#############################################################################
####
##
#A  anupga.gd                ANUPQ share package                 Frank Celler
#A                                                           & Eamonn O'Brien
#A                                                           & Benedikt Rothe
##
##  Declaration file for p-group generation of automorphism  group  functions
##  and variables.
##
#H  @(#)$Id$
##
#Y  Copyright 1992-2001,  Lehrstuhl D fuer Mathematik,  RWTH Aachen,  Germany
#Y  Copyright 1992-1994,  School of Mathematical Sciences, ANU,     Australia
##
Revision.anupga_gd :=
    "@(#)$Id$";

#############################################################################
##
#F  ANUPQerror( <param> ) . . . . . . . . . . . . . .report illegal parameter
##
DeclareGlobalFunction( "ANUPQerror" );

#############################################################################
##
#F  ANUPQextractArgs( <args>) . . . . . . . . . . . . . . parse argument list
##
DeclareGlobalFunction( "ANUPQextractArgs" );

#############################################################################
##
#F  ANUPQinstructions( <pqi>, <param>, <p> )  . . . . . .  construct PQ input
##
DeclareGlobalFunction( "ANUPQinstructions" );

#############################################################################
##
#F  ANUPQauto( <G>, <gens>, <imgs> )  . . . . . . . .  construct automorphism
##
DeclareGlobalFunction( "ANUPQauto" );

#############################################################################
##
#F  ANUPQautoList( <G>, <gens>, <L> ) . . . . . . . construct a list of autos
##
DeclareGlobalFunction( "ANUPQautoList" );

#############################################################################
##
#F  ANUPQSetAutomorphismGroup( <G>, <gens>, <automs>, <isSoluble> ) 
##
DeclareGlobalFunction( "ANUPQSetAutomorphismGroup" );

#############################################################################
##
#F  ANUPQprintExps( <pqi>, <lst> ) . . . . . . . . . . .  print exponent list
##
DeclareGlobalFunction( "ANUPQprintExps" );

#############################################################################
##
#V  ANUPGAGlobalVariables
##
DeclareGlobalVariable( "ANUPGAGlobalVariables",
  "A list of strings representing names of p-group aut. grp global variables"
  );

#############################################################################
##
#F  PqList( <file> ) . . . . . . . . . . . . . . .  get a list of descendants
##
DeclareGlobalFunction( "PqList" );

#############################################################################
##
#F  PqLetterInt( <n> ) . . . . . . . . . . . . . . . 
##
DeclareGlobalFunction( "PqLetterInt" );

#############################################################################
##
#F  PQ_DESCENDANTS( <arglist> : <options> ) . .  construct descendants of <G>
##
DeclareGlobalFunction( "PQ_DESCENDANTS" );

#############################################################################
##
#F  PqDescendants( <G>, ... ) . . . . . . . . .  construct descendants of <G>
##
DeclareGlobalFunction( "PqDescendants" );

#############################################################################
##
#F  SavePqList( <file>, <lst> ) . . . . . . . . .  save a list of descendants
##
DeclareGlobalFunction( "SavePqList" );

#E  anupga.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here 