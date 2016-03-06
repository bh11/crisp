gap> START_TEST("normals");
gap> LoadPackage("crisp", "", false);
true
gap> CRISP_Read("tst/samples.g");
gap> 
gap> if PRINT_METHODS then
>    TraceMethods(NormalSubgroups);
>    TraceMethods(CharacteristicSubgroups);
>    TraceMethods(AllNormalSubgroupsWithNProperty);
>    TraceMethods(AllNormalSubgroupsWithQProperty);
>    TraceMethods(AllInvariantSubgroupsWithNProperty);
>    TraceMethods(AllInvariantSubgroupsWithQProperty);
>    TraceMethods(OneNormalSubgroupMaxWrtNProperty);
>    TraceMethods(OneNormalSubgroupMinWrtQProperty);
>    TraceMethods(OneInvariantSubgroupMaxWrtNProperty);
>    TraceMethods(OneInvariantSubgroupMinWrtQProperty);
> fi;
gap> 
gap> for G in groups do
> 	old := SortedList(List(NormalSubgroups(G()), Order));
> 	
> 	H := G();
> 	new := SortedList(List(AllInvariantSubgroupsWithNProperty(H, H, 
> 		ReturnTrue, ReturnTrue, rec()), Size));
> 	if old <> new then
> 		Error("AllInvariantSubgroupsWithNProperty: orders of normal subgroups don't agree");
> 	fi;
> 
> 	H := G();
> 	new := SortedList(List(AllNormalSubgroupsWithNProperty(H, 
> 		ReturnTrue, ReturnTrue, rec()), Size));
> 	if old <> new then
> 		Error("AllNormalSubgroupsWithNProperty: orders of normal subgroups don't agree");
> 	fi;
> 	
> 	H := G();
> 	new := SortedList(List(AllInvariantSubgroupsWithQProperty(H, H, 
> 		ReturnTrue, ReturnTrue, rec()), Size));
> 	if old <> new then
> 		Error("AllInvariantSubgroupsWithQProperty: orders of normal subgroups don't agree");
> 	fi;
> 	
> 	H := G();
> 	new := SortedList(List(AllNormalSubgroupsWithQProperty(H,
> 		ReturnTrue, ReturnTrue, rec()), Size));
> 	if old <> new then
> 		Error("AllNormalSubgroupsWithQProperty: orders of normal subgroups don't agree");
> 	fi;
> 	
> 	old := SortedList(List(CharacteristicSubgroups(G()), Order));
> 	
> 	H := G();
> 	new := SortedList(List(AllInvariantSubgroupsWithNProperty(
> 		GeneratorsOfGroup(AutomorphismGroup(H)), H, 
> 		ReturnTrue, ReturnTrue, rec()), Size));
> 	if old <> new then
> 		Error("AllInvariantSubgroupsWithNProperty: orders of characteristic subgroups don't agree");
> 	fi;
> 
> 	H := G();
> 	new := SortedList(List(AllInvariantSubgroupsWithQProperty(
> 		GeneratorsOfGroup(AutomorphismGroup(H)), H, 
> 		ReturnTrue, ReturnTrue, rec()), Size));
> 	if old <> new then
> 		Error("AllInvariantSubgroupsWithQProperty: orders of characteristic subgroups don't agree");
> 	fi;
> 	
> 	H := G();
> 	old := DerivedSubgroup(H);
> 	new := OneInvariantSubgroupMinWrtQProperty(
> 		GeneratorsOfGroup(AutomorphismGroup(H)), H, 
> 		ReturnFail, 
>         function(S, R, data)
>             return IsAbelian(data/S);
>         end, 
>         H);
> 	if old <> new then
> 		Error("OneInvariantSubgroupMinWrtQProperty: derived subgroup doesn't agree");
> 	fi;
> 	
> 	H := G();
> 	old := DerivedSubgroup(H);
> 	new := OneNormalSubgroupMinWrtQProperty(H, 
> 		ReturnFail, 
>         function(S, R, data)
>             return IsAbelian(data/S);
>         end, 
>         H);
> 	if old <> new then
> 		Error("OneNormalSubgroupMinWrtQProperty: derived subgroup doesn't agree");
> 	fi;
> 	
> 	H := G();
> 	old := FittingSubgroup(H);
> 	new := OneNormalSubgroupMaxWrtNProperty(H, 
> 		ReturnFail, 
>         function(S, R, data)
>             return IsNilpotentGroup(S);
>         end, 
>         rec());
> 	if old <> new then
> 		Error("OneNormalSubgroupMaxWrtNProperty: Fitting subgroup doesn't agree");
> 	fi;
> 
> 	H := G();
> 	old := FittingSubgroup(H);
> 	new := OneInvariantSubgroupMaxWrtNProperty(GeneratorsOfGroup(AutomorphismGroup(H)), H, 
> 		ReturnFail, 
>         function(S, R, data)
>             return IsNilpotentGroup(S);
>         end, 
>         rec());
> 	if old <> new then
> 		Error("OneInvariantSubgroupMaxWrtNProperty: Fitting subgroup doesn't agree");
> 	fi;
> od;
gap> 
gap> if PRINT_METHODS then
>    UnTraceMethods(NormalSubgroups);
>    UnTraceMethods(CharacteristicSubgroups);
>    UnTraceMethods(AllInvariantSubgroupsWithNProperty);
>    UnTraceMethods(AllInvariantSubgroupsWithQProperty);
>    UnTraceMethods(AllNormalSubgroupsWithNProperty);
>    UnTraceMethods(AllNormalSubgroupsWithQProperty);
>    UnTraceMethods(OneNormalSubgroupMaxWrtNProperty);
>    UnTraceMethods(OneNormalSubgroupMinWrtQProperty);
>    UnTraceMethods(OneInvariantSubgroupMaxWrtNProperty);
>    UnTraceMethods(OneInvariantSubgroupMinWrtQProperty);
> fi;
gap> STOP_TEST("normals", 52870000);
normals
GAP4stones: 0
gap> 
gap> 
gap> ############################################################################
gap> ##
gap> #E
gap> ##
gap> 
