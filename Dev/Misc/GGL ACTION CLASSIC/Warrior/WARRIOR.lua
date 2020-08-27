local TMW                                     = TMW 
local Action                                = Action
local toNum                                 = Action.toNum

local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 

local wipe                                     = wipe 
local math_floor                            = math.floor
local math_ceil                                = math.ceil
local setmetatable, select, unpack, table, pairs    = 
setmetatable, select, unpack, table, pairs 
local tinsert                                = table.insert 


local CombatLogGetCurrentEventInfo            = CombatLogGetCurrentEventInfo

local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower =
UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

Action[Action.PlayerClass]                     = {
    -- Racials 
    Shadowmeld                                  = Action.Create({ Type = "Spell", ID = 20580    }),  
    Perception                                = Action.Create({ Type = "Spell", ID = 20600, FixedTexture = ACTION_CONST_HUMAN     }), 
    BloodFury                                 = Action.Create({ Type = "Spell", ID = 20572      }), 
    Berserking                                = Action.Create({ Type = "Spell", ID = 20554    }), 
    WarStomp                                  = Action.Create({ Type = "Spell", ID = 20549     }), 
    Stoneform                                  = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                          = Action.Create({ Type = "Spell", ID = 7744        }), 
    EscapeArtist                              = Action.Create({ Type = "Spell", ID = 20589    }), 
    -- Core API
    AntiFakeCC                                = Action.Create({ Type = "SpellSingleColor", ID = 5246,     Color = "GREEN",     Desc = "[1] CC",                 QueueForbidden = true, BlockForbidden = true         }), -- IntimidatingShout
    AntiFakeInterrupt1                        = Action.Create({ Type = "SpellSingleColor", ID = 6552,     Color = "GREEN",     Desc = "[2] Interrupt",         QueueForbidden = true                                }),    -- Pummel             (required stance)
    AntiFakeInterrupt2                        = Action.Create({ Type = "SpellSingleColor", ID = 72,                              Desc = "[2] Interrupt",         QueueForbidden = true                                }), -- ShieldBash        (required stance)
    -- Equipment
    SwapWeapon                                = Action.Create({ Type = "SwapEquip", ID = 132996, Desc = "SwapWeapon", Equip1 = function() return Player:HasShield() and not Player:HasShield(true) end, Equip2 = function() return Player:HasShield(true) and ((not Player:HasWeaponTwoHand(true) and Player:HasWeaponTwoHand()) or (not Player:HasWeaponOffHand(true) and Player:HasWeaponOffHand())) end    }),
    --TidalCharm                                = Action.Create({ Type = "Trinket", ID = 1404                                                                }),
    HeartofNoxxion                            = Action.Create({ Type = "Trinket", ID = 17744                                                                    }),
    MightyRagePotion                        = Action.Create({ Type = "Potion",  ID = 13442                                                                    }),
    -- Spell-equip
    ShootBow                                = Action.Create({ Type = "Spell", ID = 2480,     QueueForbidden = true, BlockForbidden = true                    }),
    ShootCrossbow                            = Action.Create({ Type = "Spell", ID = 7919,     QueueForbidden = true, BlockForbidden = true                    }),
    ShootGun                                = Action.Create({ Type = "Spell", ID = 7918,     QueueForbidden = true, BlockForbidden = true                    }),
    Throw                                    = Action.Create({ Type = "Spell", ID = 2764,     QueueForbidden = true, BlockForbidden = true                    }),
    -- Class spells 
    Whirlwind                                  = Action.Create({ Type = "Spell", ID = 1680                                                                     }),
    BattleStance                              = Action.Create({ Type = "Spell", ID = 2457,    isStance = 1                                                    }), 
    DefensiveStance                              = Action.Create({ Type = "Spell", ID = 71,         isStance = 2                                                    }), 
    BerserkerStance                              = Action.Create({ Type = "Spell", ID = 2458,    isStance = 3                                                    }),     
    DemoralizingShout                        = Action.Create({ Type = "Spell", ID = 1160,     useMaxRank = true                                                 }),
    SunderArmor                                  = Action.Create({ Type = "Spell", ID = 7386,     useMaxRank = true                                                 }),
    Overpower                                  = Action.Create({ Type = "Spell", ID = 7384,     useMaxRank = true                                                 }),
    Slam                                    = Action.Create({ Type = "Spell", ID = 1464,     useMaxRank = true                                                 }),
    Execute                                    = Action.Create({ Type = "Spell", ID = 5308,     useMaxRank = true                                                 }),
    Rend                                    = Action.Create({ Type = "Spell", ID = 772,     useMaxRank = true                                                 }),
    MortalStrike                            = Action.Create({ Type = "Spell", ID = 12294,     isTalent = true, useMaxRank = true                                 }),
    SweepingStrikes                            = Action.Create({ Type = "Spell", ID = 12292,    isTalent = true                                                   }),
    Bloodthirst                                = Action.Create({ Type = "Spell", ID = 23881,     isTalent = true, useMaxRank = true                                 }),
    Cleave                                    = Action.Create({ Type = "Spell", ID = 845,     useMaxRank = true                                                 }),
    ThunderClap                                = Action.Create({ Type = "Spell", ID = 6343,     useMaxRank = true                                                 }),
    Revenge                                    = Action.Create({ Type = "Spell", ID = 6572,     useMaxRank = true                                                 }),
    HeroicStrike                            = Action.Create({ Type = "Spell", ID = 78,         useMaxRank = true                                                 }),
    MockingBlow                                = Action.Create({ Type = "Spell", ID = 694,     useMaxRank = true                                                 }),
    ShieldSlam                                = Action.Create({ Type = "Spell", ID = 23922,     isTalent = true, useMaxRank = true                                 }), -- 50% chance to dispel magic 
    -- Burst     
    Recklessness                              = Action.Create({ Type = "Spell", ID = 1719                                                                     }),
    Bloodrage                                = Action.Create({ Type = "Spell", ID = 2687                                                                         }),
    DeathWish                                = Action.Create({ Type = "Spell", ID = 12328,    isTalent = true                                                  }), -- Also imunes for Fear effects
    -- Defense
    ShieldBlock                                  = Action.Create({ Type = "Spell", ID = 2565                                                                         }),
    ShieldWall                                = Action.Create({ Type = "Spell", ID = 871                                                                         }),
    Retaliation                                = Action.Create({ Type = "Spell", ID = 20230                                                                     }),
    LastStand                                = Action.Create({ Type = "Spell", ID = 12975,     isTalent = true                                                 }),
    -- Misc
    Taunt                                      = Action.Create({ Type = "Spell", ID = 355                                                                         }),
    TauntPets                                  = Action.Create({ Type = "Spell", ID = 355,        Desc = "PvP Taunt Pets"                                            }),
    ChallengingShout                        = Action.Create({ Type = "Spell", ID = 1161                                                                     }),
    -- Buffs 
    BattleShout                                = Action.Create({ Type = "Spell", ID = 6673,     useMaxRank = true                                                  }),    
    -- Trinket
    BerserkerRage                              = Action.Create({ Type = "Spell", ID = 18499                                                                     }),
    -- CrownControl
    Hamstring                                = Action.Create({ Type = "Spell", ID = 7373,     useMaxRank = true                                                 }),
    PiercingHowl                            = Action.Create({ Type = "Spell", ID = 12323,    isTalent = true, Desc = "PvP"                                    }),
    Charge                                    = Action.Create({ Type = "Spell", ID = 100,     useMaxRank = true                                                 }), -- Can't be used in combat
    Intercept                                = Action.Create({ Type = "Spell", ID = 20252,     useMaxRank = true                                                 }),
    IntimidatingShout                        = Action.Create({ Type = "Spell", ID = 5246                                                                        }),
    Pummel                                    = Action.Create({ Type = "Spell", ID = 6552,     useMaxRank = true                                                 }),
    ShieldBash                                = Action.Create({ Type = "Spell", ID = 72,         useMaxRank = true                                                 }),
    Disarm                                      = Action.Create({ Type = "Spell", ID = 676                                                                         }),    -- Tech limitions to block 
    ConcussionBlow                            = Action.Create({ Type = "Spell", ID = 12809,     isTalent = true                                                 }),    
    -- Hidden
    TacticalMastery                            = Action.Create({ Type = "Spell", ID = 12295,     isTalent = true, Hidden = true                                     }),    
    ImprovedBerserkerRage                    = Action.Create({ Type = "Spell", ID = 12295,     isTalent = true, useMaxRank = true, Hidden = true                 }),    
    Flurry                                    = Action.Create({ Type = "Spell", ID = 12319,     isTalent = true, useMaxRank = true, Hidden = true                 }),    
    BlessingofProtection                    = Action.Create({ Type = "Spell", ID = 1022,     Color = "BLUE",  Hidden = true                                     }),    
    PowerWordShield                            = Action.Create({ Type = "Spell", ID = 17,         Hidden = true                                                     }),    
    WindfuryTotem                            = Action.Create({ Type = "Spell", ID = 8512,     Hidden = true                                                     }),    
}

Player:RegisterShield()
Player:RegisterWeaponTwoHand()
Player:RegisterWeaponOffHand()
Action.Data.QueueAutoResetTimer                = 3
local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })

-------------------------------------------
-- [[ DODGE LOG ]] 
-------------------------------------------
local dodgedGUID = {}
local revengeGUID = {}

local function RESET_GUID(DestGUID)    
    if DestGUID then 
        dodgedGUID[DestGUID] = nil 
        revengeGUID[DestGUID] = nil 
    else 
        wipe(dodgedGUID)
        wipe(revengeGUID)
    end 
end 

local function COMBAT_LOG_EVENT_UNFILTERED(...)
    local _, EVENT, _, SourceGUID, _, _, _, DestGUID, _, _, _, _, spellName, _, missType = CombatLogGetCurrentEventInfo()
    
    -- Log Save
    if (EVENT == "SWING_MISSED" or EVENT == "SPELL_MISSED" or EVENT == "DAMAGE_SHIELD_MISSED" or EVENT == "RANGE_MISSED") then 
        local pGuid = UnitGUID("player") 
        if missType == "DODGE" and DestGUID and SourceGUID and SourceGUID == pGuid then 
            dodgedGUID[DestGUID] = TMW.time + 5
        end 
        
        if (missType == "DODGE" or missType == "BLOCK" or missType == "PARRY") and (pGuid == DestGUID or pGuid == SourceGUID) then 
            revengeGUID[pGuid] = TMW.time + 5            
        end 
    end 
    
    -- Log Remove (do we need DURABILITY damage?)
    if (EVENT == "SPELL_DAMAGE" or EVENT == "SPELL_CAST_SUCCESS" or EVENT == "DAMAGE_SPLIT") and DestGUID and SourceGUID == UnitGUID("player") and (spellName == A.Overpower:Info() or spellName == A.Revenge:Info()) then 
        RESET_GUID(DestGUID)
    end 
    
    -- Wipe     
    if EVENT == "UNIT_DIED" or EVENT == "UNIT_DESTROYED" or EVENT == "UNIT_DISSIPATES" then 
        RESET_GUID(DestGUID)
    end 
end 

A.Listener:Add("ACTION_EVENT_WARRIOR", "PLAYER_REGEN_ENABLED",             RESET_GUID) 
A.Listener:Add("ACTION_EVENT_WARRIOR", "COMBAT_LOG_EVENT_UNFILTERED",    COMBAT_LOG_EVENT_UNFILTERED) 

-------------------------------------------
-- [[ CONDITIONS ]] 
-------------------------------------------
local function IsQueuedAutoAnyPassiveSlot()
    -- @return boolean 
    local index = #Action.Data.Q
    if index > 0 then 
        for i = 1, index do 
            if Action.Data.Q[i] and Action.Data.Q[i].Auto and Action.Data.Q[i].MetaSlot and Action.Data.Q[i].MetaSlot >= 6 then 
                return true 
            end 
        end 
    end 
end 

local function IsQueuedAutoMainSlot()
    local index = #Action.Data.Q
    if index > 0 then 
        for i = 1, index do 
            if Action.Data.Q[i] and Action.Data.Q[i].Auto and not Action.Data.Q[i].MetaSlot then 
                return true 
            end 
        end 
    end 
end 

local function IsLockedRotation()
    -- @return boolean 
    return     IsQueuedAutoMainSlot() or 
    (
        IsQueuedAutoAnyPassiveSlot() and 
        (
            TellMeWhen_Group1_Icon6.attributes.realAlpha ~= 0 or -- Passive1
            TellMeWhen_Group1_Icon7.attributes.realAlpha ~= 0 or -- Passive2
            TellMeWhen_Group1_Icon8.attributes.realAlpha ~= 0      -- Passive3
        )
    )
end 

