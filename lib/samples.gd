#############################################################################
##
##  samples.gd                      CRISP                    Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##


#############################################################################
##  
#V  TrivialGroups
##
DeclareGlobalVariable("TrivialGroups");


#############################################################################
##  
#V  NilpotentGroups
##
DeclareGlobalVariable("NilpotentGroups");


#############################################################################
##  
#A  NilpotentProjector(<grp>)
##
DeclareAttribute("NilpotentProjector", IsGroup);


#############################################################################
##
#V  SupersolubleGroups
##
DeclareGlobalVariable("SupersolubleGroups");
DeclareSynonym("SupersolvableGroups", SupersolubleGroups);

#############################################################################
##
#A  SupersolubleProjector(<grp>)
##
DeclareAttribute("SupersolubleProjector", IsGroup);
DeclareSynonymAttr("SupersolvableProjector", SupersolubleProjector);


#############################################################################
##
#V  AbelianGroups
##
DeclareGlobalVariable("AbelianGroups");


#############################################################################
##
#F  AbelianGroupsOfExponent(<exp>)
##
DeclareGlobalFunction("AbelianGroupsOfExponent");


#############################################################################
##
#F  PiGroups(<primes>)
##
DeclareGlobalFunction("PiGroups");


#############################################################################
##
#F  PGroups(<p>)
##
DeclareGlobalFunction("PGroups");


#############################################################################
##
#V  AllPrimes
##
DeclareGlobalVariable("AllPrimes");


############################################################################
##
#E
##

