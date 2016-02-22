############################################################################
##
##  timing_socle.g                  CRISP                   Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##

LoadPackage("crisp", "", false);
CRISP_Read("tst/timing_test.g");
CRISP_Read("tst/timing_samples.g");

SolvableSocleFromPCores := function(G)

    local S, pi, nilp, i, j, P, O, ser, act, N;

    if IsTrivial(G) then
        return G;
    fi;
    S := TrivialSubgroup(G);
    pi := PrimeDivisors(Size(G));
    P := [];
    nilp := true;
    for i in [1..Length(pi)] do
        P[i] := PCore(G, pi[i]);
        nilp := nilp and Index(G, P[i]) mod pi[i] <> 0;
    od;
    if not nilp then
        act := List(SmallGeneratingSet(G), g -> InnerAutomorphismNC(G,g));
    fi;
    for i in [1..Length(pi)] do
        if not IsTrivial(P[i]) then
            O := Omega(Center(P[i]), pi[i], 1);
            if nilp then
                S := ClosureGroup(S, O);
            else
                ser := CompositionSeriesUnderAction(act, O);
                for j in [1..Length(ser)-2] do
                    N := ComplementsOfCentralSectionUnderActionNC(act, ser[j], ser[j+1], TrivialSubgroup(G), false);
                    if N <> fail then
                        S := ClosureGroup(S, N);
                    fi;
                od;
                S := ClosureGroup(S, ser[Length(ser)-1]);
            fi;
        fi;
    od;
    return S;
end;


SolvableSocleFromPCores2 := function(G)

    local S, pi, nilp, i, j, P, O, ser, act, N;

    if IsTrivial(G) then
        return G;
    fi;
    S := TrivialSubgroup(G);
    pi := PrimeDivisors(Size(G));
    P := [];
    nilp := true;
    for i in [1..Length(pi)] do
        P[i] := PCore(G, pi[i]);
        nilp := nilp and Index(G, P[i]) mod pi[i] <> 0;
    od;
    if not nilp then
        act := List(SmallGeneratingSet(G), g -> InnerAutomorphismNC(G,g));
    fi;
    for i in [1..Length(pi)] do
        if not IsTrivial(P[i]) then
            O := Omega(Center(P[i]), pi[i], 1);
            if nilp then
                S := ClosureGroup(S, O);
            else
                ser := CompositionSeriesUnderAction(act, O);
                for j in [1..Length(ser)-2] do
                    N := ComplementsOfCentralSectionUnderActionNC(act, ser[j], ser[j+1], TrivialSubgroup(G), false);
                    if N <> fail then
                        S := ClosureGroup(S, N);
                    fi;
                od;
                S := ClosureGroup(S, ser[Length(ser)-1]);
            fi;
        fi;
    od;
    return S;
end;


PSocleFromPCores := function(G, p)

    local P, O, S, ser, j, N, act;

    if IsTrivial(G) then
        return G;
    fi;

    if Size(G) mod p <> 0 then
        return TrivialSubgroup(G);
    fi;

    P := PCore(G,p);

    if IsTrivial(P) then
        return P;
    fi;

    O := Omega(Center(P),p,1);

    act := List(SmallGeneratingSet(G), g -> InnerAutomorphismNC(G,g));

    ser := CompositionSeriesUnderAction(act, O);
    S := ser[Length(ser)-1];
    for j in [1..Length(ser)-2] do
        N := ComplementsOfCentralSectionUnderActionNC(act, ser[j], ser[j+1], TrivialSubgroup(G), false);
        if N <> fail then
            S := ClosureGroup(S, N);
        fi;
    od;
    return S;
end;


PSocleFromPCores2 := function(G, p)

    local P, S, ser, j, N, act;

    if Size(G) mod p <> 0 then
        return TrivialSubgroup(G);
    fi;

    if IsPNilpotent(G, p) then
        P := SylowSubgroup(Centre(G), p);
        if IsTrivial(P) then
            return P;
        else
            return Omega(P, p, 1);
        fi;
    fi;

    P := PCore(G,p);

    if IsTrivial(P) then
        return P;
    fi;

    O := Omega(Center(P),p,1);

    ser := CompositionSeriesUnderAction(G, O);
    S := ser[Length(ser)-1];
    for j in [1..Length(ser)-2] do
        N := ComplementsOfCentralSectionUnderActionNC(G, ser[j], ser[j+1], TrivialSubgroup(G), false);
        if N <> fail then
            S := ClosureGroup(S, N);
        fi;
    od;
    return S;
end;



SolvableSocleNilpotent := function(G)

    local S, p, P;

    if IsTrivial(G) then
        return G;
    elif not IsNilpotentGroup(G) then
        return fail;
    fi;
    S := TrivialSubgroup(G);
    for p in PrimeDivisors(Size(G)) do
        P := SylowSubgroup(G, p);
        S := ClosureGroup(S, Omega(Center(P), p, 1));
    od;
    return S;
