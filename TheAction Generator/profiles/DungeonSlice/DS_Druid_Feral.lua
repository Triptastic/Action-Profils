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

Action[ACTION_CONST_DRUID_FERAL] = {
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
    WildFleshrending                       = Create({ Type = "Spell", ID = 279527 }),
    Regrowth                               = Create({ Type = "Spell", ID = 8936 }),
    BloodtalonsBuff                        = Create({ Type = "Spell", ID = 145152 }),
    Bloodtalons                            = Create({ Type = "Spell", ID = 155672 }),
    CatFormBuff                            = Create({ Type = "Spell", ID = 768 }),
    CatForm                                = Create({ Type = "Spell", ID = 768 }),
    ProwlBuff                              = Create({ Type = "Spell", ID = 5215 }),
    Prowl                                  = Create({ Type = "Spell", ID = 5215 }),
    BerserkBuff                            = Create({ Type = "Spell", ID = 106951 }),
    Berserk                                = Create({ Type = "Spell", ID = 106951 }),
    TigersFury                             = Create({ Type = "Spell", ID = 5217 }),
    TigersFuryBuff                         = Create({ Type = "Spell", ID = 5217 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    Thorns                                 = Create({ Type = "Spell", ID = 467 }),
    ThornsDebuff                           = Create({ Type = "Spell", ID = 467 }),
    FeralFrenzy                            = Create({ Type = "Spell", ID = 274837 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    Incarnation                            = Create({ Type = "Spell", ID = 102543 }),
    IncarnationBuff                        = Create({ Type = "Spell", ID = 102543 }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984 }),
    Rake                                   = Create({ Type = "Spell", ID = 1822 }),
    RakeDebuff                             = Create({ Type = "Spell", ID = 155722 }),
    JungleFury                             = Create({ Type = "Spell", ID = 274424 }),
    SavageRoar                             = Create({ Type = "Spell", ID = 52610 }),
    PoolResource                           = Create({ Type = "Spell", ID = 9999000010 }),
    SavageRoarBuff                         = Create({ Type = "Spell", ID = 52610 }),
    PrimalWrath                            = Create({ Type = "Spell", ID = 285381 }),
    RipDebuff                              = Create({ Type = "Spell", ID = 1079 }),
    Rip                                    = Create({ Type = "Spell", ID = 1079 }),
    Sabertooth                             = Create({ Type = "Spell", ID = 202031 }),
    Maim                                   = Create({ Type = "Spell", ID = 22570 }),
    IronJawsBuff                           = Create({ Type = "Spell", ID = 276026 }),
    FerociousBiteMaxEnergy                 = Create({ Type = "Spell", ID = 22568 }),
    FerociousBite                          = Create({ Type = "Spell", ID = 22568 }),
    PredatorySwiftnessBuff                 = Create({ Type = "Spell", ID = 69369 }),
    LunarInspiration                       = Create({ Type = "Spell", ID = 155580 }),
    BrutalSlash                            = Create({ Type = "Spell", ID = 202028 }),
    ThrashCat                              = Create({ Type = "Spell", ID = 106830 }),
    ThrashCatDebuff                        = Create({ Type = "Spell", ID = 106830 }),
    ScentofBlood                           = Create({ Type = "Spell", ID = 285564 }),
    ScentofBloodBuff                       = Create({ Type = "Spell", ID = 285646 }),
    SwipeCat                               = Create({ Type = "Spell", ID = 106785 }),
    MoonfireCat                            = Create({ Type = "Spell", ID = 155625 }),
    Shred                                  = Create({ Type = "Spell", ID = 5221 }),
    MoonfireCatDebuff                      = Create({ Type = "Spell", ID = 155625 }),
    ClearcastingBuff                       = Create({ Type = "Spell", ID = 135700 }),
    ShadowmeldBuff                         = Create({ Type = "Spell", ID = 58984 }),
    CyclingVariable                        = Create({ Type = "Spell", ID =  })
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
A:CreateCovenantsFor(ACTION_CONST_DRUID_FERAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_FERAL], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarUseThrash = 0;
local VarReapingDelay = 0;
local VarOpenerDone = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarUseThrash = 0
  VarReapingDelay = 0
  VarOpenerDone = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- FERAL PRE APL SETUP -----------
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
local player = "player"

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function InMelee(unit)
    -- @return boolean 
    return A.Rake:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit(target, unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InMelee(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end 
        end 
    end
end 

-- Return the lowest Unit TTD value
-- Used as snipping function 
local function LowestTTD()
    local lowTTD = 0
    for activeunits in pairs(ActiveUnitPlates) do
        if (lowTTD == 0 or Unit(activeunits):TimeToDie() < lowTTD) then
            lowTTD = Unit(activeunits):TimeToDie()
        end
    end
    return lowTTD
end

local function SwipeBleedMult()
    return (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0 or Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > 0 or Unit(unit):HasDeBuffs(A.ThrashCatDebuff.ID, true) > 0) and 1.2 or 1
end

local function RakeBleedTick()
    return LastRakeAP * 0.15561 * (1 + Player:VersatilityDmgPct() / 100)
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return A.IsUnitEnemy(unit)    
end 
A[1] = function(icon)    

	-- Cyclone
    if     A.AntiFakeCCFocusCyclone:IsReady(nil, nil, nil, true) and Unit("target"):GetRange() <= 20 and 
    (
        AntiFakeStun("mouseover") 
		or 
        AntiFakeStun("target") 
    )
    then 
        return A.AntiFakeCCFocusCyclone:Show(icon)         
    end 
	
	-- MightyBash
    if     A.MightyBashGreen:IsReady(nil, nil, nil, true) and Unit("target"):GetRange() <= 8 and 
    (
        AntiFakeStun("mouseover") 
		or 
        AntiFakeStun("target") 
    )
    then 
        return A.MightyBashGreen:Show(icon)         
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
            if not notKickAble and A.SkullBashGreen:IsReady(unit, nil, nil, true) and A.SkullBashGreen:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.SkullBashGreen:Show(icon)                                                  
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
    
    -- SurvivalInstincts
    local SurvivalInstincts = A.GetToggle(2, "SurvivalInstincts")
    if     SurvivalInstincts >= 0 and A.SurvivalInstincts:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            SurvivalInstincts >= 100 and 
            (
                Unit(player):HealthPercent() <= 50 or
                (                        
                    Unit(player):HealthPercent() < 70 
                )
            )
        ) 
        or 
        (    -- Custom
            SurvivalInstincts < 100 and 
            Unit(player):HealthPercent() <= SurvivalInstincts
        )
    ) 
    then 
        return A.SurvivalInstincts
    end 
 
    -- Bear Form
 --[[   local BearForm = A.GetToggle(2, "BearForm")
    if     BearForm >= 0 and not IsInBearForm and A.BearForm:IsReady("player") and
    (
        (     -- Auto 
            BearForm >= 100 and Unit(player):HealthPercent() < 20 and
            (
			    EnemyTeam():IsReshiftAble() 
				or 
				(Unit(player):HasDeBuffs(78675) > 0 and Unit(player):HasDeBuffs("Rooted") > 0)
			)
        ) 
        or 
        (    -- Custom
            BearForm < 100 and 
            Unit(player):HealthPercent() <= BearForm
        )
    ) 
    then 
        return A.BearForm
    end
 ]]--
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

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

-- Stealth Handler UI --
local function HandleStealth()
    local choice = GetToggle(2, "AutoStealthOOC")
    local unit = "target"
    return     (
        (IsInRaid() and choice[1]) or 
        (IsInGroup() and choice[2]) or
        (A.IsInPvP and choice[3]) or
		(A.Prowl:IsReady() and choice[4])
    )
end

A.FerociousBiteMaxEnergy.CustomCost = {
    [3] = function ()
        if (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0 or Unit(player):HasBuffs(A.BerserkBuff.ID, true) > 0) then 
		    return 25
        else 
		    return 50
        end
    end
}

local function BalanceAffinity(unit)
	
	-- Sunfire
	if A.Sunfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) < 4 then
        return A.Sunfire	
	end
		
	-- Moonfire	
	if A.Moonfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) < 4 then
        return A.Moonfire	
	end
		
	-- Solar Wrath
	if A.SolarWrath:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and 
    Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) > 0
	then
        return A.SolarWrath	
	end
		
	-- Lunar Strike
	if A.LunarStrike:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and
	Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) > 0
	then
        return A.LunarStrike
	end
		
	-- Starsurge
	if A.Starsurge:IsReady(unit) and (Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) == 0 or Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0) then
        return A.Starsurge	
	end	
	
	-- Solar Wrath
	if A.SolarWrath:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and 
    Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) == 0 and A.Starsurge:GetCooldown() > 0
	then
        return A.SolarWrath	
	end

