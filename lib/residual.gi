#############################################################################
##
##  residuals.gi                     CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.residuals_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  NormalSubgroups
##
InstallMethod (NormalSubgroups, 
	"normal complement method for groups which can compute pcgs",
	true,
	[IsGroup and IsFinite and CanEasilyComputePcgs], 
	RankFilter (IsPcGroup), #use for pc groups as well
	function (G) 
		return AllNormalSubgroupsWithQProperty (G, 
			ReturnTrue, ReturnTrue, rec());
	end);


#############################################################################
##
#M  NormalSubgroups
##
InstallMethod (NormalSubgroups, 
	"normal complement method for soluble perm groups",
	true,
	[IsPermGroup and IsFinite and IsSolvableGroup], 2, 
	function (G) 
		return AllNormalSubgroupsWithQProperty (G, 
			ReturnFail, ReturnTrue, rec());
	end);


#############################################################################
##
#M  NormalSubgroups
##
InstallMethod (NormalSubgroups, 
	"try if the group is solvable",
	true,
	[IsGroup and IsFinite], 0, 
	function (G) 
		if not HasIsSolvableGroup (G) and IsSolvableGroup (G) then
			return AllNormalSubgroupsWithQProperty (G, 
				ReturnFail, ReturnTrue, rec());
		else
			TryNextMethod();
		fi;
	end);


#############################################################################
##
#M  NormalSubgroups
##
InstallMethod (NormalSubgroups, 
	"try if the group is finite",
	true,
	[IsGroup], 0, 
	function (G) 
		if not HasIsFinite (G) and IsFinite (G) then
			return AllNormalSubgroupsWithQProperty (G, 
				ReturnFail, ReturnTrue, rec());
		else
			TryNextMethod();
		fi;
	end);


#############################################################################
##
#M  AllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>)
##
InstallMethod (AllNormalSubgroupsWithQProperty, 
	"for solvable groups",
	true,
	[IsGroup and IsSolvableGroup and IsFinite, IsFunction, IsFunction, IsObject], 
	RankFilter (IsPcGroup), 
	function (G, pretest, test, data)

		local i, norms, ser, gens, new, N, cmpl, res, testser;
		
		norms := [G];
		testser := true;
		
		ser := ChiefSeries (G);
		gens := SmallGeneratingSet (G);
			
		for i in [3..Length (ser)] do
			new := [];
			for N in norms do
				res := pretest (ser[i-1], ser[i], N, data);
				if res <> false then
					cmpl := NormalComplementsOfElAbSectionUnderAction (
						gens, N, ser[i-1], ser[i], true);
					if res = true then
						Append (new, cmpl);
					else
						Append (new, Filtered (cmpl, C -> test (C, N, data)));
					fi;
				fi;
			od;
			
			Append (norms, new);
			
			if testser then # ser[i-2] has passed the test
				res := pretest (ser[i-2], ser[i-1], ser[i-2], data);
				if res = fail then
					res := test (ser[i-1], ser[i-2], data);
				fi;
				if res then
					Add (norms, ser[i-1]);
				else
					testser := false;
				fi;
			fi;
			Info (InfoLattice, 1, "Step ",i,", ",Length (norms)," normal subgroups");
		od;
			
		if testser then # ser[i-2] has passed the test
			res := pretest (ser[Length (ser)-1], 
				ser[Length (ser)], ser[Length (ser)], data);
			if res = fail then
				res := test (ser[Length (ser)], ser[Length (ser)-1], data);
			fi;
			if res then
				Add (norms, ser[Length (ser)]);
			fi;
		fi;
		return norms;
	end);


#############################################################################
##
#M  AllNormalSubgroupsWithQProperty
##
InstallMethod (AllNormalSubgroupsWithQProperty, 
	"test if group is finite and solvable", true, 
	[IsGroup, IsFunction, IsFunction, IsObject], 
	0,
	function( G, pretest, test, data)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return AllNormalSubgroupsWithQProperty ( G, pretest, test, data);
		fi;
		TryNextMethod();
	end);
	
	