end;

SolvableSocleNilpotent2 := function(G)

    local S, p, F;

    if IsTrivial(G) then
        return G;
    elif not IsNilpotentGroup(G) then
        return fail;
    fi;
    S := TrivialSubgroup(G);
    for p in PrimeDivisors(Size(G)) do
        S := ClosureGroup(S, Omega(SylowSubgroup(Center(G), p), p, 1));
    od;
    return S;
end;

Append(groups,[
    [DirectProduct, ListWithIdenticalEntries(4, SmallGroup(432, 25)), "G", "(432-25)^4"],
    [DirectProduct, ListWithIdenticalEntries(5, AbelianGroup([49,2])), "G", "(C49xC2)^5"],
    [DirectProduct, ListWithIdenticalEntries(3, SmallGroup(256, 537)), "G", "(256-537)^3"],
    [DirectProduct, ListWithIdenticalEntries(3, SmallGroup(256, 541)), "G", "(256-541)^3"],
    [DirectProduct, ListWithIdenticalEntries(4, SmallGroup(256, 540)), "G", "(256-541)^4"],
    [DirectProduct, ListWithIdenticalEntries(6, SymmetricGroup(4)), "G", "S4^6"],
    [DirectProduct, ListWithIdenticalEntries(5, DihedralGroup(8)), "G", "D8^5"],
]);

tests :=
[ 
  [Socle, Size, "CRISP", []],
#  [function(G) FittingSubgroup(G); return Socle(G); end, Size, "known Fit", []],
#  [function(G) Center(FittingSubgroup(G)); return Socle(G); end, Size, "ΩZFit", []],
  [SolvableSocleFromPCores, Size, "ΩZOp", []],
  [SolvableSocleFromPCores2, Size, "ΩZOp2", []],
  [G -> List(PrimeDivisors(Size(G)), p -> PSocle(G, p)), l -> Product(l, Size), "psoc", []],
  [G -> List(PrimeDivisors(Size(G)), p -> PSocleFromPCores(G, p)), l -> Product(l, Size), "ΩZOp", []],
  [G -> List(PrimeDivisors(Size(G)), p -> PSocleFromPCores2(G, p)), l -> Product(l, Size), "ΩZOp2", []],
#   [G -> List(PrimeDivisors(Size(G)), p -> PCore(G, p)), ReturnFail, "PCores", []],
#  [G -> List(PrimeDivisors(Size(G)), p -> Center(PCore(G, p))), ReturnFail, "Z-PCores", [], G -> List(PrimeDivisors(Size(G)), p -> PCore(G, p))],
#  [FittingSubgroup, ReturnFail, "Fit", []],
#  [G -> Center(FittingSubgroup(G)), ReturnFail, "Z-Fit", [], FittingSubgroup],
#  [G -> List(PrimeDivisors(Size(G)), p -> SylowSubgroup(Center(FittingSubgroup(G)),p)), ReturnFail, "Syl-ZFit", [], G -> Center(FittingSubgroup(G))],
#  [G -> List(PrimeDivisors(Size(FittingSubgroup(G))), p -> Omega(SylowSubgroup(Center(FittingSubgroup(G)),p),p,1)),
#        ReturnFail, "Ω-SylZFit", [], G -> List(PrimeDivisors(Size(G)), p -> SylowSubgroup(Center(FittingSubgroup(G)),p))],
#  [LowerCentralSeries, ReturnFail, "HC", []],
#  [G -> List(PrimeDivisors(Size(G)), p -> IsPNilpotent(G, p)), ReturnFail, "pNilp", []],
#  [SolvableSocleNilpotent2, Size, "nilΩSylZ", []],
#  [SolvableSocleNilpotent, Size, "nilΩZSyl", []],
#  [G -> List(PrimeDivisors(Size(G)), p -> PSocle(G, p)),
#  	l -> Product(l, Size), "psoc", []],
#  [G -> List(PrimeDivisors(Size(G)), p -> PSocle(G, p)),
#  	l -> Product(l, Size), "psoc", [], Socle],
];

Print("Socle\n");
DoTests(groups, tests);


for p in [2,3,5,7,31] do
    tests := [
        [Socle, ReturnFail, "Soc", []],
        [SolvableSocleFromPCores, ReturnFail, "ΩZOp", []],
        [SolvableSocleFromPCores2, ReturnFail, "ΩZOp2", []],
        [G -> PSocle(G,p), Size, Concatenation(String(p), "-soc"), []],
        [G -> PSocleFromPCores(G,p), Size, Concatenation("ΩZO-", String(p)), []],
        [G -> PSocleFromPCores2(G,p), Size, Concatenation("ΩZO-", String(p), "-2"), []],
        [G -> IsPNilpotent(G,p), ReturnFail, Concatenation(String(p),"-nilp"), []],
    ];
    Print(p, "-Socle\n");
    DoTests(groups, tests);
od;


############################################################################
##
#E
##
