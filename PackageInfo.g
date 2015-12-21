#############################################################################
##  
##  Packageinfo.g for CRISP package                       (Burkhard Höfling)
##
##  adapted from PackageInfo.g template by Frank Luebeck
##  

SetPackageInfo( rec(

##  This is case sensitive, use your preferred spelling.

PackageName := "CRISP",
Subtitle := "Computing with Radicals, Injectors, Schunck classes and Projectors",
Version := "1.4.1",

Date := "21/12/2015",

BannerString := Concatenation ("\
----------------------------------------------------------------------\n\
                        CRISP Version ", ~.Version, "\n\
  Computing with Radicals, Injectors, Schunck classes and Projectors\n\
                         by Burkhard Höfling\n\
----------------------------------------------------------------------\n"),

ArchiveURL := "http://www.icm.tu-bs.de/~bhoeflin/crisp/crisp-1r4n1",

ArchiveFormats := ".tar.bz2", # the others are generated automatically
BinaryFiles := ["doc/manual.pdf"],

Persons := [
  rec(
  LastName := "Höfling",
  FirstNames := "Burkhard",
  IsAuthor := true,
  IsMaintainer := true,
  WWWHome := "http://www.icm.tu-bs.de/~bhoeflin",
  Email := "b.hoefling@tu-bs.de"
  )
# provide such a record for each author and/or maintainer ...
  
],

Status := "accepted",
CommunicatedBy := "Joachim Neubüser (Aachen)",
AcceptDate := "12/2000",

README_URL := "http://www.icm.tu-bs.de/~bhoeflin/crisp/README",
PackageInfoURL := "http://www.icm.tu-bs.de/~bhoeflin/crisp/PackageInfo.g",

AbstractHTML := "The <span class=\"pkgname\">GAP</span> package <span \
class=\"pkgname\">CRISP</span> provides algorithms for computing \
subgroups of finite solvable groups related to a group class \
<i>C</i>. In particular, it allows to compute <i>C</i>-radicals and \
<i>C</i>-injectors for Fitting classes (and Fitting sets) <i>C</i>, \
<i>C</i>-residuals for formations <i>C</i>, and <i>C</i>-projectors \
for Schunck classes <i>C</i>. In order to carry out these \
computations, the group class <i>C</i> must be represented by an \
algorithm which can decide membership in the group class.</p> \
 \
<p>Moreover, <span class=\"pkgname\">CRISP</span> contains algorithms \
for the computation of normal subgroups invariant under a \
prescribed set of automorphisms and belonging to a given group \
class.</p> \
 \
<p>This includes an improved method to compute the set of all \
normal subgroups of a finite solvable group, its characteristic \
subgroups, minimal normal subgroups and the socle and \
<i>p</i>-socles for given primes <i>p</i>.",

PackageWWWHome := "http://www.icm.tu-bs.de/~bhoeflin/crisp/index.html",
                  
PackageDoc := rec(
  BookName := "CRISP",
  # format/extension can be one of .zoo, .tar.gz, .tar.bz2, -win.zip
  ArchiveURLSubset := ["doc", "html"],
  HTMLStart := "html/chapters.htm",
  PDFFile := "doc/manual.pdf",
  # the path to the .six file used by GAP's help system
  SixFile := "doc/manual.six",
  # a longer title of the book, this together with the book name should
  # fit on a single text line (appears with the '?books' command in GAP)
  LongTitle := "Computing Radicals, Injectors, Projectors of solvable groups",
  # Should this help book be autoloaded when GAP starts up? This should
  # usually be 'true', otherwise say 'false'. 
  Autoload := true
),


Dependencies := rec(
  # GAP version, use version strings for specifying exact versions,
  # prepend a '>=' for specifying a least version.
  GAP := ">=4.5",
  # NeededOtherPackages := [["GAPDoc", ">= 0.99"]],
  NeededOtherPackages := [],
  SuggestedOtherPackages := [],
  # needed external conditions (programs, operating system, ...)  provide 
  # just strings as text or
  ExternalConditions := []
                      
),

AvailabilityTest := ReturnTrue,

Autoload := true,

TestFile := "tst/test.tst",

Keywords := ["radical", "residual", "projector", "injector",
   "formation", "Fitting class", "Fitting set", "Schunck class",
   "group class", "normal subgropus", "minimal normal subgropus", "socle"]

));


