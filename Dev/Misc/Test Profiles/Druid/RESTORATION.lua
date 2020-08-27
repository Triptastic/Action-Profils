-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW 
local HealingEngine                             = Action.HealingEngine
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")
local Action									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_DRUID_RESTORATION] = {
    -- Racial
    ArcaneTorrent                             = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                 = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                             = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                               = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                               = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Action.Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                 = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                               = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                         = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                        = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Roots   
    EntanglingRoots                           = Action.Create({ Type = "Spell", ID = 339    }),
    MassEntanglement                          = Action.Create({ Type = "Spell", ID = 102359, isTalent = true   }), 
    -- Disorient
	Cyclone                                   = Action.Create({ Type = "Spell", ID = 33786, isTalent = true   }), -- PvP Talent
	-- Stun
	MightyBash                                = Action.Create({ Type = "Spell", ID = 5211, isTalent = true   }),
	-- Knockbacks
	Typhoon                                   = Action.Create({ Type = "Spell", ID = 132469, isTalent = true   }),
    -- Hots
    Lifebloom                                 = Action.Create({ Type = "Spell", ID = 33763     }),
	Rejuvenation                              = Action.Create({ Type = "Spell", ID = 774     }),
	RejuvenationGermimation                   = Action.Create({ Type = "Spell", ID = 155777    }),
    WildGrowth                                = Action.Create({ Type = "Spell", ID = 48438     }),
	CenarionWard                              = Action.Create({ Type = "Spell", ID = 102351, isTalent = true     }),
	-- Direct Heals
	Regrowth                                  = Action.Create({ Type = "Spell", ID = 8936     }),
	Swiftmend                                 = Action.Create({ Type = "Spell", ID = 18562     }),
    -- Self Defensives
    Barkskin                                  = Action.Create({ Type = "Spell", ID = 22812     }),
	-- Cooldowns
	Ironbark                                  = Action.Create({ Type = "Spell", ID = 102342     }),
	Tranquility                               = Action.Create({ Type = "Spell", ID = 740     }),
    Innervate                                 = Action.Create({ Type = "Spell", ID = 29166     }),
    -- Shapeshift
    TravelForm                                = Action.Create({ Type = "Spell", ID = 783     }), 
    BearForm                                  = Action.Create({ Type = "Spell", ID = 5487     }), 
    CatForm                                   = Action.Create({ Type = "Spell", ID = 768     }), 
    AquaticForm                               = Action.Create({ Type = "Spell", ID = 276012     }), 	
    -- Utilities
	UrsolVortex                               = Action.Create({ Type = "Spell", ID = 102793     }),
    NaturesCure                               = Action.Create({ Type = "Spell", ID = 88423     }),  
	Dash                                      = Action.Create({ Type = "Spell", ID = 1850     }), 
	Rebirth                                   = Action.Create({ Type = "Spell", ID = 20484     }),  -- Combat Rez
	Revive                                    = Action.Create({ Type = "Spell", ID = 50769     }), 
	Hibernate                                 = Action.Create({ Type = "Spell", ID = 2637     }), 
	Soothe                                    = Action.Create({ Type = "Spell", ID = 50769     }), 
	Prowl                                     = Action.Create({ Type = "Spell", ID = 2908     }), 
	Revitalize                                = Action.Create({ Type = "Spell", ID = 212040     }), 
    -- Healing Spells       
    Efflorescence                             = Action.Create({ Type = "Spell", ID = 145205     }),
	Renewal                                   = Action.Create({ Type = "Spell", ID = 108238, isTalent = true     }),
	-- Talents
	SouloftheForest                           = Action.Create({ Type = "Spell", ID = 102351, isTalent = true, Hidden = true     }),
	IncarnationTreeofLife                     = Action.Create({ Type = "Spell", ID = 33891, isTalent = true     }),
	IncarnationTreeofLifeBuff                 = Action.Create({ Type = "Spell", ID = 117679, Hidden = true     }),
	Flourish                                  = Action.Create({ Type = "Spell", ID = 197721, isTalent = true     }),
	Photosynthesis                            = Action.Create({ Type = "Spell", ID = 274902, isTalent = true, Hidden = true     }),
	Germination                               = Action.Create({ Type = "Spell", ID = 155675, isTalent = true, Hidden = true     }),
	GuardianAffinity                          = Action.Create({ Type = "Spell", ID = 197491, isTalent = true, Hidden = true     }),
	FeralAffinity                             = Action.Create({ Type = "Spell", ID = 197490, isTalent = true, Hidden = true     }),
	BalanceAffinity                           = Action.Create({ Type = "Spell", ID = 197632, isTalent = true, Hidden = true     }),	
	InnerPeace                                = Action.Create({ Type = "Spell", ID = 197073, isTalent = true, Hidden = true     }),
	Stonebark                                 = Action.Create({ Type = "Spell", ID = 197061, isTalent = true, Hidden = true     }),
	Prosperity                                = Action.Create({ Type = "Spell", ID = 200383, isTalent = true, Hidden = true     }),
	Abundance 	                              = Action.Create({ Type = "Spell", ID = 207383, isTalent = true, Hidden = true     }),
	SpringBlossoms                            = Action.Create({ Type = "Spell", ID = 207385, isTalent = true, Hidden = true     }),
	Cultivation                               = Action.Create({ Type = "Spell", ID = 200390, isTalent = true, Hidden = true     }),
    -- PvP Talents
	Disentanglement                           = Action.Create({ Type = "Spell", ID = 233673, isTalent = true, Hidden = true     }),
	EntanglingBark                            = Action.Create({ Type = "Spell", ID = 247543, isTalent = true, Hidden = true     }),
	EarlySpring                               = Action.Create({ Type = "Spell", ID = 203624, isTalent = true, Hidden = true     }),
	Nourish                                   = Action.Create({ Type = "Spell", ID = 289022, isTalent = true     }),
	Overgrowth                                = Action.Create({ Type = "Spell", ID = 203651, isTalent = true     }),
	Thorns                                    = Action.Create({ Type = "Spell", ID = 305497, isTalent = true     }),
	DeepRoots                                 = Action.Create({ Type = "Spell", ID = 233755, isTalent = true, Hidden = true     }),		
    MarkoftheWild                             = Action.Create({ Type = "Spell", ID = 289318, isTalent = true     }),
	FocusedGrowth                             = Action.Create({ Type = "Spell", ID = 203553, isTalent = true, Hidden = true     }),
	MasterShapeshifter                        = Action.Create({ Type = "Spell", ID = 289237, isTalent = true     }),
	-- Azerites
    AutumnLeaves                              = Action.Create({ Type = "Spell", ID = 274432, Hidden = true     }),
	EarlyHarvest                              = Action.Create({ Type = "Spell", ID = 287251, Hidden = true     }),
	GroveTending                              = Action.Create({ Type = "Spell", ID = 279778, Hidden = true     }),
	LivelySpirit                              = Action.Create({ Type = "Spell", ID = 279642, Hidden = true     }),
	RampantGrowth                             = Action.Create({ Type = "Spell", ID = 278515, Hidden = true     }),
	WakingDream                               = Action.Create({ Type = "Spell", ID = 278513, Hidden = true     }),
	-- Offensives Spells
    Moonfire                                  = Action.Create({ Type = "Spell", ID = 164812     }),
	Sunfire                                   = Action.Create({ Type = "Spell", ID = 93402     }),
	SolarWrath                                = Action.Create({ Type = "Spell", ID = 5176     }),
	Mutilate                                  = Action.Create({ Type = "Spell", ID = 33917     }),
	-- Offensives abilities with Affinity
	-- Boomkin
	Starsurge                                 = Action.Create({ Type = "Spell", ID = 5176     }),
	LunarStrike                               = Action.Create({ Type = "Spell", ID = 194153     }),
	MoonkinForm                               = Action.Create({ Type = "Spell", ID = 24858     }),
	-- Guardian
	FrenziedRegeneration                      = Action.Create({ Type = "Spell", ID = 22842     }),
	Ironfur                                   = Action.Create({ Type = "Spell", ID = 192081     }),
	Thrash                                    = Action.Create({ Type = "Spell", ID = 106832     }),
	-- Feral
	Shred                                     = Action.Create({ Type = "Spell", ID = 5221     }),
	Rip                                       = Action.Create({ Type = "Spell", ID = 1079     }),
	FerociousBite                             = Action.Create({ Type = "Spell", ID = 22568     }),
	Rake                                      = Action.Create({ Type = "Spell", ID = 1822     }),
	RakeDebuff                                = Action.Create({ Type = "Spell", ID = 155722	,    Hidden = true }),
	Swipe                                     = Action.Create({ Type = "Spell", ID = 106785 }),
    -- Movememnt    

    -- Items
    PotionofReconstitution                    = Action.Create({ Type = "Potion", ID = 168502     }),     
    CoastalManaPotion                         = Action.Create({ Type = "Potion", ID = 152495     }), 
    -- Hidden 
	ClearCasting                              = Action.Create({ Type = "Spell", ID = 16870,    Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep  
    TigerTailSweep                            = Action.Create({ Type = "Spell", ID = 264348,     isTalent = true, Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RisingMist                                = Action.Create({ Type = "Spell", ID = 274909,     isTalent = true, Hidden = true }), -- 7/3 Talent "Fistweaving Rotation by damage healing"
    SpiritoftheCrane                          = Action.Create({ Type = "Spell", ID = 210802,     isTalent = true, Hidden = true }), -- 3/2 Talent "Mana regen by BlackoutKick"
    Innervate                                 = Action.Create({ Type = "Spell", ID = 29166,     Hidden = true }), -- Buff condition for Mana Tea and Mana Saving
    TeachingsoftheMonastery                   = Action.Create({ Type = "Spell", ID = 202090,     Hidden = true }), -- Buff condition for Blackout Kick
}

Action:CreateEssencesFor(ACTION_CONST_DRUID_RESTORATION)
local A = setmetatable(Action[ACTION_CONST_DRUID_RESTORATION], { __index = Action })

local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local player = "player"

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 and A.MightyBash:IsSpellLearned() and 
    A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)         
end 
A[1] = function(icon)
    -- Mighty Bash    
    if     A.MightyBash:IsReady(nil, nil, nil, true) and A.MightyBash:IsSpellLearned() and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        AntiFakeStun("targettarget") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and             
            not A.IsUnitEnemy("targettarget") 
        )
    )
    then 
        return A.MightyBash:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    elseif A.IsUnitEnemy("targettarget") then 
        unit = "targettarget"
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     
            if A.MightyBash:IsReady(unit) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
                return A.MightyBash:Show(icon)                  
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

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

-- Return number
-- Efflorescence duration left
local function Efflorescence()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 134222 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

-- Return boolean
-- Current HPS > Incoming damage
local function IsEnoughHPS(unit)
    return Unit(player):GetHPS() > Unit(unit):GetDMG()
end 

-- Return boolean
-- Current Group HPS > Incoming damage
local function IsGroupEnoughHPS()
    return ((HealingEngine.GetIncomingHPSAVG() > HealingEngine.GetIncomingDMGAVG()) or (not IsInRaid() and not IsInGroup()))
end

-- Return boolean
-- Current Group is taking massive damage that need burst
local function NeedEmergencyHPS()
    return ( HealingEngine.GetIncomingHPSAVG() * 2 < HealingEngine.GetIncomingDMGAVG() )
end

-- Return boolean
-- Current Group is taking ultra massive damage that need burst
local function NeedUltraEmergencyHPS()
    return ( HealingEngine.GetIncomingHPSAVG() * 3 < HealingEngine.GetIncomingDMGAVG() )
end

-- Mana Management
local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit(player):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

-- Cached parts 
-- PvP: Balance Solar Interrupt 
UnitCooldown:Register("arena", 78675, 60) 
-- PvP: Mage Counterspell
UnitCooldown:Register("arena", 2139, 24)
--[[local function CanZenFocusTea(mode, true)
    if A.IsInPvP and A.ZenFocusTea:IsReady(nil, nil, nil, true) and Unit(player):HasBuffs(A.ZenFocusTea.ID, true) == 0 then 
        -- If melee is around (doesn't tracking their kick but anyway)
        if not mode and EnemyTeam("DAMAGER_MELEE"):GetUnitID(15) ~= "none" then 
            return true 
        end 
        
        -- Catch Balance Interrupt if enemy in burst or while rooted
        if UnitCooldown:GetCooldown("arena", 78675) == 0 then 
            local UnitBalance = EnemyTeam("DAMAGER_RANGE"):GetUnitID(40, 102)         
            if UnitBalance ~= "none" and Unit(UnitBalance):InCC() == 0 and Unit(player):HasBuffs("Reflect") == 0 then
                -- If rooted 
                if mode == "CATCH" and LoC:Get("ROOT") > 0 then 
                    return true   
                end 
                -- If bursting 
                if not mode and (EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8)) then 
                    return true 
                end 
            end 
        end 
        
        -- Catch Mage Interrupt if enemy in burst or through Blink / Shrimmer 
        if not mode and UnitCooldown:GetCooldown("arena", 2139) == 0 then 
            local UnitMage = EnemyTeam("DAMAGER_RANGE"):GetUnitID(60, {62, 63, 64})
            if UnitMage ~= "none" and Unit(UnitMage):InCC() == 0 and Unit(player):HasBuffs("Reflect") == 0 then
                -- If Blink / Shrimmer  
                if Unit(UnitMage):GetRange() > 40 and Unit(UnitMage):GetBlinkOrShrimmer() <= 1.5 then 
                    return true   
                end 
                -- If bursting 
                if EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8) then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanZenFocusTea = A.MakeFunctionCachedDynamic(CanZenFocusTea)  ]]--

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    --if CanZenFocusTea("CATCH", true) then 
    --    return A.ZenFocusTea
    --end 
    
	-- Barkskin
    local Barkskin = A.GetToggle(2, "Barkskin")
    if     Barkskin >= 0 and A.Barkskin:IsReady("player", nil, nil, true) and IsSchoolFree() and
    (
        (     -- Auto 
            Barkskin >= 85 and 
            (
                Unit(player):HealthPercent() <= 50 or
                (                        
                    Unit(player):HealthPercent() < 70 
                )
            )
        ) or 
        (    -- Custom
            Barkskin < 85 and 
            Unit(player):HealthPercent() <= Barkskin
        )
    ) 
    then 
        return A.Barkskin
    end 
    
	-- Iron Bark
    local Ironbark = A.GetToggle(2, "Ironbark")
    if     Ironbark >= 0 and A.Ironbark:IsReady(unit) and A.IsUnitFriendly(unit) and
    (
        (     -- Auto 
            Ironbark >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(unit):GetDMG() * 100 / Unit(unit):HealthMax() >= 20 or 
                Unit(unit):GetRealTimeDMG() >= Unit(unit):HealthMax() * 0.25 or 
                -- TTD 
                Unit(unit):TimeToDieX(25) < 3 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(unit):UseDeff() or 
                        (
                            Unit(unit, 5):HasFlags() and 
                            Unit(unit):GetRealTimeDMG() > 0 and 
                            Unit(unit):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(unit):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Ironbark < 100 and 
            Unit(unit):HealthPercent() <= Ironbark
        )
    ) 
    then 
        return A.Ironbark
    end 
    
	-- Bear Form
    local BearForm = A.GetToggle(2, "BearForm")
    if     BearForm >= 0 and Unit(player):HasBuffs(A.BearForm.ID) == 0 and A.BearForm:IsReady(player) and
    (
        (     -- Auto 
            BearForm >= 100 and 
            (EnemyTeam():IsReshiftAble() or (Unit(player):HasDeBuffs(78675) > 0 and Unit(player):HasDeBuffs("Rooted") > 0))
        ) or 
        (    -- Custom
            BearForm < 100 and 
            Unit(player):HealthPercent() <= BearForm
        )
    ) 
    then 
        return A.BearForm
    end
    
    -- Stoneform on defensive
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP("player", nil, nil, true) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit(player):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit(player):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end     
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:AutoRacial("player", true, nil, true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 

-- Interrupts
local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    
    if useCC and A.MightyBash:IsReady(unit) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.MightyBash              
    end             
    
    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, true) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, true) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, true) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, true) then 
        return A.BullRush
    end      
    
