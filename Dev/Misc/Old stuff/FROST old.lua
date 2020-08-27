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
local TR                                     = Action.TasteRotation
local pairs                                  = pairs

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEATHKNIGHT_FROST] = {
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
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544     }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984     }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594     }), 
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generic Spells 
    RemorselessWinter                      = Action.Create({ Type = "Spell", ID = 196770     }),
    GatheringStorm                         = Action.Create({ Type = "Spell", ID = 194912     }),
    GlacialAdvance                         = Action.Create({ Type = "Spell", ID = 194913     }),
    Frostscythe                            = Action.Create({ Type = "Spell", ID = 207230     }),
    FrostStrike                            = Action.Create({ Type = "Spell", ID = 49143     }),
    HowlingBlast                           = Action.Create({ Type = "Spell", ID = 49184     }),
    RunicAttenuation                       = Action.Create({ Type = "Spell", ID = 207104     }),
    Obliterate                             = Action.Create({ Type = "Spell", ID = 49020     }),
    HornofWinter                           = Action.Create({ Type = "Spell", ID = 57330     }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    PillarofFrost                          = Action.Create({ Type = "Spell", ID = 51271     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }),
    FrostwyrmsFury                         = Action.Create({ Type = "Spell", ID = 279302     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297     }),
    EmpowerRuneWeapon                      = Action.Create({ Type = "Spell", ID = 47568     }),
    BreathofSindragosa                     = Action.Create({ Type = "Spell", ID = 152279     }),
    ColdHeart                              = Action.Create({ Type = "Spell", ID = 281208     }),
    FrozenPulse                            = Action.Create({ Type = "Spell", ID = 194909     }),
    Obliteration                           = Action.Create({ Type = "Spell", ID = 281238     }),
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998      }),
    FrozenTempest                          = Action.Create({ Type = "Spell", ID = 278487     }),
    IcyCitadel                             = Action.Create({ Type = "Spell", ID = 272718     }),
    MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528      }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
    ChillStreak                            = Action.Create({ Type = "Spell", ID = 305392     }),
    Icecap                                 = Action.Create({ Type = "Spell", ID = 207126     }),
    -- Buffs
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932     }),
    IcyCitadelBuff                         = Action.Create({ Type = "Spell", ID = 272719     }),
    UnholyStrengthBuff                     = Action.Create({ Type = "Spell", ID = 53365     }),
    DeathStrikeBuff                        = Action.Create({ Type = "Spell", ID = 101568     }),
    IcyTalonsBuff                          = Action.Create({ Type = "Spell", ID = 194879     }),
    FrozenPulseBuff                        = Action.Create({ Type = "Spell", ID = 194909     }),
    EmpowerRuneWeaponBuff                  = Action.Create({ Type = "Spell", ID = 47568     }),
    PillarofFrostBuff                      = Action.Create({ Type = "Spell", ID = 51271     }),
    ColdHeartBuff                          = Action.Create({ Type = "Spell", ID = 281209     }),
    KillingMachineBuff                     = Action.Create({ Type = "Spell", ID = 51124     }),
    RimeBuff                               = Action.Create({ Type = "Spell", ID = 59052     }), 
    SeethingRageBuff                       = Action.Create({ Type = "Spell", ID = 297126 }),  
    BreathofSindragosaBuff                 = Action.Create({ Type = "Spell", ID = 155166 }),
	-- Defensives
    IceboundFortitude                      = Action.Create({ Type = "Spell", ID = 48792 }),
    AntiMagicShell                         = Action.Create({ Type = "Spell", ID = 48707 }),
    DeathPact                              = Action.Create({ Type = "Spell", ID = 48743 }),	-- Talent
    -- Debuffs
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568     }),
    FrostFeverDebuff                       = Action.Create({ Type = "Spell", ID = 55095     }),
    RazoriceDebuff                         = Action.Create({ Type = "Spell", ID = 51714     }), 
	-- Utilities
	WraithWalk                             = Action.Create({ Type = "Spell", ID = 212552     }), 
	MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528     }),
	Asphyxiate                             = Action.Create({ Type = "Spell", ID = 108194     }),
	DeathsAdvance                          = Action.Create({ Type = "Spell", ID = 48265     }), -- 30% Speed & immune to 100% normal speed
	DeathGrip                              = Action.Create({ Type = "Spell", ID = 49576     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }), -- 70% snare, 8sec
    RaiseAlly                              = Action.Create({ Type = "Spell", ID = 61999     }),	 -- Battle rez
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
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
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
	GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574, QueueForbidden = true }),
	BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936, QueueForbidden = true }),
	RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580, QueueForbidden = true }),
	VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307, QueueForbidden = true }),
	JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627, QueueForbidden = true }),
	GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379, QueueForbidden = true }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319, QueueForbidden = true }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367, QueueForbidden = true }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413, QueueForbidden = true }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795, QueueForbidden = true }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163, QueueForbidden = true }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866, QueueForbidden = true }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380, QueueForbidden = true }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377, QueueForbidden = true }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058, QueueForbidden = true }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055, QueueForbidden = true }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625, QueueForbidden = true }),
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
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_FROST], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarOtherOnUseEquipped = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarOtherOnUseEquipped = 0
end)


