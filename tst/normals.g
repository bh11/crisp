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
   TraceMethods (AllNormalSubgroupsWithNProperty);
   TraceMethods (AllNormalSubgroupsWithQProperty);
   TraceMethods (AllInvariantSubgroupsWithNProperty);
   TraceMethods (AllInvariantSubgroupsWithQProperty);
   TraceMethods (OneNormalSubgroupMaxWrtNProperty);
   TraceMethods (OneNormalSubgroupMinWrtQProperty);
   TraceMethods (OneInvariantSubgroupMaxWrtNProperty);
   TraceMethods (OneInvariantSubgroupMinWrtQProperty);
fi;

for G in groups do
	old := SortedList (List (NormalSubgroups (G()), Order));
	
	H := G();
	new := SortedList (List (AllInvariantSubgroupsWithNProperty (H, H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;

	H := G();
	new := SortedList (List (AllNormalSubgroupsWithNProperty (H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;
	
	H := G();
	new := SortedList (List (AllInvariantSubgroupsWithQProperty (H, H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;
	
	H := G();
	new := SortedList (List (AllNormalSubgroupsWithQProperty (H,
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;
	
	old := SortedList (List (CharacteristicSubgroups (G()), Order));
	
	H := G();
	new := SortedList (List (AllInvariantSubgroupsWithNProperty (
		AutomorphismGroup (H), H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;

	H := G();
	new := SortedList (List (AllInvariantSubgroupsWithQProperty (
		AutomorphismGroup (H), H, 
		ReturnTrue, ReturnTrue, rec()), Size));
	if old <> new then
		Error ("results don't agree");
	fi;
	
	H := G();
	old := TrivialSubgroup (H);
	new := OneInvariantSubgroupMinWrtQProperty (
		AutomorphismGroup (H), H, 
		ReturnTrue, ReturnTrue, rec());
	if old <> new then
		Error ("results don't agree");
	fi;
	
	H := G();
	old := TrivialSubgroup (H);
	new := OneNormalSubgroupMinWrtQProperty (H, 
		ReturnTrue, ReturnTrue, rec());
	if old <> new then
		Error ("results don't agree");
	fi;
	
	H := G();
	old := H;
	new := OneNormalSubgroupMaxWrtNProperty (H, 
		ReturnTrue, ReturnTrue, rec());
	if old <> new then
		Error ("results don't agree");
	fi;

	H := G();
	old := H;
	new := OneInvariantSubgroupMaxWrtNProperty (AutomorphismGroup (H), H, 
		ReturnTrue, ReturnTrue, rec());
	if old <> new then
		Error ("results don't agree");
	fi;
od;

if PRINT_METHODS then
   UntraceMethods (NormalSubgroups);
   UntraceMethods (CharacteristicSubgroups);
   UntraceMethods (AllInvariantSubgroupsWithNProperty);
   UntraceMethods (AllInvariantSubgroupsWithQProperty);
   UntraceMethods (AllNormalSubgroupsWithNProperty);
   UntraceMethods (AllNormalSubgroupsWithQProperty);
   UntraceMethods (OneNormalSubgroupMaxWrtNProperty);
   UntraceMethods (OneNormalSubgroupMinWrtQProperty);
   UntraceMethods (OneInvariantSubgroupMaxWrtNProperty);
   UntraceMethods (OneInvariantSubgroupMinWrtQProperty);
fi;


############################################################################
##
#E
##
