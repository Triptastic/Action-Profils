------------------------------------------
------- PROTECTION PRE APL SETUP ---------
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
	BigDeff                                 = {A.GuardianofAncientKings.ID, A.DivineShield.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsHolySchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 10 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 10)) or 
                (not A.IsInPvP and MultiUnits:GetByRange(10, 1) >= 1)
            )
        )
    )
    then 
        return A.HammerofJusticeGreen:Show(icon)         
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
            if not notKickAble and A.Rebuke:IsReady(unit, nil, nil, true) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.Rebuke:Show(icon)                                                  
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

local function InRange(unit)
	-- @return boolean 
	return A.Judgment:IsInRange(unit)
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

local function isCurrentlyTanking()
    -- is player currently tanking any enemies within 16 yard radius
    local IsTanking = Unit(player):IsTankingAoE(16) or Unit(player):IsTanking("target", 16);
    return IsTanking;
end

local StunsBlackList = {
	-- Atal'Dazar
	[87318] = "Dazar'ai Colossus",
	[122984] = "Dazar'ai Colossus",
	[128455] = "T'lonja",
	[129553] = "Dinomancer Kish'o",
	[129552] = "Monzumi",
	-- Freehold
	[129602] = "Irontide Enforcer",
	[130400] = "Irontide Crusher",
	-- King's Rest
	[133935] = "Animated Guardian",
	[134174] = "Shadow-Borne Witch Doctor",
	[134158] = "Shadow-Borne Champion",
	[137474] = "King Timalji",
	[137478] = "Queen Wasi",
	[137486] = "Queen Patlaa",
	[137487] = "Skeletal Hunting Raptor",
	[134251] = "Seneschal M'bara",
	[134331] = "King Rahu'ai",
	[137484] = "King A'akul",
	[134739] = "Purification Construct",
	[137969] = "Interment Construct",
	[135231] = "Spectral Brute",
	[138489] = "Shadow of Zul",
	-- Shrine of the Storm
	[134144] = "Living Current",
	[136214] = "Windspeaker Heldis",
	[134150] = "Runecarver Sorn",
	[136249] = "Guardian Elemental",
	[134417] = "Deepsea Ritualist",
	[136353] = "Colossal Tentacle",
	[136295] = "Sunken Denizen",
	[136297] = "Forgotten Denizen",
	-- Siege of Boralus
	[129369] = "Irontide Raider",
	[129373] = "Dockhound Packmaster",
	[128969] = "Ashvane Commander",
	[138255] = "Ashvane Spotter",
	[138465] = "Ashvane Cannoneer",
	[135245] = "Bilge Rat Demolisher",
	-- Temple of Sethraliss
	[134991] = "Sandfury Stonefist",
	[139422] = "Scaled Krolusk Tamer",
	[136076] = "Agitated Nimbus",
	[134691] = "Static-charged Dervish",
	[139110] = "Spark Channeler",
	[136250] = "Hoodoo Hexer",
	[139946] = "Heart Guardian",
	-- MOTHERLODE!!
	[130485] = "Mechanized Peacekeeper",
	[136139] = "Mechanized Peacekeeper",
	[136643] = "Azerite Extractor",
	[134012] = "Taskmaster Askari",
	[133430] = "Venture Co. Mastermind",
	[133463] = "Venture Co. War Machine",
	[133436] = "Venture Co. Skyscorcher",
	[133482] = "Crawler Mine",
	-- Underrot
	[131436] = "Chosen Blood Matron",
	[133912] = "Bloodsworn Defiler",
	[138281] = "Faceless Corruptor",
	-- Tol Dagor
	[130025] = "Irontide Thug",
	-- Waycrest Manor
	[131677] = "Heartsbane Runeweaver",
	[135329] = "Matron Bryndle",
	[131812] = "Heartsbane Soulcharmer",
	[131670] = "Heartsbane Vinetwister",
	[135365] = "Matron Alma"
}

local HOJ_unitList = {
	[131009] = "Spirit of Gold",
	[134388] = "A Knot of Snakes",
	[129758] = "Irontide Grenadier"
}

local HOJ_list = {
	274400,
	274383,
	257756,
	276292,
	268273,
	256897,
	272542,
	272888,
	269266,
	258317,
	258864,
	259711,
	258917,
	264038,
	253239,
	269931,
	270084,
	270482,
	270506,
	270507,
	267433,
	267354,
	268702,
	268846,
	268865,
	258908,
	264574,
	272659,
	272655,
	267237,
	265568,
	277567,
	265540
}

