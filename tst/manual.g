############################################################################
##
##  manual.g                        CRISP                 Burkhard Höfling
##
##  Copyright (C) 2012 by Burkhard H\"ofling
##
LoadPackage ("crisp");

dir := DirectoriesPackageLibrary ("crisp", "doc")[1];
for ch in [2..5] do
    Print ("Testing examples in chapter ", ch, ":\n");
    ReadTest (Filename (dir, Concatenation ("manual.example-", String(ch),".tst")));
od;

############################################################################
##
#E
##