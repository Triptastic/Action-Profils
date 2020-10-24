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

Action[ACTION_CONST_DRUID_GUARDIAN] = {
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
    BearFormBuff                           = Create({ Type = "Spell", ID = 5487 }),
    BearForm                               = Create({ Type = "Spell", ID = 5487 }),
    Maul                                   = Create({ Type = "Spell", ID = 6807 }),
    Ironfur                                = Create({ Type = "Spell", ID = 192081 }),
    IronfurBuff                            = Create({ Type = "Spell", ID = 192081 }),
    Pulverize                              = Create({ Type = "Spell", ID = 80313 }),
    ThrashBearDebuff                       = Create({ Type = "Spell", ID = 192090 }),
    Moonfire                               = Create({ Type = "Spell", ID = 8921 }),
    MoonfireDebuff                         = Create({ Type = "Spell", ID = 164812 }),
    Mangle                                 = Create({ Type = "Spell", ID = 33917 }),
    GalacticGuardianBuff                   = Create({ Type = "Spell", ID = 213708 }),
    ThrashCat                              = Create({ Type = "Spell", ID = 106830 }),
    ThrashBear                             = Create({ Type = "Spell", ID = 77758 }),
    SwipeCat                               = Create({ Type = "Spell", ID = 106785 }),
    SwipeBear                              = Create({ Type = "Spell", ID = 213771 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    Barkskin                               = Create({ Type = "Spell", ID = 22812 }),
    LunarBeam                              = Create({ Type = "Spell", ID = 204066 }),
    BristlingFur                           = Create({ Type = "Spell", ID = 155835 }),
    Incarnation                            = Create({ Type = "Spell", ID = 102558 }),
    IncarnationBuff                        = Create({ Type = "Spell", ID = 102558 }),
    TheCrucibleofFlame                     = Create({ Type = "Spell", ID =  }),
    AnimaofDeath                           = Create({ Type = "Spell", ID =  }),
    AnimaofLifeandDeath                    = Create({ Type = "Spell", ID =  }),
    ConflictandStrife                      = Create({ Type = "Spell", ID =  }),
    SharpenedClawsBuff                     = Create({ Type = "Spell", ID =  }),
    LayeredMane                            = Create({ Type = "Spell", ID = 279552 })
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
A:CreateCovenantsFor(ACTION_CONST_DRUID_GUARDIAN)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_GUARDIAN], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- GUARDIAN PRE APL SETUP ---------
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
	BigDeff                                 = {A.SurvivalInstincts.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function GetStance()
    -- @return number (1 - Bear, 2 - Cat, 3 - Travel)
    return Player:GetStance()
end 

local function Swipe()
  if Unit("player"):HasBuffs(A.CatForm.ID, true) > 0 then
    return A.SwipeCat
  else
    return A.SwipeBear
  end
end

local function Thrash()
  if Unit("player"):HasBuffs(A.CatForm.ID, true) > 0 then
    return A.ThrashCat
  else
    return A.ThrashBear
  end
end


-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = math.max((Unit(player):GetDMG() * 100 / Unit(player):HealthMax()) - (Unit(player):GetHEAL() * 100 / Unit(player):HealthMax()), 0)

	
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
	
    -- memory_of_lucid_dreams
    if A.MemoryofLucidDreams:AutoHeartOfAzerothP(player, true) and Action.GetToggle(1, "HeartOfAzeroth") then 
	    local LucidDreamTTD = GetToggle(2, "LucidDreamTTD")	
	    local LucidDreamHP = GetToggle(2, "LucidDreamHP")
            
        if  (    
                ( LucidDreamHP      >= 0     or LucidDreamTTD                    >= 0                                        ) and 
                ( LucidDreamHP      <= 0     or Unit(player):HealthPercent()     <= LucidDreamHP                             ) and 
                ( LucidDreamTTD     <= 0     or Unit(player):TimeToDie()         <= LucidDreamTTD                            ) 
            )                 
        then                
            return A.MemoryofLucidDreams
        end 
    end
			
    -- Ironfur (any role, whenever have physical damage)
	local IronfurHPLost = GetToggle(2, "IronfurHPLost")
	local IsTanking = Unit(player):IsTanking("target", 8) or Unit(player):IsTankingAoE(8)
    if Player:Rage() >= A.Ironfur:GetSpellPowerCost() and A.Ironfur:IsReady(player) and 
	(
	    HPLoosePerSecond >= IronfurHPLost
		or
        Unit(player):HealthPercent() < 99 and IsTanking
	)
	then 
        return A.Ironfur
    end 

    -- Emergency FrenziedRegeneration
    local FrenziedRegeneration = Action.GetToggle(2, "FrenziedRegenerationHP")
    if     FrenziedRegeneration >= 0 and A.FrenziedRegeneration:IsReady("player") and Unit("player"):HasBuffs(A.FrenziedRegeneration.ID, true) == 0 and
    (
        (   -- Auto 
            FrenziedRegeneration >= 100 and 
            (
                -- HP lose per sec >= 5
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 15 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.15 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
				-- Custom logic with current HPS and DMG
				Unit("player"):HealthPercent() <= 85 or
	    		Unit("player"):GetHEAL() * 2 < Unit("player"):GetDMG() or
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
            ) 
        ) or 
        (    -- Custom
            FrenziedRegeneration < 100 and 
            Unit("player"):HealthPercent() <= FrenziedRegeneration
        )
    ) 
    then 
        return A.FrenziedRegeneration
    end 
			
    -- SurvivalInstincts
    if A.SurvivalInstincts:IsReadyByPassCastGCD(player) then 
        local SI_HP                 = A.GetToggle(2, "SurvivalInstinctsHP")
        local SI_TTD                = A.GetToggle(2, "SurvivalInstinctsTTD")
            
        if  (    
                ( SI_HP     >= 0     or SI_TTD                              >= 0                                        ) and 
                ( SI_HP     <= 0     or Unit(player):HealthPercent()     <= SI_HP                                    ) and 
                ( SI_TTD     <= 0     or Unit(player):TimeToDie()         <= SI_TTD      )  
            ) 
			or 
            (
                A.GetToggle(2, "SurvivalInstinctsCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- Ironfur
            if A.Ironfur:IsReadyByPassCastGCD(player) and Player:Rage() >= A.Ironfur:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.IronfurBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SurvivalInstincts.ID, true) == 0 then  
                return A.Ironfur        -- #4
            end 
                
            -- SurvivalInstincts
            return A.SurvivalInstincts         -- #3                  
             
        end 
    end

    -- Barkskin	
    if A.Barkskin:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "BarkskinIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local BS_HP                 = A.GetToggle(2, "BarkskinHP")
        local BS_TTD                = A.GetToggle(2, "BarkskinTTD")
            
        if  (    
                ( BS_HP     >= 0     or BS_TTD                              >= 0                                     ) and 
                ( BS_HP     <= 0     or Unit(player):HealthPercent()     <= BS_HP                                    ) and 
                ( BS_TTD    <= 0     or Unit(player):TimeToDie()         <= BS_TTD                                   ) 
            ) 
		    or 
            (
                A.GetToggle(2, "BarkskinCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.Barkskin
        end 
    end 

	-- SuperiorSteelskinPotion
    local SuperiorSteelskinPotion = A.GetToggle(2, "SuperiorSteelskinPotionHP")
    if     SuperiorSteelskinPotion >= 0 and A.SuperiorSteelskinPotion:IsReady(player) and 
    (
        (     -- Auto 
            SuperiorSteelskinPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 3 or 
				GetByRange(5, 15) and Unit(player):HealthPercent() <= 25 and Player:AreaTTD(15) > 20 or
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
        ) or 
        (    -- Custom
            SuperiorSteelskinPotion < 100 and 
            Unit(player):HealthPercent() <= SuperiorSteelskinPotion
        )
    ) 
    then 
        return A.SuperiorSteelskinPotion
    end
	
	-- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
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
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.SkullBash:IsReadyByPassCastGCD(unit) or not A.SkullBash:AbsentImun(unit, Temp.TotalAndMagKick) then
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
    local EnemiesCasting = MultiUnits:GetByRangeCasting(10, 5, true, "TargetMouseover")
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and A.SkullBash:IsReady(unit) and A.SkullBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Skull Bash interrupting on " .. unit, A.SkullBash.ID)
            return A.SkullBash
        end         

        if useCC and A.MightyBash:IsReady(unit) and A.MightyBash:IsSpellLearned() and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Mighty Bash interrupting on " .. unit, A.MightyBash.ID)
            return A.MightyBash
        end  

 	     -- IncapacitatingRoar
   	    if useCC and EnemiesCasting >= 3 and (not A.MightyBash:IsSpellLearned() or not A.MightyBash:IsReady(unit)) and A.IncapacitatingRoar:IsReady(unit) then 
   	        return A.IncapacitatingRoar
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
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

-- Multidot Handler UI --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if IsInGroup() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if A.IsInPvP then 
    		return true
		else
		    return false
		end		
    elseif choice == "Everywhere" then 
        return true
    else
		return false
    end
	--print(choice)
end

local function EvaluateCyclePulverize26(unit)
    return Unit(unit):HasDeBuffsStacks(A.ThrashBearDebuff.ID, true) == dot.thrash_bear.max_stacks
end

local function EvaluateCycleMoonfire37(unit)
    return not Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true)
end

local function EvaluateCycleMoonfire50(unit)
    return Unit("player"):HasBuffs(A.GalacticGuardianBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true)
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
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- bear_form
            if A.BearForm:IsReady(unit) and Unit("player"):HasBuffsDown(A.BearFormBuff.ID, true) then
                return A.BearForm:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
        end
        
        --Cleave
        local function Cleave(unit)
        
            -- maul,if=rage.deficit<=10
            if A.Maul:IsReady(unit) and (Player:RageDeficit() <= 10) then
                return A.Maul:Show(icon)
            end
            
            -- ironfur,if=cost<=0
            if A.Ironfur:IsReady(unit) and (A.Ironfur:GetSpellPowerCostCache() <= 0) then
                return A.Ironfur:Show(icon)
            end
            
            -- pulverize,target_if=dot.thrash_bear.stack=dot.thrash_bear.max_stacks
            if A.Pulverize:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Pulverize, 40, "min", EvaluateCyclePulverize26) then
                    return A.Pulverize:Show(icon) 
                end
            end
            -- moonfire,target_if=!dot.moonfire.ticking
            if A.Moonfire:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Moonfire, 40, "min", EvaluateCycleMoonfire37) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- mangle,if=dot.thrash_bear.ticking
            if A.Mangle:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ThrashBearDebuff.ID, true)) then
                return A.Mangle:Show(icon)
            end
            
            -- moonfire,target_if=buff.galactic_guardian.up&active_enemies=1|dot.moonfire.refreshable
            if A.Moonfire:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Moonfire, 40, "min", EvaluateCycleMoonfire50) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- maul
            if A.Maul:IsReady(unit) then
                return A.Maul:Show(icon)
            end
            
            -- thrash
            if Thrash():IsReady(unit) then
                return Thrash:Show(icon)
            end
            
            -- swipe
            if Swipe():IsReady(unit) then
                return Swipe:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- potion
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- barkskin,if=buff.bear_form.up
            if A.Barkskin:IsReady(unit) and (Unit("player"):HasBuffs(A.BearFormBuff.ID, true)) then
                return A.Barkskin:Show(icon)
            end
            
            -- lunar_beam,if=buff.bear_form.up
            if A.LunarBeam:IsReady(unit) and (Unit("player"):HasBuffs(A.BearFormBuff.ID, true)) then
                return A.LunarBeam:Show(icon)
            end
            
            -- bristling_fur,if=buff.bear_form.up
            if A.BristlingFur:IsReady(unit) and (Unit("player"):HasBuffs(A.BearFormBuff.ID, true)) then
                return A.BristlingFur:Show(icon)
            end
            
            -- incarnation,if=(dot.moonfire.ticking|active_enemies>1)&dot.thrash_bear.ticking
            if A.Incarnation:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and Unit(unit):HasDeBuffs(A.ThrashBearDebuff.ID, true)) then
                return A.Incarnation:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=((equipped.cyclotronic_blast&cooldown.cyclotronic_blast.remains>25&debuff.razor_coral_debuff.down)|debuff.razor_coral_debuff.down|(debuff.razor_coral_debuff.up&debuff.conductive_ink_debuff.up&target.time_to_pct_30<=2)|(debuff.razor_coral_debuff.up&time_to_die<=20))
            if A.AshvanesRazorCoral:IsReady(unit) and (((A.CyclotronicBlast:IsExists() and A.CyclotronicBlast:GetCooldown() > 25 and Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):TimeToDieX(30) <= 2) or (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and Unit(unit):TimeToDie() <= 20))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast
            if A.CyclotronicBlast:IsReady(unit) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_items
        end
        
        --Essences
        local function Essences(unit)
        
            -- concentrated_flame,if=essence.the_crucible_of_flame.major&((!dot.concentrated_flame_burn.ticking&!action.concentrated_flame_missile.in_flight)^time_to_die<=7)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Azerite:EssenceHasMajor(A.TheCrucibleofFlame.ID) and ({}^time_to_die <= 7)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- anima_of_death,if=essence.anima_of_life_and_death.major
            if A.AnimaofDeath:IsReady(unit) and (Azerite:EssenceHasMajor(A.AnimaofLifeandDeath.ID)) then
                return A.AnimaofDeath:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=essence.memory_of_lucid_dreams.major
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- worldvein_resonance,if=essence.worldvein_resonance.major
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Azerite:EssenceHasMajor(A.WorldveinResonance.ID)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space,if=essence.ripple_in_space.major
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Azerite:EssenceHasMajor(A.RippleInSpace.ID)) then
                return A.RippleInSpace:Show(icon)
            end
            
        end
        
        --Multi
        local function Multi(unit)
        
            -- maul,if=essence.conflict_and_strife.major&!buff.sharpened_claws.up
            if A.Maul:IsReady(unit) and (Azerite:EssenceHasMajor(A.ConflictandStrife.ID) and not Unit("player"):HasBuffs(A.SharpenedClawsBuff.ID, true)) then
                return A.Maul:Show(icon)
            end
            
            -- ironfur,if=(rage>=cost&azerite.layered_mane.enabled)|rage.deficit<10
            if A.Ironfur:IsReady(unit) and ((Player:Rage() >= A.Ironfur:GetSpellPowerCostCache() and A.LayeredMane:GetAzeriteRank() > 0) or Player:RageDeficit() < 10) then
                return A.Ironfur:Show(icon)
            end
            
            -- thrash,if=(buff.incarnation.up&active_enemies>=4)|cooldown.thrash_bear.up
            if Thrash():IsReady(unit) and ((Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 4) or A.ThrashBear:GetCooldown() == 0) then
                return Thrash:Show(icon)
            end
            
            -- mangle,if=buff.incarnation.up&active_enemies=3&dot.thrash_bear.ticking
            if A.Mangle:IsReady(unit) and (Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) == 3 and Unit(unit):HasDeBuffs(A.ThrashBearDebuff.ID, true)) then
                return A.Mangle:Show(icon)
            end
            
            -- moonfire,if=dot.moonfire.refreshable&active_enemies<=4
            if A.Moonfire:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4) then
                return A.Moonfire:Show(icon)
            end
            
            -- swipe,if=buff.incarnation.down
            if Swipe():IsReady(unit) and (Unit("player"):HasBuffsDown(A.IncarnationBuff.ID, true)) then
                return Swipe:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- call_action_list,name=cleave,if=active_enemies<=2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2) then
                if Cleave(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=multi,if=active_enemies>=3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                if Multi(unit) then
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