end 
Interrupts = Action.MakeFunctionCachedDynamic(Interrupts)

-- Tranquility handler
local function CanTranquility()
    if A.Tranquility:IsReady(player) then 
        local TranquilityHP = A.GetToggle(2, "Tranquility")
        local TranquilityUnits = A.GetToggle(2, "TranquilityUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
		local RejuvenationCount = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 2, nil, true)
		local currentMembers = TeamCache.Friendly.Size		
		
        -- Auto Counter
        if TranquilityUnits > 40 then 
            TranquilityUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 4 or 7, 40)
            -- Reduce size in raid by 20%
            if TranquilityUnits > 5 then 
                TranquilityUnits = TranquilityUnits - (#totalMembers * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif TranquilityUnits >= TeamCache.Friendly.Size then 
            TranquilityUnits = TeamCache.Friendly.Size
        end 
        
        if TranquilityUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if TranquilityHP >= 100 and A.Tranquility:PredictHeal("Tranquility", totalMembers[i].Unit) and (Unit(totalMembers[i].Unit):TimeToDie() < 5 or totalMembers[i].HP <= 35) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if TranquilityHP < 100 and totalMembers[i].HP <= TranquilityHP then 
                counter = counter + 1
            end 
            
            if (counter >= TranquilityUnits) then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanTranquility = Action.MakeFunctionCachedDynamic(CanTranquility)

-- Flourish handler
local function CanFlourish()
    if A.Flourish:IsReady(player) and IsSchoolFree() then 
        local FlourishHP = A.GetToggle(2, "Flourish")
        local FlourishUnits = A.GetToggle(2, "FlourishUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
		local RejuvenationCount = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 2, nil, true)
		local currentMembers = TeamCache.Friendly.Size
		
        -- Auto Counter
        if FlourishUnits > 40 then 
            FlourishUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 4 or 7, 40)
            -- Reduce size in raid by 20%
            if FlourishUnits > 5 then 
                FlourishUnits = FlourishUnits - (#totalMembers * 0.20)
            end 
            -- If user typed counter higher than max available members 
        elseif FlourishUnits >= TeamCache.Friendly.Size then 
            FlourishUnits = TeamCache.Friendly.Size
        end 
        
        if FlourishUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if FlourishHP >= 100 and (Unit(totalMembers[i].Unit):TimeToDie() < 8 or totalMembers[i].HP <= 35) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if FlourishHP < 100 and totalMembers[i].HP <= FlourishHP then 
                counter = counter + 1
            end 
            
            if (counter >= FlourishUnits) and (RejuvenationCount >= (currentMembers * 0.25)) then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanFlourish = Action.MakeFunctionCachedDynamic(CanFlourish)

-- Wild Growth handler
local function CanWildGrowth(unit)
    if A.WildGrowth:IsReady(unit) and IsSchoolFree() and (not Player:IsMoving() or A.EarlySpring:IsSpellLearned())   then 
        local WildGrowthHP = A.GetToggle(2, "WildGrowth")
        local WildGrowthUnits = A.GetToggle(2, "WildGrowthUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if WildGrowthUnits > 6 then 
            WildGrowthUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 3 or 5, 40)
        end
		
        if WildGrowthUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
                -- Auto HP 
                if WildGrowthHP >= 100 and HealingEngine.GetBelowHealthPercentercentUnits(85, 20) > 2 then 
                    counter = counter + 1
                end 
                
                -- Custom HP 
                if WildGrowthHP < 100 and totalMembers[i].HP <= WildGrowthHP then 
                    counter = counter + 1
                end 
                
                if counter >= WildGrowthUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanWildGrowth = Action.MakeFunctionCachedDynamic(CanWildGrowth)

local function ActivesRejuvenations()
    if ActionUnit(player):CombatTime() > 1 then 
        local totalMembers = HealingEngine.GetMembersAll()		 	
        local RejuvenationCount = 0
		
		-- Get number of Rejuvenation for all members
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
			    if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) > 0 then
				    RejuvenationCount = RejuvenationCount + 1				
				end 
            end 
        end 
    end 
    return RejuvenationCount 