-- Auto cancel Blessing of Protection
local function AutoCancelBoP()
	if AutoCancelBop then
		if Unit(player):HasBuffs(A.BlessingofProtection.ID, true) > 0 then
			Player:CancelBuff(A.BlessingofProtection:Info())
		end
		if Unit(player):HasBuffs(A.DivineShield.ID, true) > 0 and not A.FinalStand:IsSpellLearned() then
			Player:CancelBuff(A.DivineShield:Info())
		end
	end
end

-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
	
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
			
    -- ShieldoftheRighteous (any role, whenever have physical damage)
	local ShieldoftheRighteousHPLost = GetToggle(2, "ShieldoftheRighteousHPLost")
    if (HPLoosePerSecond >= ShieldoftheRighteousHPLost or Player:ActiveMitigationNeeded()) and A.ShieldoftheRighteous:IsReady(player) and Unit(player):HasBuffs(A.ShieldoftheRighteousBuff.ID, true) < A.GetGCD() + 0.1 and Unit(player):HasBuffs(A.ArdentDefender.ID, true) == 0 and Unit(player):GetRealTimeDMG(3) > 0 then 
        return A.ShieldoftheRighteous
    end 
	
	-- LightoftheProtector 
	local LightoftheProtectorHPLost = GetToggle(2, "LightoftheProtectorHPLost")
	local LightoftheProtectorHP = GetToggle(2, "LightoftheProtectorHP")
    if not A.HandoftheProtector:IsSpellLearned() and A.LightoftheProtector:IsReady(player) and 
	(
	    Unit(player):HealthPercent() <= LightoftheProtectorHP 
		or 
		Unit(player):TimeToDie() < 10 
		or 
		Unit(player):HealthPercent() < 97
	)
	then 
        return A.LightoftheProtector
    end 
	
    -- ArdentDefender
    if A.ArdentDefender:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "ArdentDefenderIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff) == 0) and
	-- Divine Shield and BoP and PvP Divine Shield (prot)
    Unit(player):HasBuffs({642, 1022, 228050}, true) == 0
    then 
        local AD_HP                 = A.GetToggle(2, "ArdentDefenderHP")
        local AD_TTD                = A.GetToggle(2, "ArdentDefenderTTD")
            
        if  (    
                ( AD_HP     >= 0     or AD_TTD                           >= 0                                        ) and 
                ( AD_HP     <= 0     or Unit(player):HealthPercent()     <= AD_HP                                    ) and 
                ( AD_TTD    <= 0     or Unit(player):TimeToDie()         <= AD_TTD                                   ) 
            ) 
		    or 
            (
                A.GetToggle(2, "ArdentDefenderCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()       >= Unit(player):Health() and Unit(player):HealthPercent() <= 10 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()      <= A.GetGCD()
                )
            )                
        then                
            return A.ArdentDefender
        end 
    end
		
		
    -- Guardian of Ancient Kings
    if A.GuardianofAncientKings:IsReadyByPassCastGCD(player) and
	-- Divine Shield and BoP and PvP Divine Shield (prot)
    Unit(player):HasBuffs({642, 1022, 228050}, true) == 0
	then 
        local GoAK_HP                 = A.GetToggle(2, "GuardianofAncientKingsHP")
        local GoAK_TTD                = A.GetToggle(2, "GuardianofAncientKingsTTD")
            
        if  (    
                ( GoAK_HP     >= 0     or GoAK_TTD                         >= 0             ) and 
                ( GoAK_HP     <= 0     or Unit(player):HealthPercent()     <= GoAK_HP       ) and 
                ( GoAK_TTD    <= 0     or Unit(player):TimeToDie()         <= GoAK_TTD      )  
            ) 
			or 
            (
                A.GetToggle(2, "GuardianofAncientKingsCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()       >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()      <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- ShieldoftheRighteous
            if A.ShieldoftheRighteous:IsReadyByPassCastGCD(player) and Unit(player):HasBuffs(A.ShieldoftheRighteousBuff.ID, true) < A.GetGCD() + 0.1 and Unit(player):HasBuffs(A.ArdentDefender.ID, true) == 0 then  
                return A.ShieldoftheRighteous        -- #4
            end 
                
            -- GuardianofAncientKings
            return A.GuardianofAncientKings         -- #3                  
             
        end 
    end

    -- Lay on Hands @Player
    if A.LayonHands:IsReady(player) and
    A.Zone ~= "arena" and
    not Action.InstanceInfo.isRated and
    Unit("player"):CombatTime() > 0 and
    Unit("player"):Health() <= Unit("player"):HealthMax() * 0.13 and
	Unit("player"):HasDeBuffs(25771, true) == 0 and -- Forbearance and
    (
        Unit("player"):HasBuffs(31850, true) <= 0.1 -- Ardent Defender    
    ) 	
	or 
    (
        A.GetToggle(2, "LayonHandsCatchKillStrike") and 
        (
            ( Unit(player):GetDMG()       >= Unit(player):Health() and Unit(player):HealthPercent() <= 15 ) or 
            Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
            Unit(player):TimeToDie()      <= A.GetGCD() + A.GetCurrentGCD()
        )
    )   
    then 
	    return A.LayonHands
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
    if not A.Rebuke:IsReadyByPassCastGCD(unit) or not A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
	        -- Notification					
            Action.SendNotification("Rebuke interrupting...", A.Rebuke.ID)
            return A.Rebuke
        end 
    
        if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	        -- Notification					
            Action.SendNotification("Hammer of Justice interrupting...", A.HammerofJustice.ID)
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
end

local DispelSpell = {
    -- Spell ID
    ["CleansingLight"] = 236186, -- PvP AoE Dispel 15 yards (Cleansing Light)
    [70] = 213644, -- Retribution
    [66] = 213644, -- Protection
    [65] = 4987, -- Holy
    -- DeBuffs Poison and Disease
    ["Slow"] = {
        3408, -- Crippling Poison
        58180, -- Infected Wounds
        197091, -- Neurotoxin
        -- 55095б -- Frost DK dot (no reason spend gcd for that)
    },
}

local function Dispel(unit)    
    return 
    (
        -- SELF 
        (
            UnitIsUnit(unit, player) and 
            (
                (
                    not Unit(player):HasSpec(65) and -- Holy            
                    A.CleansingLight:IsSpellLearned() and -- AoE Dispel 
                    A.Cleanse:IsReady(unit) and 
                    A.LastPlayerCastID ~= DispelSpell["CleansingLight"]
                ) or 
                (
                    not A.CleansingLight:IsSpellLearned() and -- AoE Dispel 
                    A.Cleanse:IsReady(unit) and 
                    A.LastPlayerCastID ~= 4987
                )
            ) and 
            Unit(unit):HasDeBuffs(DispelSpell["Slow"], true) > 2 and 
            Unit(unit):GetCurrentSpeed() > 0 and
            Unit(unit):GetCurrentSpeed() < 100 and
            (
                not Unit(player):HasSpec(65) or -- Holy
                (
                    not AutoFreedom or 
                    not A.BlessingofFreedom:IsReady(unit) -- Freedom
                )
            )
        ) or 
        -- PvE: ANOTHER UNIT   
        (
            -- Useable conditions
            not A.IsInPvP and
            Unit(unit):IsExists() and
            --not UnitIsUnit(unit, player) and 
            Unit(unit):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone
            Env.PvEDispel(unit)             
        ) or
        -- PvP: ANOTHER UNIT   
        (
            -- Useable conditions
            A.IsInPvP and
            Unit(unit):IsExists() and
            --not UnitIsUnit(unit, player) and 
            Unit(unit):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone
            (
                (
                    not Unit(player):HasSpec(65) and -- Holy            
                    A.CleansingLight:IsSpellLearned() and -- AoE Dispel 
                    A.Cleanse:IsReady(unit) and 
                    A.LastPlayerCastID ~= DispelSpell["CleansingLight"] and
                    Unit(unit):GetRange() <= 15 
                ) or 
                (
                    not A.CleansingLight:IsSpellLearned() and -- AoE Dispel 
                    A.Cleanse:IsReady(unit) and 
                    A.LastPlayerCastID ~= 4987 and
                    --not Unit(unit):InLOS() and 
                    A.Cleanse:IsInRange(unit)
                )
            ) and 
            -- Dispel types 
            (
                -- Poison CC 
                Unit(unit):HasDeBuffs("Poison") > 2 or
                (
                    -- Holy Paladin Magic CC 
                    Unit(player):HasSpec(65) and -- Holy
                    (
                        Unit(unit):HasDeBuffs("Magic") > 2 or 
                        -- Magic Rooted (if not available freedom)
                        (                            
                            (
                                not AutoFreedom or 
                                not A.BlessingofFreedom:IsReady(unit) -- Freedom
                            ) and 
                            select(2, UnitClass(unit)) ~= "DRUID" and
                            Unit(unit):HasDeBuffs("MagicRooted") > 3 and 
                            Unit(unit):IsMelee() and
                            Unit(unit):GetRealTimeDMG() <= Unit(unit):HealthMax() * 0.1 
                        )
                    )
                ) or 
                -- Poison Slowed 
                (
                    not Unit(player):HasSpec(65) and -- Holy 
                    (
                        not AutoFreedom or 
                        not A.BlessingofFreedom:IsReady(unit) -- Freedom
                    ) and     
                    select(2, UnitClass(unit)) ~= "DRUID" and
                    Unit(unit):HasDeBuffs(DispelSpell["Slow"], true) > 5 and                        
                    Unit(unit):HasDeBuffs("DamageBuffs_Melee") > 6
                )
            )
        )
    ) and
    -- Check another CC types     
    Unit(unit):HasDeBuffs("Physical") <= GetCurrentGCD() and 
    -- Hex
    Unit(unit):HasDeBuffs(51514, true) <= GetCurrentGCD()
end

-- Blessing of Sanctuary
local function BoS(unit)    
    return
    A.BlessingofSanctuary:IsSpellLearned() and 
    A.BlessingofSanctuary:IsReady() and 
    UnitExists(unit) and      
    A.BlessingofSanctuary:IsSpellInRange(unit) and     
    Unit(unit):HasDeBuffs(33786, true) == 0 and -- Cyclone
    (
        (
            --MacroSpells(Icon, "HoS") and 
            (
                Unit(unit):HasDeBuffs("Stuned") > 1.5 or 
                Unit(unit):HasDeBuffs("Fear") > 1.5 or 
                (
                    Unit(unit):HasDeBuffs("Silenced") > 1.5 and 
                    Unit(unit):HasDeBuffs(78675, true) == 0 -- Solar Beam
                )
            )
        ) or 
        (
            HoS_toggle and 
            (
                Unit(unit):HasDeBuffs({115080, 79140}, true) == 0 or -- Touch of Death, Vendetta
                not BlessingofProtection:IsReady() or -- BoP
                Unit(unit):HasDeBuffs(25771, true) > 1 -- Forbearance
            ) and 
            (
                (
                    (
                        Unit(unit):HasDeBuffs(5246, true) > 3.5 and -- Intimidating Shout                
                        not Unit(unit):IsFocused() 
                    ) or 
                    (
                        Unit(unit):HasDeBuffs("PhysStuned") > 3.5 and 
                        (
                            Unit(unit):HasBuffs("DamageBuffs") > 3 or 
                            (
                                Unit(unit):HasDeBuffs(76577, true) > 0 and -- Smoke Bomb
                                Unit(unit):IsFocused("MELEE")
                            )
                        )
                    ) or             
                    (
                        Unit(unit):Role("HEALER") and 
                        (
                            Unit(unit):HasDeBuffs("Stuned") > 3.5 or
                            Unit(unit):HasDeBuffs("Fear") > 3.5 or 
                            (
                                Unit(unit):HasDeBuffs("Silenced") > 3.5 and 
                                Unit(unit):HasDeBuffs(78675, true) == 0 -- Solar Beam
                            ) 
                        )  
                    ) 
                ) and 
                -- Hex, Polly, Repentance, Blind, Wyvern Sting, Ring of Frost, Paralysis, Freezing Trap, Mind Control
                Unit(unit):HasDeBuffs({51514, 118, 20066, 2094, 19386, 82691, 115078, 3355, 605}, true) <= GetCurrentGCD() 
            )
        ) 
    )
end

local function HoF(unit)    
    --local msg = MacroSpells(Icon, "Freedom")
    return
    --(
   --     msg or 
   --     HoF_toggle  
   -- ) and
    A.BlessingofFreedom:IsReady(unit) and 
    Unit(unit):IsPlayer() and
    (
        -- SELF
        (
            UnitIsUnit(unit, player) and 
            (
                Unit(unit):HasDeBuffs("Rooted") > GetCurrentGCD() + GetGCD() or 
                (
                    Unit(player):GetCurrentSpeed() > 0 and 
                    Unit(player):GetMaxSpeed() < 100
                )
            )
        ) or
        -- ANOTHER UNIT 
        (
            -- Useable conditions
            Unit(unit):IsExists() and 
            not UnitIsUnit(unit, player) and 
            select(2, UnitClass(unit)) ~= "DRUID" and
            --not Unit(unit):InLOS() and         
            A.BlessingofFreedom:IsInRange(unit)    and        
            Unit(unit):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone    
            (
                -- MSG System
               -- msg or 
                -- Rooted and Solar Beam
                (
                    Unit(unit):HasDeBuffs(78675, true) > 0 and  
                    Unit(unit):HasDeBuffs("Rooted") > GetCurrentGCD()
                ) 
                or 
                -- Rooted without inc dmg 
                (
                    Unit(unit):HasDeBuffs("Rooted") > 3 and
                    Unit(unit):GetRealTimeDMG() <= Unit(unit):HealthMax() * 0.1 
                ) 
                or 
                -- Slowed (if we no need freedom for self)
                (
                    (
                        -- 8.2 changes Unbound Freedom
                        A.IsSpellLearned(305394) or 
                        not Unit(player):IsFocused() or 
                        Unit(player):GetMaxSpeed() >= 100
                    ) and
                    Unit(unit):GetCurrentSpeed() > 0 and 
                    Unit(unit):GetMaxSpeed() < 80 and 
                    (
                        (
                            -- 8.2 changes Unbound Freedom
                            A.IsSpellLearned(305394) and 
                            Unit(player):GetCurrentSpeed() < 100
                        ) or 
                        (
                            Unit(unit):HasBuffs("DamageBuffs") > 6 and 
                            Unit(unit):HasDeBuffs("Slowed") > 0 and 
                            Unit(unit):HasDeBuffs("Disarmed") <= GetCurrentGCD()
                        )
                    )
                ) 
                or 
                (                
                    Action.ZoneID == 1580 and                   -- Ny'alotha - Vision of Destiny
                    Unit(unit):HasDeBuffsStacks(307056) >= 40 -- Burning Madness
                )
            )
        )
    ) and
    -- Check another CC types 
    -- Hex, Polly, Repentance, Blind, Wyvern Sting, Ring of Frost, Paralysis, Freezing Trap, Mind Control
    Unit(unit):HasDeBuffs({51514, 118, 20066, 2094, 19386, 82691, 115078, 3355, 605}, true) <= GetCurrentGCD() and 
    Unit(unit):HasDeBuffs("Incapacitated") <= GetCurrentGCD() and 
    Unit(unit):HasDeBuffs("Disoriented") <= GetCurrentGCD() and 
    Unit(unit):HasDeBuffs("Fear") <= GetCurrentGCD() and 
    Unit(unit):HasDeBuffs("Stuned") <= GetCurrentGCD()  
end    

local function SacrificeAble(unit)
    -- Function to check if we can use sacriface with max profit time duration on unit
    local dmg, u_ttd, bubble, shield = Unit(unit):GetDMG() * 0.7, Unit(unit):TimeToDie() * 0.7, Unit(player):HasBuffs(642, true), 1
    -- -20% incoming damage
    local shield_buff = Unit(player):HasBuffs(498, true)
    if shield_buff > 0 then 
        shield = dmg * ( 0.2 - (0.2 - (shield_buff * 0.2 / 8)) )
    end
    
    local p_ttd, p_chp = 0, Unit(player):Health()
    if not A.UltimateSacrifice:IsSpellLearned() or not A.IsInPvP then
        -- Real player's ttd to lower 20% under sacriface and shield buff
        local p_mhp = Unit(player):HealthMax() * 0.2
        if p_chp > p_mhp and dmg > 0 and u_ttd > 0 then 
            local muliplier = 0.75
            -- If Protection then 100% receiving damage by Sacriface
            if Unit(player):HasSpec(66) then 
                muliplier = 1
            end     
            p_ttd = math.abs(        
                -- Current HP without 20% / incdmg by Sacriface + already exist incdmg for yourself
                (p_chp - p_mhp) /
                (( dmg * muliplier * (1 - (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)/2/100)) ) + Unit(player):GetDMG() )
            )     
        end
    else
        p_ttd = math.abs(        
            -- Current HP / incdmg by Sacriface + already exist incdmg for yourself
            p_chp /
            (( dmg * (1 - (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)/2/100)) ) + Unit(player):GetDMG() )
        )    
    end 
    
    if bubble > 0 then 
        p_ttd = p_ttd + bubble
    end
    
    return p_ttd + GetCurrentGCD() >= u_ttd, p_ttd
