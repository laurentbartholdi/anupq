#############################################################################
####
##
#W  anupqopt.gi             ANUPQ Share Package                 Werner Nickel
#W                                                                Greg Gamble
##
##  Install file for functions to do with option manipulation.
##    
#H  @(#)$Id$
##
#Y  Copyright (C) 2001  Lehrstuhl D fuer Mathematik,  RWTH Aachen,  Germany
##
Revision.anupqopt_gi :=
    "@(#)$Id$";

#############################################################################
##
#V  PQ_FUNCTION . . . . . . . . . internal functions called by user functions 
##
##  A record whose fields are (function)  names  and  whose  values  are  the
##  internal functions called by the functions with those names.
##
InstallValue( PQ_FUNCTION, 
              rec( Pq                   := PQ_EPIMORPHISM,
                   PqDescendants        := PQ_DESCENDANTS,
                   StandardPresentation := PQ_EPIMORPHISM_STANDARD_PRESENTATION
                  )
             );

#############################################################################
##
#V  ANUPQoptions  . . . . . . . . . . . . . . . . . . . .  admissible options
##
##  A record of lists of names of admissible ANUPQ options. Each field is the
##  name of an ANUPQ function and the corresponding  value  is  the  list  of
##  names of admissible for the function.
##
InstallValue( ANUPQoptions, 
              rec( # options for `Pq' and `PqEpimorphism'
                   Pq  := [ "Prime", 
                            "ClassBound", 
                            "Exponent", 
                            "Metabelian", 
                            "OutputLevel", 
                            "Verbose", 
                            "SetupFile",
                            "PqWorkspace" ],

                   # options for `PqDescendants'
                   PqDescendants
                       := [ "ClassBound", 
                            "OrderBound", 
                            "StepSize", 
                            "PcgsAutomorphisms", 
                            "RankInitialSegmentSubgroups", 
                            "SpaceEfficient", 
                            "AllDescendants", 
                            "Exponent", 
                            "Metabelian", 
                            "SubList", 
                            "TmpDir", 
                            "Verbose", 
                            "SetupFile" ],

                   # options for `[Epimorphism][Pq]StandardPresentation'
                   StandardPresentation
                       := [ "Prime", 
                            "ClassBound", 
                            "PcgsAutomorphisms", 
                            "Exponent", 
                            "Metabelian", 
                            "OutputLevel", 
                            "TmpDir",
                            "Verbose", 
                            "SetupFile" ]
                  )
             );

#############################################################################
##
#V  ANUPQoptionChecks . . . . . . . . . . . the checks for admissible options
##
##  A record whose fields are the names of admissible ANUPQ options and whose
##  values are one-argument functions that return `true' when given  a  value
##  that is a valid value for the option, and `false' otherwise.
##
InstallValue( ANUPQoptionChecks,
              rec( Prime := x -> IsInt(x) and IsPrimeInt(x),
                   ClassBound := IsPosInt,
                   OrderBound := IsPosInt,
                   Exponent   := IsPosInt,
                   Metabelian := IsBool,
                   OutputLevel := x -> x in [0..3],
                   Verbose    := IsBool,
                   SetupFile  := IsString,
                   PqWorkspace := IsPosInt,
                   Stepsize := x -> IsPosInt(x) or
                                    (IsList(x) and ForAll(x, IsPosInt)), 
                   PcgsAutomorphisms := IsBool,
                   RankInitialSegmentSubgroups := x -> x = 0 or IsPosInt(x),
                   SpaceEfficient := IsBool,
                   AllDescendants := IsBool,
                   SubList := x -> IsPosInt(x) or
                                   (IsSet(x) and ForAll(x, IsInt)
                                    and IsPosInt(x[1])),
                   TmpDir := IsString
                   )
             );

