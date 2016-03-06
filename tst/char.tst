gap> START_TEST("characteristic");
gap> LoadPackage("crisp", "", false);
true
gap> CRISP_Read("tst/samples.g");
gap> 
gap> if PRINT_METHODS then
>     TraceMethods(Characteristic);
> fi;
gap> 
gap> old := fail;
fail
gap> cl := classes(); 
[ [2,5]-grps by boundary, [2,5]-grps by locdef, [2,5]-grps by membersip, 
  [2,5]-grps by res, [2,5]-grps by rad, [2,5]-grps by inj, [2,5]-grps by proj 
 ]
gap> for i in [1..Length(cl)] do
>     if InfoLevel(InfoTest) >= 2 then
>         View(cl[i]);
>         Print("\n");
>     fi;
>     new := Difference([2,3,5,7], Characteristic(cl[i]));
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     for j in [i+1..Length(cl)] do
>         I := Intersection(cl[i], cl[j]);
>         if InfoLevel(InfoTest) >= 3 then
>             View(I);
>             Print("\n");
>         fi;
>         new := Difference([2,3,5,7], Characteristic(I));
>         if old <> new then
>             Error("different results");
>         fi;
>     od;
> od;
[2,5]-grps by boundary
Intersection([ [2,5]-grps by boundary, [2,5]-grps by locdef ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by membersip ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by res ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by proj ])
[2,5]-grps by locdef
Intersection([ [2,5]-grps by locdef, [2,5]-grps by membersip ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by res ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by proj ])
[2,5]-grps by membersip
Intersection([ [2,5]-grps by membersip, [2,5]-grps by res ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by proj ])
[2,5]-grps by res
Intersection([ [2,5]-grps by res, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by res, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by res, [2,5]-grps by proj ])
[2,5]-grps by rad
Intersection([ [2,5]-grps by rad, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by rad, [2,5]-grps by proj ])
[2,5]-grps by inj
Intersection([ [2,5]-grps by inj, [2,5]-grps by proj ])
[2,5]-grps by proj
gap> cl := classes(); 
[ [2,5]-grps by boundary, [2,5]-grps by locdef, [2,5]-grps by membersip, 
  [2,5]-grps by res, [2,5]-grps by rad, [2,5]-grps by inj, [2,5]-grps by proj 
 ]
gap> for C in cl do
>     SetIsOrdinaryFormation(C, true);
> od;
gap> for C in cl do
>     for D in cl do
>         P := FormationProduct(C, D);
>         if InfoLevel(InfoTest) >= 3 then
>             View(C, "by", D);
>             Print("\n");
>         fi;
>         new := Difference([2,3,5,7], Characteristic(P));
>         if old <> new then
>             Error("different results");
>         fi;
>     od;
> od;
[2,5]-grps by boundary"by"[2,5]-grps by boundary
[2,5]-grps by boundary"by"[2,5]-grps by locdef
[2,5]-grps by boundary"by"[2,5]-grps by membersip
[2,5]-grps by boundary"by"[2,5]-grps by res
[2,5]-grps by boundary"by"[2,5]-grps by rad
[2,5]-grps by boundary"by"[2,5]-grps by inj
[2,5]-grps by boundary"by"[2,5]-grps by proj
[2,5]-grps by locdef"by"[2,5]-grps by boundary
[2,5]-grps by locdef"by"[2,5]-grps by locdef
[2,5]-grps by locdef"by"[2,5]-grps by membersip
[2,5]-grps by locdef"by"[2,5]-grps by res
[2,5]-grps by locdef"by"[2,5]-grps by rad
[2,5]-grps by locdef"by"[2,5]-grps by inj
[2,5]-grps by locdef"by"[2,5]-grps by proj
[2,5]-grps by membersip"by"[2,5]-grps by boundary
[2,5]-grps by membersip"by"[2,5]-grps by locdef
[2,5]-grps by membersip"by"[2,5]-grps by membersip
[2,5]-grps by membersip"by"[2,5]-grps by res
[2,5]-grps by membersip"by"[2,5]-grps by rad
[2,5]-grps by membersip"by"[2,5]-grps by inj
[2,5]-grps by membersip"by"[2,5]-grps by proj
[2,5]-grps by res"by"[2,5]-grps by boundary
[2,5]-grps by res"by"[2,5]-grps by locdef
[2,5]-grps by res"by"[2,5]-grps by membersip
[2,5]-grps by res"by"[2,5]-grps by res
[2,5]-grps by res"by"[2,5]-grps by rad
[2,5]-grps by res"by"[2,5]-grps by inj
[2,5]-grps by res"by"[2,5]-grps by proj
[2,5]-grps by rad"by"[2,5]-grps by boundary
[2,5]-grps by rad"by"[2,5]-grps by locdef
[2,5]-grps by rad"by"[2,5]-grps by membersip
[2,5]-grps by rad"by"[2,5]-grps by res
[2,5]-grps by rad"by"[2,5]-grps by rad
[2,5]-grps by rad"by"[2,5]-grps by inj
[2,5]-grps by rad"by"[2,5]-grps by proj
[2,5]-grps by inj"by"[2,5]-grps by boundary
[2,5]-grps by inj"by"[2,5]-grps by locdef
[2,5]-grps by inj"by"[2,5]-grps by membersip
[2,5]-grps by inj"by"[2,5]-grps by res
[2,5]-grps by inj"by"[2,5]-grps by rad
[2,5]-grps by inj"by"[2,5]-grps by inj
[2,5]-grps by inj"by"[2,5]-grps by proj
[2,5]-grps by proj"by"[2,5]-grps by boundary
[2,5]-grps by proj"by"[2,5]-grps by locdef
[2,5]-grps by proj"by"[2,5]-grps by membersip
[2,5]-grps by proj"by"[2,5]-grps by res
[2,5]-grps by proj"by"[2,5]-grps by rad
[2,5]-grps by proj"by"[2,5]-grps by inj
[2,5]-grps by proj"by"[2,5]-grps by proj
gap> cl := classes(); 
[ [2,5]-grps by boundary, [2,5]-grps by locdef, [2,5]-grps by membersip, 
  [2,5]-grps by res, [2,5]-grps by rad, [2,5]-grps by inj, [2,5]-grps by proj 
 ]