#############################################################################
##
#F  PcgsAllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>,
##   	hom, conv)
##
##  similar to AllNormalSubgroupsWithQProperty, but working with a pcgs,
##  and returning the pcgs of all normal subgroups. Also the chief factor
##  used in <pretest> is a modulo pcgs.
##
InstallGlobalFunction ("PcgsAllNormalSubgroupsWithQProperty",
	function (pcgs, pretest, test, data,
		hom, conv)

	local ppcgs, inds, grp, opcgs, fac, i, j, elabpcgs, ser, mpcgs, npcgs,
		norms, N, cmpl, new, res;
	
	inds := IndicesElementaryAbelianSteps (pcgs);
	if inds = fail then
		Error ("pcgs must refine an elementary abelian series");
	fi;
	
	
	if conv or hom then
		grp := PcGroupWithPcgs (pcgs);
	else
		grp := GroupOfPcgs (pcgs);
	fi;
	
	if hom then
		fac := [];
		fac[Length (inds)] := grp;
		for j in [Length(inds)-1, Length (inds)-2..2] do
			ppcgs := FamilyPcgs (fac[j+1]);
			fac[j] := PcGroupWithPcgs (
				ppcgs mod InducedPcgsByPcSequenceNC (ppcgs, ppcgs{[inds[j]..Length (ppcgs)]}));
		od;
	else
		if conv then
			ppcgs := FamilyPcgs (grp);
		else
			ppcgs := pcgs;
		fi;
		elabpcgs := List (inds, 
			i -> InducedPcgsByPcSequenceNC (pcgs, pcgs{[i, i+1..Length (pcgs)]}));
		ppcgs := pcgs;
	fi;

	norms := [ppcgs];

	# treat the layers of the elementary abelian series
	for j in [1,2..Length (inds) - 1] do
		Info(InfoProjector, 1, "starting step ",j, " of ",Length (inds) - 1);
			
		if hom then
			grp := fac[j+1];
			ppcgs := FamilyPcgs (grp);
			mpcgs := InducedPcgsByPcSequenceNC (ppcgs, ppcgs{[inds[j]..Length (ppcgs)]});
			if j = 1 then
				norms := [ppcgs];
			else
				opcgs := FamilyPcgs (fac[j]);
				norms  := List (norms, upcgs ->
					InducedPcgsByPcSequenceNC (ppcgs,
						Concatenation ( List (upcgs, x -> 
							PcElementByExponentsNC (ppcgs, [1..inds[j]-1], 
							ExponentsOfPcElement (opcgs, x))),
							mpcgs)));
			fi;
		else
			mpcgs := elabpcgs[j] mod elabpcgs[j+1];
		fi;
		
		ser := PcgsChiefSeriesElAbModuloPcgsUnderAction (
			ppcgs{[1..inds[j]-1]}, mpcgs);
					
		for i in [1..Length (ser) - 1] do
			npcgs := ser[i] mod ser[i+1];
			
			new := [];
			for N in norms do
				res := pretest (ser[i], ser[i+1], N, data);
				if res <> false then
					cmpl := PcgsNormalComplementsOfElAbModuloPcgsUnderAction (
						ppcgs{[1..inds[j+1]-1]}, 
						ppcgs, N mod ser[i], 
						npcgs, ser[i+1], true);
					if res = true then
						Append (new, cmpl);
					else
						Append (new, Filtered (cmpl, C -> test (C, N, data)));
					fi;
				fi;
			od;
			
			Append (norms, new);

		od;
	od;
	
	if hom or conv then # translate result back to previous pcgs
		norms := List (norms, upcgs -> InducedPcgsByPcSequenceNC (pcgs,
			List (upcgs, x -> 
				PcElementByExponentsNC (pcgs, 
					ExponentsOfPcElement (ppcgs, x)))));
	fi;
	return norms;
end);

		
#############################################################################
##
#M  OneNormalSubgroupMinWrtQProperty (<grp>, <pretest>, <test>, <data>)
##
InstallMethod (OneNormalSubgroupMinWrtQProperty, 
	"for solvable groups",
	true,
	[IsGroup and IsSolvableGroup and IsFinite, IsFunction, IsFunction, IsObject], 
	0, 
	function (G, pretest, test, data)

		local i, k, M, ser, gens, new, N, cmpl, res, R;

		if IsTrivial (G) then
			return [G];
		fi;
		
		ser := ChiefSeries (G);

		for k in [2..Length (ser)] do
			res := pretest (ser[k-1], ser[k], ser[k-1], data);
			if res = fail then
				res := test (ser[k], ser[k-1], data);
			fi;
			if not res then
				break;
			fi;
		od;
		if res then
			return TrivialSubgroup (G);
		fi;
		
		M := ser[k-1];
		
		gens := SmallGeneratingSet (G);
			
		for i in [k..Length (ser)-1] do
			res := pretest (ser[i], ser[i+1], M, data);
			if res <> false then
				cmpl := NormalComplementsOfElAbSectionUnderAction (
					gens, M, ser[i], ser[i+1], res <> true);
				if res = true then
					if cmpl <> fail then
						M := cmpl;
					fi;
				else
					for R in cmpl do
						if test (R, M, data) then
							M := R;
							break;
						fi;
					od;
				fi;
			fi;
			Info (InfoLattice, 1, "Step ",i,"done");
		od;
					
		return M;
	end);