end 
ActivesRejuvenations = Action.MakeFunctionCachedDynamic(ActivesRejuvenations)

local function MaintainRejuvenation(unit)
    if A.Rejuvenation:IsReady(unit) then 
        local totalMembers = HealingEngine.GetMembersAll()		 
        local MinRaidRejuvUnits = HealingEngine.GetMinimumUnits(6, 20)
        local MinPartyRejuvenationUnits = HealingEngine.GetMinimumUnits(3, 5)
        local currentMembers = TeamCache.Friendly.Size		
		local RejuvenationCount = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 2, nil, true)

		-- Arena
		if (currentMembers == 2 or currentMembers == 3) then	
			-- Get members without Rejuvenation active
            for i = 1, #totalMembers do 
                if Unit(totalMembers[i].Unit):GetRange() <= 40 and not Unit(unit):InLOS() and currentMembers > 5 and RejuvenationCount <= currentMembers then  
			        -- SetTarget on member missing buff
				    if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then
				        HealingEngine.SetTarget(totalMembers[i].Unit)                  					
				    end
				    -- Notification					
                    Action.SendNotification("Maintaining minimum rejuvenations : " .. RejuvenationCount .. "/" .. currentMembers, A.Rejuvenation.ID) 					
                end				
            end
	    -- Party
		elseif currentMembers == 5 then		    
		    -- Get members without Rejuvenation active
            for i = 1, #totalMembers do 
                if Unit(totalMembers[i].Unit):GetRange() <= 40 and not Unit(unit):InLOS() then 
			   	    if RejuvenationCount < 3 then
			   		    -- SetTarget on member missing buff
			   	        if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then
			                HealingEngine.SetTarget(totalMembers[i].Unit)                  					
			            end
				        -- Notification					
                        Action.SendNotification("Maintaining minimum rejuvenations : " .. RejuvenationCount .. "/3.", A.Rejuvenation.ID)
                    end					
                end				
            end
		-- In Raid	
        else
    	-- Get members without Rejuvenation active
            for i = 1, #totalMembers do 
                if Unit(totalMembers[i].Unit):GetRange() <= 40 and not Unit(unit):InLOS() and currentMembers > 5 and RejuvenationCount <= (currentMembers / 4) then  
		         -- SetTarget on member missing buff
			        if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then
			            HealingEngine.SetTarget(totalMembers[i].Unit)                  					
			        end
			        -- Notification					
                    Action.SendNotification("Maintaining minimum rejuvenations : " .. RejuvenationCount .. "/" .. round((currentMembers * 0.25), 0), A.Rejuvenation.ID) 					
                end				
            end
        end			
    end 