local Temp                                     = {
    AttackTypes                             = {"TotalImun", "DamagePhysImun"},
    AuraForInterrupt                         = {"TotalImun", "DamagePhysImun", "KickImun"},
    AuraForFear                                = {"TotalImun", "DamagePhysImun", "FearImun"},
    AuraForStun                                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    AuraForSlow                                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "Freedom"},
    BerserkerRageLoC                        = {"FEAR", "INCAPACITATE"},
    SortStance                                 = {},
    BigDeff                                    = {A.Retaliation.ID, A.ShieldWall.ID},
    AuraTaunt                                = {A.Taunt.ID, A.MockingBlow.ID, A.ChallengingShout.ID},
}

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

local function IsInvisAffected()
    -- @return boolean
    for i = 1, #Temp.InvisAuras do 
        if UnitCooldown:GetCooldown("arena", Temp.InvisAuras[i]) > 0 then 
            return true 
        end 
    end 
end 

A.Listener:Add("ACTION_EVENT_WARRIOR_INVISIBLE", "PLAYER_REGEN_ENABLED", function()     
        if A.Zone ~= "pvp" then 
            Temp.hasInvisibleUnits, Temp.invisibleUnitID = nil, nil 
        end 
end) 

local MetaQueue                             = {
    [3]                                        = {
        player                                = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1},
        mouseover                             = {UnitID = "mouseover",     Silence = true, Auto = true, Value = true, Priority = 1},
        target                                 = {UnitID = "target",         Silence = true, Auto = true, Value = true, Priority = 1},
    },
    [6]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 6},
        target                                 = {UnitID = "arena1",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 6},
    },
    [7]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 7},
        target                                 = {UnitID = "arena2",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 7},
    },
    [8]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 8},
        target                                 = {UnitID = "arena3",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 8},
    },
    Cancel                                     = {Silence = true},
}

local function InMelee(unitID)
    -- @return boolean 
    return A.Rend:IsInRange(unitID) or (A.Rend:IsBlockedBySpellBook() and Player:GetSwing(4) > 0)
end 

local function IsBossFight()
    -- @return boolean 
    for i = 1, MAX_BOSS_FRAMES do 
        if Unit("boss" .. i):IsExists() then 
            return true 
        end 
    end 
end 

local function IsCastingShoot(unitID)
    -- @return boolean 
    local AutoShoot = A.DetermineUsableObject(unitID, nil, nil, true, nil, A.ShootBow, A.ShootCrossbow, A.ShootGun, A.Throw) 
    return AutoShoot and AutoShoot:IsSpellCurrent()
end 

local function IsOverPowerUP(unitID)
    -- @return boolean 
    local GUID = UnitGUID(unitID) 
    return GUID and dodgedGUID[GUID] and TMW.time < dodgedGUID[GUID]
end 

local function IsRevengeUP(unitID)
    -- @return boolean 
    local GUID = UnitGUID(unitID) 
    return GUID and revengeGUID[GUID] and TMW.time < revengeGUID[GUID]
end 

local function IsShieldUP()
    -- @return boolean 
    return Player:HasShield(true) or Player:IsSwapLocked()
end 

local function CanSwapToShields()
    -- @return boolean 
    return not A.SwapWeapon:IsBlocked() and not Player:IsSwapLocked() and A.SwapWeapon.Equip1()
end 

local function CanSwapFromShields()
    -- @return boolean 
    return not A.SwapWeapon:IsBlocked() and not Player:IsSwapLocked() and A.SwapWeapon.Equip2()
end 

local function GetStance()
    -- @return number (1 - BattleStance, 2 - DefensiveStance, 3 - BerserkerStance)
    return Player:GetStance()
end 

local function GetStanceByRole(damagerFixed)
    -- @return number (1 - BattleStance, 2 - DefensiveStance, 3 - BerserkerStance)
    -- Optional: damagerFixed
    if A.Role == "TANK" then 
        return (A.DefensiveStance:IsBlockedBySpellBook() and 1) or 2
    else 
        return (A.BerserkerStance:IsBlockedBySpellBook() and 1) or damagerFixed or 3
    end 
end 

local function InRoleStance(inStance, damagerFixed)
    -- @return boolean 
    -- Optional: damagerFixed
    if A.Role == "TANK" then 
        return (A.DefensiveStance:IsBlockedBySpellBook() and inStance == 1) or inStance == 2
    else 
        return (A.BerserkerStance:IsBlockedBySpellBook() and inStance == 1) or (not damagerFixed and (inStance == 1 or inStance == 3)) or (damagerFixed and inStance == damagerFixed)
    end 
end 

local function IsCurrentAttack()
    -- @return boolean 
    -- true if HeroicStrike or Cleave placed in use queue by next swing attack 
    return A.HeroicStrike:IsSpellCurrent() or A.Cleave:IsSpellCurrent()
end 

local function CanCastIfExecuteOff(targetHealthPercent, myRage)
    -- @return boolean 
    return targetHealthPercent > 20 or A.Execute:IsBlockedBySpellBook() or A.Execute:IsBlocked() or (GetStance() ~= 2 and myRage < A.Execute:GetSpellPowerCostCache()) or not A.Execute:IsInRange("target")
end

local function GetByRange(count, range)
    -- @return boolean 
    local nameplates = MultiUnits:GetActiveUnitPlates()
    if nameplates then 
        local c = 0 
        for unitID in pairs(nameplates) do 
            if ((not A.Hamstring:IsBlockedBySpellBook() and A.Hamstring:IsInRange(unitID)) or (not A.Rend:IsBlockedBySpellBook() and A.Rend:IsInRange(unitID))) then 
                c = c + 1
            else
                local r = Unit(unitID):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end 
        end 
    end    
end 

local function UnitsMissingByDeBuff(ID, isSource, count, range)
    -- @return boolean 
    local nameplates = MultiUnits:GetActiveUnitPlates()
    if nameplates then 
        local c = 0 
        for unitID in pairs(nameplates) do             
            if ((not A.Hamstring:IsBlockedBySpellBook() and A.Hamstring:IsInRange(unitID)) or (not A.Rend:IsBlockedBySpellBook() and A.Rend:IsInRange(unitID))) then 
                if Unit(unitID):HasDeBuffs(ID, isSource) <= A.GetGCD() then 
                    c = c + 1
                end 
            else
                local r = Unit(unitID):GetRange()
                if r > 0 and r <= range and Unit(unitID):HasDeBuffs(ID, isSource) <= A.GetGCD() then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end             
        end 
    end 
end 

local function CanTargetNearest(inCombat)
    -- @return boolean 
    return inCombat and A.GetToggle(1, "AutoTarget") and GetByRange(2, 8) 
end 

local function CanCastDefeanseStancePvP(unitID, inCombat, inMelee, inStance)
    -- @return boolean 
    return A.IsInPvP and inCombat and not inMelee and inStance ~= 2 and A.GetToggle(2, "PvP-DefensiveStance") and A.DefensiveStance:IsReady("player") and A.DefensiveStance:PowerLimitOK() and (not unitID or not A.Intercept:IsReadyByPassCastGCD(unitID, nil, nil, true)) and not CanTargetNearest(inCombat)
end 

local function CalculateRage(...)
    -- @return number (required rage to use all these)
    local total = 0
    for i = 1, select("#", ...) do 
        local object = select(i, ...)
        if object:IsReadyToUse(nil, true, true) then 
            total = total + object:GetSpellPowerCostCache()
        end 
    end 
    return total
end 

function Action:PowerLimitOK(meta)
    -- @return boolean 
    local PowerLimit 
    if not self.isStance or (meta and meta == 2) then 
        return true 
    elseif self.isStance == 1 then 
        PowerLimit = A.GetToggle(2, "BattleStancePowerLimit")
    elseif self.isStance == 2 then 
        PowerLimit = A.GetToggle(2, "DefensiveStancePowerLimit")
    elseif self.isStance == 3 then 
        PowerLimit = A.GetToggle(2, "BerserkerStancePowerLimit")
    end 
    
    return (PowerLimit <= 0 and true) or Unit("player"):Power() <= PowerLimit
end 

function Action:CanCastBurst(...) 
    -- @return boolean 
    local targetHealthPercent, timing20, ttdto20, isboss, timetouseall = ...
    return not timing20 or A.IsInPvP or (not isboss and not IsBossFight()) or (isboss and (targetHealthPercent <= 20 or (ttdto20 <= timetouseall and targetHealthPercent <= 25 and ttdto20 ~= 500) or (self.Type == "Spell" and ttdto20 > self:GetSpellBaseCooldown() and ttdto20 ~= 500) or (self.Type ~= "Spell" and ttdto20 > 180 and ttdto20 ~= 500)))
end

-------------------------------------------
-- [[ QUEUE GENERATOR ]] 
-------------------------------------------
local function GenerateShieldBash(meta, obj, arg, skipObj, unitID)
    -- Usage: @number meta, @table obj, @number castLeft or @string unitID, @boolean skipObj will not queue itself interrupt if true 
    -- Sorts queue priority for specified meta to build enough rage for successfully interrupt 
    if not A.IsQueueRunningAuto() then         
        local inStance        = GetStance()        
        local useShield     = A.SwapWeapon.Equip1() and A.GetToggle(2, "UseShield-ShieldBash")                             -- not static
        local useStance     = A.GetToggle(2, "UseStance-ShieldBash")                                                     -- not static
        local useBloodrage     = A.GetToggle(2, "UseBloodrage-ShieldBash")                                                 -- not static
        
        -- Do nothing if toggles disabled for equip / stance or shield is not equiped and not existed at all             
        if (not IsShieldUP() and not useShield) or (inStance == 3 and not useStance) then 
            return false 
        end 
        
        local myRage        = Unit("player"):Power()        
        local needRage      = obj:GetSpellPowerCostCache()                                                                      
        local castLeft      = arg or Unit(arg):IsCastingRemains()
        local StancePrimary = GetStanceByRole(1) 
        local StancesReady     = useStance and ((A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta)) or ((A.BattleStance:IsReadyP("player") and A.BattleStance:PowerLimitOK(meta))))            
        
        -- Do nothing if we can't swap to shield by timing or use any stance by extra conditions
        if (not IsShieldUP() and castLeft < 0.6) or (inStance == 3 and not StancesReady) then 
            return false
        end 
        
        -- Do nothing if not enough rage generate
        local canBloodrage = useBloodrage > 0 and A.Bloodrage:IsReadyP("player") and Unit("player"):HealthPercent() >= useBloodrage
        if ((myRage < needRage and inStance ~= 3) or (inStance == 3 and (myRage < needRage or A.TacticalMastery:GetTalentRank() * 5 < needRage))) and not canBloodrage then 
            return false 
        end 
        
        -- General 
        if not skipObj then 
            local target = unitID == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
            obj:SetQueue(target)                                     -- #4
        end 
        
        -- Bloodrage 
        if ((myRage < needRage and inStance ~= 3) or (inStance == 3 and (myRage < needRage or A.TacticalMastery:GetTalentRank() * 5 < needRage))) and canBloodrage then 
            A.Bloodrage:SetQueue(MetaQueue[meta].player)             -- #3
        end 
        
        if inStance == 3 then 
            if StancePrimary == 2 and inStance ~= 2 and A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta) then 
                A.DefensiveStance:SetQueue(MetaQueue[meta].player)  -- #2
            elseif inStance ~= 1 and A.BattleStance:IsReadyP("player") and A.BattleStance:PowerLimitOK(meta) then 
                A.BattleStance:SetQueue(MetaQueue[meta].player)     -- #2
            elseif inStance ~= 2 and A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta) then 
                A.DefensiveStance:SetQueue(MetaQueue[meta].player)  -- #2
            end     
        end 
        
        if not IsShieldUP() then 
            A.SwapWeapon:SetQueue(MetaQueue[meta].player)             -- #1
        end 
        
        return true 
    end 
end 

