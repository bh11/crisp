############################################################################
##
##  timing_socle.g                 CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##

RequirePackage ("crisp");
ReadPkg ("crisp", "tst/timing_test.g");
ReadPkg ("crisp", "tst/timing_samples.g");



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
