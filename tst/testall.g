############################################################################
##
##  testall.g                         CRISP                 Burkhard Höfling
##
##  Copyright © 2016 Burkhard Höfling
##
LoadPackage("crisp", "", false);
DeclareInfoClass("InfoTest");
SetInfoLevel(InfoTest,3);
PRINT_METHODS := false;
if TestDirectory(DirectoriesPackageLibrary("crisp", "tst")) then
    Print("#I  No errors detected while testing package CRISP\n");
else
    Print("#I  Errors detected while testing package CRISP\n");
fi;

############################################################################
##
#E
##