end

-- Hand of Sacrifice
local function HoS(unit, hp, IsRealDMG, IsDeffensed)  
    return 
    Unit(unit):IsExists() and 
    Unit(unit):IsPlayer() and
    not UnitIsUnit(unit, player) and
    --not Unit(unit):InLOS() and 
    (UnitInRaid(unit) or UnitInParty(unit)) and 
    A.BlessingofSacrifice:IsReady(unit) and
    A.BlessingofSacrifice:IsInRange(unit) and 
    Unit(unit):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone 
    Unit(player):Health() > Unit(player):HealthMax() * 0.2 and       
    (
        -- MSG System TO ACTION
        --(
        --    Icon and 
         --   MacroSpells(Icon, "HoS") 
        --) or  
        -- HoS conditions 
        (
           -- HoS_toggle and 
            SacrificeAble(unit) and 
            Unit(unit):HasBuffs(1022, true) == 0 and -- BoP
            -- Check args
            (
                not IsRealDMG or
                Unit(unit):GetRealTimeDMG() > 0
            ) and 
            ( 
                not IsDeffensed or 
                Unit(unit):HasBuffs("DeffBuffs", true) == 0
            ) and 
            -- Check if unit don't will be killed 
            (
                not Unit(player):HasSpec(65) or -- Holy
                Unit(unit):TimeToDie() >= 4 
            ) and 
            -- Conditions
            (
                -- Check for HP arg
                ( 
                    hp and 
                    Unit(unit):Health() <= Unit(unit):HealthMax() * (hp / 100)
                ) or 
                -- Another check 
                (
                    Unit(unit):TimeToDie() < 14 and 
                    (
                        (
                            Unit(unit):Health() <= Unit(unit):HealthMax() * 0.35 and 
                            (
                                Unit(unit):GetHEAL()  * 1.4 < Unit(unit):GetDMG() or
                                Unit(unit):Health() <= Unit(unit):GetDMG() * 3.5 
                            ) 
                        ) or 
                        -- if unit has 35% dmg per sec 
                        Unit(unit):GetRealTimeDMG() >= Unit(unit):HealthMax() * 0.35 or 
                        -- if unit has sustain 20% dmg per sec 
                        Unit(unit):GetDMG() >= Unit(unit):HealthMax() * 0.2
                    )
                )
            )
        )
    )