local function GeneratePummel(meta, obj, arg, skipObj, unitID)
    -- Usage: @number meta, @table obj, @number castLeft or @string unitID, @boolean skipObj will not queue itself interrupt if true  
    -- Sorts queue priority for specified meta to build enough rage for successfully interrupt 
    if not A.IsQueueRunningAuto() then         
        local inStance            = GetStance()                
        local useStance         = A.GetToggle(2, "UseStance-Pummel")                                                     -- not static
        local useBerserkerRage     = A.GetToggle(2, "UseBerserkerRage-Pummel")                                             -- not static
        local useBloodrage         = A.GetToggle(2, "UseBloodrage-Pummel")                                                 -- not static
        local StancesReady         = useStance and A.BerserkerStance:IsReadyP("player") and A.BerserkerStance:PowerLimitOK(meta)
        
        -- Do nothing if toggles disabled for stance                                                                 
        if inStance ~= 3 and not StancesReady then 
            return false 
        end 
        
        local myRage            = Unit("player"):Power()        
        local needRage          = obj:GetSpellPowerCostCache()                                                                      
        local castLeft          = arg or Unit(arg):IsCastingRemains()    
        
        -- Do nothing if not enough rage generate
        local rageAfterSwap        = (myRage >= A.TacticalMastery:GetTalentRank() * 5 and A.TacticalMastery:GetTalentRank() * 5) or myRage
        local canBloodrage         = useBloodrage > 0 and A.Bloodrage:IsReadyP("player") and Unit("player"):HealthPercent() >= useBloodrage
        local canBerserkerRage  = useBerserkerRage and A.BerserkerRage:IsReadyP("player") and A.ImprovedBerserkerRage:GetTalentRank() * 5 + (inStance == 3 and myRage or rageAfterSwap) >= needRage
        if ((myRage < needRage and inStance == 3) or (inStance ~= 3 and (myRage < needRage or A.TacticalMastery:GetTalentRank() * 5 < needRage))) and not canBloodrage and not canBerserkerRage then 
            return false 
        end 
        
        -- General             
        if not skipObj then 
            local target = unitID == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
            obj:SetQueue(target)                                     -- # 3
        end 
        
        if (myRage < needRage and inStance == 3) or (inStance ~= 3 and (myRage < needRage or A.TacticalMastery:GetTalentRank() * 5 < needRage)) then 
            if canBloodrage then 
                A.BerserkerRage:SetQueue(MetaQueue[meta].player)     -- # 2
            elseif canBerserkerRage then 
                A.Bloodrage:SetQueue(MetaQueue[meta].player)         -- # 2
            end 
        end 
        
        if inStance ~= 3 then 
            A.BerserkerStance:SetQueue(MetaQueue[meta].player)         -- # 1
        end     
        
        return true
    end 
end 

local function GenerateDisarm(meta, obj, skipObj, unitID)
    -- Usage: @number meta, @table obj, @boolean skipObj will not queue itself disarm if true  
    -- Sorts queue priority for specified meta to build enough rage for successfully interrupt 
    if not A.IsQueueRunningAuto() then         
        local inStance            = GetStance()                
        local useStance         = A.GetToggle(2, "UseStance-Disarm")                                                     -- not static
        local useBerserkerRage     = A.GetToggle(2, "UseBerserkerRage-Disarm")                                             -- not static
        local useBloodrage         = A.GetToggle(2, "UseBloodrage-Disarm")                                                 -- not static
        local StancesReady         = useStance and A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta)
        
        -- Do nothing if toggles disabled for stance 
        if inStance ~= 2 and not StancesReady then 
            return false 
        end 
        
        local myRage            = Unit("player"):Power()        
        local needRage          = obj:GetSpellPowerCostCache()      
        
        -- Do nothing if not enough rage generate
        local rageAfterSwap        = (myRage >= A.TacticalMastery:GetTalentRank() * 5 and A.TacticalMastery:GetTalentRank() * 5) or myRage
        local canBloodrage         = useBloodrage > 0 and A.Bloodrage:IsReadyP("player") and Unit("player"):HealthPercent() >= useBloodrage
        local canBerserkerRage  = useBerserkerRage and A.BerserkerRage:IsReadyP("player") and A.ImprovedBerserkerRage:GetTalentRank() * 5 + (inStance == 3 and myRage or rageAfterSwap) >= needRage
        if ((myRage < needRage and inStance == 2) or (inStance ~= 2 and (myRage < needRage or A.TacticalMastery:GetTalentRank() * 5 < needRage))) and not canBloodrage and not canBerserkerRage then 
            return false 
        end 
        
        -- General             
        if not skipObj then 
            local target = unitID == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
            obj:SetQueue(target)                                     -- # 3
        end 
        
        if (myRage < needRage and inStance == 2) or (inStance ~= 2 and (myRage < needRage or A.TacticalMastery:GetTalentRank() * 5 < needRage)) then 
            if canBloodrage then 
                A.BerserkerRage:SetQueue(MetaQueue[meta].player)     -- # 2
            elseif canBerserkerRage then 
                A.Bloodrage:SetQueue(MetaQueue[meta].player)         -- # 2
            end 
        end 
        
        if inStance ~= 2 then 
            A.DefensiveStance:SetQueue(MetaQueue[meta].player)         -- # 1
        end     
        
        return true
    end 
end 

local function GenerateObjects(meta, target, ...)
    local n = select("#", ...)
    local first     
    for i = 1, n do 
        local object = select(i, ...)
        if i == n then 
            first = object
        end 
        
        if object.isStance then 
            object:SetQueue(MetaQueue[meta].player)
        else 
            object:SetQueue(MetaQueue[meta][target])
        end 
    end 
    return first:Show(icon) 
end 

-- [Disarm] 
function Action.Warrior_DisarmIsReady(unitID, isMsg)
    -- @return string or nil  
    local unitID            = unitID or "target"
    local Disarm_Trigger     = (isMsg and "ON COOLDOWN") or A.GetToggle(2, "Trigger-Disarm")
    
    -- Do nothing 
    if Disarm_Trigger == "OFF" or not A.IsInPvP or not Unit(unitID):IsControlAble("disarm") or not Unit(unitID):IsPlayer() then -- Unit(unitID):InLOS()
        return 
    end 
    
    if Disarm_Trigger == "ON BURST" then 
        -- Do nothing 
        if Unit(unitID):HasBuffs("DamageBuffs") == 0 or not Unit(unitID):IsDamager() then 
            return 
        end 
        
        -- Do nothing 
        local unitID_Class = Unit(unitID):Class()
        if unitID_Class == "MAGE" or unitID_Class == "PRIEST" or (unitID_Class == "SHAMAN" and not Unit(unitID):IsMelee()) or unitID_Class == "WARLOCK" or unitID_Class == "DRUID" then 
            return 
        end 
    end 
    
    local Disarm_Units        = A.GetToggle(2, "Units-Disarm")
    local index             = toNum[unitID:gsub("%D", "") or 4]
    
    -- Passive @arena1-3 
    if index < 4 and A.Zone == "pvp" and Disarm_Units[index] and A.Disarm:IsReadyM(unitID, nil, true) then  
        return true 
    end 
    
    -- Rotation @target @mouseover 
    if index == 4 and Disarm_Units[4] and ((isMsg and A.Disarm:IsReadyM(unitID, nil, true)) or (not isMsg and A.Disarm:IsReady(unitID, nil, nil, nil, true))) then
        return true         
    end 
end 

-- [PrimaryStance]
local function UsePrimaryStance(icon, inStance, damagerFixed)
    -- @return boolean, true if can 
    local primary = GetStanceByRole(damagerFixed)
    if inStance ~= primary then 
        if primary == 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() then 
            return A.BattleStance:Show(icon)
        end 
        
        if primary == 2 and A.DefensiveStance:IsReady("player") and A.DefensiveStance:PowerLimitOK() then 
            return A.DefensiveStance:Show(icon)
        end 
        
        if primary == 3 and A.BerserkerStance:IsReady("player") and A.BerserkerStance:PowerLimitOK() then 
            return A.BerserkerStance:Show(icon)
        end 
    end 
end 

local function UseFirstAvailableStance(icon, inStance, ...)
    -- @return boolean, true if can 
    for i = 1, select("#", ...) do 
        local object = select(i, ...)
        if object:IsReady("player") and object:PowerLimitOK() and object.isStance ~= inStance then 
            return object:Show(icon)
        end 
    end 
end 

local function SortByRoleStance(...)
    -- @return objects sorted by current role 
    wipe(Temp.SortStance)
    for i = 1, select("#", ...) do
        local object = select(i, ...)
        if object.isStance == GetStanceByRole() then 
            tinsert(Temp.SortStance, 1, object)
        else 
            tinsert(Temp.SortStance, object)
        end 
    end 
    
    return unpack(Temp.SortStance)
end 

--[[ Note
A:IsReady(unitID, skipRange, skipLua, skipShouldStop, skipUsable)
A:IsReadyP(unitID, skipRange, skipLua, skipShouldStop, skipUsable)
A:IsReadyM(unitID, skipRange, skipUsable)
A:IsReadyByPassCastGCD(unitID, skipRange, skipLua, skipUsable)
A:IsReadyByPassCastGCDP(unitID, skipRange, skipLua, skipUsable)
A:IsReadyToUse(unitID, skipShouldStop, skipUsable)
]]
-- [1] CC AntiFake Rotation
A[1] = function(icon)    
    local unitID
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unitID = "target"
    end 
    
    if unitID and A.AntiFakeCC:IsReadyByPassCastGCD(unitID) and A.AntiFakeCC:AbsentImun(unitID, Temp.AuraForFear) and Unit(unitID):IsControlAble("fear") then 
        return A.AntiFakeCC:Show(icon)                    
    end 
end 

-- [2] Kick AntiFake Rotation
A[2] = function(icon)    
    -- Note: This will ignore power limit!
    local unitID
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unitID = "target"
    end 
    
    if unitID then         
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > 0 and not notKickAble and A.AbsentImun(nil, unitID, Temp.AuraForInterrupt) then 
            local meta                     = 2
            local inStance                = GetStance()                    
            
            local useStancePummel         = A.GetToggle(2, "UseStance-Pummel")                                                         -- not static
            local useBerserkerRage        = A.GetToggle(2, "UseBerserkerRage-Pummel")                                                 -- not static
            local useBloodragePummel    = A.GetToggle(2, "UseBloodrage-Pummel")                                                     -- not static
            
            local useShield             = A.SwapWeapon.Equip1() and A.GetToggle(2, "UseShield-ShieldBash")                             -- not static
            local useStance             = A.GetToggle(2, "UseStance-ShieldBash")                                                     -- not static
            local useBloodrage             = A.GetToggle(2, "UseBloodrage-ShieldBash")                                                 -- not static
            local myRage                = Unit("player"):Power()                
            local StancePrimary         = GetStanceByRole(1) 
            local StancesReady             = useStance and ((A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta)) or ((A.BattleStance:IsReadyP("player") and A.BattleStance:PowerLimitOK(meta))))    
            
            -- ShieldBash 
            if A.AntiFakeInterrupt2:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsShieldUP() then 
                if StancesReady and inStance == 3 then 
                    if StancePrimary == 2 and inStance ~= 2 and A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta) then 
                        return A.DefensiveStance:Show(icon) 
                    end 
                    
                    if inStance ~= 1 and A.BattleStance:IsReadyP("player") and A.BattleStance:PowerLimitOK(meta) then 
                        return A.BattleStance:Show(icon)
                    end                     
                    
                    if inStance ~= 2 and A.DefensiveStance:IsReadyP("player") and A.DefensiveStance:PowerLimitOK(meta) then 
                        return A.DefensiveStance:Show(icon)
                    end 
                end     
                
                if inStance ~= 3 then 
                    -- Bloodrage 
                    if useBloodrage > 0 and myRage < A.AntiFakeInterrupt2:GetSpellPowerCostCache() and A.Bloodrage:IsReadyP("player") and Unit("player"):HealthPercent() >= useBloodrage then 
                        return A.Bloodrage:Show(icon)
                    end 
                    
                    return A.AntiFakeInterrupt2:Show(icon)                
                end 
            end 
            
            -- Pummel 
            if A.AntiFakeInterrupt1:IsReadyByPassCastGCD(unitID, nil, nil, true) then      
                if inStance ~= 3 and A.BerserkerStance:IsReadyP("player") and A.BerserkerStance:PowerLimitOK(meta) and useStancePummel then 
                    return A.BerserkerStance:Show(icon)
                end         
                
                if inStance == 3 then 
                    if myRage < A.AntiFakeInterrupt1:GetSpellPowerCostCache() then 
                        -- BerserkerRage
                        if useBerserkerRage and A.BerserkerRage:IsReadyP("player") and A.ImprovedBerserkerRage:GetTalentRank() * 5 + Unit("player"):Power() >= A.AntiFakeInterrupt1:GetSpellPowerCostCache() then 
                            return A.BerserkerRage:Show(icon)
                        end 
                        
                        -- Bloodrage
                        if useBloodragePummel > 0 and A.Bloodrage:IsReadyP("player") and Unit("player"):HealthPercent() >= useBloodragePummel then 
                            return A.Bloodrage:Show(icon)
                        end                 
                    end 
                    
                    return A.AntiFakeInterrupt1:Show(icon)    
                end
            end 
            
            -- ShieldBash - Equip Shield 
            if A.AntiFakeInterrupt2:IsReadyByPassCastGCD(unitID, nil, nil, true) and (inStance ~= 3 or StancesReady) and not IsShieldUP() and useShield then 
                return A.SwapWeapon:Show(icon)            
            end                     
        end         
    end                                                                                 
end

