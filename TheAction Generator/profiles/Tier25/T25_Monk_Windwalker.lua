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
    SerenityBuff                           = Create({ Type = "Spell", ID = 152173 }),
    Serenity                               = Create({ Type = "Spell", ID = 152173 }),
    ChiBurst                               = Create({ Type = "Spell", ID = 123986 }),
    FistoftheWhiteTiger                    = Create({ Type = "Spell", ID = 261947 }),
    ChiWave                                = Create({ Type = "Spell", ID = 115098 }),
    ConflictandStrife                      = Create({ Type = "Spell", ID =  }),
    InvokeXuentheWhiteTiger                = Create({ Type = "Spell", ID = 123904 }),
    WhirlingDragonPunch                    = Create({ Type = "Spell", ID = 152175 }),
    EnergizingElixir                       = Create({ Type = "Spell", ID = 115288 }),
    TigerPalm                              = Create({ Type = "Spell", ID = 100780 }),
    FistsofFury                            = Create({ Type = "Spell", ID = 113656 }),
    RisingSunKick                          = Create({ Type = "Spell", ID = 107428 }),
    MarkoftheCraneDebuff                   = Create({ Type = "Spell", ID = 228287 }),
    RushingJadeWind                        = Create({ Type = "Spell", ID = 261715 }),
    RushingJadeWindBuff                    = Create({ Type = "Spell", ID = 261715 }),
    SpinningCraneKick                      = Create({ Type = "Spell", ID = 101546 }),
    DanceofChijiBuff                       = Create({ Type = "Spell", ID =  }),
    ReverseHarm                            = Create({ Type = "Spell", ID =  }),
    HitCombo                               = Create({ Type = "Spell", ID = 196741 }),
    FlyingSerpentKick                      = Create({ Type = "Spell", ID = 101545 }),
    BokProcBuff                            = Create({ Type = "Spell", ID = 116768 }),
    BlackoutKick                           = Create({ Type = "Spell", ID = 100784 }),
    TouchofDeath                           = Create({ Type = "Spell", ID = 115080 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    StormEarthandFire                      = Create({ Type = "Spell", ID = 137639 }),
    TouchofDeathDebuff                     = Create({ Type = "Spell", ID =  }),
    WorldveinResonanceBuff                 = Create({ Type = "Spell", ID =  }),
    TouchofKarma                           = Create({ Type = "Spell", ID = 122470 }),
    StormEarthandFireBuff                  = Create({ Type = "Spell", ID = 137639 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    SpearHandStrike                        = Create({ Type = "Spell", ID = 116705 }),
    SeethingRageBuff                       = Create({ Type = "Spell", ID =  })
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
local VarTodOnUseTrinket = 0;
local VarFontofPowerPrecombatChannel = 0;
local VarHoldTod = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarTodOnUseTrinket = 0
  VarFontofPowerPrecombatChannel = 0
  VarHoldTod = 0
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


local function EvaluateTargetIfFilterRisingSunKick59(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick74(unit)
  return (A.WhirlingDragonPunch:IsSpellLearned() and A.RisingSunKick:BaseDuration() > A.WhirlingDragonPunch:GetCooldown() + 4) and (A.FistsofFury:GetCooldown() > 3 or Player:Chi() >= 5)
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger96(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger103(unit)
  return Player:ChiMax() - Player:Chi() >= 3
end


local function EvaluateTargetIfFilterTigerPalm109(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm118(unit)
  return Player:ChiMax() - Player:Chi() >= 2 and (not A.HitCombo:IsSpellLearned() or not combo_break)
end


local function EvaluateTargetIfFilterBlackoutKick130(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick143(unit)
  return combo_strike and (Unit("player"):HasBuffs(A.BokProcBuff.ID, true) or (A.HitCombo:IsSpellLearned() and Player:PrevGCD(1, A.TigerPalm) and Player:Chi() < 4))
end


local function EvaluateTargetIfFilterRisingSunKick561(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick568(unit)
  return combo_strike
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger576(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger583(unit)
  return Player:Chi() < 3
end


local function EvaluateTargetIfFilterBlackoutKick591(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick600(unit)
  return combo_strike or not A.HitCombo:IsSpellLearned()
end


local function EvaluateTargetIfFilterRisingSunKick618(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick631(unit)
  return A.Serenity:IsSpellLearned() or A.TouchofDeath:GetCooldown() > 2 or VarHoldTod
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger651(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger658(unit)
  return Player:Chi() < 3
end


local function EvaluateTargetIfFilterTigerPalm674(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm685(unit)
  return combo_strike and Player:ChiMax() - Player:Chi() > 3 and not Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) and Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true)
end


local function EvaluateTargetIfFilterBlackoutKick697(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick724(unit)
  return combo_strike and ((A.Serenity:IsSpellLearned() or A.TouchofDeath:GetCooldown() > 2 or VarHoldTod) and (A.RisingSunKick:GetCooldown() > 2 and A.FistsofFury:GetCooldown() > 2 or A.RisingSunKick:GetCooldown() < 3 and A.FistsofFury:GetCooldown() > 3 and Player:Chi() > 2 or A.RisingSunKick:GetCooldown() > 3 and A.FistsofFury:GetCooldown() < 3 and Player:Chi() > 4 or Player:Chi() > 5) or Unit("player"):HasBuffs(A.BokProcBuff.ID, true))
end


local function EvaluateTargetIfFilterTigerPalm730(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm737(unit)
  return combo_strike and Player:ChiMax() - Player:Chi() > 1
end


local function EvaluateTargetIfFilterBlackoutKick745(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick756(unit)
  return combo_strike and (A.FistsofFury:GetCooldown() < 3 and Player:Chi() == 2 or Player:EnergyTimeToMaxPredicted() < 1) and (Player:PrevGCD(1, A.TigerPalm) or Player:ChiMax() - Player:Chi() < 2)
end


local function EvaluateTargetIfFilterFistoftheWhiteTiger810(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFistoftheWhiteTiger833(unit)
  return Player:ChiMax() - Player:Chi() >= 3 and Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and Unit("player"):HasBuffsDown(A.SeethingRageBuff.ID, true) and (Player:EnergyTimeToMaxPredicted() < 1 or A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2 or not A.Serenity:IsSpellLearned() and A.TouchofDeath:GetCooldown() < 3 and not VarHoldTod or Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)
end


local function EvaluateTargetIfFilterTigerPalm839(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm872(unit)
  return not combo_break and Player:ChiMax() - Player:Chi() >= 2 and (A.Serenity:IsSpellLearned() or not Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) and Unit("player"):HasBuffsDown(A.SeethingRageBuff.ID, true) and Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (Player:EnergyTimeToMaxPredicted() < 1 or A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2 or not A.Serenity:IsSpellLearned() and A.TouchofDeath:GetCooldown() < 3 and not VarHoldTod or Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)
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
            
            -- variable,name=tod_on_use_trinket,op=set,value=equipped.cyclotronic_blast|equipped.lustrous_golden_plumage|equipped.gladiators_badge|equipped.gladiators_medallion|equipped.remote_guidance_device
            VarTodOnUseTrinket = num(A.CyclotronicBlast:IsExists() or A.LustrousGoldenPlumage:IsExists() or A.GladiatorsBadge:IsExists() or A.GladiatorsMedallion:IsExists() or A.RemoteGuidanceDevice:IsExists())
            
            -- variable,name=font_of_power_precombat_channel,op=set,value=19,if=!talent.serenity.enabled&(variable.tod_on_use_trinket|equipped.ashvanes_razor_coral)
            if (not A.Serenity:IsSpellLearned() and (VarTodOnUseTrinket or A.AshvanesRazorCoral:IsExists())) then
                VarFontofPowerPrecombatChannel = 19
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- chi_burst,if=!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled
            if A.ChiBurst:IsReady(unit) and (not A.Serenity:IsSpellLearned() or not A.FistoftheWhiteTiger:IsSpellLearned()) then
                return A.ChiBurst:Show(icon)
            end
            
            -- chi_wave,if=talent.fist_of_the_white_tiger.enabled|essence.conflict_and_strife.major
            if A.ChiWave:IsReady(unit) and (A.FistoftheWhiteTiger:IsSpellLearned() or Azerite:EssenceHasMajor(A.ConflictandStrife.ID)) then
                return A.ChiWave:Show(icon)
            end
            
            -- invoke_xuen_the_white_tiger
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- whirling_dragon_punch
            if A.WhirlingDragonPunch:IsReady(unit) then
                return A.WhirlingDragonPunch:Show(icon)
            end
            
            -- energizing_elixir,if=!prev_gcd.1.tiger_palm&chi<=1&energy<50
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (not Player:PrevGCD(1, A.TigerPalm) and Player:Chi() <= 1 and Player:EnergyPredicted() < 50) then
                return A.EnergizingElixir:Show(icon)
            end
            
            -- fists_of_fury,if=energy.time_to_max>1
            if A.FistsofFury:IsReady(unit) and (Player:EnergyTimeToMaxPredicted() > 1) then
                return A.FistsofFury:Show(icon)
            end
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.rising_sun_kick.duration>cooldown.whirling_dragon_punch.remains+4)&(cooldown.fists_of_fury.remains>3|chi>=5)
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick59, EvaluateTargetIfRisingSunKick74) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true)) then
                return A.RushingJadeWind:Show(icon)
            end
            
            -- spinning_crane_kick,if=combo_strike&(((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2))|energy.time_to_max<=3|buff.dance_of_chiji.react)
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and (((Player:Chi() > 3 or A.FistsofFury:GetCooldown() > 6) and (Player:Chi() >= 5 or A.FistsofFury:GetCooldown() > 2)) or Player:EnergyTimeToMaxPredicted() <= 3 or Unit("player"):HasBuffsStacks(A.DanceofChijiBuff.ID, true))) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 2) then
                return A.ReverseHarm:Show(icon)
            end
            
            -- chi_burst,if=chi.max-chi>=3
            if A.ChiBurst:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 3) then
                return A.ChiBurst:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger96, EvaluateTargetIfFistoftheWhiteTiger103) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|!combo_break)
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm109, EvaluateTargetIfTigerPalm118) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- chi_wave,if=!combo_break
            if A.ChiWave:IsReady(unit) and (not combo_break) then
                return A.ChiWave:Show(icon)
            end
            
            -- flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BokProcBuff.ID, true)) then
                return A.FlyingSerpentKick:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(buff.bok_proc.up|(talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi<4))
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick130, EvaluateTargetIfBlackoutKick143) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
        end
        
        --CdSef
        local function CdSef(unit)
        
            -- invoke_xuen_the_white_tiger,if=buff.serenity.down|fight_remains<25
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) or fight_remains < 25) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            
            -- guardian_of_azeroth,if=fight_remains>185|!variable.hold_tod&cooldown.touch_of_death.remains<=14|fight_remains<36
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (fight_remains > 185 or not VarHoldTod and A.TouchofDeath:GetCooldown() <= 14 or fight_remains < 36) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.touch_of_death.remains>58|cooldown.touch_of_death.remains<2|variable.hold_tod|fight_remains<20
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.TouchofDeath:GetCooldown() > 58 or A.TouchofDeath:GetCooldown() < 2 or VarHoldTod or fight_remains < 20) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:ChiMax() - Player:Chi() >= 1 and Player:EnergyTimeToMaxPredicted() >= 0.5) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- use_item,name=lustrous_golden_plumage,if=cooldown.touch_of_death.remains<1|cooldown.touch_of_death.remains>20|variable.hold_tod|fight_remains<=20
            if A.LustrousGoldenPlumage:IsReady(unit) and (A.TouchofDeath:GetCooldown() < 1 or A.TouchofDeath:GetCooldown() > 20 or VarHoldTod or fight_remains <= 20) then
                return A.LustrousGoldenPlumage:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_medallion,if=cooldown.touch_of_death.remains<1|cooldown.touch_of_death.remains>20|variable.hold_tod|fight_remains<=20
            if A.GladiatorsMedallion:IsReady(unit) and (A.TouchofDeath:GetCooldown() < 1 or A.TouchofDeath:GetCooldown() > 20 or VarHoldTod or fight_remains <= 20) then
                return A.GladiatorsMedallion:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_emblem,if=fight_remains>159|cooldown.touch_of_death.remains<1|variable.hold_tod
            if A.GladiatorsEmblem:IsReady(unit) and (fight_remains > 159 or A.TouchofDeath:GetCooldown() < 1 or VarHoldTod) then
                return A.GladiatorsEmblem:Show(icon)
            end
            
            -- touch_of_death,if=!variable.hold_tod&(!equipped.cyclotronic_blast|cooldown.cyclotronic_blast.remains<=1)&(chi>1|energy<40)
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (not VarHoldTod and (not A.CyclotronicBlast:IsExists() or A.CyclotronicBlast:GetCooldown() <= 1) and (Player:Chi() > 1 or Player:EnergyPredicted() < 40)) then
                return A.TouchofDeath:Show(icon)
            end
            
            -- storm_earth_and_fire,,if=cooldown.storm_earth_and_fire.charges=2|dot.touch_of_death.remains|fight_remains<20|(buff.worldvein_resonance.remains>10|cooldown.worldvein_resonance.remains>cooldown.storm_earth_and_fire.full_recharge_time|!essence.worldvein_resonance.major)&(cooldown.touch_of_death.remains>cooldown.storm_earth_and_fire.full_recharge_time|variable.hold_tod&!equipped.dribbling_inkpod)&cooldown.fists_of_fury.remains<=9&chi>=3&cooldown.whirling_dragon_punch.remains<=13
            if A.StormEarthandFire:IsReady(unit) and A.BurstIsON(unit) and (A.StormEarthandFire:GetSpellCharges() == 2 or Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) or fight_remains < 20 or (Unit("player"):HasBuffs(A.WorldveinResonanceBuff.ID, true) > 10 or A.WorldveinResonance:GetCooldown() > A.StormEarthandFire:FullRechargeTimeP() or not Azerite:EssenceHasMajor(A.WorldveinResonance.ID)) and (A.TouchofDeath:GetCooldown() > A.StormEarthandFire:FullRechargeTimeP() or VarHoldTod and not A.DribblingInkpod:IsExists()) and A.FistsofFury:GetCooldown() <= 9 and Player:Chi() >= 3 and A.WhirlingDragonPunch:GetCooldown() <= 13) then
                return A.StormEarthandFire:Show(icon)
            end
            
            -- touch_of_karma,if=fight_remains>159|dot.touch_of_death.remains|variable.hold_tod
            if A.TouchofKarma:IsReady(unit) and (fight_remains > 159 or Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) or VarHoldTod) then
                return A.TouchofKarma:Show(icon)
            end
            
            -- blood_of_the_enemy,if=cooldown.touch_of_death.remains>45|variable.hold_tod&cooldown.fists_of_fury.remains<2|fight_remains<12|fight_remains>100&fight_remains<110&(cooldown.fists_of_fury.remains<3|cooldown.whirling_dragon_punch.remains<5|cooldown.rising_sun_kick.remains<5)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.TouchofDeath:GetCooldown() > 45 or VarHoldTod and A.FistsofFury:GetCooldown() < 2 or fight_remains < 12 or fight_remains > 100 and fight_remains < 110 and (A.FistsofFury:GetCooldown() < 3 or A.WhirlingDragonPunch:GetCooldown() < 5 or A.RisingSunKick:GetCooldown() < 5)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&((cooldown.concentrated_flame.remains<=cooldown.touch_of_death.remains+1|variable.hold_tod)&(!talent.whirling_dragon_punch.enabled|cooldown.whirling_dragon_punch.remains)&cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains&buff.storm_earth_and_fire.down|dot.touch_of_death.remains)|fight_remains<8
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and ((A.ConcentratedFlame:GetCooldown() <= A.TouchofDeath:GetCooldown() + 1 or VarHoldTod) and (not A.WhirlingDragonPunch:IsSpellLearned() or A.WhirlingDragonPunch:GetCooldown()) and A.RisingSunKick:GetCooldown() and A.FistsofFury:GetCooldown() and Unit("player"):HasBuffsDown(A.StormEarthandFireBuff.ID, true) or Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true)) or fight_remains < 8) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- blood_fury,if=cooldown.touch_of_death.remains>30|variable.hold_tod|fight_remains<20
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.TouchofDeath:GetCooldown() > 30 or VarHoldTod or fight_remains < 20) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=cooldown.touch_of_death.remains>30|variable.hold_tod|fight_remains<15
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.TouchofDeath:GetCooldown() > 30 or VarHoldTod or fight_remains < 15) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=cooldown.touch_of_death.remains>30|variable.hold_tod|fight_remains<10
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.TouchofDeath:GetCooldown() > 30 or VarHoldTod or fight_remains < 10) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=cooldown.touch_of_death.remains>30|variable.hold_tod|fight_remains<20
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.TouchofDeath:GetCooldown() > 30 or VarHoldTod or fight_remains < 20) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- use_item,name=pocketsized_computation_device,,if=cooldown.touch_of_death.remains>30|variable.hold_tod
            if A.PocketsizedComputationDevice:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 30 or VarHoldTod) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
            
            -- use_item,name=remote_guidance_device,if=cooldown.touch_of_death.remains>30|variable.hold_tod
            if A.RemoteGuidanceDevice:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 30 or VarHoldTod) then
                return A.RemoteGuidanceDevice:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_badge,if=cooldown.touch_of_death.remains>20|variable.hold_tod|fight_remains<20
            if A.GladiatorsBadge:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 20 or VarHoldTod or fight_remains < 20) then
                return A.GladiatorsBadge:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=cooldown.touch_of_death.remains>55|variable.hold_tod|fight_remains<12
            if A.GalecallersBoon:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 55 or VarHoldTod or fight_remains < 12) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,name=writhing_segment_of_drestagath,if=cooldown.touch_of_death.remains>20|variable.hold_tod
            if A.WrithingSegmentofDrestagath:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 20 or VarHoldTod) then
                return A.WrithingSegmentofDrestagath:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=variable.tod_on_use_trinket&(cooldown.touch_of_death.remains>21|variable.hold_tod)&(debuff.razor_coral_debuff.down|buff.storm_earth_and_fire.remains>13|fight_remains-cooldown.touch_of_death.remains<40&cooldown.touch_of_death.remains<25|fight_remains<25)
            if A.AshvanesRazorCoral:IsReady(unit) and (VarTodOnUseTrinket and (A.TouchofDeath:GetCooldown() > 21 or VarHoldTod) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) > 13 or fight_remains - A.TouchofDeath:GetCooldown() < 40 and A.TouchofDeath:GetCooldown() < 25 or fight_remains < 25)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=!variable.tod_on_use_trinket&(debuff.razor_coral_debuff.down|(!equipped.dribbling_inkpod|target.time_to_pct_30.remains<8)&(dot.touch_of_death.remains|cooldown.touch_of_death.remains+9>fight_remains)&buff.storm_earth_and_fire.up|fight_remains<25)
            if A.AshvanesRazorCoral:IsReady(unit) and (not VarTodOnUseTrinket and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or (not A.DribblingInkpod:IsExists() or Unit(unit):TimeToDieX(30) < 8) and (Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) or A.TouchofDeath:GetCooldown() + 9 > fight_remains) and Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or fight_remains < 25)) then
                return A.AshvanesRazorCoral:Show(icon)
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
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
        end
        
        --CdSerenity
        local function CdSerenity(unit)
        
            -- invoke_xuen_the_white_tiger,if=buff.serenity.down|fight_remains<25
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) or fight_remains < 25) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=buff.serenity.down&(cooldown.serenity.remains<20|fight_remains<40)
            if A.AzsharasFontofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (A.Serenity:GetCooldown() < 20 or fight_remains < 40)) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- guardian_of_azeroth,if=buff.serenity.down&(fight_remains>185|cooldown.serenity.remains<=7)|fight_remains<35
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (fight_remains > 185 or A.Serenity:GetCooldown() <= 7) or fight_remains < 35) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- blood_fury,if=cooldown.serenity.remains>20|fight_remains<20
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.Serenity:GetCooldown() > 20 or fight_remains < 20) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=cooldown.serenity.remains>20|fight_remains<15
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.Serenity:GetCooldown() > 20 or fight_remains < 15) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_torrent,if=buff.serenity.down&chi.max-chi>=1&energy.time_to_max>=0.5
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and Player:ChiMax() - Player:Chi() >= 1 and Player:EnergyTimeToMaxPredicted() >= 0.5) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=cooldown.serenity.remains>20|fight_remains<10
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.Serenity:GetCooldown() > 20 or fight_remains < 10) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=cooldown.serenity.remains>20|fight_remains<20
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.Serenity:GetCooldown() > 20 or fight_remains < 20) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- use_item,name=lustrous_golden_plumage,if=cooldown.touch_of_death.remains<1|cooldown.touch_of_death.remains>20|variable.hold_tod|fight_remains<=20
            if A.LustrousGoldenPlumage:IsReady(unit) and (A.TouchofDeath:GetCooldown() < 1 or A.TouchofDeath:GetCooldown() > 20 or VarHoldTod or fight_remains <= 20) then
                return A.LustrousGoldenPlumage:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_medallion,if=cooldown.touch_of_death.remains<1|cooldown.touch_of_death.remains>20|variable.hold_tod|fight_remains<=20
            if A.GladiatorsMedallion:IsReady(unit) and (A.TouchofDeath:GetCooldown() < 1 or A.TouchofDeath:GetCooldown() > 20 or VarHoldTod or fight_remains <= 20) then
                return A.GladiatorsMedallion:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_emblem,if=fight_remains>159|cooldown.touch_of_death.remains<1|variable.hold_tod
            if A.GladiatorsEmblem:IsReady(unit) and (fight_remains > 159 or A.TouchofDeath:GetCooldown() < 1 or VarHoldTod) then
                return A.GladiatorsEmblem:Show(icon)
            end
            
            -- touch_of_death,if=!variable.hold_tod
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (not VarHoldTod) then
                return A.TouchofDeath:Show(icon)
            end
            
            -- touch_of_karma,if=fight_remains>159|dot.touch_of_death.remains|variable.hold_tod
            if A.TouchofKarma:IsReady(unit) and (fight_remains > 159 or Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) or VarHoldTod) then
                return A.TouchofKarma:Show(icon)
            end
            
            -- use_item,name=pocketsized_computation_device,if=buff.serenity.down&(cooldown.touch_of_death.remains>10|variable.hold_tod)|fight_remains<5
            if A.PocketsizedComputationDevice:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (A.TouchofDeath:GetCooldown() > 10 or VarHoldTod) or fight_remains < 5) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.serenity.down&(cooldown.serenity.remains>20|cooldown.serenity.remains<2)|fight_remains<15
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (A.Serenity:GetCooldown() > 20 or A.Serenity:GetCooldown() < 2) or fight_remains < 15) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- use_item,name=remote_guidance_device,if=cooldown.touch_of_death.remains>10|variable.hold_tod
            if A.RemoteGuidanceDevice:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 10 or VarHoldTod) then
                return A.RemoteGuidanceDevice:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_badge,if=cooldown.serenity.remains>20|fight_remains<20
            if A.GladiatorsBadge:IsReady(unit) and (A.Serenity:GetCooldown() > 20 or fight_remains < 20) then
                return A.GladiatorsBadge:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=cooldown.serenity.remains>20|fight_remains<20
            if A.GalecallersBoon:IsReady(unit) and (A.Serenity:GetCooldown() > 20 or fight_remains < 20) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,name=writhing_segment_of_drestagath,if=cooldown.touch_of_death.remains>10|variable.hold_tod
            if A.WrithingSegmentofDrestagath:IsReady(unit) and (A.TouchofDeath:GetCooldown() > 10 or VarHoldTod) then
                return A.WrithingSegmentofDrestagath:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|buff.serenity.remains>9|fight_remains<25
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit("player"):HasBuffs(A.SerenityBuff.ID, true) > 9 or fight_remains < 25) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.serenity.down&(cooldown.serenity.remains>15|cooldown.serenity.remains<2)|fight_remains<20
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (A.Serenity:GetCooldown() > 15 or A.Serenity:GetCooldown() < 2) or fight_remains < 20) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- concentrated_flame,if=buff.serenity.down&(cooldown.serenity.remains|cooldown.concentrated_flame.charges=2)&!dot.concentrated_flame_burn.remains&(cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains|fight_remains<8)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (A.Serenity:GetCooldown() or A.ConcentratedFlame:GetSpellCharges() == 2) and not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and (A.RisingSunKick:GetCooldown() and A.FistsofFury:GetCooldown() or fight_remains < 8)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- serenity
            if A.Serenity:IsReady(unit) and A.BurstIsON(unit) then
                return A.Serenity:Show(icon)
            end
            
            -- the_unbound_force,if=buff.serenity.down
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- purifying_blast,if=buff.serenity.down
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- reaping_flames,if=buff.serenity.down&(target.time_to_pct_20>30|target.health.pct<=20)|target.time_to_die<2
            if A.ReapingFlames:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (target.time_to_pct_20 > 30 or Unit(unit):HealthPercent() <= 20) or Unit(unit):TimeToDie() < 2) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- focused_azerite_beam,if=buff.serenity.down
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=buff.serenity.down&energy<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and Player:EnergyPredicted() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- ripple_in_space,if=buff.serenity.down
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.serenity.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
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
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick561, EvaluateTargetIfRisingSunKick568) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- fists_of_fury,interrupt_if=gcd.remains=0
            if A.FistsofFury:IsReady(unit) then
                return A.FistsofFury:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger576, EvaluateTargetIfFistoftheWhiteTiger583) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- reverse_harm,if=chi.max-chi>1&energy.time_to_max<1
            if A.ReverseHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() > 1 and Player:EnergyTimeToMaxPredicted() < 1) then
                return A.ReverseHarm:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike|!talent.hit_combo.enabled
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick591, EvaluateTargetIfBlackoutKick600) then 
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
            
            -- fists_of_fury,if=talent.serenity.enabled|cooldown.touch_of_death.remains>6|variable.hold_tod
            if A.FistsofFury:IsReady(unit) and (A.Serenity:IsSpellLearned() or A.TouchofDeath:GetCooldown() > 6 or VarHoldTod) then
                return A.FistsofFury:Show(icon)
            end
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=talent.serenity.enabled|cooldown.touch_of_death.remains>2|variable.hold_tod
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick618, EvaluateTargetIfRisingSunKick631) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if A.RushingJadeWind:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) then
                return A.RushingJadeWind:Show(icon)
            end
            
            -- reverse_harm,if=chi.max-chi>1
            if A.ReverseHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() > 1) then
                return A.ReverseHarm:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger651, EvaluateTargetIfFistoftheWhiteTiger658) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- energizing_elixir,if=chi<=3&energy<50
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (Player:Chi() <= 3 and Player:EnergyPredicted() < 50) then
                return A.EnergizingElixir:Show(icon)
            end
            
            -- chi_burst,if=chi.max-chi>0&active_enemies=1|chi.max-chi>1
            if A.ChiBurst:IsReady(unit) and (Player:ChiMax() - Player:Chi() > 0 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Player:ChiMax() - Player:Chi() > 1) then
                return A.ChiBurst:Show(icon)
            end
            
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>3&!dot.touch_of_death.remains&buff.storm_earth_and_fire.down
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm674, EvaluateTargetIfTigerPalm685) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            
            -- spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.react
            if A.SpinningCraneKick:IsReady(unit) and (combo_strike and Unit("player"):HasBuffsStacks(A.DanceofChijiBuff.ID, true)) then
                return A.SpinningCraneKick:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&((talent.serenity.enabled|cooldown.touch_of_death.remains>2|variable.hold_tod)&(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>2|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4|chi>5)|buff.bok_proc.up)
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick697, EvaluateTargetIfBlackoutKick724) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>1
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm730, EvaluateTargetIfTigerPalm737) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- flying_serpent_kick,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) then
                return A.FlyingSerpentKick:Show(icon)
            end
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(cooldown.fists_of_fury.remains<3&chi=2|energy.time_to_max<1)&(prev_gcd.1.tiger_palm|chi.max-chi<2)
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick745, EvaluateTargetIfBlackoutKick756) then 
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
            
            -- variable,name=hold_tod,op=set,value=cooldown.touch_of_death.remains+9>target.time_to_die|!talent.serenity.enabled&!variable.tod_on_use_trinket&equipped.dribbling_inkpod&target.time_to_pct_30.remains<130&target.time_to_pct_30.remains>8|fight_remains<130&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>2|buff.serenity.up&fight_remains>11
            VarHoldTod = num(A.TouchofDeath:GetCooldown() + 9 > Unit(unit):TimeToDie() or not A.Serenity:IsSpellLearned() and not VarTodOnUseTrinket and A.DribblingInkpod:IsExists() and Unit(unit):TimeToDieX(30) < 130 and Unit(unit):TimeToDieX(30) > 8 or fight_remains < 130 and fight_remains > A.Serenity:GetCooldown() and A.Serenity:GetCooldown() > 2 or Unit("player"):HasBuffs(A.SerenityBuff.ID, true) and fight_remains > 11)
            
            -- potion,if=buff.serenity.up|buff.storm_earth_and_fire.up&dot.touch_of_death.remains|fight_remains<=60
            if A.ProlongedPower:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.SerenityBuff.ID, true) or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true) or fight_remains <= 60) then
                return A.ProlongedPower:Show(icon)
            end
            
            -- reverse_harm,if=chi.max-chi>=2&(talent.serenity.enabled|!dot.touch_of_death.remains)&buff.serenity.down&(energy.time_to_max<1|talent.serenity.enabled&cooldown.serenity.remains<2|!talent.serenity.enabled&cooldown.touch_of_death.remains<3&!variable.hold_tod|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
            if A.ReverseHarm:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 2 and (A.Serenity:IsSpellLearned() or not Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true)) and Unit("player"):HasBuffsDown(A.SerenityBuff.ID, true) and (Player:EnergyTimeToMaxPredicted() < 1 or A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2 or not A.Serenity:IsSpellLearned() and A.TouchofDeath:GetCooldown() < 3 and not VarHoldTod or Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)) then
                return A.ReverseHarm:Show(icon)
            end
            
            -- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3&buff.serenity.down&buff.seething_rage.down&(energy.time_to_max<1|talent.serenity.enabled&cooldown.serenity.remains<2|!talent.serenity.enabled&cooldown.touch_of_death.remains<3&!variable.hold_tod|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
            if A.FistoftheWhiteTiger:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FistoftheWhiteTiger, 40, "min", EvaluateTargetIfFilterFistoftheWhiteTiger810, EvaluateTargetIfFistoftheWhiteTiger833) then 
                    return A.FistoftheWhiteTiger:Show(icon) 
                end
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!combo_break&chi.max-chi>=2&(talent.serenity.enabled|!dot.touch_of_death.remains|active_enemies>2)&buff.seething_rage.down&buff.serenity.down&(energy.time_to_max<1|talent.serenity.enabled&cooldown.serenity.remains<2|!talent.serenity.enabled&cooldown.touch_of_death.remains<3&!variable.hold_tod|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm839, EvaluateTargetIfTigerPalm872) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- chi_wave,if=!talent.fist_of_the_white_tiger.enabled&prev_gcd.1.tiger_palm&time<=3
            if A.ChiWave:IsReady(unit) and (not A.FistoftheWhiteTiger:IsSpellLearned() and Player:PrevGCD(1, A.TigerPalm) and Unit("player"):CombatTime() <= 3) then
                return A.ChiWave:Show(icon)
            end
            
            -- call_action_list,name=cd_serenity,if=talent.serenity.enabled
            if (A.Serenity:IsSpellLearned()) then
                if CdSerenity(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cd_sef,if=!talent.serenity.enabled
            if (not A.Serenity:IsSpellLearned()) then
                if CdSef(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=serenity,if=buff.serenity.up
            if (Unit("player"):HasBuffs(A.SerenityBuff.ID, true)) then
                if Serenity(unit) then
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

