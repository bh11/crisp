#############################################################################
##
##  form.gd                         CRISP                 Burkhard H\"ofling
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
#F  IsOrdinaryFormation (<group class>)
##
DeclareSynonym ("IsOrdinaryFormation", 
	IsGroupClass and IsNonEmpty and IsQuotientClosed and IsResiduallyClosed);


#############################################################################
##
#F  SetIsOrdinaryFormation (<group class>)
##
DeclareGlobalFunction ("SetIsOrdinaryFormation");


#############################################################################
##
#O  OrdinaryFormation (<obj>)
##
DeclareOperation ("OrdinaryFormation", [IsObject]);


#############################################################################
##
#O  FormationProduct (<form1>, <form2>)
##
DeclareOperation ("FormationProduct", 
	[IsOrdinaryFormation, IsOrdinaryFormation]);


#############################################################################
##
#F  IsSaturatedFormation (<group class>)
##
DeclareSynonym ("IsSaturatedFormation", IsOrdinaryFormation and IsSaturated);


#############################################################################
##
#F  SetIsSaturatedFormation (<group class>)
##
DeclareGlobalFunction ("SetIsSaturatedFormation");


#############################################################################
##
#O  SaturatedFormation (<rec>)
##
DeclareOperation ("SaturatedFormation", [IsObject]);


#############################################################################
##
#F  IsFittingFormation(<group class>)
##
DeclareSynonym ("IsFittingFormation", 
	IsFittingClass and IsOrdinaryFormation);


#############################################################################
##
#F  SetIsFittingFormation (<group class>)
##
##  fake setter functions for these "properties"
##
DeclareGlobalFunction ("SetIsFittingFormation");


#############################################################################
##
#O  FittingFormation (<obj>)
##
DeclareOperation ("FittingFormation", [IsObject]);


#############################################################################
##
#F  IsSaturatedFittingFormation (<group class>)
##
DeclareSynonym ("IsSaturatedFittingFormation", 
	IsFittingFormation and IsSaturated);


#############################################################################
##
#F  SetIsSaturatedFittingFormation (<group class>)
##
##  fake setter functions for these "properties"
##
DeclareGlobalFunction ("SetIsSaturatedFittingFormation");


#############################################################################
##
#O  SaturatedFittingFormation (<obj>)
##
DeclareOperation ("SaturatedFittingFormation", [IsObject]);


#############################################################################
##
##  form.gd                         CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000, Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##


#############################################################################
##
#A  ResidualFunction (<class>)
##
##  if bound, stores a function for computing the <class>-residual of a given
##  group
##
DeclareAttribute ("ResidualFunction", IsGroupClass);


#############################################################################
##
#A  LocalDefinitionFunction (<class>)
##
##  if bound, stores a function for computing the f(p)-residuals of a given
##  group
##
DeclareAttribute ("LocalDefinitionFunction", IsGroupClass);


############################################################################
##
#E
##