-- [3] Rotation 
A[3] = function(icon)
    -- Return
    if IsLockedRotation() then 
        return 
    end     
    
    local meta                                                     = 3
    local combatTime                                            = Unit("player"):CombatTime()
    local inCombat                                                 = combatTime > 0
    local inStance                                                = GetStance()
    local inAoE                                                    = A.GetToggle(2, "AoE")
    local myRage                                                    = Unit("player"):Power()
    local targetHealthPercent                                     = Unit("target"):HealthPercent()
    local targetExists                                            = Unit("target"):IsExists() and Unit("target"):IsEnemy()
    local targetThreatSituation, targetThreatPercent            = Unit("player"):ThreatSituation()
    local bloodrageAtCombatTime                                 = A.GetToggle(2, "Bloodrage-AtCombatTime")
    local bloodrageOnlyDamager                                     = A.GetToggle(2, "Bloodrage-OnlyDamager")
    local bloodrageHP                                            = A.GetToggle(2, "Bloodrage-LimitHP")
    local hamstringPWR                                            = A.GetToggle(2, "Hamstring-PWR")
    local heroicStrikePWR                                        = A.GetToggle(2, "HeroicStrike-PWR")
    local cleavePWR                                                = A.GetToggle(2, "Cleave-PWR")
    local overpowerPWRbelow                                        = A.GetToggle(2, "Overpower-PWR-Below")
    local threatDamagerLimit                                    = (A.Role == "DAMAGER" and A.GetToggle(2, "ThreatDamagerLimit")) or -1
    local isSafestThreatRotation                                = not A.IsInPvP and A.Zone ~= "none" and A.TeamCache.Friendly.Size > 1 and threatDamagerLimit ~= -1 and targetThreatPercent >= threatDamagerLimit
    local rageSaved
    local inMelee        
    local unitID
    
    if A.Role == "DAMAGER" then 
        rageSaved                                                = myRage >= 45 or ((A.Whirlwind:GetCooldown() > 2 or A.Whirlwind:IsBlockedBySpellBook()) and (A.Bloodthirst:GetCooldown() > 2 or A.MortalStrike:GetCooldown() > 2 or (A.Bloodthirst:IsBlockedBySpellBook() and A.MortalStrike:IsBlockedBySpellBook())))
    elseif A.Role == "TANK" then 
        rageSaved                                                = myRage >= 45 or (A.Bloodthirst:GetCooldown() > 2 or A.ShieldSlam:GetCooldown() > 2 or (A.Bloodthirst:IsBlockedBySpellBook() and A.ShieldSlam:IsBlockedBySpellBook()))
    end 
    
    if A.IsUnitEnemy("target") then
        unitID             = "target" 
        inMelee            = InMelee(unitID)
    elseif A.IsUnitEnemy("mouseover") then 
        unitID             = "mouseover"
        inMelee            = InMelee(unitID)    
    end 
    
    -- ShieldSlam (Purge Friendly)
    if not targetExists and Unit("target"):IsPlayer() and A.ShieldSlam:IsReady("target", nil, nil, nil, true) and A.AuraIsValid("target", "UsePurge", "PurgeFriendly") and (Unit("target"):InParty() or Unit("target"):InRaid()) then
        if CanSwapToShields() and myRage >= A.ShieldSlam:GetSpellPowerCostCache() then 
            return A.SwapWeapon:Show(icon)
        end 
        
        if IsShieldUP() and myRage >= A.ShieldSlam:GetSpellPowerCostCache() then 
            return A.ShieldSlam:Show(icon)
        end 
    end 
    
    -- Return (if casting shooting)
    if IsCastingShoot(unitID) then 
        return 
    end 
    
    -- Power Word: Shield (combat, cancel buff)
    if inCombat and A.GetToggle(2, "CancelauraPOWS") and Unit("player"):HasBuffs(A.PowerWordShield.ID) > 0 and Unit("player"):Power() < 30 then 
        Player:CancelBuff(A.PowerWordShield:Info())
    end 
    
    -- BerserkerRage (while CC)
    if inStance == 3 and LoC:IsValid(Temp.BerserkerRageLoC) and A.GetToggle(2, "UseBerserkerRage-LoC") and A.BerserkerRage:IsReadyP("player") then 
        return A.BerserkerRage:Show(icon)
    end
    
    -- Racial (while CC)
    if A.GetToggle(2, "UseRacial-LoC") then 
        if A.Stoneform:AutoRacial() then 
            return A.Stoneform:Show(icon)
        end 
        
        if A.WilloftheForsaken:AutoRacial() then 
            return A.WilloftheForsaken:Show(icon)
        end 
        
        if not inMelee and A.EscapeArtist:AutoRacial() then 
            return A.EscapeArtist:Show(icon)
        end 
    end 
    
    -- DeathWish (while CC)
    if LoC:IsValid("FEAR") and A.GetToggle(2, "UseDeathWish-LoC") and A.DeathWish:IsReadyP("player") then 
        return A.DeathWish:Show(icon)
    end     
    
    -- BlessingofProtection (combat, cancel buff)
    if inCombat and A.GetToggle(2, "CancelauraBOP") and Unit("player"):HasBuffs(A.BlessingofProtection.ID) > 0 and Unit("player"):HealthPercent() > 50 then 
        Player:CancelBuff(A.BlessingofProtection:Info())
        return A.BlessingofProtection:Show(icon)
    end 
    
    -- [[ SELF DEFENSE ]] 
    if inCombat then 
        -- ShieldWall
        if A.ShieldWall:IsReadyByPassCastGCD("player", nil, nil, true) and (inStance == 2 or (A.DefensiveStance:IsReady("player") and A.DefensiveStance:PowerLimitOK())) and (IsShieldUP() or CanSwapToShields()) then 
            local SW_HP                    = A.GetToggle(2, "ShieldWallHP")
            local SW_TTD                = A.GetToggle(2, "ShieldWallTTD")
            
            if  (    
                ( SW_HP     >= 0     or SW_TTD                              >= 0                                        ) and 
                ( SW_HP     <= 0     or Unit("player"):HealthPercent()     <= SW_HP                                    ) and 
                ( SW_TTD     <= 0     or Unit("player"):TimeToDie()         <= SW_TTD + (IsShieldUP() and 0 or 0.6)     ) -- add 0.6 sec due delay in weapon swap 
            ) or 
            (
                A.GetToggle(2, "ShieldWallCatchKillStrike") and 
                (
                    ( Unit("player"):GetDMG()         >= Unit("player"):Health() and Unit("player"):HealthPercent() <= 20 ) or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):Health() or 
                    Unit("player"):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD() + (IsShieldUP() and 0 or 0.6)
                )
            )                
            then
                -- ShieldBlock
                if A.ShieldBlock:IsReadyByPassCastGCD("player", nil, nil, true) and myRage >= A.ShieldBlock:GetSpellPowerCostCache() and (inStance == 2 or A.TacticalMastery:GetTalentRank() * 5 >= A.ShieldBlock:GetSpellPowerCostCache()) then  
                    A.ShieldBlock:SetQueue(MetaQueue[meta].player)        -- #4
                end 
                
                -- ShieldWall
                A.ShieldWall:SetQueue(MetaQueue[meta].player)            -- #3
                
                -- Stance 
                if inStance ~= 2 then                     
                    A.DefensiveStance:SetQueue(MetaQueue[meta].player)    -- #2
                end 
                
                -- Equip Shield
                if not IsShieldUP() then 
                    A.SwapWeapon:SetQueue(MetaQueue[meta].player)        -- #1
                end         
                
                return 
            end 
        end 
        
        -- Retaliation
        if A.Retaliation:IsReadyByPassCastGCD("player", nil, nil, true) and (inStance == 1 or (A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK())) then         
            local Units                 = A.GetToggle(2, "RetaliationAttackUnits")
            local Range                    = A.GetToggle(2, "RetaliationRangeUnits")
            local HP                    = A.GetToggle(2, "RetaliationHP")
            local TTD                     = A.GetToggle(2, "RetaliationTTD")
            local HITS                    = A.GetToggle(2, "RetaliationHits")
            local PHYSHP                = A.GetToggle(2, "RetaliationPhysHP")
            
            local Hits, Phys             = Unit("player"):GetRealTimeDMG(2)
            
            if     ( Units     >= 0     or HP >= 0 or TTD >= 0 or HITS >= 0 or PHYSHP >= 0                                            ) and 
            ( Units        <= 0     or MultiUnits:GetByRangeIsFocused("player", Range > 0 and Range or nil, Units)     >= Units     ) and 
            ( HP        <= 0     or Unit("player"):HealthPercent()                                                 <= HP         ) and 
            ( TTD        <= 0     or Unit("player"):TimeToDie()                                                     <= TTD        ) and 
            ( HITS         <= 0     or Hits                                                                            >= HITS        ) and 
            ( PHYSHP    <= 0     or Phys * 100 / Unit("player"):HealthMax()                                         >= PHYSHP    )
            then     
                A.Retaliation:SetQueue(MetaQueue[meta].player)        -- #2
                
                -- Stance 
                if inStance ~= 1 then                     
                    A.BattleStance:SetQueue(MetaQueue[meta].player)    -- #1
                end 
                
                return 
            end 
        end 
        
        -- LastStand
        if A.LastStand:IsReadyByPassCastGCD("player", nil, nil, true) and (not A.GetToggle(2, "LastStandIgnoreBigDeff") or Unit("player"):HasBuffs(Temp.BigDeff) == 0) then 
            local LS_HP                    = A.GetToggle(2, "LastStandHP")
            local LS_TTD                = A.GetToggle(2, "LastStandTTD")
            
            if  (    
                ( LS_HP     >= 0     or LS_TTD                              >= 0                                        ) and 
                ( LS_HP     <= 0     or Unit("player"):HealthPercent()     <= LS_HP                                    ) and 
                ( LS_TTD     <= 0     or Unit("player"):TimeToDie()         <= LS_TTD                                      ) 
            ) or 
            (
                A.GetToggle(2, "LastStandCatchKillStrike") and 
                (
                    ( Unit("player"):GetDMG()         >= Unit("player"):Health() and Unit("player"):HealthPercent() <= 20 ) or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):Health() or 
                    Unit("player"):TimeToDie()         <= A.GetGCD()
                )
            )                
            then                
                return A.LastStand:Show(icon)
            end 
        end 
        
        -- Stoneform
        if A.PlayerRace == "Dwarf" then 
            local Stoneform = A.GetToggle(2, "Stoneform")
            if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP("player") and 
            (
                -- Auto 
                (     
                    Stoneform >= 100 and 
                    (
                        (
                            not A.IsInPvP and                         
                            Unit("player"):TimeToDieX(45) < 4 
                        ) or 
                        (
                            A.IsInPvP and 
                            (
                                Unit("player"):UseDeff() or 
                                (
                                    Unit("player", 5):HasFlags() and 
                                    Unit("player"):GetRealTimeDMG() > 0 and 
                                    Unit("player"):IsFocused()                                 
                                )
                            )
                        )
                    ) 
                ) or 
                -- Custom
                (    
                    Stoneform < 100 and 
                    Unit("player"):HealthPercent() <= Stoneform
                )
            ) 
            then 
                return A.Stoneform:Show(icon)
            end     
        end 
    end 
    
    -- PvP: Try to find invisible 
    if A.IsInPvP and A.Zone == "pvp" and A.GetToggle(2, "TryToFindInvisible") and A.Perception:IsRacialReady("player") then 
        if not inCombat then 
            if not Temp.hasInvisibleUnits then 
                Temp.hasInvisibleUnits, Temp.invisibleUnitID = EnemyTeam:HasInvisibleUnits()
            end 
            
            -- Try to catch them by entering combat by someone around while we're not entered 
            if Temp.hasInvisibleUnits and not Unit(Temp.invisibleUnitID):IsVisible() and (MultiUnits:GetByRangeInCombat(nil, 1) >= 1 or FriendlyTeam:PlayersInCombat(25, 5)) then 
                return A.Perception:Show(icon)
            end 
        elseif IsInvisAffected() then 
            -- Try to catch them by used stealth  
            return A.Perception:Show(icon)             
        end 
    end     
    
    -- BattleShout (no combat or no unitID) 
    if (not inCombat or not unitID) and A.BattleShout:IsReady("player") and Unit("player"):HasBuffs(A.BattleShout.ID) <= A.GetGCD() + A.GetCurrentGCD() then 
        return A.BattleShout:Show(icon) 
    end 
    
    -- Return back if no primary unit 
    if not unitID then 
        if CanTargetNearest(inCombat) then 
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end 
        
        if CanCastDefeanseStancePvP(unitID, inCombat, inMelee, inStance) then 
            return A.DefensiveStance:Show(icon)
        end 
        
        -- [[ SWAP WEAPON BY ROLE ]]
        if not inCombat then 
            if A.Role == "DAMAGER" and CanSwapFromShields() then 
                return A.SwapWeapon:Show(icon)
            end 
            
            if A.Role == "TANK" and CanSwapToShields() then 
                return A.SwapWeapon:Show(icon)
            end     
        end 
        
        return 
    end 
    
    -- Bloodrage (no combat)
    if (not bloodrageOnlyDamager or A.Role == "DAMAGER") and not inCombat and bloodrageAtCombatTime == 0 and Unit("player"):Power() <= 80 and A.Bloodrage:IsReady("player") and Unit("player"):HealthPercent() >= bloodrageHP then  
        return A.Bloodrage:Show(icon)
    end     
    
    -- Auto Shoot (no combat) 
    if not inCombat and A.GetToggle(1, "AutoShoot") and Player:IsStaying() then 
        local AutoShoot = A.DetermineUsableObject(unitID, nil, nil, true, nil, A.ShootBow, A.ShootCrossbow, A.ShootGun, A.Throw) 
        if AutoShoot and AutoShoot:AbsentImun(unitID, Temp.AttackTypes) then 
            -- Pre use BattleStance to later without time wasting make Charge 
            if inStance ~= 1 and A.Charge:IsReady(unitID, nil, nil, nil, true) and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() then 
                return A.BattleStance:Show(icon)
            end         
            return A:Show(icon, ACTION_CONST_AUTOSHOOT)
        end 
    end 
    
    -- Charge (no combat)
    if not inCombat and A.Charge:IsReady(unitID, nil, nil, nil, true) then 
        if inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() then  
            return A.BattleStance:Show(icon)
        end 
        
        if inStance == 1 then 
            return A.Charge:Show(icon)
        end 
    end 
    
    -- [[ INTERRUPTS ]] 
    local useKick, useCC, useRacial = A.InterruptIsValid(unitID, "TargetMouseover") 
    if useKick or useCC or useRacial then         
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        local interrupt                      = (not A.Pummel:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.ShieldBash:IsReadyByPassCastGCD(unitID, nil, nil, true) and not IsShieldUP()) or Unit(unitID):CanInterrupt(nil, nil, 15, 67)
        
        -- useKick
        if useKick and castLeft > 0 and not notKickAble and A.AbsentImun(nil, unitID, Temp.AuraForInterrupt) and interrupt then 
            -- ShieldBash 
            if A.ShieldBash:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsShieldUP() then 
                if GenerateShieldBash(meta, A.ShieldBash, castLeft, false, unitID) then 
                    return false 
                end 
                
                if A.ShieldBash:IsReady(unitID) then      
                    return A.ShieldBash:Show(icon)
                end 
            end 
            
            -- Pummel 
            if A.Pummel:IsReadyByPassCastGCD(unitID, nil, nil, true) then     
                if GeneratePummel(meta, A.Pummel, castLeft, false, unitID) then 
                    return false 
                end 
                
                if A.Pummel:IsReady(unitID) then      
                    return A.Pummel:Show(icon)
                end
            end 
            
            -- ShieldBash - Equip Shield -> Stance
            if A.ShieldBash:IsReadyByPassCastGCD(unitID, nil, nil, true) then 
                if GenerateShieldBash(meta, A.ShieldBash, castLeft, false, unitID) then 
                    return false 
                end 
                
                if A.ShieldBash:IsReady(unitID) then      
                    return A.ShieldBash:Show(icon)
                end  
            end             
        end 
        
        -- useCC / useRacial
        if not useKick or notKickAble or (not A.Pummel:IsReadyByPassCastGCD(unitID) and not A.ShieldBash:IsReadyByPassCastGCD(unitID) and interrupt) or not A.AbsentImun(nil, unitID, Temp.AuraForInterrupt) or A.Pummel:GetCooldown() > 0 or A.ShieldBash:GetCooldown() > 0 or ((A.Pummel:IsBlocked() or A.Pummel:IsBlockedBySpellBook()) and (A.ShieldBash:IsBlocked() or A.ShieldBash:IsBlockedBySpellBook())) then 
            -- useCC          - ConcussionBlow
            if useCC and castLeft > A.GetCurrentGCD() and castLeft < A.GetGCD() + A.GetCurrentGCD() + 0.2 and A.ConcussionBlow:IsReady(unitID) and A.ConcussionBlow:AbsentImun(unitID, Temp.AuraForStun) and Unit(unitID):IsControlAble("stun") then 
                return A.ConcussionBlow:Show(icon)
            end 
            
            -- useRacial     - WarStomp
            if useRacial and A.WarStomp:AutoRacial(unitID) then 
                return A.WarStomp:Show(icon)
            end 
            
            -- useCC        - IntimidatingShout
            if useCC and castLeft > A.GetCurrentGCD() and castLeft < A.GetGCD() + A.GetCurrentGCD() + 0.2 and A.IntimidatingShout:IsReady(unitID) and A.IntimidatingShout:AbsentImun(unitID, Temp.AuraForFear) and Unit(unitID):IsControlAble("fear") then 
                return A.IntimidatingShout:Show(icon)
            end 
        end 
    end         
    
    -- [[ CROWNCONTROL ]]
    if A.Disarm:IsReadyByPassCastGCD(unitID, nil, nil, true) then 
        if Action.Warrior_DisarmIsReady(unitID) then 
            if GenerateDisarm(meta, A.Disarm, true, unitID) then 
                return false 
            end 
            
            if A.Disarm:IsReady(unitID) then 
                return A.Disarm:Show(icon)        
            end 
        end 
    end 
    
    -- [[ PvP ]]    
    -- Rend (Rogue, Feral)
    if A.IsInPvP and A.Rend:IsReady("target", nil, nil, nil, true) and (Unit("target"):Class() == "ROGUE" or Unit("target"):Class() == "DRUID") and CanCastIfExecuteOff(targetHealthPercent, myRage) then 
        if inStance == 3 and myRage >= A.Rend:GetSpellPowerCostCache() and A.TacticalMastery:GetTalentRank() * 5 >= A.Rend:GetSpellPowerCostCache() and UseFirstAvailableStance(icon, inStance, SortByRoleStance(A.BattleStance, A.DefensiveStance)) then 
            return true 
        end 
        
        if inStance ~= 3 and A.Rend:IsReady("target") then 
            return A.Rend:Show(icon)
        end 
    end 
    
    -- PiercingHowl (PvP, AoE)
    if A.IsInPvP and A.PiercingHowl:IsReadyByPassCastGCD() and myRage >= A.PiercingHowl:GetSpellPowerCostCache() and (not targetExists or CanCastIfExecuteOff(targetHealthPercent, myRage)) then 
        if inStance == 2 and inMelee and Unit(unitID):IsPlayer() and Unit(unitID):HasDeBuffs(A.PiercingHowl.ID) <= A.GetGCD() + A.GetCurrentGCD() and Unit(unitID):GetMaxSpeed() >= 100 and A.PiercingHowl:AbsentImun(unitID, Temp.AuraForSlow) then 
            return A.PiercingHowl:Show(icon)
        end 
        
        if inAoE then 
            local PH_Nameplates = MultiUnits:GetActiveUnitPlates()
            if PH_Nameplates then 
                local PH_Players = 0
                for PH_Unit in pairs(PH_Nameplates) do 
                    if not UnitIsUnit(PH_Unit, unitID) and Unit(PH_Unit):IsPlayer() and A.Hamstring:IsInRange(PH_Unit) and Unit(unitID):HasDeBuffs(A.PiercingHowl.ID) <= A.GetGCD() + A.GetCurrentGCD() and Unit(unitID):GetMaxSpeed() >= 100 and A.PiercingHowl:AbsentImun(unitID, Temp.AuraForSlow) then 
                        PH_Players = PH_Players + 1
                        if PH_Players >= 2 then 
                            return A.PiercingHowl:Show(icon)
                        end 
                    end 
                end                 
            end 
        end 
    end 
    
    -- Hamstring 
    if A.IsInPvP and A.Hamstring:IsReady("target", nil, nil, nil, true) and Unit("target"):IsPlayer() and Unit("target"):HasDeBuffs(A.Hamstring.ID) <= A.GetGCD() + A.GetCurrentGCD() and Unit("target"):GetMaxSpeed() >= 100 and A.Hamstring:AbsentImun("target", Temp.AuraForSlow) and CanCastIfExecuteOff(targetHealthPercent, myRage) then 
        if inStance == 2 and (A.Role ~= "TANK" or A.PiercingHowl:IsBlockedBySpellBook() or A.PiercingHowl:IsBlocked()) and myRage >= A.Hamstring:GetSpellPowerCostCache() and A.TacticalMastery:GetTalentRank() * 5 >= A.Hamstring:GetSpellPowerCostCache() and UseFirstAvailableStance(icon, inStance, SortByRoleStance(A.BattleStance, A.BerserkerStance)) then 
            return true 
        end 
        
        if inStance ~= 2 and A.Hamstring:IsReady("target") then 
            return A.Hamstring:Show(icon)
        end 
    end     
    
    -- ShieldSlam (High priority)
    if A.IsInPvP and A.ShieldSlam:IsReady("target", nil, nil, nil, true) and Unit("target"):IsPlayer() and A.AuraIsValid("target", "UsePurge", "PurgeHigh") and ((A.ShieldSlam:AbsentImun("target", Temp.AttackTypes) and CanCastIfExecuteOff(targetHealthPercent, myRage)) or Unit("target"):HasBuffs(A.BlessingofProtection.ID) > 0) then
        if CanSwapToShields() and myRage >= A.ShieldSlam:GetSpellPowerCostCache() then 
            return A.SwapWeapon:Show(icon)
        end 
        
        if IsShieldUP() and myRage >= A.ShieldSlam:GetSpellPowerCostCache() then 
            return A.ShieldSlam:Show(icon)
        end 
    end 
    
    -- DefensiveStance
    if CanCastDefeanseStancePvP(unitID, inCombat, inMelee, inStance) then 
        return A.DefensiveStance:Show(icon)
    end
    
    -- [[ CANCEL QUEUE ]] 
    -- A.CancelAllQueueForMeta(meta) -- Not sure if that must be here since we do not queue itself final objects, we timing them through each loop    
    
    -- ChallengingShout
    if not A.IsInPvP and A.Role == "TANK" and combatTime > 5 and A.ChallengingShout:IsReady() then 
        local CS_Count = A.GetToggle(2, "ChallengingShout-Units")
        if CS_Count > 0 then 
            local CS_Nameplates = MultiUnits:GetActiveUnitPlates()
            if CS_Nameplates then 
                local CS_Mobs = 0
                for CS_Unit in pairs(CS_Nameplates) do 
                    if not Unit(CS_Unit):IsPlayer() and A.Hamstring:IsInRange(CS_Unit) and Unit(unitID):HasDeBuffs(Temp.AuraTaunt) == 0 and not Unit(CS_Unit .. "target"):IsTank() then 
                        CS_Mobs = CS_Mobs + 1
                        if CS_Mobs > CS_Count then 
                            return A.ChallengingShout:Show(icon)
                        end 
                    end 
                end                 
            end 
        end 
    end     
    
    -- Taunt 
    if not A.IsInPvP and A.Role == "TANK" and combatTime > 3.1 and A.Taunt:IsReady(unitID, nil, nil, nil, true) and not Unit(unitID):IsPlayer() and Unit("player"):ThreatSituation(unitID) ~= 3 and not Unit(unitID .. "target"):IsTank() and Unit(unitID):HasDeBuffs(Temp.AuraTaunt) == 0 then 
        if inStance ~= 2 and A.DefensiveStance:IsReady("player") and A.DefensiveStance:PowerLimitOK() then 
            return GenerateObjects(meta, unitID, A.Taunt, A.DefensiveStance)
        end 
        
        if inStance == 2 then 
            return A.Taunt:Show(icon)
        end 
    end 
    
    -- MockingBlow
    if not A.IsInPvP and A.Role == "TANK" and combatTime > 4 and targetExists and A.MockingBlow:IsReady("target", nil, nil, nil, true) and myRage >= A.MockingBlow:GetSpellPowerCostCache() and not Unit("target"):IsPlayer() and targetThreatSituation ~= 3 and not Unit("targettarget"):IsTank() and Unit("target"):HasDeBuffs(Temp.AuraTaunt) == 0 and (A.Taunt:IsBlockedBySpellBook() or A.Taunt:IsBlocked() or A.Taunt:GetCooldown() > 2) then 
        if inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() and A.TacticalMastery:GetTalentRank() * 5 >= A.MockingBlow:GetSpellPowerCostCache()  then 
            return GenerateObjects(meta, unitID, A.MockingBlow, A.BattleStance)
        end 
        
        if inStance == 1 then 
            return A.MockingBlow:Show(icon)
        end     
    end 
    
    -- BattleShout 
    if A.BattleShout:IsReady("player") and Unit("player"):HasBuffs(A.BattleShout.ID) <= A.GetGCD() + A.GetCurrentGCD() then 
        return A.BattleShout:Show(icon) 
    end     
    
    -- ShieldSlam (Low priority, only if shields already equiped)
    if A.IsInPvP and A.ShieldSlam:IsReady("target") and Unit("target"):IsPlayer() and A.AuraIsValid("target", "UsePurge", "PurgeLow") and ((A.ShieldSlam:AbsentImun("target", Temp.AttackTypes) and CanCastIfExecuteOff(targetHealthPercent, myRage)) or Unit("target"):HasBuffs(A.BlessingofProtection.ID) > 0) and IsShieldUP() then
        return A.ShieldSlam:Show(icon)
    end 
    
    -- ShieldBlock (any role, whenever have physical damage)
    if inStance == 2 and Player:HasShield(true) and myRage >= A.ShieldBlock:GetSpellPowerCostCache() and A.ShieldBlock:IsReady("player", nil, nil, nil, true) and Unit("player"):GetRealTimeDMG(3) > 0 and (targetThreatPercent >= 100 or A.Role == "DAMAGER") then 
        return A.ShieldBlock:Show(icon)
    end 
    
    -- [[ SWAP WEAPON BY ROLE ]]
    if A.Role == "DAMAGER" and CanSwapFromShields() then 
        return A.SwapWeapon:Show(icon)
    end 
    
    if A.Role == "TANK" and CanSwapToShields() then 
        return A.SwapWeapon:Show(icon)
    end         
    
    -- Hamstring (outside, leveling kite)
    if A.Zone == "none" and A.GetToggle(2, "UseHamstring-Outside") and A.Hamstring:IsReady("target") and not Unit("target"):IsBoss() and Unit("target"):HasDeBuffs(A.Hamstring.ID) <= A.GetGCD() + A.GetCurrentGCD() and Unit("target"):GetMaxSpeed() >= 100 and UnitIsUnit("targettarget", "player") and A.Hamstring:GetSpellTimeSinceLastCast() > 5 then 
        return A.Hamstring:Show(icon)
    end     
    
    -- Bloodrage (pulling)        
    if (not bloodrageOnlyDamager or A.Role == "DAMAGER") and combatTime > 0 and bloodrageAtCombatTime > 0 and combatTime <= bloodrageAtCombatTime and Unit("player"):Power() <= 60 and A.Bloodrage:IsReady("player") and Unit("player"):HealthPercent() >= bloodrageHP then 
        return A.Bloodrage:Show(icon)
    end     
    
    -- [[ BURST ]]     
    if inCombat and inMelee and A.BurstIsON("target") and A.AbsentImun(nil, "target", Temp.AttackTypes) then 
        local timing20             = A.GetToggle(2, "BurstTimingTo20")        
        local ttdto20             = Unit("target"):TimeToDieX(20)
        local isboss            = Unit("target"):IsBoss()
        local timetouseall        = A.DetermineCountGCDs(A.BloodFury, A.Berserking, A.Recklessness, A.DeathWish) * A.GetGCD() + A.GetCurrentGCD()
        
        -- Berserking
        if A.Berserking:AutoRacial("target") and A.Berserking:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then 
            return A.Berserking:Show(icon)
        end 
        
        -- BloodFury 
        if A.BloodFury:AutoRacial("target") and A.BloodFury:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then 
            return A.BloodFury:Show(icon)
        end 
        
        -- DeathWish
        if A.DeathWish:IsReady("player") and A.DeathWish:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then 
            return A.DeathWish:Show(icon)
        end  
        
        -- Recklessness
        if A.Recklessness:IsReady("player", nil, nil, nil, true) and A.Recklessness:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then 
            if inStance ~= 3 and A.BerserkerStance:IsReady("player") and A.BerserkerStance:PowerLimitOK() and GenerateObjects(meta, "player", A.Recklessness, A.BerserkerStance) then 
                return true 
            end 
            
            if inStance == 3 then 
                return A.Recklessness:Show(icon)
            end 
        end  
        
        -- Trinkets  
        if A.Trinket1:IsReady("target") and A.Trinket1:IsItemDamager() and A.Trinket1:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then -- and not Temp.IsBlackListedItem[A.Trinket1:GetID()]
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady("target") and A.Trinket2:IsItemDamager() and A.Trinket2:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then -- and not Temp.IsBlackListedItem[A.Trinket2:GetID()]
            return A.Trinket2:Show(icon)
        end         
        
        -- Potion
        if A.MightyRagePotion:IsReady("player") and A.MightyRagePotion:CanCastBurst(targetHealthPercent, timing20, ttdto20, isboss, timetouseall) then 
            return A.MightyRagePotion:Show(icon)
        end         
    end 
    
    -- Bloodrage    
    if inCombat and (not bloodrageOnlyDamager or A.Role == "DAMAGER") and inMelee and InRoleStance(inStance, 3) and Unit("player"):Power() < 30 and A.Bloodrage:IsReady("player") and Unit("player"):HealthPercent() >= bloodrageHP then 
        return A.Bloodrage:Show(icon)
    end     
    
    -- SweepingStrikes (AoE)
    if inStance == 1 and inAoE and A.SweepingStrikes:IsReady("player") and MultiUnits:GetBySpell(A.Hamstring, 2) >= 2 and myRage >= (((targetHealthPercent > 20 or not A.Execute:IsReadyByPassCastGCD("target", nil, nil, true) or isSafestThreatRotation) and CalculateRage(A.Bloodthirst, A.MortalStrike, A.SweepingStrikes)) or (not isSafestThreatRotation and A.Execute:IsReadyByPassCastGCD("target", nil, nil, true) and targetHealthPercent <= 20 and A.Execute:GetSpellPowerCostCache()) or 0) then
        return A.SweepingStrikes:Show(icon)
    end 
    
    -- Whirlwind (2+ AoE)
    if targetExists and inStance == 3 and inAoE and (A.Whirlwind:IsReady("target", true) or (not A.Whirlwind:IsBlocked() and not A.Whirlwind:IsBlockedBySpellBook() and A.Whirlwind:IsUsable(A.GetGCD()))) and A.Whirlwind:AbsentImun("target", Temp.AttackTypes) and GetByRange(2, 8) and (not A.IsInPvP or not EnemyTeam:IsBreakAble(8)) then         
        return A.Whirlwind:Show(icon)
    end     
    
    -- Execute 
    if targetExists and not isSafestThreatRotation and A.Execute:IsReadyByPassCastGCD("target", nil, nil, true) and A.Execute:AbsentImun("target", Temp.AttackTypes) and targetHealthPercent <= 20 then 
        if inStance ~= 2 and A.Execute:IsReady("target") then 
            return A.Execute:Show(icon)
        end 
        
        -- BattleStance
        if A.Role == "TANK" and inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() then 
            return A.BattleStance:Show(icon)
        end 
        
        -- BerserkerStance
        if A.Role == "DAMAGER" and inStance ~= 3 and A.BerserkerStance:IsReady("player") and A.BerserkerStance:PowerLimitOK() then 
            return A.BerserkerStance:Show(icon)
        end          
        
        -- BerserkerRage (gain toggle)
        if inCombat and inStance == 3 and A.GetToggle(2, "UseBerserkerRage-GainRage") and A.ImprovedBerserkerRage:GetTalentRank() > 0 and A.BerserkerRage:IsReady("player") and myRage < A.Execute:GetSpellPowerCostCache() then 
            return A.BerserkerRage:Show(icon)             
        end            
        
        -- Pulling rage 
        if inStance ~= 2 and (A.Role == "DAMAGER" or (A.Taunt:GetCooldown() == 0 and A.MockingBlow:GetCooldown() == 0) or targetThreatSituation ~= 3) and (myRage >= A.Execute:GetSpellPowerCostCache() or A.Role ~= "DAMAGER" or not IsOverPowerUP("target") or A.Overpower:IsBlocked() or A.Overpower:IsBlockedBySpellBook() or myRage < A.Overpower:GetSpellPowerCostCache() or A.TacticalMastery:GetTalentRank() < 1 or not A.BattleStance:IsReady("player") or not A.BattleStance:PowerLimitOK()) then
            return A.Execute:Show(icon) 
        end 
    end         
    
    -- Bloodthirst
    if (A.Bloodthirst:IsReady("target") or (not A.Bloodthirst:IsBlocked() and not A.Bloodthirst:IsBlockedBySpellBook() and A.Bloodthirst:IsUsable(A.GetGCD()) and A.Bloodthirst:IsInRange("target") and myRage < CalculateRage(A.Bloodthirst, A.Whirlwind))) and A.Bloodthirst:AbsentImun("target", Temp.AttackTypes) then 
        return A.Bloodthirst:Show(icon)
    end 
    
    -- MortalStrike
    if (A.MortalStrike:IsReady("target") or (not A.MortalStrike:IsBlocked() and not A.MortalStrike:IsBlockedBySpellBook() and A.MortalStrike:IsUsable(A.GetGCD()) and A.MortalStrike:IsInRange("target") and myRage < CalculateRage(A.MortalStrike, A.Whirlwind))) and A.MortalStrike:AbsentImun("target", Temp.AttackTypes) then 
        return A.MortalStrike:Show(icon)
    end 
    
    -- SweepingStrikes (AoE)
    if inStance == 1 and inAoE and A.SweepingStrikes:IsReady("player") and MultiUnits:GetBySpell(A.Hamstring, 2) >= 2 and myRage >= CalculateRage(A.MortalStrike, A.Whirlwind) then
        return A.SweepingStrikes:Show(icon)
    end     
    
    -- ShieldSlam 
    if A.Role == "TANK" and A.ShieldSlam:IsReady("target", nil, nil, nil, true) and myRage >= A.ShieldSlam:GetSpellPowerCostCache() and IsShieldUP() then 
        if inStance ~= 2 and A.DefensiveStance:IsReady("player") and A.DefensiveStance:PowerLimitOK() and myRage <= A.TacticalMastery:GetTalentRank() * 5 then 
            A.ShieldSlam:SetQueue(MetaQueue[meta].target)         -- #2
            A.DefensiveStance:SetQueue(MetaQueue[meta].player)     -- #1
            return A.DefensiveStance:Show(icon)
        end 
        
        return A.ShieldSlam:Show(icon)
    end 
    
    -- Revenge
    if (A.Role == "TANK" or (inStance == 2 and not isSafestThreatRotation and targetThreatSituation == 3 and A.Zone == "none")) and A.Revenge:IsReady("target", nil, nil, nil, true) and myRage >= A.Revenge:GetSpellPowerCostCache() then 
        if inStance ~= 2 and IsRevengeUP("player") and A.DefensiveStance:IsReady("player") and A.DefensiveStance:PowerLimitOK() and myRage <= A.TacticalMastery:GetTalentRank() * 5 then 
            A.Revenge:SetQueue(MetaQueue[meta].target)             -- #2
            A.DefensiveStance:SetQueue(MetaQueue[meta].player)     -- #1
            return A.DefensiveStance:Show(icon)
        end 
        
        if inStance == 2 and A.Revenge:IsReady("target") then 
            return A.Revenge:Show(icon)
        end 
    end 
    
    -- SunderArmor (if not up then apply)
    if rageSaved and not isSafestThreatRotation and A.SunderArmor:IsReady("target") and A.SunderArmor:AbsentImun("target", Temp.AttackTypes) and ((Unit("target"):HasDeBuffs(A.SunderArmor.ID) == 0 and not Unit("target"):IsDeBuffsLimited()) or (Unit("target"):HasDeBuffs(A.SunderArmor.ID, true) ~= 0 and Unit("target"):HasDeBuffsStacks(A.SunderArmor.ID) >= 5 and A.SunderArmor:GetSpellTimeSinceLastCast() >= 30 - A.GetGCD() - A.GetCurrentGCD())) then 
        return A.SunderArmor:Show(icon)
    end 
    
    -- Whirlwind (Single)
    if targetExists and A.Whirlwind:IsReady("target", true, nil, nil, true) and A.Whirlwind:AbsentImun("target", Temp.AttackTypes) and (inMelee or (Unit("target"):GetRange() > 0 and Unit("target"):GetRange() <= 8)) and myRage >= A.Whirlwind:GetSpellPowerCostCache() + ((inStance ~= 3 and 0) or (not A.Bloodthirst:IsBlockedBySpellBook() and A.Bloodthirst:GetCooldown() < 3 and A.Bloodthirst:GetSpellPowerCostCache()) or (not A.MortalStrike:IsBlockedBySpellBook() and A.MortalStrike:GetCooldown() < 3 and A.MortalStrike:GetSpellPowerCostCache()) or 0) and (not A.IsInPvP or not EnemyTeam:IsBreakAble(8)) then         
        if A.Role == "DAMAGER" and inStance ~= 3 and A.BerserkerStance:IsReady("player") and A.BerserkerStance:PowerLimitOK() then 
            return A.BerserkerStance:Show(icon)
        end 
        
        if A.Whirlwind:IsReady("target", true) then 
            return A.Whirlwind:Show(icon)
        end 
    end 
    
    -- Cleave (AoE or isSafestThreatRotation)
    if targetExists and (isSafestThreatRotation or (inAoE and MultiUnits:GetBySpell(A.Hamstring, 7) >= 2 and (A.Role == "DAMAGER" or MultiUnits:GetBySpell(A.Hamstring, 7) <= 4 or MultiUnits:GetBySpell(A.Hamstring, 7) >= 7))) and not IsCurrentAttack() and inMelee and A.Cleave:IsReady("target", true) and A.Cleave:AbsentImun("target", Temp.AttackTypes) and (not A.IsInPvP or not EnemyTeam:IsBreakAble(5)) and ((cleavePWR < 0 and myRage > 50) or (cleavePWR >= 0 and myRage >= cleavePWR)) then 
        return A.Cleave:Show(icon)
    end 
    
    -- HeroicStrike (Single)
    if targetExists and not IsCurrentAttack() and not isSafestThreatRotation and ((heroicStrikePWR < 0 and myRage > 50) or (heroicStrikePWR >= 0 and myRage >= heroicStrikePWR)) and inMelee and A.HeroicStrike:IsReady("target") and A.HeroicStrike:AbsentImun("target", Temp.AttackTypes) then
        return A.HeroicStrike:Show(icon)
    end 
    
    -- Overpower
    if (A.Role == "DAMAGER" or inStance == 1) and inMelee and IsOverPowerUP("target") and ((overpowerPWRbelow < 0 and inStance ~= 1 and ((myRage <= 25) or (myRage < 50 and (A.Whirlwind:GetCooldown() > 2 or A.Whirlwind:IsBlockedBySpellBook()) and (A.Bloodthirst:GetCooldown() > 2 or A.MortalStrike:GetCooldown() > 2 or (A.Bloodthirst:IsBlockedBySpellBook() and A.MortalStrike:IsBlockedBySpellBook()))))) or (overpowerPWRbelow >= 0 and myRage <= overpowerPWRbelow)) and A.Overpower:IsReady("target", true, nil, nil, true) and A.Overpower:AbsentImun("target", Temp.AttackTypes) then 
        if inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() and myRage >= A.Overpower:GetSpellPowerCostCache() and A.TacticalMastery:GetTalentRank() * 5 >= A.Overpower:GetSpellPowerCostCache() then 
            A.Overpower:SetQueue(MetaQueue[meta].target)     -- #2
            A.BattleStance:SetQueue(MetaQueue[meta].player) -- #1
            return A.BattleStance:Show(icon)
        end 
        
        if inStance == 1 and A.Overpower:IsReady("target") then 
            return A.Overpower:Show(icon)
        end 
    end 
    
    -- Switch stance to primary, if can't lose rage 
    if inMelee and myRage <= A.TacticalMastery:GetTalentRank() * 5 and UsePrimaryStance(icon, inStance) then 
        return true 
    end 
    
    -- DemoralizingShout
    if targetExists and inAoE and A.DemoralizingShout:IsReady("target", true) and ((A.Role == "TANK" and GetByRange(3, 7)) or (rageSaved and UnitsMissingByDeBuff(A.DemoralizingShout.ID, nil, 3, 10))) and A.DemoralizingShout:AbsentImun("target", Temp.AttackTypes) then 
        return A.DemoralizingShout:Show(icon)
    end 
    
    -- ThunderClap
    if targetExists and inAoE and A.ThunderClap:IsReady("target", true, nil, nil, true) and rageSaved and UnitsMissingByDeBuff(A.ThunderClap.ID, nil, 4, 10) and A.ThunderClap:AbsentImun("target", Temp.AttackTypes) and myRage >= A.ThunderClap:GetSpellPowerCostCache() then 
        if inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() and myRage <= A.TacticalMastery:GetTalentRank() * 5 and A.TacticalMastery:GetTalentRank() * 5 >= A.ThunderClap:GetSpellPowerCostCache() then 
            A.ThunderClap:SetQueue(MetaQueue[meta].player)     -- #2 (player here)
            A.BattleStance:SetQueue(MetaQueue[meta].player) -- #1
            return A.BattleStance:Show(icon)
        end 
        
        if inStance == 1 then 
            return A.ThunderClap:Show(icon)
        end 
    end 
    
    -- [Tank] Cycle targets > 4 and < 7 to apply for every one SunderArmor if there are more than 1 unit without or around to expire debuff 
    if A.Role == "TANK" and rageSaved and targetExists and inAoE and A.GetToggle(1, "AutoTarget") and A.SunderArmor:IsReadyByPassCastGCD() and not Unit("target"):IsBoss() and Unit("target"):HasDeBuffs(A.SunderArmor.ID) > A.GetGCD() + A.GetCurrentGCD() and MultiUnits:GetBySpell(A.Hamstring, 7) > 4 and MultiUnits:GetBySpell(A.Hamstring, 7) < 7 then 
        local SA_Nameplates = MultiUnits:GetActiveUnitPlates()
        if SA_Nameplates then  
            for SA_UnitID in pairs(SA_Nameplates) do             
                if not UnitIsUnit("target", SA_UnitID) and A.SunderArmor:IsInRange(SA_UnitID) and Unit(SA_UnitID):HasDeBuffs(A.SunderArmor.ID) <= A.GetGCD() + A.GetCurrentGCD() then 
                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                end         
            end 
        end 
    end 
    
    -- SunderArmor (refresh, build 5 stacks)
    if rageSaved and not isSafestThreatRotation and A.SunderArmor:IsReady("target") and A.SunderArmor:AbsentImun("target", Temp.AttackTypes) and ((Unit("target"):HasDeBuffs(A.SunderArmor.ID) == 0 and not Unit("target"):IsDeBuffsLimited()) or Unit("target"):HasDeBuffs(A.SunderArmor.ID, true) ~= 0) and (Unit("target"):HasDeBuffsStacks(A.SunderArmor.ID) < 5 or A.SunderArmor:GetSpellTimeSinceLastCast() >= 30 - A.GetGCD() * 2 - A.GetCurrentGCD()) then 
        return A.SunderArmor:Show(icon)
    end 
    
    -- Slam (TwoHand, if to next swing hit > cast time)    
    if targetExists and rageSaved and Player:HasWeaponTwoHand(true) and Player:IsStayingTime() > 0.4 and A.Slam:IsReady("target") and A.Slam:AbsentImun("target", Temp.AttackTypes) and Player:GetSwing(1) > A.Slam:GetSpellCastTime() + A.GetPing() + ACTION_CONST_CACHE_DEFAULT_TIMER and ((A.Role == "TANK" or A.Whirlwind:IsBlockedBySpellBook() or A.Whirlwind:GetCooldown() > A.GetGCD() + A.GetCurrentGCD()) and (A.Bloodthirst:IsBlockedBySpellBook() or A.Bloodthirst:GetCooldown() > A.GetGCD() + A.GetCurrentGCD()) and (A.MortalStrike:IsBlockedBySpellBook() or A.MortalStrike:GetCooldown() > A.GetGCD() + A.GetCurrentGCD()) and (A.ShieldSlam:IsBlockedBySpellBook() or A.ShieldSlam:GetCooldown() > A.GetGCD() + A.GetCurrentGCD())) and ((targetHealthPercent > 22 and Unit("target"):TimeToDieX(20) > A.Slam:GetSpellCastTime() + A.GetPing() + ACTION_CONST_CACHE_DEFAULT_TIMER + A.GetGCD() * 2) or not A.Execute:IsReadyByPassCastGCD("target", nil, nil, true)) then 
        return A.Slam:Show(icon)
    end 
    
    -- Hamstring (spam)
    if A.Hamstring:IsReady("target") and A.Hamstring:AbsentImun("target", Temp.AuraForSlow) and ((hamstringPWR < 0 and myRage >= 80) or (hamstringPWR >= 0 and myRage >= hamstringPWR)) and A.Flurry:GetTalentRank() > 0 and (Unit("player"):HasBuffs(A.Flurry.ID, true) == 0 or Unit("player"):HasBuffs(A.WindfuryTotem.ID) > 0) then 
        return A.Hamstring:Show(icon)
    end         
    
    -- SweepingStrikes
    if inAoE and A.SweepingStrikes:IsReady("player", nil, nil, nil, true) and MultiUnits:GetBySpell(A.Hamstring, 2) >= 2 then 
        if inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() and A.TacticalMastery:GetTalentRank() >= 5 and Player:GetSwing(4) > 0 and Player:GetSwing(4) < 0.3 then -- here is fixed 5 since SweepingStrikes cost 30, we use additional next swing prediction to gain rage
            A.SweepingStrikes:SetQueue(MetaQueue[meta].player)     -- #2
            A.BattleStance:SetQueue(MetaQueue[meta].player)     -- #1
            return A.BattleStance:Show(icon)
        end 
        
        if inStance == 1 and A.SweepingStrikes:IsReady("player") then 
            return A.SweepingStrikes:Show(icon)
        end 
    end       
    
    -- Auto Shoot (combat, nothing to do) 
    if inCombat and A.GetToggle(1, "AutoShoot") and Player:IsStaying() and (LoC:Get("ROOT") > A.GetGCD() or (LoC:Get("ROOT") == 0 and Player:IsStayingTime() > 2) or combatTime < 5) then 
        local AutoShoot = A.DetermineUsableObject(unitID, nil, nil, true, nil, A.ShootBow, A.ShootCrossbow, A.ShootGun, A.Throw)
        if AutoShoot and AutoShoot:AbsentImun(unitID, Temp.AttackTypes) then 
            return A:Show(icon, ACTION_CONST_AUTOSHOOT)
        end 
    end 
    
    -- Intercept
    if not inMelee and A.Intercept:IsReady(unitID, nil, nil, nil, true) and A.Intercept:AbsentImun(unitID, Temp.AuraForStun) then 
        if inStance ~= 3 and A.BerserkerStance:IsReady("player") and A.BerserkerStance:PowerLimitOK() and A.TacticalMastery:GetTalentRank() * 5 >= A.Intercept:GetSpellPowerCostCache() then  
            return A.BerserkerStance:Show(icon)
        end 
        
        if inStance == 3 and A.Intercept:IsReady(unitID) then 
            return A.Intercept:Show(icon)
        end 
    end 
    
    -- BerserkerRage (gain toggle)
    if inCombat and A.GetToggle(2, "UseBerserkerRage-GainRage") and A.ImprovedBerserkerRage:GetTalentRank() > 0 and A.BerserkerRage:IsReady("player") and myRage <= 15 + (A.ImprovedBerserkerRage:GetTalentRank() * 5) then 
        if inStance ~= 3 and A.BerserkerStance:IsReady("player") and A.BerserkerStance:PowerLimitOK() and myRage + (A.ImprovedBerserkerRage:GetTalentRank() * 5) <= A.TacticalMastery:GetTalentRank() * 5 then
            A.BerserkerRage:SetQueue(MetaQueue[meta].player)     -- #2
            A.BerserkerStance:SetQueue(MetaQueue[meta].player)     -- #1
            return A.BerserkerStance:Show(icon)
        end 
        
        if inStance == 3 then 
            return A.BerserkerRage:Show(icon)
        end 
    end    
    
    -- PvE: Stoneform (self dispel)
    if not A.IsInPvP and inCombat and A.PlayerRace == "Dwarf" and A.Stoneform:IsRacialReady("player", true) and (A.AuraIsValid("player", true, "Poison") or A.AuraIsValid("player", true, "Bleed") or A.AuraIsValid("player", true, "Disease")) then 
        return A.Stoneform:Show(icon)
    end     
    
    -- PvE: HeartofNoxxion (self dispel)
    if not A.IsInPvP and inCombat and A.HeartofNoxxion:IsReady("player") and (A.AuraIsValid("player", true, "Poison") or A.AuraIsValid("player", true, "Bleed") or A.AuraIsValid("player", true, "Disease")) then 
        return A.Stoneform:Show(icon)
    end         
    
    -- Leveling rotation
    if A.PlayerLevel < 60 and A.GetToggle(2, "IsLevelingRotation") then 
        if A.PlayerLevel < 4 then 
            if targetExists and A.HeroicStrike:IsReady("target") and not IsCurrentAttack() and A.HeroicStrike:AbsentImun("target", Temp.AttackTypes) then 
                return A.HeroicStrike:Show(icon)
            end 
        end 
        
        if A.PlayerLevel <= 10 then 
            if targetExists and inAoE and A.ThunderClap:IsReady("target", true, nil, nil, true) and A.ThunderClap:AbsentImun("target", Temp.AttackTypes) and (inMelee or (Unit("target"):GetRange() > 0 and Unit("target"):GetRange() <= 8)) and MultiUnits:GetByRangeMissedDoTs(8, 2, A.ThunderClap.ID, 8) >= 2 then
                if inStance ~= 1 and A.BattleStance:IsReady("player") and A.BattleStance:PowerLimitOK() then  
                    return A.BattleStance:Show(icon)
                end 
                
                if inStance == 1 and myRage >= A.ThunderClap:GetSpellPowerCostCache() then 
                    return A.ThunderClap:Show(icon)
                end 
            end 
        end 
        
        if A.PlayerLevel < 40 then 
            if A.Rend:IsReady("target") and A.Rend:AbsentImun("target", Temp.AttackTypes) and Unit("target"):HasDeBuffs(A.Rend.ID, true) == 0 then 
                return A.Rend:Show(icon)
            end 
            
            if A.GetToggle(1, "AutoTarget") and A.PlayerLevel <= 10 and A.Rend:IsReadyByPassCastGCD() and inCombat and inAoE then                 
                local RendNameplates = MultiUnits:GetActiveUnitPlates()
                if RendNameplates then 
                    local RendMobs = 0
                    for RendMob in pairs(RendNameplates) do 
                        if A.Rend:IsReady(RendMob) and Unit(RendMob):HasDeBuffs(A.Rend.ID, true) == 0 then 
                            RendMobs = RendMobs + 1
                            if RendMobs >= 2 then 
                                if targetExists and Unit("target"):HasDeBuffs(A.Rend.ID, true) ~= 0 then 
                                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                                end 
                                
                                return A.Rend:Show(icon)
                            end 
                        end 
                    end 
                end 
            end 
        end 
    end 
    
    -- Switch stance to primary 
    if (inMelee or (inStance ~= 3 or A.Intercept:IsBlockedBySpellBook() or not A.Intercept:IsInRange(unitID) or A.Intercept:GetCooldown() > 2)) and myRage < 25 and UsePrimaryStance(icon, inStance) then 
        return true 
    end     
    
    -- AutoTarget (nearest out of range / imun, combat)
    if ((not inMelee and Unit(unitID):GetRange() > 8) or not A.AbsentImun(nil, unitID, Temp.AttackTypes)) and CanTargetNearest(inCombat) then 
        return A:Show(icon, ACTION_CONST_AUTOTARGET)
    end 
