#############################################################################
##
##  projector.gi                     CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.projector_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  CoveringSubgroupOp
##
InstallMethod (CoveringSubgroupOp, "for Schunck classes: return projector",
	true, 
	[IsGroup, IsSchunckClass], 0,
	function (G, C)
 	return Projector (G, C);
 end);


#############################################################################
##
#M  ProjectorOp
##
InstallMethod (ProjectorOp, "if ProjectorFunction is known", true, 
	[IsGroup, IsSchunckClass and HasProjectorFunction], 
		RankFilter (IsPcGroup and IsFinite and IsSaturatedFormation 
			and HasCharacteristic and HasBoundaryFunction),
	function (G, C)
 	return ProjectorFunction(C) (G);
 end);


#############################################################################
##
#M  ProjectorOp
##
InstallMethod (ProjectorOp, "compute from LocalDefinitionFunction", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSaturatedFormation and HasCharacteristic and HasLocalDefinitionFunction], 
	RankFilter (HasBoundaryFunction),
	function (G, C)
		return ProjectorFromExtendedBoundaryFunction (
			G, 
			rec (
				dfunc := DFUNC_FROM_CHARACTERISTIC (C),
				cfunc := CFUNC_FROM_CHARACTERISTIC (C),
				ncfunc := NCFUNC_FROM_LOCAL_DEFINITION (C)),				
	    	false); # we want a projector, not a membership test
	end);


#############################################################################
##
#M  ProjectorOp
##
InstallMethod (ProjectorOp, "compute from boundary", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSchunckClass and HasBoundaryFunction], 
	0,
	function (G, C)
		return ProjectorFromExtendedBoundaryFunction (
			G, 
			rec (
				cfunc := CFUNC_FROM_CHARACTERISTIC_SCHUNCK (C),
				bfunc := BFUNC_FROM_TEST_FUNC (C, BoundaryFunction (C))),
	    	false); # we want a projector, not a membership test
	end);


#############################################################################
##
#M  ProjectorOp
##
InstallMethod (ProjectorOp, "compute from MemberFunction", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSchunckClass and HasMemberFunction], 
	0,
	function (G, C)
		return ProjectorFromExtendedBoundaryFunction (
			G, 
			rec (
				cfunc := CFUNC_FROM_CHARACTERISTIC_SCHUNCK (C),
				bfunc := BFUNC_FROM_TEST_FUNC (C, H -> not MemberFunction (C)(H))),
	    	false); # we want a projector, not a membership test
	end);


#############################################################################
##
#M  ProjectorOp
##
InstallMethodByNiceMonomorphismForGroupAndClass (ProjectorOp, 
	IsFinite and IsSolvableGroup, IsSchunckClass);
	
	
#############################################################################
##
#M  ProjectorOp
##
InstallMethod (ProjectorOp, "try if group is finite and solvable", true, 
	[IsGroup, IsSchunckClass], 
	0,
	function (G, C)
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return ProjectorOp (G, C);
		else
			TryNextMethod();
		fi;
	end);


###################################################################################
##
#F  BFUNC_FROM_TEST_FUNC
##
InstallGlobalFunction(BFUNC_FROM_TEST_FUNC, function (C, test)
	return function (upcgs, cpcgs, ncpcgs, npcgs, kpcgs, p, centind, data)
				local H, cent, x, nat, F;
			
				H := GroupOfPcgs (upcgs);
				if Length (cpcgs) > 0 then
					cent := GroupOfPcgs (cpcgs);
					for x in npcgs do
						cent := CentralizerModulo (cent, 
							GroupOfPcgs (kpcgs), 
							x);
					od;
					nat := NaturalHomomorphismByNormalSubgroupNC (H, cent);
					F := ImagesSource (nat);
					SetIsPrimitiveSolvable (F, true);
					SetSocle (F, SubgroupNC (F, ImagesSet (nat, npcgs)));
					SetSocleComplement (F, SubgroupNC (F, ImagesSet (nat, ncpcgs)));
					return test (F);
				else
					SetIsPrimitiveSolvable (H, true);
					SetSocle (H, SubgroupNC (H, npcgs));
					SetSocleComplement (H, TrivialSubgroup (H));
					return test (H);
				fi;
			end;
	end);