end
MaintainRejuvenation = Action.MakeFunctionCachedDynamic(MaintainRejuvenation)

local function ResfreshRejuvenation(unit)
    if A.Rejuvenation:IsReady(unit) then 
        local totalMembers = HealingEngine.GetMembersAll()		 
        local RejuvenationUnits = HealingEngine.GetMinimumUnits(2, 4)
        local currentMembers = TeamCache.Friendly.Size
		
        if RejuvenationUnits < 2 and not A.IsInPvP then 
            return false 
        end
		
        local RejuvenationToRefresh = 0
		
		-- Get number of Rejuvenation & members count in range
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
			    if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) <= 2 or Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then
				    RejuvenationToRefresh = RejuvenationToRefresh + 1                  					
				end				
            end
			-- Party and Arena
			if currentMembers <= 5 then
		        -- Make sure we got all player with hot
                if RejuvenationToRefresh >= 1 then    
                    return true
                end	
			 
            -- In raid
		    else
                -- Pre Rejuv 1/3 of our raid / party
                if RejuvenationToRefresh > (currentMembers * 0.25) then    
                    return true
			    end		
            end 			
        end 
 
    end 
    return false 
end 
ResfreshRejuvenation = Action.MakeFunctionCachedDynamic(ResfreshRejuvenation)


