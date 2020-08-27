--------------------
-- Taste TMW Action ProfileUI
local TMW                                             = TMW
local A                                             = Action
local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                             = A.Pet
local LoC                                             = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local select                                        = select

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]     = true
A.Data.ProfileUI                                     = {    
    DateTime = "v2.0.2 (23.01.2020)",
	-- Class Settings
    [2] = {        
        [ACTION_CONST_WARRIOR_FURY] = {
            { -- [1]                            
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                    }, 
                    M = {},
                },                    
            }, 
            { -- [2]
                {
                    E = "Header",
                    L = {
                        enUS = " -- Self Defensives -- ",
                    },
                },
            }, 
            { -- [3]     
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VictoryRush",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(34428) .. " (%)",
                    }, 
                    M = {},
                },
                {                    
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ImpendingVictory",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(202168) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
            { -- [4]    
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "RallyingCry",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(97462) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EnragedRegeneration",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(184364) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
            { -- [5]    

                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketDefensive",
                    DBV = 50,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["TRINKET"] .. "\n(Self HP %)",
                    }, 
                    M = {},
                },
            }, 
            { -- [6]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Party -- ",
                    },
                },
            }, 
            { -- [7]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@party1", value = 1 },
                        { text = "@party2", value = 2 },
                    },
                    MULT = true,
                    DB = "PartyUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L = { 
                        ANY = "Party Units",
                    }, 
                    TT = { 
                        enUS = "Enable/Disable relative party passive rotation", 
                    }, 
                    M = {},
                },            
            },            
            { -- [8]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            }, 
            { -- [9]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Only Heal", value = "Heal" },
                        { text = "Only PvP", value = "PvP" },
                        { text = "BOTH", value = "BOTH" },
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "StormBoltPvP",
                    DBV = "BOTH",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(107570),
                    }, 
                    TT = { 
                        enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by StormBolt\nMore custom config you can find in group by open /tmw", 
                    }, 
                    M = {},
                },
            }, 
            { -- [10]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "DisarmPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(236077),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "DisarmPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(236077) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
            { -- [11] Spell Reflect
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "DANGEROUS CAST", value = "DANGEROUS CAST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "ReflectPvP",
                    DBV = "DANGEROUS CAST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(216890),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nDANGEROUS CAST - Only if target or arena unit is casting a spell considered as dangerous. (CC or Big damage).\nON COOLDOWN - means will use always on all casts.\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nDANGEROUS CAST - Only if target or arena unit is casting a spell considered as dangerous. (CC or Big damage).\nON COOLDOWN - means will use always on all casts.\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "ReflectPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(216890) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },	
            },				
        }, 

		[ACTION_CONST_WARRIOR_ARMS] = {
            { -- [1]                            
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                    }, 
                    M = {},
                },                    
            }, 
            { -- [2]
                {
                    E = "Header",
                    L = {
                        enUS = " -- Self Defensives -- ",
                    },
                },
            }, 
            { -- [3]     
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VictoryRush",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(34428) .. " (%)",
                    }, 
                    M = {},
                },
                {                    
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ImpendingVictory",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(202168) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
            { -- [4]    
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "RallyingCry",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(97462) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DiebytheSword",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(118038) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
            { -- [5]    

                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketDefensive",
                    DBV = 50,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["TRINKET"] .. "\n(Self HP %)",
                    }, 
                    M = {},
                },
            }, 
            { -- [6]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Party -- ",
                    },
                },
            }, 
            { -- [7]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@party1", value = 1 },
                        { text = "@party2", value = 2 },
                    },
                    MULT = true,
                    DB = "PartyUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L = { 
                        ANY = "Party Units",
                    }, 
                    TT = { 
                        enUS = "Enable/Disable relative party passive rotation", 
                    }, 
                    M = {},
                },            
            },            
            { -- [8]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            }, 
            { -- [9]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Only Heal", value = "Heal" },
                        { text = "Only PvP", value = "PvP" },
                        { text = "BOTH", value = "BOTH" },
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "StormBoltPvP",
                    DBV = "BOTH",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(107570),
                    }, 
                    TT = { 
                        enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by StormBolt\nMore custom config you can find in group by open /tmw", 
                    }, 
                    M = {},
                },
            }, 
            { -- [10]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "DisarmPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(236077),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "DisarmPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(236077) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
            { -- [11] Spell Reflect
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "DANGEROUS CAST", value = "DANGEROUS CAST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "ReflectPvP",
                    DBV = "DANGEROUS CAST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(216890),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nDANGEROUS CAST - Only if target or arena unit is casting a spell considered as dangerous. (CC or Big damage).\nON COOLDOWN - means will use always on all casts.\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nDANGEROUS CAST - Only if target or arena unit is casting a spell considered as dangerous. (CC or Big damage).\nON COOLDOWN - means will use always on all casts.\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "ReflectPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(216890) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },			
        },
        [ACTION_CONST_WARRIOR_PROTECTION] = {        
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },			
            { -- [1] 1st Row                           
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE"
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {},
                }, 
            }, 
            { -- [1] 1st Row                           
                {
                    E = "Checkbox", 
                    DB = "AvatarOnCD",
                    DBV = true,
                    L = { 
                        enUS = "Use Avatar on cooldown", 
                        ruRU = "Use Avatar on cooldown", 
                        frFR = "Use Avatar on cooldown", 
                    }, 
                    TT = { 
                        enUS = "Use Avatar on cooldown", 
                        ruRU = "Use Avatar on cooldown", 
                        frFR = "Use Avatar on cooldown", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DSOnCD",
                    DBV = true,
                    L = { 
                        enUS = "Use Demoralizing Shout on cooldown", 
                        ruRU = "Use Demoralizing Shout on cooldown",  
                        frFR = "Use Demoralizing Shout on cooldown", 
                    }, 
                    TT = { 
                        enUS = "Use Demoralizing Shout on cooldown", 
                        ruRU = "Use Demoralizing Shout on cooldown",  
                        frFR = "Use Demoralizing Shout on cooldown", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AbyssalHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(301308) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [1] 1st Row  	
                {
                    E = "Checkbox", 
                    DB = "LastStandIgnoreBigDeff",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(12975) .. "\nSkip if " .. A.GetSpellInfo(871) .. " used",
                        ruRU = A.GetSpellInfo(12975) .. "\nSkip if " .. A.GetSpellInfo(871) .. " used",  
                        frFR = A.GetSpellInfo(12975) .. "\nSkip if " .. A.GetSpellInfo(871) .. " used", 
                    }, 
                    M = {},
                }, 		    
                {
                    E = "Checkbox", 
                    DB = "ShieldWallCatchKillStrike",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(12975) .. "\nCatch death hit",
                        ruRU = A.GetSpellInfo(12975) .. "\nCatch death hit",  
                        frFR = A.GetSpellInfo(12975) .. "\nCatch death hit", 
                    }, 
                    TT = { 
                        enUS = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!", 
                        ruRU = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!",
                        frFR = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!",  
                    },
                    M = {},
                }, 					
                {
                    E         = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 20,                            
                    DB         = "LastStandTTD",
                    DBV     = 5,
                    ONLYOFF    = true,
                    L = { 
                        enUS = A.GetSpellInfo(12975) .. "\n<= time to die (sec)", 
                        ruRU = A.GetSpellInfo(12975) .. "\n<= time to die (sec)",  
                        frFR = A.GetSpellInfo(12975) .. "\n<= time to die (sec)",  
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition", 
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                },
                {
                    E         = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 100,                            
                    DB         = "LastStandHP",
                    DBV     = 20,
                    ONLYOFF    = true,
                    L = { 
                        enUS = A.GetSpellInfo(12975) .. "\n<= health (%)", 
                        ruRU = A.GetSpellInfo(12975) .. "\n<= health (%)",  
                        frFR = A.GetSpellInfo(12975) .. "\n<= health (%)", 
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                }, 
            }, 
            { -- [1] 1st Row  			    
                {
                    E = "Checkbox", 
                    DB = "ShieldWallCatchKillStrike",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(871) .. "\nCatch death hit",
                        ruRU = A.GetSpellInfo(871) .. "\nCatch death hit",  
                        frFR = A.GetSpellInfo(871) .. "\nCatch death hit", 
                    }, 
                    TT = { 
                        enUS = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!", 
                        ruRU = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!",
                        frFR = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!",  
                    },
                    M = {},
                }, 					
                {
                    E         = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 20,                            
                    DB         = "ShieldWallTTD",
                    DBV     = 5,
                    ONLYOFF    = true,
                    L = { 
                        enUS = A.GetSpellInfo(871) .. "\n<= time to die (sec)", 
                        ruRU = A.GetSpellInfo(871) .. "\n<= time to die (sec)",  
                        frFR = A.GetSpellInfo(871) .. "\n<= time to die (sec)",  
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition", 
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                },
                {
                    E         = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 100,                            
                    DB         = "ShieldWallHP",
                    DBV     = 20,
                    ONLYOFF    = true,
                    L = { 
                        enUS = A.GetSpellInfo(871) .. "\n<= health (%)", 
                        ruRU = A.GetSpellInfo(871) .. "\n<= health (%)",  
                        frFR = A.GetSpellInfo(871) .. "\n<= health (%)", 
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                }, 
            }, 
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseLastStandToFillShieldBlockDownTime",
                    DBV = true,
                    L = { 
                        enUS = "Use Last Stand to fill Shield Block down time", 
                        ruRU = "Use Last Stand to fill Shield Block down time", 
                        frFR = "Use Last Stand to fill Shield Block down time",
                    }, 
                    TT = { 
                        enUS = "Enable this if you want to fill Shield Block down time with Last Stand.", 
                        ruRU = "Enable this if you want to fill Shield Block down time with Last Stand.", 
                        frFR = "Enable this if you want to fill Shield Block down time with Last Stand.",
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UseShieldBlockDefensively",
                    DBV = true,
                    L = { 
                        enUS = "Use Shield Block purely defensively", 
                        ruRU = "Use Shield Block purely defensively", 
                        frFR = "Use Shield Block purely defensively",
                    }, 
                    TT = { 
                        enUS = "Enable this if you only want to use Shield Block in a defensive manner.", 
                        ruRU = "Enable this if you only want to use Shield Block in a defensive manner.", 
                        frFR = "Enable this if you only want to use Shield Block in a defensive manner.",
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UseRageDefensively",
                    DBV = true,
                    L = { 
                        enUS = "Use Rage defensively", 
                        ruRU = "Use Rage defensively", 
                        frFR = "Use Rage defensively",
                    }, 
                    TT = { 
                        enUS = "Enable this to prioritize defensive use of Rage.", 
                        ruRU = "Enable this to prioritize defensive use of Rage.", 
                        frFR = "Enable this to prioritize defensive use of Rage.",
                    }, 
                    M = {},
                }, 
            },
            { -- [4] 4th Row
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "FearPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(5782),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "FearPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(5782) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },		
    },
    [7] = {
        [ACTION_CONST_WARRIOR_FURY] = {
            ["stun"] = { Enabled = true, Key = "StormBolt", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Disarm", LUAVER = 5, LUA = [[
                return     DisarmIsReady(thisunit, true)
            ]] },
            ["reflect"] = { Enabled = true, Key = "Reflect", LUAVER = 5, LUA = [[
                return     ReflectIsReady(thisunit, true)
            ]] },
            ["kick"] = { Enabled = true, Key = "Pummel", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return     A.Pummel:IsReadyM(thisunit) and                         
                        A.Pummel:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
            ]] },
        },
        [ACTION_CONST_WARRIOR_ARMS] = {
            ["stun"] = { Enabled = true, Key = "StormBolt", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Disarm", LUAVER = 5, LUA = [[
                return     DisarmIsReady(thisunit, true)
            ]] },
            ["reflect"] = { Enabled = true, Key = "Reflect", LUAVER = 5, LUA = [[
                return     ReflectIsReady(thisunit, true)
            ]] },
            ["kick"] = { Enabled = true, Key = "Pummel", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return     A.Pummel:IsReadyM(thisunit) and                         
                        A.Pummel:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
            ]] },
        },
        [ACTION_CONST_WARRIOR_PROTECTION] = {
            ["stun"] = { Enabled = true, Key = "StormBolt", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Disarm", LUAVER = 5, LUA = [[
                return     DisarmIsReady(thisunit, true)
            ]] },
            ["reflect"] = { Enabled = true, Key = "Reflect", LUAVER = 5, LUA = [[
                return     ReflectIsReady(thisunit, true)
            ]] },
            ["kick"] = { Enabled = true, Key = "Pummel", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return     A.Pummel:IsReadyM(thisunit) and                         
                        A.Pummel:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
            ]] },
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------

