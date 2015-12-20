#############################################################################
##
##  socle.gi                           CRISP                 Burkhard Höfling
##
##  Copyright (C) 2001, 2002, 2005, 2015 Burkhard Höfling
##

#############################################################################
##
#M  PSocleComponentsOp (<G>, <p>) 
##
InstallMethod (PSocleComponentsOp, 
    "for finite group", true,
    [IsGroup and IsFinite, IsPosInt], 
    0,
    function( G, p )

        local P, O, ser, j, N, res;

        if Size(G) mod p <> 0 then
            return [];
        fi;

        P := PCore (G,p);

        if IsTrivial (P) then
            return [];
        fi;

        O := Omega (Center (P),p,1);

        ser := CompositionSeriesUnderAction (G, O);

        res := [ser[Length (ser)-1]];
        for j in [Length (ser)-2, Length (ser)-3..1] do
            N := ComplementsOfCentralSectionUnderActionNC (G, ser[j], ser[j+1], TrivialSubgroup (G), false);
            if N <> fail then
                Add (res, N);
            fi;
        od;
        return res;
    end);


#############################################################################
##
#M  PSocleComponentsOp (<G>, <p>) 
##
InstallMethod (PSocleComponentsOp, 
    "for finite group with SolvableSocleComponents", true, 
    [IsGroup and IsFinite and HasSolvableSocleComponents, 
        IsPosInt], 
    0,
    function( G, p ) 
        return Filtered (SolvableSocleComponents (G), L -> PrimePGroup (L) = p);
    end);


#############################################################################
##
#M  PSocleComponentsOp (<G>, <p>) 
##
RedispatchOnCondition (PSocleComponentsOp, true, 
    [IsGroup, IsPosInt], 
    [IsFinite, ],
    0);
    
    
