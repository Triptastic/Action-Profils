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

Action[ACTION_CONST_MONK_WINDWALKER] = {
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
    ChiBurst                               = Create({ Type = "Spell", ID = 123986 }),
    SerenityBuff                           = Create({ Type = "Spell", ID = 152173 }),
    Serenity                               = Create({ Type = "Spell", ID = 152173 }),
    FistoftheWhiteTiger                    = Create({ Type = "Spell", ID = 261947 }),
    ChiWave                                = Create({ Type = "Spell", ID = 115098 }),
    EnergizingElixer                       = Create({ Type = "Spell", ID =  }),
    WhirlingDragonPunch                    = Create({ Type = "Spell", ID = 152175 }),
    EnergizingElixir                       = Create({ Type = "Spell", ID = 115288 }),
    TigerPalm                              = Create({ Type = "Spell", ID = 100780 }),
    SpinningCraneKick                      = Create({ Type = "Spell", ID = 101546 }),
    DanceofChijiBuff                       = Create({ Type = "Spell", ID =  }),
    DanceofChijiAzeriteBuff                = Create({ Type = "Spell", ID =  }),
    FistsofFury                            = Create({ Type = "Spell", ID = 113656 }),
    StormEarthandFireBuff                  = Create({ Type = "Spell", ID = 137639 }),
    RisingSunKick                          = Create({ Type = "Spell", ID = 107428 }),
    MarkoftheCraneDebuff                   = Create({ Type = "Spell", ID = 228287 }),
    RushingJadeWind                        = Create({ Type = "Spell", ID = 261715 }),
    RushingJadeWindBuff                    = Create({ Type = "Spell", ID = 261715 }),
    ExpelHarm                              = Create({ Type = "Spell", ID =  }),
    ConflictandStrife                      = Create({ Type = "Spell", ID =  }),
    HitCombo                               = Create({ Type = "Spell", ID = 196741 }),
    FlyingSerpentKick                      = Create({ Type = "Spell", ID = 101545 }),
    BokProcBuff                            = Create({ Type = "Spell", ID = 116768 }),
    BlackoutKick                           = Create({ Type = "Spell", ID = 100784 }),
    InvokeXuentheWhiteTiger                = Create({ Type = "Spell", ID = 123904 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    TouchofDeath                           = Create({ Type = "Spell", ID = 115080 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    StormEarthandFire                      = Create({ Type = "Spell", ID = 137639 }),
    SeethingRageBuff                       = Create({ Type = "Spell", ID =  }),
    TouchofKarma                           = Create({ Type = "Spell", ID = 122470 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    ChiEnergyBuff                          = Create({ Type = "Spell", ID =  }),
    SpearHandStrike                        = Create({ Type = "Spell", ID = 116705 })
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

-- To create covenant use next code:
A:CreateCovenantsFor(ACTION_CONST_MONK_WINDWALKER)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MONK_WINDWALKER], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarXuenOnUseTrinket = 0;
local VarHoldXuen = 0;
local VarSerenityBurst = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarXuenOnUseTrinket = 0
  VarHoldXuen = 0
  VarSerenityBurst = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
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


local function EvaluateTargetIfFilterRisingSunKick43(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick58(unit)
  return (A.WhirlingDragonPunch:IsSpellLearned() and A.RisingSunKick:BaseDuration() > A.WhirlingDragonPunch:GetCooldown() + 3) and (A.FistsofFury:GetCooldown() > 3 or Player:Chi() >= 5)
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger80(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger87(unit)
  return Player:ChiMax() - Player:Chi() >= 3
end


local function EvaluateTargetIfFilterTigerPalm93(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm102(unit)
  return Player:ChiMax() - Player:Chi() >= 2 and (not A.HitCombo:IsSpellLearned() or combo_strike)
end


local function EvaluateTargetIfFilterBlackoutKick114(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick129(unit)
  return combo_strike and (Unit("player"):HasBuffs(A.BokProcBuff.ID, true) or A.HitCombo:IsSpellLearned() and Player:PrevGCD(1, A.TigerPalm) and (Player:ChiMax() - Player:Chi() >= 14 and energy.time_to_50 < 1 or Player:Chi() == 2 and A.FistsofFury:GetCooldown() < 3))
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger301(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFilterTigerPalm316(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm323(unit)
  return combo_strike and Player:ChiMax() - Player:Chi() >= 2
end


local function EvaluateTargetIfFilterTigerPalm335(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm342(unit)
  return Player:ChiMax() - Player:Chi() >= 2
end


local function EvaluateTargetIfFilterRisingSunKick374(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick381(unit)
  return combo_strike
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger395(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger402(unit)
  return Player:Chi() < 3
end


local function EvaluateTargetIfFilterBlackoutKick408(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick417(unit)
  return combo_strike or not A.HitCombo:IsSpellLearned()
end


local function EvaluateTargetIfFilterRisingSunKick439(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick450(unit)
  return A.Serenity:GetCooldown() > 1 or not A.Serenity:IsSpellLearned()
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger472(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger479(unit)
  return Player:Chi() < 3
end


local function EvaluateTargetIfFilterTigerPalm489(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm498(unit)
  return combo_strike and Player:ChiMax() - Player:Chi() >= 2 and Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true)
end


local function EvaluateTargetIfFilterBlackoutKick530(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick555(unit)
  return combo_strike and (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 3 or A.RisingSunKick:GetCooldown() > 1 and A.FistsofFury:GetCooldown() > 1 or A.RisingSunKick:GetCooldown() < 3 and A.FistsofFury:GetCooldown() > 3 and Player:Chi() > 2 or A.RisingSunKick:GetCooldown() > 3 and A.FistsofFury:GetCooldown() < 3 and Player:Chi() > 3 or Player:Chi() > 5 or Unit("player"):HasBuffs(A.BokProcBuff.ID, true))
end


local function EvaluateTargetIfFilterTigerPalm561(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm568(unit)
  return combo_strike and Player:ChiMax() - Player:Chi() >= 2
end


local function EvaluateTargetIfFilterBlackoutKick576(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick587(unit)
  return combo_strike and A.FistsofFury:GetCooldown() < 3 and Player:Chi() == 2 and Player:PrevGCD(1, A.TigerPalm) and energy.time_to_50 < 1
end


local function EvaluateTargetIfFilterBlackoutKick593(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick602(unit)
  return combo_strike and Player:EnergyTimeToMaxPredicted() < 2 and (Player:ChiMax() - Player:Chi() <= 1 or Player:PrevGCD(1, A.TigerPalm))
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger632(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger641(unit)
  return Player:ChiMax() - Player:Chi() >= 3 and (Player:EnergyTimeToMaxPredicted() < 1 or Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)
end


local function EvaluateTargetIfFilterTigerPalm655(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm666(unit)
  return combo_strike and Player:ChiMax() - Player:Chi() >= 2 and (Player:EnergyTimeToMaxPredicted() < 1 or A.Serenity:GetCooldown() < 2 or Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)
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
            -- potion
            if A.ProlongedPower:IsReady(unit) and Potion then
                return A.ProlongedPower:Show(icon)
            end
            
            -- variable,name=xuen_on_use_trinket,op=set,value=0
            VarXuenOnUseTrinket = 0
            
            -- chi_burst,if=!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled
            if A.ChiBurst:IsReady(unit) and (not A.Serenity:IsSpellLearned() or not A.FistoftheWhiteTiger:IsSpellLearned()) then
                return A.ChiBurst:Show(icon)
            end
            
            -- chi_wave,if=!talent.energizing_elixer.enabled
            if A.ChiWave:IsReady(unit) and (not A.EnergizingElixer:IsSpellLearned()) then
                return A.ChiWave:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- whirling_dragon_punch
            if A.WhirlingDragonPunch:IsReady(unit) then
                return A.WhirlingDragonPunch:Show(icon)
            end
            
            -- energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (Player:ChiMax() - Player:Chi() >= 2 and Player:EnergyTimeToMaxPredicted() > 3 or Player:ChiMax() - Player:Chi() >= 4 and (Player:EnergyTimeToMaxPredicted() > 2 or not Player:PrevGCD(1, A.TigerPalm))) then
                return A.EnergizingElixir:Show(icon)
            end
            
            -- spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and (Unit("player"):HasBuffs(A.DanceofChijiBuff.ID, true) or Unit("player"):HasBuffs(A.DanceofChijiAzeriteBuff.ID, true))) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- fists_of_fury,if=energy.time_to_max>execute_time-1|buff.storm_earth_and_fire.remains
            if A.FistsofFury:IsReady(unit) and (Player:EnergyTimeToMaxPredicted() > A.FistsofFury:GetSpellCastTime() - 1 or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true)) then
                return A.FistsofFury:Show(icon)
            end
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.rising_sun_kick.duration>cooldown.whirling_dragon_punch.remains+3)&(cooldown.fists_of_fury.remains>3|chi>=5)
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick43, EvaluateTargetIfRisingSunKick58) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true)) then
                return A.RushingJadeWind:Show(icon)
            end
            
            -- spinning_crane_kick,if=combo_strike&((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2)|energy.time_to_max<=3)
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and ((Player:Chi() > 3 or A.FistsofFury:GetCooldown() > 6) and (Player:Chi() >= 5 or A.FistsofFury:GetCooldown() > 2) or Player:EnergyTimeToMaxPredicted() <= 3)) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
            if A.ExpelHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 1 + Azerite:EssenceHasMajor(A.ConflictandStrife.ID)) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- chi_burst,if=chi.max-chi>=1
            if A.ChiBurst:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 1) then
                return A.ChiBurst:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger80, EvaluateTargetIfFistoftheWhiteTiger87) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|combo_strike)
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm93, EvaluateTargetIfTigerPalm102) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- chi_wave,if=combo_strike
            if A.ChiWave:IsReady(unit) and (combo_strike) then
                return A.ChiWave:Show(icon)
            end
            
            -- flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BokProcBuff.ID, true)) then
                return A.FlyingSerpentKick:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(buff.bok_proc.up|talent.hit_combo.enabled&prev_gcd.1.tiger_palm&(chi.max-chi>=14&energy.time_to_50<1|chi=2&cooldown.fists_of_fury.remains<3))
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick114, EvaluateTargetIfBlackoutKick129) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
        end
        
        --CdSef
        local function CdSef(unit)
        
            -- invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) and (not VarHoldXuen or fight_remains < 25) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            
            -- arcane_torrent,if=chi.max-chi>=1
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:ChiMax() - Player:Chi() >= 1) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- touch_of_death,if=buff.storm_earth_and_fire.down
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true)) then
                return A.TouchofDeath:Show(icon)
            end
            
            -- blood_of_the_enemy,if=cooldown.fists_of_fury.remains<2|fight_remains<12
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.FistsofFury:GetCooldown() < 2 or fight_remains < 12) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&((!talent.whirling_dragon_punch.enabled|cooldown.whirling_dragon_punch.remains)&cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains&buff.storm_earth_and_fire.down)|fight_remains<8
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and ((not A.WhirlingDragonPunch:IsSpellLearned() or A.WhirlingDragonPunch:GetCooldown()) and A.RisingSunKick:GetCooldown() and A.FistsofFury:GetCooldown() and Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true)) or fight_remains < 8) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20
            if A.ReapingFlames:IsReady(unit) and (target.time_to_pct_20 > 30 or Unit(unit):HealthPercent() <= 20) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=energy<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyPredicted() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|fight_remains<20|buff.seething_rage.up|(cooldown.blood_of_the_enemy.remains+1>cooldown.storm_earth_and_fire.full_recharge_time|!essence.blood_of_the_enemy.major)&cooldown.fists_of_fury.remains<10&chi>=2&cooldown.whirling_dragon_punch.remains<12
            if A.StormEarthandFire:IsReady(unit) and A.BurstIsON(unit) and (A.StormEarthandFire:GetSpellCharges() == 2 or fight_remains < 20 or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or (A.BloodoftheEnemy:GetCooldown() + 1 > A.StormEarthandFire:FullRechargeTimeP() or not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID)) and A.FistsofFury:GetCooldown() < 10 and Player:Chi() >= 2 and A.WhirlingDragonPunch:GetCooldown() < 12) then
                return A.StormEarthandFire:Show(icon)
            end
            
            -- use_item,name=corrupted_gladiators_medallion
            if A.CorruptedGladiatorsMedallion:IsReady(unit) then
                return A.CorruptedGladiatorsMedallion:Show(icon)
            end
            
            -- touch_of_karma,interval=90,pct_health=0.5
            if A.TouchofKarma:IsReady(unit) then
                return A.TouchofKarma:Show(icon)
            end
            
            -- blood_fury,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 125 or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or fight_remains < 20) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 185 or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or fight_remains < 20) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 125 or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or fight_remains < 20) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 185 or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or fight_remains < 20) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.storm_earth_and_fire.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
        end
        
        --CdSerenity
        local function CdSerenity(unit)
        
            -- variable,name=serenity_burst,op=set,value=cooldown.serenity.remains<1|fight_remains<20
            VarSerenityBurst = num(A.Serenity:GetCooldown() < 1 or fight_remains < 20)
            
            -- invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) and (not VarHoldXuen or fight_remains < 25) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            
            -- guardian_of_azeroth,if=fight_remains>185|variable.serenity_burst|fight_remains<35
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (fight_remains > 185 or VarSerenityBurst or fight_remains < 35) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- worldvein_resonance,if=variable.serenity_burst
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (VarSerenityBurst) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- blood_of_the_enemy,if=variable.serenity_burst
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (VarSerenityBurst) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- concentrated_flame,if=(cooldown.serenity.remains|cooldown.concentrated_flame.charges=2)&!dot.concentrated_flame_burn.remains&(cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains|fight_remains<8)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((A.Serenity:GetCooldown() or A.ConcentratedFlame:GetSpellCharges() == 2) and not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and (A.RisingSunKick:GetCooldown() and A.FistsofFury:GetCooldown() or fight_remains < 8)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20|target.time_to_die<2
            if A.ReapingFlames:IsReady(unit) and (target.time_to_pct_20 > 30 or Unit(unit):HealthPercent() <= 20 or Unit(unit):TimeToDie() < 2) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=energy<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyPredicted() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- blood_fury,if=fight_remains>125|variable.serenity_burst
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 125 or VarSerenityBurst) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=fight_remains>185|variable.serenity_burst
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 185 or VarSerenityBurst) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_torrent,if=chi.max-chi>=1
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:ChiMax() - Player:Chi() >= 1) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=fight_remains>125|variable.serenity_burst
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 125 or VarSerenityBurst) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=fight_remains>125|variable.serenity_burst
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (fight_remains > 125 or VarSerenityBurst) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks,if=variable.serenity_burst
            if A.BagofTricks:IsReady(unit) and (VarSerenityBurst) then
                return A.BagofTricks:Show(icon)
            end
            
            -- use_item,name=corrupted_gladiators_medallion
            if A.CorruptedGladiatorsMedallion:IsReady(unit) then
                return A.CorruptedGladiatorsMedallion:Show(icon)
            end
            
            -- touch_of_death
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) then
                return A.TouchofDeath:Show(icon)
            end
            
            -- touch_of_karma,interval=90,pct_health=0.5
            if A.TouchofKarma:IsReady(unit) then
                return A.TouchofKarma:Show(icon)
            end
            
            -- serenity,if=cooldown.rising_sun_kick.remains<2|fight_remains<15
            if A.Serenity:IsReady(unit) and A.BurstIsON(unit) and (A.RisingSunKick:GetCooldown() < 2 or fight_remains < 15) then
                return A.Serenity:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
        end
        
        --Opener
        local function Opener(unit)
        
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger301) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- expel_harm,if=talent.chi_burst.enabled
            if A.ExpelHarm:IsReady(unit) and (A.ChiBurst:IsSpellLearned()) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm316, EvaluateTargetIfTigerPalm323) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- expel_harm,if=chi.max-chi=3|chi.max-chi=1
            if A.ExpelHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() == 3 or Player:ChiMax() - Player:Chi() == 1) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- flying_serpent_kick,if=talent.hit_combo.enabled
            if A.FlyingSerpentKick:IsReady(unit) and (A.HitCombo:IsSpellLearned()) then
                return A.FlyingSerpentKick:Show(icon)
            end
            
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm335, EvaluateTargetIfTigerPalm342) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
        end
        
        --Serenity
        local function Serenity(unit)
        
            -- fists_of_fury,if=buff.serenity.remains<1|active_enemies>1
            if A.FistsofFury:IsReady(unit) and (Unit("player"):HasBuffs(A.SerenityBuff.ID, true) < 1 or MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) then
                return A.FistsofFury:Show(icon)
            end
            
            -- spinning_crane_kick,if=combo_strike&(active_enemies>2|active_enemies>1&!cooldown.rising_sun_kick.up)
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2 or MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not A.RisingSunKick:GetCooldown() == 0)) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick374, EvaluateTargetIfRisingSunKick381) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and (Unit("player"):HasBuffs(A.DanceofChijiBuff.ID, true) or Unit("player"):HasBuffs(A.DanceofChijiAzeriteBuff.ID, true))) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- fists_of_fury,interrupt_if=gcd.remains=0
            if A.FistsofFury:IsReady(unit) then
                return A.FistsofFury:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger395, EvaluateTargetIfFistoftheWhiteTiger402) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike|!talent.hit_combo.enabled
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick408, EvaluateTargetIfBlackoutKick417) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
            -- spinning_crane_kick
            if A.SpinningCraneKick:IsReady(unit) then
                return A.SpinningCraneKick:Show(icon)
            end
            
        end
        
        --St
        local function St(unit)
        
            -- whirling_dragon_punch
            if A.WhirlingDragonPunch:IsReady(unit) then
                return A.WhirlingDragonPunch:Show(icon)
            end
            
            -- energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (Player:ChiMax() - Player:Chi() >= 2 and Player:EnergyTimeToMaxPredicted() > 3 or Player:ChiMax() - Player:Chi() >= 4 and (Player:EnergyTimeToMaxPredicted() > 2 or not Player:PrevGCD(1, A.TigerPalm))) then
                return A.EnergizingElixir:Show(icon)
            end
            
            -- spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and (Unit("player"):HasBuffs(A.DanceofChijiBuff.ID, true) or Unit("player"):HasBuffs(A.DanceofChijiAzeriteBuff.ID, true))) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- fists_of_fury
            if A.FistsofFury:IsReady(unit) then
                return A.FistsofFury:Show(icon)
            end
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=cooldown.serenity.remains>1|!talent.serenity.enabled
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick439, EvaluateTargetIfRisingSunKick450) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if A.RushingJadeWind:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) then
                return A.RushingJadeWind:Show(icon)
            end
            
            -- expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
            if A.ExpelHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 1 + Azerite:EssenceHasMajor(A.ConflictandStrife.ID)) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger472, EvaluateTargetIfFistoftheWhiteTiger479) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- chi_burst,if=chi.max-chi>=1
            if A.ChiBurst:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 1) then
                return A.ChiBurst:Show(icon)
            end
            
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&buff.storm_earth_and_fire.down
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm489, EvaluateTargetIfTigerPalm498) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies&combo_strike&buff.storm_earth_and_fire.down&(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>3|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4|chi.max-chi<=1&energy.time_to_max<2)|buff.chi_energy.stack>10&fight_remains<7
            if A.SpinningCraneKick:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ChiEnergyBuff.ID, true) > 30 - 5 * MultiUnits:GetByRangeInCombat(8, 5, 10) and combo_strike and Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true) and (A.RisingSunKick:GetCooldown() > 2 and A.FistsofFury:GetCooldown() > 2 or A.RisingSunKick:GetCooldown() < 3 and A.FistsofFury:GetCooldown() > 3 and Player:Chi() > 3 or A.RisingSunKick:GetCooldown() > 3 and A.FistsofFury:GetCooldown() < 3 and Player:Chi() > 4 or Player:ChiMax() - Player:Chi() <= 1 and Player:EnergyTimeToMaxPredicted() < 2) or Unit("player"):HasBuffsStacks(A.ChiEnergyBuff.ID, true) > 10 and fight_remains < 7) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(talent.serenity.enabled&cooldown.serenity.remains<3|cooldown.rising_sun_kick.remains>1&cooldown.fists_of_fury.remains>1|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>2|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>3|chi>5|buff.bok_proc.up)
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick530, EvaluateTargetIfBlackoutKick555) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm561, EvaluateTargetIfTigerPalm568) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- flying_serpent_kick,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) then
                return A.FlyingSerpentKick:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&cooldown.fists_of_fury.remains<3&chi=2&prev_gcd.1.tiger_palm&energy.time_to_50<1
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick576, EvaluateTargetIfBlackoutKick587) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&energy.time_to_max<2&(chi.max-chi<=1|prev_gcd.1.tiger_palm)
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick593, EvaluateTargetIfBlackoutKick602) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- spear_hand_strike,if=target.debuff.casting.react
            if A.SpearHandStrike:IsReady(unit) and Action.GetToggle.InterruptEnabled and (Unit(unit):IsCasting) then
                return A.SpearHandStrike:Show(icon)
            end
            
            -- variable,name=hold_xuen,op=set,value=cooldown.invoke_xuen_the_white_tiger.remains>fight_remains|fight_remains<120&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>10
            VarHoldXuen = num(A.InvokeXuentheWhiteTiger:GetCooldown() > fight_remains or fight_remains < 120 and fight_remains > A.Serenity:GetCooldown() and A.Serenity:GetCooldown() > 10)
            
            -- potion,if=(buff.serenity.up|buff.storm_earth_and_fire.up)&pet.xuen_the_white_tiger.active|fight_remains<=60
            if A.ProlongedPower:IsReady(unit) and Potion and ((Unit("player"):HasBuffs(A.SerenityBuff.ID, true) or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true)) and pet.xuen_the_white_tiger.active or fight_remains <= 60) then
                return A.ProlongedPower:Show(icon)
            end
            
            -- call_action_list,name=serenity,if=buff.serenity.up
            if (Unit("player"):HasBuffs(A.SerenityBuff.ID, true)) then
                if Serenity(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
            if (Unit("player"):CombatTime() < 5 and Player:Chi() < 5 and not pet.xuen_the_white_tiger.active) then
                if Opener(unit) then
                    return true
                end
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3&(energy.time_to_max<1|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger632, EvaluateTargetIfFistoftheWhiteTiger641) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
            if A.ExpelHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 1 + Azerite:EssenceHasMajor(A.ConflictandStrife.ID) and (Player:EnergyTimeToMaxPredicted() < 1 or A.Serenity:GetCooldown() < 2 or Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm655, EvaluateTargetIfTigerPalm666) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- call_action_list,name=cd_sef,if=!talent.serenity.enabled
            if (not A.Serenity:IsSpellLearned()) then
                if CdSef(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cd_serenity,if=talent.serenity.enabled
            if (A.Serenity:IsSpellLearned()) then
                if CdSerenity(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=st,if=active_enemies<3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                if St(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=aoe,if=active_enemies>=3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                if Aoe(unit) then
                    return true
                end
            end
            
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

