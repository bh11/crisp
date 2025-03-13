#############################################################################
##
##  samples.gd                      CRISP                    Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##


#############################################################################
##  
#A  NilpotentProjector(<grp>)
##
DeclareAttribute("NilpotentProjector", IsGroup);


#############################################################################
##
#A  SupersolubleProjector(<grp>)
##
DeclareAttribute("SupersolubleProjector", IsGroup);
DeclareSynonymAttr("SupersolvableProjector", SupersolubleProjector);


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


############################################################################
##
#E
##

