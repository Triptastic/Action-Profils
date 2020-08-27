-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local Action                                    = Action
local Listener                                  = Action.Listener
local Create                                    = Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Azerite                                   = LibStub("AzeriteTraits")
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert
local select, unpack, table                     = select, unpack, table
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local _G, setmetatable, select, math            = _G, setmetatable, select, math
local huge                                      = math.huge
local UIParent                                  = _G.UIParent
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType

--- ============================ CONTENT =========================== ---
--- ======================= SPELLS DECLARATION ===================== ---

Action[ACTION_CONST_WARRIOR_FURY] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    RecklessnessBuff                       = Create({ Type = "Spell", ID = 1719 }),
    Recklessness                           = Create({ Type = "Spell", ID = 1719 }),
    HeroicLeap                             = Create({ Type = "Spell", ID = 6544 }),
    Siegebreaker                           = Create({ Type = "Spell", ID = 280772 }),
    Rampage                                = Create({ Type = "Spell", ID = 184367 }),
    FrothingBerserker                      = Create({ Type = "Spell", ID = 215571 }),
    Carnage                                = Create({ Type = "Spell", ID = 202922 }),
    EnrageBuff                             = Create({ Type = "Spell", ID = 184362 }),
    Massacre                               = Create({ Type = "Spell", ID = 206315 }),
    Execute                                = Create({ Type = "Spell", ID = 5308 }),
    FuriousSlash                           = Create({ Type = "Spell", ID = 100130 }),
    FuriousSlashBuff                       = Create({ Type = "Spell", ID = 202539 }),
    Bladestorm                             = Create({ Type = "Spell", ID = 46924 }),
    Bloodthirst                            = Create({ Type = "Spell", ID = 23881 }),
    ColdSteelHotBlood                      = Create({ Type = "Spell", ID =  }),
    DragonRoar                             = Create({ Type = "Spell", ID = 118000 }),
    RagingBlow                             = Create({ Type = "Spell", ID = 85288 }),
    Whirlwind                              = Create({ Type = "Spell", ID = 190411 }),
    Charge                                 = Create({ Type = "Spell", ID = 100 }),
    GuardianofAzerothBuff                  = Create({ Type = "Spell", ID =  }),
    SiegebreakerBuff                       = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    MeatCleaverBuff                        = Create({ Type = "Spell", ID = 280392 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    SiegebreakerDebuff                     = Create({ Type = "Spell", ID = 280773 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  })
    -- Trinkets
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Create({ Type = "Spell", ID = 302565, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- FURY PRE APL SETUP ------------
------------------------------------------

local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
    -- @return boolean 
    return A.Bloodthirst:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    
    if isStrictlySuperior == nil then
        isStrictlySuperior = false
    end
    
    if isStrictlyInferior == nil then
        isStrictlyInferior = false
    end    
    
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InRange(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            -- Strictly superior than >
            if isStrictlySuperior and not isStrictlyInferior then
                if c > count then
                    return true
                end
            end
            
            -- Stryctly inferior <
            if isStrictlyInferior and not isStrictlySuperior then
                if c < count then
                    return true
                end
            end
            
            -- Classic >=
            if not isStrictlyInferior and not isStrictlySuperior then
                if c >= count then 
                    return true 
                end 
            end
        end 
        
    end
    
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    (
        (A.IsInPvP and Unit(unit):IsControlAble("stun", 0)) 
        or
        not A.IsInPvP        
    ) 
    and A.StormboltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if    A.StormboltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormboltGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then 
            -- Pummel        
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
            -- Stormbolt
            if A.Stormbolt:IsReady(unit, nil, nil, true) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.Stormbolt:Show(icon)                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

local function SelfDefensives()
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    -- Enraged Regeneration
    local EnragedRegeneration = A.GetToggle(2, "EnragedRegeneration")
    if     EnragedRegeneration >= 0 and A.EnragedRegeneration:IsReady(player) and 
    (
        (   -- Auto 
            EnragedRegeneration >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
        or 
        (   -- Custom
            EnragedRegeneration < 100 and 
            Unit(player):HealthPercent() <= EnragedRegeneration
        )
    ) 
    then 
        return A.EnragedRegeneration
    end 
    
    -- Rallying Cry
    local RallyingCry = A.GetToggle(2, "RallyingCry")
    if     RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
        or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(player):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
    
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Pummel:IsReadyByPassCastGCD(unit) or not A.Pummel:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
	    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
    
	if castRemainsTime >= A.GetLatency() then
        -- Pummel
        if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            return A.Pummel
        end 
    
        -- Stormbolt
        if useCC and A.Stormbolt:IsReady(unit) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then
            return A.Stormbolt              
        end  
    
        -- IntimidatingShout
        if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear", 0) then 
            return A.IntimidatingShout              
        end  
		    
   	    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
   	        return A.QuakingPalm
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial(unit) then 
            return A.Haymaker
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial(unit) then 
            return A.WarStomp
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial(unit) then 
            return A.BullRush
   	    end 
    end
end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local DBM = Action.GetToggle(1, "DBM")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
        
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- recklessness
            if A.Recklessness:IsReady(unit) and Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true) and A.BurstIsON(unit) then
                return A.Recklessness:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
        end
        
        --Movement
        local function Movement(unit)
        
            -- heroic_leap
            if A.HeroicLeap:IsReady(unit) then
                return A.HeroicLeap:Show(icon)
            end
            
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
        
            -- siegebreaker
            if A.Siegebreaker:IsReady(unit) and A.BurstIsON(unit) then
                return A.Siegebreaker:Show(icon)
            end
            
            -- rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
            if A.Rampage:IsReady(unit) and ((Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) or (A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < GetGCD() or Player:Rage() > 90) or A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < GetGCD() or Player:Rage() > 90))) then
                return A.Rampage:Show(icon)
            end
            
            -- execute
            if A.Execute:IsReady(unit) then
                return A.Execute:Show(icon)
            end
            
            -- furious_slash,if=!buff.bloodlust.up&buff.furious_slash.remains<3
            if A.FuriousSlash:IsReady(unit) and (not Unit("player"):HasHeroism and Unit("player"):HasBuffs(A.FuriousSlashBuff.ID, true) < 3) then
                return A.FuriousSlash:Show(icon)
            end
            
            -- bladestorm,if=prev_gcd.1.rampage
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Player:PrevGCD(1, A.Rampage)) then
                return A.Bladestorm:Show(icon)
            end
            
            -- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
            if A.Bloodthirst:IsReady(unit) and (Unit("player"):HasBuffsDown(A.EnrageBuff.ID, true) or A.ColdSteelHotBlood:GetAzeriteRank() > 1) then
                return A.Bloodthirst:Show(icon)
            end
            
            -- dragon_roar,if=buff.enrage.up
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true)) then
                return A.DragonRoar:Show(icon)
            end
            
            -- raging_blow,if=charges=2
            if A.RagingBlow:IsReady(unit) and (A.RagingBlow:GetSpellCharges() == 2) then
                return A.RagingBlow:Show(icon)
            end
            
            -- bloodthirst
            if A.Bloodthirst:IsReady(unit) then
                return A.Bloodthirst:Show(icon)
            end
            
            -- raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90)
            if A.RagingBlow:IsReady(unit) and (A.Carnage:IsSpellLearned() or (A.Massacre:IsSpellLearned() and Player:Rage() < 80) or (A.FrothingBerserker:IsSpellLearned() and Player:Rage() < 90)) then
                return A.RagingBlow:Show(icon)
            end
            
            -- furious_slash,if=talent.furious_slash.enabled
            if A.FuriousSlash:IsReady(unit) and (A.FuriousSlash:IsSpellLearned()) then
                return A.FuriousSlash:Show(icon)
            end
            
            -- whirlwind
            if A.Whirlwind:IsReady(unit) then
                return A.Whirlwind:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- charge
            if A.Charge:IsReady(unit) then
                return A.Charge:Show(icon)
            end
            
            -- run_action_list,name=movement,if=movement.distance>5
            if (Unit(unit):GetRange() > 5) then
                return Movement(unit);
            end
            
            -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
            if A.HeroicLeap:IsReady(unit) and ((raid_event.movement.distance > 25 and IncomingAddsIn > 45)) then
                return A.HeroicLeap:Show(icon)
            end
            
            -- potion,if=buff.guardian_of_azeroth.up|(!essence.condensed_lifeforce.major&target.time_to_die=60)
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or (not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit(unit):TimeToDie() == 60)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- rampage,if=cooldown.recklessness.remains<3
            if A.Rampage:IsReady(unit) and (A.Recklessness:GetCooldown() < 3) then
                return A.Rampage:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.recklessness.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- reaping_flames,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.ReapingFlames:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- guardian_of_azeroth,if=!buff.recklessness.up&(target.time_to_die>195|target.health.pct<20)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and (Unit(unit):TimeToDie() > 195 or Unit(unit):HealthPercent() < 20)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=!buff.recklessness.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>1|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
            if A.Recklessness:IsReady(unit) and A.BurstIsON(unit) and (not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or A.GuardianofAzeroth:GetCooldown() > 1 or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or A.BloodoftheEnemy:GetCooldown() < GetGCD()) then
                return A.Recklessness:Show(icon)
            end
            
            -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
            if A.Whirlwind:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true)) then
                return A.Whirlwind:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=target.time_to_die<20|!debuff.razor_coral_debuff.up|(target.health.pct<30.1&debuff.conductive_ink_debuff.up)|(!debuff.conductive_ink_debuff.up&buff.memory_of_lucid_dreams.up|prev_gcd.2.guardian_of_azeroth|prev_gcd.2.recklessness&(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major))
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):TimeToDie() < 20 or not Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) or (Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true)) or (not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Player:PrevGCD(2, A.GuardianofAzeroth) or Player:PrevGCD(2, A.Recklessness) and (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- blood_fury,if=buff.recklessness.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=buff.recklessness.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment,if=buff.recklessness.down&debuff.siegebreaker.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.SiegebreakerDebuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=buff.recklessness.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=buff.recklessness.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.recklessness.down&debuff.siegebreaker.down&buff.enrage.up
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.SiegebreakerDebuff.ID, true) and Unit("player"):HasBuffs(A.EnrageBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- run_action_list,name=single_target
            return SingleUnitunit(unit);
            
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
--[[local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end]]--

