-----------------------------
-- Taste TMW Action Rotation
-----------------------------

local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local Action = Action
local TeamCache = Action.TeamCache
local EnemyTeam = Action.EnemyTeam
local FriendlyTeam = Action.FriendlyTeam
--local HealingEngine = Action.HealingEngine
local LoC = Action.LossOfControl
local ActionPlayer = Action.Player 
local MultiUnits = Action.MultiUnits
local UnitCooldown = Action.UnitCooldown
local ActionUnit = Action.Unit 
--local Pet = LibStub("PetLibrary")
--local Azerite = LibStub("AzeriteTraits")
local TR                                     = Action.TasteRotation

Action[ACTION_CONST_WARRIOR_FURY] = {
    -- Racial
    ArcaneTorrent                        = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                            = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                            = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                        = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                           = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                          = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                          = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                             = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                             = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                             = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                          = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                           = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                            = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                    = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                         = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                   = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                              = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
	-- CrowdControl
	StormBolt							= Action.Create({ Type = "Spell", ID = 107570    }),
	StormBoltGreen						= Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", Hidden = true, QueueForbidden = true }),
	StormBoltAntiFake                   = Action.Create({ Type = "Spell", ID = 107570, Desc = "[2] Kick", Hidden = true, QueueForbidden = true    }),
	Pummel                              = Action.Create({ Type = "Spell", ID = 6552    }),
	PummelGreen							= Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", Hidden = true, QueueForbidden = true }), 
	IntimidatingShout                   = Action.Create({ Type = "Spell", ID = 5246    }),
	IntimidatingShoutAntiFake           = Action.Create({ Type = "Spell", ID = 5246, Desc = "[2] Kick", QueueForbidden = true    }),
	PiercingHowl						= Action.Create({ Type = "Spell", ID = 12323    }),
	Taunt								= Action.Create({ Type = "Spell", ID = 355, Desc = "[6] PvP Pets Taunt", QueueForbidden = true    }),
	Disarm								= Action.Create({ Type = "Spell", ID = 236077, isTalent = true    }), -- PvP Talent 
	SpellReflection  					= Action.Create({ Type = "Spell", ID = 216890, isTalent = true    }), -- PvP Talent
    -- Generics Spells
    Recklessness                          = Action.Create({ Type = "Spell", ID = 1719    }),
    FuriousSlash                          = Action.Create({ Type = "Spell", ID = 100130    }),
    RecklessAbandon                       = Action.Create({ Type = "Spell", ID = 202751    }),
    HeroicLeap                            = Action.Create({ Type = "Spell", ID = 6544    }),
    Siegebreaker                          = Action.Create({ Type = "Spell", ID = 280772    }),
    Rampage                               = Action.Create({ Type = "Spell", ID = 184367    }),
    FrothingBerserker                     = Action.Create({ Type = "Spell", ID = 215571    }),
    Carnage                               = Action.Create({ Type = "Spell", ID = 202922    }),    
    Massacre                              = Action.Create({ Type = "Spell", ID = 206315    }),
    --Execute                               = MultiSpell(5308, 280735    }),
    Bloodthirst                           = Action.Create({ Type = "Spell", ID = 23881    }),
    RagingBlow                            = Action.Create({ Type = "Spell", ID = 85288    }),
    Bladestorm                            = Action.Create({ Type = "Spell", ID = 46924    }),
    DragonRoar                            = Action.Create({ Type = "Spell", ID = 118000    }),
    Whirlwind                             = Action.Create({ Type = "Spell", ID = 190411    }),
    Charge                                = Action.Create({ Type = "Spell", ID = 100    }),
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647    }),
    ColdSteelHotBlood                     = Action.Create({ Type = "Spell", ID = 288080    }),
	ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368    }),
	BattleShout                           = Action.Create({ Type = "Spell", ID = 6673    }),
    -- Defensive
	RallyingCry                           = Action.Create({ Type = "Spell", ID = 97462    }),
    -- Misc
	BerserkerRage						 = Action.Create({ Type = "Spell", ID = 18499    }),
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Victorious                           = Action.Create({ Type = "Spell", ID = 32216, Hidden = true     }),
    VictoryRush                          = Action.Create({ Type = "Spell", ID = 34428, Hidden = true     }),
	ImpendingVictory                     = Action.Create({ Type = "Spell", ID = 202168, Hidden = true     }),
    -- Buffs
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932, Hidden = true}),
    FujiedasFuryBuff                      = Action.Create({ Type = "Spell", ID = 207775, Hidden = true}),
    MeatCleaverBuff                       = Action.Create({ Type = "Spell", ID = 85739, Hidden = true}),
	EnrageBuff                            = Action.Create({ Type = "Spell", ID = 184362, Hidden = true}),
    FuriousSlashBuff                      = Action.Create({ Type = "Spell", ID = 202539, Hidden = true}),
    RecklessnessBuff                      = Action.Create({ Type = "Spell", ID = 1719, Hidden = true}),
	Enrage                                = Action.Create({ Type = "Spell", ID = 184362, Hidden = true}),
	SuddenDeathBuff                       = Action.Create({ Type = "Spell", ID = 280776, Hidden = true}),
    -- Debuffs 
    RazorCoralDebuff                      = Action.Create({ Type = "Spell", ID = 303568, Hidden = true}),
    ConductiveInkDebuff                   = Action.Create({ Type = "Spell", ID = 302565, Hidden = true}),
    SiegebreakerDebuff                    = Action.Create({ Type = "Spell", ID = 280773, Hidden = true}),
    -- Trinkets    
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	AshvanesRazorCoral                   = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),	
	ExecuteDefault                        = Action.Create({ Type = "Spell", ID = 5308, Hidden = true}),
    ExecuteMassacre                       = Action.Create({ Type = "Spell", ID = 280735, Hidden = true}),	
    -- Hidden Heart of Azeroth
    VisionofPerfectionMinor               = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2              = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3              = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                 = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                       = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                        = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}),
	CondensedLifeforce                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295834, Hidden = true}),
	CondensedLifeforce2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299354, Hidden = true}),
	CondensedLifeforce3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299357, Hidden = true}),
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady(), it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do A.Guard:IsReady() instead of Action[PLAYERSPEC].Guard:IsReady()
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

