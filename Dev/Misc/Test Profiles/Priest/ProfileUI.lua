local TMW                                           = TMW 

local A                                             = Action
local UnitCooldown                                  = A.UnitCooldown
local Unit                                          = A.Unit 
local Player                                        = A.Player 
local Pet                                           = A.Pet
local LoC                                           = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                     = A.EnemyTeam
local FriendlyTeam                                  = A.FriendlyTeam
local TeamCache                                     = A.TeamCache
local InstanceInfo                                  = A.InstanceInfo

local select                                        = select

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]     = true
A.Data.ProfileUI                                     = {    
    DateTime = "v2.0.3 (19.12.2019)",
    [2] = {        
        [ACTION_CONST_PRIEST_SHADOW] = {             
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
                    E = "Checkbox", 
                    DB = "ByPassSpells",
                    DBV = true,
                    L = { 
                        enUS = "ByPassSpells", 
                    }, 
                    TT = { 
                        enUS = "Spells\nWill stop channeling",
                    }, 
                    M = {},
                },         
                {
                    E = "Checkbox", 
                    DB = "SpellsTiming",
                    DBV = false,
                    L = { 
                        enUS = "Spells\nVoid Bolt timed",
                    }, 
                    TT = { 
                        enUS = "Spells will not be used if Void Bolt will be up within next GCD",
                    }, 
                    M = {},
                },  
            },
			{ -- [3]
                {
                    E = "Header",
                    L = {
                        enUS = " -- Defensives -- ",
                    },
                },
            }, 
            { -- [4]     
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VampiricEmbrace",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(15286) .. " (%)",
                    }, 
                    M = {},
                },
                {                    
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Dispersion",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(47585) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
        },
    },
}

function A.Second_CastBars(unitID)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp")  then 
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