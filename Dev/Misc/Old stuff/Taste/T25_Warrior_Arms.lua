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
Action[ACTION_CONST_WARRIOR_ARMS] = {
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
    Skullsplitter                          = Action.Create({ Type = "Spell", ID = 260643 }),
    DeadlyCalmBuff                         = Action.Create({ Type = "Spell", ID = 262228 }),
    Ravager                                = Action.Create({ Type = "Spell", ID = 152277 }),
    ColossusSmash                          = Action.Create({ Type = "Spell", ID = 167105 }),
    Warbreaker                             = Action.Create({ Type = "Spell", ID = 262161 }),
    DeadlyCalm                             = Action.Create({ Type = "Spell", ID = 262228 }),
    Bladestorm                             = Action.Create({ Type = "Spell", ID = 227847 }),
    TestofMightBuff                        = Action.Create({ Type = "Spell", ID = 275540 }),
    Cleave                                 = Action.Create({ Type = "Spell", ID = 845 }),
    Slam                                   = Action.Create({ Type = "Spell", ID = 1464 }),
    CrushingAssaultBuff                    = Action.Create({ Type = "Spell", ID = 278826 }),
    MortalStrike                           = Action.Create({ Type = "Spell", ID = 12294 }),
    OverpowerBuff                          = Action.Create({ Type = "Spell", ID = 7384 }),
    Dreadnaught                            = Action.Create({ Type = "Spell", ID = 262150 }),
    ExecutionersPrecisionBuff              = Action.Create({ Type = "Spell", ID = 242188 }),
    Execute                                = Action.Create({ Type = "Spell", ID = 163201 }),
    Overpower                              = Action.Create({ Type = "Spell", ID = 7384 }),
    ColossusSmashDebuff                    = Action.Create({ Type = "Spell", ID = 208086 }),
    SweepingStrikesBuff                    = Action.Create({ Type = "Spell", ID = 260708 }),
    TestofMight                            = Action.Create({ Type = "Spell", ID = 275529 }),
    DeepWoundsDebuff                       = Action.Create({ Type = "Spell", ID = 262115 }),
    SuddenDeathBuff                        = Action.Create({ Type = "Spell", ID = 52437 }),
    StoneHeartBuff                         = Action.Create({ Type = "Spell", ID = 225947 }),
    SweepingStrikes                        = Action.Create({ Type = "Spell", ID = 260708 }),
    Whirlwind                              = Action.Create({ Type = "Spell", ID = 1680 }),
    FervorofBattle                         = Action.Create({ Type = "Spell", ID = 202316 }),
    Rend                                   = Action.Create({ Type = "Spell", ID = 772 }),
    RendDebuff                             = Action.Create({ Type = "Spell", ID = 772 }),
    AngerManagement                        = Action.Create({ Type = "Spell", ID = 152278 }),
    SeismicWave                            = Action.Create({ Type = "Spell", ID = 277639 }),
    Charge                                 = Action.Create({ Type = "Spell", ID = 100 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  }),
    Avatar                                 = Action.Create({ Type = "Spell", ID = 107574 }),
    ReapingFlames                          = Action.Create({ Type = "Spell", ID =  }),
    Massacre                               = Action.Create({ Type = "Spell", ID = 281001 })
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })





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

A.ExecuteDefault    = 163201
A.ExecuteMassacre   = 281000

local function UpdateExecuteID()
    A.Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
end

