local A                                                = Action
local PR                                             = A[A.PlayerClass]
local L                                             = {
    MOUSEOVER                 = { enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover" },
    MOUSEOVERTT             = { enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг" },
    TARGETTARGET            = { enUS = "Use\n@targettarget",
    ruRU = "Использовать\n@targettarget" },
    TARGETTARGETTT            = { enUS = "Will unlock use actions\nfor enemy @targettarget units",
    ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов" },
    AOE                     = { enUS = "Use\nAoE",
    ruRU = "Использовать\nAoE" },
    AOETT                     = { enUS = "Enable multiunits actions",
    ruRU = "Включает действия для нескольких целей" },
    PASSIVEROTATION            = { enUS = "Use\nPassive\nRotation",
    ruRU = "Включить\nПассивную\nРотацию" },
    SHARED                    = { enUS = "Shared",
    ruRU = "Общее" },
    SELFPOWS                = { enUS = "Self\nPower Word: Shield",
    ruRU = "На себя\nСлово Силы: Щит" },
    SELFPOWSTT                = { enUS = "Shadow: Will use on self while target an enemy\nHealer: Will use on self to prevent damage interrupts while casting",
    ruRU = "Тьма: Будет использовать на себя пока в цели противник\nЛекарь: Будет использовать на себя для прекращения прерываний произнесения уроном" },
    MANAPOTION                = { enUS = "Use\nMana Potion",
    ruRU = "Использовать\nЗелье Маны" },    
    RUNES                    = { enUS = "Mana Runes\n(% your mana)",
    ruRU = "Руны Маны\n(% вашей маны)" },                            
    STARTBYPRECAST            = { enUS = "Begin Combat\nBy PreCast",
    ruRU = "Начинать Бой\nЗаранее произнося" },
    STARTBYPRECASTTT        = { enUS = "Will start rotation on enemy by available logner\ncasting spell depended on your spec",
    ruRU = "Будет начинать ротация на противнике с доступной\nдлинной произносящейся способности в зависимости от спека" }, 
    DEFENSEABILITIES        = { enUS = "Defense Abilities",
    ruRU = "Способности Защиты" },                
    FEEDBACK                = { enUS = PR.Feedback:Info() .. "\n(Inc.Magic Damage %)",
        ruRU = PR.Feedback:Info() .. "\n(Вход.Магич. Урон %)" },
    TRINKETS                = { enUS = "Trinkets",
    ruRU = "Аксессуары" },                
    TRINKETBURSTHEALING        = { enUS = "Healer: Target Health (%)",
    ruRU = "Лекарь: Здоровье Цели (%)" },        
    TRINKETBURSTSYNCUP        = { enUS = "Damager: How to use trinkets",
    ruRU = "Урон: Как использовать аксессуары" },
    TRINKETBURSTSYNCUPTT     = { enUS = "Always: On cooldown\nBurst Synchronized: By Burst Mode in 'General' tab",
    ruRU = "Always: По доступности\nBurst Synchronized: От Режима Бурстов во вкладке 'Общее'" },    
    TRYTOFINDINVISIBLE        = { enUS = "Try To\nFind Invisible",
    ruRU = "Пытаться\nНайти Невидимок" },    
    TRYTOFINDINVISIBLETT     = { enUS = "Will use out of combat Holy Nova (Rank 1) and Perception\nAs soon as any one around entered combat and in enemy team exist stealthed units\nAlso will use Perception by react on used stealth spells around",
    ruRU = "Будет использовать вне боя Кольцо Света (Уровень 1) и Внимательность\nКак только кто-нибудь поблизости войдет в бой и в команде противника есть скрытые юниты\nТакже использует Внимательность на недавно использованные способности невидимости рядом" },                        
    SHADOW                    = { enUS = "Shadow",
    ruRU = "Тьма" },        
    WEAVINGSSTACKING        = { enUS = "Begin Combat By\nS.Weaving Stacking",
    ruRU = "Начинать Бой c\nП.Тьмы Настакивания" },
    WEAVINGSSTACKINGTT        = { enUS = "If taken talent 'Shadow Weaving' then each fight will be begin with\nstacking 5 debuffs on a boss or enemy player",
    ruRU = "Если взят талант 'Плетение Тьмы', то будет каждый бой начинать\nс накопления 5-ми эффектов по боссу или вражескому игроку" },        
    CANCELSHADOWFORM        = { enUS = "Auto Cancel Shadowform",
    ruRU = "Авто Отмена Облика Тьмы" },                        
    CANCELSHADOWFORMTT        = { enUS = "Will try cancel aura of Shadowform if it's required to use\nsome spells which are unavailable by school",
    ruRU = "Будет пытаться отменить эффект Облика Тьмы при необходимости\nиспользовать определенные способности недоступной школы" },
    BYPASSMINDBLAST            = { enUS = "Mind Blast\nWill stop channeling",
    ruRU = "Взрыв Разума\nПрерывать потоковое" },    
    MINDFLAYTIMING            = { enUS = "Mind Flay\nMind Blast timed",
    ruRU = "Пытка Разума\nТаймится Взрывом Разума" },        
    MINDFLAYTIMINGTT        = { enUS = "Mind Flay will not be used if Mind Blast will be up within next GCD",
    ruRU = "Пытка Разума не используется если за ГКД успевает восстановиться Взрыв Разума" },    
    DOUBLECASTMINDFLAY        = { enUS = "Mind Flay\nDouble cast",
    ruRU = "Пытка Разума\nДвойное использование" },    
    DOUBLECASTMINDFLAYTT     = { enUS = "Mind Flay will be casted twice in a row to increase total ticks\nDEV Note:\nI didn't figured out if that worked on Classic or not, seems not\nAt least it will waste mana and cast can be interrupted by Mind Blast\nSo feel free to decide for yourself what better for you",
    ruRU = "Пытка Разума будет использована дважды в потоке для увеличения тактов\nКомментарий Разработчика:\nЯ так и не понял работает ли это в Классике или нет, похоже что нет\nВ конце концов это будет затрачивать дополнительно ману и произнесение может быть прервано Взрывом Разума\nПоэтому чувствуйте себя свободно, чтобы попробовать и решить для себя как будет лучше" },                                
    HEALER                    = { enUS = "Healer",
    ruRU = "Лекарь" },    
    PREPAREPOWS                = { enUS = "Pre Pare\nPower Word: Shield",
    ruRU = "Подготовить\nСлово Силы: Щит" },    
    PREPAREPOWSTT            = { enUS = "If enabled then Power Word: Shield will be used on everyone party and raid member\nRight mouse click: Create macro and use during fight whenever you need",
    ruRU = "Если включено, то Слово Силы: Щит будет использован на каждом участнике группы и рейда\nПравый щелчок мышки: Создать макрос и используйте в бою тогда когда это нужно" },                            
    PREPARERENEW            = { enUS = "Pre Pare\nRenew",
    ruRU = "Подготовить\nОбновление" },    
    PREPARERENEWTT            = { enUS = "If enabled then Renew will be used on everyone party and raid member\nRight mouse click: Create macro and use during fight whenever you need",
    ruRU = "Если включено, то Обновление будет использовано на каждом участнике группы и рейда\nПравый щелчок мышки: Создать макрос и используйте в бою тогда когда это нужно" },
    POWERINFUSION            = { enUS = "Power Infusion - Units",
    ruRU = "Придание сил - Цели" },    
    HEALERAOE                = { enUS = "Healer AoE",
    ruRU = "Лекарь AoE" },                            
    PRAYEROFHEALINGUNITS    = { enUS = PR.PrayerofHealing:Info() .. "\nUnit Counter",
        ruRU = PR.PrayerofHealing:Info() .. "\nКол-во целей" },        
    HOLYNOVAUNITS            = { enUS = PR.HolyNova:Info() .. "\nUnit Counter",
        ruRU = PR.HolyNova:Info() .. "\nКол-во целей" },    
    HOLYNOVAPOWS            = { ANY  = PR.HolyNova:Info() .. " & " .. PR.PowerWordShield:Info() },    
    RENEWONLYTANK            = { enUS = PR.Renew:Info() .. " (Tank Only)",
        ruRU = PR.Renew:Info() .. " (Только Танк)" },    
    RENEWONLYTANKTT            = { enUS = "This toggle is also affected by the state of 'Pre Pare Renew'",
    ruRU = "На этот  переключатель также влияет состояние 'Подготовить Обновление'" },                                
}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v8 (03.10.2019)",
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
        DB         = "ManaPotion",
        DBV     = true,
        L         = L.MANAPOTION,
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
A.Data.ProfileUI[2][4]                                = {    -- Defense
    {
        E         = "Header",
        L         = L.DEFENSEABILITIES, 
    },
}
A.Data.ProfileUI[2][5]                                = {
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
A.Data.ProfileUI[2][6]                                = {
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
A.Data.ProfileUI[2][7]                                = {
    {
        E         = "Header",
        L         = L.TRINKETS,
    },
}
A.Data.ProfileUI[2][8]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Always",                 value = "Always" },
            { text = "Burst Synchronized",     value = "BurstSync" },                    
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
A.Data.ProfileUI[2][9]                                = {    -- PvP
    {
        E         = "Header",
        L         = {
            ANY = "PvP",
        },
    },
}
A.Data.ProfileUI[2][10]                                = {
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
A.Data.ProfileUI[2][11]                                = { -- Shadow 
    {
        E         = "Header",
        L         = L.SHADOW,
    },
}
A.Data.ProfileUI[2][12]                                = {
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
A.Data.ProfileUI[2][13]                                = {
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
A.Data.ProfileUI[2][14]                                = { -- Healer 
    {
        E         = "Header",
        L         = L.HEALER,
    },
}
A.Data.ProfileUI[2][15]                                = {
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
            { text = "SELF",     value = 1 },
            { text = "DAMAGER", value = 2 },
            { text = "HEALER",     value = 3 },
            { text = "ENEMY",     value = 4 },
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
A.Data.ProfileUI[2][16]                                = { -- Healer AoE 
    {
        E         = "Header",
        L         = L.HEALERAOE,
    },
}
A.Data.ProfileUI[2][17]                                = {
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
A.Data.ProfileUI[2][18]                                = { -- PrayerofHealing 
    {
        E         = "Header",
        L         = { ANY  = PR.PrayerofHealing:Info() },
    },
}
A.Data.ProfileUI[2][19]                                = {
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
A.Data.ProfileUI[2][20]                                = {
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
A.Data.ProfileUI[2][21]                                = { -- HolyNova & PoWS
    {
        E         = "Header",
        L         = L.HOLYNOVAPOWS,
    },
}
A.Data.ProfileUI[2][22]                                = {
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
A.Data.ProfileUI[2][23]                                = { -- Renew 
    {
        E         = "Header",
        L         = { ANY  = PR.Renew:Info() },
    },
}
A.Data.ProfileUI[2][24]                                = {
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
A.Data.ProfileUI[2][25]                                = {
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
A.Data.ProfileUI[2][26]                                = {
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
A.Data.ProfileUI[2][27]                                = {
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
A.Data.ProfileUI[2][28]                                = { -- Heal 
    {
        E         = "Header",
        L         = { ANY  = PR.Heal:Info() },
    },
}
A.Data.ProfileUI[2][29]                                = {
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
A.Data.ProfileUI[2][30]                                = {
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
A.Data.ProfileUI[2][31]                                = { -- GreaterHeal 
    {
        E         = "Header",
        L         = { ANY  = PR.GreaterHeal:Info() },
    },
}
A.Data.ProfileUI[2][32]                                = {
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
A.Data.ProfileUI[2][33]                                = {
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
A.Data.ProfileUI[2][34]                                = { -- FlashHeal 
    {
        E         = "Header",
        L         = { ANY  = PR.FlashHeal:Info() },
    },
}
A.Data.ProfileUI[2][35]                                = {
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
A.Data.ProfileUI[2][36]                                = {
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
A.Data.ProfileUI[2][37]                                = {
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
A.Data.ProfileUI[2][38]                                = { -- LesserHeal 
    {
        E         = "Header",
        L         = { ANY  = PR.LesserHeal:Info() },
    },
}
A.Data.ProfileUI[2][39]                                = {
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

