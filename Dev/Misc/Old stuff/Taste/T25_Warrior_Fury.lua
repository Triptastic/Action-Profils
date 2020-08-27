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
Action[ACTION_CONST_WARRIOR_FURY] = {
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
    RecklessnessBuff                       = Action.Create({ Type = "Spell", ID = 1719 }),
    Recklessness                           = Action.Create({ Type = "Spell", ID = 1719 }),
    HeroicLeap                             = Action.Create({ Type = "Spell", ID = 6544 }),
    Siegebreaker                           = Action.Create({ Type = "Spell", ID = 280772 }),
    Rampage                                = Action.Create({ Type = "Spell", ID = 184367 }),
    FrothingBerserker                      = Action.Create({ Type = "Spell", ID = 215571 }),
    Carnage                                = Action.Create({ Type = "Spell", ID = 202922 }),
    EnrageBuff                             = Action.Create({ Type = "Spell", ID = 184362 }),
    Massacre                               = Action.Create({ Type = "Spell", ID = 206315 }),
    Execute                                = Action.Create({ Type = "Spell", ID = 5308 }),
    FuriousSlash                           = Action.Create({ Type = "Spell", ID = 100130 }),
    FuriousSlashBuff                       = Action.Create({ Type = "Spell", ID = 202539 }),
    Bladestorm                             = Action.Create({ Type = "Spell", ID = 46924 }),
    Bloodthirst                            = Action.Create({ Type = "Spell", ID = 23881 }),
    ColdSteelHotBlood                      = Action.Create({ Type = "Spell", ID =  }),
    DragonRoar                             = Action.Create({ Type = "Spell", ID = 118000 }),
    RagingBlow                             = Action.Create({ Type = "Spell", ID = 85288 }),
    Whirlwind                              = Action.Create({ Type = "Spell", ID = 190411 }),
    Charge                                 = Action.Create({ Type = "Spell", ID = 100 }),
    GuardianofAzerothBuff                  = Action.Create({ Type = "Spell", ID =  }),
    SiegebreakerBuff                       = Action.Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Action.Create({ Type = "Spell", ID =  }),
    MeatCleaverBuff                        = Action.Create({ Type = "Spell", ID = 280392 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })





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
        local Precombat, Movement, SingleUnit(unit)
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- recklessness
            if A.Recklessness:IsReady(unit) and Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true) and A.BurstIsON(unit) then
                return A.Recklessness:Show(icon)
            end
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
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
            if A.Rampage:IsReady(unit) and ((Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) or (A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() or Player:Rage() > 90) or A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() or Player:Rage() > 90))) then
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
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):GetSpellLastCast(A.Rampage)) then
                return A.Bladestorm:Show(icon)
            end
            -- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
            if A.Bloodthirst:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.EnrageBuff.ID, true)) or A.ColdSteelHotBlood:GetAzeriteRank() > 1) then
                return A.Bloodthirst:Show(icon)
            end
            -- dragon_roar,if=buff.enrage.up
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true)) then
                return A.DragonRoar:Show(icon)
            end
            -- raging_blow,if=charges=2
            if A.RagingBlow:IsReady(unit) and (A.RagingBlow:ChargesP() == 2) then
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
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
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
            if A.HeroicLeap:IsReady(unit) and ((raid_event.movement.distance > 25 and 10000000000 > 45)) then
                return A.HeroicLeap:Show(icon)
            end
            -- potion,if=buff.guardian_of_azeroth.up|(!essence.condensed_lifeforce.major&target.time_to_die=60)
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or (not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and Unit(unit):TimeToDie() == 60)) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- rampage,if=cooldown.recklessness.remains<3
            if A.Rampage:IsReady(unit) and (A.Recklessness:GetCooldown() < 3) then
                return A.Rampage:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.recklessness.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- reaping_flames,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.ReapingFlames:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.ReapingFlames:Show(icon)
            end
            -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            -- guardian_of_azeroth,if=!buff.recklessness.up&(target.time_to_die>195|target.health.pct<20)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and (Unit(unit):TimeToDie() > 195 or Unit(unit):HealthPercent() < 20)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- memory_of_lucid_dreams,if=!buff.recklessness.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>1|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
            if A.Recklessness:IsReady(unit) and A.BurstIsON(unit) and (not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and not bool(Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID)) or A.GuardianofAzeroth:GetCooldown() > 1 or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or A.BloodoftheEnemy:GetCooldown() < A.GetGCD()) then
                return A.Recklessness:Show(icon)
            end
            -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
            if A.Whirlwind:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true)) then
                return A.Whirlwind:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=target.time_to_die<20|!debuff.razor_coral_debuff.up|(target.health.pct<30.1&debuff.conductive_ink_debuff.up)|(!debuff.conductive_ink_debuff.up&buff.memory_of_lucid_dreams.up|prev_gcd.2.guardian_of_azeroth|prev_gcd.2.recklessness&(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major))
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):TimeToDie() < 20 or not Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) or (Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true)) or (not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):GetSpellLastCast(A.GuardianofAzeroth) or Unit("player"):GetSpellLastCast(A.Recklessness) and (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID))))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- blood_fury,if=buff.recklessness.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.recklessness.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- lights_judgment,if=buff.recklessness.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood,if=buff.recklessness.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=buff.recklessness.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- bag_of_tricks,if=buff.recklessness.up
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            -- run_action_list,name=single_target
            if (true) then
                return SingleUnitunit(unit);
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
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
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