--- ======= ACTION LISTS =======
local function APL()
        local Precombat, Execute, FiveUnit(unit), Hac, SingleUnit(unit)
  UpdateRanges()
  Everyone.AoEToggleEnemiesUpdate()
  UpdateExecuteID()
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
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
        end
        
        --Execute
        local function Execute(unit)
            -- skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 60 and bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true))) then
                return A.Skullsplitter:Show(icon)
            end
            -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
            if A.ColossusSmash:IsReady(unit) and (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) or (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or A.MemoryofLucidDreams:GetCooldown() > 10)) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) or (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or A.MemoryofLucidDreams:GetCooldown() > 10)) then
                return A.Warbreaker:Show(icon)
            end
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            -- bladestorm,if=!buff.memory_of_lucid_dreams.up&buff.test_of_might.up&rage<30&!buff.deadly_calm.up
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) and Player:Rage() < 30 and not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true)) then
                return A.Bladestorm:Show(icon)
            end
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            -- slam,if=buff.crushing_assault.up&buff.memory_of_lucid_dreams.down
            if A.Slam:IsReady(unit) and (Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true))) then
                return A.Slam:Show(icon)
            end
            -- mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2
            if A.MortalStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and A.Dreadnaught:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2) then
                return A.MortalStrike:Show(icon)
            end
            -- execute,if=buff.memory_of_lucid_dreams.up|buff.deadly_calm.up|(buff.test_of_might.up&cooldown.memory_of_lucid_dreams.remains>94)
            if A.Execute:IsReady(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) and A.MemoryofLucidDreams:GetCooldown() > 94)) then
                return A.Execute:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- execute
            if A.Execute:IsReady(unit) then
                return A.Execute:Show(icon)
            end
        end
        
        --FiveUnit(unit)
        local function FiveUnit(unit)(unit)
            -- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 60 and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)))) then
                return A.Skullsplitter:Show(icon)
            end
            -- ravager,if=(!talent.warbreaker.enabled|cooldown.warbreaker.remains<2)
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and ((not A.Warbreaker:IsSpellLearned() or A.Warbreaker:GetCooldown() < 2)) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=debuff.colossus_smash.down
            if A.ColossusSmash:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=debuff.colossus_smash.down
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Warbreaker:Show(icon)
            end
            -- bladestorm,if=buff.sweeping_strikes.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.SweepingStrikesBuff.ID, true)) and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true))) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 4.5 and not bool(A.TestofMight:GetAzeriteRank())) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            -- cleave
            if A.Cleave:IsReady(unit) then
                return A.Cleave:Show(icon)
            end
            -- execute,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|(buff.sudden_death.react|buff.stone_heart.react)&(buff.sweeping_strikes.up|cooldown.sweeping_strikes.remains>8)
            if A.Execute:IsReady(unit) and ((not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or (bool(Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true)) or bool(Unit("player"):HasBuffsStacks(A.StoneHeartBuff.ID, true))) and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) or A.SweepingStrikes:GetCooldown() > 8)) then
                return A.Execute:Show(icon)
            end
            -- mortal_strike,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sweeping_strikes.up&buff.overpower.stack=2&(talent.dreadnaught.enabled|buff.executioners_precision.stack=2)
            if A.MortalStrike:IsReady(unit) and ((not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) and Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and (A.Dreadnaught:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2)) then
                return A.MortalStrike:Show(icon)
            end
            -- whirlwind,if=debuff.colossus_smash.up|(buff.crushing_assault.up&talent.fervor_of_battle.enabled)
            if A.Whirlwind:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or (Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) and A.FervorofBattle:IsSpellLearned())) then
                return A.Whirlwind:Show(icon)
            end
            -- whirlwind,if=buff.deadly_calm.up|rage>60
            if A.Whirlwind:IsReady(unit) and (Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or Player:Rage() > 60) then
                return A.Whirlwind:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- whirlwind
            if A.Whirlwind:IsReady(unit) then
                return A.Whirlwind:Show(icon)
            end
        end
        
        --Hac
        local function Hac(unit)
            -- rend,if=remains<=duration*0.3&(!raid_event.adds.up|buff.sweeping_strikes.up)
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration() * 0.3 and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true))) then
                return A.Rend:Show(icon)
            end
            -- skullsplitter,if=rage<60&(cooldown.deadly_calm.remains>3|!talent.deadly_calm.enabled)
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 60 and (A.DeadlyCalm:GetCooldown() > 3 or not A.DeadlyCalm:IsSpellLearned())) then
                return A.Skullsplitter:Show(icon)
            end
            -- deadly_calm,if=(cooldown.bladestorm.remains>6|talent.ravager.enabled&cooldown.ravager.remains>6)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.DeadlyCalm:IsReady(unit) and ((A.Bladestorm:GetCooldown() > 6 or A.Ravager:IsSpellLearned() and A.Ravager:GetCooldown() > 6) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.DeadlyCalm:Show(icon)
            end
            -- ravager,if=(raid_event.adds.up|raid_event.adds.in>target.time_to_die)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or 10000000000 > Unit(unit):TimeToDie()) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
            if A.ColossusSmash:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or 10000000000 > 40 or (10000000000 > 20 and A.AngerManagement:IsSpellLearned())) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or 10000000000 > 40 or (10000000000 > 20 and A.AngerManagement:IsSpellLearned())) then
                return A.Warbreaker:Show(icon)
            end
            -- bladestorm,if=(debuff.colossus_smash.up&raid_event.adds.in>target.time_to_die)|raid_event.adds.up&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and 10000000000 > Unit(unit):TimeToDie()) or (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 4.5 and not bool(A.TestofMight:GetAzeriteRank())) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            -- overpower,if=!raid_event.adds.up|(raid_event.adds.up&azerite.seismic_wave.enabled)
            if A.Overpower:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) and bool(A.SeismicWave:GetAzeriteRank()))) then
                return A.Overpower:Show(icon)
            end
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            -- execute,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sudden_death.react
            if A.Execute:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or (not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or bool(Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true))) then
                return A.Execute:Show(icon)
            end
            -- mortal_strike,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)
            if A.MortalStrike:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or (not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2)) then
                return A.MortalStrike:Show(icon)
            end
            -- whirlwind,if=raid_event.adds.up
            if A.Whirlwind:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return A.Whirlwind:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- whirlwind,if=talent.fervor_of_battle.enabled
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned()) then
                return A.Whirlwind:Show(icon)
            end
            -- slam,if=!talent.fervor_of_battle.enabled&!raid_event.adds.up
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned() and not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return A.Slam:Show(icon)
            end
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
            -- rend,if=remains<=duration*0.3&debuff.colossus_smash.down
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration() * 0.3 and bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Rend:Show(icon)
            end
            -- skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 60 and bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true))) then
                return A.Skullsplitter:Show(icon)
            end
            -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash
            if A.ColossusSmash:IsReady(unit) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) then
                return A.Warbreaker:Show(icon)
            end
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            -- execute,if=buff.sudden_death.react
            if A.Execute:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true))) then
                return A.Execute:Show(icon)
            end
            -- bladestorm,if=cooldown.mortal_strike.remains&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.up&!azerite.test_of_might.enabled)|buff.test_of_might.up)&buff.memory_of_lucid_dreams.down&rage<40
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (bool(A.MortalStrike:GetCooldown()) and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true))) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not bool(A.TestofMight:GetAzeriteRank())) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) and Player:Rage() < 40) then
                return A.Bladestorm:Show(icon)
            end
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            -- overpower,if=(rage<30&buff.memory_of_lucid_dreams.up&debuff.colossus_smash.up)|(rage<70&buff.memory_of_lucid_dreams.down)
            if A.Overpower:IsReady(unit) and ((Player:Rage() < 30 and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) or (Player:Rage() < 70 and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)))) then
                return A.Overpower:Show(icon)
            end
            -- mortal_strike
            if A.MortalStrike:IsReady(unit) then
                return A.MortalStrike:Show(icon)
            end
            -- whirlwind,if=talent.fervor_of_battle.enabled&(buff.memory_of_lucid_dreams.up|debuff.colossus_smash.up|buff.deadly_calm.up)
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned() and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true))) then
                return A.Whirlwind:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- whirlwind,if=talent.fervor_of_battle.enabled&(buff.test_of_might.up|debuff.colossus_smash.down&buff.test_of_might.down&rage>60)
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned() and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.TestofMightBuff.ID, true)) and Player:Rage() > 60)) then
                return A.Whirlwind:Show(icon)
            end
            -- slam,if=!talent.fervor_of_battle.enabled
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned()) then
                return A.Slam:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end
        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            -- charge
            if A.Charge:IsReady(unit) then
                return A.Charge:Show(icon)
            end
            -- auto_attack
            -- potion,if=target.health.pct<21&buff.memory_of_lucid_dreams.up|!essence.memory_of_lucid_dreams.major
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(unit):HealthPercent() < 21 and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID))) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- blood_fury,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) < 5 or (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.memory_of_lucid_dreams.up|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.Berserking:Show(icon)
            end
            -- arcane_torrent,if=cooldown.mortal_strike.remains>1.5&buff.memory_of_lucid_dreams.down&rage<50
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.MortalStrike:GetCooldown() > 1.5 and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) and Player:Rage() < 50) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- lights_judgment,if=debuff.colossus_smash.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) < 5 or (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) < 5 or (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.AncestralCall:Show(icon)
            end
            -- bag_of_tricks,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) < 5 or (not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.BagofTricks:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=!debuff.razor_coral_debuff.up|(target.health.pct<20.1&buff.memory_of_lucid_dreams.up&cooldown.memory_of_lucid_dreams.remains<117)|(target.health.pct<30.1&debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major)|(!debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)|target.time_to_die<30
            if A.AshvanesRazorCoral:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) or (Unit(unit):HealthPercent() < 20.1 and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and A.MemoryofLucidDreams:GetCooldown() < 117) or (Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID))) or (not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) or Unit(unit):TimeToDie() < 30) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8)
            if A.Avatar:IsReady(unit) and A.BurstIsON(unit) and (A.ColossusSmash:GetCooldown() < 8 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 8)) then
                return A.Avatar:Show(icon)
            end
            -- sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled)
            if A.SweepingStrikes:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and (A.Bladestorm:GetCooldown() > 10 or A.ColossusSmash:GetCooldown() > 8 or bool(A.TestofMight:GetAzeriteRank()))) then
                return A.SweepingStrikes:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.test_of_might.up|(debuff.colossus_smash.up&!azerite.test_of_might.enabled)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not bool(A.TestofMight:GetAzeriteRank()))) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- purifying_blast,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            -- ripple_in_space,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            -- focused_azerite_beam,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- reaping_flames,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.ReapingFlames:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.ReapingFlames:Show(icon)
            end
            -- concentrated_flame,if=!debuff.colossus_smash.up&!buff.test_of_might.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            -- guardian_of_azeroth,if=cooldown.colossus_smash.remains<10
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.ColossusSmash:GetCooldown() < 10) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- memory_of_lucid_dreams,if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<gcd&(target.time_to_die>150|target.health.pct<20)
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Warbreaker:IsSpellLearned() and A.ColossusSmash:GetCooldown() < A.GetGCD() and (Unit(unit):TimeToDie() > 150 or Unit(unit):HealthPercent() < 20)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- memory_of_lucid_dreams,if=talent.warbreaker.enabled&cooldown.warbreaker.remains<gcd&(target.time_to_die>150|target.health.pct<20)
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < A.GetGCD() and (Unit(unit):TimeToDie() > 150 or Unit(unit):HealthPercent() < 20)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- run_action_list,name=hac,if=raid_event.adds.exists
            if ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return Hac(unit);
            end
            -- run_action_list,name=five_target,if=spell_targets.whirlwind>4
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) > 4) then
                return FiveUnitunit(unit);
            end
            -- run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
            if Execute(unit) and 
			    (
				    (A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35) 
					or
					Unit(unit):HealthPercent() < 20
				)
			then
                return true
            end
            -- run_action_list,name=single_target
            if SingleUnit(unit) then
                return true
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

