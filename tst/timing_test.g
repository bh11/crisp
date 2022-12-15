############################################################################
##
##  timing_test.g                   CRISP                   Burkhard Höfling
##
##  Copyright © 2000, 2015 Burkhard Höfling
##


############################################################################
##
#V  PRINT
##
##  global variable storing the original value of `Print'
##
if not IsBound(PRINT) then
    PRINT := Print;
    MakeReadOnlyGlobal("PRINT");
fi;


############################################################################
##
#F  SilentRead(g1, g2, g3)
##
##  if g1 is a function, this simply assigns g1(g2) to the global variable g3.
##  Otherwise, it behaves like ReadPackage(pkg fname), but suppresses anything 
##  printed while reading the file
##
SilentRead := function(g1, g2, g3)

    if IsFunction(g1) then
        BindGlobal(g3, CallFuncList(g1, g2));
    else
        MakeReadWriteGlobal("Print");
        Print := Ignore;
        ReadPackage(g1, g2);
        Print := PRINT;
        MakeReadOnlyGlobal("Print");
    fi;
end;


############################################################################
##
#F  UTF8String(str, len)
##
UTF8String := function(str, len)

    local new, w, i;

    if not IsString(str) then
        str := String(str);
    fi;
    w := WidthUTF8String(str);
    if len > 0 and w < len then
        new := [];
        new{[len-w+1..Length(str)+len-w]} := str;
        for i in [1..len-w] do
            new[i] := ' ';
        od;
    elif len < 0 and w < -len then
        new := ShallowCopy(str);
        for i in [Length(str)+1..Length(str)-len-w] do
            new[i] := ' ';
        od;
    else
        new := ShallowCopy(str);
    fi;
    return new;
end;


############################################################################
##
#F  StringFactorsInt(n)
##
StringFactorsInt := function(n)

    local facs, str, dot, f;

    if n < 0 then
        str := "-";
        n := -n;
    else
        str := "";
    fi;

    facs := Collected(FactorsInt(n));
    dot := false;

    for f in facs do
        if dot then
            Add(str, '.');
        fi;
        Append(str, String(f[1]));
        if f[2] > 1 then
            Add(str, '^');
            Append(str, String(f[2]));
        fi;
        dot := true;
    od;
    return str;
end;