###################################################################################
##
#F  NCFUNC_FROM_LOCAL_DEFINITION
##
InstallGlobalFunction (NCFUNC_FROM_LOCAL_DEFINITION, function (C)
	return function (upcgs, ncpcgs, npcgs, kpcgs, p, cent, data)
				local res;
				res := LocalDefinitionFunction (C)(GroupOfPcgs (upcgs), p);
				if res = fail then 
					return true; # empty local formation
				elif IsGroup (res) then
					res := GeneratorsOfGroup (res);
				fi;
				return not CentralizesLayer (res, npcgs);
			end;
	end);
	

###################################################################################
##
#F  DFUNC_FROM_CHARACTERISTIC
##
##  this only works if groups in C only have prime divisors in the characteristic
##
InstallGlobalFunction (DFUNC_FROM_CHARACTERISTIC, function (C)
	return function (upcgs, npcgs, kpcgs, p, data) 
				if p in Characteristic (C) then
					return fail;
				else 
					return true; 
				fi;
			end;
	end);


###################################################################################
##
#F  CFUNC_FROM_CHARACTERISTIC
##
InstallGlobalFunction (CFUNC_FROM_CHARACTERISTIC, function (C)
	return function (upcgs, npcgs, kpcgs, p, centind, data) 
				if centind = 1 then
					return false; # the primitive group is cyclic of order p
				else
					return fail;
				fi;
			end;
	end);


###################################################################################
##
#F  CFUNC_FROM_CHARACTERISTIC_SCHUNCK
##
InstallGlobalFunction (CFUNC_FROM_CHARACTERISTIC_SCHUNCK, function (C)
	return function (upcgs, npcgs, kpcgs, p, centind, data) 
				if centind = 1 and p in Characteristic (C) then
					return false; # the primitive group is cyclic of order p
				else
					return fail;
				fi;
			end;
	end);


###################################################################################
##
#M  ProjectorFromExtendedBoundaryFunction (
##	   <grp>, <rec>, <inonly>) 
##
##  method for pc groups
##
InstallMethod (ProjectorFromExtendedBoundaryFunction, "for pc group",
	[IsPcGroup and IsFinite, IsRecord, IsBool], 0,
	function (grp, r, inonly)
		local pcgs, res;

		if not IsBound (r.dfunc) then
			r.dfunc := ReturnFail;
		fi;
		if not IsBound (r.cfunc) then
			r.cfunc := ReturnFail;
		fi;
		if not IsBound (r.ncfunc) then
			r.ncfunc := ReturnFail;
		fi;
		if not IsBound (r.bfunc) then
			r.bfunc := ReturnFail;
		fi;
		if not IsBound (r.data) then
			r.data := rec();
		fi;

		pcgs := PcgsElementaryAbelianSeries (grp);
		res := PROJECTOR_FROM_BOUNDARY (
			pcgs, r.dfunc, r.cfunc, r.ncfunc, r.bfunc, r.data, inonly, true, true);
		if inonly then
			return res;
		else
			return GroupOfPcgs (res);
		fi;
	end);
	
	
###################################################################################
##
#M  ProjectorFromExtendedBoundaryFunction (
##	   <grp>, <rec>, <inonly>) 
##
InstallMethod (ProjectorFromExtendedBoundaryFunction, "for solvable groups",
	[IsGroup and IsFinite and IsSolvableGroup, IsRecord, IsBool], 0,
	function (grp, r, inonly)
		local pcgs, res;
		if not IsBound (r.dfunc) then
			r.dfunc := ReturnFail;
		fi;
		if not IsBound (r.cfunc) then
			r.cfunc := ReturnFail;
		fi;
		if not IsBound (r.ncfunc) then
			r.ncfunc := ReturnFail;
		fi;
		if not IsBound (r.bfunc) then
			r.bfunc := ReturnFail;
		fi;
		if not IsBound (r.data) then
			r.data := rec();
		fi;

		pcgs := PcgsElementaryAbelianSeries (grp);
		res := PROJECTOR_FROM_BOUNDARY (
			pcgs, r.dfunc, r.cfunc, r.ncfunc, r.bfunc, r.data, inonly, false, false);
		if inonly then
			return res;
		else
			return GroupOfPcgs (res);
		fi;
	end);
	
	
###################################################################################
##
#M  ProjectorFromExtendedBoundaryFunction (
##	   <grp>, <rec>, <inonly>) 
##
InstallMethod (ProjectorFromExtendedBoundaryFunction, "last resort - try if it is finite soluble",
	[IsGroup, IsRecord, IsBool], 
	0,
	function (G, r, inonly)
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return ProjectorFromExtendedBoundaryFunction (
					G, r, inonly);
		else
			TryNextMethod();
		fi;
	end);	
	