#############################################################################
##
#V  ANUPQoptionTypes . . . . . .  the types (in words) for admissible options
##
##  A record whose fields are the names of admissible ANUPQ options and whose
##  values are valid types of the options in plain words.
##
InstallValue( ANUPQoptionTypes,
              rec( Prime := "prime integer",
                   ClassBound := "positive integer",
                   OrderBound := "positive integer",
                   Exponent   := "positive integer",
                   Metabelian := "boolean",
                   OutputLevel := "integer in [0..3]",
                   Verbose    := "boolean",
                   SetupFile  := "string",
                   PqWorkspace := "positive integer",
                   Stepsize := "positive integer or positive integer list",
                   PcgsAutomorphisms := "boolean",
                   RankInitialSegmentSubgroups := "nonnegative integer",
                   SpaceEfficient := "boolean",
                   AllDescendants := "boolean",
                   SubList 
                       := "pos've integer or increasing pos've integer list",
                   TmpDir := "string"
                   )
             );

#############################################################################
##
#F  VALUE_PQ_OPTION( <optname> ) . . . . . . . . . enhancement of ValueOption
#F  VALUE_PQ_OPTION( <optname>, <defaultval> ) 
#F  VALUE_PQ_OPTION( <optname>, <datarec> ) 
#F  VALUE_PQ_OPTION( <optname>, <defaultval>, <datarec> ) 
##
##  If the value <optval> of <optname> is not `fail' and it is  an  ok  value
##  for <optname> then <optval> is returned; if <optval> is not an  ok  value
##  an error is  signalled.  If  <optval>  is  `fail'  and  a  default  value
##  <defaultval> different from  `fail'  is  supplied  then  <defaultval>  is
##  returned. Supplying a <defaultval> of `fail'  is  special;  it  indicates
##  that option <optname> must have a value i.e. <optval> is not  allowed  to
##  be `fail' and if it is an error is signalled. If a <datarec> argument  is
##  supplied, which must be a record, then the return value,  if  not  `fail'
##  and a legal value, is also stored in `<datarec>.(<optname>)'.
##
##  *Note:* <defaultval> cannot be a record.
##
InstallGlobalFunction(VALUE_PQ_OPTION, function(arg)
local optname, optval, defaultval, len;
  optname := arg[1];
  optval := ValueOption(optname);
  len := Length(arg);
  if optval = fail then
    if 2 <= len and not IsRecord(arg[2]) then
      defaultval := arg[2];
      if defaultval = fail then
        Error("you must supply a value for option: \"", optname, "\"\n");
      fi;
      if 3 = len then
        arg[3].(optname) := defaultval;
      fi;
      return defaultval;
    fi;
    return optval;
  elif not ANUPQoptionChecks.(optname)(optval) then
    Error("\"", optname, "\" value must be a ", 
          ANUPQoptionTypes.(optname), "\n");
  fi;
  if 2 <= len and IsRecord( arg[len] ) then
    arg[len].(optname) := optval;
  fi;
  return optval;
end);
  
#############################################################################
##
#F  SET_ANUPQ_OPTIONS( <funcname>, <fnname> )  . set options from OptionStack
##    
##  When called by a function with name  <funcname>  sets  the  options  from
##  `OptionsStack'    checking    that    they    are     a     subset     of
##  `ANUPQoptions.<fnname>'. Both <funcname> and <fnname> should be strings.
##
InstallGlobalFunction( SET_ANUPQ_OPTIONS, function( funcname, fnname )
    local optrec, optnames, opt;

    # there should be options
    if IsEmpty( OptionsStack ) then
        # no options??
        optrec := rec();
        Info( InfoANUPQ, 1, funcname, " called with no options!" );
    else
        optrec := ShallowCopy( OptionsStack[ Length( OptionsStack ) ] );
        optnames := Set( REC_NAMES(optrec) );
        SubtractSet( optnames, Set( ANUPQoptions.(fnname) ) );
        Info( InfoANUPQ, 2, funcname, " called with options: ", 
                            OptionsStack[ Length( OptionsStack ) ] );
        if 0 < Length(optnames) then
            # it's not an error to have unknown options,
            # function may have been called recursively and the 
            # options may be intended for some other function
            Info( InfoWarning + InfoANUPQ, 2,
                  funcname, " called with unknown options: ", optnames);
        fi;
        for opt in optnames do
            Unbind( optrec.(opt) );
        od;
    fi;
    return optrec;
end );