end 

-- [5] Trinket Rotation 
A[5] = function(icon)
    -- BerserkerRage (while cc)
    if GetStance() == 3 and LoC:IsValid(Temp.BerserkerRageLoC) and A.BerserkerRage:IsReadyP("player") then 
        return A.BerserkerRage:Show(icon)
    end 
end 

-- Pasive Rotation 
local function RotationPassive(icon, unitID)
    local inStance                             = GetStance()
    -- PvP: Taunt Pets
    if icon.ID == 6 and A.IsInPvP and A.Zone == "pvp" and (inStance == 2 or (A.DefensiveStance:IsReady(unitID) and A.DefensiveStance:PowerLimitOK())) and A.TauntPets:IsReady(nil, nil, nil, nil, true) and EnemyTeam:IsTauntPetAble(A.TauntPets) and LoC:Get("ROOT") > 0 and not InMelee("target") then  
        if inStance ~= 2 then 
            return A.DefensiveStance:Show(icon)
        end 
        return A.TauntPets:Show(icon)
    end     
    
    -- [[ All below disable able only through UI ]]
    -- PvP: Disarm
    if A.Disarm:IsReadyByPassCastGCDP(unitID, nil, nil, true) then 
        if Action.Warrior_DisarmIsReady(unitID) then 
            if GenerateDisarm(icon.ID, A.Disarm, isMsg) then 
                return false 
            end 
            
            if A.Disarm:IsReadyP(unitID) then 
                return A.Disarm:Show(icon)        
            end     
        end 
    end 
    
    -- PvP: Interrupts
    if A.IsInPvP and A.Zone == "pvp" and not UnitIsUnit(unitID, "target") and A.GetToggle(2, "InterruptsPvP")[icon.ID - 5] and (A.InterruptIsValid(unitID, "PvP") or A.InterruptIsValid(unitID, "Heal")) and A.AbsentImun(nil, unitID, Temp.AuraForInterrupt) then 
        local interrupt = (not A.Pummel:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.ShieldBash:IsReadyByPassCastGCD(unitID, nil, nil, true) and not IsShieldUP()) or Unit(unitID):CanInterrupt(nil, nil, 15, 67)
        if interrupt then 
            -- ShieldBash 
            if A.ShieldBash:IsReadyByPassCastGCDP(unitID, nil, nil, true) and IsShieldUP() then 
                if GenerateShieldBash(icon.ID, A.ShieldBash, unitID) then 
                    return false 
                end 
                
                if A.ShieldBash:IsReadyP(unitID) then      
                    return A.ShieldBash:Show(icon)
                end 
            end 
            
            -- Pummel 
            if A.Pummel:IsReadyByPassCastGCDP(unitID, nil, nil, true) then     
                if GeneratePummel(icon.ID, A.Pummel, unitID) then 
                    return false 
                end 
                
                if A.Pummel:IsReadyP(unitID) then      
                    return A.Pummel:Show(icon)
                end
            end 
            
            -- ShieldBash - Equip Shield -> Stance
            if A.ShieldBash:IsReadyByPassCastGCDP(unitID, nil, nil, true) then 
                if GenerateShieldBash(icon.ID, A.ShieldBash, unitID) then 
                    return false 
                end 
                
                if A.ShieldBash:IsReadyP(unitID) then      
                    return A.ShieldBash:Show(icon)
                end  
            end 
        end 
    end 