-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 

    -- Icebound Fortitude
    local IceboundFortitude = Action.GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady("player") and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or
				-- Player stunned
                LoC:Get("STUN") > 0	or			
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
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            IceboundFortitude < 100 and 
            Unit("player"):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady("player") and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                    -- TTD Magic
                    Unit("player"):TimeToDieMagicX(50) < 5 or 
					
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
                ) and 
                Unit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                AntiMagicShell < 100 and 
                Unit("player"):HealthPercent() <= AntiMagicShell
            )
        ) 
        then 
            return A.AntiMagicShell
        end  		

        -- Emergency Death Pact
        local DeathPact = Action.GetToggle(2, "DeathPactHP")
        if     DeathPact >= 0 and A.DeathPact:IsReady("player") and A.DeathPact:IsSpellLearned() and 
        (
            (   -- Auto 
                DeathPact >= 100 and 
                (
                    -- HP lose per sec >= 30
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 30 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.30 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
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
                ) and 
                Unit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                DeathPact < 100 and 
                Unit("player"):HealthPercent() <= DeathPact
            )
        ) 
        then 
            return A.DeathPact
        end  

	    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
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
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 		

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)


local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    local EnemiesCasting = MultiUnits:GetByRangeCasting(10, 5, true, "TargetMouseover")
		
    -- MindFreeze
    if useKick and A.MindFreeze:IsReady(unit) then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.MindFreeze
       	end 
   	end 
	
    -- DeathGrip
    if useCC and not A.MindFreeze:IsReady(unit) and A.DeathGrip:IsReady(unit) and A.GetToggle(2, "DeathGripInterrupt") then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.DeathGrip
       	end 
   	end 
	
   	-- Asphyxiate
   	if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
 		if Unit(unit):CanInterrupt(true, nil, 25, 70) then
   	        return A.Asphyxiate
   	    end 
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
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

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

local function GuardianofAzerothIsActive() 
    return Pet:GetRemainDuration(152396) > 0 and true or false
end	

local function DeathStrikeHeal()
    return (Action.GetToggle(2, "SoloMode") and Unit("player"):HealthPercent() < Action.GetToggle(2, "UseDeathStrikeHP")) and true or false;
end

