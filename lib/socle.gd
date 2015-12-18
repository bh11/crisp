#############################################################################
##
##  socle.gd                         CRISP                   Burkhard Höfling
##
##  Copyright (C) 2001, 2002, 2015 Burkhard Höfling
##

#############################################################################
##
#A  PSocleComponents (<G>) 
##
KeyDependentOperation ("PSocleComponents", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  PSocleComponents (<G>) 
##
KeyDependentOperation ("PSocleSeries", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  PSocle (<G>) 
##
KeyDependentOperation ("PSocle", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  SolvableSocle (<G>) 
##
DeclareAttribute ("SolvableSocle", IsGroup);
DeclareSynonym ("AbelianSocle", SolvableSocle);

#############################################################################
##
#A  SocleComponents (<G>) 
##
DeclareAttribute ("SocleComponents", IsGroup);


#############################################################################
##
#A  SolvableSocleComponents (<G>) 
##
DeclareAttribute ("SolvableSocleComponents", IsGroup);
DeclareSynonym ("AbelianSocleComponents", SolvableSocleComponents);


#############################################################################
##
#A  MinimalNormalPSubgroups (<G>)
##
KeyDependentOperation ("MinimalNormalPSubgroups", IsGroup, IsPosInt, "prime");


#############################################################################
##
#A  SolvableMinimalNormalSubgroups (<G>) 
##
DeclareAttribute ("AbelianMinimalNormalSubgroups", IsGroup);



#############################################################################
##
#E
##