end

local function IsInHumanForm()
    return Player:GetStance() == 0
end

local function IsInBearForm()
    return Player:GetStance() == 1
end

local function IsInCatForm()
    return Player:GetStance() == 2
end

local function IsInTravelForm()
    return Player:GetStance() == 3
end

local function IsInMoonkinForm()
    return Player:GetStance() == 4
end

local function EvaluateCycleReapingFlames106(unit)
    return Unit(unit):TimeToDie() < 1.5 or ((Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) and VarReapingDelay > 29) or (target.time_to_pct_20 > 30 and VarReapingDelay > 44)
end

local function EvaluateCyclePrimalWrath192(unit)
    return MultiUnits:GetByRangeInCombat(5, 5, 10) > 1 and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 4
end

local function EvaluateCyclePrimalWrath203(unit)
    return MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2
end

local function EvaluateCycleRip212(unit)
    return not Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) or (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff.ID, true:BaseDuration() * 0.3) and (not A.Sabertooth:IsSpellLearned()) or (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff.ID, true:BaseDuration() * 0.8 and A.Persistent_PMultiplier(A.Rip) > A.PMultiplier(unit, A.RipDebuff.ID)) and Unit(unit):TimeToDie() > 8
end

local function EvaluateTargetIfFilterFerociousBite271(unit)
  return max:druid.rip.ticks_gained_on_refresh
