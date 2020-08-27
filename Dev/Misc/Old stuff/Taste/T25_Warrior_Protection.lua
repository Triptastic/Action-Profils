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
Action[ACTION_CONST_WARRIOR_PROTECTION] = {
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
    ThunderClap                            = Action.Create({ Type = "Spell", ID = 6343 }),
    AvatarBuff                             = Action.Create({ Type = "Spell", ID = 107574 }),
    DemoralizingShout                      = Action.Create({ Type = "Spell", ID = 1160 }),
    BoomingVoice                           = Action.Create({ Type = "Spell", ID = 202743 }),
    LastStandBuff                          = Action.Create({ Type = "Spell", ID = 12975, Hidden = true     }),
    DragonRoar                             = Action.Create({ Type = "Spell", ID = 118000 }),
    Revenge                                = Action.Create({ Type = "Spell", ID = 6572 }),
    Ravager                                = Action.Create({ Type = "Spell", ID = 228920 }),
    ShieldBlock                            = Action.Create({ Type = "Spell", ID = 2565 }),
    ShieldSlam                             = Action.Create({ Type = "Spell", ID = 23922 }),
    ShieldBlockBuff                        = Action.Create({ Type = "Spell", ID = 132404 }),
    UnstoppableForce                       = Action.Create({ Type = "Spell", ID = 275336 }),
    Avatar                                 = Action.Create({ Type = "Spell", ID = 107574 }),
    Devastate                              = Action.Create({ Type = "Spell", ID = 20243 }),
    Intercept                              = Action.Create({ Type = "Spell", ID = 198304 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    IgnorePain                             = Action.Create({ Type = "Spell", ID = 190456 }),
    LastStand                              = Action.Create({ Type = "Spell", ID = 12975     }),
	ShieldWall                             = Action.Create({ Type = "Spell", ID = 871    }),
	-- Utilities
    VictoryRush                            = Action.Create({ Type = "Spell", ID = 34428     }),
    ImpendingVictory                       = Action.Create({ Type = "Spell", ID = 202168     }),
    Pummel                                 = Action.Create({ Type = "Spell", ID = 6552     }),
	PummelGreen	                           = Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true}), 
    IntimidatingShout                      = Action.Create({ Type = "Spell", ID = 5246     }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
	StormBolt                              = Action.Create({ Type = "Spell", ID = 107570}),
 	StormBoltGreen                         = Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true}),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Trinkets  
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319, QueueForbidden = true }),
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367, QueueForbidden = true }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413, QueueForbidden = true }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795, QueueForbidden = true }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163, QueueForbidden = true }),
    GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574, QueueForbidden = true }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866, QueueForbidden = true }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380, QueueForbidden = true }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377, QueueForbidden = true }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058, QueueForbidden = true }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055, QueueForbidden = true }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625, QueueForbidden = true }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627, QueueForbidden = true }),
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })


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
	BigDeff                                 = {A.ShieldWall.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function isCurrentlyTanking()
    -- is player currently tanking any enemies within 16 yard radius
    local IsTanking = Player:IsTankingAoE(16) or Player:IsTanking(Target);
    return IsTanking;
end

local function shouldCastIp()
    if Unit("player"):HasBuffs(A.IgnorePain.ID, true) > 0 then 
        local castIP = tonumber((GetSpellDescription(190456):match("%d+%S+%d"):gsub("%D","")))
        local IPCap = math.floor(castIP * 1.3);
        local currentIp = Unit("player"):HasBuffs(A.IgnorePain.ID, true)

        -- Dont cast IP if we are currently at 50% of IP Cap remaining
        if currentIp  < (0.5 * IPCap) then
            return true
        else
            return false
        end
    else
        -- No IP buff currently
        return true
    end
end

local function offensiveShieldBlock()
    return not Action.GetToggle(2, "UseShieldBlockDefensively") and true or false
end

local function offensiveRage()
    return not Action.GetToggle(2, "UseRageDefensively") and true or false 
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.StormBoltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if	A.StormBoltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormBoltGreen:Show(icon)         
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
            
			-- StormBolt
            if A.StormBolt:IsReady(unit, nil, nil, true) and A.StormBolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.StormBolt:Show(icon)                  
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

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
	
    -- ShieldBlock (any role, whenever have physical damage)
    if Player:Rage() >= A.ShieldBlock:GetSpellPowerCostCache() and A.ShieldBlock:IsReady("player", nil, nil, nil, true) and Unit("player"):GetRealTimeDMG(3) > 0 then 
        return A.ShieldBlock:Show(icon)
    end 
	
    -- LastStand
    if A.LastStand:IsReadyByPassCastGCD("player", nil, nil, true) and (not A.GetToggle(2, "LastStandIgnoreBigDeff") or Unit("player"):HasBuffs(Temp.BigDeff) == 0) then 
        local LS_HP                 = A.GetToggle(2, "LastStandHP")
        local LS_TTD                = A.GetToggle(2, "LastStandTTD")
            
        if  (    
                ( LS_HP     >= 0     or LS_TTD                              >= 0                                        ) and 
                ( LS_HP     <= 0     or Unit("player"):HealthPercent()     <= LS_HP                                    ) and 
                ( LS_TTD     <= 0     or Unit("player"):TimeToDie()         <= LS_TTD                                      ) 
            ) 
		    or 
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
		
		
    -- ShieldWall
    if A.ShieldWall:IsReadyByPassCastGCD("player", nil, nil, true) then 
        local SW_HP                 = A.GetToggle(2, "ShieldWallHP")
        local SW_TTD                = A.GetToggle(2, "ShieldWallTTD")
            
        if  (    
                ( SW_HP     >= 0     or SW_TTD                              >= 0                                        ) and 
                ( SW_HP     <= 0     or Unit("player"):HealthPercent()     <= SW_HP                                    ) and 
                ( SW_TTD     <= 0     or Unit("player"):TimeToDie()         <= SW_TTD      )  
            ) 
			or 
            (
                A.GetToggle(2, "ShieldWallCatchKillStrike") and 
                (
                    ( Unit("player"):GetDMG()         >= Unit("player"):Health() and Unit("player"):HealthPercent() <= 20 ) or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):Health() or 
                    Unit("player"):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- ShieldBlock
            if A.ShieldBlock:IsReadyByPassCastGCD("player", nil, nil, true) and Player:Rage() >= A.ShieldBlock:GetSpellPowerCostCache() then  
                A.ShieldBlock:Show(icon)        -- #4
            end 
                
            -- ShieldWall
            return A.ShieldWall:Show(icon)         -- #3                  
             
        end 
    end 		 
	
	-- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                -- TTD 
                Unit("player"):TimeToDieX(20) < 5 or 
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
    
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
	    -- Notification					
        Action.SendNotification("Pummel interrupting on Target ", A.Pummel.ID)
        return A.Pummel
    end 
    
    if useCC and A.Stormbolt:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	    -- Notification					
        Action.SendNotification("HammerofJustice interrupting...", A.HammerofJustice.ID)
        return A.HammerofJustice              
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

local function EvaluateCycleAshvanesRazorCoral84(unit)
    return Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0
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
        local Precombat, Aoe, St
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
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and A.BurstIsON(unit) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and A.BurstIsON(unit) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and A.BurstIsON(unit) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- thunder_clap
            if A.ThunderClap:IsReady(unit) then
                return A.ThunderClap:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=buff.avatar.down
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- demoralizing_shout,if=talent.booming_voice.enabled
            if A.DemoralizingShout:IsReady(unit) and A.BoomingVoice:IsSpellLearned() then
                return A.DemoralizingShout:Show(icon)
            end
			
            -- anima_of_death,if=buff.last_stand.up
            if A.AnimaofDeath:IsReady(unit) and Unit("player"):HasBuffs(A.LastStandBuff.ID, true) > 0 then
                return A.AnimaofDeath:Show(icon)
            end
			
            -- dragon_roar
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                return A.DragonRoar:Show(icon)
            end
			
            -- revenge
            if A.Revenge:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.thunder_clap.remains>=4
            if A.GrongsPrimalRage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) or A.ThunderClap:GetCooldown() >= 4) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
            -- ravager
            if A.Ravager:IsReady(unit) then
                return A.Ravager:Show(icon)
            end
			
            -- shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
			
        end
        
        --St
        local function St(unit)
            -- thunder_clap,if=spell_targets.thunder_clap=2&talent.unstoppable_force.enabled&buff.avatar.up
            if A.ThunderClap:IsReady(unit) and (MultiUnits:GetByRange(5) == 2 and A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff.ID, true) > 0) then
                return A.ThunderClap:Show(icon)
            end
			
            -- shield_slam,if=buff.shield_block.up
            if A.ShieldSlam:IsReady(unit) and (Unit("player"):HasBuffs(A.ShieldBlockBuff.ID, true) > 0) then
                return A.ShieldSlam:Show(icon)
            end
			
            -- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up)
            if A.ThunderClap:IsReady(unit) and ((A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff.ID, true) > 0)) then
                return A.ThunderClap:Show(icon)
            end
			
            -- demoralizing_shout,if=talent.booming_voice.enabled
            if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
                return A.DemoralizingShout:Show(icon)
            end
			
            -- anima_of_death,if=buff.last_stand.up
            if A.AnimaofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.LastStandBuff.ID, true) > 0) then
                return A.AnimaofDeath:Show(icon)
            end
			
            -- shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,target_if=debuff.razor_coral_debuff.stack=0
            if A.AshvanesRazorCoral:IsReady(unit) then
                if Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0 then
                    return A.AshvanesRazorCoral:Show(icon) 
                end
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack>7&(cooldown.avatar.remains<5|buff.avatar.up)
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 7 and (A.Avatar:GetCooldown() < 5 or Unit("player"):HasBuffs(A.AvatarBuff.ID, true) > 0)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- dragon_roar
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                return A.DragonRoar:Show(icon)
            end
			
            -- thunder_clap
            if A.ThunderClap:IsReady(unit) then
                return A.ThunderClap:Show(icon)
            end
			
            -- revenge
            if A.Revenge:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.shield_slam.remains>=4
            if A.GrongsPrimalRage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) or A.ShieldSlam:GetCooldown() >= 4) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
            -- ravager
            if A.Ravager:IsReady(unit) then
                return A.Ravager:Show(icon)
            end
			
            -- devastate
            if A.Devastate:IsReady(unit) then
                return A.Devastate:Show(icon)
            end
        end        
        
        -- call precombat
        if not inCombat and Precombat(unit) and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
                    -- auto_attack
            -- intercept,if=time=0
          --  if A.Intercept:IsReady(unit) and (Unit("player"):CombatTime() == 0) then
          --      return A.Intercept:Show(icon)
          --  end
			
            -- use_items,if=cooldown.avatar.remains<=gcd|buff.avatar.up
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
			
            -- arcane_torrent
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
			
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
			
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
			
            -- potion,if=buff.avatar.up|target.time_to_die<25
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AvatarBuff.ID, true) > 0 or Unit(unit):TimeToDie() < 25) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready
            if A.IgnorePain:IsReady(unit) and (Player:RageDeficit() < 25 + 20 * num(A.BoomingVoice:IsSpellLearned()) * num(A.DemoralizingShout:GetCooldown() == 0)) then
                return A.IgnorePain:Show(icon)
            end
			
            -- worldvein_resonance,if=cooldown.avatar.remains<=2
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Avatar:GetCooldown() <= 2) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- concentrated_flame,if=buff.avatar.down&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 then
                return A.ConcentratedFlame:Show(icon)
            end
						
            -- avatar
            if A.Avatar:IsReady(unit) and A.BurstIsON(unit) then
                return A.Avatar:Show(icon)
            end
			
            -- run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
            if Aoe(unit) and (MultiUnits:GetByRange(8) >= 3) then
                return true
            end
			
            -- call_action_list,name=st
            if St(unit) then
                return true
            end
			
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
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

