############################################################################
##
##  timing_normpro.g                CRISP                 Burkhard H\"ofling
##
##  @(#)$ $
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("crisp");

groups := [
 ["format","grp/g93.gi", "g93", "31:3"],
 ["format","grp/OOF.gi", "OOF"],
 ["format","grp/ONF.gi", "ONF"],
 ["format","grp/FI22.gi", "G", "FI22"],
# ["crisp", "grp/FI22mod.gp", "FI22mod", "FI22mod"],
 ["format","grp/LUX2_12.gi", "LUX2_12"],
# ["crisp", "grp/DARKmod6.gp", "DARKmod6", "DARK/6"],
 ["format","grp/UPP.gi", "G", "UPP"],
 ["format","grp/DARK.gi","G", "DARK"],
# ["format","grp/DARKplus4.gp", "DARKplus"],
# ["format","grp/LUXwreath4.gp", "LUX2_12wrs3", "LUXwrS3"],
 ["format","grp/LUX.gi", "G", "LUXwrS3"],
# ["crisp", "grp/DARKwrS3.gp", "DARKwrS3"],
];

if IsBound (FAST_TEST) and FAST_TEST then
   groups := groups{[1..3]};
fi;

if not IsBound (PRINT) then
   PRINT := Print;
   MakeReadOnlyGlobal ("PRINT");
fi;

SilentRead := function (pkg, fname)

   MakeReadWriteGlobal ("Print");
   Print := Ignore;
   ReadPkg (pkg, fname);
   Print := PRINT;
   MakeReadOnlyGlobal ("Print");
end;


Collect := function ()
   if IsBound (DO_TIMING) and DO_TIMING then
      GASMAN ("collect");
   fi;
end;

      
if not IsBound (ex) then
   ex := [];
fi;

if not IsBound (slow) then
   slow := [];
fi;

if not IsBound (res) then
   res := [];
fi;

test := function (H)
   
   local p, primes, res, P, norm1, norm2, t1, t2, t0;
   
   Print ("testing group of size ", Size (H),"  ",
      Collected (FactorsInt (Size (H))),"\n");
   primes := Set (FactorsInt (Size(H)));
   res := [];
   Collect();
   t0 := Runtime();
   SpecialPcgs (H);
   t1 := Runtime() - t0;
   Collect();
   t0 := Runtime();
   PcgsElementaryAbelianSeries (H);
   t2 := Runtime() - t0;      
   if IsBound (DO_TIMING) and DO_TIMING then
      Print ("time for special pcgs ", t1, 
         " time for PcgsElementaryAbelianSeries: ", t2, "\n");
   fi;
   
   for p in primes do 
      P := SylowSubgroup (H, p);
      Print ("prime ", p, " |P| =", Size (P), " |H:P| = ", Size (H)/Size (P),"\n");
      Collect();
      t0 := Runtime();
      norm1 := NormalizerOfPronormalSubgroup (H, P);
      t1 := Runtime() - t0;
      Collect();
      t0 := Runtime();
      norm2 := Normalizer (H, P); 
      t2 := Runtime() - t0;
      if norm1 <> norm2 then
         Add (ex, [H, norm1, norm2, P, p]);
         Error ("wrong normalizer  \n");
      fi;
      if norm1 <> norm2 then
         Add (ex, [H, norm1, norm2, P, p]);
         Error ("normalizer not self-normalising \n");
      fi;
      if Index (H, norm1) mod p <> 1 then
         Add (ex, [H, norm1, norm2, P, p]);
         Error ("wrong index \n");
      fi;
      if IsBound (DO_TIMING) and DO_TIMING then
         Print (t1, "   ", t2,
            "  |N_G(P):P| = ", Size (norm1)/Size(P),
            "  |G:N_G(P)| =  ", Size (H)/Size(norm1));
         AppendTo ("normpro.log", t1, "   ", t2, 
            "  |N_G(P):P| = ", Size (norm1)/Size(P),
            "  |G:N_G(P)| =  ", Size (H)/Size(norm1),"\n");
         AppendTo ("normpro.log", InducedPcgsWrtSpecialPcgs (H), "\n\n");

         Add (res, [t1,t2]);
#         if t1 > 2*t2 then
#            Add (slow, [t1, t2, H, P, norm1]);
#         fi;
      fi;
      Print ("\n");
   od;
   return res;
end;


test2 := function (G)

   local pcgs, pcgsH, H, i, new;
   
   pcgs := Pcgs (G);
   pcgsH := InducedPcgsByPcSequence (pcgs, []);
   H := SubgroupByPcgs (G, pcgsH);
   
   repeat 
      new := Random(PcSeries (pcgs)[Random([1..Length (pcgs)])]);
      i := DepthOfPcElement (pcgs, new);
      if not new in H then
         pcgsH := InducedPcgsByPcSequenceAndGenerators (pcgs, pcgsH, [new]);
         H := SubgroupByPcgs (G, pcgsH);
         test (H);
      fi;
   until H = G;
end;



for g in groups do
   if IsBoundGlobal (g[3]) then
      UnbindGlobal (g[3]);
   fi;
   if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
      UnbindGlobal(Concatenation ("MAKE_",g[3]));
   fi;
   SilentRead (g[1],g[2]);
   if IsBound (g[4]) then
      name := g[4];
   else
      name := g[3];
   fi;
   Print (String (name,-10));
   tmp := ValueGlobal (g[3]);
   size := Size (tmp);
   Print (String (LogInt (Size (tmp), 10), 8));
   Print (String (Length (Pcgs(tmp)), 8), "\c");
   UnbindGlobal (g[3]);
   if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
      UnbindGlobal(Concatenation ("MAKE_",g[3]));
   fi;

   test2(tmp);
   test2(tmp);
   test2(tmp);
od;


############################################################################
##
#E
##
