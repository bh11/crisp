gap> START_TEST("print");
gap> LoadPackage("crisp", "", false);
true
gap> CRISP_Read("tst/samples.g");
gap> 
gap> if PRINT_METHODS then
>     TraceMethods(PrintObj, ViewObj);
> fi;
gap> 
gap> old := fail;
fail
gap> cl := classes(); 
[ [2,5]-grps by boundary, [2,5]-grps by locdef, [2,5]-grps by membersip, 
  [2,5]-grps by res, [2,5]-grps by rad, [2,5]-grps by inj, [2,5]-grps by proj 
 ]
gap> for i in [1..Length(cl)] do
>     View(cl[i]);
>     Print("\n",cl[i], "\n");
>     for j in [i+1..Length(cl)] do
>         I := Intersection(cl[i], cl[j]);
>         View(I);
>         Print("\n", I, "\n");
>     od;
> od;
[2,5]-grps by boundary
[2,5]-grps by boundary
Intersection([ [2,5]-grps by boundary, [2,5]-grps by locdef ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by locdef ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by membersip ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by membersip ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by res ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by res ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by proj ])
Intersection([ [2,5]-grps by boundary, [2,5]-grps by proj ])
[2,5]-grps by locdef
[2,5]-grps by locdef
Intersection([ [2,5]-grps by locdef, [2,5]-grps by membersip ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by membersip ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by res ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by res ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by proj ])
Intersection([ [2,5]-grps by locdef, [2,5]-grps by proj ])
[2,5]-grps by membersip
[2,5]-grps by membersip
Intersection([ [2,5]-grps by membersip, [2,5]-grps by res ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by res ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by proj ])
Intersection([ [2,5]-grps by membersip, [2,5]-grps by proj ])
[2,5]-grps by res
[2,5]-grps by res
Intersection([ [2,5]-grps by res, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by res, [2,5]-grps by rad ])
Intersection([ [2,5]-grps by res, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by res, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by res, [2,5]-grps by proj ])
Intersection([ [2,5]-grps by res, [2,5]-grps by proj ])
[2,5]-grps by rad
[2,5]-grps by rad
Intersection([ [2,5]-grps by rad, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by rad, [2,5]-grps by inj ])
Intersection([ [2,5]-grps by rad, [2,5]-grps by proj ])
Intersection([ [2,5]-grps by rad, [2,5]-grps by proj ])
[2,5]-grps by inj
[2,5]-grps by inj
Intersection([ [2,5]-grps by inj, [2,5]-grps by proj ])
Intersection([ [2,5]-grps by inj, [2,5]-grps by proj ])
[2,5]-grps by proj
[2,5]-grps by proj
gap> for C in cl do
>     SetIsOrdinaryFormation(C, true);
> od;
gap> for C in cl do
>     for D in cl do
>         P := FormationProduct(C, D);
>         View(P);
>         Print("\n", P, "\n");
>     od;
> od;
FormationProduct([2,5]-grps by boundary, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by res)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by res)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by rad)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by rad)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by inj)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by inj)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by proj)
FormationProduct([2,5]-grps by boundary, [2,5]-grps by proj)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by res)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by res)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by rad)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by rad)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by inj)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by inj)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by proj)
FormationProduct([2,5]-grps by locdef, [2,5]-grps by proj)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by res)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by res)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by rad)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by rad)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by inj)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by inj)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by proj)
FormationProduct([2,5]-grps by membersip, [2,5]-grps by proj)
FormationProduct([2,5]-grps by res, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by res, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by res, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by res, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by res, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by res, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by res, [2,5]-grps by res)
FormationProduct([2,5]-grps by res, [2,5]-grps by res)
FormationProduct([2,5]-grps by res, [2,5]-grps by rad)
FormationProduct([2,5]-grps by res, [2,5]-grps by rad)
FormationProduct([2,5]-grps by res, [2,5]-grps by inj)
FormationProduct([2,5]-grps by res, [2,5]-grps by inj)
FormationProduct([2,5]-grps by res, [2,5]-grps by proj)
FormationProduct([2,5]-grps by res, [2,5]-grps by proj)
FormationProduct([2,5]-grps by rad, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by rad, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by rad, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by rad, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by rad, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by rad, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by rad, [2,5]-grps by res)
FormationProduct([2,5]-grps by rad, [2,5]-grps by res)
FittingFormationProduct([2,5]-grps by rad, [2,5]-grps by rad)
FittingFormationProduct([2,5]-grps by rad, [2,5]-grps by rad)
FittingFormationProduct([2,5]-grps by rad, [2,5]-grps by inj)
FittingFormationProduct([2,5]-grps by rad, [2,5]-grps by inj)
FormationProduct([2,5]-grps by rad, [2,5]-grps by proj)
FormationProduct([2,5]-grps by rad, [2,5]-grps by proj)
FormationProduct([2,5]-grps by inj, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by inj, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by inj, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by inj, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by inj, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by inj, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by inj, [2,5]-grps by res)
FormationProduct([2,5]-grps by inj, [2,5]-grps by res)
FittingFormationProduct([2,5]-grps by inj, [2,5]-grps by rad)
FittingFormationProduct([2,5]-grps by inj, [2,5]-grps by rad)
FittingFormationProduct([2,5]-grps by inj, [2,5]-grps by inj)
FittingFormationProduct([2,5]-grps by inj, [2,5]-grps by inj)
FormationProduct([2,5]-grps by inj, [2,5]-grps by proj)
FormationProduct([2,5]-grps by inj, [2,5]-grps by proj)
FormationProduct([2,5]-grps by proj, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by proj, [2,5]-grps by boundary)
FormationProduct([2,5]-grps by proj, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by proj, [2,5]-grps by locdef)
FormationProduct([2,5]-grps by proj, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by proj, [2,5]-grps by membersip)
FormationProduct([2,5]-grps by proj, [2,5]-grps by res)
FormationProduct([2,5]-grps by proj, [2,5]-grps by res)
FormationProduct([2,5]-grps by proj, [2,5]-grps by rad)
FormationProduct([2,5]-grps by proj, [2,5]-grps by rad)
FormationProduct([2,5]-grps by proj, [2,5]-grps by inj)
FormationProduct([2,5]-grps by proj, [2,5]-grps by inj)
FormationProduct([2,5]-grps by proj, [2,5]-grps by proj)
FormationProduct([2,5]-grps by proj, [2,5]-grps by proj)
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
>         View(P);
>         Print("\n", P, "\n");
>     od;
> od;
FittingProduct([2,5]-grps by boundary, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by res)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by res)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by rad)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by rad)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by inj)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by inj)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by proj)
FittingProduct([2,5]-grps by boundary, [2,5]-grps by proj)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by boundary)
FittingFormationProduct([2,5]-grps by locdef, [2,5]-grps by locdef)
FittingFormationProduct([2,5]-grps by locdef, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by membersip)
FittingFormationProduct([2,5]-grps by locdef, [2,5]-grps by res)
FittingFormationProduct([2,5]-grps by locdef, [2,5]-grps by res)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by rad)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by rad)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by inj)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by inj)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by proj)
FittingProduct([2,5]-grps by locdef, [2,5]-grps by proj)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by res)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by res)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by rad)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by rad)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by inj)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by inj)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by proj)
FittingProduct([2,5]-grps by membersip, [2,5]-grps by proj)
FittingProduct([2,5]-grps by res, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by res, [2,5]-grps by boundary)
FittingFormationProduct([2,5]-grps by res, [2,5]-grps by locdef)
FittingFormationProduct([2,5]-grps by res, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by res, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by res, [2,5]-grps by membersip)
FittingFormationProduct([2,5]-grps by res, [2,5]-grps by res)
FittingFormationProduct([2,5]-grps by res, [2,5]-grps by res)
FittingProduct([2,5]-grps by res, [2,5]-grps by rad)
FittingProduct([2,5]-grps by res, [2,5]-grps by rad)
FittingProduct([2,5]-grps by res, [2,5]-grps by inj)
FittingProduct([2,5]-grps by res, [2,5]-grps by inj)
FittingProduct([2,5]-grps by res, [2,5]-grps by proj)
FittingProduct([2,5]-grps by res, [2,5]-grps by proj)
FittingProduct([2,5]-grps by rad, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by rad, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by rad, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by rad, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by rad, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by rad, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by rad, [2,5]-grps by res)
FittingProduct([2,5]-grps by rad, [2,5]-grps by res)
FittingProduct([2,5]-grps by rad, [2,5]-grps by rad)
FittingProduct([2,5]-grps by rad, [2,5]-grps by rad)
FittingProduct([2,5]-grps by rad, [2,5]-grps by inj)
FittingProduct([2,5]-grps by rad, [2,5]-grps by inj)
FittingProduct([2,5]-grps by rad, [2,5]-grps by proj)
FittingProduct([2,5]-grps by rad, [2,5]-grps by proj)
FittingProduct([2,5]-grps by inj, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by inj, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by inj, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by inj, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by inj, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by inj, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by inj, [2,5]-grps by res)
FittingProduct([2,5]-grps by inj, [2,5]-grps by res)
FittingProduct([2,5]-grps by inj, [2,5]-grps by rad)
FittingProduct([2,5]-grps by inj, [2,5]-grps by rad)
FittingProduct([2,5]-grps by inj, [2,5]-grps by inj)
FittingProduct([2,5]-grps by inj, [2,5]-grps by inj)
FittingProduct([2,5]-grps by inj, [2,5]-grps by proj)
FittingProduct([2,5]-grps by inj, [2,5]-grps by proj)
FittingProduct([2,5]-grps by proj, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by proj, [2,5]-grps by boundary)
FittingProduct([2,5]-grps by proj, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by proj, [2,5]-grps by locdef)
FittingProduct([2,5]-grps by proj, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by proj, [2,5]-grps by membersip)
FittingProduct([2,5]-grps by proj, [2,5]-grps by res)
FittingProduct([2,5]-grps by proj, [2,5]-grps by res)
FittingProduct([2,5]-grps by proj, [2,5]-grps by rad)
FittingProduct([2,5]-grps by proj, [2,5]-grps by rad)
FittingProduct([2,5]-grps by proj, [2,5]-grps by inj)
FittingProduct([2,5]-grps by proj, [2,5]-grps by inj)
FittingProduct([2,5]-grps by proj, [2,5]-grps by proj)
FittingProduct([2,5]-grps by proj, [2,5]-grps by proj)
gap> 
gap> if PRINT_METHODS then
>     UnTraceMethods(PrintObj, ViewObj);
> fi;
gap> STOP_TEST("print", 950000);
print
GAP4stones: 0
gap> 
gap> 
gap> ############################################################################
gap> ##
gap> #E
gap> ##
gap> 