###################################################################################
##
#F  PROJECTOR_FROM_BOUNDARY_2 (
##	   <gpcgs>, <dfunc>, <cfunc>, <ncfunc>, <bfunc>, <data>, 
##     <inonly>, <hom>, <conv>)
##
InstallGlobalFunction ("PROJECTOR_FROM_BOUNDARY_2", 
	function (pcgs, dfunc, cfunc, ncfunc, bfunc, data, inonly, hom, conv)

	local 
		ppcgs,      # pcgs wrt to which all computations are carried out
		grp,		# group in which all computations are carried out
		opcgs,      # image of ppcgs
		elabpcgs,   # elementary abelian series derived from pcgs
		fac,        # images mod el. ab. series
		inds,       # indices of pcgs exhibiting an elementary abelian series
		upcgs,      # pcgs of a projector
		userinds,   # indices of an el. ab. series of upcgs,
		            # as obtained by intersecting with elabpcgs
		nextstep,   # composition length of last step of 
		            # el ab series of upcgs mod elabpcgs[i+1]
		userp,      # prime expoents of el ab series of upcgs
		i, j,       # loop variables
		mpcgs,      # modulo pcgs representing a factor of the series in elabpcgs
		ser,        # upcgs-composition series of mpcgs
		npcgs,      # modulo pcgs representing a composition factor of ser
		centind,    # all elements of upcgs {[centind..Length(upcgs)]} centralise npcgs
		centpcgs,   # upcgs {[centind..Length(upcgs)]}
		p,		    # exponent of mpcgs and npcgs
 		cpcgs,      # pcgs of a complement of npcgs in upcgs
 		ncpcgs,     # pcgs of a normal complement of npcgs in a suitable normal subgroup
 		            # of upcgs
 		frec,       # factorization information wrt ncpcgs*npcgs
 		id,         # a suitable identity matrix
 		res;        # result returned by the boundary function, or false if no complement
 		 	
		
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
		upcgs := pcgs; # set up the projector
		ppcgs := pcgs;
	fi;
	userinds := [1];
	userp := [];
	
	# treat the layers of the elementary abelian series
	for j in [1,2..Length (inds) - 1] do
		Info(InfoProjector, 1, "starting step ",j, " of ",Length (inds) - 1);
			
		if hom then
			grp := fac[j+1];
			ppcgs := FamilyPcgs (grp);
			mpcgs := InducedPcgsByPcSequenceNC (ppcgs, ppcgs{[inds[j]..Length (ppcgs)]});
			if j = 1 then
				upcgs := ppcgs;
			else
				opcgs := FamilyPcgs (fac[j]);
				upcgs := InducedPcgsByPcSequenceNC (ppcgs,
					Concatenation ( List (upcgs, x -> 
						PcElementByExponentsNC (ppcgs, [1..inds[j]-1], ExponentsOfPcElement (opcgs, x))),
						mpcgs));
			fi;
		else
			mpcgs := elabpcgs[j] mod elabpcgs[j+1];
		fi;
		
		p := RelativeOrderOfPcElement (ppcgs, mpcgs[1]);
		
		ser := PcgsChiefSeriesElAbModuloPcgsUnderAction (
			upcgs{[1..userinds[Length(userinds)]-1]}, mpcgs);
			
		Info(InfoProjector, 2, Length (ser)-1, " composition factors");
		nextstep := 0;
		
		for i in [1..Length (ser) - 1] do
			npcgs := ser[i] mod ser[i+1];
			
			res := dfunc (upcgs, npcgs, ser[i+1], p, data);
			if inonly and res = true then
				return false;
			fi;
			
			Info (InfoProjector, 3, "dfunc returns ", res);
			
			if res <> false then
				Info(InfoProjector, 2, "complementing factor of size ",p,"^",Length (npcgs));
				centind := Length (userinds);
				
				# find the largest term in an el. ab. series of upcgs centralising npcgs
				
				while centind > 1 and 
					(p = userp[centind-1] or 
						CentralizesLayer (upcgs{[userinds[centind-1]..userinds[centind]-1]}, npcgs)) do
							centind := centind - 1;
				od;
								
				Info (InfoProjector, 3, "centralizing level: ",userinds[centind]);
				
				centpcgs := InducedPcgsByPcSequenceNC (ppcgs, 
							upcgs{[userinds[centind]..Length (upcgs)]});
				
				if res = fail then
					res := cfunc (upcgs, npcgs, ser[i+1], p, userinds[centind], data);
					if inonly and res = true then
						return false;
					fi;
				fi;
				
				Info (InfoProjector, 3, "cfunc returns ", res);
		
				# now find normal complement of npcgs in upcgs{[userinds[centind]..Length (upcgs)]})
				
#				if centind = Length (userinds) and nextstep = 0 then # nothing to complement
#					ncpcgs := ser[i+1];
#					Info(InfoProjector, 3, "trivial normal complement");
#				elif 
				if res <> false then # only complement if we have to
					frec := ExtendedPcgsComplementsOfCentralModuloPcgsUnderAction (
						List (upcgs{[1,2..userinds[centind]-1]}, 
							x -> InnerAutomorphismNC (grp, x)), 
						ppcgs, centpcgs mod ser[i], npcgs, ser[i+1], false);
					if frec.nrSolutions = 0 then
						ncpcgs := fail;
						if not p in userp then
							Error ("coprime situation but no complement");
						fi;
						Info(InfoProjector, 3, "no normal complement found");
					else
						Info(InfoProjector, 3, Length (ncpcgs)," normal complement(s) found");
						ncpcgs := frec.solutionFunction(frec, 1);
						Assert (1, IsSubgroup (GroupOfPcgs (ncpcgs), GroupOfPcgs (ser[i+1])),
							Error (" complement is not a subgroup"));
						Assert (1, GroupOfPcgs (SumPcgs (ppcgs, ncpcgs, ser[i]))
							= GroupOfPcgs (InducedPcgsByPcSequenceNC (ppcgs, 
								upcgs{[userinds[centind]..Length (upcgs)]})),
							Error ("wrong join for normal complement"));
						Assert (1, GroupOfPcgs (NormalIntersectionPcgs (ppcgs, ncpcgs, ser[i]))
							= GroupOfPcgs (ser[i+1]),
							Error ("wrong intersection for normal complement"));
						
					fi;
				fi;

				# now find a complement of npcgs in upcgs
				
				if res <> false and not IsBool (ncpcgs) then
					if res = fail then
						res := ncfunc (upcgs, ncpcgs, npcgs, ser[i+1], p, 
							userinds[centind], data);
						Info (InfoProjector, 3, "ncfunc returns ", res);
						if inonly and res = true then
							return false;
						fi;
					fi;
					
					if res <> false then
						if centind = 1 then # npcgs is central, so ncpcgs is a complement
							cpcgs := ncpcgs;
							Info(InfoProjector, 3, "central socle");
						else
							Assert (1, userp[centind-1] <> p, Error ("wrong prime ", p));
							Info(InfoProjector, 3, "noncentral socle - computing complement");
							cpcgs := PcgsComplementOfChiefFactor2 (ppcgs,
								upcgs{[1..userinds[centind]-1]}, 
									userinds[centind-1], 
									npcgs, 
									ncpcgs,
									frec);
						fi;
					fi;
	
					if res = fail then
						Info (InfoProjector, 3, "testing group of size ", 
							Product (RelativeOrders(upcgs)) / 
							Product (RelativeOrders (ser[i+1])),
							" size of socle: ",
							Product (RelativeOrders (npcgs)),
							" size of complement: ",
							Product (RelativeOrders(cpcgs)) / 
							Product (RelativeOrders (ser[i+1])));
						Assert (1, Length (npcgs) + Length (cpcgs) = Length (upcgs),
							Error("cpcgs does not complement"));
						res := bfunc (upcgs, cpcgs, ncpcgs, npcgs, p, ser[i+1], 
							userinds[centind], data);
						if inonly and res = true then
							return false;
						fi;
						Info (InfoProjector, 3, "bfunc returns ", res);
					fi;
				else
					res := false; # there is no complement, the projector remains unchanged
				fi;
			fi;
			
			if res then # in boundary
				upcgs := cpcgs;
			else
				nextstep := nextstep + Length (npcgs);
			fi;
		od;
		if nextstep > 0 then
			Add (userp, p);
			Add (userinds, userinds[Length (userinds)]+nextstep);
		fi;
	od;
	if inonly then
		return true;
	fi;
	
	if hom or conv then # translate result back to previous pcgs
		upcgs := InducedPcgsByPcSequenceNC (pcgs,
			List (upcgs, x -> 
				PcElementByExponentsNC (pcgs, ExponentsOfPcElement (ppcgs, x))));
	fi;
	return upcgs;
end);


