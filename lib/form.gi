#############################################################################
##
##  form.gi                         CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.form_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  OrdinaryFormation (<rec>)
##
InstallMethod (OrdinaryFormation, true, [IsRecord], 0,
	function (record)
		local F, r;
		r := ShallowCopy (record);
 		F := NewClass ("OrdinaryFormation", IsGroupClass and IsClassByPropertyRep, 
 			rec (definingAttributes := [
 				["in", MemberFunction],
 				["res", ResidualFunction]]));
       if IsBound (r.char) then
        	SetCharacteristic (F, r.char);
        	Unbind (r.char);
        fi;
		InstallDefiningAttributes (F, r);
   		SetIsOrdinaryFormation (F, true);
	 	return F;
	end);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for formation", true, [IsOrdinaryFormation], 0,
	function (C) 
		Print ("OrdinaryFormation (");
		ViewDefiningAttributes (C);
		Print (")");
	end);

#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, "for formation", true, [IsOrdinaryFormation], 0,
	function (C) 
		Print ("OrdinaryFormation(");
		PrintDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, "if residual function is known", true, 
	[IsGroup, IsOrdinaryFormation and HasResidualFunction], 10,  
			# residual function is usually faster 
			# than computation of radical or injector
	function (G, C)
		if HasMemberFunction (C) then
			TryNextMethod();
		else
			return IsTrivial (ResidualFunction(C) (G));
		fi;
	end);
 

#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for formation", true, 
	[IsOrdinaryFormation, IsOrdinaryFormation], 0,
	function (bot, top) 
		return OrdinaryFormation (rec (
			\in := G -> Residual (G, top) in bot,
	  		res := G -> Residual (Residual (G, top), bot),
	  		char := Union (Characteristic (top), Characteristic (bot))
	  		));
	end);
	

#############################################################################
##
#M  SaturatedFormation
##
InstallMethod (SaturatedFormation, true, [IsRecord], 0,
	function (record)
		local F, r;
		r := ShallowCopy (record);
		F := NewClass ("FittingFormation", IsGroupClass and IsClassByPropertyRep, 
 	  		rec (definingAttributes := 
		  			[	["in", MemberFunction],
	  				["res", ResidualFunction],
	  				["proj", ProjectorFunction],
	  				["locdef", LocalDefinitionFunction],
	  				["bound", BoundaryFunction]]));
       if IsBound (r.char) then
        	SetCharacteristic (F, r.char);
        	Unbind (r.char);
        fi;
  		SetIsSaturatedFormation (F, true);
  		InstallDefiningAttributes (F, r);
		return F;
	end);

#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for a saturated formation", true, [IsSaturatedFormation], 0,
	function (C) 
		Print ("SaturatedFormation (");
		ViewDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, "for a saturated formation", true, [IsSaturatedFormation], 0,
	function (C) 
		Print ("SaturatedFormation (");
		PrintDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for saturated formation", true, 
	[IsSaturatedFormation, IsSaturatedFormation], 0,
	function (bot, top) 
		return SaturatedFormation (rec (
			\in := G -> Residual (G, top) in bot,
			rad := function (G)
				local nat;
				nat := NaturalHomomorphismByNormalSubgroup (G, Radical (G, bot));
				return PreImagesSet (nat, Radical (ImagesSource (nat), top));
			end,
	  		res := G -> Residual (Residual (G, top), bot),
	  		char := Union (Characteristic (top), Characteristic (bot))
	  		));
	end);
	

#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for saturated formations w/local def", true, 
	[IsSaturatedFormation and HasLocalDefinitionFunction, 
	 IsSaturatedFormation and HasLocalDefinitionFunction], 0,
	function (bot, top) 
		return SaturatedFormation (rec (
			\in := G -> Residual (G, top) in bot,
			locdef := function (G, p)
				if p in Characteristic (bot) then
					return LocalDefinitionFunction (bot) (Residual (G, top), p);
				else
					return LocalDefinitionFunction (top) (G, p);
				fi;
			end,
	  		res := G -> Residual (Residual (G, top), bot),
	  		char := Union (Characteristic (top), Characteristic (bot))
	  		));
	end);
	

#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for saturated formation and formation - try if saturated", true, 
	[IsSaturatedFormation and HasLocalDefinitionFunction, 
	 IsOrdinaryFormation and HasCharacteristic], 0,
	function (bot, top) 
		if HasCharacteristic (top) and IsSet (Characteristic (top))
		 	and ForAll (Characteristic(top), x -> x in Characteristic (bot)) then
				return SaturatedFormation (rec (
					\in := G -> Residual (G, top) in bot,
					locdef := function (G, p)
						if p in Characteristic (bot) then
							return LocalDefinitionFunction (bot) (Residual (G, top), p);
						else
							return LocalDefinitionFunction (top) (G, p);
						fi;
					end,
					res := G -> Residual (Residual (G, top), bot),
					char := Union (Characteristic (top), Characteristic (bot))
					));
		else
			TryNextMethod();
		fi;
	end);
	
	
