--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_HUNTER_BEASTMASTERY] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    SummonPet                              = Action.Create({ Type = "Spell", ID = 883 }),
    AspectoftheWildBuff                    = Action.Create({ Type = "Spell", ID = 193530 }),
    AspectoftheWild                        = Action.Create({ Type = "Spell", ID = 193530 }),
    PrimalInstinctsBuff                    = Action.Create({ Type = "Spell", ID = 279810 }),
    PrimalInstincts                        = Action.Create({ Type = "Spell", ID = 279806 }),
    EssenceoftheFocusingIris               = Action.Create({ Type = "Spell", ID =  }),
    BestialWrathBuff                       = Action.Create({ Type = "Spell", ID = 19574 }),
    BestialWrath                           = Action.Create({ Type = "Spell", ID = 19574 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({ Type = "Spell", ID = 26297 }),
    KillerInstinct                         = Action.Create({ Type = "Spell", ID = 273887 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Action.Create({ Type = "Spell", ID = 20572 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    FrenzyBuff                             = Action.Create({ Type = "Spell", ID = 272790 }),
    PotionofUnbridledFuryBuff              = Action.Create({ Type = "Spell", ID =  }),
    UnbridledFuryBuff                      = Action.Create({ Type = "Spell", ID =  }),
    VisionofPerfection                     = Action.Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Action.Create({ Type = "Spell", ID =  }),
    BarbedShot                             = Action.Create({ Type = "Spell", ID = 217200 }),
    BarbedShotDebuff                       = Action.Create({ Type = "Spell", ID =  }),
    Multishot                              = Action.Create({ Type = "Spell", ID = 2643 }),
    BeastCleaveBuff                        = Action.Create({ Type = "Spell", ID = 118455, "pet" }),
    Stampede                               = Action.Create({ Type = "Spell", ID = 201430 }),
    OneWiththePack                         = Action.Create({ Type = "Spell", ID = 199528 }),
    ChimaeraShot                           = Action.Create({ Type = "Spell", ID = 53209 }),
    AMurderofCrows                         = Action.Create({ Type = "Spell", ID = 131894 }),
    Barrage                                = Action.Create({ Type = "Spell", ID = 120360 }),
    KillCommand                            = Action.Create({ Type = "Spell", ID = 34026 }),
    RapidReload                            = Action.Create({ Type = "Spell", ID =  }),
    DireBeast                              = Action.Create({ Type = "Spell", ID = 120679 }),
    CobraShot                              = Action.Create({ Type = "Spell", ID = 193455 }),
    SpittingCobra                          = Action.Create({ Type = "Spell", ID = 194407 }),
    DanceofDeath                           = Action.Create({ Type = "Spell", ID =  }),
    DanceofDeathBuff                       = Action.Create({ Type = "Spell", ID =  }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  }),
    GuardianofAzerothBuff                  = Action.Create({ Type = "Spell", ID =  }),
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_HUNTER_BEASTMASTERY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_BEASTMASTERY], { __index = Action })





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


local function EvaluateTargetIfFilterBarbedShot133(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true)
end

local function EvaluateTargetIfBarbedShot144(unit)
  return Pet:HasBuffs(A.FrenzyBuff.ID, true) and Pet:HasBuffs(A.FrenzyBuff.ID, true) <= A.GetGCD()
end


local function EvaluateTargetIfFilterBarbedShot154(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true)
end

local function EvaluateTargetIfBarbedShot167(unit)
  return A.BarbedShot:FullRechargeTimeP() < A.GetGCD() and bool(A.BestialWrath:GetCooldown())
end


local function EvaluateTargetIfFilterBarbedShot205(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true)
end

local function EvaluateTargetIfBarbedShot230(unit)
  return bool(Pet:HasBuffsDown(A.FrenzyBuff.ID, true)) and (A.BarbedShot:ChargesFractionalP() > 1.8 or Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true)) or A.AspectoftheWild:GetCooldown() < A.FrenzyBuff.ID, true:BaseDuration() - A.GetGCD() and bool(A.PrimalInstincts:GetAzeriteRank()) or A.BarbedShot:ChargesFractionalP() > 1.4 or Unit(unit):TimeToDie() < 9
end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Cds, Cleave, St
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists&(trinket.1.has_cooldown+trinket.2.has_cooldown<2|equipped.variable_intensity_gigavolt_oscillating_reactor)
            if A.CyclotronicBlast:IsReady(unit) and (not bool(raid_event.invulnerable.exists) and (trinket.1.has_cooldown + trinket.2.has_cooldown < 2 or A.VariableIntensityGigavoltOscillatingReactor:IsExists())) then
                A.CyclotronicBlast:Show(icon)
            end
            -- focused_azerite_beam,if=!raid_event.invulnerable.exists
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not bool(raid_event.invulnerable.exists)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- aspect_of_the_wild,precast_time=1.1,if=!azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
            if A.AspectoftheWild:IsReady(unit) and Unit("player"):HasBuffsDown(A.AspectoftheWildBuff.ID, true) and (not bool(A.PrimalInstincts:GetAzeriteRank()) and not bool(Azerite:EssenceHasMajor(A.EssenceoftheFocusingIris.ID)) and (A.AzsharasFontofPower:IsExists() or not A.CyclotronicBlast:IsExists())) then
                return A.AspectoftheWild:Show(icon)
            end
            -- bestial_wrath,precast_time=1.5,if=azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
            if A.BestialWrath:IsReady(unit) and Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) and (bool(A.PrimalInstincts:GetAzeriteRank()) and not bool(Azerite:EssenceHasMajor(A.EssenceoftheFocusingIris.ID)) and (A.AzsharasFontofPower:IsExists() or not A.CyclotronicBlast:IsExists())) then
                return A.BestialWrath:Show(icon)
            end
            -- potion,dynamic_prepot=1
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- ancestral_call,if=cooldown.bestial_wrath.remains>30
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
            -- fireblood,if=cooldown.bestial_wrath.remains>30
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
            -- berserking,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<13
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and (Unit(unit):TimeToDie() > A.Berserking:BaseDuration() + A.BerserkingBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
            -- blood_fury,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<16
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and (Unit(unit):TimeToDie() > A.BloodFury:BaseDuration() + A.BloodFuryBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.BloodFury:Show(icon)
            end
            -- lights_judgment,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains>gcd.max|!pet.turtle.buff.frenzy.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Pet:HasBuffs(A.FrenzyBuff.ID, true) and Pet:HasBuffs(A.FrenzyBuff.ID, true) > A.GetGCD() or not Pet:HasBuffs(A.FrenzyBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            -- potion,if=buff.bestial_wrath.up&buff.aspect_of_the_wild.up&target.health.pct<35|((consumable.potion_of_unbridled_fury|consumable.unbridled_fury)&target.time_to_die<61|target.time_to_die<26)
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) and Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and Unit(unit):HealthPercent() < 35 or ((Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff.ID, true) or Unit(unit):HasBuffs(A.UnbridledFuryBuff.ID, true)) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26)) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- worldvein_resonance,if=(prev_gcd.1.aspect_of_the_wild|cooldown.aspect_of_the_wild.remains<gcd|target.time_to_die<20)|!essence.vision_of_perfection.minor
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((Unit("player"):GetSpellLastCast(A.AspectoftheWild) or A.AspectoftheWild:GetCooldown() < A.GetGCD() or Unit(unit):TimeToDie() < 20) or not bool(Azerite:EssenceHasMinor(A.VisionofPerfection.ID))) then
                return A.WorldveinResonance:Show(icon)
            end
            -- guardian_of_azeroth,if=cooldown.aspect_of_the_wild.remains<10|target.time_to_die>cooldown+duration|target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.AspectoftheWild:GetCooldown() < 10 or Unit(unit):TimeToDie() > cooldown + duration or Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:IsReady(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30) then
                return A.ReapingFlames:Show(icon)
            end
        end
        
        --Cleave
        local function Cleave(unit)
            -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<=gcd.max
            if A.BarbedShot:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot133, EvaluateTargetIfBarbedShot144) then 
                    return A.BarbedShot:Show(icon) 
                end
            end
            -- multishot,if=gcd.max-pet.turtle.buff.beast_cleave.remains>0.25
            if A.Multishot:IsReady(unit) and (A.GetGCD() - Pet:HasBuffs(A.BeastCleaveBuff.ID, true) > 0.25) then
                return A.Multishot:Show(icon)
            end
            -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=full_recharge_time<gcd.max&cooldown.bestial_wrath.remains
            if A.BarbedShot:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot154, EvaluateTargetIfBarbedShot167) then 
                    return A.BarbedShot:Show(icon) 
                end
            end
            -- aspect_of_the_wild
            if A.AspectoftheWild:IsReady(unit) then
                return A.AspectoftheWild:Show(icon)
            end
            -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 15) then
                return A.Stampede:Show(icon)
            end
            -- bestial_wrath,if=cooldown.aspect_of_the_wild.remains_guess>20|talent.one_with_the_pack.enabled|target.time_to_die<15
            if A.BestialWrath:IsReady(unit) and (cooldown.aspect_of_the_wild.remains_guess > 20 or A.OneWiththePack:IsSpellLearned() or Unit(unit):TimeToDie() < 15) then
                return A.BestialWrath:Show(icon)
            end
            -- chimaera_shot
            if A.ChimaeraShot:IsReady(unit) then
                return A.ChimaeraShot:Show(icon)
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            -- kill_command,if=active_enemies<4|!azerite.rapid_reload.enabled
            if A.KillCommand:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 or not bool(A.RapidReload:GetAzeriteRank())) then
                return A.KillCommand:Show(icon)
            end
            -- dire_beast
            if A.DireBeast:IsReady(unit) then
                return A.DireBeast:Show(icon)
            end
            -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.turtle.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|charges_fractional>1.4|target.time_to_die<9
            if A.BarbedShot:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot205, EvaluateTargetIfBarbedShot230) then 
                    return A.BarbedShot:Show(icon) 
                end
            end
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            -- multishot,if=azerite.rapid_reload.enabled&active_enemies>2
            if A.Multishot:IsReady(unit) and (bool(A.RapidReload:GetAzeriteRank()) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Multishot:Show(icon)
            end
            -- cobra_shot,if=cooldown.kill_command.remains>focus.time_to_max&(active_enemies<3|!azerite.rapid_reload.enabled)
            if A.CobraShot:IsReady(unit) and (A.KillCommand:GetCooldown() > Player:FocusTimeToMaxPredicted() and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or not bool(A.RapidReload:GetAzeriteRank()))) then
                return A.CobraShot:Show(icon)
            end
            -- spitting_cobra
            if A.SpittingCobra:IsReady(unit) then
                return A.SpittingCobra:Show(icon)
            end
        end
        
        --St
        local function St(unit)
            -- barbed_shot,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<gcd|cooldown.bestial_wrath.remains&(full_recharge_time<gcd|azerite.primal_instincts.enabled&cooldown.aspect_of_the_wild.remains<gcd)
            if A.BarbedShot:IsReady(unit) and (Pet:HasBuffs(A.FrenzyBuff.ID, true) and Pet:HasBuffs(A.FrenzyBuff.ID, true) < A.GetGCD() or bool(A.BestialWrath:GetCooldown()) and (A.BarbedShot:FullRechargeTimeP() < A.GetGCD() or bool(A.PrimalInstincts:GetAzeriteRank()) and A.AspectoftheWild:GetCooldown() < A.GetGCD())) then
                return A.BarbedShot:Show(icon)
            end
            -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.bestial_wrath.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:Focus() + Player:FocusRegen() * A.GetGCD() < Player:FocusMax() and bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true)) and (not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true)) and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD() or Unit(unit):TimeToDie() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- aspect_of_the_wild,if=cooldown.barbed_shot.charges<1|!azerite.primal_instincts.enabled
            if A.AspectoftheWild:IsReady(unit) and (A.BarbedShot:ChargesP() < 1 or not bool(A.PrimalInstincts:GetAzeriteRank())) then
                return A.AspectoftheWild:Show(icon)
            end
            -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 15) then
                return A.Stampede:Show(icon)
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- focused_azerite_beam,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true)) or Unit(unit):TimeToDie() < 5) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10 or Unit(unit):TimeToDie() < 5) then
                return A.TheUnboundForce:Show(icon)
            end
            -- bestial_wrath,if=!buff.bestial_wrath.up&cooldown.aspect_of_the_wild.remains>15|target.time_to_die<15+gcd
            if A.BestialWrath:IsReady(unit) and (not Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) and A.AspectoftheWild:GetCooldown() > 15 or Unit(unit):TimeToDie() < 15 + A.GetGCD()) then
                return A.BestialWrath:Show(icon)
            end
            -- barbed_shot,if=azerite.dance_of_death.rank>1&buff.dance_of_death.remains<gcd&crit_pct_current>40
            if A.BarbedShot:IsReady(unit) and (A.DanceofDeath:GetAzeriteRank() > 1 and Unit("player"):HasBuffs(A.DanceofDeathBuff.ID, true) < A.GetGCD() and crit_pct_current > 40) then
                return A.BarbedShot:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.aspect_of_the_wild.remains>10+gcd|target.time_to_die<10+gcd
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) > 10 + A.GetGCD() or Unit(unit):TimeToDie() < 10 + A.GetGCD()) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- kill_command
            if A.KillCommand:IsReady(unit) then
                return A.KillCommand:Show(icon)
            end
            -- bag_of_tricks,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.BagofTricks:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true)) or Unit(unit):TimeToDie() < 5) then
                return A.BagofTricks:Show(icon)
            end
            -- chimaera_shot
            if A.ChimaeraShot:IsReady(unit) then
                return A.ChimaeraShot:Show(icon)
            end
            -- dire_beast
            if A.DireBeast:IsReady(unit) then
                return A.DireBeast:Show(icon)
            end
            -- barbed_shot,if=talent.one_with_the_pack.enabled&charges_fractional>1.5|charges_fractional>1.8|cooldown.aspect_of_the_wild.remains<pet.turtle.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|target.time_to_die<9
            if A.BarbedShot:IsReady(unit) and (A.OneWiththePack:IsSpellLearned() and A.BarbedShot:ChargesFractionalP() > 1.5 or A.BarbedShot:ChargesFractionalP() > 1.8 or A.AspectoftheWild:GetCooldown() < A.FrenzyBuff.ID, true:BaseDuration() - A.GetGCD() and bool(A.PrimalInstincts:GetAzeriteRank()) or Unit(unit):TimeToDie() < 9) then
                return A.BarbedShot:Show(icon)
            end
            -- purifying_blast,if=buff.bestial_wrath.down|target.time_to_die<8
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true)) or Unit(unit):TimeToDie() < 8) then
                return A.PurifyingBlast:Show(icon)
            end
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            -- cobra_shot,if=(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd&cooldown.bestial_wrath.remains_guess>focus.time_to_max|buff.memory_of_lucid_dreams.up)&cooldown.kill_command.remains>1|target.time_to_die<3
            if A.CobraShot:IsReady(unit) and ((Player:Focus() - A.CobraShot:Cost() + Player:FocusRegen() * (A.KillCommand:GetCooldown() - 1) > A.KillCommand:Cost() or A.KillCommand:GetCooldown() > 1 + A.GetGCD() and cooldown.bestial_wrath.remains_guess > Player:FocusTimeToMaxPredicted() or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) and A.KillCommand:GetCooldown() > 1 or Unit(unit):TimeToDie() < 3) then
                return A.CobraShot:Show(icon)
            end
            -- spitting_cobra
            if A.SpittingCobra:IsReady(unit) then
                return A.SpittingCobra:Show(icon)
            end
            -- barbed_shot,if=pet.turtle.buff.frenzy.duration-gcd>full_recharge_time
            if A.BarbedShot:IsReady(unit) and (A.FrenzyBuff.ID, true:BaseDuration() - A.GetGCD() > A.BarbedShot:FullRechargeTimeP()) then
                return A.BarbedShot:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_shot
            -- use_items,if=prev_gcd.1.aspect_of_the_wild|target.time_to_die<20
            -- use_item,name=azsharas_font_of_power,if=cooldown.aspect_of_the_wild.remains_guess<15&target.time_to_die>10
            if A.AzsharasFontofPower:IsReady(player) and (cooldown.aspect_of_the_wild.remains_guess < 15 and Unit(unit):TimeToDie() > 10) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.up&(!equipped.azsharas_font_of_power|trinket.azsharas_font_of_power.cooldown.remains>86|essence.blood_of_the_enemy.major)&(prev_gcd.1.aspect_of_the_wild|!equipped.cyclotronic_blast&buff.aspect_of_the_wild.remains>9)&(!essence.condensed_lifeforce.major|buff.guardian_of_azeroth.up)&(target.health.pct<35|!essence.condensed_lifeforce.major|!talent.killer_instinct.enabled)|(debuff.razor_coral_debuff.down|target.time_to_die<26)&target.time_to_die>(24*(cooldown.cyclotronic_blast.remains+4<target.time_to_die))
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and (not A.AzsharasFontofPower:IsExists() or trinket.azsharas_font_of_power.cooldown.remains > 86 or bool(Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID))) and (Unit("player"):GetSpellLastCast(A.AspectoftheWild) or not A.CyclotronicBlast:IsExists() and Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) > 9) and (not bool(Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID)) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true)) and (Unit(unit):HealthPercent() < 35 or not bool(Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID)) or not A.KillerInstinct:IsSpellLearned()) or (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):TimeToDie() < 26) and Unit(unit):TimeToDie() > (24 * num((A.CyclotronicBlast:GetCooldown() + 4 < Unit(unit):TimeToDie())))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.CyclotronicBlast:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true)) or Unit(unit):TimeToDie() < 5) then
                A.CyclotronicBlast:Show(icon)
            end
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=st,if=active_enemies<2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
                local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cleave,if=active_enemies>1
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                local ShouldReturn = Cleave(unit); if ShouldReturn then return ShouldReturn; end
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
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
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

