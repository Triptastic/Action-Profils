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

Action[ACTION_CONST_WARLOCK_DESTRUCTION] = {
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
    SummonPet                              = Create({ Type = "Spell", ID = 688 }),
    GrimoireofSacrifice                    = Create({ Type = "Spell", ID = 108503 }),
    SoulFire                               = Create({ Type = "Spell", ID = 6353 }),
    Incinerate                             = Create({ Type = "Spell", ID = 29722 }),
    RainofFire                             = Create({ Type = "Spell", ID = 5740 }),
    CrashingChaosBuff                      = Create({ Type = "Spell", ID =  }),
    GrimoireofSupremacy                    = Create({ Type = "Spell", ID = 266086 }),
    Havoc                                  = Create({ Type = "Spell", ID = 80240 }),
    RainofFireDebuff                       = Create({ Type = "Spell", ID = 5740 }),
    ChannelDemonfire                       = Create({ Type = "Spell", ID = 196447 }),
    ImmolateDebuff                         = Create({ Type = "Spell", ID = 157736 }),
    Immolate                               = Create({ Type = "Spell", ID = 348 }),
    Cataclysm                              = Create({ Type = "Spell", ID = 152108 }),
    HavocDebuff                            = Create({ Type = "Spell", ID = 80240 }),
    ChaosBolt                              = Create({ Type = "Spell", ID = 116858 }),
    Inferno                                = Create({ Type = "Spell", ID = 270545 }),
    FireandBrimstone                       = Create({ Type = "Spell", ID = 196408 }),
    BackdraftBuff                          = Create({ Type = "Spell", ID = 117828 }),
    Conflagrate                            = Create({ Type = "Spell", ID = 17962 }),
    Shadowburn                             = Create({ Type = "Spell", ID = 17877 }),
    SummonInfernal                         = Create({ Type = "Spell", ID = 1122 }),
    DarkSoulInstability                    = Create({ Type = "Spell", ID = 113858 }),
    DarkSoulInstabilityBuff                = Create({ Type = "Spell", ID = 113858 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    GrimoireofSupremacyBuff                = Create({ Type = "Spell", ID = 266091 }),
    InternalCombustion                     = Create({ Type = "Spell", ID = 266134 }),
    ShadowburnDebuff                       = Create({ Type = "Spell", ID = 17877 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    Flashover                              = Create({ Type = "Spell", ID = 267115 }),
    CrashingChaos                          = Create({ Type = "Spell", ID =  }),
    Eradication                            = Create({ Type = "Spell", ID = 196412 }),
    EradicationDebuff                      = Create({ Type = "Spell", ID = 196414 })
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
A:CreateCovenantsFor(ACTION_CONST_WARLOCK_DESTRUCTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_DESTRUCTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolSoulShards = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolSoulShards = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
------- DESTRUCTION PRE APL SETUP --------
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
	ImmolateDelay                           = 0,
	CastStartTime                           = {},
}
local player = "player"
local SoulShardsP = Player:SoulShardsP()
local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsLatenced(self)
    -- @return boolean 
    return TMW.time - (Temp.CastStartTime[self:Info()] or 0) > GetGCD() + 0.5
end 

-- Chaos School tricks
-- https://wow.gamepedia.com/Chaos_(spell_school)
local ChaosSchool = {
    "SHADOW",
    "ARCANE",
    "FIRE",
    "FROST",
    "HOLY",
    "NATURE",
    "PHYSICAL"	
}
local function IsChaosSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", ChaosSchool) == 0
end 

local function IsFireSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "FIRE") == 0
end 

local function IsShadowSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function FutureShard ()
    local Shard = Player:SoulShards()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
    
    if not Unit(player):IsCasting() then
        return Shard
    else
        if spellID == A.SummonDoomGuard.ID 
                or spellID == A.SummonDoomGuardSuppremacy.ID 
                or spellID == A.SummonInfernal.ID
                or spellID == A.SummonInfernalSuppremacy.ID 
                or spellID == A.GrimoireFelhunter.ID 
                or spellID == A.SummonFelhunter.ID 
		then
            return Shard - 1
        else
            return Shard
        end
    end
end

-- API - Tracker
-- Initialize Tracker 
Pet:AddTrackers(ACTION_CONST_WARLOCK_DESTRUCTION, { -- this template table is the same with what has this library already built-in, just for example
    [89] = {
        name = "Infernal",
        duration = 30,
    },
})

-- Function to check for Infernal duration
local function InfernalTime()
    return Pet:GetRemainDuration(89) or 0
end 

local function InfernalIsActive()
    return InfernalTime() > 5.25 and true or false -- 5.25 because Vision of Perfection procs and Infernal with same NPC ID
end

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- UnendingResolve
    local UnendingResolve = GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady("player") and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            UnendingResolve < 100 and 
            Unit(player):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
	
	    -- HealingPotion
    local AbyssalHealingPotion = GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
	
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.PetKick:IsReadyByPassCastGCD(unit) or not A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells : "MainPvP", "MainPvE", "MousePvE", "MousePvP"
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
	    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):IsControlAble("stun", 0) then 
            return A.PetKick
        end 
    
        if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
            return A.Shadowfury              
        end          
	
	    if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 75) then 
            return A.Fear              
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
            if not notKickAble and Pet:IsActive(417) and A.PetKick:IsReady(unit, nil, nil, true) and A.PetKick:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.PetKick:Show(icon)                                                  
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

local function IsSaveManaPhase()
    if not A.IsInPvP and GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit(player):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)



local Havoc_Nameplates = MultiUnits:GetActiveUnitPlates()
local pairs = pairs

local function HavocDebuffTime()
    --local Havoc_Nameplates = MultiUnits:GetActiveUnitPlates() -- don't use here, it will create pointer to table from this function which overflow memory a bit
   -- if Havoc_Nameplates then  
        for Havoc_UnitID in pairs(Havoc_Nameplates) do
            local debuff = Unit(Havoc_UnitID):HasDeBuffs(A.Havoc.ID, true)
            if debuff > 0 then         
                return debuff 
            --else -- logical error
               -- return 0
            end
        end
    --end    
    return 0    
end
HavocDebuffTime = A.MakeFunctionCachedStatic(HavocDebuffTime)

-- Pet Handler UI --
local function HandlePetChoice()
    local choice = GetToggle(2, "PetChoice")
    local currentspell = "Spell(688)"
    
    if choice == "IMP" then
        --print("IMP")
        currentspell = "Spell(688)"    
    elseif choice == "VOIDWALKER" then
        --print("VOIDWALKER")
        currentspell = "Spell(697)"
    elseif choice == "FELHUNTER" then 
        --print("FELHUNTER")    
        currentspell = "Spell(691)"
    elseif choice == "SUCCUBUS" then 
        --print("SUCCUBUS")    
        currentspell = "Spell(712)"
    else
        print("No Pet Data")
    end
    return choice
end
HandlePetChoice = A.MakeFunctionCachedStatic(HandlePetChoice)

local function EvaluateCycleImmolate46(unit)
  return Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < 5 and (not A.Cataclysm:IsSpellLearned() or A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true))
