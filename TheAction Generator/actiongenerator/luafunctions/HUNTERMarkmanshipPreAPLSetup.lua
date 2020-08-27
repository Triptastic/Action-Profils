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
Pet:AddActionsSpells(254, {

	-- number accepted
	17253, -- Bite
	16827, -- Claw
	49966, -- Smack 
}, true)

local GameLocale = GetLocale()    
local PetLocalization = {
    [GameLocale] = {},
    ruRU = {
	    SPIRITBEAST = "Дух зверя",
		TENACITY = "Упорство",
		FEROCITY = "Свирепость",
		CUNNING = "Хитрость",
	},
    enGB = {
    	SPIRITBEAST = "Spirit Beast",
		TENACITY = "Tenacity",
		FEROCITY = "Ferocity",
		CUNNING = "Cunning",
	},
    enUS = {
    	SPIRITBEAST = "Spirit Beast",
		TENACITY = "Tenacity",
		FEROCITY = "Ferocity",
		CUNNING = "Cunning",
	},
    deDE = {
	    SPIRITBEAST = "Geisterbestie",
		TENACITY = "Hartnäckigkeit",
		FEROCITY = "Wildheit",
		CUNNING = "Gerissenheit",
	},
    esES = {
    	SPIRITBEAST = "Bestia espíritu",
		TENACITY = "Tenacidad",
		FEROCITY = "Ferocidad",
		CUNNING = "Astucia",
	},
    esMX = {
	    SPIRITBEAST = "Bestia espíritu",
		TENACITY = "Tenacidad",
		FEROCITY = "Ferocidad",
		CUNNING = "Astucia",
	},
    frFR = {
	    SPIRITBEAST = "Esprit de bête",
		TENACITY = "Tenacité",
		FEROCITY = "Férocité",
		CUNNING = "Ruse",
	},
    itIT = {
	    SPIRITBEAST = "Bestia Eterea",
		TENACITY = "Tenacia",
		FEROCITY = "Ferocia",
		CUNNING = "Scaltrezza",
	},
    ptBR = {
    	SPIRITBEAST = "Fera Espiritual",
		TENACITY = "Tenacidade",
		FEROCITY = "Ferocidade",
		CUNNING = "Astúcia",
	},
    koKR = {
    	SPIRITBEAST = "야수 정령",
		TENACITY = "끈기",
		FEROCITY = "야성",
		CUNNING = "교활",
	},
    zhCN = {
	    SPIRITBEAST = "灵魂兽",
		TENACITY = "坚韧",
		FEROCITY = "狂野",
		CUNNING = "狡诈",
	},
    zhTW = {
	    SPIRITBEAST = "靈獸",
		TENACITY = "",
		FEROCITY = "",
		CUNNING = "",
	},
}
local LP = setmetatable(PetLocalization[GameLocale], { __index = PetLocalization.enUS })

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

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.CounterShot:IsReadyByPassCastGCD(unit) or not A.CounterShot:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- CounterShot
        if useKick and not notInterruptable and A.CounterShot:IsReady(unit) then 
            return A.CounterShot
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