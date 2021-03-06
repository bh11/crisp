############################################################################
##
##  socle.g                           CRISP                 Burkhard Höfling
##
##  Copyright © 2000, 2015 by Burkhard Höfling
##
LogTo("test.log");
START_TEST("crisp");
LoadPackage("crisp", "", false);
CRISP_Read("tst/samples.g");

if PRINT_METHODS then
    TraceMethods(Socle);
    TraceMethods(SocleComponents);
    TraceMethods(PSocleOp);
    TraceMethods(PSocleComponentsOp);
    TraceMethods(PSocleSeriesOp);
fi;

for G in groups do
    Info(InfoTest, 1, G());
    old := Size(Socle(G()));
    new := Size(SolvableSocle(G()));
    
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
    new := Product(SocleComponents(G()), Size);
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
    new := Product(SolvableSocleComponents(G()), Size);
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
    
    new := Product(PrimeDivisors(Size(G())), p -> Size(PSocle(G(), p)));
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
    new := Product(PrimeDivisors(Size(G())), p ->
    		Product(PSocleComponents(G(), p), Size));
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
od;


for G in insolvgroups do
    Info(InfoTest, 1, G());
    old := Size(SolvableSocle(G()));
    
    new := Product(SolvableSocleComponents(G()), Size);
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
    
    new := Product(PrimeDivisors(Size(G())), p -> Size(PSocle(G(), p)));
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
    new := Product(PrimeDivisors(Size(G())), p ->
    		Product(PSocleComponents(G(), p), Size));
    if old = fail then
        old := new;
    elif old <> new then
        Error("different results");
    fi;
od;

if PRINT_METHODS then
    UnTraceMethods(Socle);
    UnTraceMethods(SocleComponents);
    UnTraceMethods(PSocleOp);
    UnTraceMethods(PSocleComponentsOp);
    UnTraceMethods(PSocleSeriesOp);
fi;
STOP_TEST("crisp", 0);


############################################################################
##
#E
##
