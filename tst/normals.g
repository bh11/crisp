############################################################################
##
##  normals.g                       CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("crisp");
ReadPkg ("crisp", "tst/samples.g");

if PRINT_METHODS then
   TraceMethods (NormalSubgroups);
fi;
List (groups, G -> NormalSubgroups (G()));
if PRINT_METHODS then
   UntraceMethods (NormalSubgroups);
fi;


############################################################################
##
#E
##