-- Simcraft Imported
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Pet        = Unit.Pet
local Spell      = HL.Spell
local Item       = HL.Item
-- HeroRotation
local HR         = HeroRotation

---------------------------
-- PORT TO ACTION 
local S, I = A:HeroCreate()
Action.HeroSetHookAllTable(S, {
        [3] = "TellMeWhen_Group4_Icon3",
        [4] = "TellMeWhen_Group4_Icon4",
		[6] = "TellMeWhen_Group4_Icon6", 
})
Action.HeroSetHookAllTable(I, {
        [3] = "TellMeWhen_Group4_Icon3",
        [4] = "TellMeWhen_Group4_Icon4",
		[6] = "TellMeWhen_Group4_Icon6",
})
-- Adding manually missed staff
--S.Brews                                 = Spell(115308)
--S.BlackoutCombo                         = Spell(196736)
--S.BlackoutComboBuff                     = Spell(228563)

---------------------------

-- Rotation Var
local ShouldReturn; -- Used to get the return string
local ForceOffGCD = {true, false};
local Everyone = HR.Commons.Everyone;

-- Stuns
local StunInterrupts = {
  {S.IntimidatingShout, "Cast Intimidating Shout (Interrupt)", function () return true; end},
};

local EnemyRanges = {5, 8, "Melee"}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local function UpdateExecuteID()
    S.Execute = S.Massacre:IsAvailable() and S.ExecuteMassacre or S.ExecuteDefault
end

local function ExecuteRange()
	return S.Massacre:IsAvailable() and 35 or 20;
end