end

local function EvaluateCycleHavoc71(unit)
  return not (Unit(unit) == self.target) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4
end

local function EvaluateCycleHavoc106(unit)
  return not (Unit(unit) == self.target) and (not A.GrimoireofSupremacy:IsSpellLearned() or not A.Inferno:IsSpellLearned() or A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) <= 10)
end

local function EvaluateCycleImmolate531(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.ImmolateDebuff.ID, true) and (not A.Cataclysm:IsSpellLearned() or A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true))
end

local function EvaluateCycleHavoc598(unit)
  return not (Unit(unit) == self.target) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) > A.ImmolateDebuff.ID, true:BaseDuration() * 0.5 or not A.InternalCombustion:IsSpellLearned()) and (not A.SummonInfernal:GetCooldown() == 0 or not A.GrimoireofSupremacy:IsSpellLearned() or A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) <= 10)
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
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            
            -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
            if A.GrimoireofSacrifice:IsReady(unit) and (A.GrimoireofSacrifice:IsSpellLearned()) then
                return A.GrimoireofSacrifice:Show(icon)
            end
            
            -- snapshot_stats
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- soul_fire
            if A.SoulFire:IsReady(unit) then
                return A.SoulFire:Show(icon)
            end
            
            -- incinerate,if=!talent.soul_fire.enabled
            if A.Incinerate:IsReady(unit) and (not A.SoulFire:IsSpellLearned()) then
                return A.Incinerate:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- rain_of_fire,if=pet.infernal.active&(buff.crashing_chaos.down|!talent.grimoire_of_supremacy.enabled)&(!cooldown.havoc.ready|active_enemies>3)
            if A.RainofFire:IsReady(unit) and (pet.infernal.active and (Unit("player"):HasBuffsDown(A.CrashingChaosBuff.ID, true) or not A.GrimoireofSupremacy:IsSpellLearned()) and (not A.Havoc:GetCooldown() == 0 or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3)) then
                return A.RainofFire:Show(icon)
            end
            
            -- channel_demonfire,if=dot.immolate.remains>cast_time
            if A.ChannelDemonfire:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) > A.ChannelDemonfire:GetSpellCastTime()) then
                return A.ChannelDemonfire:Show(icon)
            end
            
            -- immolate,cycle_targets=1,if=remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
            if A.Immolate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Immolate, 40, "min", EvaluateCycleImmolate46) then
                    return A.Immolate:Show(icon) 
                end
            end
            -- call_action_list,name=cds
            if A.BurstIsON(unit) then
                if Cds(unit) then
                    return true
                end
            end
            
            -- havoc,cycle_targets=1,if=!(target=self.target)&active_enemies<4
            if A.Havoc:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Havoc, 40, "min", EvaluateCycleHavoc71) then
                    return A.Havoc:Show(icon) 
                end
            end
            -- chaos_bolt,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active&(havoc_active|talent.cataclysm.enabled|talent.inferno.enabled&active_enemies<4)
            if A.ChaosBolt:IsReady(unit) and (A.GrimoireofSupremacy:IsSpellLearned() and pet.infernal.active and (havoc_active or A.Cataclysm:IsSpellLearned() or A.Inferno:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4)) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- rain_of_fire
            if A.RainofFire:IsReady(unit) then
                return A.RainofFire:Show(icon)
            end
            
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- havoc,cycle_targets=1,if=!(target=self.target)&(!talent.grimoire_of_supremacy.enabled|!talent.inferno.enabled|talent.grimoire_of_supremacy.enabled&pet.infernal.remains<=10)
            if A.Havoc:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Havoc, 40, "min", EvaluateCycleHavoc106) then
                    return A.Havoc:Show(icon) 
                end
            end
            -- incinerate,if=talent.fire_and_brimstone.enabled&buff.backdraft.up&soul_shard<5-0.2*active_enemies
            if A.Incinerate:IsReady(unit) and (A.FireandBrimstone:IsSpellLearned() and Unit("player"):HasBuffs(A.BackdraftBuff.ID, true) and Player:SoulShardsP < 5 - 0.2 * MultiUnits:GetByRangeInCombat(40, 5, 10)) then
                return A.Incinerate:Show(icon)
            end
            
            -- soul_fire
            if A.SoulFire:IsReady(unit) then
                return A.SoulFire:Show(icon)
            end
            
            -- conflagrate,if=buff.backdraft.down
            if A.Conflagrate:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BackdraftBuff.ID, true)) then
                return A.Conflagrate:Show(icon)
            end
            
            -- shadowburn,if=!talent.fire_and_brimstone.enabled
            if A.Shadowburn:IsReady(unit) and (not A.FireandBrimstone:IsSpellLearned()) then
                return A.Shadowburn:Show(icon)
            end
            
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight&active_enemies<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- incinerate
            if A.Incinerate:IsReady(unit) then
                return A.Incinerate:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- immolate,if=talent.grimoire_of_supremacy.enabled&remains<8&cooldown.summon_infernal.remains<4.5
            if A.Immolate:IsReady(unit) and (A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < 8 and A.SummonInfernal:GetCooldown() < 4.5) then
                return A.Immolate:Show(icon)
            end
            
            -- conflagrate,if=talent.grimoire_of_supremacy.enabled&cooldown.summon_infernal.remains<4.5&!buff.backdraft.up&soul_shard<4.3
            if A.Conflagrate:IsReady(unit) and (A.GrimoireofSupremacy:IsSpellLearned() and A.SummonInfernal:GetCooldown() < 4.5 and not Unit("player"):HasBuffs(A.BackdraftBuff.ID, true) and Player:SoulShardsP < 4.3) then
                return A.Conflagrate:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=cooldown.summon_infernal.up|cooldown.summon_infernal.remains<=4
            if A.AzsharasFontofPower:IsReady(unit) and (A.SummonInfernal:GetCooldown() == 0 or A.SummonInfernal:GetCooldown() <= 4) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- summon_infernal
            if A.SummonInfernal:IsReady(unit) then
                return A.SummonInfernal:Show(icon)
            end
            
            -- guardian_of_azeroth,if=pet.infernal.active
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (pet.infernal.active) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- dark_soul_instability,if=pet.infernal.active&(pet.infernal.remains<20.5|pet.infernal.remains<22&soul_shard>=3.6|!talent.grimoire_of_supremacy.enabled)
            if A.DarkSoulInstability:IsReady(unit) and (pet.infernal.active and (Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) < 20.5 or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) < 22 and Player:SoulShardsP >= 3.6 or not A.GrimoireofSupremacy:IsSpellLearned())) then
                return A.DarkSoulInstability:Show(icon)
            end
            
            -- worldvein_resonance,if=pet.infernal.active&(pet.infernal.remains<18.5|pet.infernal.remains<20&soul_shard>=3.6|!talent.grimoire_of_supremacy.enabled)
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (pet.infernal.active and (pet.infernal.remains < 18.5 or pet.infernal.remains < 20 and Player:SoulShardsP >= 3.6 or not A.GrimoireofSupremacy:IsSpellLearned())) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=pet.infernal.active&(pet.infernal.remains<15.5|soul_shard<3.5&(buff.dark_soul_instability.up|!talent.grimoire_of_supremacy.enabled&dot.immolate.remains>12))
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (pet.infernal.active and (pet.infernal.remains < 15.5 or Player:SoulShardsP < 3.5 and (Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) or not A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) > 12))) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- summon_infernal,if=target.time_to_die>cooldown.summon_infernal.duration+30
            if A.SummonInfernal:IsReady(unit) and (Unit(unit):TimeToDie() > A.SummonInfernal:BaseDuration() + 30) then
                return A.SummonInfernal:Show(icon)
            end
            
            -- guardian_of_azeroth,if=time>30&target.time_to_die>cooldown.guardian_of_azeroth.duration+30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):CombatTime() > 30 and Unit(unit):TimeToDie() > A.GuardianofAzeroth:BaseDuration() + 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- summon_infernal,if=talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains>target.time_to_die
            if A.SummonInfernal:IsReady(unit) and (A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() > Unit(unit):TimeToDie()) then
                return A.SummonInfernal:Show(icon)
            end
            
            -- guardian_of_azeroth,if=cooldown.summon_infernal.remains>target.time_to_die
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie()) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- dark_soul_instability,if=cooldown.summon_infernal.remains>target.time_to_die&pet.infernal.remains<20.5
            if A.DarkSoulInstability:IsReady(unit) and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() and Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) < 20.5) then
                return A.DarkSoulInstability:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.summon_infernal.remains>target.time_to_die&pet.infernal.remains<18.5
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() and pet.infernal.remains < 18.5) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=cooldown.summon_infernal.remains>target.time_to_die&(pet.infernal.remains<15.5|buff.dark_soul_instability.up&soul_shard<3)
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() and (pet.infernal.remains < 15.5 or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) and Player:SoulShardsP < 3)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- summon_infernal,if=target.time_to_die<30
            if A.SummonInfernal:IsReady(unit) and (Unit(unit):TimeToDie() < 30) then
                return A.SummonInfernal:Show(icon)
            end
            
            -- guardian_of_azeroth,if=target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- dark_soul_instability,if=target.time_to_die<21&target.time_to_die>4
            if A.DarkSoulInstability:IsReady(unit) and (Unit(unit):TimeToDie() < 21 and Unit(unit):TimeToDie() > 4) then
                return A.DarkSoulInstability:Show(icon)
            end
            
            -- worldvein_resonance,if=target.time_to_die<19&target.time_to_die>4
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):TimeToDie() < 19 and Unit(unit):TimeToDie() > 4) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=target.time_to_die<16&target.time_to_die>6
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):TimeToDie() < 16 and Unit(unit):TimeToDie() > 6) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.summon_infernal.remains>=60-12&!pet.infernal.active
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.SummonInfernal:GetCooldown() >= 60 - 12 and not pet.infernal.active) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- potion,if=pet.infernal.active|target.time_to_die<30
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (pet.infernal.active or Unit(unit):TimeToDie() < 30) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- berserking,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (pet.infernal.active and (not A.GrimoireofSupremacy:IsSpellLearned() or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) and (not A.DarkSoulInstability:IsSpellLearned() or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true))) or Unit(unit):TimeToDie() <= 15) then
                return A.Berserking:Show(icon)
            end
            
            -- blood_fury,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (pet.infernal.active and (not A.GrimoireofSupremacy:IsSpellLearned() or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) and (not A.DarkSoulInstability:IsSpellLearned() or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true))) or Unit(unit):TimeToDie() <= 15) then
                return A.BloodFury:Show(icon)
            end
            
            -- fireblood,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (pet.infernal.active and (not A.GrimoireofSupremacy:IsSpellLearned() or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) and (not A.DarkSoulInstability:IsSpellLearned() or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true))) or Unit(unit):TimeToDie() <= 15) then
                return A.Fireblood:Show(icon)
            end
            
            -- use_items,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|pet.infernal.remains<=20)|target.time_to_die<=20
            -- use_item,name=pocketsized_computation_device,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.PocketsizedComputationDevice:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
            
            -- use_item,name=rotcrusted_voodoo_doll,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.RotcrustedVoodooDoll:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.RotcrustedVoodooDoll:Show(icon)
            end
            
            -- use_item,name=shiver_venom_relic,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.ShiverVenomRelic:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.ShiverVenomRelic:Show(icon)
            end
            
            -- use_item,name=aquipotent_nautilus,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.AquipotentNautilus:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.AquipotentNautilus:Show(icon)
            end
            
            -- use_item,name=tidestorm_codex,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.TidestormCodex:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.TidestormCodex:Show(icon)
            end
            
            -- use_item,name=vial_of_storms,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.VialofStorms:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.VialofStorms:Show(icon)
            end
            
        end
        
        --GosupInfernal
        local function GosupInfernal(unit)
        
            -- rain_of_fire,if=soul_shard=5&!buff.backdraft.up&buff.memory_of_lucid_dreams.up&buff.grimoire_of_supremacy.stack<=10
            if A.RainofFire:IsReady(unit) and (Player:SoulShardsP == 5 and not Unit("player"):HasBuffs(A.BackdraftBuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffsStacks(A.GrimoireofSupremacyBuff.ID, true) <= 10) then
                return A.RainofFire:Show(icon)
            end
            
            -- chaos_bolt,if=buff.backdraft.up
            if A.ChaosBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.BackdraftBuff.ID, true)) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- chaos_bolt,if=soul_shard>=4.2-buff.memory_of_lucid_dreams.up
            if A.ChaosBolt:IsReady(unit) and (Player:SoulShardsP >= 4.2 - num(Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true))) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- chaos_bolt,if=!cooldown.conflagrate.up
            if A.ChaosBolt:IsReady(unit) and (not A.Conflagrate:GetCooldown() == 0) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- chaos_bolt,if=cast_time<pet.infernal.remains&pet.infernal.remains<cast_time+gcd
            if A.ChaosBolt:IsReady(unit) and (A.ChaosBolt:GetSpellCastTime() < pet.infernal.remains and pet.infernal.remains < A.ChaosBolt:GetSpellCastTime() + GetGCD()) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- conflagrate,if=buff.backdraft.down&buff.memory_of_lucid_dreams.up&soul_shard>=1.3
            if A.Conflagrate:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BackdraftBuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Player:SoulShardsP >= 1.3) then
                return A.Conflagrate:Show(icon)
            end
            
            -- conflagrate,if=buff.backdraft.down&!buff.memory_of_lucid_dreams.up&(soul_shard>=2.8|charges_fractional>1.9&soul_shard>=1.3)
            if A.Conflagrate:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BackdraftBuff.ID, true) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and (Player:SoulShardsP >= 2.8 or A.Conflagrate:GetSpellChargesFrac() > 1.9 and Player:SoulShardsP >= 1.3)) then
                return A.Conflagrate:Show(icon)
            end
            
            -- conflagrate,if=pet.infernal.remains<5
            if A.Conflagrate:IsReady(unit) and (pet.infernal.remains < 5) then
                return A.Conflagrate:Show(icon)
            end
            
            -- conflagrate,if=charges>1
            if A.Conflagrate:IsReady(unit) and (A.Conflagrate:GetSpellCharges() > 1) then
                return A.Conflagrate:Show(icon)
            end
            
            -- soul_fire
            if A.SoulFire:IsReady(unit) then
                return A.SoulFire:Show(icon)
            end
            
            -- shadowburn
            if A.Shadowburn:IsReady(unit) then
                return A.Shadowburn:Show(icon)
            end
            
            -- incinerate
            if A.Incinerate:IsReady(unit) then
                return A.Incinerate:Show(icon)
            end
            
        end
        
        --Havoc
        local function Havoc(unit)
        
            -- conflagrate,if=buff.backdraft.down&soul_shard>=1&soul_shard<=4
            if A.Conflagrate:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BackdraftBuff.ID, true) and Player:SoulShardsP >= 1 and Player:SoulShardsP <= 4) then
                return A.Conflagrate:Show(icon)
            end
            
            -- immolate,if=talent.internal_combustion.enabled&remains<duration*0.5|!talent.internal_combustion.enabled&refreshable
            if A.Immolate:IsReady(unit) and (A.InternalCombustion:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < A.ImmolateDebuff.ID, true:BaseDuration() * 0.5 or not A.InternalCombustion:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ImmolateDebuff.ID, true)) then
                return A.Immolate:Show(icon)
            end
            
            -- chaos_bolt,if=cast_time<havoc_remains
            if A.ChaosBolt:IsReady(unit) and (A.ChaosBolt:GetSpellCastTime() < havoc_remains) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- soul_fire
            if A.SoulFire:IsReady(unit) then
                return A.SoulFire:Show(icon)
            end
            
            -- shadowburn,if=active_enemies<3|!talent.fire_and_brimstone.enabled
            if A.Shadowburn:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or not A.FireandBrimstone:IsSpellLearned()) then
                return A.Shadowburn:Show(icon)
            end
            
            -- incinerate,if=cast_time<havoc_remains
            if A.Incinerate:IsReady(unit) and (A.Incinerate:GetSpellCastTime() < havoc_remains) then
                return A.Incinerate:Show(icon)
            end
            
        end
        
