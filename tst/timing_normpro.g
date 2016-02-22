############################################################################
##
##  timing_normpro.g                   CRISP                Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##
LoadPackage("crisp", "", false);
CRISP_Read("tst/timing_samples.g");

LoadPackage("crisp");
CRISP_Read("tst/timing_test.g");
CRISP_Read("tst/timing_samples.g");


############################################################################
##
#F  test(H)
##
##  computes normalizers of the Sylow p-subgroups of H for all prime 
##  p of |H| and compares the result of the library method to the results
##  obtained by NormalizerOfPronormalSubgroup
##
##  if DO_TIMING is true, the running times needed by these functions is 
##  being measured, too.
##
test := function(H)  # computes normalizers of the Sylow subgroups of H
    
    local p, primes, res, P, norm1, norm2, t1, t2, t0;
    
    Print("testing group of size ");
    PrintFactorsInt(Size(H));
    Print("\n");
    primes := PrimeDivisors(Size(H));
    res := [];
    SpecialPcgs(H);
    PcgsElementaryAbelianSeries(H);
    
    for p in primes do 
        P := SylowSubgroup(H, p);
        Print("prime ", p, " |P| =", Size(P), " |H:P| = ", 
            Size(H)/Size(P), "\c");
        if IsBound(DO_TIMING) and DO_TIMING then
            GASMAN("collect");
        fi;
        t0 := Runtime();
        if IsBound(TIMEOUT) and IsBound(CallWithTimeout) then
            norm1 := CallWithTimeout(TIMEOUT, NormalizerOfPronormalSubgroup, H, P);
            if IsList(norm1) then
                norm1 := norm1[1];
            fi;
        else
            norm1 := NormalizerOfPronormalSubgroup(H, P);
        fi;
        if norm1 = fail then
            t1 := "n/a";
        else
            t1 := Runtime() - t0;
        fi;
        if IsBound(DO_TIMING) and DO_TIMING then
            Print("  ", t1, "\c");
        fi;
        if IsBound(DO_TIMING) and DO_TIMING then
            GASMAN("collect");
        fi;
        t0 := Runtime();
        if IsBound(TIMEOUT) and IsBound(CallWithTimeout) then
            norm2 := CallWithTimeout(TIMEOUT, Normalizer, H, P);
            if IsList(norm2) then
                norm2 := norm2[1];
            fi;
        else
            norm2 := Normalizer(H, P);
        fi;
        if norm2 = fail then
            t2 := "n/a";
        else
            t2 := Runtime() - t0;
        fi;
        if IsBound(DO_TIMING) and DO_TIMING then
            Print("  ", t2, "\c");
        fi;
        if norm1 <> fail and norm2 <> fail and norm1 <> norm2 then
            Error("wrong normalizer  \n");
        fi;
        if Index(H, norm1) mod p <> 1 then
            Error("wrong index \n");
        fi;
        if IsBound(DO_TIMING) and DO_TIMING then
            Print("  |N_G(P):P| = ", Size(norm1)/Size(P),
                "  |G:N_G(P)| =  ", Size(H)/Size(norm1), "\n");
        else
        	 Print("\n");
        fi;
    od;
end;


############################################################################
##
#F  test(G)
##
##  generate random subgroup of G and run function test on it
##
test2 := function(G)  

    local pcgs, pcgsH, H, i, new;
    
    pcgs := Pcgs(G);
    pcgsH := InducedPcgsByPcSequence(pcgs, []);
    H := SubgroupByPcgs(G, pcgsH);
    
    repeat 
        new := Random(PcSeries(pcgs)[Random([1..Length(pcgs)])]);
        i := DepthOfPcElement(pcgs, new);
        if not new in H then
            pcgsH := InducedPcgsByPcSequenceAndGenerators(pcgs, pcgsH, [new]);
            H := SubgroupByPcgs(G, pcgsH);
            test(H);
        fi;
    until H = G;
end;


# now run the actual tests

for g in groups do
    if IsBoundGlobal(g[3]) then
        if IsReadOnlyGlobal(g[3]) then
            MakeReadWriteGlobal(g[3]);
        fi;
        UnbindGlobal(g[3]);
    fi;
    SilentRead(g[1],g[2],g[3]);
    if IsBound(g[4]) then
        name := g[4];
    else
        name := g[3];
    fi;
    tmp := ValueGlobal(g[3]);
    if IsReadOnlyGlobal(g[3]) then
        MakeReadWriteGlobal(g[3]);
    fi;
    UnbindGlobal(g[3]);

    # test2 uses random subgroups, so it makes sense to run it a few times
    test2(tmp);
    test2(tmp);
    test2(tmp);
od;


############################################################################
##
#E
##
