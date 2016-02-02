#############################################################################
##
##  socle.gd                         CRISP                   Burkhard Höfling
##
##  Copyright © 2001, 2002, 2015 Burkhard Höfling
##

#############################################################################
##
#A  PSocleComponents(<G>) 
##
KeyDependentOperation("PSocleComponents", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  PSocleComponents(<G>) 
##
KeyDependentOperation("PSocleSeries", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  PSocle(<G>) 
##
KeyDependentOperation("PSocle", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  SolubleSocle(<G>)
##
DeclareAttribute("SolubleSocle", IsGroup);
DeclareSynonymAttr("SolvableSocle", SolubleSocle);
DeclareSynonymAttr("AbelianSocle", SolubleSocle);

#############################################################################
##
#A  SocleComponents(<G>) 
##
DeclareAttribute("SocleComponents", IsGroup);


#############################################################################
##
#A  SolubleSocleComponents(<G>)
##
DeclareAttribute("SolubleSocleComponents", IsGroup);
DeclareSynonymAttr("SolvableSocleComponents", SolubleSocleComponents);
DeclareSynonymAttr("AbelianSocleComponents", SolubleSocleComponents);


#############################################################################
##
#A  MinimalNormalPSubgroups(<G>)
##
KeyDependentOperation("MinimalNormalPSubgroups", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  AbelianMinimalNormalSubgroups(<G>)
##
DeclareAttribute("AbelianMinimalNormalSubgroups", IsGroup);



#############################################################################
##
#E
##