-- call precombat
if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then
  if Precombat(unit) then
    return true
end
end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- call_action_list,name=havoc,if=havoc_active&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled)
            if (havoc_active and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5 - num(A.Inferno:IsSpellLearned()) + num((A.Inferno:IsSpellLearned() and A.InternalCombustion:IsSpellLearned()))) then
                if Havoc(unit) then
                    return true
                end
            end
            
            -- cataclysm,if=!(pet.infernal.active&dot.immolate.remains+1>pet.infernal.remains)|spell_targets.cataclysm>1|!talent.grimoire_of_supremacy.enabled
            if A.Cataclysm:IsReady(unit) and (not (pet.infernal.active and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) + 1 > pet.infernal.remains) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or not A.GrimoireofSupremacy:IsSpellLearned()) then
                return A.Cataclysm:Show(icon)
            end
            
            -- call_action_list,name=aoe,if=active_enemies>2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                if Aoe(unit) then
                    return true
                end
            end
            
            -- immolate,cycle_targets=1,if=refreshable&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
            if A.Immolate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Immolate, 40, "min", EvaluateCycleImmolate531) then
                    return A.Immolate:Show(icon) 
                end
            end
            -- immolate,if=talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains<duration*0.5
            if A.Immolate:IsReady(unit) and (A.InternalCombustion:IsSpellLearned() and A.ChaosBolt:IsSpellInFlight() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < A.ImmolateDebuff.ID, true:BaseDuration() * 0.5) then
                return A.Immolate:Show(icon)
            end
            
            -- call_action_list,name=cds
            if A.BurstIsON(unit) then
                if Cds(unit) then
                    return true
                end
            end
            
            -- focused_azerite_beam,if=!pet.infernal.active|!talent.grimoire_of_supremacy.enabled
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not pet.infernal.active or not A.GrimoireofSupremacy:IsSpellLearned()) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.react
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsStacks(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight()) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- channel_demonfire
            if A.ChannelDemonfire:IsReady(unit) then
                return A.ChannelDemonfire:Show(icon)
            end
            
            -- havoc,cycle_targets=1,if=!(target=self.target)&(dot.immolate.remains>dot.immolate.duration*0.5|!talent.internal_combustion.enabled)&(!cooldown.summon_infernal.ready|!talent.grimoire_of_supremacy.enabled|talent.grimoire_of_supremacy.enabled&pet.infernal.remains<=10)
            if A.Havoc:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Havoc, 40, "min", EvaluateCycleHavoc598) then
                    return A.Havoc:Show(icon) 
                end
            end
            -- call_action_list,name=gosup_infernal,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active
            if (A.GrimoireofSupremacy:IsSpellLearned() and pet.infernal.active) then
                if GosupInfernal(unit) then
                    return true
                end
            end
            
            -- soul_fire
            if A.SoulFire:IsReady(unit) then
                return A.SoulFire:Show(icon)
            end
            
            -- variable,name=pool_soul_shards,value=active_enemies>1&cooldown.havoc.remains<=10|cooldown.summon_infernal.remains<=15&(talent.grimoire_of_supremacy.enabled|talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15)|talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15&(cooldown.summon_infernal.remains>target.time_to_die|cooldown.summon_infernal.remains+cooldown.summon_infernal.duration>target.time_to_die)
            VarPoolSoulShards = num(MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and A.Havoc:GetCooldown() <= 10 or A.SummonInfernal:GetCooldown() <= 15 and (A.GrimoireofSupremacy:IsSpellLearned() or A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() <= 15) or A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() <= 15 and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() or A.SummonInfernal:GetCooldown() + A.SummonInfernal:BaseDuration() > Unit(unit):TimeToDie()))
            
            -- conflagrate,if=buff.backdraft.down&soul_shard>=1.5-0.3*talent.flashover.enabled&!variable.pool_soul_shards
            if A.Conflagrate:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BackdraftBuff.ID, true) and Player:SoulShardsP >= 1.5 - 0.3 * num(A.Flashover:IsSpellLearned()) and not VarPoolSoulShards) then
                return A.Conflagrate:Show(icon)
            end
            
            -- shadowburn,if=soul_shard<2&(!variable.pool_soul_shards|charges>1)
            if A.Shadowburn:IsReady(unit) and (Player:SoulShardsP < 2 and (not VarPoolSoulShards or A.Shadowburn:GetSpellCharges() > 1)) then
                return A.Shadowburn:Show(icon)
            end
            
            -- chaos_bolt,if=(talent.grimoire_of_supremacy.enabled|azerite.crashing_chaos.enabled)&pet.infernal.active|buff.dark_soul_instability.up|buff.reckless_force.react&buff.reckless_force.remains>cast_time
            if A.ChaosBolt:IsReady(unit) and ((A.GrimoireofSupremacy:IsSpellLearned() or A.CrashingChaos:GetAzeriteRank() > 0) and pet.infernal.active or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceBuff.ID, true) and Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > A.ChaosBolt:GetSpellCastTime()) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards&!talent.eradication.enabled
            if A.ChaosBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.BackdraftBuff.ID, true) and not VarPoolSoulShards and not A.Eradication:IsSpellLearned()) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- chaos_bolt,if=!variable.pool_soul_shards&talent.eradication.enabled&(debuff.eradication.remains<cast_time|buff.backdraft.up)
            if A.ChaosBolt:IsReady(unit) and (not VarPoolSoulShards and A.Eradication:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.EradicationDebuff.ID, true) < A.ChaosBolt:GetSpellCastTime() or Unit("player"):HasBuffs(A.BackdraftBuff.ID, true))) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- chaos_bolt,if=(soul_shard>=4.5-0.2*active_enemies)&(!talent.grimoire_of_supremacy.enabled|cooldown.summon_infernal.remains>7)
            if A.ChaosBolt:IsReady(unit) and ((Player:SoulShardsP >= 4.5 - 0.2 * MultiUnits:GetByRangeInCombat(40, 5, 10)) and (not A.GrimoireofSupremacy:IsSpellLearned() or A.SummonInfernal:GetCooldown() > 7)) then
                return A.ChaosBolt:Show(icon)
            end
            
            -- conflagrate,if=charges>1
            if A.Conflagrate:IsReady(unit) and (A.Conflagrate:GetSpellCharges() > 1) then
                return A.Conflagrate:Show(icon)
            end
            
            -- incinerate
            if A.Incinerate:IsReady(unit) then
                return A.Incinerate:Show(icon)
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

