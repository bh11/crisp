############################################################################
##
##  samples.g                       CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
groups:= [ function (  )
        return SymmetricGroup( 4 );
    end, 
    function (  )
        return DihedralGroup( 10 );
    end, 
    function (  )
        return GL( 2, 3 );
    end ];
    
if not IsBound (InfoTest) then
   DeclareInfoClass ("InfoTest");

   InstallMethod (HallSubgroupOp, "by nice homomorphism",
      true, [IsGroup and IsHandledByNiceMonomorphism, IsList], 0,
      function (G, pi)
         return PreImagesSet (NiceMonomorphism (G), HallSubgroup (NiceObject (G), pi));
      end);
fi;

25grps := PiGroups ([2,5]);

classes := function ()
   return [
      SchunckClass (rec (bound := BoundaryFunction (25grps))),
      SaturatedFormation (rec (locdef := LocalDefinitionFunction (25grps))),
      GroupClass (rec (\in := MemberFunction (25grps))),
      OrdinaryFormation (rec (res := function (G)
         local pi;
         pi := Difference (Set (Factors (Size (G))), [2,5]);
         return NormalClosure (G, HallSubgroup (G, pi));
      end)),
      FittingClass (rec (rad := G -> Core (G, HallSubgroup (G, [2,5])))),
      FittingClass (rec (inj := InjectorFunction (25grps))),
      SchunckClass (rec (proj:= ProjectorFunction (25grps)))
   ];
end;


############################################################################
##
#E
##