gap> for C in cl do
>     SetIsFittingClass(C, true);
> od;
gap> for C in cl do
>     for D in cl do
>         P := FittingProduct(C, D);
>         if InfoLevel(InfoTest) >= 3 then
>             View(C, "by", D);
>             Print("\n");
>         fi;
>         new := Difference([2,3,5,7], Characteristic(P));
>         if old <> new then
>             Error("different results");
>         fi;
>     od;
> od;
[2,5]-grps by boundary"by"[2,5]-grps by boundary
[2,5]-grps by boundary"by"[2,5]-grps by locdef
[2,5]-grps by boundary"by"[2,5]-grps by membersip
[2,5]-grps by boundary"by"[2,5]-grps by res
[2,5]-grps by boundary"by"[2,5]-grps by rad
[2,5]-grps by boundary"by"[2,5]-grps by inj
[2,5]-grps by boundary"by"[2,5]-grps by proj
[2,5]-grps by locdef"by"[2,5]-grps by boundary
[2,5]-grps by locdef"by"[2,5]-grps by locdef
[2,5]-grps by locdef"by"[2,5]-grps by membersip
[2,5]-grps by locdef"by"[2,5]-grps by res
[2,5]-grps by locdef"by"[2,5]-grps by rad
[2,5]-grps by locdef"by"[2,5]-grps by inj
[2,5]-grps by locdef"by"[2,5]-grps by proj
[2,5]-grps by membersip"by"[2,5]-grps by boundary
[2,5]-grps by membersip"by"[2,5]-grps by locdef
[2,5]-grps by membersip"by"[2,5]-grps by membersip
[2,5]-grps by membersip"by"[2,5]-grps by res
[2,5]-grps by membersip"by"[2,5]-grps by rad
[2,5]-grps by membersip"by"[2,5]-grps by inj
[2,5]-grps by membersip"by"[2,5]-grps by proj
[2,5]-grps by res"by"[2,5]-grps by boundary
[2,5]-grps by res"by"[2,5]-grps by locdef
[2,5]-grps by res"by"[2,5]-grps by membersip
[2,5]-grps by res"by"[2,5]-grps by res
[2,5]-grps by res"by"[2,5]-grps by rad
[2,5]-grps by res"by"[2,5]-grps by inj
[2,5]-grps by res"by"[2,5]-grps by proj
[2,5]-grps by rad"by"[2,5]-grps by boundary
[2,5]-grps by rad"by"[2,5]-grps by locdef
[2,5]-grps by rad"by"[2,5]-grps by membersip
[2,5]-grps by rad"by"[2,5]-grps by res
[2,5]-grps by rad"by"[2,5]-grps by rad
[2,5]-grps by rad"by"[2,5]-grps by inj
[2,5]-grps by rad"by"[2,5]-grps by proj
[2,5]-grps by inj"by"[2,5]-grps by boundary
[2,5]-grps by inj"by"[2,5]-grps by locdef
[2,5]-grps by inj"by"[2,5]-grps by membersip
[2,5]-grps by inj"by"[2,5]-grps by res
[2,5]-grps by inj"by"[2,5]-grps by rad
[2,5]-grps by inj"by"[2,5]-grps by inj
[2,5]-grps by inj"by"[2,5]-grps by proj
[2,5]-grps by proj"by"[2,5]-grps by boundary
[2,5]-grps by proj"by"[2,5]-grps by locdef
[2,5]-grps by proj"by"[2,5]-grps by membersip
[2,5]-grps by proj"by"[2,5]-grps by res
[2,5]-grps by proj"by"[2,5]-grps by rad
[2,5]-grps by proj"by"[2,5]-grps by inj
[2,5]-grps by proj"by"[2,5]-grps by proj
gap> 
gap> if PRINT_METHODS then
>     UnTraceMethods(Characteristic);
> fi;
gap> STOP_TEST("characteristic", 6300000);
characteristic
GAP4stones: 0
gap> 
gap> 
gap> ############################################################################
gap> ##
gap> #E
gap> ##
gap> 
gap> 
