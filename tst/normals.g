############################################################################
##
##  normals.g                       CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("crisp");
ReadPkg ("crisp", "tst/samples.g");

if PRINT_METHODS then
   TraceMethods (NormalSubgroups);
   TraceMethods (CharacteristicSubgroups);
   TraceMethods (AllInvariantSubgroupsWithQPropertyUnderAction);
   TraceMethods (AllInvariantSubgroupsWithNPropertyUnderAction);
fi;

for G in groups do
	old := SortedList (List (NormalSubgroups (G()), Order));
	H := G();
	new := SortedList (List (AllInvariantSubgroupsWithNPropertyUnderAction (H, H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;

	old := SortedList (List (CharacteristicSubgroups (G()), Order));
	H := G();
	new := SortedList (List (AllInvariantSubgroupsWithNPropertyUnderAction (
		AutomorphismGroup (H), H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;
od;

if PRINT_METHODS then
   UntraceMethods (NormalSubgroups);
   UntraceMethods (CharacteristicSubgroups);
   UntraceMethods (AllInvariantSubgroupsWithQPropertyUnderAction);
   UntraceMethods (AllInvariantSubgroupsWithNPropertyUnderAction);
fi;


############################################################################
##
#E
##