###################################################################################
##
#F  PROJECTOR_FROM_BOUNDARY (
##	   <gpcgs>, <dfunc>, <cfunc>, <ncfunc>, <bfunc>, <data>, 
##     <inonly>, <hom>, <conv>)
##
InstallGlobalFunction ("PROJECTOR_FROM_BOUNDARY", 
	function (pcgs, dfunc, cfunc, ncfunc, bfunc, data, inonly, hom, conv)

	local 
		ppcgs,      # pcgs wrt to which all computations are carried out
		grp,		# group in which all computations are carried out
		opcgs,      # image of ppcgs
		elabpcgs,   # elementary abelian series derived from pcgs
		fac,        # images mod el. ab. series
		inds,       # indices of pcgs exhibiting an elementary abelian series
		upcgs,      # pcgs of a projector
		userinds,   # indices of an el. ab. series of upcgs,
		            # as obtained by intersecting with elabpcgs
		nextstep,   # composition length of last step of 
		            # el ab series of upcgs mod elabpcgs[i+1]
		userp,      # prime expoents of el ab series of upcgs
		i, j,       # loop variables
		mpcgs,      # modulo pcgs representing a factor of the series in elabpcgs
		ser,        # upcgs-composition series of mpcgs
		npcgs,      # modulo pcgs representing a composition factor of ser
		centind,    # all elements of upcgs {[centind..Length(upcgs)]} centralise npcgs
		centpcgs,   # upcgs {[centind..Length(upcgs)]}
		p,		    # exponent of mpcgs and npcgs
 		cpcgs,      # pcgs of a complement of npcgs in upcgs
 		ncpcgs,     # pcgs of a normal complement of npcgs in a suitable normal subgroup
 		            # of upcgs
 		id,         # a suitable identity matrix
 		res;        # result returned by the boundary function, or false if no complement
 		 	
		
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
		upcgs := pcgs; # set up the projector
		ppcgs := pcgs;
	fi;
	userinds := [1];
	userp := [];
	
	# treat the layers of the elementary abelian series
	for j in [1,2..Length (inds) - 1] do
		Info(InfoProjector, 1, "starting step ",j, " of ",Length (inds) - 1);
			
		if hom then
			grp := fac[j+1];
			ppcgs := FamilyPcgs (grp);
			mpcgs := InducedPcgsByPcSequenceNC (ppcgs, ppcgs{[inds[j]..Length (ppcgs)]});
			if j = 1 then
				upcgs := ppcgs;
			else
				opcgs := FamilyPcgs (fac[j]);
				upcgs := InducedPcgsByPcSequenceNC (ppcgs,
					Concatenation ( List (upcgs, x -> 
						PcElementByExponentsNC (ppcgs, [1..inds[j]-1], ExponentsOfPcElement (opcgs, x))),
						mpcgs));
			fi;
		else
			mpcgs := elabpcgs[j] mod elabpcgs[j+1];
		fi;
		
		p := RelativeOrderOfPcElement (ppcgs, mpcgs[1]);
		
		ser := PcgsChiefSeriesElAbModuloPcgsUnderAction (
			upcgs{[1,2..userinds[Length(userinds)]-1]}, mpcgs);
			
		Info(InfoProjector, 2, Length (ser)-1, " composition factors");
		nextstep := 0;
		
		for i in [1..Length (ser) - 1] do
			npcgs := ser[i] mod ser[i+1];
			
			res := dfunc (upcgs, npcgs, ser[i+1], p, data);
			if inonly and res = true then
				return false;
			fi;
			
			Info (InfoProjector, 3, "dfunc returns ", res);
			
			if res <> false then
				Info(InfoProjector, 2, "complementing factor of size ",p,"^",Length (npcgs));
				centind := Length (userinds);
				
				# find the largest term in an el. ab. series of upcgs centralising npcgs
				
				while centind > 1 and 
					(p = userp[centind-1] or 
						CentralizesLayer (upcgs{[userinds[centind-1]..userinds[centind]-1]}, npcgs)) do
							centind := centind - 1;
				od;
								
				Info (InfoProjector, 3, "centralizing level: ",userinds[centind]);
				
				centpcgs := InducedPcgsByPcSequenceNC (ppcgs, 
							upcgs{[userinds[centind]..Length (upcgs)]});
				
				if res = fail then
					res := cfunc (upcgs, npcgs, ser[i+1], p, userinds[centind], data);
					if inonly and res = true then
						return false;
					fi;
				fi;
				
				Info (InfoProjector, 3, "cfunc returns ", res);
		
				# now find normal complement of npcgs in upcgs{[userinds[centind]..Length (upcgs)]})
				
				if centind = Length (userinds) and nextstep = 0 then # nothing to complement
					ncpcgs := ser[i+1];
					Info(InfoProjector, 3, "trivial normal complement");
				elif res <> false then # only complement if we have to
					ncpcgs := PcgsComplementsOfCentralModuloPcgsUnderActionNC (
						List (upcgs{[1,2..userinds[centind]-1]}, 
							x -> InnerAutomorphismNC (grp, x)), 
						ppcgs, centpcgs mod ser[i], npcgs, ser[i+1], false);
					if Length (ncpcgs) = 0 then
						ncpcgs := fail;
						if not p in userp then
							Error ("coprime situation but no complement");
						fi;
						Info(InfoProjector, 3, "no normal complement found");
					else
						Info(InfoProjector, 3, Length (ncpcgs)," normal complement(s) found");
						ncpcgs := ncpcgs[1];
						Assert (1, IsSubgroup (GroupOfPcgs (ncpcgs), GroupOfPcgs (ser[i+1])),
							Error (" complement is not a subgroup"));
						Assert (1, GroupOfPcgs (SumPcgs (ppcgs, ncpcgs, ser[i]))
							= GroupOfPcgs (InducedPcgsByPcSequenceNC (ppcgs, 
								upcgs{[userinds[centind]..Length (upcgs)]})),
							Error ("wrong join for normal complement"));
						Assert (1, GroupOfPcgs (NormalIntersectionPcgs (ppcgs, ncpcgs, ser[i]))
							= GroupOfPcgs (ser[i+1]),
							Error ("wrong intersection for normal complement"));
						
					fi;
				fi;

				# now find a complement of npcgs in upcgs
				
				if res <> false and not IsBool (ncpcgs) then
					if res = fail then
						res := ncfunc (upcgs, ncpcgs, npcgs, ser[i+1], p, 
							userinds[centind], data);
						Info (InfoProjector, 3, "ncfunc returns ", res);
						if inonly and res = true then
							return false;
						fi;
					fi;
					
					if res <> false then
						if centind = 1 then # npcgs is central, so ncpcgs is a complement
							cpcgs := ncpcgs;
							Info(InfoProjector, 3, "central socle");
						else
							Assert (1, userp[centind-1] <> p, Error ("wrong prime ", p));
							Info(InfoProjector, 3, "noncentral socle - computing complement");
							cpcgs := PcgsComplementOfChiefFactor (ppcgs,
								upcgs{[1..userinds[centind]-1]}, 
									userinds[centind-1], centpcgs mod ncpcgs, ncpcgs);
						fi;
					fi;
	
					if res = fail then
						Info (InfoProjector, 3, "testing group of size ", 
							Product (RelativeOrders(upcgs)) / 
							Product (RelativeOrders (ser[i+1])),
							" size of socle: ",
							Product (RelativeOrders (npcgs)),
							" size of complement: ",
							Product (RelativeOrders(cpcgs)) / 
							Product (RelativeOrders (ser[i+1])));
						Assert (1, Length (npcgs) + Length (cpcgs) = Length (upcgs),
							Error("cpcgs does not complement"));
						res := bfunc (upcgs, cpcgs, ncpcgs, npcgs, ser[i+1], p, 
							userinds[centind], data);
						if inonly and res = true then
							return false;
						fi;
						Info (InfoProjector, 3, "bfunc returns ", res);
					fi;
				else
					res := false; # there is no complement, the projector remains unchanged
				fi;
			fi;
			
			if res then # in boundary
				upcgs := cpcgs;
			else
				nextstep := nextstep + Length (npcgs);
			fi;
		od;
		if nextstep > 0 then
			Add (userp, p);
			Add (userinds, userinds[Length (userinds)]+nextstep);
		fi;
	od;
	if inonly then
		return true;
	fi;
	
	if hom or conv then # translate result back to previous pcgs
		upcgs := InducedPcgsByPcSequenceNC (pcgs,
			List (upcgs, x -> 
				PcElementByExponentsNC (pcgs, ExponentsOfPcElement (ppcgs, x))));
	fi;
	return upcgs;
end);


############################################################################
##
#E
##