############################################################################
##
#F  DoTests(groups, tests)
##
##  performs a series of tests with a list of sample groups, comparing 
##  the results of the various tests. if the global Boolean DO_TIMING is
##  true, additionally, a table containing the running times of the 
##  various tests is printed.
##
##  groups is a list describing the sample input groups for the tests.
##  Each entry consists of a list g. 
##  Either g[1] is the name of the GAP package to which the sample group 
##  belongs, and g[2] is the file containing the sample group, or g[1] is a
##  function which returns a *new* group (not identical to any previous object) -
##  note that each call to g[1] should return a group with the same presentation.
##
##  g[3] contains the name of the global variable 
##  to which the group will be assigned after the file is read.
##  if g[4] is bound, the name of the sample group will be the string in t[4],
##  otherwise the string in g[3].
##
##  tests consists of a list of tests to be performed. Each entry t is a list.
##  t[1] must be the function to be tested. t[2] is a function to be applied
##  to the result of t[1]. The results of t[2] will be compared between tests.
##  t[3] is a string describing the test. This string should be short because
##  it will be used as a column heading if DO_TIMING is true.
##  t[4] contains a list of the names of those groups for which the test
##  should be skipped. t[5], if bound, must contain a function which will be
##  called with the test group as the argument *before* the test function
##  t[1] will be carried out. (The idea is to allow t[5] to pre-compute
##  some knowledge about the test group, while the computing time needed
##  to compute that knowledge is not taken into account when timing the call
##  to t[1].
##  if t[6] is bound, it must be a function with no arguments. If DO_TIMING
##  is true, its result will be printed after the timing for the call to t[1].
##  The column heading for that result must be in t[7].
##  The idea is to allow partial timings during the call to t[1] or a
##  call to t[5] to be displayed.
##
DoTests := function(groups, tests)

    local g, name, tmp, t, t0, t1, res, prevres, size, w, colwidth, col;

    colwidth := [-12,8,8];
    Print(String("group", colwidth[1]));
    Print(String("logsize", colwidth[2]));
    Print(String("complen", colwidth[3]));
    col := 4;
    if IsBound(DO_TIMING) and DO_TIMING then
        for t in tests do
            w := WidthUTF8String(t[3]);
            if w < 8 then
                colwidth[col] := 8;
            else
                colwidth[col] := w+1;
            fi;
            Print(UTF8String(t[3],colwidth[col]),"\c");
            col := col + 1;
            if IsBound(t[6]) then
                w := WidthUTF8String(t[7]);
                if w < 8 then
                    colwidth[col] := 8;
                else
                    colwidth[col] := w+1;
                fi;
                Print(UTF8String(t[7],colwidth[col]), "\c");
                col := col + 1;
            fi;
        od;
    fi;
    Append(colwidth, [16, 16]);
   
    Print("\n");
    for g in groups do
        if IsBoundGlobal(g[3]) then
            if IsReadOnlyGlobal(g[3]) then
                MakeReadWriteGlobal(g[3]);
            fi;
            UnbindGlobal(g[3]);
        fi;
        SilentRead(g[1],g[2],g[3]);
        if IsBound(g[4]) then
            name := g[4];
        else
            name := g[3];
        fi;
        Print(UTF8String(name,colwidth[1]));
        tmp := ValueGlobal(g[3]);
        size := Size(tmp);
        Print(String(LogInt(Size(tmp), 10), colwidth[2]));
        Print(String(Length(Pcgs(tmp)), colwidth[3]), "\c");
        if IsReadOnlyGlobal(g[3]) then
            MakeReadWriteGlobal(g[3]);
        fi;
        UnbindGlobal(g[3]);
        prevres := fail;
        col := 4;

        for t in tests do
            if name in t[4] then
                t1 := "n/a";
            else
                SilentRead(g[1],g[2], g[3]);
                tmp := ValueGlobal(g[3]);
                if IsBound(t[5]) then
                    t[5](tmp);
                fi;
                if IsBound(DO_TIMING) and DO_TIMING then
                    GASMAN("collect");
                fi;
                t0 := Runtime();
                if IsBound(TIMEOUT) and IsBound(CallWithTimeout) then
                    res := CallWithTimeout(TIMEOUT, t[1], tmp);
                    if IsList(res) then
                        res := res[1];
                    fi;
                else
                    res := t[1](tmp);
                fi;
                t1 := Runtime() - t0;
                if res = fail then
                    t1 := "n/a";
                else
                    res := t[2](res);
                fi;
                if prevres <> fail then
                    if res <> fail and res <> prevres then
                        Error("results do not match");
                    fi;
                else
                    prevres := res;
                fi;
                if IsReadOnlyGlobal(g[3]) then
                    MakeReadWriteGlobal(g[3]);
                fi;
                UnbindGlobal(g[3]);
            fi;
         
            if IsBound(DO_TIMING) and DO_TIMING then
                Print(String(t1,colwidth[col]), "\c");
                col := col + 1;
                if IsBound(t[6]) then
                    Print(String(t[6](),colwidth[col]), "\c");
                    col := col + 1;
                fi;
            fi;
        od;
        Print("  ");
        if IsInt(prevres) then # assume that it is the order of a subgroup
            Print(String(StringFactorsInt(prevres),colwidth[col]));
            col := col + 1;
            Print("  ");
            Print(String(StringFactorsInt(size/prevres),colwidth[col]));
            col := col + 1;
        elif IsList(prevres) then # assume that it is a list of subgroups
            Print(Length(prevres));
        else
            Print(prevres);
        fi;
        Print("\n");
    od;
end;


############################################################################
##
#F  SpecialPcGroup(grp)
##
##  return a pc group isomorphic with grp whose family pcgs is a special 
##  pcgs
##
SpecialPcGroup := G -> Image(IsomorphismSpecialPcGroup(G));

############################################################################
##
#V  tSpcgs
##
##  store time needed to compute a special pcgs
##
tSpcgs := 0;


############################################################################
##
#F  SpcgsCompute(grp)
##
##  compute a special pcgs and store the time needed in the global variable
##  tSpcgs
##
SpcgsCompute  := function(tmp)
	local t0;
	if IsBound(DO_TIMING) and DO_TIMING then
		GASMAN("collect");
	fi;
	t0 := Runtime();
	IsomorphismSpecialPcGroup(tmp);
	tSpcgs := Runtime() - t0;
end;

############################################################################
##
#F  SpcgsTime()
##
##  return time needed to compute special pcgs
##
SpcgsTime := function()
	return tSpcgs;
end;


############################################################################
##
#V  mtxinfo
##
##  variable used by the Smash meataxe  to record internal running times
##
mtxinfo := [];


############################################################################
##
#F  MTXTime(grp)
##
##  compute time needed by meataxe
##
MTXTime := function()
   return Sum(mtxinfo, x -> x[2]);
end;


############################################################################
##
#F  MTXTime(grp)
##
##  reset time measurement by meataxe
##
MTXReset := function(tmp)
   mtxinfo := [];
end;


############################################################################
##
#E
##