#############################################################################
##
#M  PSocleComponentsOp (<G>, <p>) 
##
InstallMethod (PSocleComponentsOp,
    "via IsomorphismPcGroup",
    true,
    [IsGroup and IsSolvableGroup and IsFinite, IsPosInt],
    0,
    function( grp, p)
        local hom;
        if CanEasilyComputePcgs (grp) then
            TryNextMethod();
        fi;
        hom := IsomorphismPcGroup (grp);
        return List (PSocleComponentsOp (ImagesSource (hom), p),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  PSocleComponentsOp (<G>, <p>) 
##
InstallMethod (PSocleComponentsOp,
    "handled by nice monomorphism",
    true,
    [IsGroup and IsHandledByNiceMonomorphism and IsFinite, 
        IsPosInt],
    0,
    function( grp, p )
        local hom;
        hom := NiceMonomorphism (grp);
        return List (PSocleComponentsOp (NiceObject (grp), p),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  PSocleSeriesOp (<G>, <p>)
##
InstallMethod (PSocleSeriesOp,
    "for pcgs computable group, compute from components", true,
    [IsGroup and CanEasilyComputePcgs and IsFinite, IsPosInt],
    0,
    function( G, p )

        local i, pcgs, pcgssoc, socdepths, L, x, ser, n, S;

        pcgs := ParentPcgs (Pcgs (G));

        pcgssoc := [];
        socdepths := [];
        ser := [TrivialSubgroup(G)];

        for L in PSocleComponents (G, p) do
            for x in Reversed (Pcgs (L)) do
                if not AddPcElementToPcSequence (pcgs, pcgssoc, socdepths, x) then
                    Error ("Internal error in method for `PSocleOp' for pcgs computable group");
                fi;
            od;
            S := GroupOfPcgs (InducedPcgsByPcSequenceNC (pcgs, pcgssoc));
            Assert (1, IsElementaryAbelian(S));
            SetIsElementaryAbelian (S, true);
            Add (ser, S);
        od;
        return ser;
    end);


#############################################################################
##
#M  PSocleSeriesOp (<G>, <p>)
##
InstallMethod (PSocleSeriesOp,
    "for finite group, compute from components", true,
    [IsGroup and IsFinite, IsPosInt],
    0,
    function( G, p )

        local S, ser, L;
        
        S := TrivialSubgroup (G);
        ser := [S];

        for L in PSocleComponents (G, p) do
            S := ClosureGroup (S, L);
            Assert (1, IsElementaryAbelian(S));
            SetIsElementaryAbelian (S, true);
            Add (ser, S);
        od;
        return ser;
    end);


#############################################################################
##
#M  PSocleSeriesOp (<G>, <p>)
##
RedispatchOnCondition (PSocleSeriesOp, true,
    [IsGroup, IsPosInt], 
    [IsFinite, ],
    0);
    
    
#############################################################################
##
#M  PSocleSeriesOp (<G>, <p>)
##
InstallMethod (PSocleSeriesOp,
    "via IsomorphismPcGroup",
    true,
    [IsGroup and IsSolvableGroup and IsFinite, IsPosInt],
    0,
    function( grp, p)
        local hom;
        if CanEasilyComputePcgs (grp) then
            TryNextMethod();
        fi;
        hom := IsomorphismPcGroup (grp);
        return List (PSocleSeries (ImagesSource (hom), p),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  PSocleSeriesOp (<G>, <p>)
##
InstallMethod (PSocleSeriesOp,
    "handled by nice monomorphism",
    true,
    [IsGroup and IsHandledByNiceMonomorphism and IsFinite, 
        IsPosInt],
    0,
    function( grp, p )
        local hom;
        hom := NiceMonomorphism (grp);
        return List (PSocleSeries (NiceObject (grp), p),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  PSocleOp (<G>, <p>)
##
RedispatchOnCondition (PSocleOp, true, 
    [IsGroup, IsPosInt], 
    [IsFinite, ], 0);
    

#############################################################################
##
#M  PSocleOp (<G>, <p>)
##
InstallMethod (PSocleOp,
    "last term of PSocleSeriesOp",
    true,
    [IsGroup and IsFinite,
        IsPosInt],
    0,
    function( grp, p )
        local ser;
        ser := PSocleSeries(grp, p);
        return ser[Length(ser)];
    end);


##############################################################################
##
#M  SolvableSocleComponents (<G>) 
##
InstallMethod (SolvableSocleComponents,
    "concatenate PSocleComponents",
    true,
    [IsGroup and IsFinite],
    0,
    function(G)
        local p, res;
        res := [];
        for p in PrimeDivisors (Size(G)) do
            Append (res, PSocleComponents (G, p));
        od;
        return res;
    end);


##############################################################################
##
#M  SolvableSocleComponents (<G>) 
##
InstallMethod (SolvableSocleComponents,
    "handled by nice monomorphism",
    true,
    [IsGroup and IsHandledByNiceMonomorphism and IsFinite],
    0,
    function( grp)
        local hom;
        hom := NiceMonomorphism (grp);
        return List (SolvableSocleComponents (NiceObject (grp)),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  SolvableSocleComponents (<G>) 
##
InstallMethod (SolvableSocleComponents,
    "via IsomorphismPcGroup",
    true,
    [IsGroup and IsSolvableGroup and IsFinite],
    0,
    function( grp)
        local hom;
        if CanEasilyComputePcgs (grp) then
            TryNextMethod();
        fi;
        hom := IsomorphismPcGroup (grp);
        return List (SolvableSocleComponents (ImagesSource (hom)),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  SolvableSocleComponents (<G>) 
##
RedispatchOnCondition (SolvableSocleComponents, true, 
    [IsGroup], 
    [IsFinite], 0);
    

#############################################################################
##
#M  SocleComponents (<G>) 
##
InstallMethod (SocleComponents, 
    "for solvable group", true, 
    [IsGroup and IsSolvableGroup and IsFinite], 0,
    SolvableSocleComponents);
    
    
#############################################################################
##
#M  SocleComponents (<G>) 
##
RedispatchOnCondition (SocleComponents, true, 
    [IsGroup], 
    [IsFinite and IsSolvableGroup], 0);
    
    

#############################################################################
##
#M  SocleComponents (<G>) 
##
InstallMethod (SolvableSocleComponents,
    "via IsomorphismPcGroup",
    true,
    [IsGroup and IsSolvableGroup and IsFinite],
    0,
    function( grp)
        local hom;
        if CanEasilyComputePcgs (grp) then
            TryNextMethod();
        fi;
        hom := IsomorphismPcGroup (grp);
        return List (SocleComponents (ImagesSource (hom)),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  SocleComponents (<G>) 
##
InstallMethod (SocleComponents,
    "handled by nice monomorphism",
    true,
    [IsGroup and IsHandledByNiceMonomorphism and IsFinite],
    0,
    function( grp)
        local hom;
        hom := NiceMonomorphism (grp);
        return List (SocleComponents (NiceObject (grp)),
            L -> PreImagesSet (hom, L));
    end);
    
    
#############################################################################
##
#M  SolvableSocle (<G>) 
##
InstallMethod (SolvableSocle, 
    "for solvable group, product of socle components", true,
    [IsGroup and CanEasilyComputePcgs and IsFinite], 
    0,
    function( G )

        local i, pcgs, pcgssoc, socdepths, L, x, ser, n, S;
        
        if IsTrivial (G) then
            return G;
        fi;
        
        pcgs := ParentPcgs (Pcgs (G));
        
        pcgssoc := [];
        socdepths := [];
        
        for L in SocleComponents (G) do
            for x in Reversed(Pcgs (L)) do
                if not AddPcElementToPcSequence (pcgs, pcgssoc, socdepths, x) then
                    Error ("Internal error in method for `Socle' for soluble groups");
                fi;
            od;
        od;
        pcgssoc := InducedPcgsByPcSequenceNC (pcgs, pcgssoc);
        S := GroupOfPcgs (pcgssoc);
        Assert (1, IsAbelian(S));
        SetIsAbelian (S, true);
        return S;
    end);


#############################################################################
##
#M  SolvableSocle (<G>) 
##
InstallMethod (SolvableSocle, 
    "for finite group, product of socle components", true,
    [IsGroup and IsFinite], 
    0,
    function( G )

        local S, L;
        
        S := TrivialSubgroup (G);
        for L in SolvableSocleComponents (G) do
            S := ClosureGroup (S, L);
        od;
        Assert (1, IsAbelian(S));
        SetIsAbelian (S, true);
        return S;
    end);



#############################################################################
##
#M  SolvableSocle (<G>) 
##
InstallMethod (SolvableSocle,
    "handled by nice monomorphism",
    true,
    [IsGroup and IsHandledByNiceMonomorphism and IsFinite],
    0,
    function( grp )
        return PreImagesSet (NiceMonomorphism (grp), SolvableSocle (NiceObject (grp)));
    end);
    
    
#############################################################################
##
#M  SolvableSocle (<G>) 
##
InstallMethod (SolvableSocle,
    "via IsomorphismPcGroup",
    true,
    [IsGroup and IsSolvableGroup and IsFinite],
    0,
    function( grp )
        local hom;
        if CanEasilyComputePcgs (grp) then
            TryNextMethod();
        fi;
        hom := IsomorphismPcGroup (grp);
        return PreImagesSet (hom, SolvableSocle (ImagesSource (hom)));
    end);
    
    
#############################################################################
##
#M  SolvableSocle (<G>) 
##
RedispatchOnCondition (SolvableSocle, true, 
    [IsGroup], 
    [IsFinite], 0);
    
    
#############################################################################
##
#M  Socle (<G>) 
##
InstallMethod (Socle, "for finite soluble group, via SolvableSocle", true,
    [IsGroup and IsFinite and IsSolvableGroup],
    0,
    SolvableSocle);
    
    
#############################################################################
##
#M  Socle (<G>) 
##
RedispatchOnCondition (Socle, true, 
    [IsGroup],
    [IsFinite and IsSolvableGroup],
    RankFilter (IsGroup and IsFinite and IsSolvableGroup));
    
    
#############################################################################
##
#M  MinimalNormalPSubgroupsOp (<G>, <p>)
##
InstallMethod (MinimalNormalPSubgroupsOp, 
    "for finite group", true,
    [IsGroup and IsFinite, IsPosInt], 
    0,
    function( G, p )

        local P, O, ser, j, res, N;

        if Size(G) mod p <> 0 then
            return [];
        fi;

        P := PCore (G,p);

        if IsTrivial (P) then
            return [];
        fi;

        O := Omega (Center (P),p,1);

        ser := CompositionSeriesUnderAction (G, O);

        res := [ser[Length (ser)-1]];
        for j in [Length (ser)-2, Length (ser)-3..1] do
            Append (res, ComplementsOfCentralSectionUnderActionNC (G, ser[j], ser[j+1], TrivialSubgroup (G), true));
        od;
        for N in res do
            Assert (1, IsElementaryAbelian (N));
            SetIsElementaryAbelian (N, true);
        od;
        return res;
    end);


#############################################################################
##
#M  MinimalNormalPSubgroupsOp (<G>)
##
InstallMethod (MinimalNormalPSubgroupsOp,
    "handled by nice monomorphism",
    true,
    [IsGroup and IsHandledByNiceMonomorphism and IsFinite, IsPosInt],
    0,
    function( grp, p )
        local hom;
        hom := NiceMonomorphism (grp);
        return List (MinimalNormalPSubgroups (NiceObject (grp), p),
        	N -> PreImagesSet (hom, N));
    end);
    
    
#############################################################################
##
#M  MinimalNormalPSubgroupsOp (<G>)
##
InstallMethod (MinimalNormalPSubgroupsOp,
    "handled by IsomorphismPcGroup",
    true,
    [IsGroup and IsSolvableGroup and IsFinite, IsPosInt],
    0,
    function( grp, p )
        local hom;
        if CanEasilyComputePcgs (grp) then
            TryNextMethod();
        fi;
        hom := IsomorphismPcGroup (grp);
        return List (MinimalNormalPSubgroups (ImagesSource (hom), p),
        	N -> PreImagesSet (hom, N));
    end);
    
    
############################################################################
##
#M  AbelianMinimalNormalSubgroups (<G>) 
##

InstallMethod (AbelianMinimalNormalSubgroups, 
	"concatenate MinimalNormalPSubgroups",
    true, [IsGroup and IsFinite], 0,
	function (G)

    local p, norms;

    norms := [];

    for p in PrimeDivisors(Size(G)) do
        Append (norms, MinimalNormalPSubgroups (G, p));
    od;

    return norms;
end);


#############################################################################
##
#M  AbelianMinimalNormalSubgroups (<G>) 
##
RedispatchOnCondition (AbelianMinimalNormalSubgroups, true, 
    [IsGroup], 
    [IsFinite], 0);


#############################################################################
##
#M  MinimalNormalSubgroups (<G>) 
##
InstallMethod (MinimalNormalSubgroups, 
	"for solvable groups: use AbelianMinimalNormalSubgroups",
	true, [IsGroup and IsFinite and IsSolvableGroup], 0,
	AbelianMinimalNormalSubgroups);


#############################################################################
##
#M  MinimalNormalSubgroups (<G>) 
##
RedispatchOnCondition (MinimalNormalSubgroups,
	true, [IsGroup], [IsFinite and IsSolvableGroup],
    RankFilter (IsGroup and IsFinite and IsSolvableGroup));


############################################################################
##
#E
##
