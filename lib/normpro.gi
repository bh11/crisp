#############################################################################
##
##  normpro.gi                      CRISP                    Burkhard Höfling
##
##  Copyright © 2000, 2001, 2003, 2005 Burkhard Höfling
##


#############################################################################
##
#M  PcgsNormalizerOfPronormalSubgroup(<pcgs>, <ppcgs>)
##
##  returns the normalizer of the group generated by <ppcgs> in <pcgs>. 
##  The former must must be pronormal in the latter(in particular,
##  it must be a subgroup(which we don't check).
##
InstallMethod(PcgsNormalizerOfPronormalSubgroup, 
    "for pcgs refining an el. ab. series",
    IsIdenticalObj, 
    [IsPcgs, IsPcgs and HasParentPcgs], 0, 
    function(pcgs, ppcgs)
    
    local parentpcgs, N, r, 
        alpha, i, j, k, l, z, y, start,
        F, p, field, npcgs, pnpcgs, pmodn, pmodndepths,
        depths, ind, range, one,
        conj, e, v, w, 
        null, mat, sol, n, NN, sub, inters, gens;

    parentpcgs := ParentPcgs(pcgs);
    
    if not IsPcgsElementaryAbelianSeries(pcgs) then
        Error("pcgs must refine an elementary abelian series");
    elif parentpcgs <> ParentPcgs(ppcgs) then
        Error("pcgs and ppcgs must have the same parent pcgs");
    fi;
    ind := IndicesEANormalSteps(pcgs);
    
    N := List([1..Length(ind)], 
        i -> InducedPcgsByPcSequenceNC(parentpcgs, pcgs{[ind[i]..Length(pcgs)]}));
    r := Length(N);
        
    # since <pcgs>/N[2] is abelian, every subgroup is normal
    if r < 3 then
        return pcgs;
    fi;
    
    one := One(GroupOfPcgs(pcgs));
    ppcgs := CanonicalPcgs(ppcgs);
    depths := List(ppcgs, y -> DepthOfPcElement(pcgs, y));
    
    # <ppcgs, N[2]> is normalized by the elements in npcgs
    npcgs := List(pcgs mod N[2]);
    conj := List(npcgs, g -> List(ppcgs, y -> y^g)); 

    for i in [3..r] do
        
        Info(InfoNormalizer, 1, "starting level ",i, " of ",r,
            " with ",Length(npcgs)," generators");
        # we assume that <ppcgs, N[i-1]> is normalized by the elements in npcgs

        # compute a pcgs npcgs of N_GN[i](<ppcgs>N[i]) modulo <ppcgs>N[i] from one of
        # N_GN[i-1](<ppcgs>N[i-1]) modulo <ppcgs> N[i-1]

        # first find N[i-1] mod(<ppcgs> inters N[i-1]) N[i]

        sub := Filtered([1..Length(ppcgs)], k -> depths[k] < ind[i]);

        pmodn := ppcgs{sub};
        pmodndepths := depths{sub};
        
        pnpcgs := InducedPcgsByPcSequenceNC(parentpcgs, 
            Concatenation(pmodn, N[i]));


        inters := Filtered(sub, k -> depths[k] >= ind[i-1]);
        F := N[i-1] mod
            InducedPcgsByPcSequenceNC(parentpcgs, Concatenation(ppcgs{inters}, N[i]));

        if Length(F) > 0 then
            # get the exponent of N[i-1]/N[i]
            p := RelativeOrderOfPcElement(F, F[1]);
            field := GF(p);
                
            for j in [1..Length(npcgs)] do
                
                # multiply npcgs[j] by an
                # element in F such that it centralises the generators of
                # <ppcgs>N[i] - the required exponents of elements in F
                # can be found by solving a linear system

                if Length(pmodn) > 0 then 
                
                    # determine the conjugation action of npcgs[j]
                    # on <ppcgs>N[i]
        
                    n := List(conj[j], y -> 
                        SiftedPcElementWrtPcSequence(pcgs, pmodn, pmodndepths, y));
                                
                    Assert(1, ForAll([1..Length(ppcgs)], 
                        k -> conj[j][k] = ppcgs[k]^npcgs[j]),
                        Error("conj[j][k] <> ppcgs[k]^npcgs[j]"));
                    Assert(1, ForAll(sub, k -> SiftedPcElement(N[i-1],n[k]) = one),
                        Error("ppcgs[k]^npcgs[j] does not lie in PN[i-1]"));
                    
                    Info(InfoNormalizer, 2, "adjusting element ",npcgs[j],
                        " of depth ",DepthOfPcElement(pcgs, npcgs[j]));
    
                    mat := [];
                    sol := [];
                    
                    for l in [1..Length(F)] do
                        mat[l] := [];
                    od;
                    
                    for k in [1..Length(pmodn)] do
                        for l in [1..Length(F)] do
                            e := ExponentsConjugateLayer(F, F[l], conj[j][k])* One(field);
                            e[l] := e[l] - One(field);
                            Append(mat[l],e);
                        od;    
                        
                        Append(sol, ExponentsOfPcElement(F, n[k]) * One(field));
                    od;
                    
                    # now solve the system and adjust g
                    w := SolutionMat(mat , sol);
                    z := PcElementByExponentsNC(F, List(w, IntFFE ));
    
                    npcgs[j] := npcgs[j] * z;
                    Assert(1, 
                        ForAll(ppcgs, y -> 
                            SiftedPcElement(pnpcgs, Comm(y,npcgs[j]))
                                    = one),
                        Error("npcgs[j] does not normalize modulo N[i]"));
                    
                    Info(InfoNormalizer, 3, "adjusted element ",npcgs[j], 
                        " now of depth ", DepthOfPcElement(pcgs, npcgs[j]));
                        
                    for k in [1..Length(ppcgs)] do
                        conj[j][k] := conj[j][k]^z;
                        Assert(1, conj[j][k] = ppcgs[k]^npcgs[j],
                            Error("conj[j][k] <> ppcgs[k]^npcgs[j]"));
    
                    od;
                else
                    Info(InfoNormalizer, 3, "unchanged element ",npcgs[j], 
                        " of depth ", 
                        DepthOfPcElement(pcgs, npcgs[j]));
                    Assert(1, ForAll([1..Length(ppcgs)], k ->conj[j][k] = ppcgs[k]^npcgs[j]),
                        Error("conj[j][k] <> ppcgs[k]^npcgs[j]"));
                    Assert(1, 
                        ForAll(ppcgs, y -> 
                            SiftedPcElement(pnpcgs, Comm(y,npcgs[j]))
                                    = one),
                        Error("npcgs[j] does not normalize modulo N[i]"));
                fi;
            od;
            
            # now find centralising elements in N[i-1]/N[i-1] inters <ppcgs>N[i]
    
            if Length(pmodn) > 0 then
                mat := [];
                for l in [1..Length(F)] do
                    mat[l] := [];
                od;
                    
                for y in pmodn do
                    for l in [1..Length(F)] do
                        e := ExponentsConjugateLayer(F, F[l], y)* One(field);
                        e[l] := e[l] - One(field);
                        Append(mat[l],e);
                    od;    
                od;
        
                gens := NullspaceMat(mat);
                Assert(1, ForAll(gens, w -> 
                    ForAll(ppcgs, y -> 
                    SiftedPcElement(pnpcgs, 
                            Comm(y,PcElementByExponentsNC(F, List(w, IntFFE)))) 
                    = one)),
                Error("w does not normalize modulo N[i]"));
            
                if Length(gens) > 0 then
                    null := VectorSpace(field, gens);
                    for v in CanonicalBasis(null) do
                        z := PcElementByExponentsNC(F, List(v, IntFFE));
                        Add(npcgs, z);
                        Add(conj, List(ppcgs, y -> y^z)); 
                        Assert(1, ForAll(ppcgs, y -> 
                            SiftedPcElement(pnpcgs, Comm(y,z)) = one),
                            Error("last element of npcgs does not normalize modulo N[i]"));
                        Info(InfoNormalizer, 2, "additional centralising generator: ",
                            npcgs[Length(npcgs)], " of depth ", 
                            DepthOfPcElement(pcgs, npcgs[Length(npcgs)]));
                    od;
                fi;
            else # everything centralises 
                for z in F do
                    Add(npcgs, z);
                    Add(conj, List(ppcgs, y -> y^z)); 
                    Assert(1, ForAll(ppcgs, y -> 
                        SiftedPcElement(pnpcgs, Comm(y,z)) = one),
                        Error("last element of npcgs does not normalize modulo N[i]"));
                    Info(InfoNormalizer, 2, "additional centralising generator: ",
                        npcgs[Length(npcgs)], " of depth ", 
                        DepthOfPcElement(pcgs, npcgs[Length(npcgs)]));
                od;
            fi;
        fi;
        
        # finally, add elements from <ppcgs> N[i] inters N[i-1]
        
        for z in ppcgs{inters} do
            Add(npcgs, z);
            Add(conj, List(ppcgs, y -> y^z)); 
            Assert(1, ForAll(ppcgs, y -> 
                SiftedPcElement(pnpcgs, Comm(y,z)) = one),
                Error("last element of npcgs does not normalize modulo N[i]"));
            Info(InfoNormalizer, 3, "additional generator from <ppcgs>: ",
                npcgs[Length(npcgs)], " of depth ", 
                DepthOfPcElement(pcgs, npcgs[Length(npcgs)]));
        od;
        
        SortParallel(npcgs, conj, 
            function(x, y) 
                return DepthOfPcElement(pcgs, x) < DepthOfPcElement(pcgs, y); 
            end);
            
        Assert(1, ForAll([1..Length(npcgs)-1], 
            k -> DepthOfPcElement(pcgs, npcgs[k]) < DepthOfPcElement(pcgs, npcgs[k+1])),
            Error("npcgs is not a pcgs"));

        Assert(1, ForAll(ppcgs, y ->
            SiftedPcElement(
                InducedPcgsByPcSequence(parentpcgs, Concatenation(npcgs, N[i])), 
                y) 
            = one),
            Error("<ppcgs> is not a subgroup of its normalizer"));
        Assert(1, ForAll(npcgs, z ->
            ForAll(ppcgs, y -> 
                SiftedPcElement(pnpcgs, Comm(y,z)) = one)),
                    Error("last element of npcgs does not normalize modulo N[i]"));
        Assert(1, ForAll(npcgs, z -> ForAll(ppcgs, y -> 
            SiftedPcElement(pnpcgs, Comm(y,z)) = one)),
                Error("element of npcgs does not normalize"));
    od;
                    
    Assert(1, ForAll(npcgs, z -> ForAll(ppcgs, y -> 
        SiftedPcElement(ppcgs, Comm(y,z)) = one)
        ),
            Error("element of npcgs does not normalize"));

    return InducedPcgsByPcSequenceNC(parentpcgs, npcgs);
    
end);