local StopCast = false 
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
	local DBM = GetToggle(1 ,"DBM")
	local Potion = GetToggle(1, "Potion")
	local Racial = GetToggle(1, "Racial")
	local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
    local isMoving = Player:IsMoving()	
	local Emergency = NeedEmergencyHPS()
	local SuperEmergency = NeedUltraEmergencyHPS()	
	
    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unit)
        inRange = A.SolarWrath:IsInRange(unit)
        inMeleeRange = A.Mutilate:IsInRange(unit)
		
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit, nil, nil, true) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
			
        -- PvP MightyBash (Enemy Healer)
        if A.IsInPvP then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(25)
            if EnemyHealerUnitID ~= "none" and A.MightyBash:IsReady(EnemyHealerUnitID) and A.MightyBash:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun") and Unit(EnemyHealerUnitID):InCC() <= A.GetCurrentGCD() + A.GetPing() then
                return A.MightyBash:Show(icon)     
            end 
        end 
        
        -- Bursting 
        if A.BurstIsON(unit) and inRange then 
            
            if Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstDamaging") then 
                if A.BloodFury:AutoRacial(unit, nil, nil, true) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit, nil, nil, true) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit, nil, nil, true) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit, nil, nil, true) then 
                    return A.Berserking:Show(icon)
                end 
            end 
        end
        
        -- Trinkets 
        if inRange and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end  

        -- Auto reswitch from DPS to HEAL rotation
		if not IsGroupEnoughHPS() and A.IsUnitEnemy(unit) and (Unit(player):HasBuffs(A.MoonkinForm.ID, true) > 0 or Unit(player):HasBuffs(A.CatForm.ID, true) > 0) then
            HealingEngine.SetTargetMostlyIncDMG(1)		
        end
		
		-- Balance Affinity rotation
        if A.BalanceAffinity:IsSpellLearned() and IsGroupEnoughHPS() and inRange and not IsSaveManaPhase() then 
		
		    -- MoonkinForm
			if A.MoonkinForm:IsReady(unit) and Unit(player):HasBuffs(A.MoonkinForm.ID, true) == 0 then
			    return A.MoonkinForm:Show(icon)
			end		
			
			-- Starsurge
			if A.Starsurge:IsReady(unit) and Unit(player):HasBuffs(A.MoonkinForm.ID, true) > 0 and Player:AstralPower() >= 40 then
			    return A.Starsurge:Show(icon)
			end
			
			-- LunarStrike
   			if A.LunarStrike:IsReady(unit) and Unit(player):HasBuffs(A.MoonkinForm.ID, true) > 0 then
			    return A.LunarStrike:Show(icon)
			end
			
        end
		
			-- Prowl
			--if A.Prowl:IsReady(unit) and Unit(player):HasBuffs(A.Prowl.ID, true) == 0 then
			--    return A.Prowl:Show(icon)
			--end	
		
		-- Feral Affinity rotation
        if A.FeralAffinity:IsSpellLearned() and IsGroupEnoughHPS() and inMeleeRange and A.IsUnitEnemy(unit) then 
		    			
			-- Rip
			if A.Rip:IsReady(unit) and Unit(player):HasBuffs(A.CatForm.ID, true) > 0  and Player:EnergyPredicted() >= 20 and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID) > 2 and Unit(unit):HasDeBuffs(A.Rip.ID) <= 2 then
			    return A.Rip:Show(icon)
			end	
			
			-- FerociousBite
   			if A.FerociousBite:IsReady(unit) and Unit(player):HasBuffs(A.CatForm.ID, true) > 0  and Player:EnergyPredicted() >= 25 and Player:ComboPoints() >= 4 and MultiUnits:GetByRange(5) < 2 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID) > 0 and Unit(unit):HasDeBuffs(A.Rip.ID) > 2 then
			    return A.FerociousBite:Show(icon)
			end	
			
			-- Swipe aoe
   			if A.Swipe:IsReady(player) and Unit(player):HasBuffs(A.CatForm.ID, true) > 0 and Player:EnergyPredicted() >= 35 and MultiUnits:GetByRange(5, 5) >= 2 then
			    return A.Swipe:Show(icon)
			end
			
		    -- Shred
			if A.Shred:IsReady(unit) and Unit(player):HasBuffs(A.CatForm.ID, true) > 0 and MultiUnits:GetByRange(5, 5) < 2 and Player:ComboPoints() < 5 and Player:EnergyPredicted() >= 40 and Unit(unit):HasDeBuffs(A.Rip.ID) > 0 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID) > 0 then
			    return A.Shred:Show(icon)
			end		
		   
		    -- Rake
			if A.Rake:IsReady(unit) and Unit(player):HasBuffs(A.CatForm.ID, true) > 0 and Player:EnergyPredicted() >= 35 and Player:ComboPoints() < 5 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID) < 3 then
			    return A.Rake:Show(icon)
			end	
			
			-- CatForm
			if A.CatForm:IsReady(player) and Unit(player):HasBuffs(A.CatForm.ID, true) == 0 and not A.LastPlayerCastName == A.CatForm:Info() then
			    return A.CatForm:Show(icon)
			end
			
        end 
		
		-- Sunfire
        if A.Sunfire:IsReady(unit) and not IsSaveManaPhase()  and Unit(player):HasBuffs(A.CatForm.ID, true) == 0  and IsGroupEnoughHPS() and A.Sunfire:AbsentImun(unit, Temp.TotalAndMag) and (Unit(unit):HasDeBuffs(A.Sunfire.ID) <= 2 or Unit(unit):HasDeBuffs(A.Sunfire.ID) == 0) then 
            return A.Sunfire:Show(icon)
        end 
		
        -- Moonfire
        if A.Moonfire:IsReady(unit) and not IsSaveManaPhase()  and Unit(player):HasBuffs(A.CatForm.ID, true) == 0 and IsGroupEnoughHPS() and A.Moonfire:AbsentImun(unit, Temp.TotalAndMag) and (Unit(unit):HasDeBuffs(A.Moonfire.ID) <= 2 or Unit(unit):HasDeBuffs(A.Moonfire.ID) == 0)then 
            return A.Moonfire:Show(icon)
        end 
		
        -- Totally nothing to do 
        if not isMulti and A.SolarWrath:IsReady(unit) and Unit(player):HasBuffs(A.CatForm.ID, true) == 0 and Unit(player):HasBuffs(A.MoonkinForm.ID, true) == 0 and A.IsUnitEnemy(unit) and IsSaveManaPhase() and IsSchoolFree() then 
            if inCombat and IsGroupEnoughHPS() then
	     		-- Notification
			    Action.SendNotification("Solar Wrath to regen mana", A.SolarWrath.ID)	
                return A.SolarWrath:Show(icon)
            end            
        end	
		
        -- Azerite Essence 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and A.RippleinSpace:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(25, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)    
        ) 
        then 
            return A.RippleinSpace:Show(icon)
        end 
        
        -- Continue Rotation 
        if (isMulti or A.GetToggle(2, "AoE")) and A.ArcanePulse:AutoRacial(unit, true, nil, true) then 
            return A.ArcanePulse:Show(icon)
        end         
                   
    end 
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
	
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unit)

