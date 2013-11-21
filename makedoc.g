LoadPackage("AutoDoc");

# AutoDoc(
#     "anupq" : gapdoc := rec(main:="main")
# );

AutoDoc("anupq" :
    scaffold := rec(
        includes := [
            "intro.xml",
            "basics.xml",
            #"infra.xml",
            #"anupq.xml",
            #"interact.xml",
            #"options.xml",
            #"install.xml",
            ],
        entities := [
            "ANUPQ",
            "AutPGrp",
        ],
    )
);

QUIT;