local function DetermineEssenceRanks()
    S.BloodoftheEnemy = S.BloodoftheEnemy2:IsAvailable() and S.BloodoftheEnemy2 or S.BloodoftheEnemy
    S.BloodoftheEnemy = S.BloodoftheEnemy3:IsAvailable() and S.BloodoftheEnemy3 or S.BloodoftheEnemy
    S.MemoryofLucidDreams = S.MemoryofLucidDreams2:IsAvailable() and S.MemoryofLucidDreams2 or S.MemoryofLucidDreams
    S.MemoryofLucidDreams = S.MemoryofLucidDreams3:IsAvailable() and S.MemoryofLucidDreams3 or S.MemoryofLucidDreams
    S.PurifyingBlast = S.PurifyingBlast2:IsAvailable() and S.PurifyingBlast2 or S.PurifyingBlast
    S.PurifyingBlast = S.PurifyingBlast3:IsAvailable() and S.PurifyingBlast3 or S.PurifyingBlast
    S.RippleInSpace = S.RippleInSpace2:IsAvailable() and S.RippleInSpace2 or S.RippleInSpace
    S.RippleInSpace = S.RippleInSpace3:IsAvailable() and S.RippleInSpace3 or S.RippleInSpace
    S.ConcentratedFlame = S.ConcentratedFlame2:IsAvailable() and S.ConcentratedFlame2 or S.ConcentratedFlame
    S.ConcentratedFlame = S.ConcentratedFlame3:IsAvailable() and S.ConcentratedFlame3 or S.ConcentratedFlame
    S.TheUnboundForce = S.TheUnboundForce2:IsAvailable() and S.TheUnboundForce2 or S.TheUnboundForce
    S.TheUnboundForce = S.TheUnboundForce3:IsAvailable() and S.TheUnboundForce3 or S.TheUnboundForce
    S.WorldveinResonance = S.WorldveinResonance2:IsAvailable() and S.WorldveinResonance2 or S.WorldveinResonance
    S.WorldveinResonance = S.WorldveinResonance3:IsAvailable() and S.WorldveinResonance3 or S.WorldveinResonance
    S.FocusedAzeriteBeam = S.FocusedAzeriteBeam2:IsAvailable() and S.FocusedAzeriteBeam2 or S.FocusedAzeriteBeam
    S.FocusedAzeriteBeam = S.FocusedAzeriteBeam3:IsAvailable() and S.FocusedAzeriteBeam3 or S.FocusedAzeriteBeam
    S.VisionofPerfectionMinor = S.VisionofPerfectionMinor2:IsAvailable() and S.VisionofPerfectionMinor2 or S.VisionofPerfectionMinor
    S.VisionofPerfectionMinor = S.VisionofPerfectionMinor3:IsAvailable() and S.VisionofPerfectionMinor3 or S.VisionofPerfectionMinor
    S.GuardianofAzeroth = S.GuardianofAzeroth2:IsAvailable() and S.GuardianofAzeroth2 or S.GuardianofAzeroth
    S.GuardianofAzeroth = S.GuardianofAzeroth3:IsAvailable() and S.GuardianofAzeroth3 or S.GuardianofAzeroth
    S.CondensedLifeforce = S.CondensedLifeforce2:IsAvailable() and S.CondensedLifeforce2 or S.CondensedLifeforce
    S.CondensedLifeforce = S.CondensedLifeforce3:IsAvailable() and S.CondensedLifeforce3 or S.CondensedLifeforce
end