end 

A[6] = function(icon)
    if RotationPassive(icon, "arena1") then 
        return true 
    end 
end 

A[7] = function(icon)
    if RotationPassive(icon, "arena2") then 
        return true 
    end 
end 

A[8] = function(icon)
    if RotationPassive(icon, "arena3") then 
        return true 
    end 
end 

-- Nil (nothing for profile here, just wipe to nil)
A[4] = nil 

-------------------------------------------
-- [[ UI: QUEUE BASE ]] 
-------------------------------------------
local GameLocale = GetLocale()    
local Localization = {
    [GameLocale] = {},
    enUS          = {
        QERROR1 = "Already queued: ",
        QERROR2 = "Not available: ",
        SHIELD_ERROR = "No shields found on the character!",
        POWER_ERROR = "You don't have enough rage: ",
        TACTICAL_ERROR = "You lack talent" .. A.TacticalMastery:Info() .. " points: ",
    },
    ruRU         = {
        QERROR1 = "Уже находится в очереди: ",
        QERROR2 = "Недоступно: ",
        SHIELD_ERROR = "Щиты не найдены у персонажа!",
        POWER_ERROR = "Вам не хватает ярости: ",
        TACTICAL_ERROR = "Вам не хватает в таланте " .. A.TacticalMastery:Info() .. " очков: ",
    },
}
local L = setmetatable(Localization[GameLocale], { __index = Localization.enUS })

