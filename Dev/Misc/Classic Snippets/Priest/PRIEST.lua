local TMW                                    = TMW
local Env                                     = TMW.CNDT.Env 
local Action                                = Action
local Create                                 = Action.Create
local Listener                                = Action.Listener
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local LibCC                                 = LibStub("LibClassicCasterino", true)

local GetToggle                                = Action.GetToggle
local GetSpellInfo                            = Action.GetSpellInfo
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local DetermineUsableObject                    = Action.DetermineUsableObject
local DetermineHealObject                    = Action.DetermineHealObject
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local BurstIsON                                = Action.BurstIsON
local IsUnitFriendly                        = Action.IsUnitFriendly
local IsUnitEnemy                            = Action.IsUnitEnemy

local CanUseStoneformDefense                = Action.CanUseStoneformDefense
local CanUseStoneformDispel                    = Action.CanUseStoneformDispel
local CanUseHealingPotion                    = Action.CanUseHealingPotion
local CanUseLivingActionPotion                = Action.CanUseLivingActionPotion
local CanUseLimitedInvulnerabilityPotion    = Action.CanUseLimitedInvulnerabilityPotion
local CanUseRestorativePotion                = Action.CanUseRestorativePotion
local CanUseSwiftnessPotion                    = Action.CanUseSwiftnessPotion
local CanUseManaRune                        = Action.CanUseManaRune

local TeamCacheFriendly                        = TeamCache.Friendly
local TeamCacheFriendlyGUIDs                = TeamCacheFriendly.GUIDs -- unitGUID to unitID
local TeamCacheEnemy                        = TeamCache.Enemy
local HealingEngineMembersAll                 = HealingEngine.GetMembersAll()
local ActiveUnitPlates                         = MultiUnits:GetActiveUnitPlates()

local _G, setmetatable, pairs, select, math    = _G, setmetatable, pairs, select, math 
local huge                                     = math.huge

local ACTION_CONST_STOPCAST                    = _G.ACTION_CONST_STOPCAST    
local ACTION_CONST_PRIEST_SHADOW            = _G.ACTION_CONST_PRIEST_SHADOW

local UIParent                                = _G.UIParent 
local CreateFrame                            = _G.CreateFrame
local wipe                                     = _G.wipe
local IsUsableSpell                            = IsUsableSpell
local UnitGUID, UnitIsUnit, UnitPowerType     = 
UnitGUID, UnitIsUnit, UnitPowerType


Action[Action.PlayerClass]                     = {
    -- Night elf 
    Shadowmeld                                  = Create({ Type = "Spell", ID = 20580                                        }), -- usable in Action Core 
    Starshards                                = Create({ Type = "Spell", ID = 10797,     useMaxRank = true                    }), -- damage                  - channeling damage                                                                                 - no cd, channeling
    ElunesGrace                                = Create({ Type = "Spell", ID = 2651,     useMaxRank = true                    }), -- deffensive             - reduces ranged damage taken                                                                         - 5min, instant                                                                     
    -- Human  
    Perception                                = Create({ Type = "Spell", ID = 20600,     FixedTexture = ACTION_CONST_HUMAN     }),
    Feedback                                = Create({ Type = "Spell", ID = 13896,     useMaxRank = true                    }), -- misc                    - burn attacker's mana + damage if burned                                                            - 3min, instant 
    -- Human / Dwarf
    DesperatePrayer                            = Create({ Type = "Spell", ID = 13908,     useMaxRank = true                    }), -- deffensive             - self healing                                                                                        - 10min, instant 
    -- Dwarf     
    Stoneform                                  = Create({ Type = "Spell", ID = 20594                                        }),     
    FearWard                                = Create({ Type = "Spell", ID = 6346                                        }), -- buff                    - wards the friendly target against Fear                                                            - 30sec, instant  (no rank)
    -- Troll 
    Berserking                                = Create({ Type = "Spell", ID = 20554                                        }), 
    Shadowguard                                = Create({ Type = "Spell", ID = 18137,     useMaxRank = true                    }), -- deffensive             - self buff                                                                                         - no cd, instant 
    HexofWeakness                            = Create({ Type = "Spell", ID = 9035,     useMaxRank = true                    }), -- debuff                 - weakens the target enemy, reducing damage and reducing the effectiveness of any healing by 20%    - no cd, instant  
    -- Undead                                             
    WilloftheForsaken                          = Create({ Type = "Spell", ID = 7744                                        }), -- usable in Action Core and Trinket 
    DevouringPlague                            = Create({ Type = "Spell", ID = 2944,     useMaxRank = true                    }), -- debuff                 - afflicts the target with a disease that causes Shadow damage over 24 sec                            - 3min, instant 
    TouchofWeakness                            = Create({ Type = "Spell", ID = 2652,     useMaxRank = true                    }), -- buff                 - self buff                                                                                         - no cd, instant 
    -- Core API
    AntiFakeCC                                = Create({ Type = "SpellSingleColor",     ID = 8122,         Color = "GREEN", Desc = "[1] CC",                     QueueForbidden = true, BlockForbidden = true, useMaxRank = true     }),
    AntiFakeInterrupt                        = Create({ Type = "SpellSingleColor",     ID = 15487,     Color = "GREEN", Desc = "[2] Interrupt",             QueueForbidden = true, BlockForbidden = true, isTalent = true         }),
    CastBarsInterrupt                        = Create({ Type = "Spell",                  ID = 15487,                      Desc = "[CastBars] Interrupt",     QueueForbidden = true, BlockForbidden = true, isTalent = true          }),
    -- Class spells 
    Resurrection                            = Create({ Type = "Spell",              ID = 2006,     useMaxRank = true                                         }),
    DispelMagic                                = Create({ Type = "Spell",              ID = 527,         useMaxRank = true                                         }),
    AbolishDisease                            = Create({ Type = "Spell",              ID = 552                                                                 }),
    CureDisease                                = Create({ Type = "Spell",              ID = 528                                                                 }),
    -- Damager 
    MindSoothe                                = Create({ Type = "Spell",              ID = 453,         useMaxRank = true                                         }),
    VampiricEmbrace                            = Create({ Type = "Spell",              ID = 15286,     isTalent = true                                         }), -- no rank!
    Shadowform                                = Create({ Type = "Spell",              ID = 15473,     isTalent = true, FixedTexture = ACTION_CONST_SHADOWFORM    }), -- no rank!
    InnerFocus                                = Create({ Type = "Spell",              ID = 14751,     isTalent = true                                         }), -- no rank! (physical school)
    Smite                                    = Create({ Type = "Spell",              ID = 585,         useMaxRank = true                                         }),
    ShadowWordPain1                            = Create({ Type = "Spell",              ID = 589,         useMinRank = true, Desc = "Min Rank"                    }),
    ShadowWordPain                            = Create({ Type = "Spell",              ID = 589,         useMaxRank = true, Desc = "Max Rank"                    }),
    MindFlay                                = Create({ Type = "Spell",              ID = 15407,     useMaxRank = true, isTalent = true                         }),
    MindBlast                                = Create({ Type = "Spell",              ID = 8092,     useMaxRank = true                                        }),
    HolyFire                                = Create({ Type = "Spell",              ID = 14914,     useMaxRank = true                                        }),    
    -- Healer         
    InnerFire                                = Create({ Type = "Spell",              ID = 588,         useMaxRank = true                                        }),    
    PrayerofHealing1                        = Create({ Type = "Spell",              ID = 596,         isRank = 1                                                }),
    PrayerofHealing2                        = Create({ Type = "Spell",              ID = 996,         isRank = 2                                                }),
    PrayerofHealing3                        = Create({ Type = "Spell",              ID = 10960,    isRank = 3                                                }),
    PrayerofHealing4                        = Create({ Type = "Spell",              ID = 10961,     isRank = 4                                                }),    
    PrayerofHealing                            = Create({ Type = "Spell",              ID = 25316,     useMaxRank = true, Desc = "Max Rank"                    }),
    LesserHeal1                                = Create({ Type = "Spell",              ID = 2050,     isRank = 1                                                }),
    LesserHeal2                                = Create({ Type = "Spell",              ID = 2052,     isRank = 2                                                }),
    LesserHeal                                = Create({ Type = "Spell",              ID = 2053,     useMaxRank = true, Desc = "Max Rank"                    }),
    Renew1                                    = Create({ Type = "Spell",              ID = 139,         isRank = 1                                                }),
    Renew2                                    = Create({ Type = "Spell",              ID = 6074,     isRank = 2                                                }),
    Renew3                                    = Create({ Type = "Spell",              ID = 6075,     isRank = 3                                                }),
    Renew4                                    = Create({ Type = "Spell",              ID = 6076,     isRank = 4                                                }),
    Renew5                                    = Create({ Type = "Spell",              ID = 6077,     isRank = 5                                                }),
    Renew6                                    = Create({ Type = "Spell",              ID = 6078,     isRank = 6                                                }),
    Renew7                                    = Create({ Type = "Spell",              ID = 10927,     isRank = 7                                                }),
    Renew8                                    = Create({ Type = "Spell",              ID = 10928,     isRank = 8                                                }),
    Renew9                                    = Create({ Type = "Spell",              ID = 10929,     isRank = 9                                                }),
    Renew                                    = Create({ Type = "Spell",              ID = 25315,     useMaxRank = true, Desc = "Max Rank"                    }),
    --[[PowerWordShield1                        = Create({ Type = "Spell",              ID = 17,         isRank = 1                                                }),
    PowerWordShield2                        = Create({ Type = "Spell",              ID = 592,         isRank = 2                                                }),
    PowerWordShield3                        = Create({ Type = "Spell",              ID = 600,         isRank = 3                                                }),
    PowerWordShield4                        = Create({ Type = "Spell",              ID = 3747,        isRank = 4                                                }),
    PowerWordShield5                        = Create({ Type = "Spell",              ID = 6065,     isRank = 5                                                }),
    PowerWordShield6                        = Create({ Type = "Spell",              ID = 6066,        isRank = 6                                                }),
    PowerWordShield7                        = Create({ Type = "Spell",              ID = 10898,     isRank = 7                                                }),
    PowerWordShield8                        = Create({ Type = "Spell",              ID = 10899,     isRank = 8                                                }),
    PowerWordShield9                        = Create({ Type = "Spell",              ID = 10900,     isRank = 9                                                }),]]
    PowerWordShield                            = Create({ Type = "Spell",              ID = 10901,    useMaxRank = true, Desc = "Max Rank"                    }),
    Heal1                                    = Create({ Type = "Spell",              ID = 2054,     isRank = 1                                                }),
    Heal2                                    = Create({ Type = "Spell",              ID = 2055,     isRank = 2                                                }),
    Heal3                                    = Create({ Type = "Spell",              ID = 6063,     isRank = 3                                                }),
    Heal                                    = Create({ Type = "Spell",              ID = 6064,     useMaxRank = true, Desc = "Max Rank"                    }),
    GreaterHeal1                            = Create({ Type = "Spell",              ID = 2060,     isRank = 1                                                }),
    GreaterHeal2                            = Create({ Type = "Spell",              ID = 10963,     isRank = 2                                                }),
    GreaterHeal3                            = Create({ Type = "Spell",              ID = 10964,     isRank = 3                                                }),
    GreaterHeal4                            = Create({ Type = "Spell",              ID = 10965,     isRank = 4                                                }),
    GreaterHeal                                = Create({ Type = "Spell",              ID = 25314,     useMaxRank = true, Desc = "Max Rank"                    }),
    FlashHeal1                                = Create({ Type = "Spell",              ID = 2061,     isRank = 1                                                }),
    FlashHeal2                                = Create({ Type = "Spell",              ID = 9472,     isRank = 2                                                }),
    FlashHeal3                                = Create({ Type = "Spell",              ID = 9473,     isRank = 3                                                }),
    FlashHeal4                                = Create({ Type = "Spell",              ID = 9474,     isRank = 4                                                }),
    FlashHeal5                                = Create({ Type = "Spell",              ID = 10915,     isRank = 5                                                }),
    FlashHeal6                                = Create({ Type = "Spell",              ID = 10916,     isRank = 6                                                }),
    FlashHeal                                = Create({ Type = "Spell",              ID = 10917,     useMaxRank = true, Desc = "Max Rank"                    }),
    HolyNova1                                = Create({ Type = "Spell",              ID = 15237,     isTalent = true, useMinRank = true, Desc = "Min Rank"    }),
    --[[HolyNova2                                = Create({ Type = "Spell",              ID = 15430,     isTalent = true, isRank = 2                                }),
    HolyNova3                                = Create({ Type = "Spell",              ID = 15431,     isTalent = true, isRank = 3                                }),
    HolyNova4                                = Create({ Type = "Spell",              ID = 27799,     isTalent = true, isRank = 4                                }),
    HolyNova5                                = Create({ Type = "Spell",              ID = 27800,     isTalent = true, isRank = 5                                }),]]
    HolyNova                                = Create({ Type = "Spell",              ID = 27801,     isTalent = true, useMaxRank = true, Desc = "Max Rank"    }),
    Lightwell                                = Create({ Type = "Spell",              ID = 724,         isTalent = true                                            }),
    PowerInfusion                            = Create({ Type = "Spell",              ID = 10060,    isTalent = true                                            }),
    -- Member's Buffer 
    PrayerofSpirit                            = Create({ Type = "Spell",              ID = 27681,     useMaxRank = true                                        }),
    DivineSpirit                            = Create({ Type = "Spell",              ID = 14752,     isTalent = true, useMaxRank = true                        }), -- solo 
    PrayerofFortitude                        = Create({ Type = "Spell",              ID = 21562,     useMaxRank = true                                        }),
    PowerWordFortitude                        = Create({ Type = "Spell",              ID = 1243,     useMaxRank = true                                        }), -- solo 
    PrayerofShadowProtection                = Create({ Type = "Spell",              ID = 27683,     useMaxRank = true                                        }),
    ShadowProtection                        = Create({ Type = "Spell",              ID = 976,         useMaxRank = true                                        }), -- solo (shadow school)    
    -- PvP
    ManaBurn                                = Create({ Type = "Spell",              ID = 8129,     useMaxRank = true                                        }),
    -- CrownControl
    Silence                                    = Create({ Type = "Spell",              ID = 15487,     isTalent = true                                         }), -- no rank!
    ShackleUndead                            = Create({ Type = "Spell",              ID = 9484,     useMaxRank = true                                        }),
    MindControl                                = Create({ Type = "Spell",              ID = 605,         useMaxRank = true                                        }),
    PsychicScream                            = Create({ Type = "Spell",              ID = 8122,     useMaxRank = true                                        }),
    -- Misc 
    Fade                                    = Create({ Type = "Spell",              ID = 586,         useMaxRank = true                                        }),
    Levitate                                = Create({ Type = "Spell",              ID = 1706                                                                }),
    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion",          ID = 13444                                                                }),
    -- Trinkets 
    TalismanofEphemeralPower                = Create({ Type = "Trinket",          ID = 18820                                                                }), -- not used in APL but can Queue 
    ZandalarianHeroCharm                    = Create({ Type = "Trinket",          ID = 19950                                                                }), -- not used in APL but can Queue 
    -- Hidden
    SpiritofRedemption                        = Create({ Type = "Spell",              ID = 20711,    isTalent = true, Hidden = true                             }),
    ShadowWeaving                            = Create({ Type = "Spell",              ID = 15257,    useMaxRank = true, isTalent = true, Hidden = true         }),
    ShadowWeavingDeBuff                        = Create({ Type = "Spell",              ID = 15258,    Hidden = true                                            }),
    WeakenedSoul                            = Create({ Type = "Spell",              ID = 6788,        Hidden = true                                            }),
    ShadowReach                                = Create({ Type = "Spell",              ID = 17325,    useMaxRank = true, isTalent = true, Hidden = true         }),
    ImprovedRenew                            = Create({ Type = "Spell",              ID = 14908,    useMaxRank = true, isTalent = true, Hidden = true         }),
}    

