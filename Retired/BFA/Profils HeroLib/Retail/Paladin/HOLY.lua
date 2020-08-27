local TMW                                     = TMW 

local Action                                 = Action
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
--local Pet                                     = LibStub("PetLibrary")
local Azerite                                 = LibStub("AzeriteTraits")

local setmetatable                            = setmetatable


Action[ACTION_CONST_DRUID_RESTORATION] = {
    -- Racial
    ArcaneTorrent                             = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                   = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                              = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                                  = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                                  = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Action.Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                  = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                  = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                          = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
     -- Racials
    ArcaneTorrent                                             = Action.Create({ Type = "Spell", ID = 25046     }),
    GiftoftheNaaru                                             = Action.Create({ Type = "Spell", ID = 59547     }),

    --Spells
    Cleanse                                             = Action.Create({ Type = "Spell", ID = 4987     }),
    Judgement                                             = Action.Create({ Type = "Spell", ID = 275773     }),
    CrusaderStrike                                             = Action.Create({ Type = "Spell", ID = 35395     }),
    Consecration                                             = Action.Create({ Type = "Spell", ID = 26573     }),
    LightoftheMartyr                                             = Action.Create({ Type = "Spell", ID = 183998     }),
    LightoftheMartyrStack                                             = Action.Create({ Type = "Spell", ID = 223316     }),
    FlashofLight                                             = Action.Create({ Type = "Spell", ID = 19750     }),
    HolyShock                                             = Action.Create({ Type = "Spell", ID = 20473     }),
    InfusionofLight                                             = Action.Create({ Type = "Spell", ID = 54149     }),
    BeaconofLight                                             = Action.Create({ Type = "Spell", ID = 53563     }),
    BeaconofVirtue                                             = Action.Create({ Type = "Spell", ID = 200025     }),
    LightofDawn                                             = Action.Create({ Type = "Spell", ID = 85222     }),
	AuraMastery                                             = Action.Create({ Type = "Spell", ID = 31821     }),
	AvengingWrath                                             = Action.Create({ Type = "Spell", ID = 31884     }),
	HolyAvenger                                             = Action.Create({ Type = "Spell", ID = 105809     }),
	BestowFaith                                             = Action.Create({ Type = "Spell", ID = 223306     }),
	AvengingCrusader                                             = Action.Create({ Type = "Spell", ID = 216331     }),
	JudgmentOfLightHoly                                             = Action.Create({ Type = "Spell", ID = 183778     }),
	BlessingOfSacrifice                                             = Action.Create({ Type = "Spell", ID = 6940     }),
	BeaconOfFaith                                             = Action.Create({ Type = "Spell", ID = 156910     }),
	JudgementofLight                                             = Action.Create({ Type = "Spell", ID = 183778     }),
	CrusadersMight                                             = Action.Create({ Type = "Spell", ID = 196926     }),
	ConsecrationUp                                             = Action.Create({ Type = "Spell", ID = 204242     }),
	JudgmentUp                                             = Action.Create({ Type = "Spell", ID = 214222     }),
	HolyPrism                                             = Action.Create({ Type = "Spell", ID = 114165     }),
	LightsHammer                                             = Action.Create({ Type = "Spell", ID = 114158     }),

    --Azerite
    DivineRevelations                                             = Action.Create({ Type = "Spell", ID = 275469     }),
	GlimmerofLight                                             = Action.Create({ Type = "Spell", ID = 287268     }),
	
	--Heart Essences
	ConcentratedFlameHeal                                             = Action.Create({ Type = "Spell", ID = 295373     }),
	ConcentratedFlameHeal2                                             = Action.Create({ Type = "Spell", ID = 168612     }),
	ConcentratedFlameHeal3                                             = Action.Create({ Type = "Spell", ID = 168613     }),
	LifeBindersInvocation                                             = Action.Create({ Type = "Spell", ID = 293032     }),
	LifeBindersInvocation2                                             = Action.Create({ Type = "Spell", ID = 299943     }),
	LifeBindersInvocation3                                             = Action.Create({ Type = "Spell", ID = 299944     }),
	OverchargeMana                                             = Action.Create({ Type = "Spell", ID = 296072     }),
	OverchargeMana2                                             = Action.Create({ Type = "Spell", ID = 299875     }),
	OverchargeMana3                                             = Action.Create({ Type = "Spell", ID = 299876     }),
	Refreshment                                             = Action.Create({ Type = "Spell", ID = 296197     }),
	Refreshment2                                             = Action.Create({ Type = "Spell", ID = 299932     }),
	Refreshment3                                             = Action.Create({ Type = "Spell", ID = 299933     }),
	UnleashHeartofAzeroth                                             = Action.Create({ Type = "Spell", ID = 280431     }),
	VitalityConduit                                             = Action.Create({ Type = "Spell", ID = 296230     }),
	VitalityConduit2                                             = Action.Create({ Type = "Spell", ID = 299958     }),
	VitalityConduit3                                             = Action.Create({ Type = "Spell", ID = 299959     }),
	MemoryOfLucidDreams                                             = Action.Create({ Type = "Spell", ID = 298357     }),
	MemoryOfLucidDreams2                                             = Action.Create({ Type = "Spell", ID = 299372     }),
	MemoryOfLucidDreams3                                             = Action.Create({ Type = "Spell", ID = 299374     }),

    --Healing
    BlessingofProtection                                             = Action.Create({ Type = "Spell", ID = 1022     }),
    HolyLight                                             = Action.Create({ Type = "Spell", ID = 82326     }),
    LayOnHands                                             = Action.Create({ Type = "Spell", ID = 633     }),
    Forbearance                                             = Action.Create({ Type = "Spell", ID = 25771     }),
    DivineProtection                                             = Action.Create({ Type = "Spell", ID = 498     }),
    DivineShield                                             = Action.Create({ Type = "Spell", ID = 642     }),

    -- Items
    PotionofReconstitution                     = Action.Create({ Type = "Potion", ID = 168502     }),     
    CoastalManaPotion                        = Action.Create({ Type = "Potion", ID = 152495     }), 
    -- Hidden 
	ClearCasting                                 = Action.Create({ Type = "Spell", ID = 16870,    Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep  
    TigerTailSweep                            = Action.Create({ Type = "Spell", ID = 264348,     isTalent = true, Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RisingMist                                = Action.Create({ Type = "Spell", ID = 274909,     isTalent = true, Hidden = true }), -- 7/3 Talent "Fistweaving Rotation by damage healing"
    SpiritoftheCrane                        = Action.Create({ Type = "Spell", ID = 210802,     isTalent = true, Hidden = true }), -- 3/2 Talent "Mana regen by BlackoutKick"
    Innervate                                = Action.Create({ Type = "Spell", ID = 29166,     Hidden = true }), -- Buff condition for Mana Tea and Mana Saving
    TeachingsoftheMonastery                    = Action.Create({ Type = "Spell", ID = 202090,     Hidden = true }), -- Buff condition for Blackout Kick
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

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = 
GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 and A.MightyBash:IsSpellLearned() and 
    Unit(unit):IsControlAble("stun", 0) and 
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
            not A.IsUnitEnemy("targettarget") and            
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5, 1) >= 1)
            )
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
            if A.MightyBash:IsReady(unit, nil, nil, true) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
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
--                 ROTATION  
-----------------------------------------
--[[
local function ChiJi()
    -- InvokeChiJitheRedCrane
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 25 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end
]]

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
    return Unit("player"):GetHPS() > Unit(unit):GetDMG()
end 

local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit("player"):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit("player"):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit("player"):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

-- Cached parts 
-- PvP: Balance Solar Interrupt 
UnitCooldown:Register("arena", 78675, 60) 
-- PvP: Mage Counterspell
UnitCooldown:Register("arena", 2139, 24)
--[[local function CanZenFocusTea(mode, true)
    if A.IsInPvP and A.ZenFocusTea:IsReady(nil, nil, nil, true) and Unit("player"):HasBuffs(A.ZenFocusTea.ID, true) == 0 then 
        -- If melee is around (doesn't tracking their kick but anyway)
        if not mode and EnemyTeam("DAMAGER_MELEE"):GetUnitID(15) ~= "none" then 
            return true 
        end 
        
        -- Catch Balance Interrupt if enemy in burst or while rooted
        if UnitCooldown:GetCooldown("arena", 78675) == 0 then 
            local UnitBalance = EnemyTeam("DAMAGER_RANGE"):GetUnitID(40, 102)         
            if UnitBalance ~= "none" and Unit(UnitBalance):InCC() == 0 and Unit("player"):HasBuffs("Reflect") == 0 then
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
            if UnitMage ~= "none" and Unit(UnitMage):InCC() == 0 and Unit("player"):HasBuffs("Reflect") == 0 then
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
    if Unit("player"):CombatTime() == 0 then 
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
                Unit("player"):HealthPercent() <= 50 or
                (                        
                    Unit("player"):HealthPercent() < 70 
                )
            )
        ) or 
        (    -- Custom
            Barkskin < 85 and 
            Unit("player"):HealthPercent() <= Barkskin
        )
    ) 
    then 
        return A.Barkskin
    end 
    
	-- Iron Bark
    local Ironbark = A.GetToggle(2, "Ironbark")
    if     Ironbark >= 0 and A.Ironbark:IsReady(unit, nil, nil, true) and A.IsUnitFriendly(unit) and
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
    if     BearForm >= 0 and Unit("player"):HasBuffs(A.BearForm.ID) == 0 and A.BearForm:IsReady("player") and
    (
        (     -- Auto 
            BearForm >= 100 and 
            (EnemyTeam():IsReshiftAble() or (Unit("player"):HasDeBuffs(78675) > 0 and Unit("player"):HasDeBuffs("Rooted") > 0))
        ) or 
        (    -- Custom
            BearForm < 100 and 
            Unit("player"):HealthPercent() <= BearForm
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
                    Unit("player"):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit("player"):HealthPercent() <= Stoneform
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

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    
    if useCC and A.MightyBash:IsReady(unit, nil, nil, true) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
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
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanTranquility()
    if A.Tranquility:IsReady("player") and IsSchoolFree() then 
        local TranquilityHP = A.GetToggle(2, "Tranquility")
        local TranquilityUnits = A.GetToggle(2, "TranquilityUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
		local RejuvenationCount = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 2)
		local currentMembers = TeamCache.Friendly.Size		
		
        -- Auto Counter
        if TranquilityUnits > 40 then 
            TranquilityUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 8 or 11, 25)
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
            if TranquilityHP >= 100 and A.Tranquility:PredictHeal("Tranquility", totalMembers[i].Unit) and (RejuvenationCount >= (currentMembers / 3.5)) and (Unit(totalMembers[i].Unit):TimeToDieX(20) < 8 or totalMembers[i].HP <= 35) and Unit("player"):GetHPS() < Unit(totalMembers[i].Unit):GetDMG() then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if TranquilityHP < 100 and totalMembers[i].HP <= TranquilityHP then 
                counter = counter + 1
            end 
            
            if (counter >= TranquilityUnits) and Emergency then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanTranquility = A.MakeFunctionCachedDynamic(CanTranquility)

local function CanFlourish()
    if A.Flourish:IsReady("player") and IsSchoolFree() then 
        local FlourishHP = A.GetToggle(2, "Flourish")
        local FlourishUnits = A.GetToggle(2, "FlourishUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
		local RejuvenationCount = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 2)
		local currentMembers = TeamCache.Friendly.Size
		
        -- Auto Counter
        if FlourishUnits > 40 then 
            FlourishUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 5 or 8, 25)
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
            if FlourishHP >= 100 and (RejuvenationCount >= (currentMembers / 3)) and (Unit(totalMembers[i].Unit):TimeToDieX(20) < 8 or totalMembers[i].HP <= 35) and Unit("player"):GetHPS() < Unit(totalMembers[i].Unit):GetDMG() then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if FlourishHP < 100 and totalMembers[i].HP <= FlourishHP then 
                counter = counter + 1
            end 
            
            if (counter >= FlourishUnits) then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanFlourish = A.MakeFunctionCachedDynamic(CanFlourish)

local function CanWildGrowth(unit)
    if A.WildGrowth:IsReady(unit) and IsSchoolFree() and not Player:IsMoving() then 
        local WildGrowthHP = A.GetToggle(2, "WildGrowth")
        local WildGrowthUnits = A.GetToggle(2, "WildGrowthUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if WildGrowthUnits > 6 then 
            WildGrowthUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 3 or 5, 25)
        end
		
        if WildGrowthUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
                -- Auto HP 
                if WildGrowthHP >= 100 and (A.WildGrowth:PredictHeal("WildGrowth", totalMembers[i].Unit) or totalMembers[i].HP <= 75) then 
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
CanWildGrowth = A.MakeFunctionCachedDynamic(CanWildGrowth)

local function ActivesRejuvenations()
    if ActionUnit("player"):CombatTime() > 1 then 
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
ActivesRejuvenations = A.MakeFunctionCachedDynamic(ActivesRejuvenations)

local function MaintainRejuvenation(unit)
    if A.Rejuvenation:IsReady(unit) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()		 
        local MinRaidRejuvUnits = HealingEngine.GetMinimumUnits(6, 20)
        local MinPartyRejuvenationUnits = HealingEngine.GetMinimumUnits(3, 5)
        local currentMembers = TeamCache.Friendly.Size		
		local RejuvenationCount = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 2)

		-- Arena
		if (currentMembers == 2 or currentMembers == 3) then	
			-- Get members without Rejuvenation active
            for i = 1, #totalMembers do 
                if Unit(totalMembers[i].Unit):GetRange() <= 30 and not Unit(unit):InLOS() and currentMembers > 5 and RejuvenationCount <= currentMembers then  
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
                if Unit(totalMembers[i].Unit):GetRange() <= 30 and not Unit(unit):InLOS() then 
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
                if Unit(totalMembers[i].Unit):GetRange() <= 30 and not Unit(unit):InLOS() and currentMembers > 5 and RejuvenationCount <= (currentMembers / 3) then  
		         -- SetTarget on member missing buff
			        if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then
			            HealingEngine.SetTarget(totalMembers[i].Unit)                  					
			        end
			        -- Notification					
                    Action.SendNotification("Maintaining minimum rejuvenations : " .. RejuvenationCount .. "/" .. round((currentMembers / 3), 0), A.Rejuvenation.ID) 					
                end				
            end
        end			
    end 
end
MaintainRejuvenation = A.MakeFunctionCachedDynamic(MaintainRejuvenation)

local function ResfreshRejuvenation(unit)
    if A.Rejuvenation:IsReady(unit) and IsSchoolFree() then 
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
                if RejuvenationToRefresh > (currentMembers / 3) then    
                    return true
			    end		
            end 			
        end 
 
    end 
    return false 
end 
ResfreshRejuvenation = A.MakeFunctionCachedDynamic(ResfreshRejuvenation)


local StopCast = false 
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --local unit                     = "player"
    local isMoving                 = Player:IsMoving()
    --local true = Unit(unit):IsCastingRemains(A.SoothingMist.ID) > 0
    local inRange                 = false
    Efflorescence()
	--/ run Action.SendNotification("TESSSSSSSSSSSSSSST", 8921, 2)
	
	


    -- DPS Rotation
    local function DamageRotation(unit)

		if A.Judgement:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) then
			return A.Judgement:Show(icon)
		end

		if A.HolyShock:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) then
			return A.HolyShock:Show(icon)
		end
		
		if A.CrusaderStrike:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) then
			return A.CrusaderStrike:Show(icon)
		end
		
		if A.Consecration:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) and not Unit(unit):HasDeBuffs(A.ConsecrationUp.ID) then
			return A.Consecration:Show(icon)
		end
		
		if A.Judgement:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) then
			return A.Judgement:Show(icon)
		end

		if A.CrusaderStrike:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) then
			return A.CrusaderStrike:Show(icon)
		end
		
        -- Bursting 
        if A.BurstIsON(unit) and inRange and A.AbsentImun(nil, unit, Temp.TotalAndPhys) then 
            
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
        if inRange and A.AbsentImun(nil, unit, Temp.TotalAndMag) and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit, nil, nil, true) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit, nil, nil, true) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end
		
        -- Azerite Essence 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and A.RippleinSpace:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(25, 3) >= 3 and 
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

    
	-- Healing Rotation
    local function HealingRotation(unit)
	    -- Variables
        local totalMembers = HealingEngine.GetMembersAll()
		local currentTanks = HealingEngine.GetMembersByMode("TANK")
        local ChiBurstUnits = HealingEngine.GetMinimumUnits(2, 4)
		
		--Save yourself
		if A.DivineShield:IsReady(unit, nil, nil, true) and Unit("player"):HealthPercent() <= 75 and not Unit("player"):HasDeBuffs(A.Forbearance.ID) then
			return A.DivineShield:Show(icon)
		end	

        --Tank Emergency
        if A.LayOnHands:IsReady(unit, nil, nil, true) and Unit(unit):HealthPercent() < 50 and not Unit(unit):HasDeBuffs(A.Forbearance.ID) then
            return A.LayOnHands:Show(icon)
        end
		
		--Custom Beacon - Need to add specific Target in UI
        if A.BeaconofLight:IsReady(unit, nil, nil, true) and not Unit(unit):HasBuffs(A.BeaconofLight.ID, true) and Unit(unit):HealthPercent() < 99 then
            return A.BeaconofLight:Show(icon)
        end
		--Dispell
		--if not Player:CanAttack(Target) and A.Cleanse:IsReady(unit, nil, nil, true) and Target:HasDispelableDebuff("Magic", "Poison", "Disease") then
			--return A.Cleanse:Show(icon)
		--end

    --Manuel Cooldown and NOT Glimmer of Light
	if HR.CDsON() and not Azerite:GetRank(A.GlimmerofLight.ID) > 0 then
		if A.AvengingWrath:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AuraMastery.ID, true) and not Unit("player"):HasBuffs(A.HolyAvenger.ID, true) then
            return A.AvengingWrath:Show(icon)
        end

		if A.AvengingCrusader:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AuraMastery.ID, true) and not Unit("player"):HasBuffs(A.HolyAvenger.ID, true) then
            return A.AvengingCrusader:Show(icon)
        end		
		
		if A.HolyAvenger:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AuraMastery.ID, true) and not Unit("player"):HasBuffs(A.AvengingWrath.ID, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) then
            return A.HolyAvenger:Show(icon)
        end

		if A.AuraMastery:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AvengingWrath.ID, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) and not Unit("player"):HasBuffs(A.HolyAvenger.ID, true) then
			return A.AuraMastery:Show(icon)
		end
		
		if A.LifeBindersInvocation:IsReady(unit, nil, nil, true) and HealingEngine.GetBelowHealthPercentercentUnits(85) >= 5 then
			return A.LifeBindersInvocation:Show(icon)
		end
		
		if A.OverchargeMana:IsReady(unit, nil, nil, true) then
			return A.OverchargeMana:Show(icon)
		end
	end
		
		if A.MemoryOfLucidDreams:IsReady(unit, nil, nil, true) and Player:Mana() < Player:ManaMax() * 0.85 then
			return A.MemoryOfLucidDreams:Show(icon)
		end
		
	--Manuel Cooldown and Glimmer of Light
	if HR.CDsON() and Azerite:GetRank(A.GlimmerofLight.ID) > 0 then
		if A.AvengingWrath:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AuraMastery.ID, true) and not Unit("player"):HasBuffs(A.HolyAvenger.ID, true) then
            return A.AvengingWrath:Show(icon)
        end
		
		if A.HolyAvenger:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AuraMastery.ID, true) then
            return A.HolyAvenger:Show(icon)
        end

		if A.AuraMastery:IsReady(unit, nil, nil, true) and not Unit("player"):HasBuffs(A.AvengingWrath.ID, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) and not Unit("player"):HasBuffs(A.HolyAvenger.ID, true) then
			return A.AuraMastery:Show(icon)
		end
		
		if A.LifeBindersInvocation:IsReady(unit, nil, nil, true) and HealingEngine.GetBelowHealthPercentercentUnits(85) >= 5 then
			return A.LifeBindersInvocation:Show(icon)
		end
		
		if A.OverchargeMana:IsReady(unit, nil, nil, true) then
			return A.OverchargeMana:Show(icon)
		end
	end
		-- Memory of Lucid Dreams if current mana <= 85% maximum mana
		if A.MemoryOfLucidDreams:IsReady(unit, nil, nil, true) and Unit("player"):Mana() < Unit("player"):ManaMax() * 0.85 then
			return A.UnleashHeartofAzeroth:Show(icon)
		end
		
		--AuraMastery settings
        if A.AuraMastery:IsReady(unit, nil, nil, true) and HR.CDsON() and not Unit("player"):HasBuffs(A.AvengingWrath.ID, true) and not Unit("player"):HasBuffs(A.AvengingCrusader.ID, true) and not Unit("player"):HasBuffs(A.HolyAvenger.ID, true) then
            return A.AuraMastery:Show(icon)
        end		

        --Beacon of Virtue
        if A.BeaconofVirtue:IsReady(unit, nil, nil, true) and HealingEngine.GetBelowHealthPercentercentUnits(85) >= 3 then
			return A.BeaconofVirtue:Show(icon)
		end

        --Light of Dawn
        if A.LightofDawn:IsReady(unit, nil, nil, true) and HealingEngine.GetBelowHealthPercentercentUnits(85) >= 3 then
			return A.LightofDawn:Show(icon)
        end

		--Holy Shock
        if A.HolyShock:IsReady(unit, nil, nil, true) then
            if LowestAlly("ALL", "HP") <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_holyshock"]["value"] then
                ForceHealingTarget("ALL")
            end

            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_holyshock"]["value"] then
                return A.HolyShock:Show(icon)
            end

        end

        --Judgment Of Light
        if RubimRH.AoEON() and A.Judgement:IsReady(unit, nil, nil, true) and A.JudgementofLight:IsAvailable() and Player:AffectingCombat() then
            return A.Judgement:Show(icon)
        end
		
		if RubimRH.AoEON() and A.LightsHammer:IsReady(unit, nil, nil, true) and HealingEngine.GetBelowHealthPercentercentUnits(75) >= 5 then
			return A.LightsHammer:Show(icon)
		end
		
		--Holy Prism
		if RubimRH.AoEON() and A.HolyPrism:IsReady(unit, nil, nil, true) and HealingEngine.GetBelowHealthPercentercentUnits(75) >= 3 then
			return A.HolyPrism:Show(icon)
		end
		
        --Bestow Faith
        if A.BestowFaith:IsAvailable() and A.BestowFaith:IsReady(unit, nil, nil, true) then
            if LowestAlly("TANK", "HP") <= 95 then
                ForceHealingTarget("TANK")
            end
            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() <= 95 then
                return A.BestowFaith:Show(icon)
            end
        end
		
		--Concentrated Flame Heal
        if A.ConcentratedFlameHeal:IsReady(unit, nil, nil, true) then
            if LowestAlly("ALL", "HP") <= 75 then
                ForceHealingTarget("ALL")
            end

            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() <= 75 then
                return A.UnleashHeartofAzeroth:Show(icon)
            end
        end
		
		--Vitality Conduit
        if A.VitalityConduit:IsReady(unit, nil, nil, true) then
            if LowestAlly("TANK", "HP") <= 75 then
                ForceHealingTarget("TANK")
            end

            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() <= 75 then
                return A.UnleashHeartofAzeroth:Show(icon)
            end
        end
		
        --Flash of Light
        if A.FlashofLight:IsReady(unit, nil, nil, true) and not Player:IsMoving() then
            if LowestAlly("ALL", "HP") <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_flashlight"]["value"] then
                ForceHealingTarget("ALL")
            end

            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_flashlight"]["value"] then
                return A.FlashofLight:Show(icon)
            end
        end

        --Crusader Strike
        if RubimRH.AoEON() and A.CrusaderStrike:IsReady(unit, nil, nil, true) and A.CrusadersMight:IsAvailable() and not A.HolyShock:IsReady(unit, nil, nil, true) and Player:AffectingCombat() then
            return A.CrusaderStrike:Show(icon)
        end

        --Holy Light
        if A.HolyLight:IsReady(unit, nil, nil, true) and not Player:IsMoving() then
            if LowestAlly("ALL", "HP") <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_holylight"]["value"] then
                ForceHealingTarget("ALL")
            end

            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_holylight"]["value"] then
                return A.HolyLight:Show(icon)
            end
        end
		
        --Light of the Martyr
        if A.LightoftheMartyr:IsReady(unit, nil, nil, true) and Player:IsMoving() and Unit(unit):HealthPercent() > 75 then
            if LowestAlly("ALL", "HP") <= RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_martyr"]["value"] then
                ForceHealingTarget("ALL")
            end

            if not BadDebuffOnTarget() and Target:GUID() == LowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() < RubimRH.db.profile.mainOption.classprofiles[65][RubimRH.db.profile.mainOption.selectedProfile]["raid_martyr"]["value"] then
                return A.LightoftheMartyr:Show(icon)
            end
        end

    end   

	
	local function HealingRotation(unit)
        -- local
		local ActivesRejuvenations = HealingEngine.GetBuffsCount(A.Rejuvenation.ID, 1)
        local MaintainRejuvenation = MaintainRejuvenation(unit)
		-- Stopcasting 
        --if A.GetToggle(1, "StopCast") and true and ((A.GetToggle(2, "SoothingMistStopCast")[1] and not isAffectedBySoothingMist) or (A.GetToggle(2, "SoothingMistStopCast")[2] and isAffectedBySoothingMist and Unit(unit):HealthPercent() >= 100 and IsEnoughHPS(unit))) then 
        --    StopCast = true -- passing to A[6]
        --    return             
        --end            		
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit, nil, nil, true) then 
            return A.ArcaneTorrent:Show(icon)
        end     
        
        -- Out of combat / Precombat
        if Unit("player"):CombatTime() == 0 then
            -- Notification					
           -- Action.SendNotification("Pre Rejuvenations before fight " .. RejuvenationCount "/" .. (currentMembers / 3), A.Rejuvenation.ID) 		
			-- Prowl
			--if A.Prowl:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.Prowl.ID, true) == 0 then
			--    return A.Prowl:Show(icon)
			--end	
            -- Mass Rez
			if A.Revitalize:IsReady(unit, true, nil, true) and Unit(unit):InGroup() and Unit(unit):IsDead() and Unit(unit):IsPlayer() and Unit(unit):GetRange() <= 100 and not isMoving and IsSchoolFree() then 
                return A.Revitalize:Show(icon)
            end 
            -- Rez
            if A.Revive:IsReady(unit, nil, nil, true) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolFree() then 
                return A.Revive:Show(icon)
            end 
            -- Efflorescence out of combat
            if not A.IsInPvP and A.Efflorescence:IsReady(unit) and A.GetToggle(2,"AoE") and Efflorescence() <= 2 then 
                -- Notification					
                Action.SendNotification("Pre casting Efflorescence", A.Efflorescence.ID)
				return A.Efflorescence:Show(icon)
            end 
            -- Pre Rejuvenation on 1/3 of our party / raid
            if (Unit(unit):HasBuffs(A.Rejuvenation.ID, true) <= 4 or Unit(unit):HasBuffs(A.Rejuvenation.ID, true) == 0) and Unit(unit):GetRange() <= 40 then 
                -- Notification					
                Action.SendNotification("Pre casting Rejuvenation", A.Rejuvenation.ID) 
				return A.Rejuvenation:Show(icon)				
            end 
			
			-- BossMods
            local Pull = A.BossMods_Pulling()  
            if Pull > 0 then 
                -- Timing
                local extra_time = A.GetCurrentGCD() + 0.1
                local Lifebloom, Rejuvenation, WildGrowth
                if A.Lifebloom:IsReady(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.Lifebloom.ID, true) == 0 then 
                    Lifebloom = true 
                    extra_time = extra_time + A.GetGCD()
                end 
                -- Pull Rotation
                if Lifebloom and not A.Photosynthesis:IsSpellLearned() and Pull <= extra_time then 
				    -- Notification					
                    Action.SendNotification("Pre casting Lifebloom on : " .. UnitName(unit), A.Lifebloom.ID)
                    return A.Lifebloom:Show(icon) 
                end 
                -- Pull Rotation
                if Rejuvenation and Pull <= extra_time and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) == 0 then 
				    -- Notification					
                    Action.SendNotification("Pre casting Rejuvenation on : " .. UnitName(unit), A.Rejuvenation.ID)
                    return A.Rejuvenation:Show(icon) 
                end 				
                
                return 
            end 
        end 
        
        -- Interrupts (@targettarget)
        if unit == "target" and A.IsUnitEnemy("target") then 
            local Interrupt = Interrupts("target", true)
            if Interrupt then
                -- Notification					
                Action.SendNotification("Detected potential interrupt on :" .. UnitName(unit), A.MightyBash.ID)			
                return Interrupt:Show(icon)
            end 
        end 

        
		-- Low Emergency targeting
		--if Unit(unit):TimeToDieX(50) < 10 and Unit(unit):HealthPercent() <= 80 then
			-- Notification					
        --    Action.SendNotification("Prevent damage on : " .. UnitName(unit), A.Rejuvenation.ID)		
		--    HealingEngine.SetTargetMostlyIncDMG()
		--end
		
        -- Bursting 
        if A.BurstIsON(unit) then 
		    
			local Emergency = Unit(unit):TimeToDieX(25) < 4 and Unit(unit):HealthPercent() <= 60 and A.IsUnitFriendly(unit)
		    local SuperEmergency = (Unit(unit):TimeToDieX(25) < 3 or Unit(unit):HealthPercent() <= 50) and A.IsUnitFriendly(unit)
            
			-- Multi (for [4])
            if isMulti then 
                if CanTranquility() and Emergency then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Tranquility:Show(icon)
                end 
                -- Flourish burst
                if CanFlourish() and Emergency then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    -- Notification					
                    Action.SendNotification("Activated Flourish burst", A.Flourish.ID)                    
                    return A.Flourish:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) and Emergency then 
                    return A.LifeBindersInvocation:Show(icon)
                end             
            end
			
        
            -- Rotation      
		    -- Purge
		    -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
            -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")		
            if A.NaturesCure:IsReady(unit) and A.AuraIsValid(unit, "UseDispel", "Dispel") then
                -- Notification					
                Action.SendNotification("Detected dispell on :" .. UnitName(unit), A.NaturesCure.ID)
                return A.NaturesCure:Show(icon)
            end 
            
            -- Single 
            if SuperEmergency and A.IncarnationTreeofLife:IsReady("player") and IsSchoolFree() and Unit("player"):HasBuffs(A.IncarnationTreeofLifeBuff.ID, true) == 0  then 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                    return A.OverchargeMana:Show(icon)
                end 
                -- Notification					
                Action.SendNotification("Activated Tree of Life burst", A.IncarnationTreeofLife.ID)                   
                return A.IncarnationTreeofLife:Show(icon)
            end
			
			-- Tranquility
            if CanTranquility() and Emergency then 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                    return A.OverchargeMana:Show(icon)
                end 
                    
                return A.Tranquility:Show(icon)
            end 
			
            -- Flourish burst
            if CanFlourish() and Emergency then 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                    return A.OverchargeMana:Show(icon)
                end 
                -- Notification					
                Action.SendNotification("Activated Flourish burst", A.Flourish.ID)                    
                return A.Flourish:Show(icon)
            end
			
            -- Iron Bark			
            if A.Ironbark:IsReady(unit) and A.Ironbark:AbsentImun(unit) and IsSchoolFree() then 
                local Ironbark = A.GetToggle(2, "Ironbark")
                
                -- Auto 
                if     Ironbark >= 100 and A.IsUnitFriendly(unit) and Emergency and Unit(unit):HasBuffs("DeffBuffs") == 0 and (
                    (Unit(unit):TimeToDieX(25) < 3 and Unit(unit):HealthPercent() < 60) or 
                    (A.IsInPvP and Unit(unit):HealthPercent() < 80 and (Unit(unit):HasDeBuffs("DamageDeBuffs") > 5 or Unit(unit):IsExecuted()))
                ) 
                then 
                    return A.Ironbark:Show(icon)
                end 
                
                -- Custom 
                if Ironbark < 100 and A.IsUnitFriendly(unit) and Unit(unit):HealthPercent() <= Ironbark then 
                    return A.Ironbark:Show(icon)
                end 
            end   
			
             -- TreeOfLife rotation
            if Unit("player"):HasBuffs(A.IncarnationTreeofLifeBuff.ID, true) > 0 then 
			    
				if A.Regrowth:IsReady(unit) and (Unit(unit):HealthPercent() <= 60 or Unit("player"):HasBuffs(A.ClearCasting.ID, true) > 0 or Unit(unit):TimeToDieX(30) < 4) and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 3 and (Unit(unit):HasBuffs(A.RejuvenationGermimation.ID, true) > 3 or not A.Germination:IsSpellLearned())  then 
                    return A.Regrowth:Show(icon) 
			    end 
				
 			    if CanWildGrowth(unit) and (isMulti or A.GetToggle(2,"AoE")) then         
                    return A.WildGrowth:Show(icon)
                end
				
				if A.Rejuvenation:IsReady(unit) and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) == 0 or Unit(unit):HasBuffs(A.Rejuvenation.ID, true) <= 3 then 
                    return A.Rejuvenation:Show(icon) 
			    end                
                -- Rejuvenation with Germination
                if A.Rejuvenation:IsReady(unit) and A.Germination:IsSpellLearned() and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 3 and (Unit(unit):HasBuffs(A.RejuvenationGermimation.ID, true) <= 3 or Unit(unit):HasBuffs(A.RejuvenationGermimation.ID, true) == 0)  then             
                    return A.Rejuvenation:Show(icon)
                end	
            end    
			
            -- Azerite Essence
            if A.Standstill:AutoHeartOfAzeroth(unit, true) then 
                return A.Standstill:Show(icon)
            end 
            
            -- Racial 
            local RacialBurstHealing = A.GetToggle(2, "RacialBurstHealing")            
            if  Unit(unit):InRange() and A.AbsentImun(nil, unit) and 
            (
                -- Auto
                (RacialBurstHealing >= 100 and not IsEnoughHPS(unit) and (Unit(unit):TimeToDieX(45) < 5 or (A.IsInPvP and Unit(unit):UseBurst()))) or 
                -- Custom            
                (RacialBurstHealing < 100 and Unit(unit):HealthPercent() <= RacialBurstHealing)
            )
            then 
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
            
            -- AoE
			local Emergency = Unit(unit):TimeToDieX(25) < 4 and Unit(unit):HealthPercent() <= 60
		    local SuperEmergency = Unit(unit):TimeToDieX(20) < 2 and Unit(unit):HealthPercent() <= 50
			
            if not isMulti and A.GetToggle(2, "AoE") then 
                if CanTranquility() and Emergency then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    -- Notification					
                    Action.SendNotification("Activated Tranquility burst", A.Tranquility.ID)                                      
                    return A.Tranquility:Show(icon)
                end 
                
                if CanFlourish() and Emergency  then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    -- Notification					
                    Action.SendNotification("Activated Flourish burst", A.Flourish.ID)                    
                    return A.Flourish:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) then 
                    return A.LifeBindersInvocation:Show(icon)
                end                                 
            end 
        end 
        
        -- PvP MightyBash (@targettarget)
        if unit == "target" and A.IsUnitEnemy("target") and A.MightyBashIsReady("target", false, true) then 
            return A.MightyBash:Show(icon)
        end    
		
        -- Racial 
        if A.GiftofNaaru:AutoRacial(unit, nil, nil, true) and Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstHealing") then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        -- Trinkets         
        if A.AbsentImun(nil, unit) and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstHealing") and Unit(unit):InRange() then 
            if A.Trinket1:IsReady(unit, nil, nil, true) and A.Trinket1:GetItemCategory() ~= "DPS" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit, nil, nil, true) and A.Trinket2:GetItemCategory() ~= "DPS" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
		-- Dash
        if A.Dash:IsReady("player") and Unit("player"):TimeToDie() > 6 then 
            if (Unit("player"):HasDeBuffs("Rooted") > 0 or Unit(unit):GetRange() > 40 or Unit(unit):InLOS()) then 
                -- Notification					
                Action.SendNotification("Emergency Dash", A.Dash.ID)			
                return A.Dash:Show(icon)
            end 
            
            local cUnitSpeed = Unit(unit):GetCurrentSpeed()
            if cUnitSpeed > 0 and cUnitSpeed < 64 and (UnitIsUnit(unit, "player") or Unit(unit):IsMelee()) then 
                return A.Dash:Show(icon)
            end 
        end          
        
		-- Wild Growth
        if (not isMulti or A.GetToggle(2, "AoE")) and A.WildGrowth:PredictHeal("Wild Growth", unit) then 
            if A.VitalityConduit:AutoHeartOfAzeroth(unit, true) then 
                return A.VitalityConduit:Show(icon)
            end
            if CanWildGrowth(unit) and not IsSaveManaPhase() and A.WildGrowth:PredictHeal("Wild Growth", unit) then                 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and (not IsEnoughHPS(unit) or HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10) then 
                    return A.OverchargeMana:Show(icon)
                end 
                
                return A.WildGrowth:Show(icon)
            end           
            if Efflorescence() <= 2 and Player:IsStayingTime() > 2 and not IsSaveManaPhase() and A.Efflorescence:PredictHeal("Efflorescence", unit) then 
                return A.Efflorescence:Show(icon)
            end
        end 
        
        -- Multi (for [4])
        if isMulti then 
            if A.VitalityConduit:AutoHeartOfAzeroth(unit, true) then 
                return A.VitalityConduit:Show(icon)
            end
            if CanWildGrowth(unit) and not IsSaveManaPhase() and A.WildGrowth:PredictHeal("Wild Growth", unit) then                 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and (not IsEnoughHPS(unit) or HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10) then 
                    return A.OverchargeMana:Show(icon)
                end 
                
                return A.WildGrowth:Show(icon)
            end           
            if Efflorescence() <= 2 and Player:IsStayingTime() > 2 and not IsSaveManaPhase() and A.Efflorescence:PredictHeal("Efflorescence", unit) then 
                return A.Efflorescence:Show(icon)
            end 
        end
        
        -- Super Emergency 
        local Emergency = Unit(unit):TimeToDieX(25) < 4 and Unit(unit):HealthPercent() <= 60
		local MediumEmergency = Unit(unit):HealthPercent() <= 70 and A.IsUnitFriendly(unit)
		local SuperEmergency = Unit(unit):TimeToDieX(25) < 3 and Unit(unit):HealthPercent() <= 50 
		local Swiftmend = A.GetToggle(2, "SwiftmendHP")
		
        if MediumEmergency and A.Swiftmend:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and ((Swiftmend >= 100 and Unit(unit):HealthPercent() <= 50 ) or (Swiftmend < 100 and Unit(unit):HealthPercent() <= Swiftmend)) then 
            if Emergency and A.IsUnitFriendly(unit) and A.Ironbark:IsReady(unit) and Unit(unit):TimeToDie() > 3 then 
			    -- Notification
			    Action.SendNotification("Emergency Iron Bark on : " .. UnitName(unit), A.Ironbark.ID, 2)
                return A.Ironbark:Show(icon)
            end     
            if not isMoving and not IsSaveManaPhase() then
                if A.Regrowth:IsReady(unit) then 
                    return A.Regrowth:Show(icon)
                end                
            end
			-- Notification
			Action.SendNotification("Emergency Swiftmend on : " .. UnitName(unit), A.Swiftmend.ID, 2)
			return A.Swiftmend:Show(icon)

        end 		
		
        -- Innervate Bomb combo
        if true and Emergency and A.Innervate:IsReady("player") and IsSchoolFree() then 
            -- Innervate
			if Unit("player"):HasBuffs(A.Innervate.ID, true) == 0 then
			    -- Notification
			    Action.SendNotification("Using Innervate Bomb Combo burst", A.Innervate.ID, 2)
                return A.Innervate:Show(icon)
            end	
            -- Refresh Efflorescence
			if Unit("player"):HasBuffs(A.Innervate.ID, true) > 0 and Efflorescence() <= 2 then
                return A.Efflorescence:Show(icon)
            end			
			-- Maximize Rejuvenation on group
			if (Unit(unit):HasBuffs(A.Rejuvenation.ID, true) <= 4 or Unit(unit):HasBuffs(A.Rejuvenation.ID, true) == 0) and Unit(unit):GetRange() <= 40 and Unit("player"):HasBuffs(A.Innervate.ID, true) > 0 then 
                return A.Rejuvenation:Show(icon)
            end 
            -- Then Apply Wild Growth            
            if CanWildGrowth(unit) and HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10 and Unit("player"):HasBuffs(A.Innervate.ID, true) > 0 then
                return A.WildGrowth:Show(icon)
            end
            -- and use Flourish for burst			
            if Unit("player"):GetSpellLastCast(A.WildGrowth.ID, true) <= 5 and Unit("player"):HasBuffs(A.Innervate.ID, true) > 0 then
                return A.Flourish:Show(icon)
            end	
        end 
            
        -- Normal Rotation 
        local LifebloomHP = A.GetToggle(2, "LifebloomHP")
        if     true and not A.Photosynthesis:IsSpellLearned() and A.Lifebloom:IsReady(unit) and Unit(unit):GetRange() <= 40 and (Unit(unit):HasBuffs(A.Lifebloom.ID, true) <= 2 or Unit(unit):HasBuffs(A.Lifebloom.ID, true) == 0) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and 
        ( 
            (
                LifebloomHP < 100 and 
                Unit(unit):HealthPercent() <= LifebloomHP  
            ) or 
            (
                LifebloomHP >= 100 and 
                A.Lifebloom:PredictHeal("Lifebloom", unit)
            )
        )
        then
            local LifebloomWorkMode = A.GetToggle(2, "LifebloomWorkMode")
            if     LifebloomWorkMode == "Always" or 
            (
                (LifebloomWorkMode == "Auto" or LifebloomWorkMode == "Tanking Units")
            ) or 
            (
                (LifebloomWorkMode == "Auto" or LifebloomWorkMode == "Mostly Inc. Damage") and 
                HealingEngine.IsMostlyIncDMG(unit)
            ) or 
            (
                (LifebloomWorkMode == "Auto" or LifebloomWorkMode == "HPS < Inc. Damage") and 
                not IsEnoughHPS(unit)
            )
            then 
                -- Notification
			    Action.SendNotification("Refreshing Lifebloom on : " .. UnitName(unit), A.Lifebloom.ID)			
				return A.Lifebloom:Show(icon)
            end
        end
		
		-- Innervate
		if A.Innervate:IsReady("player") and Unit("player"):HasBuffs(A.Innervate.ID, true) == 0 and IsSaveManaPhase() then
		    -- Notification
		    Action.SendNotification("Low mana : Using Innervate", A.Innervate.ID, 2)
            return A.Innervate:Show(icon)
        end	
		
		-- Rejuvenation
        if A.Rejuvenation:IsReady(unit) and (not IsSaveManaPhase() or A.IsInPvP) and Unit(unit):GetRange() <= 40 and (Unit(unit):HasBuffs(A.Rejuvenation.ID, true) <= 3 or Unit(unit):HasBuffs(A.Rejuvenation.ID, true) == 0) then             
            return A.Rejuvenation:Show(icon)
        end	

        -- Rejuvenation with Germination
        if A.Rejuvenation:IsReady(unit) and (not IsSaveManaPhase() or A.IsInPvP) and A.Germination:IsSpellLearned() and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 3 and (Unit(unit):HasBuffs(A.RejuvenationGermimation.ID, true) <= 3 or Unit(unit):HasBuffs(A.RejuvenationGermimation.ID, true) == 0)  then             
            return A.Rejuvenation:Show(icon)
        end	
		
		-- Swiftmend for low moderate damage
		if A.Swiftmend:IsReady(unit) and Unit(unit):GetRange() <= 40 and (Unit(unit):TimeToDieX(50) < 4 or A.Swiftmend:PredictHeal("Swiftmend", unit)) and Unit(unit):HealthPercent() <= 75 and Unit(unit):HasBuffs(A.Rejuvenation.ID) > 2 then		
		    -- Notification
			Action.SendNotification("Emergency Swiftmend on : " .. UnitName(unit), A.Swiftmend.ID, 2)
			return A.Swiftmend:Show(icon)
        end 		

		-- PvP Overgrowth (Enemy Healer)
		local Emergency = (Unit(unit):TimeToDieX(20) < 5 and Unit(unit):HealthPercent() <= 35)
        if A.IsInPvP and Unit(unit):GetRange() <= 40 and A.Overgrowth:IsReady(unit) and A.Overgrowth:PredictHeal("Overgrowth", unit) then		    
			if Emergency and A.Ironbark:IsReady(unit) and A.IsUnitFriendly(unit) then 
                return A.Ironbark:Show(icon) 
			end
		    -- Notification
			Action.SendNotification("Emergency Overgrowth on : " .. UnitName(unit), A.Overgrowth.ID, 2)
			return A.Overgrowth:Show(icon)
		end	
				
		-- Regrowth with ClearCasting buff
		if not isMoving and A.Regrowth:IsReady(unit) and Unit("player"):HasBuffs(A.ClearCasting.ID, true) > 1 and (Unit(unit):HealthPercent() <= 90 or Unit(unit):TimeToDieX(60) < 4) and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 5 then
       		-- Notification
			Action.SendNotification("Clear Casting buff up, regrowth on : " .. UnitName(unit), A.ClearCasting.ID)		
            return A.Regrowth:Show(icon)
        end
		
		-- Wild Growth
        if not isMulti and not isMoving and A.GetToggle(2, "AoE") then 
            if CanWildGrowth(unit) and not IsSaveManaPhase() then
                return A.WildGrowth:Show(icon)
            end  
        end
		
		-- Cenarion Ward
        if A.CenarionWard:IsReady() and Unit(unit):GetRange() <= 40 and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 3 and A.CenarionWard:IsSpellLearned() and A.CenarionWard:PredictHeal("Cenarion Ward", unit) then 
		    -- Notification
			Action.SendNotification("Cenarion Ward on : " .. UnitName(unit), A.CenarionWard.ID, 2)
            return A.CenarionWard:Show(icon)
        end 
		
		-- Regrowth without ClearCasting buff
		if not isMoving and A.Regrowth:IsReady(unit) and not IsSaveManaPhase() and Unit(unit):GetRange() <= 40 and not isMoving and (A.Regrowth:PredictHeal("Regrowth", unit, 5) or Unit(unit):TimeToDieX(25) < 4) and Unit("player"):HasBuffs(A.ClearCasting.ID) == 0 and Unit(unit):HasBuffs(A.Rejuvenation.ID) > 5 then
       		-- Notification
			--Action.SendNotification("Clear Casting buff up, regrowth on : " .. UnitName(unit), A.ClearCasting.ID)		
            return A.Regrowth:Show(icon)
        end  	
		
		-- Photosynthesis Lifebloom on player to increase healing by 20%
        if A.Lifebloom:IsReady("player") and Unit("player"):HasBuffs(A.Lifebloom.ID, true) < 3 and A.Photosynthesis:IsSpellLearned() then		    
		    -- Notification
			HealingEngine.SetTarget("player")
			Action.SendNotification("Maintaining Lifebloom on you for 20% healing increase", A.Photosynthesis.ID, 2)
			return A.Lifebloom:Show(icon)
		end		
        
        -- Azerite Essences 
        if Unit("player"):CombatTime() > 0 and A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Unit("player"):PowerPercent() < 85 then 
            return A.MemoryofLucidDreams:Show(icon)
        end         
        
        if Unit("player"):CombatTime() > 0 and A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Player:IsStayingTime() > 2 then 
            return A.WorldveinResonance:Show(icon)
        end  		
        
        -- Misc 
        local Mana = A.GetToggle(2, "ManaPotion") 
        if Unit("player"):CombatTime() > 0 and Mana > 0 and Unit("player"):PowerPercent() <= Mana then 
            if A.PotionofReconstitution:IsReady("player", true, nil, true) and not isMoving and Player:IsStayingTime() > 1.5 then 
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP("player", true) then 
                    return A.MemoryofLucidDreams:Show(icon)
                end 
                
                return A.PotionofReconstitution:Show(icon)                
            end 
            
            if A.CoastalManaPotion:IsReady("player", true, nil, true) then 
                return A.CoastalManaPotion:Show(icon)
            end 
        end 
        
        -- Azerite Essences 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.Refreshment:AutoHeartOfAzeroth(unit, true) then 
            return A.Refreshment:Show(icon)
        end        		                 
        
        -- Target Damage Rotation 
        if unit == "target" and A.IsUnitEnemy("target") then 
            local CanMakeDamage = DamageRotation("target")
            if CanMakeDamage then 
                return true 
            end 
        end 
        
        -- Totally nothing to do 
        if not isMulti and A.SolarWrath:IsReady(unit) and A.IsUnitEnemy(unit) and IsSaveManaPhase() and IsSchoolFree() then 
            if Unit("player"):CombatTime() > 0 and HealingEngine.GetIncomingDMGAVG() <= 3 then
                return A.SolarWrath:Show(icon)
            end            
        end		
    end 
    
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
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) > UnitCooldown:GetMaxDuration("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) - 2 and 
    UnitCooldown:IsSpellInFly("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) and 
    Unit("player"):GetDR("incapacitate") > 0 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", ACTION_CONST_SPELLID_FREEZING_TRAP)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 

local function ArenaRotation(unit)
    if A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() then             
        --local remainCast = Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0
        
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("playrr"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then                 
            -- PvP Cyclone
            if A.Cyclone:IsReady(unit, nil, nil, true) and not Unit(unit):InLOS() and Unit(unit):GetDR("disorient") > 25 then
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
    --local castRemain = Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0
    -- NaturesCure   -- and not Unit(unit):InLOS()
    if A.NaturesCure:IsReady(unit, nil, nil, true) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel")  then                         
        return A.NaturesCure
    end 
    -- Dash
    if A.Dash:IsReady("player", nil, nil, true) and not Unit("player", 5):HasFlags() and (Unit(unit):IsMelee() or Unit("player"):IsFocused(nil, true) or Unit(unit):HasBuffs("DamageBuffs") > 0) and not Unit(unit):InLOS() then 
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
    --if StopCast and Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0 then 
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