#############################################################################
##
##  socle.gi                         CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2001 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.socle_gi :=
    "@(#)$Id$";


RequirePackage ("crisp");


#############################################################################
##
#M  Socle (<G>) 
##
InstallMethod (Socle, 
   "for solvable group", true, 
   [IsGroup and IsSolvableGroup and IsFinite], 
   0,
   function( G )

      local i, pcgs, pcgssoc, socdepths, L, x, ser, n;
      
      pcgs := ParentPcgs (Pcgs (G));
      
      if IsTrivial (G) then
         return G;
      fi;

      pcgssoc := [];
      socdepths := [];
      
      ser := ChiefSeries (G);
      n := Length (ser);

      for i in [n-1, n-2..1] do
         Info (InfoComplement, 1, "starting step ",i);
         L := ComplementsMaximalUnderAction (G, ser, i, i+1, n, false);
         if L <> fail then
            for x in Pcgs (L) do
                if not AddPcElementToPcSequence (pcgs, pcgssoc, socdepths, x) then
                   Error ("Internal error in method for `Socle' for soluble gorups");
                fi;
            od;
         fi;
      od;
      pcgssoc := InducedPcgsByPcSequenceNC (pcgs, pcgssoc);
      return GroupOfPcgs (pcgssoc);
   end);


#############################################################################
##
#M  Socle (<G>) 
##
InstallMethod (Socle, 
   "for solvable group with known Fitting subgroup", true, 
   [IsGroup and IsSolvableGroup and IsFinite and HasFittingSubgroup], 
   0,
   function( G )

      local i, pcgs, pcgssoc, socdepths, L, x, ser, n;
      
      pcgs := ParentPcgs (Pcgs (G));
      
      if IsTrivial (G) then
         return G;
      fi;

      pcgssoc := [];
      socdepths := [];
      
      ser := ChiefSeriesUnderAction (G, FittingSubgroup (G));
      n := Length (ser);

      for i in [n-1, n-2..1] do
         Info (InfoComplement, 1, "starting step ",i);
         L := ComplementsMaximalUnderAction (G, ser, i, i+1, n, false);
         if L <> fail then
            for x in Pcgs (L) do
                if not AddPcElementToPcSequence (pcgs, pcgssoc, socdepths, x) then
                   Error ("Internal error in method for `Socle' for soluble gorups");
                fi;
            od;
         fi;
      od;
      pcgssoc := InducedPcgsByPcSequenceNC (pcgs, pcgssoc);
      return GroupOfPcgs (pcgssoc);
   end);


#############################################################################
##
#M  Socle (<G>) 
##
RedispatchOnCondition (Socle, true, 
   [IsGroup], 
   [IsFinite and IsSolvableGroup], 0);
   
   
#############################################################################
##
#M  Socle (<G>) 
##
InstallMethod (Socle,
   "handled by nice monomorphism",
   true,
   [IsGroup and IsHandledByNiceMonomorphism and IsFinite and IsSolvableGroup],
   0,
   function( grp )
      local hom;
      return PreImagesSet (NiceMonomorphism (grp), Socle (NiceObject (grp)));
   end);
   
   
############################################################################
##
#E
##
