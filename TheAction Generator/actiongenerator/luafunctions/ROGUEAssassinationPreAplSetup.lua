------------------------------------------
------ ASSASSINATION PRE APL SETUP -------
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

local function InRange(unit)
	-- @return boolean 
	return A.Mutilate:IsInRange(unit)
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

---------------------------------------------------
-------------- ASSASSINATION PREAPL ---------------
---------------------------------------------------
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Player:SpellHaste(), 1 / Player:SpellHaste();
local Stealth;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

---------------------------------------------------
---------- ASSASSINATION SPECIFICS ----------------
---------------------------------------------------

-- Rupture TickTime 
-- [1943] = {2000, false}
local function RuptureTickTime()
    return 2
end

-- Garrote TickTime 
-- [703] = {2000, false}
local function GarroteTickTime()
    local BaseTickTime = 2
    local Hasted = false
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
    end
    return BaseTickTime
end

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = 256735, 3;
local function MasterAssassinRemains()
    if Unit("player"):HasBuffs(MasterAssassinBuff, true) < 0 then
        return A.GetCurrentGCD() + NominalDuration;
    else
        return Unit("player"):HasBuffs(MasterAssassinBuff, true);
    end
end

-- Poisoned
function Poisoned (unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) or Unit(unit):HasDeBuffs(A.WoundPoisonDebuff.ID, true)) and true or false;
end

-- Bleeds
function Bleeds (unit)
    return (Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0 and 1 or 0) + (Unit(unit):HasDeBuffs(A.Rupture.ID, true) > 0 and 1 or 0)
    + (Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) > 0 and 1 or 0) + (Unit(unit):HasDeBuffs(A.InternalBleeding.ID, true) > 0 and 1 or 0);
end

-- Poisoned + Bleeds  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Garrote.ID) -- Garrote count
    local AppliedInternalBleeding = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.InternalBleeding.ID) -- InternalBleeding count
    local AppliedRupture = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Rupture.ID) -- Rupture count
    
    PoisonedBleedsCount = AppliedGarrote + AppliedInternalBleeding + AppliedRupture
    
    if Unit("target"):IsDummy() then
        PoisonedBleedsCount = 1 * MultiUnits:GetByRange(10)
    end
    
    return PoisonedBleedsCount;
end

---------------------------------------------------
------- SIMC CUSTOM FUNCTION / EXPRESSION ---------
---------------------------------------------------

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Player:ComboPoints(), CPMaxSpend());
end

local function NighstalkerMultiplier ()
    return A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return A.Subterfuge:IsSpellLearned() and Player:IsStealthed() and 2 or 1;
end

A.RegisterPMultiplier( -- Garrote dot and action
    A.Garrote.ID,    -- Garrote action
    A.GarroteDebuff.ID,  -- GarroteDebuff dot
    {function ()
            return (A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5) or (A.Subterfuge:IsSpellLearned() and Player:IsStealthed() and 2) or 1
    end}
)

A.RegisterPMultiplier( -- Rupture dot and action
    A.Rupture.ID,    -- Rupture action
    A.RuptureDebuff.ID,  -- RuptureDebuff dot
    {function ()
            return A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5 or 1
    end}
    
)


--[[
-- Spells Damage
A.Envenom:RegisterDamage(
-- Envenom DMG Formula:
--    AP * CP * Env_APCoef * Aura_M * ToxicB_M * DS_M * Mastery_M * Versa_M
function ()
    return
        -- Attack Power
        Player:AttackPower() *
        -- Combo Points
        CPSpend() *
        -- Envenom AP Coef
        0.16 *
        -- Aura Multiplier (SpellID: 137037)
        1.27 *
        -- Toxic Blade Multiplier
        (A.ToxicBlade:IsSpellLearned() and 1.3 or 1) *
        -- Deeper Stratagem Multiplier
        (A.DeeperStratagem:IsSpellLearned() and 1.05 or 1) *
        -- Mastery Finisher Multiplier
        (1 + Player:MasteryPct()/100) *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct()/100);
    end
);
A.Mutilate:RegisterDamage(
    function ()
        return
            -- Attack Power (MH Factor + OH Factor)
            Player:AttackPower() *
            -- Mutilate Coefficient
            0.35 *
            -- Aura Multiplier (SpellID: 137037)
            1.27 *
            -- Versatility Damage Multiplier
            (1 + Player:VersatilityDmgPct()/100);
    end
);
]]--
-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsReady("player") and not Player:IsStealthed() then
        return Stealth:Show(icon)
    end
    return false;
end

---------------------------------------------------
------------------- DEFENSIVES --------------------
---------------------------------------------------

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if A.CrimsonVial:IsReady(unit) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "CrimsonVialHP") then
        return A.CrimsonVial:Show(icon)
    end
    return false;
end