-- Disarm
function A.DisarmIsReady(unit, isMsg, skipShouldStop)
    if A[A.PlayerSpec].Disarm then 
        local unitID = A.GetToggle(2, "DisarmPvPunits")
        return     (
            (unit == "arena1" and unitID[1]) or 
            (unit == "arena2" and unitID[2]) or
            (unit == "arena3" and unitID[3]) or
            (not unit:match("arena") and unitID[4]) 
        ) and 
        A.IsInPvP and
        Unit(unit):IsEnemy() and  
        (
            (
                not isMsg and 
                A.GetToggle(2, "DisarmPvP") ~= "OFF" and 
                A[A.PlayerSpec].Disarm:IsReady(unit, nil, nil, skipShouldStop) and 
                Unit(unit):IsMelee() and 
                (
                    A.GetToggle(2, "DisarmPvP") == "ON COOLDOWN" or 
                    Unit(unit):HasBuffs("DamageBuffs") > 3 
                )
            ) or 
            (
                isMsg and 
                A[A.PlayerSpec].Disarm:IsReadyM(unit)                     
            )
        ) and 
        Unit(unit):IsPlayer() and                     
        A[A.PlayerSpec].Disarm:AbsentImun(unit, {"CCTotalImun", "DamagePhysImun", "TotalImun"}, true) and 
        Unit(unit):IsControlAble("disarm", 0) and 
        Unit(unit):HasDeBuffs("Disarmed") == 0
    end 
