gap> START_TEST("basis");
gap> LoadPackage("crisp", "", false);
true
gap> CRISP_Read("tst/samples.g");
gap> 
gap> 
gap> if PRINT_METHODS then
>     TraceMethods(Basis);
> fi;
gap> 
gap> for G in groups do
>     Info(InfoTest, 1, G());
>     old := fail;
>     cl := classes(); 
>     for C in cl do
>         SetIsSchunckClass(C, true);
>     od;
>     for i in [1..Length(cl)] do
>         if InfoLevel(InfoTest) >= 2 then
>             View(cl[i]);
>             Print("\n");
>         fi;
>         new := G() in Basis(cl[i]);
>         if old = fail then
>             old := new;
>         elif old <> new then
>             Error("different result for group ", G(), " and class ", cl[i]);
>         fi;
>         for j in [i+1..Length(cl)] do
>             I := Intersection(cl[i], cl[j]);
>             if InfoLevel(InfoTest) >= 3 then
>                 View(I);
>                 Print("\n");
>             fi;
>             new := G() in Basis(I);
>             if old <> new then
>                 Error("different result for group ", G(), 
>                      " and intersection of classes ", cl[i],
>                      " and ", cl[j]);
>             fi;
>         od;
>     od;
>     for C in cl do
>         SetIsOrdinaryFormation(C, true);
>     od;
>     for C in cl do
>         for D in cl do
>             P := FormationProduct(C, D);
>             if InfoLevel(InfoTest) >= 3 then
>                 View(C);
>                 Print("-by-");
>                 View(D);
>                 Print("\n");
>             fi;
>             new := G() in Basis(P);
>             if old <> new then
>                 Error("different result for group ", G(), 
>                      " and intersection of classes ", cl[i],
>                      " and ", cl[j]);
>             fi;
>         od;
>     od;
> od;
#I  trivial pc group
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
#I  trivial perm group
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
#I  trivial mat group
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
#I  GL(2,3) as pc group
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
#I  Sym(4)
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
#I  Dih(10)
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
#I  GL(2,3)
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
[2,5]-grps by boundary-by-[2,5]-grps by boundary
[2,5]-grps by boundary-by-[2,5]-grps by locdef
[2,5]-grps by boundary-by-[2,5]-grps by membersip
[2,5]-grps by boundary-by-[2,5]-grps by res
[2,5]-grps by boundary-by-[2,5]-grps by rad
[2,5]-grps by boundary-by-[2,5]-grps by inj
[2,5]-grps by boundary-by-[2,5]-grps by proj
[2,5]-grps by locdef-by-[2,5]-grps by boundary
[2,5]-grps by locdef-by-[2,5]-grps by locdef
[2,5]-grps by locdef-by-[2,5]-grps by membersip
[2,5]-grps by locdef-by-[2,5]-grps by res
[2,5]-grps by locdef-by-[2,5]-grps by rad
[2,5]-grps by locdef-by-[2,5]-grps by inj
[2,5]-grps by locdef-by-[2,5]-grps by proj
[2,5]-grps by membersip-by-[2,5]-grps by boundary
[2,5]-grps by membersip-by-[2,5]-grps by locdef
[2,5]-grps by membersip-by-[2,5]-grps by membersip
[2,5]-grps by membersip-by-[2,5]-grps by res
[2,5]-grps by membersip-by-[2,5]-grps by rad
[2,5]-grps by membersip-by-[2,5]-grps by inj
[2,5]-grps by membersip-by-[2,5]-grps by proj
[2,5]-grps by res-by-[2,5]-grps by boundary
[2,5]-grps by res-by-[2,5]-grps by locdef
[2,5]-grps by res-by-[2,5]-grps by membersip
[2,5]-grps by res-by-[2,5]-grps by res
[2,5]-grps by res-by-[2,5]-grps by rad
[2,5]-grps by res-by-[2,5]-grps by inj
[2,5]-grps by res-by-[2,5]-grps by proj
[2,5]-grps by rad-by-[2,5]-grps by boundary
[2,5]-grps by rad-by-[2,5]-grps by locdef
[2,5]-grps by rad-by-[2,5]-grps by membersip
[2,5]-grps by rad-by-[2,5]-grps by res
[2,5]-grps by rad-by-[2,5]-grps by rad
[2,5]-grps by rad-by-[2,5]-grps by inj
[2,5]-grps by rad-by-[2,5]-grps by proj
[2,5]-grps by inj-by-[2,5]-grps by boundary
[2,5]-grps by inj-by-[2,5]-grps by locdef
[2,5]-grps by inj-by-[2,5]-grps by membersip
[2,5]-grps by inj-by-[2,5]-grps by res
[2,5]-grps by inj-by-[2,5]-grps by rad
[2,5]-grps by inj-by-[2,5]-grps by inj
[2,5]-grps by inj-by-[2,5]-grps by proj
[2,5]-grps by proj-by-[2,5]-grps by boundary
[2,5]-grps by proj-by-[2,5]-grps by locdef
[2,5]-grps by proj-by-[2,5]-grps by membersip
[2,5]-grps by proj-by-[2,5]-grps by res
[2,5]-grps by proj-by-[2,5]-grps by rad
[2,5]-grps by proj-by-[2,5]-grps by inj
[2,5]-grps by proj-by-[2,5]-grps by proj
gap> 
gap> if PRINT_METHODS then
>     UnTraceMethods(Basis);
> fi;
gap> STOP_TEST("basis", 32620000);
basis
GAP4stones: 0
gap> 
gap> 
gap> ############################################################################
gap> ##
gap> #E
gap> ##gap> gap> 
