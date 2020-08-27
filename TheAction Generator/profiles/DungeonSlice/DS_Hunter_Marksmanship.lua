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

Action[ACTION_CONST_HUNTER_MARKSMANSHIP] = {
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
    HuntersMarkDebuff                      = Create({ Type = "Spell", ID = 257284 }),
    HuntersMark                            = Create({ Type = "Spell", ID = 257284 }),
    DoubleTap                              = Create({ Type = "Spell", ID = 260402 }),
    TrueshotBuff                           = Create({ Type = "Spell", ID = 288613 }),
    Trueshot                               = Create({ Type = "Spell", ID = 288613 }),
    AimedShot                              = Create({ Type = "Spell", ID = 19434 }),
    RapidFire                              = Create({ Type = "Spell", ID = 257044 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Create({ Type = "Spell", ID = 26297 }),
    CarefulAim                             = Create({ Type = "Spell", ID = 260228 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Create({ Type = "Spell", ID = 20572 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    VisionofPerfection                     = Create({ Type = "Spell", ID =  }),
    WorldveinResonanceBuff                 = Create({ Type = "Spell", ID =  }),
    PotionofUnbridledFuryBuff              = Create({ Type = "Spell", ID =  }),
    UnbridledFuryBuff                      = Create({ Type = "Spell", ID =  }),
    ExplosiveShot                          = Create({ Type = "Spell", ID = 212431 }),
    Barrage                                = Create({ Type = "Spell", ID = 120360 }),
    AMurderofCrows                         = Create({ Type = "Spell", ID = 131894 }),
    SerpentSting                           = Create({ Type = "Spell", ID = 271788 }),
    SerpentStingDebuff                     = Create({ Type = "Spell", ID = 271788 }),
    LethalShots                            = Create({ Type = "Spell", ID =  }),
    IntheRhythmBuff                        = Create({ Type = "Spell", ID =  }),
    UnerringVisionBuff                     = Create({ Type = "Spell", ID = 274447 }),
    UnerringVision                         = Create({ Type = "Spell", ID = 274444 }),
    ArcaneShot                             = Create({ Type = "Spell", ID = 185358 }),
    MasterMarksmanBuff                     = Create({ Type = "Spell", ID = 269576 }),
    DoubleTapBuff                          = Create({ Type = "Spell", ID =  }),
    PreciseShotsBuff                       = Create({ Type = "Spell", ID = 260242 }),
    PiercingShot                           = Create({ Type = "Spell", ID = 198670 }),
    SteadyShot                             = Create({ Type = "Spell", ID = 56641 }),
    TrickShotsBuff                         = Create({ Type = "Spell", ID = 257622 }),
    FocusedFire                            = Create({ Type = "Spell", ID = 278531 }),
    IntheRhythm                            = Create({ Type = "Spell", ID = 264198 }),
    SurgingShots                           = Create({ Type = "Spell", ID = 287707 }),
    Streamline                             = Create({ Type = "Spell", ID = 260367 }),
    Multishot                              = Create({ Type = "Spell", ID = 257620 }),
    CallingtheShots                        = Create({ Type = "Spell", ID = 260404 }),
    GuardianofAzerothBuff                  = Create({ Type = "Spell", ID =  }),
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

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_HUNTER_MARKSMANSHIP)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_MARKSMANSHIP], { __index = Action })





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

------------------------------------------
------- MARKMANSHIP PRE APL SETUP --------
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

-- API - Spell
-- Example of create:
Pet:Add(254, {
	-- number accepted
	17253, -- Bite
	16827, -- Claw
	49966, -- Smack
	--47481, -- Gnaw
	-- strings also accepted!
--	"Gnaw",
--	(GetSpellInfo(47481)), -- must be in '(' ')' because call this function will return multi returns through ',' 
})

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
	
    -- Exhilaration
    local Exhilaration = GetToggle(2, "ExhilarationHP")
    if     Exhilaration >= 0 and A.Exhilaration:IsReady(player) and 
    (
        (     -- Auto 
            Exhilaration >= 100 and 
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
            Exhilaration < 100 and 
            Unit(player):HealthPercent() <= Exhilaration
        )
    ) 
    then 
	    -- Notification					
        Action.SendNotification("[DEF] Exhilaration", A.Exhilaration.ID)
        return A.Exhilaration
    end

    -- SpiritMend
	local CurrentCreatureFamily = UnitCreatureFamily(pet)
    local SpiritMend = GetToggle(2, "SpiritMendHP")
	--Pet:GetMainPet()
    if     SpiritMend >= 0 and A.SpiritMend:IsReady() and CurrentCreatureFamily == "Esprit de bête" and --and not A.AnimalCompanion:IsSpellLearned()
    (
        (     -- Auto 
            SpiritMend >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(15) < 3 or 
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
            SpiritMend < 100 and 
            Unit(player):HealthPercent() <= SpiritMend
        )
    ) 
    then 
		    -- Notification					
        Action.SendNotification("[DEF] Spirit Mend", A.SpiritMend.ID)
        return A.SpiritMend
    end	
	
    -- AspectoftheTurtle
    local AspectoftheTurtle = GetToggle(2, "Turtle")
    if     AspectoftheTurtle >= 0 and A.AspectoftheTurtle:IsReady(player) and 
    (
        (     -- Auto 
            AspectoftheTurtle >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
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
            AspectoftheTurtle < 100 and 
            Unit(player):HealthPercent() <= AspectoftheTurtle
        )
    ) 
    then
		    -- Notification					
        Action.SendNotification("[DEF] Aspect of the Turtle", A.AspectoftheTurtle.ID)	
        return A.AspectoftheTurtle
    end     
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- TO USE AFTER NEXT ACTION UPDATE
local function InterruptsNEW(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.CounterShot:IsReady(unit)) -- A.Kick non GCD spell
    
	if castDoneTime > 0 then
        -- CounterShot
        if useKick and not notInterruptable and A.CounterShot:IsReady(unit) then 
            return A.CounterShot:Show(icon)
        end

        -- ConcussiveShot
        if useCC and A.ConcussiveShot:IsReady(unit) then 
            return A.ConcussiveShot
   	    end  
	
        -- BindingShot
        if useCC and A.BindingShot:IsReady(unit) and Unit(unit):IsControlAble("stun", 0) then 
            return A.BindingShot
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


local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.CounterShot:IsReady(unit) and A.CounterShot:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
	    -- Notification					
        Action.SendNotification("Counter Shot interrupting on Target ", A.CounterShot.ID)
        return A.CounterShot
    end 

    if useCC and A.ConcussiveShot:IsReady(unit) and A.ConcussiveShot:AbsentImun(unit, Temp.TotalAndCC, true) then 
	    -- Notification					
        Action.SendNotification("Concussive Shot snare...", A.ConcussiveShot.ID)
        return A.ConcussiveShot              
    end    

    if useCC and A.BindingShot:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.BindingShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	    -- Notification					
        Action.SendNotification("Binding Shot interrupting...", A.BindingShot.ID)
        return A.BindingShot              
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

-- Offensive dispel rotation
local function PurgeDispellMagic(unit)
	local CurrentCreatureFamily = UnitCreatureFamily("pet") 
	
	-- SpiritShock
	if A.SpiritShock:IsReady(unit) and CurrentCreatureFamily == "Spirit Beast" and not ShouldStop and (Action.AuraIsValid(unit, "UseExpelEnrage", "Enrage") or Action.AuraIsValid(unit, "UseDispel", "Magic")) then
		return A.SpiritShock:Show(icon)
    end
			
    -- SonicBlast
    if A.SonicBlast:IsReady(unit) and CurrentCreatureFamily == "Bat" and not ShouldStop and (Action.AuraIsValid(unit, "UseExpelEnrage", "Enrage") or Action.AuraIsValid(unit, "UseDispel", "Magic")) then
        return A.SonicBlast:Show(icon)
    end		
end
PurgeDispellMagic = A.MakeFunctionCachedDynamic(PurgeDispellMagic)

local function InRange(unit)
	-- @return boolean 
	return A.Trueshot:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	
	if isStrictlySuperior == nil then
	    isStrictlySuperior = false
	end

	if isStrictlyInferior == nil then
	    isStrictlyInferior = false
	end	
	
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
			if InRange(unit) then 
				c = c + 1
			elseif range then 
				local r = Unit(unit):GetRange()
				if r > 0 and r <= range then 
					c = c + 1
				end 
			end 
			-- Strictly superior than >
			if isStrictlySuperior and not isStrictlyInferior then
			    if c > count then
				    return true
				end
			end
			
			-- Stryctly inferior <
			if isStrictlyInferior and not isStrictlySuperior then
			    if c < count then
			        return true
				end
			end
			
			-- Classic >=
			if not isStrictlyInferior and not isStrictlySuperior then
			    if c >= count then 
				    return true 
			    end 
			end
		end 
		
	end
	
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

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
            -- augmentation
            -- food
            -- snapshot_stats
            -- hunters_mark
            if A.HuntersMark:IsReady(unit) and Unit("player"):HasDebuffsDown(A.HuntersMarkDebuff.ID, true) then
                return A.HuntersMark:Show(icon)
            end
            
            -- double_tap,precast_time=10
            if A.DoubleTap:IsReady(unit) then
                return A.DoubleTap:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- trueshot,precast_time=1.5,if=active_enemies>2
            if A.Trueshot:IsReady(unit) and Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Trueshot:Show(icon)
            end
            
            -- potion,dynamic_prepot=1
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- aimed_shot,if=active_enemies<3
            if A.AimedShot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.AimedShot:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- hunters_mark,if=debuff.hunters_mark.down&!buff.trueshot.up
            if A.HuntersMark:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.HuntersMarkDebuff.ID, true) and not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true)) then
                return A.HuntersMark:Show(icon)
            end
            
            -- double_tap,if=cooldown.rapid_fire.remains<gcd|cooldown.rapid_fire.remains<cooldown.aimed_shot.remains|target.time_to_die<20
            if A.DoubleTap:IsReady(unit) and (A.RapidFire:GetCooldown() < GetGCD() or A.RapidFire:GetCooldown() < A.AimedShot:GetCooldown() or Unit(unit):TimeToDie() < 20) then
                return A.DoubleTap:Show(icon)
            end
            
            -- berserking,if=prev_gcd.1.trueshot&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<13
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:PrevGCD(1, A.Trueshot) and (Unit(unit):TimeToDie() > A.Berserking:BaseDuration() + A.BerserkingBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
            
            -- blood_fury,if=prev_gcd.1.trueshot&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:PrevGCD(1, A.Trueshot) and (Unit(unit):TimeToDie() > A.BloodFury:BaseDuration() + A.BloodFuryBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.BloodFury:Show(icon)
            end
            
            -- ancestral_call,if=prev_gcd.1.trueshot&(target.time_to_die>cooldown.ancestral_call.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:PrevGCD(1, A.Trueshot) and (Unit(unit):TimeToDie() > A.AncestralCall:BaseDuration() + duration or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.AncestralCall:Show(icon)
            end
            
            -- fireblood,if=prev_gcd.1.trueshot&(target.time_to_die>cooldown.fireblood.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<9
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:PrevGCD(1, A.Trueshot) and (Unit(unit):TimeToDie() > A.Fireblood:BaseDuration() + duration or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 9) then
                return A.Fireblood:Show(icon)
            end
            
            -- lights_judgment,if=buff.trueshot.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.trueshot.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- reaping_flames,if=buff.trueshot.down&(target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30)
            if A.ReapingFlames:IsReady(unit) and (Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30)) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- worldvein_resonance,if=(trinket.azsharas_font_of_power.cooldown.remains>20|!equipped.azsharas_font_of_power|target.time_to_die<trinket.azsharas_font_of_power.cooldown.duration+34&target.health.pct>20)&(cooldown.trueshot.remains_guess<3|(essence.vision_of_perfection.minor&target.time_to_die>cooldown+buff.worldvein_resonance.duration))|target.time_to_die<20
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((trinket.azsharas_font_of_power.cooldown.remains > 20 or not A.AzsharasFontofPower:IsExists() or Unit(unit):TimeToDie() < trinket.azsharas_font_of_power.cooldown.duration + 34 and Unit(unit):HealthPercent() > 20) and (cooldown.trueshot.remains_guess < 3 or (Azerite:EssenceHasMinor(A.VisionofPerfection.ID) and Unit(unit):TimeToDie() > cooldown + A.WorldveinResonanceBuff.ID, true:BaseDuration())) or Unit(unit):TimeToDie() < 20) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- guardian_of_azeroth,if=(ca_execute|target.time_to_die>cooldown+30)&(buff.trueshot.up|cooldown.trueshot.remains<16)|target.time_to_die<31
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((ca_execute or Unit(unit):TimeToDie() > cooldown + 30) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or A.Trueshot:GetCooldown() < 16) or Unit(unit):TimeToDie() < 31) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- ripple_in_space,if=cooldown.trueshot.remains<7
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Trueshot:GetCooldown() < 7) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=!buff.trueshot.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- potion,if=buff.trueshot.react&buff.bloodlust.react|prev_gcd.1.trueshot&target.health.pct<20|((consumable.potion_of_unbridled_fury|consumable.unbridled_fury)&target.time_to_die<61|target.time_to_die<26)
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasBuffsStacks(A.TrueshotBuff.ID, true) and Unit("player"):HasHeroism() or Player:PrevGCD(1, A.Trueshot) and Unit(unit):HealthPercent() < 20 or ((Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff.ID, true) or Unit(unit):HasBuffs(A.UnbridledFuryBuff.ID, true)) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26)) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- trueshot,if=buff.trueshot.down&cooldown.rapid_fire.remains|target.time_to_die<15
            if A.Trueshot:IsReady(unit) and (Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and A.RapidFire:GetCooldown() or Unit(unit):TimeToDie() < 15) then
                return A.Trueshot:Show(icon)
            end
            
        end
        
        --St
        local function St(unit)
        
            -- explosive_shot
            if A.ExplosiveShot:IsReady(unit) then
                return A.ExplosiveShot:Show(icon)
            end
            
            -- barrage,if=active_enemies>1
            if A.Barrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.Barrage:Show(icon)
            end
            
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- serpent_sting,if=refreshable&!action.serpent_sting.in_flight
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not A.SerpentSting:IsSpellInFlight()) then
                return A.SerpentSting:Show(icon)
            end
            
            -- rapid_fire,if=buff.trueshot.down|focus<35|focus<60&!talent.lethal_shots.enabled|buff.in_the_rhythm.remains<execute_time
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) or Player:Focus() < 35 or Player:Focus() < 60 and not A.LethalShots:IsSpellLearned() or Unit("player"):HasBuffs(A.IntheRhythmBuff.ID, true) < A.RapidFire:GetSpellCastTime()) then
                return A.RapidFire:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.trueshot.up&(buff.unerring_vision.stack>4|!azerite.unerring_vision.enabled)|target.time_to_die<11
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.UnerringVisionBuff.ID, true) > 4 or not A.UnerringVision:GetAzeriteRank() > 0) or Unit(unit):TimeToDie() < 11) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- focused_azerite_beam,if=!buff.trueshot.up|target.time_to_die<5
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or Unit(unit):TimeToDie() < 5) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&!buff.memory_of_lucid_dreams.up
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ArcaneShot:Show(icon)
            end
            
            -- aimed_shot,if=buff.trueshot.up|(buff.double_tap.down|ca_execute)&buff.precise_shots.down|full_recharge_time<cast_time&cooldown.trueshot.remains
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or (Unit("player"):HasBuffsDown(A.DoubleTapBuff.ID, true) or ca_execute) and Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true) or A.AimedShot:GetSpellChargesFullRechargeTime() < A.AimedShot:GetSpellCastTime() and A.Trueshot:GetCooldown()) then
                return A.AimedShot:Show(icon)
            end
            
            -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&buff.memory_of_lucid_dreams.up
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ArcaneShot:Show(icon)
            end
            
            -- piercing_shot
            if A.PiercingShot:IsReady(unit) then
                return A.PiercingShot:Show(icon)
            end
            
            -- purifying_blast,if=!buff.trueshot.up|target.time_to_die<8
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or Unit(unit):TimeToDie() < 8) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.trueshot.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:Focus() + Player:FocusRegen() * GetGCD() < Player:FocusMax() and Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD() or Unit(unit):TimeToDie() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10 or Unit(unit):TimeToDie() < 5) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- arcane_shot,if=buff.trueshot.down&(buff.precise_shots.up&(focus>55|buff.master_marksman.up)|focus>75|target.time_to_die<5)
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and (Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) and (Player:Focus() > 55 or Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true)) or Player:Focus() > 75 or Unit(unit):TimeToDie() < 5)) then
                return A.ArcaneShot:Show(icon)
            end
            
            -- steady_shot
            if A.SteadyShot:IsReady(unit) then
                return A.SteadyShot:Show(icon)
            end
            
        end
        
        --Trickshots
        local function Trickshots(unit)
        
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            
            -- explosive_shot
            if A.ExplosiveShot:IsReady(unit) then
                return A.ExplosiveShot:Show(icon)
            end
            
            -- aimed_shot,if=buff.trick_shots.up&ca_execute&buff.double_tap.up
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and ca_execute and Unit("player"):HasBuffs(A.DoubleTapBuff.ID, true)) then
                return A.AimedShot:Show(icon)
            end
            
            -- rapid_fire,if=buff.trick_shots.up&(azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled)
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and (A.FocusedFire:GetAzeriteRank() > 0 or A.IntheRhythm:GetAzeriteRank() > 1 or A.SurgingShots:GetAzeriteRank() > 0 or A.Streamline:IsSpellLearned())) then
                return A.RapidFire:Show(icon)
            end
            
            -- aimed_shot,if=buff.trick_shots.up&(buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time|buff.trueshot.up)
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and (Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true) or A.AimedShot:FullRechargeTimeP() < A.AimedShot:GetSpellCastTime() or Unit("player"):HasBuffs(A.TrueshotBuff.ID, true))) then
                return A.AimedShot:Show(icon)
            end
            
            -- rapid_fire,if=buff.trick_shots.up
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true)) then
                return A.RapidFire:Show(icon)
            end
            
            -- multishot,if=buff.trick_shots.down|buff.precise_shots.up&!buff.trueshot.up|focus>70
            if A.Multishot:IsReady(unit) and (Unit("player"):HasBuffsDown(A.TrickShotsBuff.ID, true) or Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) and not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or Player:Focus() > 70) then
                return A.Multishot:Show(icon)
            end
            
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- piercing_shot
            if A.PiercingShot:IsReady(unit) then
                return A.PiercingShot:Show(icon)
            end
            
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- serpent_sting,if=refreshable&!action.serpent_sting.in_flight
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not A.SerpentSting:IsSpellInFlight()) then
                return A.SerpentSting:Show(icon)
            end
            
            -- steady_shot
            if A.SteadyShot:IsReady(unit) then
                return A.SteadyShot:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_shot
            -- use_item,name=lurkers_insidious_gift,if=cooldown.trueshot.remains_guess<15|target.time_to_die<30
            if A.LurkersInsidiousGift:IsReady(unit) and (cooldown.trueshot.remains_guess < 15 or Unit(unit):TimeToDie() < 30) then
                return A.LurkersInsidiousGift:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=(target.time_to_die>cooldown+34|target.health.pct<20|target.time_to_pct_20<15)&cooldown.trueshot.remains_guess<15|target.time_to_die<35
            if A.AzsharasFontofPower:IsReady(unit) and ((Unit(unit):TimeToDie() > cooldown + 34 or Unit(unit):HealthPercent() < 20 or target.time_to_pct_20 < 15) and cooldown.trueshot.remains_guess < 15 or Unit(unit):TimeToDie() < 35) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=lustrous_golden_plumage,if=cooldown.trueshot.remains_guess<5|target.time_to_die<20
            if A.LustrousGoldenPlumage:IsReady(unit) and (cooldown.trueshot.remains_guess < 5 or Unit(unit):TimeToDie() < 20) then
                return A.LustrousGoldenPlumage:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=prev_gcd.1.trueshot|!talent.calling_the_shots.enabled|target.time_to_die<10
            if A.GalecallersBoon:IsReady(unit) and (Player:PrevGCD(1, A.Trueshot) or not A.CallingtheShots:IsSpellLearned() or Unit(unit):TimeToDie() < 10) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=prev_gcd.1.trueshot&(buff.guardian_of_azeroth.up|!essence.condensed_lifeforce.major&ca_execute)|debuff.razor_coral_debuff.down|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Player:PrevGCD(1, A.Trueshot) and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and ca_execute) or Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):TimeToDie() < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=pocketsized_computation_device,if=!buff.trueshot.up&!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up|target.time_to_die<5
            if A.PocketsizedComputationDevice:IsReady(unit) and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true) or Unit(unit):TimeToDie() < 5) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
            
            -- use_items,if=prev_gcd.1.trueshot|!talent.calling_the_shots.enabled|target.time_to_die<20
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- call_action_list,name=st,if=active_enemies<3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                if St(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=trickshots,if=active_enemies>2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                if Trickshots(unit) then
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