-- Feint
function Feint(Feint)
    if A.Feint:IsReady(unit) and not Unit("player"):HasBuffs(A.Feint.ID, true) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "FeintHP") then
        return A.Feint:Show(icon)
    end
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
    
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    -- Emergency Evade
    local Evade = Action.GetToggle(2, "EvadeHP")
    if     Evade >= 0 and A.Evade:IsReady("player") and 
    (
        (   -- Auto 
            Evade >= 100 and 
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
            Evade < 100 and 
            Unit("player"):HealthPercent() <= Evade
        )
    ) 
    then 
        return A.Evade
    end  
    
    -- Emergency Feint
    local Feint = Action.GetToggle(2, "FeintHP")
    if     Feint >= 0 and A.Feint:IsReady("player") and 
    (
        (   -- Auto 
            Feint >= 100 and 
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
            Feint < 100 and 
            Unit("player"):HealthPercent() <= Feint
        )
    ) 
    then 
        return A.Feint
    end          
    
    -- Emergency CrimsonVial
    local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
    if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
    (
        (   -- Auto 
            CrimsonVial >= 100 and 
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
            CrimsonVial < 100 and 
            Unit("player"):HealthPercent() <= CrimsonVial
        )
    ) 
    then 
        return A.CrimsonVial
    end          
    
    -- Emergency Cloak of Shadow
    local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
    if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
    (
        (   -- Auto 
            CloakofShadow >= 100 and 
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
            CloakofShadow < 100 and 
            Unit("player"):HealthPercent() <= CloakofShadow
        )
    ) 
    then 
        return A.CloakofShadow
    end 
    
    -- Emergency Vanish
    local Vanish = Action.GetToggle(2, "VanishDefensive")
    if     Vanish >= 0 and A.Vanish:IsReady("player") and 
    (
        (   -- Auto 
            Vanish >= 100 and 
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
            Vanish < 100 and 
            Unit("player"):HealthPercent() <= Vanish
        )
    ) 
    then 
        return A.Vanish
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

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
    -- Crippling Poison
    if A.CripplingPoison:IsReady("player") and (Unit("player"):HasBuffs(A.CripplingPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.CripplingPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.CripplingPoison:Info() and not Unit("player"):IsCasting() then
        return A.CripplingPoison
    end    
    -- Wound Poison
    if choice == "Wound Poison" then 
        if A.WoundPoison:IsReady("player") and (Unit("player"):HasBuffs(A.WoundPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.WoundPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.WoundPoison:Info() and not Unit("player"):IsCasting() then 
            return A.WoundPoison
        end
        -- Deadly Poison
    elseif choice == "Deadly Poison" then
        if A.DeadlyPoison:IsReady("player") and (Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.DeadlyPoison:Info() and not Unit("player"):IsCasting() then 
            return A.DeadlyPoison
        end
    elseif choice == "Auto" then
        -- Auto
        if Action.IsInPvP and A.WoundPoison:IsReady("player") and (Unit("player"):HasBuffs(A.WoundPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.WoundPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.WoundPoison:Info() and not Unit("player"):IsCasting() then         
            return A.WoundPoison
        else
            if A.DeadlyPoison:IsReady("player") and (Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) == 0) and not Action.IsInPvP and A.LastPlayerCastName ~= A.DeadlyPoison:Info() and not Unit("player"):IsCasting() then
                return A.DeadlyPoison
            end
        end
    else
        return
    end    
end
RefreshPoisons = A.MakeFunctionCachedDynamic(RefreshPoisons)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Kick:IsReadyByPassCastGCD(unit) or not A.Kick:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            -- Notification                    
            Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
            return A.Kick
        end 
    
        if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
            return A.Gouge              
        end          
    
        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
            return A.CheapShot              
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
    
    if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        -- Notification                    
        Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
        return A.Kick
    end 
    
    if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification                    
        Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
        return A.Gouge              
    end          
    
    if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification                    
        Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
        return A.CheapShot              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("QuakingPalm on : " .. UnitName(unit), A.QuakingPalm.ID)
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("Haymaker on : " .. UnitName(unit), A.Haymaker.ID)
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("WarStomp on : " .. UnitName(unit), A.WarStomp.ID)
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("BullRush on : " .. UnitName(unit), A.BullRush.ID)
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)



-------------------------------
---- CUSTOM ROGUE FCT ---------
-------------------------------
-- TODO: Register/Unregister Events on SpecChange
Action.BleedTable = {
    Assassination = {
        Garrote = {},
        Rupture = {},
		CrimsonTempest = {}
    },
    --Subtlety = {
    --  Nightblade = {},
    --}
}

local BleedGUID

--- Exsanguinated Handler
-- Exsanguinate Expression
local BleedDuration, BleedExpires;
local function Exsanguinated(unit, SpellName)
    BleedGUID = UnitGUID(unit)
    if BleedGUID then
        if SpellName == "Garrote" then
            if Action.BleedTable.Assassination.Garrote[BleedGUID] then
                return Action.BleedTable.Assassination.Garrote[BleedGUID][3];
            end
        elseif SpellName == "Rupture" then
            if Action.BleedTable.Assassination.Rupture[BleedGUID] then
                return Action.BleedTable.Assassination.Rupture[BleedGUID][3];
            end
        elseif SpellName == "CrimsonTempest" then
            if Action.BleedTable.Assassination.CrimsonTempest[BleedGUID] then
                return Action.BleedTable.Assassination.CrimsonTempest[BleedGUID][3];
            end
        end
    end
    return false
end

-- Exsanguinate OnCast Listener
Action:RegisterForSelfCombatEvent(function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)
        
        -- Exsanguinate
        if SpellID == 200806 then
            for Key, _ in pairs(Action.BleedTable.Assassination) do
                for Key2, _ in pairs(Action.BleedTable.Assassination[Key]) do
                    if Key2 == DestGUID then
                        -- Change the Exsanguinate info to true
                        Action.BleedTable.Assassination[Key][Key2][3] = true
                    end
                end
            end
        end
    end
    , "SPELL_CAST_SUCCESS"
);

-- Bleed infos
local function GetBleedInfos (GUID, SpellID)
    -- Core API is not used since we don't want cached informations
    for i = 1, 40 do
        local auraInfo = {UnitAura(GUID, i, "HARMFUL|PLAYER")}
        if auraInfo[10] == SpellID then
            return auraInfo[5]
        end
    end
    return nil
end

-- Bleed OnApply/OnRefresh Listener
Action:RegisterForSelfCombatEvent(
    function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)
        
        --- Record the Bleed Target and its Infos
        -- Garrote
        if SpellID == 703 then
            BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
            Action.BleedTable.Assassination.Garrote[DestGUID] = {BleedDuration, BleedExpires, false}
            -- Rupture
        elseif SpellID == 1943 then
            BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
            Action.BleedTable.Assassination.Rupture[DestGUID] = {BleedDuration, BleedExpires, false}
        end
    end
    , "SPELL_AURA_APPLIED"
    , "SPELL_AURA_REFRESH"
);

-- Bleed OnRemove Listener
Action:RegisterForSelfCombatEvent(function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)
        
        -- Removes the Unit from Garrote Table
        if SpellID == 703 then
            if Action.BleedTable.Assassination.Garrote[DestGUID] then
                Action.BleedTable.Assassination.Garrote[DestGUID] = nil
            end
            -- Removes the Unit from Rupture Table
        elseif SpellID == 1943 then
            if Action.BleedTable.Assassination.Rupture[DestGUID] then
                Action.BleedTable.Assassination.Rupture[DestGUID] = nil
            end
        end
    end
    , "SPELL_AURA_REMOVED"
);

-- Bleed OnUnitDeath Listener
Action:RegisterForCombatEvent(function (...)
        DestGUID = select(8, ...)
        
        -- Removes the Unit from Garrote Table
        if Action.BleedTable.Assassination.Garrote[DestGUID] then
            Action.BleedTable.Assassination.Garrote[DestGUID] = nil
        end
        -- Removes the Unit from Rupture Table
        if Action.BleedTable.Assassination.Rupture[DestGUID] then
            Action.BleedTable.Assassination.Rupture[DestGUID] = nil
        end
    end
    , "UNIT_DIED"
    , "UNIT_DESTROYED"
);


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

-- Marked for Death Sniping
-- Will try to get best unit to apply Marked for Death considering time to die to get cooldown reset
local BestUnit, BestUnitTTD;
local function MfDSniping(unit)
    local unit = "target"
    
    if A.MarkedforDeath:IsReady(unit) and A.MarkedforDeath:IsSpellLearned() then
        -- Get Units up to 30y for MfD.        
        BestUnit, BestUnitTTD = nil, 60;
        local unit = "target"
        local MOunit = "mouseover"
        local MOTTD = Unit("mouseover"):GetRange() <= 30 and Unit("mouseover"):TimeToDie() or 11111;
        local TTD = Unit(unit):TimeToDie()
        
        for CycleUnit in pairs(ActiveUnitPlates) do
            
            -- Note: Increased the SimC condition by 50% since we are slower.
            -- TEST - REMOVED 50% lowered value on Action
            if not Unit(CycleUnit):IsMfdBlacklisted() and TTD < Player:ComboPointsDeficit() * 1 and TTD < BestUnitTTD then
                if MOTTD - TTD > 1 then
                    BestUnit, BestUnitTTD = Unit(CycleUnit), TTD;
                else
                    BestUnit, BestUnitTTD = MouseOver, MOTTD;
                end
            end
        end
        if BestUnit and BestUnit:InfoGUID() ~= Unit(CycleUnit):InfoGUID() then
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end
    end
end

-- Fake SSBuffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed()
    return A.ShroudedSuffocation:GetAzeriteRank() > 0
end

-- non_SSBuffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    
    local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(10, 5, A.Garrote.ID)   
    
    count = MissingGarrote
    
    return count;
end

-- SSBuffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    local GarroteToRefresh = MultiUnits:GetByRangeDoTsToRefresh(10, 5, A.Garrote.ID, 5.4)
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.Garrote.ID) -- Garrote count
    
    count = AppliedGarrote - GarroteToRefresh
    
    return count;
end

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

-- ExpectedCombatLength
local function ExpectedCombatLength()
    local BossTTD = 0
    if not A.IsInPvP then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() then 
                BossTTD = Unit("boss" .. i):TimeToDie()
            end 
        end 
    end 
    return BossTTD
end 
ExpectedCombatLength = A.MakeFunctionCachedStatic(ExpectedCombatLength)