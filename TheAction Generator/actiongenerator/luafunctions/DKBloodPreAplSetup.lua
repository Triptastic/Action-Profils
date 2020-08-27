------------------------------------------
---------- BLOOD PRE APL SETUP -----------
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
	BigDeff                                 = {A.DancingRuneWeapon.ID, A.IceboundFortitude.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.HeartStrike:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
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
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- RuneTap	
    if A.RuneTap:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "RuneTapIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local RT_HP                 = A.GetToggle(2, "RuneTapHP")
        local RT_TTD                = A.GetToggle(2, "RuneTapTTD")
        local RT_UNITS              = A.GetToggle(2, "RuneTapUnits")
        if  (    
                ( RT_HP     >= 0     or RT_TTD                              >= 0                                     ) and 
                ( RT_HP     <= 0     or Unit(player):HealthPercent()     <= RT_HP                                    ) and 
                ( RT_TTD     <= 0     or Unit(player):TimeToDie()         <= RT_TTD                                  ) and
				( RT_UNITS   >= 0 and MultiUnits:GetByRange(8) >= RT_UNITS and Player:AreaTTD(8) > 3 and (Unit(player):HealthPercent() <= RT_HP or Unit(player):TimeToDie() <= RT_TTD) )
            ) 
		    or 
            (
                A.GetToggle(2, "RuneTapCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.RuneTap
        end 
    end 
		
    -- Emergency AntiMagicShell
    local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
	local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellTTDMagic")
    local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellTTDMagicHP")
	local total, Hits, phys, magic = Unit(player):GetDMG()
	local RTtotal, RTHits, RTphys, RTmagic = Unit(player):GetRealTimeDMG()
		
    if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
    (
        (   -- Auto 
            AntiMagicShell >= 100 and 
            (
                -- HP lose per sec >= 10
                magic * 100 / Unit(player):HealthMax() >= 10 or 
                RTmagic >= Unit(player):HealthMax() * 0.10 or 
                -- TTD Magic
                Unit(player):TimeToDieMagicX(AntiMagicShellTTDMagicHP) < AntiMagicShellTTDMagic or 
				-- GGL logic by Ayni on magic inc damage
				Unit(player):GetDMG(4) > Unit(player):GetDMG() / 2 or
				Unit(player):GetDMG(4) * 5 >= A.AntiMagicShell:GetSpellDescription()[1] or
					
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
            AntiMagicShell < 100 and 
            Unit(player):HealthPercent() <= AntiMagicShell
        )
    ) 
    then 
        return A.AntiMagicShell
    end 
		
    -- Icebound Fortitude	
    if A.IceboundFortitude:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "IceboundFortitudeIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local IF_HP                 = A.GetToggle(2, "IceboundFortitudeHP")
        local IF_TTD                = A.GetToggle(2, "IceboundFortitudeTTD")
            
        if  (    
                ( IF_HP     >= 0     or IF_TTD                              >= 0                                     ) and 
                ( IF_HP     <= 0     or Unit(player):HealthPercent()     <= IF_HP                                    ) and 
                ( IF_TTD    <= 0     or Unit(player):TimeToDie()         <= IF_TTD                                   ) 
            ) 
		    or 
            (
                A.GetToggle(2, "IceboundFortitudeCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.IceboundFortitude
        end 
    end 
	
    -- Vampiric Blood
    if A.VampiricBlood:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "VampiricBloodIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local VB_HP                 = A.GetToggle(2, "VampiricBloodHP")
        local VB_TTD                = A.GetToggle(2, "VampiricBloodTTD")
            
        if  (    
                ( VB_HP     >= 0     or VB_TTD                           >= 0                                     ) and 
                ( VB_HP     <= 0     or Unit(player):HealthPercent()     <= VB_HP                                 ) and 
                ( VB_TTD    <= 0     or Unit(player):TimeToDie()         <= VB_TTD                                )  
            ) 
			or 
            (
                A.GetToggle(2, "VampiricBloodCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 30 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then                
            -- VampiricBlood
            return A.VampiricBlood         -- #3                  
             
        end 
    end
	
    -- Dancing Rune Weapon
    if A.DancingRuneWeapon:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "DancingRuneWeaponIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local DRW_HP                 = A.GetToggle(2, "DancingRuneWeaponHP")
        local DRW_TTD                = A.GetToggle(2, "DancingRuneWeaponTTD")
            
        if  (    
                ( DRW_HP     >= 0     or DRW_TTD                          >= 0                                     ) and 
                ( DRW_HP     <= 0     or Unit(player):HealthPercent()     <= DRW_HP                                ) and 
                ( DRW_TTD    <= 0     or Unit(player):TimeToDie()         <= DRW_TTD                               )  
            ) 
			or 
            (
                A.GetToggle(2, "DancingRuneWeaponCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 25 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- Marrowrend
            if A.Marrowrend:IsReadyByPassCastGCD(player, nil, nil, true) and Player:RunicPower() >= A.Marrowrend:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 then  
                return A.Marrowrend        -- #4
            end 
                
            -- DancingRuneWeapon
            return A.DancingRuneWeapon         -- #3                  
             
        end 
    end		

    -- Emergency Death Pact
    local DeathPact = Action.GetToggle(2, "DeathPactHP")
    if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
    (
        (   -- Auto 
            DeathPact >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(10) < 5 or 
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
            DeathPact < 100 and 
            Unit(player):HealthPercent() <= DeathPact
        )
    ) 
    then 
        return A.DeathPact
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
    if not A.MindFreeze:IsReadyByPassCastGCD(unit) or not A.MindFreeze:AbsentImun(unit, Temp.TotalAndMagKick) then
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
    
	-- Check for current cast >= interface latency to avoid wasting interrupt too late
	if castRemainsTime >= A.GetLatency() then
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
	
        -- DeathGrip
        if useCC and A.DeathGrip:IsReady(unit) and DeathGripInterrupt then 
            return A.DeathGrip
   	    end 
	
   	    -- Asphyxiate
   	    if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
   	        return A.Asphyxiate
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

local function PredictDS() 
    local ReceivedLast5sec, HP7 = Unit(player):GetLastTimeDMGX(5) * 0.25, Unit(player):HealthMax() * 0.07  
    -- if this value lower than 7% then set fixed 7% heal    
    if ReceivedLast5sec <= HP7 then         
        ReceivedLast5sec = HP7    
    end 
    -- Extra buff which adding additional +10% heal 
    --[[
    if Env.Buffs("player", 101568, "player") > 0 then 
        ReceivedLast5sec = ReceivedLast5sec + HP10
    end ]]
    return Unit(player):HealthMax() - Unit(player):HealthPercent() >= ReceivedLast5sec or ReceivedLast5sec >= Unit(player):HealthMax() * 0.25
end 

local function TargetWithAgroExsist()

        local agroLevels = {}
        agroLevels[0] = false
        agroLevels[1] = false
        agroLevels[2] = false
        agroLevels[3] = false

        local DarkCommand_Nameplates = MultiUnits:GetActiveUnitPlates()
        if DarkCommand_Nameplates then
            for DarkCommand_UnitID in pairs(DarkCommand_Nameplates) do
                if Unit(DarkCommand_UnitID):CombatTime() > 0
                        and Unit(DarkCommand_UnitID):GetRange() <= 30
                        and not Unit(DarkCommand_UnitID):IsTotem()
                        and not Unit(DarkCommand_UnitID):IsPlayer()
                        and not Unit(DarkCommand_UnitID):IsExplosives()
                        and not Unit(DarkCommand_UnitID):IsDummy()
                then
                    if Unit(player):ThreatSituation(DarkCommand_UnitID) ~= nil then
                        agroLevels[Unit(player):ThreatSituation(DarkCommand_UnitID)] = true
                    end
                end
            end
        end

        return agroLevels
end