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
Version := "CRISP_VERSION",
Date := "CRISP_DATE",
License := "BSD-2-Clause",

BannerString := "\
----------------------------------------------------------------------\n\
                        CRISP Version CRISP_VERSION\n\
  Computing with Radicals, Injectors, Schunck classes and Projectors\n\
                         by Burkhard Höfling\n\
----------------------------------------------------------------------\n",

ArchiveURL := "https://github.com/bh11/crisp/releases/latest/download/crisp-CRISP_VERSION",

ArchiveFormats := ".tar.bz2", # the others are generated automatically
BinaryFiles := ["doc/manual.pdf"],

Persons := [
  rec(
  LastName := "Höfling",
  FirstNames := "Burkhard",
  IsAuthor := true,
  IsMaintainer := true,
  Email := "burkhard@hoefling.name"
  )
# provide such a record for each author and/or maintainer ...
  
],

Status := "accepted",
CommunicatedBy := "Joachim Neubüser (Aachen)",
AcceptDate := "12/2000",

README_URL := "https://github.com/bh11/crisp/releases/latest/download/README.txt",
PackageInfoURL := "https://github.com/bh11/crisp/releases/latest/download/PackageInfo.g",

AbstractHTML := "The <span class=\"pkgname\">GAP</span> package <span \
class=\"pkgname\">CRISP</span> provides algorithms for computing \
subgroups of finite soluble groups related to a group class \
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
normal subgroups of a finite soluble group, its characteristic \
subgroups, minimal normal subgroups and the socle and \
<i>p</i>-socles for given primes <i>p</i>.",

PackageWWWHome := "https://github.com/bh11/crisp/",
                  
PackageDoc := rec(
  BookName := "CRISP",
  # format/extension can be one of .zoo, .tar.gz, .tar.bz2, -win.zip
  ArchiveURLSubset := ["doc", "htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile := "doc/manual.pdf",
  # the path to the .six file used by GAP's help system
  SixFile := "doc/manual.six",
  # a longer title of the book, this together with the book name should
  # fit on a single text line (appears with the '?books' command in GAP)
  LongTitle := "Computing Radicals, Injectors, Projectors of soluble groups",
),


Dependencies := rec(
  # GAP version, use version strings for specifying exact versions,
  # prepend a '>=' for specifying a least version.
  GAP := ">=4.12",
  # NeededOtherPackages := [["GAPDoc", ">= 0.99"]],
  NeededOtherPackages := [],
  SuggestedOtherPackages := [],
  # needed external conditions (programs, operating system, ...)  provide 
  # just strings as text or
  ExternalConditions := []
                      
),
AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := ["radical", "residual", "projector", "injector",
   "formation", "Fitting class", "Fitting set", "Schunck class",
   "group class", "normal subgropus", "minimal normal subgropus", "socle"],

SourceRepository := rec(Type := "git",
                        URL := "https://github.com/bh11/crisp.git"),

IssueTrackerURL := "https://github.com/bh11/crisp/issues"

));


