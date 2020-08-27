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
    DateTime = "v4.0.3 (27.02.2020)",
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
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Simcraft Logic", value = "Simcraft Logic" },
                        { text = "High Priority Logic", value = "High Priority Logic"},                    
                    },
                    DB = "RampageLogic",
                    DBV = "Simcraft Logic",
                    L = { 
                        ANY = A.GetSpellInfo(184367) .. " Logic",
                    }, 
                    TT = { 
                        enUS = "Simcraft Logic - Respect the Simcraft logic. \n HIGH PRIORITY LOGIC - Always use Rampage whenever available.", 
                    }, 
                    M = {},
                },            
            }, 
            { -- [2]
                {
                    E = "Checkbox", 
                    DB = "holdAoE",
                    DBV = false,
                    L = { 
                        enUS = "Hold Dragon Roar / BoTE to AoE", 
                    }, 
                    TT = { 
                        enUS = "Enable to hold Dragon Roar / Blood of the Enemy to use only in multiunits.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "holdAoENum",
                    DBV = 2,
                    ONOFF = false,
                    L = { 
                        ANY = "Min. Units to Hold AoE Logic.",
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
                    DBV = 60, -- Set healthpercentage @60% life. 
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
                    DBV = 60, -- Set healthpercentage @60% life. 
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
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
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
                        frFR = "Active/Désactive la rotation spécifique aux alliés pour les personnes dans le groupe.\nExemple : Dispell automatique sur les membres du groupe.",
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
                    DBV = 60, -- Set healthpercentage @60% life. 
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
                    DBV = 60, -- Set healthpercentage @60% life. 
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
                    DB = "DiebytheSword",
                    DBV = 50, -- Set healthpercentage @30% life. 
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
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "RallyingCryPvP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(97462) .. " (%)",
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
        }, 
    },
    [7] = {
        [ACTION_CONST_WARRIOR_ARMS] = {
            ["stun"] = { Enabled = true, Key = "StormBolt", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  A.StormBolt:IsReadyM(thisunit, true) and  
                        (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Disarm", LUAVER = 5, LUA = [[
                return     DisarmPvPIsReady(thisunit, true)
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

