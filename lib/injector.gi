#############################################################################
##
##  injector.gi                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.injector_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  InjectorOp (<grp>, <class>)
##
InstallMethod (InjectorOp, "for generic groups: use radical", true, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingClass], 0,
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return InjectorFromRadicalFunction (G, U -> Radical (U, C), false);
	end);
	

#############################################################################
##
#M  InjectorOp (<grp>, <class>)
##
InstallMethod (InjectorOp, "for pc groups: use radical", true, 
	[IsPcGroup and IsFinite, IsFittingClass], 0,
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return InjectorFromRadicalFunction (G, U -> Radical (U, C), true);
	end);
	

#############################################################################
##
#M  InjectorOp (<grp>, <class>
##
InstallMethod (InjectorOp, "injector function is known", true, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingClass and HasInjectorFunction], 3,  # prefer radical function if known
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return InjectorFunction(C) (G);
	end);


#############################################################################
##
#M  InjectorOp
##
InstallMethod (InjectorOp, "for FittingSetRep without injector function", 
	function (G, C) return IsIdenticalObj (CollectionsFamily (G), C); end, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingSetRep], 0,
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return InjectorFromRadicalFunction (G, U -> Radical (U, C), false);
	end);
	
	
#############################################################################
##
#M  InjectorOp
##
InstallMethod (InjectorOp, "for FittingSetRep without injector function", 
	function (G, C) return IsIdenticalObj (CollectionsFamily (G), C); end, 
	[IsPcGroup and IsFinite, IsFittingSetRep], 0,
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return InjectorFromRadicalFunction (G, U -> Radical (U, C), true);
	end);
	
	
#############################################################################
##
#M  InjectorOp
##
InstallMethod (InjectorOp, "for FittingSetRep if injector function is known", 
	function (G, C) return IsIdenticalObj (CollectionsFamily (G), C); end, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingSetRep and HasInjectorFunction], 3,  # prefer radical function if known
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return InjectorFunction(C) (G);
	end);
	

#############################################################################
##
#M  InjectorOp
##
InstallMethodByNiceMonomorphismForGroupAndClass (InjectorOp, 
	IsFinite and IsSolvableGroup, IsFittingClass);

		
#############################################################################
##
#M  InjectorOp
##
InstallMethod (InjectorOp, "last resort - try if G is finite and soluble", true, 
	[IsGroup, IsClass], 0,
	function (G, F)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return InjectorOp (G, F);
		fi;
		TryNextMethod();
	end);


#############################################################################
##
#F  InjectorFromRadicalFunction (<G>, <radfunc>, <hom>)
##
InstallGlobalFunction (InjectorFromRadicalFunction, 
	function (G, radfunc, hom)
	
		local natQ, I, J, nat, H, N, C, W, i, gens, nilpser;
			
		I := radfunc (G);
		if hom then
			natQ := NaturalHomomorphismByNormalSubgroup (G, I);
			H := Image (natQ);
		else
			H := G;
		fi;
		
		# compute a normal series from I to G with nilpotent factors
		nilpser := [];
		while not IsTrivial (H) do
			Add (nilpser, H);
			H := Residual (H, NilpotentGroups);
		od;
	
		if hom then
			nilpser := Reversed (nilpser);
		else
			nilpser := List (Reversed (nilpser), H -> 
			ClosureGroup (I, H));
		fi;
		
		# treat the nilpotent factors
	
		for i in [2..Length (nilpser)] do
	
			Info (InfoInjector, 1, "starting step ",i-1);
			H := nilpser[i];
	
			# I is an F-injector of H
	
			Info (InfoInjector, 2, "computing normalizer");
	
			if i > 2 then 
				if hom then
					J := ImagesSet (natQ, I);
					nat := NaturalHomomorphismByNormalSubgroup (
						NormalizerOfPronormalSubgroup (H, J), J);
					N := ImagesSource (nat);
				else
					N := NormalizerOfPronormalSubgroup (H, I);
				fi;
			else # otherwise I is trivial
				N := H;
			fi;
			
			Info (InfoInjector, 3, " normalizer has order ", 
				Size (N));
	
			Info (InfoInjector, 2, "computing Carter subgroup");
			C := NilpotentProjector (N);
			Info (InfoInjector, 3, " carter subgoroup has order ", 
				Size (C));
	
			if hom then
				if i > 2 then
					W := PreImagesSet (nat, C);
				else 
					W := C;
				fi;
				W := PreImagesSet (natQ, W);
			else
				W := ClosureGroup (I, C);
			fi;
			Info (InfoInjector, 3, " preimage of carter subgoroup has order ", 
				Size (W));
			
			Info (InfoInjector, 2, " computing radical");
	
			# the radical has to be computed in the full group
			I := radfunc (W);
			Info (InfoInjector, 3, " injector has order ", Size (I));
		od;
		return I;
	end);

	
############################################################################
##
#E
##
