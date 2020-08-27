local A                                                = Action
local PR                                             = A[A.PlayerClass]
local L                                             = {
    MOUSEOVER                 = { enUS = "Use\n@mouseover", 
    ruRU = "????????????\n@mouseover" },
    MOUSEOVERTT             = { enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
    ruRU = "???????????? ????????????? ???????? ??? @mouseover ??????\n????????: ???????????, ??????" },
    TARGETTARGET            = { enUS = "Use\n@targettarget",
    ruRU = "????????????\n@targettarget" },
    TARGETTARGETTT            = { enUS = "Will unlock use actions\nfor enemy @targettarget units",
    ruRU = "???????????? ?????????????\n???????? ??? ????????? @targettarget ??????" },
    AOE                     = { enUS = "Use\nAoE",
    ruRU = "????????????\nAoE" },
    AOETT                     = { enUS = "Enable multiunits actions",
    ruRU = "???????? ???????? ??? ?????????? ?????" },
    PASSIVEROTATION            = { enUS = "Use\nPassive\nRotation",
    ruRU = "????????\n?????????\n???????" },
    SHARED                    = { enUS = "Shared",
    ruRU = "?????" },
    SELFPOWS                = { enUS = "Self\nPower Word: Shield",
    ruRU = "?? ????\n????? ????: ???" },
    SELFPOWSTT                = { enUS = "Shadow: Will use on self while target an enemy\nHealer: Will use on self to prevent damage interrupts while casting",
    ruRU = "????: ????? ???????????? ?? ???? ???? ? ???? ?????????\n??????: ????? ???????????? ?? ???? ??? ??????????? ?????????? ???????????? ??????" },    
    LOC_TT                    = { enUS = "It will be used in the desired rotation order to remove the available effects of loss of control over the character",
    ruRU = "????? ???????????? ? ?????? ??????? ??????? ??? ?????? ????????? ???????? ?????? ???????? ??? ??????????" },                            
    USERACIAL_LOC            = { enUS = "Auto Racial\nLoss of Control",
    ruRU = "???? ???????\n?????? ????????" },                            
    RUNES                    = { enUS = "Mana Runes\n(% your mana)",
    ruRU = "???? ????\n(% ????? ????)" },
    POTIONTOUSE                = { enUS = "Used potion:",
    ruRU = "???????????? ?????:" },                                
    MANAPOTION                = { enUS = "Mana Potion\n(% your mana)",
    ruRU = "????? ????\n(% ????? ????)" },    
    MANAPOTIONTT            = { enUS = "Only if used potion is " .. PR.MajorManaPotion:Info(),
        ruRU = "?????? ???? ???????????? ????? ????????" .. PR.MajorManaPotion:Info() },                        
    STARTBYPRECAST            = { enUS = "Begin Combat\nBy PreCast",
    ruRU = "???????? ???\n??????? ?????????" },
    STARTBYPRECASTTT        = { enUS = "Will start rotation on enemy by available logner\ncasting spell depended on your spec",
    ruRU = "????? ???????? ??????? ?? ?????????? ? ?????????\n??????? ?????????????? ??????????? ? ??????????? ?? ?????" }, 
    DEFENSEABILITIES        = { enUS = "Defense Abilities",
    ruRU = "??????????? ??????" },                
    FEEDBACK                = { enUS = PR.Feedback:Info() .. "\n(Inc.Magic Damage %)",
        ruRU = PR.Feedback:Info() .. "\n(????.?????. ???? %)" },
    TRINKETS                = { enUS = "Trinkets",
    ruRU = "??????????" },                
    TRINKETBURSTHEALING        = { enUS = "Healer: Target Health (%)",
    ruRU = "??????: ???????? ???? (%)" },        
    TRINKETBURSTSYNCUP        = { enUS = "Damager: How to use trinkets",
    ruRU = "????: ??? ???????????? ??????????" },
    TRINKETBURSTSYNCUPTT     = { enUS = "Always: On cooldown\nBurst Synchronized: By Burst Mode in 'General' tab",
    ruRU = "??????: ?? ???????????\n???????????????? ??????: ?? ?????? ??????? ?? ??????? '?????'" },    
    TRYTOFINDINVISIBLE        = { enUS = "Try To\nFind Invisible",
    ruRU = "????????\n????? ?????????" },    
    TRYTOFINDINVISIBLETT     = { enUS = "Will use out of combat Holy Nova (Rank 1) and Perception\nAs soon as any one around entered combat and in enemy team exist stealthed units\nAlso will use Perception by react on used stealth spells around",
    ruRU = "????? ???????????? ??? ??? ?????? ????? (??????? 1) ? ??????????????\n??? ?????? ???-?????? ?????????? ?????? ? ??? ? ? ??????? ?????????? ???? ??????? ?????\n????? ?????????? ?????????????? ?? ??????? ?????????????? ??????????? ??????????? ?????" },                        
    SHADOW                    = { enUS = "Shadow",
    ruRU = "????" },        
    WEAVINGSSTACKING        = { enUS = "Begin Combat By\nS.Weaving Stacking",
    ruRU = "???????? ??? c\n?.???? ????????????" },
    WEAVINGSSTACKINGTT        = { enUS = "If taken talent 'Shadow Weaving' then each fight will be begin with\nstacking 5 debuffs on a boss or enemy player",
    ruRU = "???? ???? ?????? '???????? ????', ?? ????? ?????? ??? ????????\n? ?????????? 5-?? ???????? ?? ????? ??? ?????????? ??????" },        
    CANCELSHADOWFORM        = { enUS = "Auto Cancel Shadowform",
    ruRU = "???? ?????? ?????? ????" },                        
    CANCELSHADOWFORMTT        = { enUS = "Will try cancel aura of Shadowform if it's required to use\nsome spells which are unavailable by school",
    ruRU = "????? ???????? ???????? ?????? ?????? ???? ??? ?????????????\n???????????? ???????????? ??????????? ??????????? ?????" },
    BYPASSMINDBLAST            = { enUS = "Mind Blast\nWill stop channeling",
    ruRU = "????? ??????\n????????? ?????????" },    
    MINDFLAYTIMING            = { enUS = "Mind Flay\nMind Blast timed",
    ruRU = "????? ??????\n???????? ??????? ??????" },        
    MINDFLAYTIMINGTT        = { enUS = "Mind Flay will not be used if Mind Blast will be up within next GCD",
    ruRU = "????? ?????? ?? ???????????? ???? ?? ??? ???????? ?????????????? ????? ??????" },    
    DOUBLECASTMINDFLAY        = { enUS = "Mind Flay\nDouble cast",
    ruRU = "????? ??????\n??????? ?????????????" },    
    DOUBLECASTMINDFLAYTT     = { enUS = "Mind Flay will be casted twice in a row to increase total ticks\nDEV Note:\nI didn't figured out if that worked on Classic or not, seems not\nAt least it will waste mana and cast can be interrupted by Mind Blast\nSo feel free to decide for yourself what better for you",
    ruRU = "????? ?????? ????? ???????????? ?????? ? ?????? ??? ?????????? ??????\n??????????? ????????????:\n? ??? ? ?? ????? ???????? ?? ??? ? ???????? ??? ???, ?????? ??? ???\n? ????? ?????? ??? ????? ??????????? ????????????? ???? ? ???????????? ????? ???? ???????? ??????? ??????\n??????? ?????????? ???? ????????, ????? ??????????? ? ?????? ??? ???? ??? ????? ?????" },                                
    HEALER                    = { enUS = "Healer",
    ruRU = "??????" },    
    PREPAREPOWS                = { enUS = "Pre Pare\nPower Word: Shield",
    ruRU = "???????????\n????? ????: ???" },    
    PREPAREPOWSTT            = { enUS = "If enabled then Power Word: Shield will be used on everyone party and raid member\nRight mouse click: Create macro and use during fight whenever you need",
    ruRU = "???? ????????, ?? ????? ????: ??? ????? ??????????? ?? ?????? ????????? ?????? ? ?????\n?????? ?????? ?????: ??????? ?????? ? ??????????? ? ??? ????? ????? ??? ?????" },                            
    PREPARERENEW            = { enUS = "Pre Pare\nRenew",
    ruRU = "???????????\n??????????" },    
    PREPARERENEWTT            = { enUS = "If enabled then Renew will be used on everyone party and raid member\nRight mouse click: Create macro and use during fight whenever you need",
    ruRU = "???? ????????, ?? ?????????? ????? ???????????? ?? ?????? ????????? ?????? ? ?????\n?????? ?????? ?????: ??????? ?????? ? ??????????? ? ??? ????? ????? ??? ?????" },
    POWERINFUSION            = { enUS = "Power Infusion - Units",
    ruRU = "???????? ??? - ????" },    
    HEALERAOE                = { enUS = "Healer AoE",
    ruRU = "?????? AoE" },                            
    PRAYEROFHEALINGUNITS    = { enUS = PR.PrayerofHealing:Info() .. "\nUnit Counter",
        ruRU = PR.PrayerofHealing:Info() .. "\n???-?? ?????" },        
    HOLYNOVAUNITS            = { enUS = PR.HolyNova:Info() .. "\nUnit Counter",
        ruRU = PR.HolyNova:Info() .. "\n???-?? ?????" },    
    HOLYNOVAPOWS            = { ANY  = PR.HolyNova:Info() .. " & " .. PR.PowerWordShield:Info() },    
    RENEWONLYTANK            = { enUS = PR.Renew:Info() .. " (Tank Only)",
        ruRU = PR.Renew:Info() .. " (?????? ????)" },    
    RENEWONLYTANKTT            = { enUS = "This toggle is also affected by the state of 'Pre Pare Renew'",
    ruRU = "?? ????  ????????????? ????? ?????? ????????? '??????????? ??????????'" },    
    ALWAYS                     = { enUS = "Always",
    ruRU = "??????" },
    BURST_SYNC                 = { enUS = "Burst Synchronized",
    ruRU = "???????????????? ??????" },                            
    SELF                     = { enUS = "Self",
    ruRU = "????" },
    DAMAGER                 = { enUS = "Damager",
    ruRU = "???????" },
    HEALER                     = { enUS = "Healer",
    ruRU = "??????" },
    ENEMY                     = { enUS = "Enemy",
    ruRU = "?????????" },                            
}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v14 (04.02.2020)",
    [2]                                             = { LayoutOptions = { gutter = 6, padding = { left = 10, right = 10 } } },
    [7]                                                = {
        ["kick"] = { Enabled = true, Key = "Silence", LUAVER = 1, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "KickImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"}
                return     Obj.Silence and 
                        Obj.Silence:IsReadyM(thisunit) and 
                        Obj.Silence:AbsentImun(thisunit, Temp) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
                        Unit(thisunit):IsControlAble("silence") and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
            ]] },
        ["fear"] = { Enabled = true, Key = "PsychicScream", LUAVER = 3, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "FearImun"}
                return     Obj.PsychicScream and 
                        Obj.PsychicScream:IsReadyM() and 
                        (
                            MultiUnits:GetByRange(8, 1) >= 1 or 
                            (
                                Obj.PsychicScream:IsReadyM(thisunit, true) and 
                                Obj.PsychicScream:AbsentImun(thisunit, Temp) and 
                                Unit(thisunit):IsControlAble("fear") and 
                                Unit(thisunit):GetRange() <= 8 and 
                                LossOfControl:IsMissed("SILENCE") and 
                                LossOfControl:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
                            )
                        )
            ]] },
    },
}
A.Data.ProfileUI[2][1]                                = {
    {
        E         = "Checkbox", 
        DB         = "mouseover",
        DBV     = true,
        L         = L.MOUSEOVER,
        TT         = L.MOUSEOVERTT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "targettarget",
        DBV     = true,
        L         = L.TARGETTARGET,
        TT         = L.TARGETTARGETTT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "AoE",
        DBV     = true,
        L         = L.AOE,
        TT         = L.AOETT,
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "UseRotationPassive",
        DBV     = true,
        L         = L.PASSIVEROTATION,
        M         = {},
    },    
}
A.Data.ProfileUI[2][2]                                = {    -- Shared 
    {
        E         = "Header",
        L         = L.SHARED, 
    },
}
A.Data.ProfileUI[2][3]                                = {
    {
        E         = "Checkbox", 
        DB         = "SelfPOWS",
        DBV     = true,
        L         = L.SELFPOWS,
        TT         = L.SELFPOWSTT,
        M         = {},
    },        
    {
        E         = "Checkbox", 
        DB         = "StartByPreCast",
        DBV     = true,
        L         = L.STARTBYPRECAST,
        TT         = L.STARTBYPRECASTTT,
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "UseRacial-LoC",
        DBV     = true,
        L         = L.USERACIAL_LOC,
        TT        = L.LOC_TT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "Runes",
        DBV     = 100,
        ONOFF     = true,
        L         = L.RUNES,
        M         = {},
    },    
}
A.Data.ProfileUI[2][4]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "OFF",                                     value = "OFF"                             },
            { text = PR.MajorManaPotion:Info(),                 value = "MajorManaPotion"                 },
            { text = PR.HealingPotion:Info(),                     value = "HealingPotion"                 },
            { text = PR.LimitedInvulnerabilityPotion:Info(),     value = "LimitedInvulnerabilityPotion"    },
            { text = PR.LivingActionPotion:Info(),                 value = "LivingActionPotion"             },
            { text = PR.RestorativePotion:Info(),                 value = "RestorativePotion"             },
            { text = PR.SwiftnessPotion:Info(),                 value = "SwiftnessPotion"                 },
        },
        DB         = "PotionToUse",
        DBV     = "MajorManaPotion",
        L         = L.POTIONTOUSE,
        TT         = {
            enUS = A.LTrim([[    Use the selected potion as the main
                                Do not forget to update the macro!
                                
                                HealingPotion macro:
                                /use Major Healing Potion
                                /use Superior Healing Potion
                                /use Greater Healing Potion
                                /use Healing Potion
                                /use Lesser Healing Potion
                                /use Minor Healing Potion
            ]]),
            ruRU = A.LTrim([[    ???????????? ????????? ?e??? ? ???????? ?????????
                                ?? ???????? ???????? ??????!
                                
                                ?????? ????? ?????????:
                                /use ??????? ???????? ?????
                                /use ????????? ???????? ?????
                                /use ??????? ???????? ?????
                                /use ???????? ?????
                                /use ??????? ???????? ?????
                                /use ?????? ???????? ?????
            ]]),
        },
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "ManaPotion",
        DBV     = 45,
        ONOFF    = false,
        L         = L.MANAPOTION,
        TT        = L.MANAPOTIONTT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][5]                                = {    -- Defense
    {
        E         = "Header",
        L         = L.DEFENSEABILITIES, 
    },
}
A.Data.ProfileUI[2][6]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DesperatePrayer",
        DBV     = 100,
        ONOFF     = true,
        L = { 
            ANY = PR.DesperatePrayer:Info() .. " (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "FeedbackIncomingMagic",
        DBV     = 100,
        ONOFF     = true,
        L         = L.FEEDBACK,
        M         = {},
    },
}
A.Data.ProfileUI[2][7]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "Stoneform",
        DBV     = 100,
        ONOFF     = true,
        L = { 
            ANY = PR.Stoneform:Info() .. " (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "ElunesGrace",
        DBV     = 100,
        ONOFF     = true,
        L = { 
            ANY = PR.ElunesGrace:Info() .. " (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][8]                                = {
    {
        E         = "Header",
        L         = L.TRINKETS,
    },
}
A.Data.ProfileUI[2][9]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.ALWAYS,         value = "Always" },
            { text = L.BURST_SYNC,     value = "BurstSync" },                    
        },
        DB         = "TrinketBurstSyncUP",
        DBV     = "Always",
        L         = L.TRINKETBURSTSYNCUP,
        TT         = L.TRINKETBURSTSYNCUPTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "TrinketBurstHealing",
        DBV     = 100,
        ONLYOFF = true,
        L         = L.TRINKETBURSTHEALING,
        M         = {},
    },    
}
A.Data.ProfileUI[2][10]                                = {    -- PvP
    {
        E         = "Header",
        L         = {
            ANY = "PvP",
        },
    },
}
A.Data.ProfileUI[2][11]                                = {
    {
        E         = "Checkbox", 
        DB         = "TryToFindInvisible",
        DBV     = true,
        L         = L.TRYTOFINDINVISIBLE,
        TT         = L.TRYTOFINDINVISIBLETT,
        M         = {},
    },    
    --[[{
        E         = "LayoutSpace",
    },]]
}
A.Data.ProfileUI[2][12]                                = { -- Shadow 
    {
        E         = "Header",
        L         = L.SHADOW,
    },
}
A.Data.ProfileUI[2][13]                                = {
    {
        E         = "Checkbox", 
        DB         = "StartByShadowWeavingsStacking",
        DBV     = false,
        L         = L.WEAVINGSSTACKING,
        TT         = L.WEAVINGSSTACKINGTT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "CancelShadowForm",
        DBV     = false,
        L         = L.CANCELSHADOWFORM,
        TT         = L.CANCELSHADOWFORMTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][14]                                = {
    {
        E         = "Checkbox", 
        DB         = "ByPassMindBlast",
        DBV     = true,
        L         = L.BYPASSMINDBLAST,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "MindFlayTiming",
        DBV     = true,
        L         = L.MINDFLAYTIMING,
        TT         = L.MINDFLAYTIMINGTT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "DoubleCastMindFlay",
        DBV     = false,
        L         = L.DOUBLECASTMINDFLAY,
        TT         = L.DOUBLECASTMINDFLAYTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][15]                                = { -- Healer 
    {
        E         = "Header",
        L         = L.HEALER,
    },
}
A.Data.ProfileUI[2][16]                                = {
    {
        E         = "Checkbox", 
        DB         = "PreParePOWS",
        DBV     = false,
        L         = L.PREPAREPOWS,
        TT         = L.PREPAREPOWSTT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "PrePareRenew",
        DBV     = false,
        L         = L.PREPARERENEW,
        TT         = L.PREPARERENEWTT,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.SELF,     value = 1 },
            { text = L.DAMAGER, value = 2 },
            { text = L.HEALER,     value = 3 },
            { text = L.ENEMY,     value = 4 },
        },
        MULT     = true,        
        DB         = "PowerInfusionUnits",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = false,
        }, 
        L         = L.POWERINFUSION,
        SetPlaceholder = { ANY = "OFF" },
        M         = {},
    },    
}
A.Data.ProfileUI[2][17]                                = { -- Healer AoE 
    {
        E         = "Header",
        L         = L.HEALERAOE,
    },
}
A.Data.ProfileUI[2][18]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 6,                            
        DB         = "PrayerofHealingUnits",
        DBV     = 6,
        ONLYON     = true,
        L         = L.PRAYEROFHEALINGUNITS, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 41,                            
        DB         = "HolyNovaUnits",
        DBV     = 41,
        ONLYON     = true,
        L         = L.HOLYNOVAUNITS,
        M         = {},
    },
}
A.Data.ProfileUI[2][19]                                = { -- PrayerofHealing 
    {
        E         = "Header",
        L         = { ANY  = PR.PrayerofHealing:Info() },
    },
}
A.Data.ProfileUI[2][20]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "PrayerofHealing1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.PrayerofHealing:Info() .. "\n#1 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "PrayerofHealing2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.PrayerofHealing:Info() .. "\n#2 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "PrayerofHealing3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.PrayerofHealing:Info() .. "\n#3 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][21]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "PrayerofHealing4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.PrayerofHealing:Info() .. "\n#4 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "PrayerofHealing5",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.PrayerofHealing:Info() .. "\n#5 (%)",
        }, 
        M         = {},
    },
}
A.Data.ProfileUI[2][22]                                = { -- HolyNova & PoWS
    {
        E         = "Header",
        L         = L.HOLYNOVAPOWS,
    },
}
A.Data.ProfileUI[2][23]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyNova",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.HolyNova:Info() .. " (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "PoWS",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.PowerWordShield:Info() .. " (%)",
        }, 
        M         = {},
    },
}
A.Data.ProfileUI[2][24]                                = { -- Renew 
    {
        E         = "Header",
        L         = { ANY  = PR.Renew:Info() },
    },
}
A.Data.ProfileUI[2][25]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#1 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#2 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#3 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][26]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#4 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew5",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#5 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew6",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#6 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][27]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew7",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#7 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew8",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#8 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew9",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#9 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][28]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Renew10",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Renew:Info() .. "\n#10 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "RenewOnlyTank",
        DBV     = false,
        L         = L.RENEWONLYTANK,
        TT         = L.RENEWONLYTANKTT,
        M         = {},
    },
    {
        E         = "LayoutSpace",                                                     
    },    
}
A.Data.ProfileUI[2][29]                                = { -- Heal 
    {
        E         = "Header",
        L         = { ANY  = PR.Heal:Info() },
    },
}
A.Data.ProfileUI[2][30]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Heal1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Heal:Info() .. "\n#1 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Heal2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Heal:Info() .. "\n#2 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][31]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Heal3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Heal:Info() .. "\n#3 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "Heal4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.Heal:Info() .. "\n#4 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][32]                                = { -- GreaterHeal 
    {
        E         = "Header",
        L         = { ANY  = PR.GreaterHeal:Info() },
    },
}
A.Data.ProfileUI[2][33]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "GreaterHeal1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.GreaterHeal:Info() .. "\n#1 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "GreaterHeal2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.GreaterHeal:Info() .. "\n#2 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "GreaterHeal3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.GreaterHeal:Info() .. "\n#3 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][34]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "GreaterHeal4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.GreaterHeal:Info() .. "\n#4 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "GreaterHeal5",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.GreaterHeal:Info() .. "\n#5 (%)",
        }, 
        M         = {},
    },
    {
        E         = "LayoutSpace",
    },    
}
A.Data.ProfileUI[2][35]                                = { -- FlashHeal 
    {
        E         = "Header",
        L         = { ANY  = PR.FlashHeal:Info() },
    },
}
A.Data.ProfileUI[2][36]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#1 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#2 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#3 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][37]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#4 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal5",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#5 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal6",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#6 (%)",
        }, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][38]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashHeal7",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.FlashHeal:Info() .. "\n#7 (%)",
        }, 
        M         = {},
    },
    {
        E         = "LayoutSpace",
    },
    {
        E         = "LayoutSpace",
    },    
}
A.Data.ProfileUI[2][39]                                = { -- LesserHeal 
    {
        E         = "Header",
        L         = { ANY  = PR.LesserHeal:Info() },
    },
}
A.Data.ProfileUI[2][40]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "LesserHeal1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.LesserHeal:Info() .. "\n#1 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "LesserHeal2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.LesserHeal:Info() .. "\n#2 (%)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "LesserHeal3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PR.LesserHeal:Info() .. "\n#3 (%)",
        }, 
        M         = {},
    },    
}