local function EvaluateCycleFrostStrike42(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned() and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike77(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate102(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike123(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate146(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and true and Player:RunicPowerDeficit() >= 25 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike165(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < 20 and not A.Frostscythe:IsSpellLearned() and A.PillarofFrost:GetCooldown() > 5
end

local function EvaluateCycleObliterate194(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike217(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate236(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPower() <= 32 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate259(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RuneTimeToX(5) < A.GetGCD() or Player:RunicPower() <= 45 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate284(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > 25 or Player:Rune() > 3 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate596(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned() and Unit("player"):HasBuffs(A.RimeBuff.ID, true) == 0 and MultiUnits:GetByRange(30, 5, 10) >= 3
end

local function EvaluateCycleObliterate629(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and bool(Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true)) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Unit("player"):GetSpellLastCast(A.FrostStrike) or Unit("player"):GetSpellLastCast(A.HowlingBlast) or Unit("player"):GetSpellLastCast(A.GlacialAdvance)))
end

local function EvaluateCycleFrostStrike670(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Unit("player"):HasBuffs(A.RimeBuff.ID, true) == 0 or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD() and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate693(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"
    local DeathStrikeHeal = DeathStrikeHeal()
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Aoe, BosPooling, BosTicking, ColdHeart, Cooldowns, Essences, Obliteration, Standard
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
			and (Pull > 0 and Pull <= 2 or not A.GetToggle(1 ,"DBM"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) 
			and (Pull > 0 and Pull <= 6 or not A.GetToggle(1 ,"DBM"))
			then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- variable,name=other_on_use_equipped,value=(equipped.notorious_gladiators_badge|equipped.sinister_gladiators_badge|equipped.sinister_gladiators_medallion|equipped.vial_of_animated_blood|equipped.first_mates_spyglass|equipped.jes_howler|equipped.notorious_gladiators_medallion|equipped.ashvanes_razor_coral)
            if (true) then
                VarOtherOnUseEquipped = num((A.NotoriousGladiatorsBadge:IsExists() or A.SinisterGladiatorsBadge:IsExists() or A.SinisterGladiatorsMedallion:IsExists() or A.VialofAnimatedBlood:IsExists() or A.FirstMatesSpyglass:IsExists() or A.JesHowler:IsExists() or A.NotoriousGladiatorsMedallion:IsExists() or A.AshvanesRazorCoral:IsExists()))
            end
            -- use_item,name=azsharas_font_of_power
            if A.ChainsofIce:IsReady(unit) 
			and (Pull > 0 and Pull <= 1 or not A.GetToggle(1 ,"DBM"))
			then
                return A.ChainsofIce:Show(icon)
            end			
        end
        
        --Aoe
        local function Aoe(unit)
            -- remorseless_winter,if=talent.gathering_storm.enabled|(azerite.frozen_tempest.rank&spell_targets.remorseless_winter>=3&!buff.rime.up)
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned() or (bool(A.FrozenTempest:GetAzeriteRank()) and MultiUnits:GetByRange(8, 5, 10) >= 3 and Unit("player"):HasBuffs(A.RimeBuff.ID, true) == 0)) then
                return A.RemorselessWinter:Show(icon)
            end
            -- glacial_advance,if=talent.frostscythe.enabled
            if A.GlacialAdvance:IsReady(unit) and (A.Frostscythe:IsSpellLearned()) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike42) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and (A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) > 0) then
                return A.HowlingBlast:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up
            if A.Frostscythe:IsReady("player") and A.Frostscythe:IsSpellLearned() and Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) > 0 then
                return A.Frostscythe:Show(icon)
            end
            -- glacial_advance,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<(15+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike77) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            -- frostscythe
            if A.Frostscythe:IsReady("player") then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>(25+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate102) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance
            if A.GlacialAdvance:IsReady(unit) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike123) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike
            if A.FrostStrike:IsReady(unit) then
                return A.FrostStrike:Show(icon)
            end
            -- horn_of_winter
            if A.HornofWinter:IsReady(unit) then
                return A.HornofWinter:Show(icon)
            end
            -- arcane_torrent
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        --BosPooling
        local function BosPooling(unit)
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) > 0) then
                return A.HowlingBlast:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&&runic_power.deficit>=25&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate146) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>=25
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() >= 25) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance,if=runic_power.deficit<20&spell_targets.glacial_advance>=2&cooldown.pillar_of_frost.remains>5
            if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and MultiUnits:GetByRange(30, 5, 10) >= 2 and A.PillarofFrost:GetCooldown() > 5) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<20&!talent.frostscythe.enabled&cooldown.pillar_of_frost.remains>5
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike165) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>5
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > 5) then
                return A.FrostStrike:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up&runic_power.deficit>(15+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady("player") and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and Player:RunicPowerDeficit() > (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and MultiUnits:GetByRange(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- frostscythe,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady("player") and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and MultiUnits:GetByRange(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate194) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and MultiUnits:GetByRange(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike217) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40
            if A.FrostStrike:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40) then
                return A.FrostStrike:Show(icon)
            end
        end
        
        --BosTicking
        local function BosTicking(unit)
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power<=32&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate236) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power<=32
            if A.Obliterate:IsReady(unit) and (Player:RunicPower() <= 32) then
                return A.Obliterate:Show(icon)
            end
            -- remorseless_winter,if=talent.gathering_storm.enabled
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned()) then
                return A.RemorselessWinter:Show(icon)
            end
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) > 0) then
                return A.HowlingBlast:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&rune.time_to_5<gcd|runic_power<=45&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate259) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=rune.time_to_5<gcd|runic_power<=45
            if A.Obliterate:IsReady(unit) and (Player:RuneTimeToX(5) < A.GetGCD() or Player:RunicPower() <= 45) then
                return A.Obliterate:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady("player") and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and MultiUnits:GetByRange(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- horn_of_winter,if=runic_power.deficit>=32&rune.time_to_3>gcd
            if A.HornofWinter:IsReady(unit) and (Player:RunicPowerDeficit() >= 32 and Player:RuneTimeToX(3) > A.GetGCD()) then
                return A.HornofWinter:Show(icon)
            end
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            -- frostscythe,if=spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady("player") and (MultiUnits:GetByRange(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>25|rune>3&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate284) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>25|rune>3
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > 25 or Player:Rune() > 3) then
                return A.Obliterate:Show(icon)
            end
            -- arcane_torrent,if=runic_power.deficit>50
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 50) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        --ColdHeart
        local function ColdHeart(unit)
            -- chains_of_ice,if=buff.cold_heart.stack>5&Unit(unit):TimeToDie()<gcd
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) > 5 and Unit(unit):TimeToDie() < A.GetGCD()) then
                return A.ChainsofIce:Show(icon)
            end
            -- chains_of_ice,if=(buff.seething_rage.remains<gcd)&buff.seething_rage.up
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) < A.GetGCD()) and Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) > 0) then
                return A.ChainsofIce:Show(icon)
            end

            -- chains_of_ice,if=(buff.pillar_of_frost.remains<=gcd*(1+cooldown.frostwyrms_fury.ready)|buff.pillar_of_frost.remains<rune.time_to_3)&buff.pillar_of_frost.up&(azerite.icy_citadel.rank<=1|buff.breath_of_sindragosa.up)&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= A.GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) or Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < Player:RuneTimeToX(3)) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and (A.IcyCitadel:GetAzeriteRank() <= 1 or Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0) and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
			
            -- chains_of_ice,if=buff.pillar_of_frost.remains<8&buff.unholy_strength.remains<gcd*(1+cooldown.frostwyrms_fury.ready)&buff.unholy_strength.remains&buff.pillar_of_frost.up&(azerite.icy_citadel.rank<=1|buff.breath_of_sindragosa.up)&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 8 and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) < A.GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and (A.IcyCitadel:GetAzeriteRank() <= 1 or Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0) and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
			
            -- chains_of_ice,if=(buff.icy_citadel.remains<4|buff.icy_citadel.remains<rune.time_to_3)&buff.icy_citadel.up&azerite.icy_citadel.rank>=2&!buff.breath_of_sindragosa.up&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < 4 or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < Player:RuneTimeToX(3)) and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and A.IcyCitadel:GetAzeriteRank() >= 2 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
			
            -- chains_of_ice,if=buff.icy_citadel.up&buff.unholy_strength.up&azerite.icy_citadel.rank>=2&!buff.breath_of_sindragosa.up&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 and A.IcyCitadel:GetAzeriteRank() >= 2 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
			
            -- chains_of_ice,if=buff.pillar_of_frost.remains<4&buff.pillar_of_frost.up&talent.icecap.enabled&buff.cold_heart.stack>=18&azerite.icy_citadel.rank<=1
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 4 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.Icecap:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 18 and A.IcyCitadel:GetAzeriteRank() <= 1) then
                return A.ChainsofIce:Show(icon)
            end
			
            -- chains_of_ice,if=buff.pillar_of_frost.up&talent.icecap.enabled&azerite.icy_citadel.rank>=2&(buff.cold_heart.stack>=19&buff.icy_citadel.remains<gcd&buff.icy_citadel.up|buff.unholy_strength.up&buff.cold_heart.stack>=18)
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() >= 2 and (Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 19 and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < A.GetGCD() and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 and Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 18)) then
                return A.ChainsofIce:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- use_item,name=azsharas_font_of_power,if=(cooldown.empowered_rune_weapon.ready&!variable.other_on_use_equipped)|(cooldown.pillar_of_frost.remains<=10&variable.other_on_use_equipped)
            if A.AzsharasFontofPower:IsReady(unit) and ((A.EmpowerRuneWeapon:GetCooldown() == 0 and not bool(VarOtherOnUseEquipped)) or (A.PillarofFrost:GetCooldown() <= 10 and bool(VarOtherOnUseEquipped))) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=lurkers_insidious_gift,if=talent.breath_of_sindragosa.enabled&((cooldown.pillar_of_frost.remains<=10&variable.other_on_use_equipped)|(buff.pillar_of_frost.up&!variable.other_on_use_equipped))|(buff.pillar_of_frost.up&!talent.breath_of_sindragosa.enabled)
            if A.LurkersInsidiousGift:IsReady(unit) and (A.BreathofSindragosa:IsSpellLearned() and ((A.PillarofFrost:GetCooldown() <= 10 and bool(VarOtherOnUseEquipped)) or (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and not bool(VarOtherOnUseEquipped))) or (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and not A.BreathofSindragosa:IsSpellLearned())) then
                return A.LurkersInsidiousGift:Show(icon)
            end
			
            -- use_item,name=cyclotronic_blast,if=!buff.pillar_of_frost.up
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0) then
                return A.CyclotronicBlast:Show(icon)
            end
			
            -- use_items,if=(cooldown.pillar_of_frost.ready|cooldown.pillar_of_frost.remains>20)&(!talent.breath_of_sindragosa.enabled|cooldown.empower_rune_weapon.remains>95)
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=cooldown.empower_rune_weapon.remains>90&debuff.razor_coral_debuff.up&variable.other_on_use_equipped|buff.breath_of_sindragosa.up&debuff.razor_coral_debuff.up&!variable.other_on_use_equipped|buff.empower_rune_weapon.up&debuff.razor_coral_debuff.up&!talent.breath_of_sindragosa.enabled|Unit(unit):TimeToDie()<21
            if A.AshvanesRazorCoral:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 90 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and bool(VarOtherOnUseEquipped) or Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and not bool(VarOtherOnUseEquipped) or Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and not A.BreathofSindragosa:IsSpellLearned() or Unit(unit):TimeToDie() < 21) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=jes_howler,if=(equipped.lurkers_insidious_gift&buff.pillar_of_frost.remains)|(!equipped.lurkers_insidious_gift&buff.pillar_of_frost.remains<12&buff.pillar_of_frost.up)
            if A.JesHowler:IsReady(unit) and ((A.LurkersInsidiousGift:IsExists() and bool(Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0)) or (not A.LurkersInsidiousGift:IsExists() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 12 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0)) then
                return A.JesHowler:Show(icon)
            end
			
            -- use_item,name=knot_of_ancient_fury,if=cooldown.empower_rune_weapon.remains>40
            if A.KnotofAncientFuryAlliance:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 40) then
                return A.KnotofAncientFuryAlliance:Show(icon)
            end
			
            -- use_item,name=knot_of_ancient_fury,if=cooldown.empower_rune_weapon.remains>40
            if A.KnotofAncientFuryHorde:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 40) then
                return A.KnotofAncientFuryHorde:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage,if=rune<=3&!buff.pillar_of_frost.up&(!buff.breath_of_sindragosa.up|!talent.breath_of_sindragosa.enabled)
            if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and (Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 or not A.BreathofSindragosa:IsSpellLearned())) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                return A.RazdunksBigRedButton:Show(icon)
            end
			
            -- use_item,name=merekthas_fang,if=!buff.breath_of_sindragosa.up&!buff.pillar_of_frost.up
            if A.MerekthasFang:IsReady(unit) and (Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0) then
                return A.MerekthasFang:Show(icon)
            end
			
            -- potion,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- blood_fury,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking,if=buff.pillar_of_frost.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) then
                return A.Berserking:Show(icon)
            end
			
            -- arcane_pulse,if=(!buff.pillar_of_frost.up&active_enemies>=2)|!buff.pillar_of_frost.up&(rune.deficit>=5&runic_power.deficit>=60)
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and MultiUnits:GetByRange(10) >= 2) or Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and (Player:RuneDeficit() >= 5 and Player:RunicPowerDeficit() >= 60)) then
                return A.ArcanePulse:Show(icon)
            end
			
            -- lights_judgment,if=buff.pillar_of_frost.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- ancestral_call,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                return A.AncestralCall:Show(icon)
            end
			
            -- fireblood,if=buff.pillar_of_frost.remains<=8&buff.empower_rune_weapon.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= 8 and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                return A.Fireblood:Show(icon)
            end
			
            -- pillar_of_frost,if=cooldown.empower_rune_weapon.remains|talent.icecap.enabled
            if A.PillarofFrost:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 0 or A.Icecap:IsSpellLearned()) then
                return A.PillarofFrost:Show(icon)
            end		
			
            -- breath_of_sindragosa,use_off_gcd=1,if=cooldown.empower_rune_weapon.remains&cooldown.pillar_of_frost.remains
            if A.BreathofSindragosa:IsReadyByPassCastGCD(unit, nil, nil, true) 
			and (A.EmpowerRuneWeapon:GetCooldown() > 0 and A.PillarofFrost:GetCooldown() > 0) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID) > 0  and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID) < 4 
			then
                return A.BreathofSindragosa:Show(icon)
            end
			
            -- empower_rune_weapon,if=cooldown.pillar_of_frost.ready&talent.obliteration.enabled&rune.time_to_5>gcd&runic_power.deficit>=10|target.1.time_to_die<20
            if A.EmpowerRuneWeapon:IsReady(unit) and (A.PillarofFrost:GetCooldown() == 0 and A.Obliteration:IsSpellLearned() and Player:RuneTimeToX(5) > A.GetGCD() and Player:RunicPowerDeficit() >= 10 or Unit(unit):TimeToDie() < 20) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
			
            -- empower_rune_weapon,if=(cooldown.pillar_of_frost.ready|Unit(unit):TimeToDie()<20)&talent.breath_of_sindragosa.enabled&runic_power>60
            if A.EmpowerRuneWeapon:IsReadyByPassCastGCD("player", nil, nil, true) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID) > 0  and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID) < 5 and A.BreathofSindragosa:IsSpellLearned() and Player:RunicPower() > 60 then
                return A.EmpowerRuneWeapon:Show(icon)
            end

            -- empower_rune_weapon,if=talent.icecap.enabled&rune<3
            if A.EmpowerRuneWeapon:IsReady(unit) and (A.Icecap:IsSpellLearned() and Player:Rune() < 3) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
			
	        -- call_action_list,name=cold_heart,if=talent.cold_heart.enabled&((buff.cold_heart.stack>=10&debuff.razorice.stack=5)|Unit(unit):TimeToDie()<=gcd)
            if (A.ColdHeart:IsSpellLearned() and ((Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 10 and Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) == 5) or Unit(unit):TimeToDie() <= A.GetGCD())) then
                if ColdHeart(unit) then
				    return true
				end
            end	
			
            -- pillar_of_frost,if=cooldown.empower_rune_weapon.remains
            if A.PillarofFrost:IsReady(unit) then
                return A.PillarofFrost:Show(icon)
            end

            -- frostwyrms_fury,if=(buff.pillar_of_frost.up&azerite.icy_citadel.rank<=1&(buff.pillar_of_frost.remains<=gcd|buff.unholy_strength.remains<=gcd&buff.unholy_strength.up))
            if A.FrostwyrmsFury:IsReady(unit) and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.IcyCitadel:GetAzeriteRank() <= 1 and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= A.GetGCD() or Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) <= A.GetGCD() and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0))) then
                return A.FrostwyrmsFury:Show(icon)
            end
			
            -- frostwyrms_fury,if=(buff.icy_citadel.up&!talent.icecap.enabled&(buff.unholy_strength.up|buff.icy_citadel.remains<=gcd))|buff.icy_citadel.up&buff.icy_citadel.remains<=gcd&talent.icecap.enabled&buff.pillar_of_frost.up
            if A.FrostwyrmsFury:IsReady(unit) and ((Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and not A.Icecap:IsSpellLearned() and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) <= A.GetGCD())) or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) <= A.GetGCD() and A.Icecap:IsSpellLearned() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) then
                return A.FrostwyrmsFury:Show(icon)
            end
			
            -- frostwyrms_fury,if=Unit(unit):TimeToDie()<gcd|(Unit(unit):TimeToDie()<cooldown.pillar_of_frost.remains&buff.unholy_strength.up)
            if A.FrostwyrmsFury:IsReady(unit) and (Unit(unit):TimeToDie() < A.GetGCD() or (Unit(unit):TimeToDie() < A.PillarofFrost:GetCooldown() and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0)) then
                return A.FrostwyrmsFury:Show(icon)
            end
        end
        
        --Essences
        local function Essences(unit)
		
            -- blood_of_the_enemy,if=buff.pillar_of_frost.up&(buff.pillar_of_frost.remains<10&(buff.breath_of_sindragosa.up|talent.obliteration.enabled|talent.icecap.enabled&!azerite.icy_citadel.enabled)|buff.icy_citadel.up&talent.icecap.enabled)
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 10 and (Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 or A.Obliteration:IsSpellLearned() or A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() == 0) or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and A.Icecap:IsSpellLearned())) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth,if=!talent.icecap.enabled|talent.icecap.enabled&azerite.icy_citadel.enabled&buff.pillar_of_frost.remains<6&buff.pillar_of_frost.up|talent.icecap.enabled&!azerite.icy_citadel.enabled
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Icecap:IsSpellLearned() or A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 6 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 or A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() == 0) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReapingFlames:Show(icon)
            end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReplicaofKnowledge:Show(icon)
            end		
			
            -- chill_streak,if=buff.pillar_of_frost.remains<5&buff.pillar_of_frost.up|Unit(unit):TimeToDie()<5
            if A.ChillStreak:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 5 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 or Unit(unit):TimeToDie() < 5) then
                return A.ChillStreak:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- focused_azerite_beam,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- concentrated_flame,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- purifying_blast,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0) then
                return A.PurifyingBlast:Show(icon)
            end
			
	        -- worldvein_resonance,if=buff.pillar_of_frost.up|buff.empower_rune_weapon.up|cooldown.breath_of_sindragosa.remains>60+15
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0 or A.BreathofSindragosa:GetCooldown() > 60 + 15) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.RippleInSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0) then
                return A.RippleInSpace:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=buff.empower_rune_weapon.remains<5&buff.breath_of_sindragosa.up|(rune.time_to_2>gcd&runic_power<50)
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) < 5 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 or (Player:RuneTimeToX(2) > A.GetGCD() and Player:RunicPower() < 50)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
        end
        
        --Obliteration
        local function Obliteration(unit)
            -- remorseless_winter,if=talent.gathering_storm.enabled
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned()) then
                return A.RemorselessWinter:Show(icon)
            end
			
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate596) then
                    return A.Obliterate:Show(icon) 
                end
            end
			
            -- obliterate,if=!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
            if A.Obliterate:IsReady(unit) and (not A.Frostscythe:IsSpellLearned() and Unit("player"):HasBuffs(A.RimeBuff.ID, true) == 0 and MultiUnits:GetByRange(30, 5, 10) >= 3) then
                return A.Obliterate:Show(icon)
            end
			
            -- frostscythe,if=(buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance)))&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady("player") and ((bool(Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true) > 0) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and (Unit("player"):GetSpellLastCast(A.FrostStrike) or Unit("player"):GetSpellLastCast(A.HowlingBlast) or Unit("player"):GetSpellLastCast(A.GlacialAdvance)))) and MultiUnits:GetByRange(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
			
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate629) then
                    return A.Obliterate:Show(icon) 
                end
            end
			
            -- obliterate,if=buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
            if A.Obliterate:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true) > 0) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and (Unit("player"):GetSpellLastCast(A.FrostStrike) or Unit("player"):GetSpellLastCast(A.HowlingBlast) or Unit("player"):GetSpellLastCast(A.GlacialAdvance)))) then
                return A.Obliterate:Show(icon)
            end
			
            -- glacial_advance,if=(!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd)&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and ((Unit("player"):HasBuffs(A.RimeBuff.ID, true) == 0 or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD()) and MultiUnits:GetByRange(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
			
            -- howling_blast,if=buff.rime.up&spell_targets.howling_blast>=2
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) > 0 and MultiUnits:GetByRange(30, 5, 10) >= 2) then
                return A.HowlingBlast:Show(icon)
            end
			
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike670) then
                    return A.FrostStrike:Show(icon) 
                end
            end
			
            -- frost_strike,if=!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd
            if A.FrostStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) == 0 or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD()) then
                return A.FrostStrike:Show(icon)
            end
			
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) > 0) then
                return A.HowlingBlast:Show(icon)
            end
			
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate693) then
                    return A.Obliterate:Show(icon) 
                end
            end
			
            -- obliterate
            if A.Obliterate:IsReady(unit) then
                return A.Obliterate:Show(icon)
            end
			
        end
        
        --Standard
        local function Standard(unit)
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
			
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and (A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
			
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) > 0) then
                return A.HowlingBlast:Show(icon)
            end
			
            -- obliterate,if=talent.icecap.enabled&buff.pillar_of_frost.up&azerite.icy_citadel.rank>=2
            if A.Obliterate:IsReady(unit) and (A.Icecap:IsSpellLearned() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.IcyCitadel:GetAzeriteRank() >= 2) then
                return A.Obliterate:Show(icon)
            end
						
            -- obliterate,if=!buff.frozen_pulse.up&talent.frozen_pulse.enabled
            if A.Obliterate:IsReady(unit) and (Unit("player"):HasBuffs(A.FrozenPulseBuff.ID, true) == 0 and A.FrozenPulse:IsSpellLearned()) then
                return A.Obliterate:Show(icon)
            end
			
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.FrostStrike:Show(icon)
            end
			
            -- frostscythe,if=buff.killing_machine.up&rune.time_to_4>=gcd
            if A.Frostscythe:IsReady("player") and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and Player:RuneTimeToX(4) >= A.GetGCD()) then
                return A.Frostscythe:Show(icon)
            end
			
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
			
            -- frost_strike
            if A.FrostStrike:IsReady(unit) then
                return A.FrostStrike:Show(icon)
            end
			
            -- horn_of_winter
            if A.HornofWinter:IsReady(unit) then
                return A.HornofWinter:Show(icon)
            end
			
            -- arcane_torrent
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end

            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end
			
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
           
		    -- auto_attack
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end			
			
			-- Chains of Ice
			if Unit(unit):IsMovingOut() and A.GetToggle(2, "UseChainsofIce") and A.ChainsofIce:IsReady(unit) and Unit(unit):HasDeBuffs(A.ChainsofIce.ID, true) == 0 then
			    return A.ChainsofIce:Show(icon) 
			end
			
			-- Death Grip
			if Unit(unit):IsMovingOut() and A.GetToggle(2, "UseDeathGrip") and Unit(unit):HasDeBuffs(A.ChainsofIce.ID, true) > 0 and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 then
			    return A.DeathGrip:Show(icon) 
			end
			
			-- Wraith Walk if out of range 
            if A.WraithWalk:IsReady("player") and isMovingFor > A.GetToggle(2, "WraithWalkTime") and A.GetToggle(2, "UseWraithWalk") then
                return A.WraithWalk:Show(icon)
            end
			
			-- Deaths Advance if out of range 
            if A.DeathsAdvance:IsReady("player") and isMovingFor > A.GetToggle(2, "DeathsAdvanceTime") and A.GetToggle(2, "UseDeathsAdvance") then
                return A.DeathsAdvance:Show(icon)
            end
            
            -- use DeathStrike on low HP in Solo Mode
            if DeathStrikeHeal and A.DeathStrike:IsReady(unit) then
                return A.DeathStrike:Show(icon) 
            end	
			
			-- howling_blast,if=!dot.frost_fever.ticking&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.HowlingBlast:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FrostFeverDebuff.ID, true) == 0 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.HowlingBlast:Show(icon)
            end
            
			-- glacial_advance,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&spell_targets.glacial_advance>=2&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.GlacialAdvance:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) <= A.GetGCD() and Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) > 0 and MultiUnits:GetByRange(30, 5, 10) >= 2 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.GlacialAdvance:Show(icon)
            end
            
			-- frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.FrostStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) <= A.GetGCD() and Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) > 0 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.FrostStrike:Show(icon)
            end
            
			-- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
			-- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
			-- run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&((cooldown.breath_of_sindragosa.remains=0&cooldown.pillar_of_frost.remains<10)|(cooldown.breath_of_sindragosa.remains<20&Unit(unit):TimeToDie()<35))
            if (A.BreathofSindragosa:IsSpellLearned() and ((A.BreathofSindragosa:GetCooldown() == 0 and A.PillarofFrost:GetCooldown() < 10) or (A.BreathofSindragosa:GetCooldown() < 20 and Unit(unit):TimeToDie() < 35))) then
                return BosPooling(unit);
            end
            
			-- run_action_list,name=bos_ticking,if=buff.breath_of_sindragosa.up
            if (Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0) then
                return BosTicking(unit);
            end
            
			-- run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
            if (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.Obliteration:IsSpellLearned()) then
                return Obliteration(unit);
            end
            
			-- run_action_list,name=aoe,if=active_enemies>=2
            if (MultiUnits:GetByRange(10, 5, 10) >= 2) then
                return Aoe(unit);
            end
            
			-- call_action_list,name=standard
            if Standard(unit) then
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

