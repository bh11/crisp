gap> START_TEST("crisp");
gap> LoadPackage("crisp", "", false);
true
gap> CRISP_Read("tst/samples.g");
gap> 
gap> if PRINT_METHODS then
>     TraceMethods(Socle);
>     TraceMethods(SocleComponents);
>     TraceMethods(PSocleOp);
>     TraceMethods(PSocleComponentsOp);
>     TraceMethods(PSocleSeriesOp);
> fi;
gap> 
gap> for G in groups do
>     Info(InfoTest, 1, G());
>     old := Size(Socle(G()));
>     new := Size(SolvableSocle(G()));
>     
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     new := Product(SocleComponents(G()), Size);
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     new := Product(SolvableSocleComponents(G()), Size);
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     
>     new := Product(PrimeDivisors(Size(G())), p -> Size(PSocle(G(), p)));
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     new := Product(PrimeDivisors(Size(G())), p ->
>     		Product(PSocleComponents(G(), p), Size));
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
> od;
#I  trivial pc group
#I  trivial perm group
#I  trivial mat group
#I  GL(2,3) as pc group
#I  Sym(4)
#I  Dih(10)
#I  GL(2,3)
gap> 
gap> 
gap> for G in insolvgroups do
>     Info(InfoTest, 1, G());
>     old := Size(SolvableSocle(G()));
>     
>     new := Product(SolvableSocleComponents(G()), Size);
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     
>     new := Product(PrimeDivisors(Size(G())), p -> Size(PSocle(G(), p)));
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
>     new := Product(PrimeDivisors(Size(G())), p ->
>     		Product(PSocleComponents(G(), p), Size));
>     if old = fail then
>         old := new;
>     elif old <> new then
>         Error("different results");
>     fi;
> od;
#I  SymmetricGroup( [ 1 .. 5 ] )
#I  GL(2,5)
#I  C5 wr S5
#I  Aut(C5xC5)
gap> 
gap> if PRINT_METHODS then
>     UnTraceMethods(Socle);
>     UnTraceMethods(SocleComponents);
>     UnTraceMethods(PSocleOp);
>     UnTraceMethods(PSocleComponentsOp);
>     UnTraceMethods(PSocleSeriesOp);
> fi;
gap> STOP_TEST("crisp", 13710000);
crisp
GAP4stones: 0
gap> 
gap> 
gap> ############################################################################
gap> ##
gap> #E
gap> ##
gap> 
