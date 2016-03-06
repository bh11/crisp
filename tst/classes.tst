gap> START_TEST("classes");
gap> LoadPackage("crisp", "", false);
true
gap> 
gap> 25grps := PiGroups([2,5]);
<class of all [ 2, 5 ]-groups>
gap> nilab := Intersection(NilpotentGroups, AbelianGroups);
Intersection([ <class of all nilpotent groups>, <class of all abelian groups> 
 ])
gap> if not KnownTruePropertiesOfObject(nilab)
>     = KnownTruePropertiesOfObject(AbelianGroups) then 
>         Error("properties not preserved by intersection");
> fi;
gap> niluab := Union(NilpotentGroups, AbelianGroups);
Union([ <class of all nilpotent groups>, <class of all abelian groups> ])
gap> nilu25 := Union(NilpotentGroups, 25grps);
Union([ <class of all nilpotent groups>, <class of all [ 2, 5 ]-groups> ])
gap> nil25 := Intersection(NilpotentGroups, 25grps);
Intersection([ <class of all nilpotent groups>, 
  <class of all [ 2, 5 ]-groups> ])
gap> nilpbynilp := FormationProduct(NilpotentGroups, NilpotentGroups);
FittingFormationProduct(<class of all nilpotent groups>, <class of all nilpote\
nt groups>)
gap> if not KnownTruePropertiesOfObject(nilpbynilp) 
>     = KnownTruePropertiesOfObject(NilpotentGroups)then 
>         Error("properties not preserved by intersection");
> fi;
gap> abbyab := FormationProduct(AbelianGroups, AbelianGroups);
FormationProduct(<class of all abelian groups>, <class of all abelian groups>)
gap> SetIsSubgroupClosed(abbyab, true);
gap> if not KnownTruePropertiesOfObject(abbyab) 
>     = KnownTruePropertiesOfObject(AbelianGroups) then 
>         Error("properties not preserved by intersection");
> fi;
gap> 
gap> FermatPrimes := Class(p -> IsPrime(p) and p = 2^LogInt(p, 2) + 1);
Class(in:=function( p ) ... end)
gap> if HasIsEmpty (FermatPrimes) then
>     Error("HasIsEmpty set");
> fi;
gap> 3 in FermatPrimes;
true
gap> if IsEmpty(FermatPrimes) then
>     Error("IsEmpty should be false");
> fi;
gap> 
gap> C := GroupClass(G -> 6 mod Size(G) = 0);
GroupClass(in:=function( G ) ... end)
gap> SetIsSubgroupClosed(C, true);
gap> if HasContainsTrivialGroup(C) then
>     Error("HasContainsTrivialGroup set");
> fi;
gap> CyclicGroup(2) in C;
true
gap> if not ContainsTrivialGroup(C) then
>     Error("ContainsTrivialGroup should be true");
> fi;
gap> STOP_TEST("classes", 1140000);
classes
GAP4stones: 0
gap> 
gap> 
gap> ############################################################################
gap> ##
gap> #E
gap> ##
gap> 
