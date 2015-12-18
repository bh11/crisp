############################################################################
##
##  socle.g                           CRISP                 Burkhard Höfling
##
##  Copyright (C) 2000, 2015 by Burkhard Höfling
##
LoadPackage ("crisp");
ReadPackage ("crisp", "tst/samples.g");

if PRINT_METHODS then
    TraceMethods (Socle);
    TraceMethods (SocleComponents);
    TraceMethods (PSocleOp);
    TraceMethods (PSocleComponentsOp);
    TraceMethods (PSocleSeriesOp);
fi;

for G in groups do
    Info (InfoTest, 1, G());
    old := Size (Socle (G()));
    new := Size (SolvableSocle (G()));
    
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
    new := Product (SocleComponents (G()), Size);
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
    new := Product (SolvableSocleComponents (G()), Size);
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
    
    new := Product (PrimeDivisors (Size(G())), p -> Size (PSocle (G(), p)));
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
    new := Product (PrimeDivisors (Size (G())), p ->
    		Product (PSocleComponents (G(), p), Size));
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
od;


for G in insolvgroups do
    Info (InfoTest, 1, G());
    old := Size (SolvableSocle (G()));
    
    new := Product (SolvableSocleComponents (G()), Size);
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
    
    new := Product (PrimeDivisors (Size(G())), p -> Size (PSocle (G(), p)));
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
    new := Product (PrimeDivisors (Size(G())), p ->
    		Product (PSocleComponents (G(), p), Size));
    if old = fail then
        old := new;
    elif old <> new then
        Error ("different results");
    fi;
od;

if PRINT_METHODS then
    UntraceMethods (Socle);
    UntraceMethods (SocleComponents);
    UntraceMethods (PSocleOp);
    UntraceMethods (PSocleComponentsOp);
    UntraceMethods (PSocleSeriesOp);
fi;


############################################################################
##
#E
##
