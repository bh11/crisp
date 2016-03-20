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

PrintDiffLists := function(old, new, printequal)

    local i, j, m, n, lcs;

    m := Length(old);
    n := Length(new);

    lcs := [];
    for i in [1..m+1] do
        lcs[i] := [];
        lcs[i][n+1] := 0;
    od;
    for j in [1..n+1] do
        lcs[m+1][j] := 0;
    od;

    for i in [m, m-1..1] do
        for j in [n, n-1..1] do
            if old[i]=new[j] then
                lcs[i][j] := lcs[i+1][j+1] + 1;
            else
                lcs[i][j] := Maximum(lcs[i+1][j], lcs[i][j+1]);
            fi;
        od;
    od;

    i := 1;
    j := 1;

    while (i <= m) or (j <= n) do
        # Print(i, " ", j, " ");
        if i <= m and lcs[i][j] = lcs[i+1][j] then
            Print ("- ", old[i], "\n");
            i := i + 1;
        elif j <= n and lcs[i][j] = lcs[i][j+1] then
            Print ("+ ", new[j], "\n");
            j := j + 1;
        elif i <= m and j <= n and lcs[i][j] > lcs[i+1][j+1] then
            if printequal then
                Print ("  ", old[i], "\n");
            fi;
            i := i + 1;
            j := j + 1;
        else
            Error("This should not happen");
        fi;
    od;
end;


ReportUnifiedDiff:= function(inp, exp, got, file, line, time)

    Print("########> Diff in ", file, " line ", line, "\n");
    Print("# Input is:\n");
    Print(inp);
    Print("# Output diff is:\n");
    PrintDiffLists(SplitString(exp, '\n'), SplitString(got, '\n'), true);
    Print("########\n");
end;

TestDirectory(DirectoriesPackageLibrary("crisp", "tst"),
        rec(exitGAP := true, testOptions:= rec(reportDiff := ReportUnifiedDiff)));

############################################################################
##
#E
##