#############################################################################
##
#M  OneNormalSubgroupMinWrtQProperty
##
InstallMethod (OneNormalSubgroupMinWrtQProperty, 
	"test if group is finite and solvable", true, 
	[IsGroup, IsFunction, IsFunction, IsObject], 
	0,
	function( G, pretest, test, data)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return OneNormalSubgroupMinWrtQProperty ( G, pretest, test, data);
		fi;
		TryNextMethod();
	end);
	
	
#############################################################################
##
#M  ResidualOp
##
InstallMethod (ResidualOp, "for formation with ResidualFunction", true, 
	[IsGroup, IsOrdinaryFormation and HasResidualFunction], 
		RankFilter (IsPcGroup and IsFinite and IsPermGroup
			and IsSaturatedFittingFormation),
	function (G, C)
 	return ResidualFunction(C) (G);
 end);


#############################################################################
##
#M  ResidualOp
##
InstallMethod (ResidualOp, "for pc group and intersection which is a formation", true, 
	[IsGroup, IsOrdinaryFormation and IsClassByIntersectionRep], 
	function (G, C)
		local D, R;
		R := TrivialSubgroup (G);
		for D in C!.intersected do
			R := ClosureGroup (R, Residual (G, C));
		od;
 		return R;
	end);


#############################################################################
##
#M  ResidualOp
##
InstallMethod (ResidualOp, " use OneNormalSubgroupMinWrtQProperty", true, 
	[IsGroup and IsFinite and IsSolvableGroup, IsOrdinaryFormation], 0,
	function (G, C)
 		return OneNormalSubgroupMinWrtQProperty (G, 
 			ReturnFail,
 			function (R, S, data)
 				return data.grp/R in data.class;
 			end,
 			rec (grp := G, class := C));
	end);


#############################################################################
##
#M  ResidualOp
##
InstallMethod (ResidualOp, " use OneNormalSubgroupMinWrtQProperty", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSaturatedFormation and HasLocalDefinitionFunction], 
	0,
	function (G, C)
 		return OneNormalSubgroupMinWrtQProperty (G, 
 			function (U, V, R, data)
 				local mpcgs, p, pos;
 				mpcgs := ModuloPcgs (U, V);
 				p := RelativeOrders (mpcgs)[1];
 				if p in Characteristic (data.class) then
 					pos := PositionSorted (data.primes, p);
 					if pos > Length (data.primes) or data.primes[pos] <> p then
 						data.locgens{[pos+1..Length (data.primes)+1]} := 
 							data.locgens{[pos..Length (data.primes)]};
 						data.primes{[pos+1..Length (data.primes)+1]} := 
 							data.primes{[pos..Length (data.primes)]};
 						data.primes[pos] := p;
 						data.locgens[pos] := LocalDefinitionFunction (data.class)(data.grp, p);
 					fi;
 					return CentralizesLayer (data.locgens[pos], mpcgs);
 				else
 					return false;
 				fi;
 			end,
 			ReturnFail, # this produces an error message if accidently called
 			rec (grp := G, class := C, primes := [], locgens := []));
	end);


#############################################################################
##
#M  ResidualOp
##
InstallMethodByNiceMonomorphismForGroupAndClass (ResidualOp, 
	IsFinite and IsSolvableGroup, IsOrdinaryFormation);
	
	
#############################################################################
##
#M  ResidualOp
##
InstallMethod (ResidualOp, "last resort - try if G is finite and soluble", true, 
	[IsGroup, IsGroupClass], 0,
	function (G, F)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return ResidualOp (G, F);
		fi;
		TryNextMethod();
	end);
	
	
############################################################################
##
#E
##