#############################################################################
##
#F  ANUPQoptError( <funcname>, <illegal> )  . . . . . create an error message
##
##  creates an error message  for  the  function  with  name  <funcname>.  If
##  <illegal> is a string it is taken to be  the  first  line  of  the  error
##  message. Otherwise <illegal> should be alist of illegal options (strings)
##  found. The error message (string) returned also gives the list  of  valid
##  options together with the value types expected for function <funcname>.
##
InstallGlobalFunction( ANUPQoptError, function( funcname, illegal )
    local Optstring, Valstring, errmsg, optname;

    Optstring := optname -> Concatenation("\"", optname, "\"");
    Valstring := optval  -> Concatenation("<",  optval,  ">");

    if IsString(illegal) then
        errmsg := illegal;
    else # IsList(illegal)
        errmsg := Concatenation("Illegal ", funcname, " option");
        if Length(illegal) > 1 then
            Append(errmsg, "s");
        fi;
        Append(errmsg, ": ");
        Append(errmsg, JoinStringsWithSeparator( List(illegal, Optstring) ));
    fi;
    Append(errmsg, Concatenation(".\nValid ", funcname, " options:\n"));
    for optname in ANUPQoptions.(funcname) do
        Append(errmsg, "    ");
        Append(errmsg, Optstring(optname));
        if ANUPQoptionChecks.(optname) <> IsBool then
            Append(errmsg, ", ");
            Append(errmsg, Valstring( ANUPQoptionTypes.(optname) ));
        fi;
        Append(errmsg, "\n");
    od;
    return errmsg;
end );

#############################################################################
##
#F  ANUPQextractOptions( <funcname>, <args> ) . . . . . . . . extract options
##
##  extracts options from  <args>  for  function  with  name  <funcname>  and
##  returns a record suitable for use with `PushOptions'.  Abbreviations  are
##  allowed for option names so long as  each  abbreviates  a  unique  option
##  name.
##
InstallGlobalFunction( ANUPQextractOptions, function(funcname, args)
    local   Match, error, optrec, i, optname;

    # allow to give only a prefix
    Match := function( argi )
        local matches;
        if IsString(argi) then
            matches := Filtered(ANUPQoptions.(funcname), 
                                optname -> 0 < Length(argi) and
                                           Length(argi) <= Length(optname) and
                                           optname{[1..Length(argi)]} = argi);
            if 1 = Length(matches) then
                return matches[1];
            fi;
            error := Concatenation( "argument: \"", argi, 
                                    "\" doesn't abbreviate a unique option");
        else
            error := Concatenation( "argument: ", String(argi),
                                    " is not a (non-null) string (option name)"
                                    );
        fi;
        return fail;
    end;

    # extract options from args
    optrec := rec();
    i := 1;
    while i <= Length(args)  do
        optname := Match( args[i] );
        if optname = fail then 
            Error( ANUPQoptError( funcname, error ) );
        elif ANUPQoptionChecks.(optname) = IsBool then
            optrec.(optname) := true;
            i := i + 1;
        elif i = Length(args) then
            # all remaining options are non-boolean and expect a value to
            # follow
            Error( ANUPQoptError( 
                       funcname,
                       Concatenation( "Expected value for option: ", args[i] )
                       ) );
        else
            # checking values are ok is done later
            optrec.(optname) := args[i + 1];
            i := i + 2;
        fi;
    od;
    return optrec;

end );

#E  anupqopt.gi . . . . . . . . . . . . . . . . . . . . . . . . . . ends here 