end 

local function BoP(unit)
    local id = 1022

    return
    A.BlessingofProtection:IsReady(unit) and 
    Unit(unit):IsExists() and 
    Unit(unit):IsPlayer() and
    not Unit(unit):IsTank() and
    (
        not UnitIsUnit(unit, player) or
        -- Divine Shield
        A.DivineShield:GetCooldown() > 5
    ) and
    --not Unit(unit):InLOS() and    
    (UnitInRaid(unit) or UnitInParty(unit)) and
    A.BlessingofProtection:IsInRange(unit) and     
    Unit(unit):HasDeBuffs({33786, 25771}, true) == 0 and -- Cyclone and Forbearance   
    ( 
        not A.IsInPvP or
        not Unit(unit):HasFlags()       
    ) and
    (
       -- ( 
       --     Icon and 
       --     MacroSpells(Icon, "BoP")
       -- ) or 
        (
            --BoP_toggle and 
            id == 1022 and 
            (
                -- Deffensive
                (            
                    Unit(unit):GetDMG(3) > 0 and 
                    (
                        (
                            Unit(player):HasSpec(65) and -- Holy
                            Unit(unit):HealthPercent() <= 38 and 
                            -- Physical real damage still appear
                            select(3, Unit(unit):GetRealTimeDMG()) > 0
                        ) or
                        (
                            not Unit(player):HasSpec(65) and -- Holy                            
                            Unit(unit):HealthPercent() <= 31 and 
                            (
                                FriendlyTeam("HEALER"):GetCC() or
                                Unit(unit):TimeToDieX(20) < 2
                            ) and
                            Unit(unit):HasBuffs("DeffBuffs") == 0 
                        )
                    ) and                     
                    (
                        -- PvP 
                        (
                            A.IsInPvP and
                            (
                                Unit(unit):IsFocused("MELEE") or
                                (
                                    Unit(unit):UseDeff() and 
                                    -- Physical real damage still appear
                                    select(3, Unit(unit):GetRealTimeDMG()) > 0
                                )
                            )
                        ) or
                        -- PvE 
                        not A.IsInPvP 
                    )
                ) or 
                -- Damage DeBuffs
                Unit(unit):HasDeBuffs({115080, 122470}, true) > 4 or -- Touch of Death and KARMA
                Unit(unit):HasDeBuffs(79140, true) > 15 or -- Vendetta
                -- CC Physical DeBuffs
                (
                    (
                        -- Disarmed
                        (
                            not Unit(player):HasSpec(70) and -- Retribution
                            Unit(unit):IsMelee() and 
                            Unit(unit):HasDeBuffs("Disarmed") > 4.5 and                             
                            Unit(unit):HasBuffs("DamageBuffs") > 4                      
                        ) or 
                        -- Another BreakAble CC 
                        (
                            (
                                Unit(unit):HasDeBuffs(2094, true) > 3.2 or -- Blind
                                (
                                    Unit(unit):HasDeBuffs(5246, true) > 3.2 and -- Intimidating Shout
                                    (
                                        not Unit(player):HasSpec(70) or -- Retribution
                                        -- Blessing of Sanctuary
                                        not A.BlessingofSanctuary:IsSpellLearned() or 
                                        not A.BlessingofSanctuary:IsReady(unit)
                                    )
                                )
                            ) and 
                            (
                                not A.IsInPvP or 
                                not Unit(unit):IsFocused()
                            )
                        ) or 
                        -- HEALER HELP 
                        (
                            Unit(unit):Role("HEALER") and 
                            (
                                Unit(unit):HasDeBuffs("Stuned") >= 4 or 
                                -- Garrote
                                Unit(unit):HasDeBuffs(1330, true) >= 2.5
                            ) and 
                            (
                                not Unit(player):HasSpec(70) or -- Retribution
                                -- Blessing of Sanctuary
                                not A.BlessingofSanctuary:IsSpellLearned() or  
                                not A.BlessingofSanctuary:IsReady(unit)
                            ) and 
                            Unit(unit):HasBuffs("DeffBuffs") <= GetCurrentGCD() and
                            (
                                not A.IsInPvP or 
                                -- if enemy melee bursting 
                                Unit(unit):IsFocused("MELEE") 
                            )
                        ) 
                    ) and 
                    -- Check for non physical CC 
                    (
                        Unit(unit):HasDeBuffs("Silenced") <= GetCurrentGCD() or 
                        -- Garrote
                        Unit(unit):HasDeBuffs(1330, true) >= 2.5
                    ) and 
                    Unit(unit):HasDeBuffs("Magic") <= GetCurrentGCD() and 
                    -- Hex
                    Unit(unit):HasDeBuffs(51514, true) <= GetCurrentGCD()
                )
            )
        )
    )
end

-- Return number
-- Consecration duration left
local function Consecration()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 135926 then
            return startTime + duration - GetTime()
        end
    end
    return 0
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

local function TargetWithAgroExsist()

        local agroLevels = {}
        agroLevels[0] = false
        agroLevels[1] = false
        agroLevels[2] = false
        agroLevels[3] = false

        local HandofReckoning_Nameplates = MultiUnits:GetActiveUnitPlates()
        if HandofReckoning_Nameplates then
            for HandofReckoning_UnitID in pairs(HandofReckoning_Nameplates) do
                if Unit(HandofReckoning_UnitID):CombatTime() > 0
                        and Unit(HandofReckoning_UnitID):GetRange() <= 30
                        and not Unit(HandofReckoning_UnitID):IsTotem()
                        and not Unit(HandofReckoning_UnitID):IsPlayer()
                        and not Unit(HandofReckoning_UnitID):IsExplosives()
                        and not Unit(HandofReckoning_UnitID):IsDummy()
                then
                    if Unit(player):ThreatSituation(HandofReckoning_UnitID) ~= nil then
                        agroLevels[Unit(player):ThreatSituation(HandofReckoning_UnitID)] = true
                    end
                end
            end
        end
    return agroLevels
end