end 

-- Spell Reflection 
function A.ReflectIsReady(unit, isMsg, skipShouldStop)
    if A[A.PlayerSpec].SpellReflection then 
        local unitID = A.GetToggle(2, "ReflectPvPunits")
        return     (
            (unit == "arena1" and unitID[1]) or 
            (unit == "arena2" and unitID[2]) or
            (unit == "arena3" and unitID[3]) or
            (not unit:match("arena") and unitID[4]) 
        ) and 
        A.IsInPvP and
        Unit(unit):IsEnemy() and  
        (
            (
                not isMsg and 
                A.GetToggle(2, "ReflectPvP") ~= "OFF" and 
                A[A.PlayerSpec].SpellReflection:IsReady(unit, nil, nil, skipShouldStop) and
                (
                    A.GetToggle(2, "ReflectPvP") == "ON COOLDOWN" or 
                    (A.GetToggle(2, "ReflectPvP") == "DANGEROUS CAST" and Action.ShouldReflect(unit))
                )
            ) or 
            (
                isMsg and 
                A[A.PlayerSpec].SpellReflection:IsReadyM(unit)                     
            )
        ) and 
        Unit(unit):IsPlayer()
    end 
end 

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].Pummel and A[A.PlayerSpec].Pummel:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Pummel:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp")  then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "StormBoltPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].StormBolt and A[A.PlayerSpec].StormBolt:IsReadyP(unit, nil, true) and A[A.PlayerSpec].StormBolt:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("stun", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 
