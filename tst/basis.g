############################################################################
##
##  basis.g                            CRISP                Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##
LogTo("test.log");
START_TEST("basis");
LoadPackage("crisp", "", false);
CRISP_Read("tst/samples.g");


if PRINT_METHODS then
    TraceMethods(Basis);
fi;

for G in groups do
    Info(InfoTest, 1, G());
    old := fail;
    cl := classes(); 
    for C in cl do
        SetIsSchunckClass(C, true);
    od;
    for i in [1..Length(cl)] do
        if InfoLevel(InfoTest) >= 2 then
            View(cl[i]);
            Print("\n");
        fi;
        new := G() in Basis(cl[i]);
        if old = fail then
            old := new;
        elif old <> new then
            Error("different result for group ", G(), " and class ", cl[i]);
        fi;
        for j in [i..Length(cl)] do
            I := Intersection(cl[i], cl[j]);
            if InfoLevel(InfoTest) >= 3 then
                View(I);
                Print("\n");
            fi;
            new := G() in Basis(I);
            if old <> new then
                Error("different result for group ", G(), 
                     " and intersection of classes ", cl[i],
                     " and ", cl[j]);
            fi;
        od;
    od;
    for C in cl do
        SetIsOrdinaryFormation(C, true);
    od;
    for C in cl do
        for D in cl do
            P := FormationProduct(C, D);
            if InfoLevel(InfoTest) >= 3 then
                View(C);
                Print("-by-");
                View(D);
                Print("\n");
            fi;
            new := G() in Basis(P);
            if old <> new then
                Error("different result for group ", G(), 
                     " and intersection of classes ", cl[i],
                     " and ", cl[j]);
            fi;
        od;
    od;
od;

if PRINT_METHODS then
    UnTraceMethods(Basis);
fi;
STOP_TEST("basis", 0);


############################################################################
##
#E
##