#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for saturated formation and formation - try if saturated", true, 
	[IsSaturatedFormation and HasLocalDefinitionFunction and HasCharacteristic, 
	 IsOrdinaryFormation], 0,
	function (bot, top) 
		if Characteristic (bot) = AllPrimes then
			return SaturatedFormation (rec (
				\in := G -> Residual (G, top) in bot,
				locdef := function (G, p)
					return LocalDefinitionFunction (bot) (Residual (G, top), p);
				end,
				res := G -> Residual (Residual (G, top), bot),
				char := Union (Characteristic (top), Characteristic (bot))
				));
		else
			TryNextMethod();
		fi;
	end);
	
	
#############################################################################
##
#M  FittingFormation (<rec>)
##
InstallMethod (FittingFormation, true, [IsRecord], 0,
	function (record)
		local F, r;
		r := ShallowCopy (record);
		F := NewClass ("FittingFormation", IsGroupClass and IsClassByPropertyRep, rec (
			definingAttributes :=
			[	["in", MemberFunction],
			 	["rad", RadicalFunction],
			 	["inj", InjectorFunction],
	  			["res", ResidualFunction] ]));
		SetIsFittingFormation (F, true);
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
InstallMethod (ViewObj, "for Fitting formation", true, [IsFittingFormation], 0,
	function (C) 
		Print ("FittingFormation (");
		ViewDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, "for Fitting formation", true, [IsFittingFormation], 0,
	function (C) 
		Print ("FittingFormation ( ");
		PrintDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for Fitting formation", true, 
	[IsFittingFormation, IsFittingFormation], 0,
	function (bot, top) 
		return FittingFormation (rec (
			\in := G -> Residual (G, top) in bot,
			rad := function (G)
				local nat;
				nat := NaturalHomomorphismByNormalSubgroup (G, Radical (G, bot));
				return PreImagesSet (nat, Radical (ImagesSource (nat), top));
			end,
	  		res := G -> Residual (Residual (G, top), bot),
	  		char := Union (Characteristic (top), Characteristic (bot))
	  		));
	end);
	

#############################################################################
##
#M  SaturatedFittingFormation (<rec>)
##
InstallMethod (SaturatedFittingFormation, true, [IsRecord], 0,
	function (record)
		local F, r;
		r := ShallowCopy (record);
		F := NewClass ("SaturatedFittingFormation", IsGroupClass and IsClassByPropertyRep, rec (
			definingAttributes :=
			[	["in", MemberFunction],
			 	["rad", RadicalFunction],
			 	["inj", InjectorFunction],
			 	["locdef", LocalDefinitionFunction],
	  			["res", ResidualFunction],
	  			["proj", ProjectorFunction],
	  			["bound", BoundaryFunction]
	  		]));
		SetIsSaturatedFittingFormation (F, true);
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
InstallMethod (ViewObj, "for saturated Fitting formation", true, 
	[IsSaturatedFittingFormation], 0,
	function (C) 
		Print ("SaturatedFittingFormation (");
		ViewDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for saturated Fitting formation", true, 
	[IsSaturatedFittingFormation and HasLocalDefinitionFunction, 
	 IsSaturatedFittingFormation and HasLocalDefinitionFunction], 
	2*RankFilter (HasCharacteristic),
	function (bot, top) 
		return SaturatedFittingFormation (rec (
			\in := G -> Residual (G, top) in bot,
			rad := function (G)
				local nat;
				nat := NaturalHomomorphismByNormalSubgroup (G, Radical (G, bot));
				return PreImagesSet (nat, Radical (ImagesSource (nat), top));
			end,
			locdef := function (G, p)
				if p in Characteristic (bot) then
					return LocalDefinitionFunction (bot) (Residual (G, top), p);
				else
					return LocalDefinitionFunction (top) (G, p);
				fi;
			end,
	  		res := G -> Residual (Residual (G, top), bot),
	  		char := Union (Characteristic (top), Characteristic (bot))
	  		));
	end);
	
	
#############################################################################
##
#M  FormationProduct
##
InstallMethod (FormationProduct, "for saturated Fitting formation and Fitting formation - try if saturated", true, 
	[IsSaturatedFittingFormation and HasLocalDefinitionFunction  and HasCharacteristic, 
	 IsFittingFormation], 0,
	function (bot, top) 
		if Characteristic (bot) = AllPrimes or
		 	(HasCharacteristic (top) and IsSet (Characteristic (top))
		 	and ForAll (Characteristic(top), x -> x in Characteristic (bot))) then
				return SaturatedFittingFormation (rec (
					\in := G -> Residual (G, top) in bot,
					locdef := function (G, p)
						if p in Characteristic (bot) then
							return LocalDefinitionFunction (bot) (Residual (G, top), p);
						else
							return LocalDefinitionFunction (top) (G, p);
						fi;
					end,
					res := G -> Residual (Residual (G, top), bot),
					char := Union (Characteristic (top), Characteristic (bot))
					));
		else
			TryNextMethod();
		fi;
	end);
	

############################################################################
##
#E
##

	