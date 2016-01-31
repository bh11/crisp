############################################################################
##
##  manual.g                        CRISP                  BBurkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##
LoadPackage("crisp");

if not IsBound(Test) then
    Test := ReadTest;
fi;

dir := DirectoriesPackageLibrary("crisp", "doc")[1];
for ch in [2,3,4,5,7] do
    Print("Testing examples in chapter ", ch, ":\n");
    Test(Filename(dir, Concatenation("manual.example-", String(ch),".tst")), rec(compareFunction := "uptowhitespace"));
od;

############################################################################
##
#E
##