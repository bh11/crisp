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
DeclareGlobalName("TrivialGroups");


#############################################################################
##  
#V  NilpotentGroups
##
DeclareGlobalName("NilpotentGroups");


#############################################################################
##  
#A  NilpotentProjector(<grp>)
##
DeclareAttribute("NilpotentProjector", IsGroup);


#############################################################################
##
#V  SupersolubleGroups
##
DeclareGlobalName("SupersolubleGroups");

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
DeclareGlobalName("AbelianGroups");


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
DeclareGlobalName("AllPrimes");


############################################################################
##
#E
##

