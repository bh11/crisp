############################################################################
##
##  timing_injectors.g              CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("crisp");
ReadPkg ("crisp", "tst/timing_test.g");
ReadPkg ("crisp", "tst/timing_samples.g");


nilp := FittingClass (rec (\in := IsNilpotent));
metanilp := FittingProduct (nilp, nilp);
MetaNilpotentGroups := FittingProduct (NilpotentGroups, NilpotentGroups);


tests :=
[ [tmp -> Injector (tmp, metanilp), Size,  "hom, in", []],
  [tmp -> Injector (tmp, MetaNilpotentGroups),  Size, "hom, rad", []],
];

Print ("metanilpotent injector\n");
DoTests (groups, tests);

tests :=
[ [tmp -> Injector (tmp, nilp), Size,  "hom, in", []],
  [tmp -> Injector (tmp, NilpotentGroups),  Size, "hom, rad", []],
];

Print ("nilpotent injector\n");
DoTests (groups, tests);

23groups := PiGroups ([2,3]);
FermatPrimes := Class (p -> IsPrime (p) and p = 2^LogInt (p, 2) + 1);
class := PiGroups (FermatPrimes);

tests :=
[ [tmp -> Injector (tmp, FittingClass (rec(\in :=MemberFunction (class)))), Size,  "hom, in", []],
  [tmp -> Injector (tmp, class),  Size, "hall", []],
];

Print (class,"-injector\n");
DoTests (groups, tests);


############################################################################
##
#E
##
