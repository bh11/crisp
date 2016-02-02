#############################################################################
##
##  schunck.gd                      CRISP                    Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##


#############################################################################
##
#P  IsPrimitiveSolubleGroup(<grp>)
#P  IsPrimitiveSoluble(<grp>)
##
DeclareProperty("IsPrimitiveSolubleGroup", IsGroup);
DeclareSynonymAttr("IsPrimitiveSoluble", IsPrimitiveSolubleGroup);
DeclareSynonymAttr("IsPrimitiveSolvableGroup", IsPrimitiveSolubleGroup);
DeclareSynonymAttr("IsPrimitiveSolvable", IsPrimitiveSolubleGroup);


#############################################################################
##
#O  SchunckClass(<obj>)
##
DeclareAttribute("SchunckClass", IsObject);


#############################################################################
##
#A  Boundary(<class>)
##
##  compute the boundary of <class>, i.e., the set of all primitive soluble
##  groups which do not belong to <class> but whose proper factor groups do.
##
DeclareAttribute("Boundary", IsGroupClass);


#############################################################################
##
#A  Basis(<class>)
##
##  the basis of a Schunck class <class> consists of the primitive soluble 
##  groups in <class>
##
DeclareAttribute("Basis", IsGroupClass);


#############################################################################
##
#A  ProjectorFunction(<class>)
##
##  if bound, stores a function for computing a <class>-projector of a given
##  group
##
DeclareAttribute("ProjectorFunction", IsGroupClass);


#############################################################################
##
#A  BoundaryFunction(<class>)
##
##  if bound, stores a function which returns true for all groups in the 
##  boundary of <class>, and false for all primitive groups in <class>.
##
DeclareAttribute("BoundaryFunction", IsGroupClass);


#############################################################################
##
#E
##

