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
local HL                                            = HeroLib 
local HeroUnit                                      = HL.Unit
local HealingEngine                                 = A.HealingEngine

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()] = true
A.Data.ProfileUI = {    
    DateTime = "v1.20 (06.10.2019)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_WARLOCK_AFFLICTION] = {  
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
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                }, 
                {
                    E = "Checkbox", 
                    DB = "OffGCDasOffGCD",
                    DBV = true,
                    L = { 
                        enUS = "Use spells OffGCD", 
                        ruRU = "Используйте заклинания OffGCD", 
                        frFR = "Utiliser les spells OffGCD",
                    }, 
                    TT = { 
                        enUS = "Will force certains spells to be used as off GCD", 
                        ruRU = "Вынудит определенные заклинания использоваться как вне GCD", 
                        frFR = "Forcera certains spells à être utilisés sur le GCD",
                    }, 
                    M = {},
                }, 
                
            },  
            { -- [2] 2nd Row 
				-- Splash Data
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "USE COMBAT LOGS", value = "USE COMBAT LOGS" }, 
                        { text = "USE SPLASH DATA", value = "USE SPLASH DATA" },                   
                        { text = "USE NAMEPLATES", value = "USE NAMEPLATES" },
                    },
                    DB = "AoeDetectionMode",
                    DBV = "USE COMBAT LOGS",
                    L = { 
                        ANY = "AoE Detection Mode",
                    }, 
                    TT = { 
                        enUS = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
                        ruRU = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
                    }, 
                    M = {},
                },	
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] Multidots settings
                {
                    E = "Header",
                    L = {
                        ANY = " -- Multidots settings -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "AutoDot",
                    DBV = true,
                    L = { 
                        enUS = "Enable auto Multidots", 
                        ruRU = "Использовать auto Multidots", 
                        frFR = "Activer le Multidots auto", 
                    }, 
                    TT = { 
                        enUS = "Automatically multidots units.\nMake sure to stay front of the enemies nameplate you want the bot to target.\nMake sure you correctly keybinded the TargetEnemy key in both game and GG.",
                        ruRU = "Automatically multidots units.\nMake sure to stay front of the enemies nameplate you want the bot to target.\nMake sure you correctly keybinded the TargetEnemy key in both game and GG.",
                        frFR = "Automatically multidots units.\nMake sure to stay front of the enemies nameplate you want the bot to target.\nMake sure you correctly keybinded the TargetEnemy key in both game and GG.",
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "In Raid", value = "In Raid" },
                        { text = "In Dungeon", value = "In Dungeon" },
						{ text = "In PvP", value = "In PvP" },
                        { text = "Everywhere", value = "Everywhere" },
                    },
                    MULT = false,
                    DB = "AutoDotSelection",
                    DBV = "In Raid", 
                    L = { 
                        ANY = "Multidots where",
                    }, 
                    TT = { 
                        enUS = "Choose where you want to automatically multidots units.", 
                        ruRU = "Choose where you want to automatically multidots units.", 
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
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "UnendingResolve",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(104773) .. " Leech HP (%)",
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
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
            { -- [4] 4th Row
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = A.GetSpellInfo(688), value = "IMP" },
                        { text = A.GetSpellInfo(697), value = "VOIDWALKER" },                    
                        { text = A.GetSpellInfo(691), value = "FELHUNTER" },
                        { text = A.GetSpellInfo(712), value = "SUCCUBUS" },
                    },
                    DB = "PetChoice",
                    DBV = "IMP",
                    L = { 
                        enUS = "Pet selection", 
                        ruRU = "Выбор питомца", 
                        frFR = "Sélection du familier",
                    }, 
                    TT = { 
                        enUS = "Choose the pet to summon", 
                        ruRU = "Выберите питомца для призыва", 
                        frFR = "Choisir le familier à invoquer",
					},
                    M = {},
                },
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
        [ACTION_CONST_WARLOCK_DESTRUCTION] = {  
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
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                }, 
                {
                    E = "Checkbox", 
                    DB = "OffGCDasOffGCD",
                    DBV = true,
                    L = { 
                        enUS = "Use spells OffGCD", 
                        ruRU = "Используйте заклинания OffGCD", 
                        frFR = "Utiliser les spells OffGCD",
                    }, 
                    TT = { 
                        enUS = "Will force certains spells to be used as off GCD", 
                        ruRU = "Вынудит определенные заклинания использоваться как вне GCD", 
                        frFR = "Forcera certains spells à être utilisés sur le GCD",
                    }, 
                    M = {},
                }, 
                
            },  
            { -- [2] 2nd Row 
				-- Splash Data
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "USE COMBAT LOGS", value = "USE COMBAT LOGS" }, 
                        { text = "USE SPLASH DATA", value = "USE SPLASH DATA" },                   
                        { text = "USE NAMEPLATES", value = "USE NAMEPLATES" },
                    },
                    DB = "AoeDetectionMode",
                    DBV = "USE COMBAT LOGS",
                    L = { 
                        ANY = "AoE Detection Mode",
                    }, 
                    TT = { 
                        enUS = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
                        ruRU = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
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
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "UnendingResolve",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(104773) .. " Leech HP (%)",
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
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
            { -- [4] 4th Row
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = A.GetSpellInfo(688), value = "IMP" },
                        { text = A.GetSpellInfo(697), value = "VOIDWALKER" },                    
                        { text = A.GetSpellInfo(691), value = "FELHUNTER" },
                        { text = A.GetSpellInfo(712), value = "SUCCUBUS" },
                    },
                    DB = "PetChoice",
                    DBV = "IMP",
                    L = { 
                        enUS = "Pet selection", 
                        ruRU = "Выбор питомца", 
                        frFR = "Sélection du familier",
                    }, 
                    TT = { 
                        enUS = "Choose the pet to summon", 
                        ruRU = "Выберите питомца для призыва", 
                        frFR = "Choisir le familier à invoquer",
					},
                    M = {},
                },
				-- Splash Data
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Auto", value = "Auto" }, 
                        { text = "Orange", value = "Orange" },                   
                        { text = "Green", value = "Green" },
                    },
                    DB = "SpellType",
                    DBV = "Auto",
                    L = { 
                        ANY = "Spell Color",
                    }, 
                    TT = { 
                        ANY = "Choose your spells color style.",
                    }, 
                    M = {},
                },	
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
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
        [ACTION_CONST_WARLOCK_DEMONOLOGY] = {  
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
                {
                    E = "Checkbox", 
                    DB = "CDs",
                    DBV = true,
                    L = { 
                        enUS = "Use Cooldowns", 
                        ruRU = "Использовать Cooldowns", 
                        frFR = "Utiliser les Cooldowns"
                    }, 
                    TT = { 
                        enUS = "Enable cooldowns usage in rotation", 
                        ruRU = "Включить использование перезарядки в ротации", 
                        frFR = "Activer l'usage des cooldowns par la rotation",
                    }, 
                    M = {},
                },                 
            }, 
            { -- [2] 2nd Row
				-- Splash Data
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "USE COMBAT LOGS", value = "USE COMBAT LOGS" }, 
                        { text = "USE SPLASH DATA", value = "USE SPLASH DATA" },                   
                        { text = "USE NAMEPLATES", value = "USE NAMEPLATES" },
                    },
                    DB = "AoeDetectionMode",
                    DBV = "USE COMBAT LOGS",
                    L = { 
                        ANY = "AoE Detection Mode",
                    }, 
                    TT = { 
                        enUS = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
                        ruRU = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
                    }, 
                    M = {},
                },				
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "Implosion",
                    DBV = 5, -- Set number of imps default @ 5. 
                    ONOFF = true,
                    L = { 
                        ANY = "Number of Imps to use " .. A.GetSpellInfo(196277),
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "UnendingResolve",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(104773) .. " (%)",
                    }, 
                    TT = { 
                        enUS = "Set the HP threshold before re-rolling for the leech buff (working only if Solo Mode is enabled).", 
                        ruRU = "Set the HP threshold before re-rolling for the leech buff (working only if Solo Mode is enabled).", 
                        frFR = "Set the HP threshold before re-rolling for the leech buff (working only if Solo Mode is enabled).",
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
    -- MSG Actions UI
    [7] = {
        [ACTION_CONST_WARLOCK_AFFLICTION] = { 
            ["tastedispel"] = { Enabled = true, Key = "SingeMagic", LUAVER = 5, LUA = [[
                return     DispelIsReady(thisunit, true, true)
            ]] },

        },
        [ACTION_CONST_WARLOCK_DESTRUCTION] = { 
            ["tastedispel"] = { Enabled = true, Key = "SingeMagic", LUAVER = 5, LUA = [[
                return     DispelIsReady(thisunit, true, true)
            ]] },

        },
        [ACTION_CONST_WARLOCK_DEMONOLOGY] = { 
            ["tastedispel"] = { Enabled = true, Key = "SingeMagic", LUAVER = 5, LUA = [[
                return     DispelIsReady(thisunit, true, true)
            ]] },

        },
    },
}


-----------------------------------------
--                   PvP  
-----------------------------------------
-- SingeMagic
function A.DispelIsReady(unit, isMsg, skipShouldStop)
	if Unit(unit):IsPlayer() then 
        if not isMsg then		
            return not Unit(unit):IsEnemy() and not Unit(unit):InLOS() and A[A.PlayerSpec].SingeMagic:IsReady(unit, nil, nil, true) and A.AuraIsValid(unit, "UseDispel", "Dispel")
		else
		    -- Notification			
			-- Mate in raid need to create a macro with their Index by doing this in game : /script print(UnitInRaid("player"))	
            -- 	
            A.SendNotification("Dispel requested by : " .. UnitName(unit), 119905)
		    return A[A.PlayerSpec].SingeMagic:IsReadyM(unit) 
		end
    end 
end 

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    -- SingeMagic Queue Message 
    --if A[A.PlayerSpec] and A[A.PlayerSpec].SingeMagic:IsReadyM(unit) then                         
    --    return true         
    --end   
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 


