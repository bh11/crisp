#############################################################################
##
##  projector.gd                     CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.projector_gd :=
    "@(#)$Id$";


###################################################################################
##
#V  InfoProjector 
##
DeclareInfoClass ("InfoProjector");


###################################################################################
##
#O  Projector (<grp>, <class>)
##
KeyDependentOperation ("Projector", IsGroup, IsGroupClass, ReturnTrue);


###################################################################################
##
#M  CoveringSubgroup (<grp>, <class>)
##
KeyDependentOperation ("CoveringSubgroup", IsGroup, IsGroupClass,
		ReturnTrue);


###################################################################################
##
#O  ProjectorFromExtendedBoundaryFunction (<grp>, <rec>, <inonly>) 
##
##  if inonly is false, this computes a projector of <grp> for the 
##  Schunck class described by <rec.dfunc>, <rec.cfunc>, <rec.ncfunc>, 
##  <rec.bfunc>, and <rec.data>.
##  if inonly is true, it returns true or false depending whether <grp>
##  belongs to the Schunck class or not.
##
##  See PROJECTOR_FROM_BOUNDARY below for the meaning of arguments
##
DeclareOperation ("ProjectorFromExtendedBoundaryFunction",
	[IsGroup, IsRecord, IsBool]);


###################################################################################
##
#F  PROJECTOR_FROM_BOUNDARY (
##	   <gpcgs>, <dfunc>, <cfunc>, <ncfunc>, <bfunc>, <data>, 
##     <inonly>, <hom>, <conv>)
##
#F  PROJECTOR_FROM_BOUNDARY_2 (
##	   <gpcgs>, <dfunc>, <cfunc>, <ncfunc>, <bfunc>, <data>, 
##     <inonly>, <hom>, <conv>)
##
##  <gpcgs> is a pcgs of the group G for which the projector will be computed
##  dfunc, cfunc, ncfunc, bfunc are functions which describe the boundary of
##  a Schunck class H. If inonly is true, the function returns true if G
##  belongs to H, and false otherwise. If inonly is false, it returns the 
##  pcgs of a projector of G. If hom is true, computations will be carried out
##  in factor groups, otherwise wrt modulo pcgs. if conv is true, computatios
##  will take place wrt a pcgs refining an elementary abelian series of G.
##  hom implies conv.
##
##  Consider the following situation: N/K is a chief factor
##             of U with U/N in H, complemented by a maximal subgroup M of U.
##    U        U and M are given by pcgs <upcgs> and <mpcgs>induced from gpcgs
##   / \       and N/K is represented by <npcgs> and p, its exponent. 
##  M   D      upcgs{[cent..Length(upcgs)]} is the longest tail sequence
##   \ / \     of upcgs centralising npcgs, and C/K is a normal complement of 
##    C   N    N/K in C/K. C is represented by ncpcgs. 
##     \ /     
##      K      The functions dfunc, cfunc, ncfunc, and bfunc take the following
##             arguments.
##
##  dfunc (upcgs, npcgs, p, data)
##  cfunc (upcgs, npcgs, p, cent, data)
##  ncfunc (upcgs, ncpcgs, npcgs, p, cent, data)
##  bfunc (upcgs, cpcgs, ncpcgs, npcgs, p, cent, data)
##
##  They are supposed to test whether U/C_M(N/K) belongs to the boundary of H,
##  (or, equivalently, if U/K does *not* belong to H), and return true in that 
##  case, or false if U/C_M(N/K) (or equivalently, U/K) belongs to H. dfunc,
##  cfunc, and ncfunc are allowed to return fail if no decision has been reached.
##
##  For any chief factor N/K, dfunc is called. If it returns fail, 
##  then additional information
##  is collected and cfunc is called. If this returns fail, ncfunc is called;
##  if no decision is readched, bfunc is called, which is supposed to return 
##  true or false. Note that dfunc and cfunc may be called in cases when 
##  the chief factor N/K is not complemented (in which case the answer 
##  returned has no effect on the result, but `false' may speed up computations).
##
##  data is any data which is passed to dfunc, cfunc, ncfunc, and bfunc,
##  which may, for instance, be used to share information between these 
##  functions.
##
DeclareGlobalFunction ("PROJECTOR_FROM_BOUNDARY");
DeclareGlobalFunction ("PROJECTOR_FROM_BOUNDARY_2");


###################################################################################
##
#F  DFUNC_FROM_CHARACTERISTIC
##
##  standard function to pass to PcgsProjectorFromExtendedBoundaryFunction
##  as dfunc
##
DeclareGlobalFunction ("DFUNC_FROM_CHARACTERISTIC");


###################################################################################
##
#F  CFUNC_FROM_CHARACTERISTIC
##
##  standard function to pass to PcgsProjectorFromExtendedBoundaryFunction
##  as cfunc
##
DeclareGlobalFunction ("CFUNC_FROM_CHARACTERISTIC");


###################################################################################
##
#F  NCFUNC_FROM_LOCAL_DEFINITION
##
##  standard function to pass to PcgsProjectorFromExtendedBoundaryFunction
##  as ncfunc
##
DeclareGlobalFunction ("NCFUNC_FROM_LOCAL_DEFINITION");


###################################################################################
##
#F  CFUNC_FROM_CHARACTERISTIC_SCHUNCK
##
##  standard function to pass to PcgsProjectorFromExtendedBoundaryFunction
##  as cfunc
##
DeclareGlobalFunction ("CFUNC_FROM_CHARACTERISTIC_SCHUNCK");


###################################################################################
##
#F  BFUNC_FROM_TEST_FUNC
##
##  standard function to pass to PcgsProjectorFromExtendedBoundaryFunction
##  as bfunc
##
DeclareGlobalFunction ("BFUNC_FROM_TEST_FUNC");


############################################################################
##
#E
##