--- ======= ACTION LISTS =======
local function APL(icon) 
    
	-- Action specifics remap
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()
	
	-- Local functions remap
    UpdateRanges()
    Everyone.AoEToggleEnemiesUpdate()
    HL.GetEnemies(40, true) -- To populate Cache.Enemies[40] for CastCycles
    UpdateExecuteID()
	ExecuteRange()
	DetermineEssenceRanks()
	
    local function Precombat_DBM()
        -- flask
        -- food
        -- augmentation
		if S.BattleShout:IsReady() and not Player:BuffP(S.BattleShout) then
            if HR.Cast(S.BattleShout) then return "BattleShout"; end
        end
		if Everyone.TargetIsValid() then
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() and Pull > 1 and Pull <= 6 then
                if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power"; end
            end
            -- memory_of_lucid_dreams
            if S.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and HR.CDsON() and not ShouldStop and Pull > 0.1 and Pull <= 2 then
                if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams"; end
            end
            -- guardian_of_azeroth
            if S.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and HR.CDsON() and not ShouldStop and Pull > 0.1 and Pull <= 2 then
                if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth"; end
            end
            -- potion
            if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") and Pull > 0.1 and Pull <= 1 + Player:GCD() then
               if HR.Cast(I.PotionofUnbridledFury) then return "PotionofUnbridledFury 4"; end
            end
             -- recklessness
            if S.Recklessness:IsCastableP() and not ShouldStop and Pull > 0.1 and Pull <= 0.7 then
                if HR.Cast(S.Recklessness) then return "recklessness precombat"; end
            end
		end
    end
    
    local function Precombat()
        -- flask
        -- food
        -- augmentation
        -- augmentation
		if S.BattleShout:IsReady() and not Player:BuffP(S.BattleShout) then
            if HR.Cast(S.BattleShout) then return "BattleShout"; end
        end
		if Everyone.TargetIsValid() then
        -- snapshot_stats
        -- use_item,name=azsharas_font_of_power
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power"; end
        end
        -- memory_of_lucid_dreams
        if S.MemoryofLucidDreams:IsCastableP() and not ShouldStop and HR.CDsON()  then
            if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams"; end
        end
        -- guardian_of_azeroth
        if S.GuardianofAzeroth:IsCastableP() and not ShouldStop and HR.CDsON()  then
            if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth"; end
        end
        -- recklessness
        if S.Recklessness:IsCastableP() and not ShouldStop then
            if HR.Cast(S.Recklessness) then return "recklessness precombat"; end
        end
        -- potion
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_strength 4"; end
        end
		end
    end
    
	local function Movement()
        -- heroic_leap
        if S.HeroicLeap:IsCastableP() and not ShouldStop then
            if HR.Cast(S.HeroicLeap, Action.GetToggle(2, "OffGCDasOffGCD")) then return "heroic_leap 16"; end
        end
    end
    
	local function SingleTarget()
        -- siegebreaker
        if S.Siegebreaker:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Siegebreaker, Action.GetToggle(2, "OffGCDasOffGCD")) then return "siegebreaker 18"; end
        end
        -- rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
        if S.Rampage:IsReadyP("Melee") and ((Player:BuffP(S.RecklessnessBuff) or Player:BuffP(S.MemoryofLucidDreams)) or (S.FrothingBerserker:IsAvailable() or S.Carnage:IsAvailable() and (Player:BuffRemainsP(S.EnrageBuff) < Player:GCD() or Player:Rage() > 90) or S.Massacre:IsAvailable() and (Player:BuffRemainsP(S.EnrageBuff) < Player:GCD() or Player:Rage() > 90))) then
            if HR.Cast(S.Rampage) then return "rampage 20"; end
        end
        -- execute
        if S.Execute:IsCastable("Melee") and not ShouldStop then
            if HR.Cast(S.Execute) then return "execute 34"; end
        end
        -- furious_slash,if=!buff.bloodlust.up&buff.furious_slash.remains<3
        if S.FuriousSlash:IsCastableP() and not ShouldStop and (not Player:HasHeroism() and Player:BuffRemainsP(S.FuriousSlashBuff) < 3) then
            if HR.Cast(S.FuriousSlash) then return "furious_slash 36"; end
        end
        -- bladestorm,if=prev_gcd.1.rampage
        if S.Bladestorm:IsCastableP("Melee") and not ShouldStop and HR.CDsON() and (Player:PrevGCDP(1, S.Rampage)) then
            if HR.Cast(S.Bladestorm) then return "bladestorm 37"; end
        end
        -- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
        if S.Bloodthirst:IsCastableP("Melee") and not ShouldStop and (Player:BuffDownP(S.EnrageBuff) or S.ColdSteelHotBlood:AzeriteRank() > 1) then
            if HR.Cast(S.Bloodthirst) then return "bloodthirst 38"; end
        end
        -- raging_blow,if=charges=2
        if S.RagingBlow:IsCastableP("Melee") and not ShouldStop and (S.RagingBlow:ChargesP() == 2) then
            if HR.Cast(S.RagingBlow) then return "raging_blow 42"; end
        end
        -- bloodthirst
        if S.Bloodthirst:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Bloodthirst) then return "bloodthirst 48"; end
        end
        -- raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90)
        if S.RagingBlow:IsCastableP("Melee") and not ShouldStop and (S.Carnage:IsAvailable() or (S.Massacre:IsAvailable() and Player:Rage() < 80) or (S.FrothingBerserker:IsAvailable() and Player:Rage() < 90)) then
            if HR.Cast(S.RagingBlow) then return "raging_blow 62"; end
        end
        -- furious_slash,if=talent.furious_slash.enabled
        if S.FuriousSlash:IsCastableP("Melee") and not ShouldStop and (S.FuriousSlash:IsAvailable()) then
            if HR.Cast(S.FuriousSlash) then return "furious_slash 70"; end
        end
        -- whirlwind
        if S.Whirlwind:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Whirlwind) then return "whirlwind 74"; end
        end
    end
	
	-- Razor Coral logic with Eternal Palace
	local function RazorCoralUsage()
		-- Sivara - a bit pre 30%
        if (Target:NPCID() == 151881 or Target:NPCID() == 155144) and I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (S.RazorCoralDebuff:ActiveCount() == 0 or (S.RazorCoralDebuff:ActiveCount() > 15 and Target:HealthPercentage() <= 33)) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 115"; end
        end
		-- Radiance - I think also a bit pre 30%
        if Target:NPCID() == 152364 and I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (S.RazorCoralDebuff:ActiveCount() == 0 or (S.RazorCoralDebuff:ActiveCount() > 15 and Target:HealthPercentage() <= 33)) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 115"; end
        end
		-- Behemoth 20 sec pre phase change or line up with last CDs on the phase.
        -- Black Water Behemot timerNextPhase
        -- InstanceDifficulty - See https://wow.gamepedia.com/DifficultyID
        if (Target:NPCID() == 154986 or Target:NPCID() == 150653) and Action.DBM_GetTimer("timerNextPhase") > 0 and Action.DBM_GetTimer("timerNextPhase") <= 20 and I.AshvanesRazorCoral:IsEquipped() and (S.RazorCoralDebuff:ActiveCount() == 0 or (S.RazorCoralDebuff:ActiveCount() > 15 and Target:HealthPercentage() <= 33)) and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral behemot"; end
        end 
		-- Ashvane - a bit pre 30%
        if (Target:NPCID() == 153142 or Target:NPCID() == 152236) and I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (S.RazorCoralDebuff:ActiveCount() == 0 or (S.RazorCoralDebuff:ActiveCount() > 15 and Target:HealthPercentage() <= 33)) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 115"; end
        end
		-- Orgozoa - keep for end fight in lower realm
        if Target:NPCID() == 152128 and I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (S.RazorCoralDebuff:ActiveCount() == 0 or (S.RazorCoralDebuff:ActiveCount() > 15 and Target:HealthPercentage() <= 33)) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 115"; end
        end
		-- Court -  a bit pre 30%
        if (Target:NPCID() == 152853 or Target:NPCID() == 152852) and I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (S.RazorCoralDebuff:ActiveCount() == 0 or (S.RazorCoralDebuff:ActiveCount() > 15 and Target:HealthPercentage() <= 33)) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 115"; end
        end
	end
	
	-- call DBM precombat
    if not Player:AffectingCombat() and Action.GetToggle(1, "DBM") and not Player:IsCasting() then
        local ShouldReturn = Precombat_DBM(); 
            if ShouldReturn then return ShouldReturn; 
        end    
    end
	
    -- call non DBM precombat
    if not Player:AffectingCombat() and not Action.GetToggle(1, "DBM") and not Player:IsCasting() then        
        local ShouldReturn = Precombat(); 
            if ShouldReturn then return ShouldReturn; 
        end    
    end
	
	-- Make use of all trinkets of the game
	-- Dont forget to add check on SIMC recommanded trinkets to keep using them with APLs.
	local function TrinketsRotation(icon)
	    --print(Trinket1IsAllowed)	
        -- print(Trinket2IsAllowed)
		
       	-- Trinkets
       	if A.Trinket1:IsReady("target") and Trinket1IsAllowed and A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	return A.Trinket1:Show(icon)
   	    end 
              
   		if A.Trinket2:IsReady("target") and Trinket2IsAllowed and A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
       	   	return A.Trinket2:Show(icon)
   	    end  	   	
     	
   	end	
	
    --- In Combat
    if Player:AffectingCombat() then
        -- auto_attack
        -- augmentation
		if S.BattleShout:IsReady() and not Player:BuffP(S.BattleShout) then
            if HR.Cast(S.BattleShout) then return "BattleShout"; end
        end
		-- Interrupt Handler
 	 	
  		local unit = "target"
   		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
  	    local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
		-- Pummel
  	    if useKick and S.Pummel:IsReady() and not ShouldStop then 
		  	if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
          	    if HR.Cast(S.Pummel, true) then return "Pummel 5"; end
         	end 
      	end 
        -- charge
        --if S.Charge:IsReadyP() and S.Charge:ChargesP() >= 1 and Target:MaxDistanceToPlayer(true) >= 8 then
        --    if HR.Cast(S.Charge, Action.GetToggle(2, "OffGCDasOffGCD")) then return "charge 78"; end
        --end
		-- Victory Rush
        if S.VictoryRush:IsReady('Melee') and Player:HealthPercentage() <= Action.GetToggle(2, "VictoryRush") then
			if HR.Cast(S.VictoryRush) then return ""; end
        end
		-- ImpendingVictory
        if S.ImpendingVictory:IsReady("Melee") and not ShouldStop and Player:HealthPercentage() <= Action.GetToggle(2, "ImpendingVictory") then
		    if HR.Cast(S.VictoryRush) then return ""; end
        end
		-- execute,if=buff.enrage.up
        if S.Execute:IsCastable("Melee") and not ShouldStop and Player:BuffRemainsP(S.SuddenDeathBuff) > 1 then
		    if HR.Cast(S.Execute) then return ""; end
        end
        if S.RallyingCry:IsReady() and Player:HealthPercentage() <= Action.GetToggle(2, "RallyingCry")then
            if HR.Cast(S.RallyingCry) then return ""; end
        end

		-- Misc - Supportive 
        if A.BerserkerRage:IsReady("player") then 
            if ActionUnit("player"):HasDeBuffs("Fear") >= 4 then 
                return A.BerserkerRage:Show(icon)
            end 
        end 

        -- Interrupts
        -- run_action_list,name=movement,if=movement.distance>5
        -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
        if ((not Target:IsInRange("Melee")) and Target:IsInRange(40)) then
            return Movement();
        end
        -- potion
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_strength 84"; end
        end
        -- rampage,if=cooldown.recklessness.remains<3
        if S.Rampage:IsReadyP("Melee") and (S.Recklessness:CooldownRemainsP() < 3) then
            if HR.Cast(S.Rampage) then return "rampage 108"; end
        end
        -- blood_of_the_enemy,if=buff.recklessness.up
        if S.BloodoftheEnemy:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffP(S.RecklessnessBuff)) then
            if HR.Cast(S.BloodoftheEnemy, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_of_the_enemy"; end
        end
        -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
        if S.PurifyingBlast:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.Recklessness) and Target:DebuffDownP(S.SiegebreakerDebuff)) then
            if HR.Cast(S.PurifyingBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "purifying_blast"; end
        end
        -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
        if S.RippleInSpace:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.Recklessness) and Target:DebuffDownP(S.SiegebreakerDebuff)) then
            if HR.Cast(S.RippleInSpace, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ripple_in_space"; end
        end
        -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
        if S.WorldveinResonance:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.Recklessness) and Target:DebuffDownP(S.SiegebreakerDebuff)) then
            if HR.Cast(S.WorldveinResonance, Action.GetToggle(2, "OffGCDasOffGCD")) then return "worldvein_resonance"; end
        end
        -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
        if S.FocusedAzeriteBeam:IsCastableP() and (Cache.EnemiesCount[8] >= 4 or ActionUnit("target"):IsBoss()) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.Recklessness) and Target:DebuffDownP(S.SiegebreakerDebuff)) then
            if HR.Cast(S.FocusedAzeriteBeam, Action.GetToggle(2, "OffGCDasOffGCD")) then return "focused_azerite_beam"; end
        end
        -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
        if S.ConcentratedFlame:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.Recklessness) and Target:DebuffDownP(S.SiegebreakerDebuff) and Target:DebuffDownP(S.ConcentratedFlameBurn)) then
            if HR.Cast(S.ConcentratedFlame, Action.GetToggle(2, "OffGCDasOffGCD")) then return "concentrated_flame"; end
        end
        -- the_unbound_force,if=buff.reckless_force.up
        if S.TheUnboundForce:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffP(S.RecklessForceBuff)) then
            if HR.Cast(S.TheUnboundForce, Action.GetToggle(2, "OffGCDasOffGCD")) then return "the_unbound_force"; end
        end
        -- guardian_of_azeroth,if=!buff.recklessness.up
        if S.GuardianofAzeroth:IsCastableP() and not ShouldStop and HR.CDsON() and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.RecklessnessBuff)) then
            if HR.Cast(S.GuardianofAzeroth, Action.GetToggle(2, "OffGCDasOffGCD")) then return "guardian_of_azeroth"; end
        end
        -- memory_of_lucid_dreams,if=!buff.recklessness.up
        if S.MemoryofLucidDreams:IsCastableP() and HR.CDsON() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffDownP(S.RecklessnessBuff)) then
            if HR.Cast(S.MemoryofLucidDreams, Action.GetToggle(2, "OffGCDasOffGCD")) then return "memory_of_lucid_dreams"; end
        end
        -- Reck if rage is > 90 and SiegebreakerDebuff
        if S.Recklessness:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffRemainsP(S.SiegebreakerDebuff) > 1 or not S.Siegebreaker:IsAvailable()) and ( S.GuardianofAzeroth:CooldownRemainsP() > 20 or not S.GuardianofAzeroth:IsAvailable() ) then
            if HR.Cast(S.Recklessness, Action.GetToggle(2, "OffGCDasOffGCD")) then return "recklessness 112"; end
        end
        -- dragonroar with aoe check or target is boss
        if S.DragonRoar:IsCastableP(12) and not ShouldStop and Player:BuffP(S.EnrageBuff) and (Cache.EnemiesCount[8] > 2 or ActionUnit("target"):IsBoss()) then
            if HR.Cast(S.DragonRoar) then return "dragon_roar 39"; end
        end
        -- dragonroar pure single target and NOT AoE activated (so we force single target)
        if S.DragonRoar:IsCastableP(12) and not HR.AoEON() and not ShouldStop and Player:BuffP(S.EnrageBuff) then
            if HR.Cast(S.DragonRoar) then return "dragon_roar 39"; end
        end
        -- recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>20|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
        ---if S.Recklessness:IsCastableP() and not ShouldStop and HR.CDsON() and (not S.CondensedLifeforce:IsAvailable() and not S.BloodoftheEnemy:IsAvailable() or S.GuardianofAzeroth:CooldownRemainsP() > 20 or Player:BuffP(S.GuardianofAzeroth) or S.BloodoftheEnemy:CooldownRemainsP() < Player:GCD()) then
        ---    if HR.Cast(S.Recklessness, Action.GetToggle(2, "OffGCDasOffGCD")) then return "recklessness 112"; end
        --end
        -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
        if S.Whirlwind:IsCastableP("Melee") and not ShouldStop and HR.AoEON() and (Cache.EnemiesCount[8] > 1 and not Player:BuffP(S.MeatCleaverBuff)) then
            if HR.Cast(S.Whirlwind) then return "whirlwind 114"; end
        end
		--local currentZoneID = select(8, GetInstanceInfo())
        -- Eternal Palace Razor Coral usage
        --if Player:InRaid() and currentZoneID == 2164 then
        --    local ShouldReturn = RazorCoralUsage(); 
        --        if ShouldReturn then return ShouldReturn; 
		--	end
        --end 	
        -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(debuff.conductive_ink_debuff.up|buff.metamorphosis.remains>20)&target.health.pct<31|target.time_to_die<20
        if I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (not Target:DebuffP(S.RazorCoralDebuff) or (Target:DebuffP(S.RazorCoralDebuff) and Target:HealthPercentage() <= 30 and Target:TimeToDie() >= 10)) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 59"; end
        end
		-- Non SIMC Custom Trinket1
	    if Action.GetToggle(1, "Trinkets")[1] and A.Trinket1:IsReady("target") and Trinket1IsAllowed then	    
       	    if A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	    return A.Trinket1:Show(icon)
   	        end 		
	    end
		
		-- Non SIMC Custom Trinket2
	    if Action.GetToggle(1, "Trinkets")[2] and A.Trinket2:IsReady("target") and Trinket2IsAllowed then	    
       	    if A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
      	   	    return A.Trinket2:Show(icon)
   	        end 	
	    end
        -- blood_fury
        if S.BloodFury:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.BloodFury, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_fury 118"; end
        end
        -- berserking
        if S.Berserking:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.Berserking, Action.GetToggle(2, "OffGCDasOffGCD")) then return "berserking 122"; end
        end
       -- lights_judgment,if=buff.recklessness.down
        if S.LightsJudgment:IsCastableP() and not ShouldStop and HR.CDsON() and (Player:BuffDownP(S.RecklessnessBuff)) then
            if HR.Cast(S.LightsJudgment) then return "lights_judgment 126"; end
        end
        -- fireblood
        if S.Fireblood:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.Fireblood, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fireblood 130"; end
        end
        -- ancestral_call
        if S.AncestralCall:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.AncestralCall, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ancestral_call 134"; end
        end
        -- run_action_list,name=single_target
        if (true) then
            return SingleTarget();
        end
    end
