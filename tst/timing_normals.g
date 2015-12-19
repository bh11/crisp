############################################################################
##
##  timing_normals.g                  CRISP                 Burkhard Höfling
##
##  Copyright (C) 2000 Burkhard Höfling
##
NormalSubgroupsSolvableOld := G -> SubgroupsSolvableGroup(G,rec(
        actions:=List(GeneratorsOfGroup(G),i->InnerAutomorphism(G,i)),
        normal:=true));

LoadPackage ("crisp");
ReadPackage ("crisp", "tst/timing_test.g");
ReadPackage ("crisp", "tst/timing_samples.g");

Sizes := l -> Collected (List (l, Size));


tests :=
[ 
    [tmp -> NormalSubgroups (tmp), Sizes, "CRISP", ["UPP"]],
    [tmp -> NormalSubgroupsCalc (tmp), Sizes, "new lib", ["UPP"]],
    [tmp -> NormalSubgroupsSolvableOld( tmp, TrivialSubgroup( tmp ), []),  Sizes, "old lib",
    [tmp -> NormalSubgroupsAbove( tmp, TrivialSubgroup( tmp ), []),  Sizes, "ccl",
        ["DARK/6", "DARK", "UPP", "LUXwrS3"]],
];

Print ("normal subgroups\n");
DoTests (groups, tests);


############################################################################
##
#E
##
