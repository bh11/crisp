############################################################################
##
##  timing_socle.g                  CRISP                   Burkhard Höfling
##
##  Copyright (C) 2000 Burkhard Höfling
##

LoadPackage ("crisp");
ReadPackage ("crisp", "tst/timing_test.g");
ReadPackage ("crisp", "tst/timing_samples.g");



tests :=
[ 
    [Socle, Size, "new", []],
    [Socle, Size, "Fit", [], FittingSubgroup],
    [G -> List (Set (FactorsInt (Size (G))), p -> PSocle (G, p)), 
        l -> Product (l, Size), "psoc", []],
    [G -> List (Set (FactorsInt (Size (G))), p -> PSocle (G, p)), 
        l -> Product (l, Size), "psoc", [], Socle],
];


Print ("Socle\n");
DoTests (groups, tests);


############################################################################
##
#E
##
