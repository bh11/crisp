#############################################################################
##
##  fitting.gd                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.fitting_gd :=
    "@(#)$Id$";


#############################################################################
##
##  IsFittingClass (<group class>) 
DeclareSynonym ("IsFittingClass", 
	IsNonEmpty and IsGroupClass and IsNormalSubgroupClosed 
	and IsNormalProductClosed);


#############################################################################
##
#F  SetIsFittingClass (<group class>)
##
DeclareGlobalFunction ("SetIsFittingClass");


#############################################################################
##
#O  FittingClass (<obj>)
##
DeclareOperation ("FittingClass", [IsObject]);


#############################################################################
##
#O  FittingProduct (<fit1>, <fit2>)
##
DeclareOperation ("FittingProduct", [IsFittingClass, IsFittingClass]);


#############################################################################
##
#O  FittingSet (<grp>, <obj>)
##
DeclareOperation ("FittingSet", [IsGroup, IsObject]);


#############################################################################
##
#O  IsFittingSet (<grp>, <obj>)
##
##  decides if the subgroups of <grp> contained in <obj> form a 
##  Fitting set of <grp>
##
DeclareOperation ("IsFittingSet", [IsGroup, IsObject]);


#############################################################################
##
#O  ImageFittingSet (<hom>, <fitset>)
##
##  constructs a Fitting set of Image (hom) from the Fitting set
##  <fitset> of PreImage (hom).
##
DeclareOperation ("ImageFittingSet", [IsGeneralMapping, IsClass]);


#############################################################################
##
#O  PreImageFittingSet (<hom>, <fitset>)
##
##  constructs a Fitting set of PreImage (hom) from the Fitting set
##  <fitset> of Image (hom).
##
DeclareOperation ("PreImageFittingSet", [IsGeneralMapping, IsClass]);


#############################################################################
##
#A  InjectorFunction (<class>)
##
##  if bound, stores a function for computing a <class>-injector of a given
##  group
##
DeclareAttribute ("InjectorFunction", IsClass);


#############################################################################
##
#A  RadicalFunction (<class>)
##
##  if bound, stores a function for computing the <class>-radical of a given
##  group
##
DeclareAttribute ("RadicalFunction", IsClass);


############################################################################
##
#E
##
