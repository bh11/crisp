############################################################################
##
##  timing_radicals.g               CRISP                 Burkhard H\"ofling
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
fit := function (G)
   local pcgs, p, newpcgs, pcser, depths, x;
   
   pcgs := FamilyPcgs (G);
   pcser := [];
   depths := [];
   for p in Set (Factors (Size (G))) do
      newpcgs := Pcgs (OneNormalSubgroupMaxWrtNProperty (G, 
           function (U, V, R, data) 
              return Index (U, V) mod data = 0;
           end, 
           ReturnFail, 
           p));
        for x in newpcgs do
           AddPcElementToPcSequence (pcgs, pcser, depths, x);
        od;
    od;
    return GroupOfPcgs (InducedPcgsByPcSequenceNC (
       pcgs, pcser));
end;

tests :=
[ [tmp -> Radical (tmp, nilp), Size, "rad", []],
  [tmp -> Radical (tmp, NilpotentGroups),  Size, "fit", []],
  [fit, Size, "newfit", []],
];

Print ("nilpotent radical\n");
DoTests (groups, tests);

metanilp := FittingProduct (nilp, nilp);
MetanilpotentGroups := FittingProduct (NilpotentGroups, NilpotentGroups);

tests :=
[ [tmp -> Radical (tmp, metanilp), Size, "rad", []],
  [tmp -> Radical (tmp, MetanilpotentGroups),  Size, "fit2", []],
];
Print ("metanilpotent radical\n");
DoTests (groups, tests);


23groups := PiGroups ([2,3]);
23groups2 := FittingClass (rec(\in := MemberFunction (23groups),
  char := [2,3]));
  
tests := 
[ [tmp -> Radical (tmp, 23groups2), Size, "in", []],
  [tmp -> Radical (tmp, 23groups),  Size, "core", []],
];

Print ("[2,3]-radical\n");
DoTests (groups, tests);

2groups := PGroups (2);
2groups2 := FittingClass (rec(\in := MemberFunction (2groups),
  char := [2]));
  
tests := 
[ [tmp -> Radical (tmp, 2groups2), Size, "in", []],
  [tmp -> Radical (tmp, 2groups),  Size, "core", []],
  [tmp -> OneNormalSubgroupMaxWrtNProperty (tmp, 
     function (U, V, R, data) 
        return Index (U, V) mod 2 = 0;
     end, 
     ReturnFail, 
     rec ()), Size, "Nprop", []],
];
Print ("2-radical\n");
DoTests (groups, tests);

5groups := PGroups (5);
5groups5 := FittingClass (rec(\in := MemberFunction (5groups),
  char := [5]));
  
tests := 
[ [tmp -> Radical (tmp, 5groups5), Size, "in", []],
  [tmp -> Radical (tmp, 5groups),  Size, "core", []],
  [tmp -> OneNormalSubgroupMaxWrtNProperty (tmp, 
     function (U, V, R, data) 
        return Index (U, V) mod 5 = 0;
     end, 
     ReturnFail, 
     rec ()), Size, "Nprop", []],
];
Print ("5-radical\n");
DoTests (groups, tests);

nilp23 := Intersection (NilpotentGroups, PiGroups ([2,3]));
   
nilp23_3 := FittingClass (rec (
   \in := G -> IsNilpotent (G) and MemberFunction (23groups)(G),
   char := [2,3]));
   
tests :=
[ [tmp -> Radical (tmp, nilp23_3), Size, "in", []],
  [tmp -> Radical (tmp, nilp23),  Size, "res", []],
];


Print ("nilp.[2,3]-residual\n");
DoTests (groups, tests);


############################################################################
##
#E
##