local QB = {
    player                                 = {UnitID = "player",         Silence = false, Value = true, Auto = true, Priority = 1},
    target                                 = {UnitID = "target",         Silence = false, Value = true, Auto = true, Priority = 1},
    Cancel                                 = {Silence = false},
    IsQueuedObjects                        = function(...)
        local found 
        for i = 1, select("#", ...) do
            local object = select(i, ...)
            if object:IsQueued() then 
                found = true 
                A.Print(L.QERROR1 .. object:Info())
            end 
        end 
        
        return found 
    end,
    IsUnavailableObjects                = function(...)
        local found 
        for i = 1, select("#", ...) do
            local object = select(i, ...)
            if (object:GetCooldown() > 0 and (not object.isStance or object.isStance ~= GetStance())) or (object.Type == "Spell" and object:IsBlockedBySpellBook()) or (object.Type == "SwapEquip" and Player:IsSwapLocked()) then 
                found = true 
                A.Print(L.QERROR2 .. object:Info())
            end 
        end 
        
        return found 
    end,
}
function Action.QueueBase(name)
    local inStance  = GetStance()
    local myRage     = Unit("player"):Power()
    
    if name == "ShieldWall" then 
        --[[ Check valid ]]
        if QB.IsQueuedObjects(A.ShieldWall, A.DefensiveStance, A.SwapWeapon) or QB.IsUnavailableObjects(A.ShieldWall, A.DefensiveStance, A.SwapWeapon) then 
            return 
        end         
        
        if not Player:HasShield(true) and not Player:HasShield() then 
            A.Print(L.SHIELD_ERROR)
            return 
        end 
        
        --[[ Cancel other queues ]]
        A.CancelAllQueueForMeta(3)
        
        --[[ Order queue ]]
        -- ShieldBlock
        if not A.ShieldBlock:IsQueued() and A.ShieldBlock:IsReadyByPassCastGCDP("player", nil, nil, true) and myRage >= A.ShieldBlock:GetSpellPowerCostCache() and (inStance == 2 or A.TacticalMastery:GetTalentRank() * 5 >= A.ShieldBlock:GetSpellPowerCostCache()) then  
            A.ShieldBlock:SetQueue(QB.player)        -- #4
        end 
        
        -- ShieldWall
        A.ShieldWall:SetQueue(QB.player)            -- #3
        
        -- Stance 
        if inStance ~= 2 then                     
            A.DefensiveStance:SetQueue(QB.player)    -- #2
        end 
        
        -- Equip Shield
        if not Player:HasShield(true) then 
            A.SwapWeapon:SetQueue(QB.player)        -- #1
        end             
    end 
    
    if name == "ShieldBlock" then 
        --[[ Check valid ]]
        if QB.IsQueuedObjects(A.ShieldBlock, A.DefensiveStance, A.SwapWeapon) or QB.IsUnavailableObjects(A.ShieldBlock, A.DefensiveStance, A.SwapWeapon) then 
            return 
        end         
        
        if not Player:HasShield(true) and not Player:HasShield() then 
            A.Print(L.SHIELD_ERROR)
            return 
        end 
        
        if myRage < A.ShieldBlock:GetSpellPowerCostCache() then 
            A.Print(L.POWER_ERROR .. A.ShieldBlock:GetSpellPowerCostCache() - myRage)
            return 
        end 
        
        if inStance ~= 2 and A.TacticalMastery:GetTalentRank() * 5 < A.ShieldBlock:GetSpellPowerCostCache() then 
            A.Print(L.TACTICAL_ERROR .. math_ceil((A.ShieldBlock:GetSpellPowerCostCache() - (A.TacticalMastery:GetTalentRank() * 5)) / 5))
            return 
        end 
        
        --[[ Cancel other queues ]]
        A.CancelAllQueueForMeta(3)
        
        --[[ Order queue ]]
        -- ShieldBlock        
        A.ShieldBlock:SetQueue(QB.player)            -- #3        
        
        -- Stance 
        if inStance ~= 2 then                     
            A.DefensiveStance:SetQueue(QB.player)    -- #2
        end 
        
        -- Equip Shield
        if not Player:HasShield(true) then 
            A.SwapWeapon:SetQueue(QB.player)        -- #1
        end     
    end 
    
    if name == "SweepingStrikes" then 
        local useBloodrage
        
        --[[ Check valid ]]
        if QB.IsQueuedObjects(A.SweepingStrikes, A.BattleStance) or QB.IsUnavailableObjects(A.SweepingStrikes, A.BattleStance) then 
            return 
        end         
        
        if inStance ~= 1 then 
            if myRage >= A.TacticalMastery:GetTalentRank() * 5 then 
                myRage = A.TacticalMastery:GetTalentRank() * 5                
            end 
        end         
        
        if myRage < A.SweepingStrikes:GetSpellPowerCostCache() then 
            local bloodrageHP = A.GetToggle(2, "Bloodrage-LimitHP")
            local deficit      = A.SweepingStrikes:GetSpellPowerCostCache() - myRage
            
            if myRage < deficit and bloodrageHP > 0 and Unit("player"):HealthPercent() >= bloodrageHP and A.Bloodrage:IsReadyP("player") then 
                myRage = myRage + 10
                useBloodrage = true 
            end 
            
            if myRage < A.SweepingStrikes:GetSpellPowerCostCache() then 
                if not useBloodrage then 
                    A.Print(L.QERROR2 .. A.Bloodrage:Info())
                end 
                
                if inStance ~= 1 then 
                    if A.TacticalMastery:GetTalentRank() * 5 < myRage and A.TacticalMastery:GetTalentRank() < 5 then 
                        A.Print(L.TACTICAL_ERROR .. math_ceil((myRage - (A.TacticalMastery:GetTalentRank() * 5)) / 5))
                        return 
                    end 
                end 
                
                A.Print(L.POWER_ERROR .. A.SweepingStrikes:GetSpellPowerCostCache() - myRage)
                return 
            end 
        end 
        
        --[[ Cancel other queues ]]
        A.CancelAllQueueForMeta(3)
        
        --[[ Order queue ]]
        -- SweepingStrikes        
        A.SweepingStrikes:SetQueue(QB.player)        -- #3 (player here because target will not be valid for range)        
        
        -- Bloodrage
        if useBloodrage then 
            A.Bloodrage:SetQueue(QB.player)            -- #2
        end 
        
        -- Stance 
        if inStance ~= 1 then                     
            A.BattleStance:SetQueue(QB.player)        -- #1
        end 
    end     
end 

