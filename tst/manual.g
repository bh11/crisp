############################################################################
##
##  manual.g                        CRISP                  BBurkhard Höfling
##
##  Copyright (C) 2000 Burkhard Höfling
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