-- PvE Restor's Barskin
return
UNITSpec("player", 105) and
CombatTime("player") > 5 and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and 
        getRealTimeDMG("mouseover") > 0 and
        TimeToDie("mouseover") < 9 and
        UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.6 and
        (
            getHEAL("mouseover") * 1.2 < getDMG("mouseover") or
            UnitHealth("mouseover") <= getDMG("mouseover") * 2.2 
        ) and
        PvPBuffs("mouseover", "DeffBuffs") == 0 and               
        SpellInRange("mouseover", 102342) 
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        getRealTimeDMG("target") > 0 and
        TimeToDie("target") < 9 and
        UnitHealth("target") <= UnitHealthMax("target") * 0.6 and
        (
            getHEAL("target") * 1.2 < getDMG("target") or 
            UnitHealth("target") <= getDMG("target") * 2.2
        ) and
        PvPBuffs("target", "DeffBuffs") == 0 and               
        SpellInRange("target", 102342) 
    )
)



-- PvE Tranquility
return
burst_toggle and
AoE_Toggle and
UNITSpec("player", 105) and
CombatTime("player") > 10 and
(
    oDruid["Stance"] == 0 or
    oDruid["Tree"] > 0
) and
UNITCurrentSpeed("player") == 0 and
(        
    (
        PvPCache["Group_FriendlySize"] <= 2 and
        AoEHP(45) >= 2
    ) or
    (
        PvPCache["Group_FriendlySize"] <= 5 and
        AoEHP(60) >= 3
    ) or
    (
        PvPCache["Group_FriendlySize"] > 5 and      
        AoEHP(65) >= AoEMembers(true, _, 5)
    ) or     
    FrequencyAHP(GCD()*4) > 35
)



-- RPvE Incarnation
return
burst_toggle and
UNITSpec("player", 105) and
CombatTime("player") > 10 and
TalentLearn(33891) and
oDruid["Tree"] == 0 and
(    
    -- Reshift to this form back
    (
        Buffs("player", 117679, "player") > 0 and
        Buffs("player", 33891, "player") == 0
    ) or
    -- HealingEngine conditions for burst raid/party heal
    (
        PvPCache["Group_FriendlySize"] > 1 and
        oDruid["Last5sec_DMG"] > oDruid["AVG_DMG"] + oDruid["AVG_HPS"] and
        AoETTD(16) >= PvPCache["Group_FriendlySize"] * 0.67
    ) or
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        UnitIsPlayer("mouseover") and
        oDruid["MouseRange40"] and
        UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.35 and
        incdmg("mouseover") * 1.2 > getHEAL("mouseover") and
        TimeToDie("mouseover") > GCD() * 4
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        UnitIsPlayer("target") and
        oDruid["TargetRange40"] and 
        UnitHealth("target") <= UnitHealthMax("target") * 0.35 and
        incdmg("target") * 1.2 > getHEAL("target") and
        TimeToDie("target") > GCD() * 4
    )
)



-- PvE Flourish
return
burst_toggle and
UNITSpec("player", 105) and
CombatTime("player") > 10 and
TalentLearn(197721) and
(
    oDruid["Tree"] > 0 or
    oDruid["Stance"] == 3 or
    oDruid["Stance"] == 0  
) and
(
    (    
        -- HealingEngine conditions for burst raid/party heal
        PvPCache["Group_FriendlySize"] and
        PvPCache["Group_FriendlySize"] > 1 and
        CombatTime("player") > 10 and
        oDruid["Last5sec_DMG"] > oDruid["AVG_DMG"] + oDruid["AVG_HPS"] and
        AoEFlourish(60)
    ) or
    (
        -- Combo Tranquility + Wild Growth 
        SpellCD(740) >= 161 and
        LastPlayerCastID == 48438
    ) or
    (
        -- Burst heal target/mouseover if it dying and no burst heals
        not oDruid["MyBurstBuffs"] and
        (    
            -- MouseOver
            (
                MouseOver_Toggle and
                UnitExists("mouseover") and 
                MouseHasFrame() and
                not UNITDead("mouseover") and                
                not UNITEnemy("mouseover") and                 
                UnitIsPlayer("mouseover") and
                oDruid["MouseRange40"] and
                TimeToDie("mouseover") < 12 and
                UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.45 and
                PvPBuffs("mouseover", "DeffBuffs") == 0 and
                -- Rejuvenation
                Buffs("mouseover", 774, "player") > 0 and
                -- Germination
                (
                    TalentLearn(155675) and 
                    Buffs("mouseover", 155777, "player") > 0
                ) and
                -- Lifebloom or Regrowth or Wild Growth
                Buffs("mouseover", {33763, 8936, 48438}, "player") > 0 
            ) or 
            (
                (
                    not MouseOver_Toggle or 
                    not UnitExists("mouseover") or 
                    UNITEnemy("mouseover")
                ) and
                not UNITDead("target") and
                not UNITEnemy("target") and
                UnitIsPlayer("target") and
                oDruid["TargetRange40"] and
                TimeToDie("mouseover") < 12 and
                UnitHealth("target") <= UnitHealthMax("target") * 0.45 and
                PvPBuffs("target", "DeffBuffs") == 0 and  
                -- Rejuvenation
                Buffs("target", 774, "player") > 0 and
                -- Germination
                (
                    TalentLearn(155675) and 
                    Buffs("target", 155777, "player") > 0
                ) and
                -- Lifebloom or Regrowth or Wild Growth
                Buffs("target", {33763, 8936, 48438}, "player") > 0
            )
        )
    )
)



-- PvE Wild Growth
return
AoE_Toggle and
UNITSpec("player", 105) and
(
    PvPCache["Group_FriendlyType"] == "raid" or
    PvPCache["Group_FriendlyType"] == "party"
) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
UNITCurrentSpeed("player") == 0 and
(
    (
        oDruid["Innervate"] > 0 and
        oDruid["Innervate"] > CastTime(48438) + CurrentTimeGCD()
    ) or
    (
        PvPCache["Group_FriendlySize"] and 
        (
            (
                PvPCache["Group_FriendlySize"] > 5 and 
                AoEHealingBySpell(48438, "Wild Growth") >= 4
            ) or
            (
                PvPCache["Group_FriendlySize"] <= 5 and 
                AoEHealingBySpell(48438, "Wild Growth") >= 3
            )
        )
    ) or
    -- Tranquility
    LastPlayerCastID == 740 or
    AoEBuffsExist(157982) >= 2
) and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 48438) 
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 48438) 
    )
) and
LastPlayerCastID ~= 48438 -- Wild Growth




