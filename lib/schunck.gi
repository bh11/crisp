#############################################################################
##
##  schunck.gi                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.schunck_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  SchunckClass
##
InstallMethod (SchunckClass, "for record", true, [IsRecord], 0,
	function (record)
		local F, r;
		r := ShallowCopy (record);
	  	F := NewClass ("Schunck Class", IsGroupClass and IsClassByPropertyRep, 
	  		rec (definingAttributes := 
	  			[	["in", MemberFunction],
	  				["proj", ProjectorFunction],
	  				["bound", BoundaryFunction]]));
	  	SetIsSchunckClass (F, true);
        if IsBound (r.char) then
        	SetCharacteristic (F, r.char);
        	Unbind (r.char);
        fi;
	  	InstallDefiningAttributes (F, r);
		return F;
  end);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for a Schunck class", true, [IsSchunckClass], 0,
	function (C) 
		Print ("SchunckClass (");
		ViewDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, "for a Schunck class", true, [IsSchunckClass], 0,
	function (C) 
		Print ("SchunckClass (");
		PrintDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, "if ProjectorFunction is known", true, 
	[IsGroup, IsSchunckClass and HasProjectorFunction], 0,
	function (G, C)
 	return Size (ProjectorFunction(C)(G)) = Size (G);
 end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, "compute from LocalDefinitionFunction", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSaturatedFormation and HasLocalDefinitionFunction], 
	RankFilter (HasBoundaryFunction),
	function (G, C)
		return ProjectorFromExtendedBoundaryFunction (
			G, 
			rec (
				dfunc := DFUNC_FROM_CHARACTERISTIC (C),
				cfunc := CFUNC_FROM_CHARACTERISTIC (C),
				ncfunc := NCFUNC_FROM_LOCAL_DEFINITION (C)),				
	    	true); # we want a membership test, not a projector
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, "compute from boundary", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSchunckClass and HasBoundaryFunction], 
	0,
	function (G, C)
		return ProjectorFromExtendedBoundaryFunction (
			G, 
			rec (
				cfunc := CFUNC_FROM_CHARACTERISTIC_SCHUNCK (C),
				bfunc := BFUNC_FROM_TEST_FUNC (C, BoundaryFunction (C))),
	    	true); # we want a membership test, not a projector
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, "compute from boundary", true, 
	[IsGroup and IsFinite and IsSolvableGroup, 
		IsSchunckClass and HasMemberFunction], 
	0,
	function (G, C)
		return ProjectorFromExtendedBoundaryFunction (
			G, 
			rec (
				cfunc := CFUNC_FROM_CHARACTERISTIC_SCHUNCK (C),
				bfunc := BFUNC_FROM_TEST_FUNC (C, H -> not MemberFunction (H, C))),
	    	true); # we want a membership test, not a projector
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, "try if group is finite and solvable", true, 
	[IsGroup, IsSchunckClass], 
	0,
	function (G, C)
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return IsMemberOp (G, C);
		else
			TryNextMethod();
		fi;
	end);


#############################################################################
##
#M  Boundary
##
InstallMethod (Boundary, "if BoundaryFunction is known", true, 
	[IsSchunckClass and HasBoundaryFunction], 3,
	function (H)
 		return GroupClass (G -> IsPrimitiveSolvable (G) and BoundaryFunction(G)
 			and G/Socle(G) in H);
 end);
  

#############################################################################
##
#M  Boundary
##
InstallMethod (Boundary, "for Schunck class with local definition", true, 
	[IsSchunckClass and HasLocalDefinitionFunction], 0,
	function (H)
 		return GroupClass (
 			function (G)
 			
 				local soc, p;
 				
 				if not IsPrimitiveSolvable (G) then
 					return false;
 				fi;
 				soc := Socle (G);
 				p := Factors (Size (soc))[1];
 				return not G/soc in LocalDefinitionFunction (H) (p);
 			end);
 	end);
 

#############################################################################
##
#M  Characteristic
##
InstallMethod (Characteristic, "for Schunck class", true, 
	[IsSchunckClass and HasBoundaryFunction], 0,
	function (H)
 		return Class (function (p)
 			local C;
 			if IsPrime(p) then
 				C := CyclicGroup (p);
 				SetSocle (C, C);
 				SetSocleComplement (C, TrivialSubgroup (C));
 				return not BoundaryFunction (H)(C);
 			else
 				return false;
 			fi;
 		end);
	end);


#############################################################################
##
#M  Characteristic
##
InstallMethod (Characteristic, "for local formation", true, 
	[IsSaturatedFormation and HasLocalDefinitionFunction], 0,
	function (H)
 		return Class (p -> IsPrime (p) and 
 			LocalDefinitionFunction (H)(TrivialGroup (), p) <> fail);
	end);


#############################################################################
##
#E
##