#############################################################################
##
#M  NormalizerOfPronormalSubgroup(<grp>, <sub>
##
##  returns the normalizer of <sub> in <grp>. <sub> must be a pronormal
##  subgroup of <grp>, i.e., for every g in <grp>, <sgr> and <sgr>^g > 
##  are conjugate in their join.
##
InstallMethod(NormalizerOfPronormalSubgroup, 
    "use pcgs method",
    IsIdenticalObj, 
    [IsGroup and IsFinite and CanEasilyComputePcgs, IsGroup], 0, 
    function(H, P)
        local pcgs;
        pcgs := PcgsElementaryAbelianSeries(H);
        return SubgroupByPcgs(H,
            PcgsNormalizerOfPronormalSubgroup(pcgs, InducedPcgs(pcgs, P)));
    end);
    

#############################################################################
##
#M  NormalizerOfPronormalSubgroup(<grp>, <sub>
##
InstallMethod(NormalizerOfPronormalSubgroup, 
    "via IsomorphismPcGroup",
    IsIdenticalObj, 
    [IsSolvableGroup and IsFinite, IsGroup], 0, 
    function(G, H)
        local iso;
        if CanEasilyComputePcgs(G) then
            TryNextMethod();
        fi;
        iso := IsomorphismPcGroup(G);
        return PreImagesSet(iso, 
                NormalizerOfPronormalSubgroup(ImagesSource(iso), ImagesSet(iso, H)));
    end);
        

#############################################################################
##
#M  NormalizerOfPronormalSubgroup(<grp>, <sub>
##
InstallMethod(NormalizerOfPronormalSubgroup, 
    "via nice hom.",
    IsIdenticalObj, 
    [IsGroup and IsHandledByNiceMonomorphism, IsGroup], 0, 
    function(G, H)
        local iso;
        iso := NiceMonomorphism(G);
        return PreImagesSet(iso, 
                NormalizerOfPronormalSubgroup(NiceObject(G), ImagesSet(iso, H)));
    end);
        

#############################################################################
##
#M  NormalizerOfPronormalSubgroup(<grp>, <sub>
##
InstallMethod(NormalizerOfPronormalSubgroup, 
    "for generic groups",
    IsIdenticalObj, 
    [IsGroup, IsGroup], 0, 
    function(G, H)
        if IsFinite(G) and IsSolvableGroup(G) then
            return NormalizerOfPronormalSubgroup(G, H);
        else
            return Normalizer(G, H);
        fi;
    end);
        

############################################################################
##
#E
##