end

local function EvaluateCycleRake349(unit)
    return not Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) or (not A.Bloodtalons:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < A.RakeDebuff.ID, true:BaseDuration() * 0.3) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleRake378(unit)
    return A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffs(A.BloodtalonsBuff.ID, true) and ((Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) <= 7) and A.Persistent_PMultiplier(A.Rake) > A.PMultiplier(unit, A.RakeDebuff.ID) * 0.85) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleMoonfireCat437(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.MoonfireCatDebuff.ID, true)
end

local function EvaluateCycleFerociousBite559(unit)
    return Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 3 and Unit(unit):TimeToDie() > 10 and (A.Sabertooth:IsSpellLearned())
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
            -- variable,name=use_thrash,value=0
            VarUseThrash = 0
            
            -- variable,name=use_thrash,value=2,if=azerite.wild_fleshrending.enabled
            if (A.WildFleshrending:GetAzeriteRank() > 0) then
                VarUseThrash = 2
            end
            
            -- regrowth,if=talent.bloodtalons.enabled
            if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned()) then
                return A.Regrowth:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- cat_form
            if A.CatForm:IsReady(unit) and Unit("player"):HasBuffsDown(A.CatFormBuff.ID, true) then
                return A.CatForm:Show(icon)
            end
            
            -- prowl
            if A.Prowl:IsReady(unit) and Unit("player"):HasBuffsDown(A.ProwlBuff.ID, true) then
                return A.Prowl:Show(icon)
            end
            
            -- potion,dynamic_prepot=1
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- berserk
            if A.Berserk:IsReady(unit) and Unit("player"):HasBuffsDown(A.BerserkBuff.ID, true) and A.BurstIsON(unit) then
                return A.Berserk:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
            if A.Berserk:IsReady(unit) and A.BurstIsON(unit) and (Player:EnergyPredicted() >= 30 and (A.TigersFury:GetCooldown() > 5 or Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true))) then
                return A.Berserk:Show(icon)
            end
            
            -- tigers_fury,if=energy.deficit>=60
            if A.TigersFury:IsReady(unit) and (Player:EnergyDeficitPredicted() >= 60) then
                return A.TigersFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- thorns,if=active_enemies>desired_targets|raid_event.adds.in>45
            if A.Thorns:IsReady(unit) and (MultiUnits:GetByRangeInCombat(30, 5, 10) > 1 or IncomingAddsIn > 45) then
                return A.Thorns:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.tigers_fury.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=buff.tigers_fury.up&buff.berserk.down
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and Unit("player"):HasBuffsDown(A.BerserkBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.tigers_fury.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- feral_frenzy,if=combo_points=0
            if A.FeralFrenzy:IsReady(unit) and (Player:ComboPoints() == 0) then
                return A.FeralFrenzy:Show(icon)
            end
            
            -- focused_azerite_beam,if=active_enemies>desired_targets|(raid_event.adds.in>90&energy.deficit>=50)
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 or (IncomingAddsIn > 90 and Player:EnergyDeficitPredicted() >= 50)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=active_enemies>desired_targets|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 or IncomingAddsIn > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- guardian_of_azeroth,if=buff.tigers_fury.up
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- concentrated_flame,if=buff.tigers_fury.up
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- ripple_in_space,if=buff.tigers_fury.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.tigers_fury.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&variable.reaping_delay>29)|(target.time_to_pct_20>30&variable.reaping_delay>44)
            if A.ReapingFlames:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ReapingFlames, 8, "min", EvaluateCycleReapingFlames106) then
                    return A.ReapingFlames:Show(icon) 
                end
            end
            -- incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
            if A.Incarnation:IsReady(unit) and A.BurstIsON(unit) and (Player:EnergyPredicted() >= 30 and (A.TigersFury:GetCooldown() > 15 or Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true))) then
                return A.Incarnation:Show(icon)
            end
            
            -- potion,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit(unit):TimeToDie() < 65 or (Unit(unit):TimeToDie() < 180 and (Unit("player"):HasBuffs(A.BerserkBuff.ID, true) or Unit("player"):HasBuffs(A.IncarnationBuff.ID, true)))) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
            if A.Shadowmeld:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:ComboPoints() < 5 and Player:EnergyPredicted() >= A.Rake:GetSpellPowerCostCache() and A.PMultiplier(unit, A.RakeDebuff.ID) < 2.1 and Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and (Unit("player"):HasBuffs(A.BloodtalonsBuff.ID, true) or not A.Bloodtalons:IsSpellLearned()) and (not A.Incarnation:IsSpellLearned() or A.Incarnation:GetCooldown() > 18) and not Unit("player"):HasBuffs(A.IncarnationBuff.ID, true)) then
                return A.Shadowmeld:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.time_to_pct_30<1.5|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|target.time_to_die<40)&buff.tigers_fury.remains>10
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):TimeToDieX(30) < 1.5 or not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) >= 25 - 10 * num(Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or Unit(unit):TimeToDie() < 40) and Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) > 10) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=(energy.deficit>=energy.regen*3)&buff.tigers_fury.down&!azerite.jungle_fury.enabled
            if A.CyclotronicBlast:IsReady(unit) and ((Player:EnergyDeficitPredicted() >= Player:EnergyRegen() * 3) and Unit("player"):HasBuffsDown(A.TigersFuryBuff.ID, true) and not A.JungleFury:GetAzeriteRank() > 0) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.tigers_fury.up&azerite.jungle_fury.enabled
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and A.JungleFury:GetAzeriteRank() > 0) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,effect_name=azsharas_font_of_power,if=energy.deficit>=50
            if A.AzsharasFontofPower:IsReady(unit) and (Player:EnergyDeficitPredicted() >= 50) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_items,if=buff.tigers_fury.up|target.time_to_die<20
        end
        
        --Finishers
        local function Finishers(unit)
        
            -- pool_resource,for_next=1
            -- savage_roar,if=buff.savage_roar.down
            if A.SavageRoar:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SavageRoarBuff.ID, true)) then
                if A.SavageRoar:IsUsablePPool() then
                    return A.SavageRoar:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- primal_wrath,target_if=spell_targets.primal_wrath>1&dot.rip.remains<4
            if A.PrimalWrath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.PrimalWrath, 8, "min", EvaluateCyclePrimalWrath192) then
                    return A.PrimalWrath:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- primal_wrath,target_if=spell_targets.primal_wrath>=2
            if A.PrimalWrath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.PrimalWrath, 8, "min", EvaluateCyclePrimalWrath203) then
                    return A.PrimalWrath:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- rip,target_if=!ticking|(remains<=duration*0.3)&(!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
            if A.Rip:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rip, 8, "min", EvaluateCycleRip212) then
                    return A.Rip:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- savage_roar,if=buff.savage_roar.remains<12
            if A.SavageRoar:IsReady(unit) and (Unit("player"):HasBuffs(A.SavageRoarBuff.ID, true) < 12) then
                if A.SavageRoar:IsUsablePPool() then
                    return A.SavageRoar:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- maim,if=buff.iron_jaws.up
            if A.Maim:IsReady(unit) and (Unit("player"):HasBuffs(A.IronJawsBuff.ID, true)) then
                if A.Maim:IsUsablePPool() then
                    return A.Maim:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- ferocious_bite,max_energy=1,target_if=max:druid.rip.ticks_gained_on_refresh
            if A.FerociousBiteMaxEnergy:IsReady(unit) and A.FerociousBiteMaxEnergy:IsUsableP then
                if Action.Utils.CastTargetIf(A.FerociousBiteMaxEnergy, 8, "max", EvaluateTargetIfFilterFerociousBite271) then 
                    return A.FerociousBiteMaxEnergy:Show(icon) 
                end
            end
        end
        
        --Generators
        local function Generators(unit)
        
            -- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
            if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff.ID, true) and Unit("player"):HasBuffsDown(A.BloodtalonsBuff.ID, true) and Player:ComboPoints() == 4 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < 4) then
                return A.Regrowth:Show(icon)
            end
            
            -- regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1
            if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffsDown(A.BloodtalonsBuff.ID, true) and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff.ID, true) and A.LunarInspiration:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < 1) then
                return A.Regrowth:Show(icon)
            end
            
            -- brutal_slash,if=spell_targets.brutal_slash>desired_targets
            if A.BrutalSlash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) then
                return A.BrutalSlash:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2)
            if A.ThrashCat:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff.ID, true)) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2)) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3
            if A.ThrashCat:IsReady(unit) and ((A.ScentofBlood:IsSpellLearned() and Unit("player"):HasBuffsDown(A.ScentofBloodBuff.ID, true)) and MultiUnits:GetByRangeInCombat(8, 5, 10) > 3) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- swipe_cat,if=buff.scent_of_blood.up|(action.swipe_cat.damage*spell_targets.swipe_cat>(action.rake.damage+(action.rake_bleed.tick_damage*5)))
            if A.SwipeCat:IsReady(unit) and (Unit("player"):HasBuffs(A.ScentofBloodBuff.ID, true) or (action.swipe_cat.damage * MultiUnits:GetByRangeInCombat(8, 5, 10) > (action.rake.damage + (action.rake_bleed.tick_damage * 5)))) then
                if A.SwipeCat:IsUsablePPool() then
                    return A.SwipeCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
            if A.Rake:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rake, 8, "min", EvaluateCycleRake349) then
                    return A.Rake:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
            if A.Rake:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rake, 8, "min", EvaluateCycleRake378) then
                    return A.Rake:Show(icon) 
                end
            end
            -- moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5
            if A.MoonfireCat:IsReady(unit) and (Unit("player"):HasBuffs(A.BloodtalonsBuff.ID, true) and Unit("player"):HasBuffsDown(A.PredatorySwiftnessBuff.ID, true) and Player:ComboPoints() < 5) then
                return A.MoonfireCat:Show(icon)
            end
            
            -- brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))&(spell_targets.brutal_slash*action.brutal_slash.damage%action.brutal_slash.cost)>(action.shred.damage%action.shred.cost)
            if A.BrutalSlash:IsReady(unit) and ((Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and (IncomingAddsIn > (1 + A.BrutalSlash:GetSpellChargesMax() - A.BrutalSlash:GetSpellChargesFrac()) * A.BrutalSlash:RechargeP())) and (MultiUnits:GetByRangeInCombat(8, 5, 10) * action.brutal_slash.damage / A.BrutalSlash:GetSpellPowerCostCache()) > (action.shred.damage / A.Shred:GetSpellPowerCostCache())) then
                return A.BrutalSlash:Show(icon)
            end
            
            -- moonfire_cat,target_if=refreshable
            if A.MoonfireCat:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MoonfireCat, 40, "min", EvaluateCycleMoonfireCat437) then
                    return A.MoonfireCat:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1)
            if A.ThrashCat:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff.ID, true) and ((VarUseThrash == 2 and (not Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) or A.WildFleshrending:GetAzeriteRank() > 0)) or MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled)
            if A.ThrashCat:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff.ID, true) and VarUseThrash == 1 and Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and (not Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) or A.WildFleshrending:GetAzeriteRank() > 0)) then
                return A.ThrashCat:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- swipe_cat,if=spell_targets.swipe_cat>1
            if A.SwipeCat:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) then
                if A.SwipeCat:IsUsablePPool() then
                    return A.SwipeCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
            if A.Shred:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > (A.Shred:GetSpellPowerCostCache() + A.Rake:GetSpellPowerCostCache() - Player:EnergyPredicted()) / Player:EnergyRegen() or Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true)) then
                return A.Shred:Show(icon)
            end
            
        end
        
        --Opener
        local function Opener(unit)
        
            -- tigers_fury
            if A.TigersFury:IsReady(unit) then
                return A.TigersFury:Show(icon)
            end
            
            -- rake,if=!ticking|buff.prowl.up
            if A.Rake:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) or Unit("player"):HasBuffs(A.ProwlBuff.ID, true)) then
                return A.Rake:Show(icon)
            end
            
            -- variable,name=opener_done,value=dot.rip.ticking
            VarOpenerDone = num(Unit(unit):HasDeBuffs(A.RipDebuff.ID, true))
            
            -- wait,sec=0.001,if=dot.rip.ticking
            -- moonfire_cat,if=!ticking
            if A.MoonfireCat:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.MoonfireCatDebuff.ID, true)) then
                return A.MoonfireCat:Show(icon)
            end
            
            -- rip,if=!ticking
            if A.Rip:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RipDebuff.ID, true)) then
                return A.Rip:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack,if=!buff.prowl.up&!buff.shadowmeld.up
            -- run_action_list,name=opener,if=variable.opener_done=0
            if (VarOpenerDone == 0) then
                return Opener(unit);
            end
            
            -- cat_form,if=!buff.cat_form.up
            if A.CatForm:IsReady(unit) and (not Unit("player"):HasBuffs(A.CatFormBuff.ID, true)) then
                return A.CatForm:Show(icon)
            end
            
            -- rake,if=buff.prowl.up|buff.shadowmeld.up
            if A.Rake:IsReady(unit) and (Unit("player"):HasBuffs(A.ProwlBuff.ID, true) or Unit("player"):HasBuffs(A.ShadowmeldBuff.ID, true)) then
                return A.Rake:Show(icon)
            end
            
            -- variable,name=reaping_delay,value=target.time_to_die,if=variable.reaping_delay=0
            if (VarReapingDelay == 0) then
                VarReapingDelay = Unit(unit):TimeToDie()
            end
            
            -- cycling_variable,name=reaping_delay,op=min,value=target.time_to_die
            if A.CyclingVariable:IsReady(unit) then
                return A.CyclingVariable:Show(icon) = math.min(return A.CyclingVariable:Show(icon), Unit(unit):TimeToDie())
            end
            
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
            -- ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(talent.sabertooth.enabled)
            if A.FerociousBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FerociousBite, 8, "min", EvaluateCycleFerociousBite559) then
                    return A.FerociousBite:Show(icon) 
                end
            end
            -- regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down
            if A.Regrowth:IsReady(unit) and (Player:ComboPoints() == 5 and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff.ID, true) and A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffsDown(A.BloodtalonsBuff.ID, true)) then
                return A.Regrowth:Show(icon)
            end
            
            -- run_action_list,name=finishers,if=combo_points>4
            if (Player:ComboPoints() > 4) then
                return Finishers(unit);
            end
            
            -- run_action_list,name=generators
            return Generators(unit);
            
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