Player:AddTier("Priest-Tier2", { 16925, 16926, 16919, 16921, 16920, 16922, 16924, 16923 })
local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })

local player                                 = "player"
local targettarget                            = "targettarget"
local Temp                                     = {
    TotalAndMagicAndCC                        = {"TotalImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
    AttackTypes                             = {"TotalImun", "DamageMagicImun"},
    AuraForInterrupt                         = {"TotalImun", "KickImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
    AuraForFear                                = {"TotalImun", "FearImun"},
    SpiritBuffs                                = {A.DivineSpirit.ID,         A.PrayerofSpirit.ID},
    FortitudeBuffs                            = {A.PowerWordFortitude.ID, A.PrayerofFortitude.ID},
    ShadowProtectionBuffs                    = {A.ShadowProtection.ID,     A.PrayerofShadowProtection.ID},
    MyBurstBuffs                            = {"DamageBuffs", "BurstHaste"},
    IsBlackListedItem                        = {
        [A.TalismanofEphemeralPower.ID]     = true,
        [A.ZandalarianHeroCharm.ID]            = true, 
    },
    MindSootheLevelByRank                    = {
        [""] = 40,
        [0]  = 40,
        [1]  = 40,
        [2]  = 55,
        [3]  = 70,        
    },
    ShadowStacksApplied                        = false,
    MindFlayRowCasted                        = 0,
    IsSpellIsCast                            = {
        [A.LesserHeal:Info()]                 = "LesserHeal",
        [A.Heal:Info()]                        = "Heal", 
        [A.GreaterHeal:Info()]                = "GreaterHeal",
        [A.FlashHeal:Info()]                = "FlashHeal",        
    },    
}

local function IsSchoolShadowUP()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function IsSchoolHolyUP()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

local function IsEnoughHPS(unitID, offset)
    local taken_heal_hps, taken_heal_hits         = Unit(unitID):GetHEAL()
    local taken_damage_dps, taken_damage_hits     = Unit(unitID):GetDMG()
    -- Skip if fight only began since at first hits is not enough data 
    if taken_heal_hits <= 5 or taken_damage_hits <= 5 then 
        return true 
    end 
    return taken_heal_hps * (offset or 1) >= taken_damage_dps
end 

Listener:Add("ACTION_EVENT_PRIEST", "PLAYER_REGEN_ENABLED", function()
        Temp.ShadowStacksApplied = false 
        Temp.MindFlayRowCasted = 0
        if A.Zone ~= "pvp" then 
            Temp.hasInvisibleUnits, Temp.invisibleUnitID = nil, nil 
        end 
end)

local function logMindFlayStop(...)
    if ... == player and not A.MindFlay:IsSpellInCasting() then 
        Temp.MindFlayRowCasted = 0 
    end 
end 

local function logMindFlayStart(...)
    local unitID, _, spellID = ...
    if unitID == player and GetSpellInfo(spellID) == A.MindFlay:Info() then 
        Temp.MindFlayRowCasted = Temp.MindFlayRowCasted + 1 
    end 
end 

Listener:Add("ACTION_EVENT_PRIEST", "UNIT_SPELLCAST_CHANNEL_STOP",  logMindFlayStop)
Listener:Add("ACTION_EVENT_PRIEST", "UNIT_SPELLCAST_INTERRUPTED",   logMindFlayStop)
Listener:Add("ACTION_EVENT_PRIEST", "UNIT_SPELLCAST_CHANNEL_START", logMindFlayStart)

-- Tracks destination unit of the casting spells to prevent by stopcasting overhealing 
local function CastStart(event, ...)
    local unitID, _, spellID = ...
    if unitID == player and spellID then 
        local spellName = GetSpellInfo(spellID)
        if spellName and Temp.IsSpellIsCast[spellName] then 
            Temp.LastPrimaryUnitGUID     = (IsUnitFriendly("mouseover") and UnitGUID("mouseover")) or (IsUnitFriendly("target") and UnitGUID("target")) or UnitGUID(player)
            Temp.LastPrimaryUnitID        = TeamCacheFriendlyGUIDs[Temp.LastPrimaryUnitGUID]
            Temp.LastPrimarySpellName     = spellName 
            Temp.LastPrimarySpellID        = spellID
        end 
    end 
end 

local function CastStop(event, ...)
    if Temp.LastPrimaryUnitGUID then     
        local unitID = ...
        if unitID == player then 
            Temp.LastPrimaryUnitGUID     = nil 
            Temp.LastPrimaryUnitID        = nil 
            Temp.LastPrimarySpellName     = nil 
            Temp.LastPrimarySpellID        = nil 
        end 
    end 
end 

local f = CreateFrame("Frame", nil, UIParent)
LibCC.RegisterCallback(f, "UNIT_SPELLCAST_START",             CastStart    )
LibCC.RegisterCallback(f, "UNIT_SPELLCAST_STOP",             CastStop    )
LibCC.RegisterCallback(f, "UNIT_SPELLCAST_FAILED",             CastStop    )
LibCC.RegisterCallback(f, "UNIT_SPELLCAST_INTERRUPTED",     CastStop    )
LibCC.RegisterCallback(f, "UNIT_SPELLCAST_CHANNEL_START",     CastStart    )
LibCC.RegisterCallback(f, "UNIT_SPELLCAST_CHANNEL_STOP",     CastStop    )

local function CanStopCastingOverHeal(unitID, unitGUID)
    -- @return boolean 
    if GetToggle(1, "StopCast") and Temp.LastPrimaryUnitGUID then
        local castLeftSeconds, castDonePercent, _, spellName = Unit(player):IsCastingRemains()
        if castLeftSeconds > 0 and castLeftSeconds <= 0.35 and spellName == Temp.LastPrimarySpellName and (Temp.LastPrimaryUnitID or (unitID and ((unitGUID or UnitGUID(unitID)) == Temp.LastPrimaryUnitGUID))) then
            local unit = Temp.LastPrimaryUnitID or unitID
            if Unit(unit):HealthPercent() >= 100 then 
                return true 
            end 
            
            local Key = Temp.IsSpellIsCast[spellName]
            local ObjKey
            for i = 0, huge do                  
                if i == 0 then 
                    ObjKey = Key
                else 
                    ObjKey = Key .. i
                end 
                
                if A[ObjKey] then 
                    if A[ObjKey].ID == Temp.LastPrimarySpellID then 
                        return not A[ObjKey]:PredictHeal(unit, 0.8, unitGUID)
                    end 
                else 
                    break 
                end 
            end 
        end 
    end 
end 

-- Tracks Invisible in PvP (3 sec cooldown is enough)
Temp.InvisAuras    = {1784, 1856, 5215, 20580}
-- Rogue: Stealth
UnitCooldown:Register(1784, 3, false, true)
-- Rogue: Vanish 
UnitCooldown:Register(1856, 3, false, true)
-- Druid: Prowl 
UnitCooldown:Register(5215, 3, false, true)
-- NightElf: Shadowmeld
UnitCooldown:Register(20580, 3, false, true)

local function IsInvisAffected(units)
    -- @return boolean
    for i = 1, #Temp.InvisAuras do 
        if UnitCooldown:GetCooldown(units, Temp.InvisAuras[i]) > 0 then 
            return true 
        end 
    end 
end 

local function IsAttackerAffectedByDeBuff(ID, isSource)
    for unitID in pairs(ActiveUnitPlates) do 
        if UnitIsUnit(unitID .. "target", player) and Unit(unitID):HasDeBuffs(ID, isSource) > 0 then 
            return true 
        end 
    end  
end 

-- [[ Healing Tools ]]
local canheal_members_byrank = {}
local function CanHealByPrayerofHealing()
    -- @return object or nil  
    -- Function calculates all party and player units by different ranks of spell and if enough units to heal by some non-blocked rank it will return object exactly with that rank 
    if TeamCacheFriendly.Type then         
        wipe(canheal_members_byrank)
        local member 
        --local PrayerofHealingHP = GetToggle(2, "PrayerofHealing" .. isRank) -- moved in :PredictHeal
        local PrayerofHealingUnits = GetToggle(2, "PrayerofHealingUnits")     
        
        -- Auto: means 4 units 
        if PrayerofHealingUnits > 5 then 
            PrayerofHealingUnits = PrayerofHealingUnits - 1 
            
            local max_party = 1
            for i = 1, 4 do 
                member = "party" .. i
                if Unit(member):IsExists() and Unit(member):GetRange() <= 30 then 
                    max_party = max_party + 1
                end 
            end 
            
            -- Set limits if party is not full
            if max_party >= 3 and max_party < PrayerofHealingUnits then 
                PrayerofHealingUnits = max_party
            end 
        end 
        
        for i = 1, 5 do 
            if i == 5 then 
                member = player
            else 
                member = "party" .. i 
            end 
            
            if i == 5 or (Unit(member):IsExists() and Unit(member):GetRange() <= 30) then 
                local Obj = DetermineHealObject(member, true, nil, nil, nil, A.PrayerofHealing, A.PrayerofHealing4, A.PrayerofHealing3, A.PrayerofHealing2, A.PrayerofHealing1)
                if Obj then 
                    canheal_members_byrank[Obj.isRank] = (canheal_members_byrank[Obj.isRank] or 0) + 1        
                    
                    if canheal_members_byrank[Obj.isRank] >= PrayerofHealingUnits then 
                        return Obj 
                    end                     
                end             
            end 
        end 
    end 
end 

local function CanHealByHolyNova()
    -- @return object or nil  
    if TeamCacheFriendly.Type then 
        local member 
        --local HolyNovaHP = GetToggle(2, "HolyNova" .. isRank) -- moved in :PredictHeal
        local HolyNovaUnits = GetToggle(2, "HolyNovaUnits")            
        
        -- Auto: means party:4, raid:6 
        if HolyNovaUnits > 40 then 
            HolyNovaUnits = HealingEngine.GetMinimumUnits(1, 6) 
            -- If not enough units set max available 
        elseif HolyNovaUnits >= TeamCacheFriendly.Size then 
            HolyNovaUnits = TeamCacheFriendly.Size
        end 
        
        local counter = 0 
        for i = 1, #HealingEngineMembersAll do 
            if A.HolyNova:IsReady(HealingEngineMembersAll[i].Unit, true) and Unit(HealingEngineMembersAll[i].Unit):GetRange() <= 10 and A.HolyNova:PredictHeal(HealingEngineMembersAll[i].Unit, nil, HealingEngineMembersAll[i].GUID) then 
                counter = counter + 1
            end 
            
            if counter >= HolyNovaUnits then 
                return A.HolyNova 
            end 
        end         
    end 
end 

-- [Cast Bars]
function Action.Main_CastBars(unitID, list)
    -- IsReadyM here just to skip gcd checks
    if A.IsInitialized and A.Zone == "pvp" and A.CastBarsInterrupt:IsReadyM(unitID) and InterruptIsValid(unitID, list) and A.CastBarsInterrupt:AbsentImun(unitID, Temp.AuraForInterrupt) and IsSchoolShadowUP() then  
        return true         
    end 
end
-- Placed in Env. for faster performance 
Env.Main_CastBars = Action.Main_CastBars

-- [1] CC AntiFake Rotation
A[1] = function(icon)    
    if A.AntiFakeCC:IsUsable() and not A.AntiFakeCC:IsBlockedBySpellBook() then 
        local isAble = false 
        for unitID in pairs(ActiveUnitPlates) do 
            if Unit(unitID):GetRange() <= 8 and Unit(unitID):IsControlAble("fear") then 
                isAble = true 
                if not A.AntiFakeCC:AbsentImun(unitID, Temp.AuraForFear) then 
                    isAble = false 
                    break 
                end 
            end 
        end
        
        if isAble then 
            return A.AntiFakeCC:Show(icon)
        end          
    end 
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)    
    -- IsReadyM here just to skip gcd checks
    local unitID
    if IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif IsUnitEnemy("target") then 
        unitID = "target"
    end 
    
    if unitID and A.AntiFakeInterrupt:IsReadyM(unitID) then         
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > 0 and not notKickAble and A.AntiFakeInterrupt:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(unitID):IsControlAble("silence") then             
            return A.AntiFakeInterrupt:Show(icon)            
        end 
    end                                                                                 
end

-- [3] Rotation 
A[3] = function(icon)
    local potionToUse    = GetToggle(2, "PotionToUse")
    local combatTime    = Unit(player):CombatTime()
    local inCombat         = combatTime > 0
    local inAoE            = GetToggle(2, "AoE")
    local inRaidPvE        = TeamCacheFriendly.Type == "raid" and not A.IsInPvP
    local inShadowform     = Unit(player):HasBuffs(A.Shadowform.ID, true) > 0
    local inSpirit        = Unit(player):HasBuffs(A.SpiritofRedemption.ID, true) > 0
    local ableEnemyCD     = (A.PlayerSpec == ACTION_CONST_PRIEST_SHADOW and (inShadowform or not A.Shadowform:IsReadyToUse(player, true, true))) or (A.PlayerSpec ~= ACTION_CONST_PRIEST_SHADOW and A.PlayerRole == "DAMAGER")
    local trackSource    = (inShadowform or A.PlayerSpec == ACTION_CONST_PRIEST_SHADOW) and true or nil
    local maxShadowDist = 30 * ((A.ShadowReach:GetTalentRank() == 1 and 1.06) or (A.ShadowReach:GetTalentRank() == 2 and 1.13) or (A.ShadowReach:GetTalentRank() == 3 and 1.2) or 1)
    
    local function PlayerRebuff()
        -- Only buffs which can be applied without target selection!
        if inSpirit then 
            return 
        end 
        
        if A.PlayerRace == "Scourge" then 
            if A.TouchofWeakness:IsReady(player) and IsSchoolShadowUP() and Unit(player):HasBuffs(A.TouchofWeakness.ID, true) <= GetGCD() and (not inCombat or not IsAttackerAffectedByDeBuff(A.TouchofWeakness.ID, true)) then 
                return A.TouchofWeakness:Show(icon)
            end 
        end 
        
        if A.PlayerRace == "Troll" then 
            if A.Shadowguard:IsReady(player) and IsSchoolShadowUP() and (Unit(player):HasBuffs(A.Shadowguard.ID, true) <= GetGCD() or (not inCombat and Unit(player):HasBuffsStacks(A.Shadowguard.ID, true) <= 1)) then 
                return A.Shadowguard:Show(icon)
            end 
        end 
        
        -- Inner Fire 
        if A.InnerFire:IsReady(player) and IsSchoolHolyUP() and (Unit(player):HasBuffs(A.InnerFire.ID, true) <= GetGCD() or Unit(player):HasBuffsStacks(A.InnerFire.ID, true) <= 1) then 
            return A.InnerFire:Show(icon)
        end 
        
        -- Shadowform 
        --if not inShadowform and A.Shadowform:IsReady(player) and IsSchoolShadowUP() then 
        --return A.Shadowform:Show(icon)
        --end 
    end 
    
    local function UnitRebuff(unitID, attackerID)
        if inSpirit and UnitIsUnit(unitID, player) then 
            return 
        end 
        
        -- Group 
        if TeamCacheFriendly.Type and Unit(unitID):InGroup() and IsSchoolHolyUP() then 
            if A.PrayerofFortitude:IsReady(unitID) and Unit(unitID):HasBuffs(A.PrayerofFortitude.ID) == 0 then 
                if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                    return A.InnerFocus:Show(icon)
                end             
                return A.PrayerofFortitude:Show(icon)
            end 
            
            if A.PrayerofShadowProtection:IsReady(unitID) and Unit(unitID):HasBuffs(A.PrayerofShadowProtection.ID) == 0 then 
                if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                    return A.InnerFocus:Show(icon)
                end             
                return A.PrayerofShadowProtection:Show(icon)
            end 
            
            if A.PrayerofSpirit:IsReady(unitID) and Unit(unitID):HasBuffs(A.PrayerofSpirit.ID) == 0 then 
                if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                    return A.InnerFocus:Show(icon)
                end             
                return A.PrayerofSpirit:Show(icon)
            end             
        end 
        
        -- Solo 
        if Unit(unitID):IsPlayer() or Unit(unitID):IsPet() then 
            if A.PowerWordFortitude:IsReady(unitID) and IsSchoolHolyUP() and Unit(unitID):HasBuffs(Temp.FortitudeBuffs) == 0 then 
                return A.PowerWordFortitude:Show(icon)
            end 
            
            if A.ShadowProtection:IsReady(unitID) and IsSchoolShadowUP() and Unit(unitID):HasBuffs(Temp.ShadowProtectionBuffs) == 0 then 
                return A.ShadowProtection:Show(icon)
            end 
            
            if A.DivineSpirit:IsReady(unitID) and IsSchoolHolyUP() and Unit(unitID):HasBuffs(Temp.SpiritBuffs) == 0 then 
                return A.DivineSpirit:Show(icon)
            end 
            
            -- Fear Ward
            if A.PlayerRace == "Dwarf" and (not inShadowform or GetToggle(2, "CancelShadowForm")) and A.FearWard:IsReady(unitID) and IsSchoolHolyUP() and Unit(unitID):HasBuffs(A.FearWard.ID) <= GetGCD() then 
                if inShadowform then 
                    Player:CancelBuff(A.Shadowform:Info())
                end 
                
                return A.FearWard:Show(icon)             
            end     
        end 
        
        -- Shadow: Power Word: Shield 
        if attackerID and unitID == player and inShadowform and inCombat and A.PowerWordShield:IsReady(player) and GetToggle(2, "SelfPOWS") and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 and (UnitIsUnit(unitID, attackerID .. "target") or Unit(unitID):GetDMG() * 30 >= A.PowerWordShield:GetSpellDescription()[1]) then 
            return A.PowerWordShield:Show(icon)
        end         
    end 
    
    local function Supportive(unitID)
        -- Dispels 
        if A.DispelMagic:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) then 
            return A.DispelMagic:Show(icon)
        end 
        
        if (not inShadowform or GetToggle(2, "CancelShadowForm")) and A.AbolishDisease:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and AuraIsValid(unitID, "UseDispel", "Disease") and Unit(unitID):HasBuffs(A.AbolishDisease.ID) == 0 then 
            if inShadowform then 
                Player:CancelBuff(A.Shadowform:Info())
            end 
            
            return A.AbolishDisease:Show(icon)
        end 
        
        if (not inShadowform or GetToggle(2, "CancelShadowForm")) and A.CureDisease:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and AuraIsValid(unitID, "UseDispel", "Disease") and Unit(unitID):HasBuffs(A.AbolishDisease.ID) == 0 then 
            if inShadowform then 
                Player:CancelBuff(A.Shadowform:Info())
            end             
            
            return A.CureDisease:Show(icon)
        end  
    end 
    
    local function Enemy(unitID)    
        if inSpirit then 
            return 
        end 
        
        local isCap = Unit(unitID):IsDeBuffsLimited()
        
        -- Out of combat: Player Buffer 
        if not unitID ~= targettarget and not inCombat and UnitRebuff(player) then  
            return true              
        end         
        
        -- Interrupts 
        if not unitID ~= targettarget and A.Silence:IsReady(unitID) and IsSchoolShadowUP() then 
            local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
            if castLeft > 0 and not notKickAble and InterruptIsValid(unitID, "TargetMouseover") and castLeft < GetGCD() + GetCurrentGCD() and A.Silence:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(unitID):IsControlAble("silence") then 
                return A.Silence:Show(icon)
            end 
        end 
        
        -- Crown Control 
        if A.ShackleUndead:IsReady(unitID) and IsSchoolShadowUP() and Player:IsStaying() and Unit(unitID):CombatTime() > 0 and Unit(unitID):IsUndead() and Unit(unitID):GetDMG() == 0 and A.ShackleUndead:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and Unit(unitID):IsControlAble("incapacitate") then 
            return A.ShackleUndead:Show(icon)
        end 
        
        -- Shadowform 
        if unitID ~= targettarget and not inShadowform and A.Shadowform:IsReady(player) and IsSchoolShadowUP() then 
            return A.Shadowform:Show(icon)
        end         
        
        -- Pre pull by cast 
        if not inCombat and GetToggle(2, "StartByPreCast") and Player:IsStaying() and Player:CastRemains() == 0 and Unit(unitID):CombatTime() == 0 then 
            if not inShadowform then 
                local PreCast = DetermineUsableObject(unitID, nil, nil, nil, nil, A.HolyFire, A.Smite)
                if PreCast and IsSchoolHolyUP() and PreCast:AbsentImun(unitID, Temp.AttackTypes) and PreCast:GetSpellTimeSinceLastCast() > 1 then 
                    return PreCast:Show(icon)
                end 
            end 
            
            if A.MindBlast:IsReady(unitID) and IsSchoolShadowUP() and A.MindBlast:AbsentImun(unitID, Temp.AttackTypes) and A.MindBlast:GetSpellTimeSinceLastCast() > 1 then 
                return A.MindBlast:Show(icon)
            end 
        end 
        
        -- Starts boss / pvp player fight with Shadow Weaving stacking 
        if not Temp.ShadowStacksApplied and A.ShadowWeaving:GetTalentRank() > 0 and GetToggle(2, "StartByShadowWeavingsStacking") and (Unit(unitID):IsBoss() or Unit(unitID):IsPlayer()) and IsSchoolShadowUP() then      
            local SWstacks = Unit(unitID):HasDeBuffsStacks(A.ShadowWeavingDeBuff.ID, trackSource)
            
            -- Lowest rank up to 4 (or max rank if user blocked lowest rank)
            if SWstacks < 4 and A.ShadowWordPain1:IsReady(unitID) and A.ShadowWordPain1:AbsentImun(unitID, Temp.AttackTypes) then
                return A.ShadowWordPain1:Show(icon)
            end 
            
            -- Max rank from 4 to 5 
            if SWstacks < 5 and A.ShadowWordPain:IsReady(unitID) and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) then 
                return A.ShadowWordPain:Show(icon)
            end 
            
            if SWstacks >= 5 then 
                Temp.ShadowStacksApplied = true 
            end 
        end 
        
        -- PvP: Hex of Weakness
        if A.IsInPvP and A.PlayerRace == "Troll" and A.HexofWeakness:IsReady(unitID) and A.HexofWeakness:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and Unit(unitID):IsPlayer() and Unit(unitID):HasDeBuffs(A.HexofWeakness.ID) <= GetGCD() + GetCurrentGCD() and IsSchoolShadowUP() then 
            return A.HexofWeakness:Show(icon)
        end 
        
        -- Purge (high)
        if unitID ~= targettarget and A.DispelMagic:IsReady(unitID, nil, nil, true) and A.DispelMagic:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and IsSchoolHolyUP() and AuraIsValid(unitID, "UsePurge", Unit(unitID):InGroup() and "PurgeFriendly" or "PurgeHigh") then 
            return A.DispelMagic:Show(icon)
        end             
        
        -- Trinekts 
        local TrinketsMode = GetToggle(2, "TrinketBurstSyncUP")
        if unitID ~= targettarget and ableEnemyCD and (TrinketsMode == "Always" or (TrinketsMode == "BurstSync" and BurstIsON(unitID)) or Unit(player):HasBuffs(Temp.MyBurstBuffs) > 0) and Unit(unitID):GetRange() <= maxShadowDist then 
            if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unitID, Temp.AttackTypes) then -- and not Temp.IsBlackListedItem[A.Trinket1:GetID()]
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unitID, Temp.AttackTypes) then -- and not Temp.IsBlackListedItem[A.Trinket2:GetID()]
                return A.Trinket2:Show(icon)
            end     
        end         
        
        -- CD's
        if unitID ~= targettarget and ableEnemyCD and BurstIsON(unitID) and A.AbsentImun(nil, unitID, Temp.AttackTypes) and Unit(unitID):GetRange() <= maxShadowDist then                     
            -- Racials         
            if A.Berserking:AutoRacial(unitID) then 
                return A.Berserking:Show(icon)
            end 
            
            -- Power Infusion
            if not inShadowform and A.PowerInfusion:IsReady(unitID) and A.PowerInfusion:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolHolyUP() then 
                local PImode = GetToggle(2, "PowerInfusionUnits")                
                -- [1] SELF 
                -- [2] DAMAGER 
                -- [3] HEALER     
                -- [4] ENEMY 
                if PImode[4] then 
                    return A.PowerInfusion:Show(icon)
                end 
            end             
            
            -- Devouring Plague
            if not isCap and combatTime > 10 and A.PlayerRace == "Scourge" and A.DevouringPlague:IsRacialReady(unitID) and A.DevouringPlague:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() then 
                return A.DevouringPlague:Show(icon)
            end             
        end         
        
        --Icy-Veins: https://www.icy-veins.com/wow-classic/shadow-priest-dps-pve-rotation-cooldowns-abilities
        --Use Shadow Word: Pain and maintain it on the boss
        local SWPspellID, SWPremains = Unit(unitID):GetDeBuffInfoByName(A.ShadowWordPain:Info(), trackSource)
        
        if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and A.ShadowWordPain.ID >= SWPspellID and (SWPremains <= GetGCD() + GetCurrentGCD() or (A.ShadowWeaving:GetTalentRank() > 0 and Unit(unitID):HasDeBuffs(A.ShadowWeavingDeBuff.ID, trackSource) <= GetGCD() + GetCurrentGCD())) then 
            return A.ShadowWordPain:Show(icon)
        end 
        
        --Downranked spells can be used when your mana runs out and consumables are not available. In particular Rank 1 Shadow Word: Pain to help apply or maintain the 5 stacks of Shadow Weaving
        if A.ShadowWordPain1:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain1:AbsentImun(unitID, Temp.AttackTypes) and A.ShadowWordPain1.ID >= SWPspellID and ((A.ShadowWordPain:IsBlocked() and SWPremains <= GetGCD() + GetCurrentGCD()) or A.ShadowWeaving:GetTalentRank() > 0 and Unit(unitID):HasDeBuffs(A.ShadowWeavingDeBuff.ID, trackSource) <= GetGCD() + GetCurrentGCD()) then 
            return A.ShadowWordPain1:Show(icon)
        end 
        
        --Use Mind Blast as often as possible. Be careful on the pull if you have an undergeared tank, as this ability can generate a huge amount of threat, especially if it critically strikes
        if A.MindBlast:IsReady(unitID, nil, nil, GetToggle(2, "ByPassMindBlast")) and IsSchoolShadowUP() and A.MindBlast:AbsentImun(unitID, Temp.AttackTypes) and Player:IsStaying() then 
            --You should ideally use Inner Focus with Mind Blast for maximum damage and Mana conservation
            if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                return A.InnerFocus:Show(icon)
            end 
            
            return A.MindBlast:Show(icon)
        end 
        
        -- Purge (low)
        if unitID ~= targettarget and A.DispelMagic:IsReady(unitID, nil, nil, true) and A.DispelMagic:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and IsSchoolHolyUP() and AuraIsValid(unitID, "UsePurge", "PurgeLow") then 
            return A.DispelMagic:Show(icon)
        end         
        
        -- PvE: Mind Soothe
        if not A.IsInPvP and not isCap and combatTime > 10 and A.MindSoothe:IsReady(unitID) and A.MindSoothe:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and IsSchoolShadowUP() and not Unit(unitID):IsBoss() and UnitIsUnit(unitID .. "target", player) and Unit(unitID):CombatTime() > 0 and Unit(unitID):GetLevel() <= Temp.MindSootheLevelByRank[A.MindSoothe:GetSpellRank()] and Unit(unitID):GetRange() > 10 and (Unit(unitID):GetDPS() > 0 or Unit(unitID):IsCastingRemains() > 0) and Unit(unitID):GetCurrentSpeed() == 0 and Unit(unitID):HasDeBuffs(A.MindSoothe.ID, true) == 0 then 
            return A.MindSoothe:Show(icon)
        end 
        
        -- Supportive
        if unitID ~= targettarget and Supportive(player) then 
            return true 
        end             
        
        -- Rebuff
        if unitID ~= targettarget and inCombat and (PlayerRebuff() or UnitRebuff(player, unitID)) then 
            return true              
        end 
        
        -- Vampiric Embrace
        if not isCap and A.VampiricEmbrace:IsReady(unitID) and A.VampiricEmbrace:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and IsSchoolShadowUP() and Unit(unitID):CombatTime() > 5 and (Unit(unitID):IsBoss() or Unit(unitID):TimeToDie() > 30 or (A.Zone == "none" and Unit(unitID):TimeToDie() > 10)) and Unit(unitID):HasDeBuffs(A.VampiricEmbrace.ID) <= GetGCD() then 
            return A.VampiricEmbrace:Show(icon)
        end                
        
        -- PvE: Mana Burn (Moam in Ruins of Ahn'Qiraj)
        if inRaidPvE and A.ManaBurn:IsReady(unitID) and A.ManaBurn:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and Player:IsStaying() and Unit(unitID):IsBoss() and select(6, Unit(unitID):InfoGUID()) == 15340 then 
            return A.ManaBurn:Show(icon)
        end         
        
        -- PvP: Mana burn 
        if A.IsInPvP and A.ManaBurn:IsReady(unitID) and A.ManaBurn:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and Player:IsStaying() and select(2, UnitPowerType(unitID)) == "MANA" and Unit(unitID):IsPlayer() and Unit(unitID):Power() >= A.ManaBurn:GetSpellDescription()[1] and (not Unit(player):IsFocused() or A.IsInDuel) then 
            return A.ManaBurn:Show(icon)
        end 
        
        --In almost every instance you would consider Casting Starshards, Mind Flay is the better option. But on the rare occasion, your target is going to be able to run out of line of sight with very little health remaining. It is a better option to cast Starshards, because it can still hit the target, even out of line of sight
        if A.PlayerRace == "NightElf" and A.Starshards:IsReady(unitID) and A.Starshards:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and Player:IsStaying() and Unit(unitID):IsMovingOut() and Unit(unitID):GetRange() >= 20 then 
            return A.Starshards:Show(icon)
        end 
        
        -- Holy Fire 
        -- has a very long cast time, after which it deals direct damage, followed by a DoT over 10 seconds. This spell is good to start combat off with, but typically should not be used too much outside of that. As a Shadow Priest, you ignore this ability altogether
        
        -- Smite 
        if not inShadowform and A.Smite:IsReady(unitID) and A.Smite:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolHolyUP() and Player:IsStaying() then 
            return A.Smite:Show(icon)
        end 
        
        -- Mind Flay 
        if not GetToggle(2, "MindFlayTiming") or A.MindBlast:GetCooldown() >= GetGCD() + 0.5 or not IsUsableSpell(A.MindBlast:Info()) then 
            --Use Mind Flay to fill in the gaps between your other casts or if you do not have enough Mana for them
            if A.MindFlay:IsReady(unitID) and A.MindFlay:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and Player:IsStaying() then 
                return A.MindFlay:Show(icon)         
            end 
            
            -- Mind Flay (double cast in a row if user prefer by UI)
            if Temp.MindFlayRowCasted <= 1 and GetToggle(2, "DoubleCastMindFlay") and A.MindFlay:IsSpellInCasting() and A.MindFlay:IsReadyToUse(unitID, true) then 
                return A.MindFlay:Show(icon)
            end 
        end 
        
        -- Holy Nova 
        if unitID ~= targettarget and not inShadowform and inAoE and MultiUnits:GetByRange(10, 3) >= 3 and (A.Zone ~= "pvp" or not EnemyTeam():IsBreakAble(10)) and IsSchoolHolyUP() then 
            --local HN = DetermineUsableObject(unitID, true, nil, nil, nil, A.HolyNova, A.HolyNova5, A.HolyNova4, A.HolyNova3, A.HolyNova2, A.HolyNova1)
            local HN = A.HolyNova
            if HN and HN:AbsentImun(unitID, Temp.AttackTypes) then 
                return HN:Show(icon)
            end 
        end 
        
        -- SwiftnessPotion
        if potionToUse == "SwiftnessPotion" and inCombat and CanUseSwiftnessPotion(icon, unitID, 35) then 
            return true
        end 
        
        -- LivingActionPotion
        if potionToUse == "LivingActionPotion" and CanUseLivingActionPotion(icon, false) then 
            return true
        end 
    end 
    
    local function Friendly(unitID)        
        local unitGUID = UnitGUID(unitID)
        
        -- StopCast if destination is unknown as unitID 
        if not Temp.LastPrimaryUnitID and CanStopCastingOverHeal(unitID, unitGUID) then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        -- Out of combat: Buffer 
        if not inCombat then 
            -- Lightwell (if it's boss fight / pvp if we staying long time in fk room for example, preparation otherwise it's useless)
            if not inShadowform and TeamCacheFriendly.Type and A.Lightwell:IsReady(player) and IsSchoolHolyUP() and Player:IsStaying() and ((Unit(unitID .. "target"):IsBoss() and not Unit(unitID .. "target"):IsDead()) or (A.Zone == "pvp" and Player:IsStayingTime() > 4)) then 
                return A.Lightwell:Show(icon)
            end 
            
            -- Ress 
            if A.Resurrection:IsReady(unitID) and IsSchoolHolyUP() and Player:IsStaying() and Unit(unitID):IsDead() then 
                if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                    return A.InnerFocus:Show(icon)
                end             
                
                return A.Resurrection:Show(icon)
            end            
            
            -- Members buffer 
            if UnitRebuff(unitID) then 
                return true 
            end 
        end             
        
        -- Supportive
        if Supportive(unitID) then 
            return true 
        end         
        
        -- Power Word: Shield (toggle - PrePare)
        if GetToggle(2, "PreParePOWS") and A.PowerWordShield:IsReady(unitID) and A.PowerWordShield:AbsentImun(unitID) and IsSchoolHolyUP() and Unit(unitID):InGroup() and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 then 
            return A.PowerWordShield:Show(icon)                        
        end         
        
        -- Renew (toggle - PrePare)
        if not inShadowform and GetToggle(2, "PrePareRenew") and IsSchoolHolyUP() and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 and (not GetToggle(2, "RenewOnlyTank") or Unit(unitID):IsTank()) then 
            local Renew = DetermineUsableObject(unitID, nil, nil, nil, nil, A.Renew, A.Renew9, A.Renew8, A.Renew7, A.Renew6, A.Renew5, A.Renew4, A.Renew3, A.Renew2, A.Renew1)
            if Renew and Renew:AbsentImun(unitID) then 
                return Renew:Show(icon)                        
            end 
        end     
        
        -- Power Word: Shield (self buff if we got attacked by enemies to stop interrupts by damage)
        if GetToggle(2, "SelfPOWS") and A.PowerWordShield:IsReady(player) and IsSchoolHolyUP() and Unit(player):HasDeBuffs(A.WeakenedSoul.ID) == 0 and Unit(player):HasBuffs(A.PowerWordShield.ID) == 0 and MultiUnits:GetByRangeIsFocused(player, nil, 1) >= 1 and Unit(player):GetRealTimeDMG() > 0 then 
            if not UnitIsUnit(player, unitID) then 
                HealingEngine.SetTarget(player)
                -- return -- Ideally must be here but can caused wrong behaivor if engine turned off 
            else 
                return A.PowerWordShield:Show(icon)
            end                         
        end         
        
        -- CD's
        if BurstIsON(unitID) and A.AbsentImun(nil, unitID) then 
            -- Racials 
            if A.Berserking:AutoRacial(unitID) and Unit(unitID):InRange() then 
                -- If Everything then on cooldown 
                -- If Auto then:
                -- 1. if not enough HPS to heal up all group during next 15 sec 
                -- 2. if group received too much damage in short time 
                -- 3. if current unitID started receiving non healing able damage 
                if GetToggle(1, "Burst") ~= "Auto" or 
                (
                    Unit(unitID):TimeToDie() >= GetGCD() * 2 + GetCurrentGCD() + 1.5 and -- let's be sure what while this move our primary unitID will not be dropped 
                    (
                        -- 3
                        (
                            not IsEnoughHPS(unitID, 1.25) and 
                            Unit(player):HasBuffs(A.PowerInfusion.ID) == 0 and 
                            Unit(unitID):HealthPercent() < 60 and 
                            Unit(unitID):TimeToDieX(25) < 5
                        ) or 
                        -- 2
                        (
                            HealingEngine.GetHealthFrequency(3.5) > 25 and 
                            HealingEngine.GetIncomingDMG() > HealingEngine.GetIncomingHPS()
                        ) or 
                        -- 1
                        HealingEngine.GetTimeToFullDie() <= 15
                    )
                )
                then 
                    return A.Berserking:Show(icon)
                end                 
            end     
            
            -- Power Infusion
            if not inShadowform and A.PowerInfusion:IsReady(unitID) and IsSchoolHolyUP() then 
                local PImode = GetToggle(2, "PowerInfusionUnits")                
                -- [1] SELF 
                -- [2] DAMAGER 
                -- [3] HEALER     
                -- [4] ENEMY 
                local isSelf     = PImode[1] and UnitIsUnit(player, unitID)
                local isDamager = PImode[2] and Unit(unitID):IsDamager()
                local isHealer     = PImode[3] and Unit(unitID):IsHealer()
                if isSelf or isDamager or isHealer then 
                    if     GetToggle(1, "Burst") ~= "Auto" or 
                    (
                        Unit(unitID):TimeToDie() >= GetGCD() * 2 + GetCurrentGCD() + 1.5 and -- let's be sure what while this move our primary unitID will not be dropped 
                        (
                            (
                                isDamager and
                                Unit(unitID):HasBuffs("DamageBuffs") > 10
                            ) or 
                            (
                                isSelf and 
                                (
                                    (
                                        not IsEnoughHPS(unitID, 1.25) and 
                                        Unit(unitID):TimeToDieX(25) < 5
                                    ) or  
                                    HealingEngine.GetTimeToFullDie() <= 15 or 
                                    Unit(player):HasBuffs("BurstHaste") > 10 or 
                                    Unit(player):HasBuffs(A.Berserking.ID, true) > 10
                                )
                            ) or 
                            (
                                not isSelf and 
                                isHealer and 
                                (
                                    (
                                        not IsEnoughHPS(unitID .. "target", 1.25) and
                                        Unit(unitID .. "target"):TimeToDieX(25) < 5
                                    ) or  
                                    HealingEngine.GetTimeToFullDie() <= 15 
                                )
                            )
                        )
                    )
                    then 
                        return A.PowerInfusion:Show(icon)
                    end 
                end 
            end 
        end 
        
        -- Trinkets 
        local TrinketBurstHealing = GetToggle(2, "TrinketBurstHealing")
        if inCombat and TrinketBurstHealing >= 0 and Unit(unitID):HealthPercent() <= TrinketBurstHealing and Unit(unitID):InRange() then 
            if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DPS" and A.Trinket1:AbsentImun(unitID) then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DPS" and A.Trinket2:AbsentImun(unitID) then 
                return A.Trinket2:Show(icon)
            end     
        end    
        
        -- [[ DYING PHASE ]]         
        if IsSchoolHolyUP() and Unit(unitID):TimeToDie() < 8 and Unit(unitID):HealthPercent() < 50 then 
            if not inShadowform and Player:IsStaying() then 
                -- Greater Heal (max rank)
                if A.GreaterHeal:IsReady(unitID) and A.GreaterHeal:AbsentImun(unitID) and A.GreaterHeal:PredictHeal(unitID, 1.2, unitGUID) and A.GreaterHeal:CanSafetyCastHeal(unitID) then 
                    if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                        return A.InnerFocus:Show(icon)
                    end         
                    return A.GreaterHeal:Show(icon)
                end 
                
                -- Flash Heal (max rank)
                if A.FlashHeal:IsReady(unitID) and A.FlashHeal:AbsentImun(unitID) and A.FlashHeal:PredictHeal(unitID, nil, unitGUID) and A.FlashHeal:CanSafetyCastHeal(unitID) then 
                    if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                        return A.InnerFocus:Show(icon)
                    end         
                    return A.FlashHeal:Show(icon)
                end                             
            end 
            
            -- Power Word: Shield (max rank)
            if A.PowerWordShield:IsReady(unitID) and A.PowerWordShield:AbsentImun(unitID) and Unit(unitID):InGroup() and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 and Unit(unitID):TimeToDie() < 3 + GetGCD() + GetCurrentGCD() then 
                return A.PowerWordShield:Show(icon)                        
            end             
        end 
        
        -- [[ AOE ]]
        -- Improved Renew (build)
        if not inShadowform and A.ImprovedRenew:GetTalentRank() > 0 and IsSchoolHolyUP() and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 and (not GetToggle(2, "RenewOnlyTank") or Unit(unitID):IsTank()) then 
            local ImprovedRenew = DetermineHealObject(unitID, nil, nil, nil, nil, A.Renew, A.Renew9, A.Renew8, A.Renew7, A.Renew6, A.Renew5, A.Renew4, A.Renew3, A.Renew2, A.Renew1)
            if ImprovedRenew and ImprovedRenew:AbsentImun(unitID) then 
                return ImprovedRenew:Show(icon)
            end 
        end 
        
        if inAoE and not inShadowform and IsSchoolHolyUP() then 
            -- Prayer of Healing (different ranks)
            if Player:IsStaying() then 
                local PrayerofHealing = CanHealByPrayerofHealing()
                if PrayerofHealing then 
                    -- Only if it's max rank 
                    if PrayerofHealing.isRank == A.PrayerofHealing.isRank and A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                        return A.InnerFocus:Show(icon)
                    end                     
                    return PrayerofHealing:Show(icon)
                end 
            end 
            
            -- Holy Nova (max rank, while moving or more than 6 sec ago) 
            if (not A.IsInPvP or not EnemyTeam():IsBreakAble(10)) and (not Player:IsStaying() or (A.HolyNova:GetSpellTimeSinceLastCast() == 0 or A.HolyNova:GetSpellTimeSinceLastCast() > 6)) then 
                local HolyNovaHeal = CanHealByHolyNova()
                if HolyNovaHeal then 
                    return HolyNovaHeal:Show(icon)
                end 
            end 
        end         
        
        -- [[ LARGE PHASE ]]
        -- Greater Heal (max rank, >1)
        if not inShadowform and Player:IsStaying() and A.GreaterHeal.isRank > 1 and IsSchoolHolyUP() and A.GreaterHeal:IsReady(unitID) and A.GreaterHeal:AbsentImun(unitID) and A.GreaterHeal:PredictHeal(unitID, nil, unitGUID) and A.GreaterHeal:CanSafetyCastHeal(unitID) then 
            if A.InnerFocus:IsReady(player) and Unit(player):HasBuffs(A.InnerFocus.ID, true) == 0 then 
                return A.InnerFocus:Show(icon)
            end         
            return A.GreaterHeal:Show(icon)
        end         
        
        -- Flash Heal (different ranks, only if unitID takes heavy damage)
        local FlashHeal -- leave it here to pass at the down of APL if safety cast is not up but still try to heal unit 
        if not inShadowform and Player:IsStaying() and IsSchoolHolyUP() and not IsEnoughHPS(unitID) and (HealingEngine.IsMostlyIncDMG(unitID) or Unit(unitID):HealthPercent() < 35 or (Unit(unitID):TimeToDieX(20) < 3 and Unit(unitID):HealthPercent() < 50)) then 
            FlashHeal = DetermineHealObject(unitID, nil, nil, nil, nil, A.FlashHeal, A.FlashHeal6, A.FlashHeal5, A.FlashHeal4, A.FlashHeal3, A.FlashHeal2, A.FlashHeal1)
            if FlashHeal and FlashHeal:AbsentImun(unitID) and FlashHeal:CanSafetyCastHeal(unitID) then 
                return FlashHeal:Show(icon)
            end         
        end 
        
        -- [[ NORMAL PHASE ]]        
        -- Heal (different ranks, skip if has Tier2 bonus 8 parts)
        local Heal -- leave it here to pass at the down of APL if safety cast is not up but still try to heal unit 
        if not inShadowform and Player:IsStaying() and not Player:HasTier("Priest-Tier2", 8) and IsSchoolHolyUP() then 
            Heal = DetermineHealObject(unitID, nil, nil, nil, nil, A.Heal, A.Heal3, A.Heal2, A.Heal1)
            if Heal and Heal:AbsentImun(unitID) and Heal:CanSafetyCastHeal(unitID) then 
                return Heal:Show(icon)
            end         
        end 
        
        -- Power Word: Shield (max rank, skip if unit has rage, dying phase still will apply shield if unit will die)
        if IsSchoolHolyUP() and select(2, UnitPowerType(unitID)) ~= "RAGE" and A.PowerWordShield:IsReady(unitID) and A.PowerWordShield:AbsentImun(unitID) and Unit(unitID):InGroup() and Unit(unitID):HasDeBuffs(A.WeakenedSoul.ID) == 0 and Unit(unitID):HasBuffs(A.PowerWordShield.ID) == 0 and A.PowerWordShield:PredictHeal(unitID, nil, unitGUID) then 
            return A.PowerWordShield:Show(icon)                        
        end 
        
        -- Renew (different ranks)
        if not inShadowform and IsSchoolHolyUP() and Unit(unitID):HasBuffs(A.Renew.ID, true) == 0 and (not GetToggle(2, "RenewOnlyTank") or Unit(unitID):IsTank()) then 
            local Renew = DetermineHealObject(unitID, nil, nil, nil, nil, A.Renew, A.Renew9, A.Renew8, A.Renew7, A.Renew6, A.Renew5, A.Renew4, A.Renew3, A.Renew2, A.Renew1)
            if Renew and Renew:AbsentImun(unitID) then 
                return Renew:Show(icon)
            end 
        end 
        
        -- Greater Heal (different ranks, not max rank)
        if not inShadowform and Player:IsStaying() and IsSchoolHolyUP() then 
            local GreaterHeal = DetermineHealObject(unitID, nil, nil, nil, nil, A.GreaterHeal4, A.GreaterHeal3, A.GreaterHeal2, A.GreaterHeal1)    
            if GreaterHeal and GreaterHeal.isRank ~= A.GreaterHeal.isRank and GreaterHeal:CanSafetyCastHeal(unitID) then 
                return GreaterHeal:Show(icon)
            end 
        end             
        
        -- [[ SAFETY CAST PROBLEM PHASE ]]
        if FlashHeal then 
            return FlashHeal:Show(icon)
        end 
        
        if Heal then 
            return Heal:Show(icon)
        end 
        
        -- Lesser Heal (different ranks)
        if not inShadowform and Player:IsStaying() and IsSchoolHolyUP() then 
            local LesserHeal = DetermineHealObject(unitID, nil, nil, nil, nil, A.LesserHeal, A.LesserHeal2, A.LesserHeal1)
            if LesserHeal and LesserHeal:AbsentImun(unitID) then -- without safety cast 
                return LesserHeal:Show(icon)
            end         
        end         
        
        -- Rebuff 
        if inCombat and (UnitRebuff(unitID) or PlayerRebuff()) then 
            return true 
        end         
        
        -- SwiftnessPotion
        if potionToUse == "SwiftnessPotion" and inCombat and CanUseSwiftnessPotion(icon, unitID, 45) then 
            return true
        end 
        
        -- @targettarget damage rotation
        if IsUnitEnemy(targettarget) and Enemy(targettarget) then 
            return true 
        end 
        
        -- LivingActionPotion
        if potionToUse == "LivingActionPotion" and CanUseLivingActionPotion(icon, false) then 
            return true
        end 
    end 
    
    ----------------------------------------------------------------------
    -- APL 
    ----------------------------------------------------------------------    
    if not inSpirit then 
        -- [[ LOSS OF CONTROL - RACIALS ]] 
        if GetToggle(2, "UseRacial-LoC") then 
            -- Stoneform
            if A.Stoneform:AutoRacial() then 
                return A.Stoneform:Show(icon)
            end 
            
            -- WilloftheForsaken
            if A.WilloftheForsaken:AutoRacial() then 
                return A.WilloftheForsaken:Show(icon)
            end 
        end 
        
        -- LivingActionPotion
        if potionToUse == "LivingActionPotion" and CanUseLivingActionPotion(icon, true) then 
            return true
        end 
        
        -- Deffensives
        if inCombat then 
            -- LimitedInvulnerabilityPotion
            if potionToUse == "LimitedInvulnerabilityPotion" and combatTime > 2 and Unit(player):HasBuffs("DeffBuffs") == 0 and CanUseLimitedInvulnerabilityPotion(icon) then 
                return true  
            end 
            
            -- HealingPotion 
            if potionToUse == "HealingPotion" and combatTime > 2 and CanUseHealingPotion(icon) then 
                return true 
            end 
            
            -- Desperate Prayer
            if (not inShadowform or GetToggle(2, "CancelShadowForm")) and (A.PlayerRace == "Human" or A.PlayerRace == "Dwarf") then 
                local DesperatePrayer = GetToggle(2, "DesperatePrayer")
                if DesperatePrayer >= 0 and A.DesperatePrayer:IsReady(player) and IsSchoolHolyUP() and 
                (
                    -- Auto 
                    (     
                        DesperatePrayer >= 100 and 
                        A.DesperatePrayer:PredictHeal(player) and 
                        Unit(player):TimeToDieX(20) < GetGCD()
                    ) or 
                    -- Custom
                    (    
                        DesperatePrayer < 100 and 
                        Unit(player):HealthPercent() <= DesperatePrayer
                    )
                ) 
                then 
                    if inShadowform then 
                        Player:CancelBuff(A.Shadowform:Info())
                    end 
                    
                    return A.DesperatePrayer:Show(icon)
                end                     
            end 
            
            -- PvP (Auto only): Feedback (by Magic percent of total incoming damage, usable in Shadowform)
            if A.PlayerRace == "Human" then 
                local Feedback = GetToggle(2, "FeedbackIncomingMagic")
                if     Feedback >= 0 and A.Feedback:IsReady(player) and 
                (
                    -- Auto 
                    (     
                        Feedback >= 100 and 
                        A.IsInPvP and 
                        -- If more than 60% of total damage is magic
                        Unit(player):GetDMG(4) > Unit(player):GetDMG() * 0.6
                    ) or 
                    -- Custom
                    (    
                        Feedback < 100 and 
                        -- If more than custom % of total damage is magic
                        Unit(player):GetDMG(4) > Unit(player):GetDMG() * (Feedback / 100)
                    )
                ) 
                then 
                    return A.Feedback:Show(icon)
                end                 
            end             
            
            -- Stoneform (usable in Shadowform)
            if CanUseStoneformDefense(icon) then 
                return true 
            end 
            
            -- Elune's Grace 
            if (not inShadowform or GetToggle(2, "CancelShadowForm")) and A.PlayerRace == "NightElf" then 
                local ElunesGrace = GetToggle(2, "ElunesGrace")
                if ElunesGrace >= 0 and A.ElunesGrace:IsReady(player) and IsSchoolHolyUP() and 
                (
                    -- Auto 
                    (     
                        ElunesGrace >= 100 and 
                        (
                            (
                                not A.IsInPvP and                         
                                Unit(player):TimeToDieX(45) < 3 and 
                                -- If more than 50% of total damage is physical
                                Unit(player):GetDMG(3) > Unit(player):GetDMG() * 0.5
                            ) or 
                            (
                                A.IsInPvP and 
                                Unit(player, 5):HasFlags() and 
                                Unit(player):GetRealTimeDMG() > 0 and 
                                Unit(player):IsFocused() and
                                Unit(player):HasBuffs("DeffBuffs") == 0
                            )
                        ) 
                    ) or 
                    -- Custom
                    (    
                        ElunesGrace < 100 and 
                        Unit(player):HealthPercent() <= ElunesGrace
                    )
                ) 
                then 
                    if inShadowform then 
                        Player:CancelBuff(A.Shadowform:Info())
                    end 
                    
                    return A.ElunesGrace:Show(icon)
                end         
            end             
        end 
        
        -- RestorativePotion
        if potionToUse == "RestorativePotion" and inCombat and CanUseRestorativePotion(icon, "UseDispel") then 
            return true 
        end 
        
        -- Stoneform
        if not A.IsInPvP and inCombat and CanUseStoneformDispel(icon, "UseDispel") then 
            return true
        end     
        
        -- Levitate
        if A.Levitate:IsReady(player) and IsSchoolHolyUP() and (Player:IsFalling() or (not inCombat and Player:IsSwimming() and not Player:IsMounted())) and Unit(player):HasBuffs(A.Levitate.ID, true) == 0 then 
            return A.Levitate:Show(icon)
        end 
        
        -- PvE: Fade (agro dump)
        if inCombat and not A.IsInPvP and A.Zone ~= "none" and TeamCacheFriendly.Type and A.Fade:IsReady(player) and IsSchoolShadowUP() and (Unit(player):IsTankingAoE() or (inShadowform and combatTime < 5 and A.LastPlayerCastName == A.MindBlast:Info())) then 
            return A.Fade:Show(icon)
        end 
        
        -- PvE: Shadowmeld (agro dump)
        if inCombat and not A.IsInPvP and A.Zone ~= "none" and TeamCacheFriendly.Type and A.PlayerRace == "NightElf" and A.Shadowmeld:IsRacialReady(player) and Unit(player):IsTankingAoE() and Unit(player):HasBuffs(A.Fade.ID, true) == 0 then 
            return A.Shadowmeld:Show(icon)
        end 
        
        -- inAoE: Interrupts
        if inCombat and inAoE then 
            if A.PsychicScream:IsReadyToUse() and IsSchoolShadowUP() then 
                local isAble = false 
                for unit in pairs(ActiveUnitPlates) do 
                    if Unit(unit):GetRange() <= 8 and (select(2, InterruptIsValid(unit, "TargetMouseover"))) and Unit(unit):IsControlAble("fear") then                         
                        isAble = true 
                        
                        if not A.PsychicScream:AbsentImun(unit, Temp.AuraForFear) then 
                            isAble = false 
                            break 
                        end                                                  
                    end 
                end
                
                if isAble then 
                    return A.PsychicScream:Show(icon)
                end                  
            end         
        end     
        
        -- Out of combat: Self Buffer 
        if not inCombat and PlayerRebuff() then 
            return true 
        end 
        
        -- PvP: Try to find invisible 
        if A.IsInPvP and GetToggle(2, "TryToFindInvisible") then 
            if A.Zone == "pvp" then 
                if not inCombat then 
                    if not Temp.hasInvisibleUnits then 
                        Temp.hasInvisibleUnits, Temp.invisibleUnitID = EnemyTeam():HasInvisibleUnits()
                    end 
                    
                    -- Try to catch them by entering combat by someone around while we're not entered 
                    if Temp.hasInvisibleUnits and not Unit(Temp.invisibleUnitID):IsVisible() and (MultiUnits:GetByRangeInCombat(nil, 1) >= 1 or FriendlyTeam():PlayersInCombat(25, 5)) then 
                        -- Human 
                        if A.Perception:IsRacialReady(player) then 
                            return A.Perception:Show(icon)
                        end 
                        
                        -- Holy Nova (Rank 1)
                        if inAoE and not inShadowform and A.HolyNova1:IsReady(player) and IsSchoolHolyUP() and (A.PlayerRace ~= "Human" or Unit(player):HasBuffs(A.Perception.ID, true) == 0) and not Player:IsMounted() and not Unit("target"):IsExists() then 
                            return A.HolyNova1:Show(icon)
                        end 
                    end 
                else
                    -- Try to catch them by used stealth  
                    -- Human 
                    if A.Perception:IsRacialReady(player) and IsInvisAffected("arena") then 
                        return A.Perception:Show(icon)
                    end 
                end 
            elseif inCombat and (A.Zone == "none" or A:GetTimeDuel() > 3) and A.Perception:IsRacialReady(player) and IsInvisAffected("enemy") then  
                -- Try to catch wpvp and duel 
                return A.Perception:Show(icon) 
            end 
        end 
        
        -- Runes 
        if inCombat and CanUseManaRune(icon) then 
            return true 
        end 
        
        -- Mana Potion 
        if potionToUse == "MajorManaPotion" and inCombat and A.MajorManaPotion:IsReady(player) and Unit(player):PowerPercent() <= GetToggle(2, "ManaPotion") then 
            return A.MajorManaPotion:Show(icon)
        end         
    end 
    
    if IsUnitEnemy("mouseover") then 
        return Enemy("mouseover")
    elseif IsUnitFriendly("mouseover") then 
        return Friendly("mouseover")
    end 
    
    if IsUnitEnemy("target") then 
        return Enemy("target")
    elseif IsUnitFriendly("target") then
        return Friendly("target")
    end 
end 

local function RotationPassive(icon)
    if not GetToggle(2, "UseRotationPassive") then 
        return 
    end 
    
    local n = icon.ID and icon.ID - 6
    if n then  
        local eUnit, fUnit
        if TeamCacheEnemy.Type and A.Zone == "pvp" then 
            eUnit = TeamCacheEnemy.Type .. n
        end 
        
        if TeamCacheFriendly.Type then 
            fUnit = TeamCacheFriendly.Type .. n
        end 
        
        -- Purge 
        if eUnit and Unit(eUnit):IsExists() and not UnitIsUnit(eUnit, "target") and not Unit(eUnit):InLOS() and A.DispelMagic:IsReady(eUnit) and A.DispelMagic:AbsentImun(eUnit, Temp.TotalAndMagicAndCC) and IsSchoolHolyUP() and AuraIsValid(eUnit, "UsePurge", "PurgeHigh") then 
            return A.DispelMagic:Show(icon)
        end     
        
        -- Dispels 
        if fUnit and Unit(fUnit):IsExists() and not UnitIsUnit(fUnit, "target") and not Unit(fUnit):InLOS() then             
            if A.DispelMagic:IsReady(fUnit, nil, nil, true) and IsSchoolHolyUP() and (AuraIsValid(fUnit, "UseDispel", "Magic") or AuraIsValid(fUnit, "UsePurge", "PurgeFriendly")) then 
                return A.DispelMagic:Show(icon)
            end 
            
            if (not inShadowform or GetToggle(2, "CancelShadowForm")) and A.AbolishDisease:IsReady(fUnit, nil, nil, true) and IsSchoolHolyUP() and AuraIsValid(fUnit, "UseDispel", "Disease") and Unit(fUnit):HasBuffs(A.AbolishDisease.ID) == 0 then 
                if inShadowform then 
                    Player:CancelBuff(A.Shadowform:Info())
                end 
                
                return A.AbolishDisease:Show(icon)
            end 
            
            if (not inShadowform or GetToggle(2, "CancelShadowForm")) and A.CureDisease:IsReady(fUnit, nil, nil, true) and IsSchoolHolyUP() and AuraIsValid(fUnit, "UseDispel", "Disease") and Unit(fUnit):HasBuffs(A.AbolishDisease.ID) == 0 then 
                if inShadowform then 
                    Player:CancelBuff(A.Shadowform:Info())
                end             
                
                return A.CureDisease:Show(icon)
            end              
        end         
    end     
end 

A[6] = function(icon)
    -- StopCast if destination is known as unitID 
    if Temp.LastPrimaryUnitID and CanStopCastingOverHeal() then 
        return A:Show(icon, ACTION_CONST_STOPCAST)
    end
    
    if RotationPassive(icon) then 
        return true 
    end 
end 

A[7] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
end 

A[8] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
end 

-- Nil (nothing for profile here, just reset them)
A[4] = nil 
A[5] = nil 