end
-- Finished


-----------------------------------------
--           PVP ROTATION  
-----------------------------------------
-- Locals
local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
    DisablePhys                                = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                                = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    Action.IsUnitEnemy(unit) and  
    ActionUnit(unit):GetRange() <= 5 and 
    ActionUnit(unit):IsControlAble("stun", 0) and 
    A.StormBoltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.StormBoltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not Action.IsUnitEnemy("mouseover") and 
            not Action.IsUnitEnemy("target") and                     
            (
                (Action.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not Action.IsInPvP and MultiUnits:GetByRange(5, 1) >= 1)
            )
        )
    )
    then 
        return A.StormBoltGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if Action.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif Action.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = ActionUnit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
            if A.StormBoltAntiFake:IsReady(unit, nil, nil, true) and A.StormBoltAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and ActionUnit(unit):IsControlAble("stun", 0) then
                return A.StormBoltAntiFake:Show(icon)                  
            end 

			if A.IntimidatingShoutAntiFake:IsReady(unit, nil, nil, true) and A.IntimidatingShoutAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and ActionUnit(unit):IsControlAble("fear", 0) then
				return A.IntimidatingShoutAntiFake:Show(icon)
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

-- [3] is Single rotation (supports all actions)
A[3] = function(icon)
    if APL(icon) then 
        return true 
    end
end

