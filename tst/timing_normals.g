############################################################################
##
##  timing_normals.g                CRISP                 Burkhard H\"ofling
##
##  @(#)$ $
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
if not IsBound (LOADED_PACKAGES.crisp) then
   NormalSubgroupsSolvableOld := ApplicableMethod (NormalSubgroups, [DihedralGroup (8)]);
fi;
RequirePackage ("crisp");

groups := [
 ["format","grp/g93.gi", "g93", "31:3"],
 ["format","grp/OOF.gi", "OOF"],
 ["format","grp/ONF.gi", "ONF"],
 ["format","grp/FI22.gi", "G", "FI22"],
# ["crisp", "grp/FI22mod.gp", "FI22mod", "FI22mod"],
 ["format","grp/LUX2_12.gi", "LUX2_12"],
# ["crisp", "grp/DARKmod6.gp", "DARKmod6", "DARK/6"],
 ["format","grp/UPP.gi", "G", "UPP"],
 ["format","grp/DARK.gi","G", "DARK"],
# ["format","grp/DARKplus4.gp", "DARKplus"],
# ["format","grp/LUXwreath4.gp", "LUX2_12wrs3", "LUXwrS3"],
 ["format","grp/LUX.gi", "G", "LUXwrS3"],
# ["crisp", "grp/DARKwrS3.gp", "DARKwrS3"],
];

if IsBound (FAST_TEST) and FAST_TEST then
   groups := groups{[1..3]};
fi;

if not IsBound (PRINT) then
   PRINT := Print;
   MakeReadOnlyGlobal ("PRINT");
fi;

SilentRead := function (pkg, fname)

   MakeReadWriteGlobal ("Print");
   Print := Ignore;
   ReadPkg (pkg, fname);
   Print := PRINT;
   MakeReadOnlyGlobal ("Print");
end;

SpecialPcGroup := G -> Image (IsomorphismSpecialPcGroup (G));

mtxinfo := [];

MTXTime := function ()
   return Sum (mtxinfo, x -> x[2]);
end;


MTXReset := function (tmp)
   mtxinfo := [];
end;

tSpcgs := 0;

SpcgsCompute  := function (tmp)
   local t0;
   GASMAN ("collect");
   t0 := Runtime();
   IsomorphismSpecialPcGroup (tmp);
   tSpcgs := Runtime() - t0;
end;

SpcgsTime := function ()
   return tSpcgs;
end;

results := [];

DoTests := function (groups, tests)

   local g, name, tmp, t, t0, t1, res, prevres, ccl, size;
   
   Print (String ("group",-10));
   Print (String ("logsize", 8));
   Print (String ("complen", 8));
   for t in tests do
      Print (String(t[3],8),"\c");
      if IsBound (t[6]) then
         Print (String (t[7],8), "\c");
      fi;
   od;
   Print ("\n");
   for g in groups do
      if IsBoundGlobal (g[3]) then
         UnbindGlobal (g[3]);
      fi;
      if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
         UnbindGlobal(Concatenation ("MAKE_",g[3]));
      fi;
      SilentRead (g[1],g[2]);
      if IsBound (g[4]) then
         name := g[4];
      else
         name := g[3];
      fi;
      Print (String (name,-10));
      tmp := ValueGlobal (g[3]);
      size := Size (tmp);
      Print (String (LogInt (Size (tmp), 10), 8));
      Print (String (Length (Pcgs(tmp)), 8), "\c");
      UnbindGlobal (g[3]);
      if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
         UnbindGlobal(Concatenation ("MAKE_",g[3]));
      fi;
      prevres := fail;
      ccl := fail;
      results := [];
      
      for t in tests do
         if name in t[4] then
            t1 := 999999;
         else
            SilentRead (g[1],g[2]);
            tmp := ValueGlobal (g[3]);
            if IsBound (t[5]) then
               t[5](tmp);
            fi;
            if DO_TIMING then
               GASMAN ("collect");
            fi;
            t0 := Runtime();
            res := t[1](tmp);
            Add (results, res);
            t1 := Runtime() - t0;
            res := t[2](res);
            if prevres <> fail then
               if res <> fail and res <> prevres then
                  Error ("results do not match");
               fi;
            else
               prevres := res;
            fi;
            if HasNrConjugacyClasses (tmp) then
               ccl := NrConjugacyClasses (tmp);
            fi;
            UnbindGlobal (g[3]);
            if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
               UnbindGlobal(Concatenation ("MAKE_",g[3]));
            fi;
         fi;
         
         Print (String(t1,8), "\c");
         if IsBound (t[6]) then
            Print (String(t[6](),8), "\c");
         fi;
      od;
      if prevres <> fail then
         Print ("  ",prevres);
         if ccl <> fail then
            Print ("  ", ccl);
         fi;
      fi;
      Print ("\n");
   od;
end;


Sizes := l -> Collected (List (l, Size));


tests :=
[ 
  [tmp ->  NormalSubgroups (tmp), Sizes, "new", ["UPP",]],
  [tmp -> NormalSubgroupsAbove( tmp, TrivialSubgroup( tmp ), []),  Sizes, "class", ["DARK/6", "DARK", "UPP", "LUXwrS3"]],
];

if IsBound (NormalSubgroupsSolvableOld) then
   tests[3] := tests[2];
     tests[2] := [tmp ->  NormalSubgroupsSolvableOld (tmp), Sizes, "old", ["UPP",]];
fi;

Print ("normal subgroups\n");
DoTests (groups, tests);


############################################################################
##
#E
##