-- PvE #1 Efflorescence (Innervate refresh)
return
AoE_Toggle and
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
oDruid["Innervate"] > CurrentTimeGCD() + 0.2 and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and  
        UnitIsPlayer("mouseover") and
        oDruid["MouseRange40"]
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        UnitIsPlayer("target") and
        oDruid["TargetRange40"]
    )
) and
LastPlayerCastID~=145205 -- Efflorescence



-- RPvE #1 Swiftmend
return
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
-- Talent Soul of Forest
Buffs("player", 114108, "player") == 0 and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 18562) and
        PredictHeal("Swiftmend", "mouseover") and
        (
            UnitHealth("mouseover") <= UnitHealthMax("mouseover")*0.6 or
            (
                TalentLearn(200383) and -- [talent:1/2]
                ChargesFrac(18562) >= 1.8
            )
        )
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 18562) and
        PredictHeal("Swiftmend", "target") and
        (
            UnitHealth("target") <= UnitHealthMax("target")*0.6 or
            (
                TalentLearn(200383) and -- [talent:1/2]
                ChargesFrac(18562) >= 1.8
            )
        )
    )
)



-- RPvE #1 Regrowth (Clearcasting, Soul of Forest, Incarnation)
--Note: Soul of Forest should be used if hots is not refresh able
return
UNITSpec("player", 105) and
(
    oDruid["Tree"] > 0 or
    UNITCurrentSpeed("player") == 0
    --[[
    (
        UNITCurrentSpeed("player") == 0 and
        (
            oDruid["Stance"] == 3 or
            oDruid["Stance"] == 0  
        )
    )
]]
) and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 8936) and
        PredictHeal("Regrowth", "mouseover") and
        (
            Buffs("player", 16870, "player") > 0 or -- Clearcasting
            (
                -- Talent Soul of Forest
                Buffs("player", 114108, "player") > 0 and
                Buffs("player", 114108, "player") < 2 and
                not PT("mouseover", 774) and -- Rejuvenation
                (
                    not TalentLearn(155675) or -- Germination
                    not PT("mouseover", 114108)
                )
            ) or
            (
                oDruid["Tree"] > 0 and
                PT("mouseover", 8936) -- Regrowth
            )
        )
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 8936) and
        PredictHeal("Regrowth", "target") and
        (
            Buffs("player", 16870, "player") > 0 or -- Clearcasting
            (
                -- Talent Soul of Forest
                Buffs("player", 114108, "player") > 0 and
                Buffs("player", 114108, "player") < 2 and
                not PT("target", 774) and -- Rejuvenation
                (
                    not TalentLearn(155675) or -- Germination
                    not PT("target", 114108)
                )
            ) or
            (
                oDruid["Tree"] > 0 and
                PT("target", 8936) -- Regrowth
            )
        )
    )
) and
select(2, CastTime()) == 0 -- no casting



-- PvE Lifebloom
return
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
SpellUsable(33763) and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 33763) and
        PredictHeal("Lifebloom", "mouseover") and
        Buffs("mouseover", 33763, "player") == 0 and
        (
            (
                MostlyIncDMG("mouseover") and
                getRealTimeDMG("mouseover") > 0
            ) or
            UNITRole("mouseover", "TANK") or
            CombatTime("player") == 0 or
            -- Lifebloom Tracker (is not applied for any one unit)
            IsIconShown("TMW:icon:1S3Qj_IAsV6L") or
            -- Photosynthesis
            (
                TalentLearn(274902) and
                UnitIsUnit("mouseover", "player")
            )
        )
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 33763) and
        PredictHeal("Lifebloom", "target") and
        Buffs("target", 33763, "player") == 0 and
        (
            (
                MostlyIncDMG("target") and
                getRealTimeDMG("target") > 0
            ) or
            UNITRole("target", "TANK") or
            CombatTime("player") == 0 or
            -- Lifebloom Tracker (is not applied for any one unit)
            IsIconShown("TMW:icon:1S3Qj_IAsV6L") or
            -- Photosynthesis
            (
                TalentLearn(274902) and
                UnitIsUnit("target", "player")
            )
        )
    )
)

-- PvE Cenarion Ward
return
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
CombatTime("player") > 3 and
TalentLearn(102351) and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 102351) and
        PredictHeal("Cenarion Ward", "mouseover") and
        (
            
            (
                MostlyIncDMG("mouseover") and
                UnitHealth("mouseover") <= UnitHealthMax("mouseover")*0.9
            ) or
            UNITRole("mouseover", "TANK")
        )
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 102351) and
        PredictHeal("Cenarion Ward", "target") and
        (
            (
                MostlyIncDMG("target") and
                UnitHealth("target") <= UnitHealthMax("target")*0.9
            ) or
            UNITRole("target", "TANK")
        )
    )
)



-- PvE Rejuvenation
return
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 774) and
        PredictHeal("Rejuvenation", "mouseover") and
        (
            PT("mouseover", 774) or
            (
                TalentLearn(155675) and -- Germination
                PT("mouseover", 155777)
            )
        )
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 774) and
        PredictHeal("Rejuvenation", "target") and
        (
            PT("target", 774) or
            (
                TalentLearn(155675) and -- Germination
                PT("target", 155777)
            )
        )
    )
)


-- RPvE #2 Swiftmend
return
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
-- Talent Soul of Forest
Buffs("player", 114108, "player") == 0 and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 18562) and
        PredictHeal("Swiftmend", "mouseover") and
        UnitHealth("mouseover") <= UnitHealthMax("mouseover")*0.75
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 18562) and
        PredictHeal("Swiftmend", "target") and
        UnitHealth("target") <= UnitHealthMax("target")*0.75
    )
)



-- PvE #2 Efflorescence
--if we have 3+ melee units which can be healed or while run 
return
AoE_Toggle and
UNITSpec("player", 105) and
--[[
(
    oDruid["Stance"] == 0 or
    oDruid["Stance"] == 3 or
    oDruid["Tree"] > 0
) and
]]
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and  
        UnitIsPlayer("mouseover") and
        oDruid["MouseRange40"] and
        (
            UNITCurrentSpeed("player") > 0 or
            not PT("mouseover", 8936) -- Regrowth   
        ) and
        PredictHeal("Efflorescence", "mouseover")        
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        UnitIsPlayer("target") and
        oDruid["TargetRange40"] and
        (
            UNITCurrentSpeed("player") > 0 or
            not PT("target", 8936) -- Regrowth   
        ) and
        PredictHeal("Efflorescence", "target") 
    ) or
    AoEHealingByRange(40, "Efflorescence", true) >= 3
) and
LastPlayerCastID~=145205 -- Efflorescence



