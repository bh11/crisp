#############################################################################
##
##  samples.gd                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.samples_gd :=
    "@(#)$Id$";


#############################################################################
##  
#V  TrivialGroups
##
DeclareGlobalVariable ("TrivialGroups");


#############################################################################
##  
#V  NilpotentGroups
##
DeclareGlobalVariable ("NilpotentGroups");


#############################################################################
##  
#A  NilpotentProjector
##
DeclareAttribute ("NilpotentProjector", IsGroup);


#############################################################################
##
#V  SupersolvableGroups
##
DeclareGlobalVariable ("SupersolvableGroups");


#############################################################################
##
#A  SupersolvableProjector
##
DeclareAttribute ("SupersolvableProjector", IsGroup);


#############################################################################
##
#V  AbelianGroups
##
DeclareGlobalVariable ("AbelianGroups");


#############################################################################
##
#F  AbelianGroupsOfExponent
##
DeclareGlobalFunction ("AbelianGroupsOfExponent");


#############################################################################
##
#F  GroupsOfPiLength
##
DeclareGlobalFunction ("GroupsOfPiLength");


#############################################################################
##
#F  PiGroups
##
DeclareGlobalFunction ("PiGroups");


#############################################################################
##
#F  PGroups
##
DeclareGlobalFunction ("PGroups");


#############################################################################
##
#V  AllPrimes
##
DeclareGlobalVariable ("AllPrimes");


############################################################################
##
#E
##