-- RPvE #2 Regrowth
return
UNITSpec("player", 105) and
(
    oDruid["Tree"] > 0 or
    UNITCurrentSpeed("player") == 0
    --[[
    (
        (
            oDruid["Stance"] == 3 or
            oDruid["Stance"] == 0 
        ) and
        UNITCurrentSpeed("player") == 0
    )  
]]   
) and
(
    -- MouseOver
    (
        MouseOver_Toggle and
        UnitExists("mouseover") and 
        MouseHasFrame() and
        not UNITDead("mouseover") and                
        not UNITEnemy("mouseover") and                 
        SpellInRange("mouseover", 8936) and
        UNITHP("mouseover") <= 95 and
        PredictHeal("Regrowth", "mouseover") and
        (
            PvPCache["Group_FriendlySize"] <= 5 or
            UNITRole("mouseover", "TANK") or
            UNITHP("mouseover") <= 40
        )
    ) or 
    (
        (
            not MouseOver_Toggle or 
            not UnitExists("mouseover") or 
            UNITEnemy("mouseover")
        ) and
        not UNITDead("target") and
        not UNITEnemy("target") and
        SpellInRange("target", 8936) and
        UNITHP("target") <= 95 and
        PredictHeal("Regrowth", "target") and
        (
            PvPCache["Group_FriendlySize"] <= 5 or
            UNITRole("target", "TANK") or
            UNITHP("target") <= 40
        )
    )
) and
select(2, CastTime()) == 0 -- no casting


















        
	
    end 
    HealingRotation = Action.MakeFunctionCachedDynamic(HealingRotation)
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
	
	-- Friendly Mouseover
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"  
		
        if HealingRotation(unit) then 
            return true 
        end             
    end
    
    -- Enemy Mouseover 
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"	
		
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    -- DPS Target     
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 

    -- DPS targettarget     
    if A.IsUnitEnemy("targettarget") then 
        unit = "targettarget"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
	
    -- Heal Target 
    if A.IsUnitFriendly("target") then 
        unit = "target" 
		
        if HealingRotation(unit) then 
            return true 
        end 
    end 
    
    -- Misc 
    if A.IsInPvP and not isMoving and A.Nourish:IsReady() and IsSchoolFree() then 
        return A.Nourish:Show(icon)
    end     
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    --if Player:IsMovingTime() < 2.5 then 
    --    return 
    --end 
        
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

-- [5] Trinket Rotation
-- No specialization trinket actions 

-- Passive 
local function Passive()
-- Passive Barskin
return 
not UNITSpec("player", 103) and -- Feral
CombatTime("player")>0 and
(
    MacroSpells("Icon6", "Barkskin") or
    (
        deff_toggle and
        incdmg("player")>0 and        
        (
            (
                oDruid["DeffBuffs"] == 0 and
                (
                    (
                        not InPvP() and
                        TimeToDie("player")<12 and
                        UnitHealth("player")<=UnitHealthMax("player")*0.68
                    ) or
                    (
                        TimeToDie("player") < 14 and
                        incdmg("player") * 3 >= UnitHealth("player")
                    ) or
                    (
                        TimeToDie("player")<7 and
                        getRealTimeDMG("player") > 0 and
                        UnitHealth("player")<=UnitHealthMax("player")*0.25
                    )
                )
            ) or
            (
                InPvP() and
                oDruid["PvPNeedDeffMe"] and
                (
                    (
                        not UNITSpec("player", 105) and
                        oDruid["PvPFriendlyHealerInCC"]
                    ) or
                    DeBuffs("player", 212182) > 0 or -- Smoke Bomb
                    (
                        UNITSpec("player", 105) and -- Restor
                        incdmg("player") > getHEAL("player")
                    )
                ) and
                oDruid["PvPTargetingMe"] and
                (
                    (
                        oDruid["DeffBuffs"] == 0 and
                        TimeToDie("player")<=GCD()*8
                    ) or
                    PvPExecuteRisk("player")            
                )        
            ) or
            (
                -- Restor
                UNITSpec("player", 105) and
                InPvP() and
                oDruid["PvPTargetingMe"] and
                oDruid["DeffBuffs"] == 0 and
                PvPDeBuffs("player", "Stuned") > 2 and
                (
                    PvPEnemyBurst("player", true) or
                    getHEAL("player") <= UnitHealthMax("player")*0.2 or
                    TimeToDie("player") <= PvPDeBuffs("player", "Stuned") + GCD()*4
                )
            )
        )        
    )    
)


end 

local function ArenaRotation(unit)
    if A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() then             
        --local remainCast = Unit(player):IsCastingRemains(A.SoothingMist.ID) > 0
        
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("playrr"):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then                 
            -- PvP Cyclone
            if A.Cyclone:IsReady(unit) and not Unit(unit):InLOS() and Unit(unit):GetDR("disorient") > 25 then
                return A.Cyclone
            end  
        end 
        
        -- PvP Disarm 
        if A.MightyBashIsReady(unit, false, true) and not Unit(unit):InLOS() and Unit(unit):GetDR("incapacitate") > 25  then
            return A.MightyBash
        end         
    end 
end 

local function PartyRotation(unit)
    --local castRemain = Unit(player):IsCastingRemains(A.SoothingMist.ID) > 0
    -- NaturesCure   -- and not Unit(unit):InLOS()
    if A.NaturesCure:IsReady(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel")  then                         
        return A.NaturesCure
    end 
    -- Dash
    if A.Dash:IsReady("player", nil, nil, true) and not Unit("player", 5):HasFlags() and (Unit(unit):IsMelee() or Unit(player):IsFocused(nil, true) or Unit(unit):HasBuffs("DamageBuffs") > 0) and not Unit(unit):InLOS() then 
        if Unit(unit):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.Dash
        end 
        
        local cMoving = Unit(unit):GetCurrentSpeed()
        if cMoving > 0 and cMoving < 64 then -- 64 because unit can moving backward 
            return A.Dash
        end 
    end 
    
    
end 

A[6] = function(icon)    
    --if StopCast and Unit(player):IsCastingRemains(A.SoothingMist.ID) > 0 then 
    --    return A:Show(icon, ACTION_CONST_STOPCAST)
    --end 
    
    StopCast = false 
    
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    local Arena = ArenaRotation("arena2")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end