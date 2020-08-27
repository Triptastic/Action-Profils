local Action                                = Action

local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local Pet                                    = LibStub("PetLibrary")

local setmetatable, pairs, select, wipe        = setmetatable, pairs, select, wipe
local UnitPowerType                         = UnitPowerType 
local UnitIsUnit                            = UnitIsUnit
local IsUsableSpell                            = IsUsableSpell


-- All spells and action
Action[Action.PlayerClass] = {
    -- Night elf 
    Shadowmeld = Action.Create({ Type = "Spell", ID = 20580 }),
    -- Dwarf     
    Stoneform = Action.Create({ Type = "Spell", ID = 20594 }),     
    -- Troll 
    Berserking = Action.Create({ Type = "Spell", ID = 20554 }), 

    -- Damager 
    SoulFire = Action.Create({ Type = "Spell", ID = 6353, useMaxRank = true }), 
    Corruption = Action.Create({ Type = "Spell", ID = 172, useMaxRank = true }), 
    SiphonLife = Action.Create({ Type = "Spell", ID = 18265, useMaxRank = true }),
    Immolate = Action.Create({ Type = "Spell", ID = 348, useMaxRank = true }),
	ShadowBolt = Action.Create({ Type = "Spell", ID = 686, useMaxRank = true }),
	RainofFire = Action.Create({ Type = "Spell", ID = 5740, useMaxRank = true }),
	ShadowBurn = Action.Create({ Type = "Spell", ID = 17877, useMaxRank = true }),
	Conflagrate = Action.Create({ Type = "Spell", ID = 17962, useMaxRank = true }),
	HellFire = Action.Create({ Type = "Spell", ID = 11684, useMaxRank = true }),
    CurseofDoom = Action.Create({ Type = "Spell", ID = 603, useMaxRank = true }), -- Don't work on players
	DrainLife = Action.Create({ Type = "Spell", ID = 689, useMaxRank = true }),
	DrainSoul = Action.Create({ Type = "Spell", ID = 1120, useMaxRank = true }),
	SearingPain = Action.Create({ Type = "Spell", ID = 5676, useMaxRank = true }),
	
	-- Curses
	CurseofWeakness = Action.Create({ Type = "Spell", ID = 702, useMaxRank = true }),
	CurseofAgony = Action.Create({ Type = "Spell", ID = 980, useMaxRank = true }),
	CurseofRecklessness = Action.Create({ Type = "Spell", ID = 704, useMaxRank = true }),
	CurseofTongues = Action.Create({ Type = "Spell", ID = 1714, useMaxRank = true }),
	CurseoftheElements = Action.Create({ Type = "Spell", ID = 1490, useMaxRank = true }),
	CurseofShadow = Action.Create({ Type = "Spell", ID = 17862, useMaxRank = true }),
	
    -- Pets
    SummonImp = Action.Create({ Type = "Spell", ID = 688, useMaxRank = true }),   
    SummonVoidwalker = Action.Create({ Type = "Spell", ID = 697, useMaxRank = true }),
    SummonFelhunter = Action.Create({ Type = "Spell", ID = 691, useMaxRank = true }),
    SummonSuccubus = Action.Create({ Type = "Spell", ID = 712, useMaxRank = true }),
    HealthFunnel = Action.Create({ Type = "Spell", ID = 755, useMaxRank = true }),
	
    -- Utilities
	Banish = Action.Create({ Type = "Spell", ID = 710, useMaxRank = true }),
    EnslaveDemon = Action.Create({ Type = "Spell", ID = 1098, useMaxRank = true }),
	LifeTap = Action.Create({ Type = "Spell", ID = 1454, useMaxRank = true }),
	HowlofTerror = Action.Create({ Type = "Spell", ID = 5484, useMaxRank = true }),
	Fear = Action.Create({ Type = "Spell", ID = 5782, useMaxRank = true }),
	ShadowWard = Action.Create({ Type = "Spell", ID = 6229, useMaxRank = true }),	
	
	-- Buff
	DemonSkin = Action.Create({ Type = "Spell", ID = 687, useMaxRank = true }),	

    -- Potions
    MajorManaPotion = Action.Create({ Type = "Potion", ID = 13444 }),
	MajorHealingPotion = Action.Create({ Type = "Potion", ID = 13446 }),
	
    -- Trinkets 
    -- TalismanofEphemeralPower                = Action.Create({ Type = "Trinket",          ID = 18820                                                                }), -- not used in APL but can Queue 
    -- ZandalarianHeroCharm                    = Action.Create({ Type = "Trinket",          ID = 19950                                                                }), -- not used in APL but can Queue 

}    
local A = setmetatable(Action[Action.PlayerClass], { __index = Action })

-- For racials use following values as Key from racial key:
local RacialKeys = {
	NightElf = "Shadowmeld",
	Human = "Perception",
	Gnome = "EscapeArtist",
	Dwarf = "Stoneform",
	Scourge = "WilloftheForsaken",
	Troll = "Berserking",
	Tauren = "WarStomp",
	Orc = "BloodFury",
}

-- Local used to check immunities
local Temp                                  = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
}

local function HandlePetChoice()
    local choice = Action.GetToggle(2, "PetChoice")
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
HandlePetChoice = Action.MakeFunctionCachedDynamic(HandlePetChoice)

local function HandleCurseChoice()
    local choice = Action.GetToggle(2, "CurseChoice")
    
    return choice
end
HandleCurseChoice = Action.MakeFunctionCachedDynamic(HandleCurseChoice)

-- Defensives abilities
local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    -- FeignDeath on large burst damage
	
	-- Get the FeignDeath setting from ProfileUI : FeignDeathHP
    --[[ local FeignDeath = A.GetToggle(2, "FeignDeathHP")
    if     FeignDeath >= 0 and A.FeignDeath:IsReady("player") and
    (
        (     -- Auto 
            FeignDeath >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 3 or 
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
            FeignDeath < 100 and 
            Unit("player"):HealthPercent() <= FeignDeath
        )
    ) 
    then 
        return A.FeignDeath
    end ]]--
    
 
end 
SelfDefensives = Action.MakeFunctionCachedDynamic(SelfDefensives)

-- Interrupts
local function Interrupts(unit)
    local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")
    -- Your interrupt
  --  if useKick and A.YourInterruptSpell:IsReady(unit) and A.YourInterruptSpell:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then 
  --      if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then 
	--	    return A.YourInterruptSpel
  --      end			
  --  end 
     -- Your CC
   -- if useCC and A.YourCCSpell:IsReady(unit) and A.YourCCSpell:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then 
   --     if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then 
	--	    return A.YourCCSpell
   --     end			
   -- end 	
    
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
Interrupts = Action.MakeFunctionCachedDynamic(Interrupts)


-- [3] Rotation 
A[3] = function(icon)
    local combatTime       = Unit("player"):CombatTime()
    local inCombat         = combatTime > 0
    local inRaidPvE        = TeamCache.Friendly.Type == "raid" and not A.IsInPvP
    local SoulShardsCount = GetItemCount(6265)
	
	
	local function PreBuff(unit)
		-- Initialize Pet Choice handler
		HandlePetChoice()
    	-- Pet Selection Menu
    	local PetSpell = HandlePetChoice()    
    	if PetSpell == "IMP" then
       		--print("IMP")
        	SummonPet = A.SummonImp    
    	elseif PetSpell == "VOIDWALKER" then
       		--print("VOIDWALKER")
        	SummonPet = A.SummonVoidwalker
    	elseif PetSpell == "FELHUNTER" then 
       		--print("FELHUNTER")    
        	SummonPet = A.SummonFelhunter
    	elseif PetSpell == "SUCCUBUS" then 
       		--print("SUCCUBUS")    
       		SummonPet = A.SummonSuccubus
    	else
        	print("No Pet Data")
    	end	
	
		-- Summon Pet if missing 
    	if SummonPet:IsReady("player") and not Pet:IsActive() and not SummonPet:IsSpellLastGCD() then
        	return SummonPet:Show(icon)
    	end
    end	

    -- Precombat SoulFire
    if not inCombat and A.IsUnitEnemy("target") then
        if A.SoulFire:IsReady(unit) and SoulShardsCount > 0 then
	        return A.SoulFire:Show(icon)
	    else 
	        if A.ShadowBolt:IsReady(unit) then 
                return A.ShadowBolt:Show(icon)
            end 
        end 
    end		
	
	-- DPS Rotation
    local function DamageRotation(unit)
        
        -- Interrupts
        --local Interrupt = Interrupts(unit)
        --if Interrupt then 
        --    return Interrupt:Show(icon)
        --end	
		-- Initialize Curse Choice handler
		HandleCurseChoice()
    	-- Curse Selection Menu
    	local CurseSpell = HandleCurseChoice()    
    	if CurseSpell == "CurseofWeakness" then
        	--print("IMP")
        	SelectedCurse = A.CurseofWeakness    
    	elseif CurseSpell == "CurseofAgony" then
        	--print("VOIDWALKER")
        	SelectedCurse = A.CurseofAgony
    	elseif CurseSpell == "CurseofRecklessness" then 
        	--print("FELHUNTER")    
        	SelectedCurse = A.CurseofRecklessness
    	elseif CurseSpell == "CurseofTongues" then 
        	--print("SUCCUBUS")    
        	SelectedCurse = A.CurseofTongues
    	elseif CurseSpell == "CurseoftheElements" then 
        	--print("SUCCUBUS")    
        	SelectedCurse = A.CurseoftheElements
    	elseif CurseSpell == "CurseofShadow" then 
        	--print("SUCCUBUS")    
        	SelectedCurse = A.CurseofShadow
    	else
        	print("No Curse Selected")
    	end	
	
		
		-- Apply Corruption if allowed
        if A.Corruption:IsReady(unit) and not A.Corruption:IsSpellLastGCD() and Action.GetToggle(2, "CorruptionAllow") and (Unit(unit):HasDeBuffs(A.Corruption.ID, true) == 0 or Unit(unit):HasDeBuffs(A.Corruption.ID, true) <= Unit(unit):CastTime(A.Corruption.ID)) then 
            return A.Corruption:Show(icon)
        end 
		-- Immolate
        if A.Immolate:IsReady(unit) and not A.Immolate:IsSpellLastGCD() and (Unit(unit):HasDeBuffs(A.Corruption.ID, true) > 0 or not Action.GetToggle(2, "CorruptionAllow"))  and (Unit(unit):HasDeBuffs(A.Immolate.ID, true) == 0 or Unit(unit):HasDeBuffs(A.Immolate.ID, true) <= Unit(unit):CastTime(A.Immolate.ID)) then 
            return A.Immolate:Show(icon)
        end 
		
		-- Curse to Apply depending on user choice
		-- Apply your assigned curse ( Curse of the Elements,  Curse of Shadow,  Curse of Recklessness)
        if SelectedCurse:IsReady(unit) and not SelectedCurse:IsSpellLastGCD() and SelectedCurse:IsSpellLearned() then 
            return SelectedCurse:Show(icon)
        end 	

		-- Conflagrate
        if A.Conflagrate:IsReady(unit) and not A.Conflagrate:IsSpellLastGCD() then 
            return A.Conflagrate:Show(icon)
        end 

		-- SiphonLife
        if A.SiphonLife:IsReady(unit) and not A.SiphonLife:IsSpellLastGCD() and not IsInRaid() then 
            return A.SiphonLife:Show(icon)
        end 		
		
		-- Cast Shadow Bolt as filler 
        if A.ShadowBolt:IsReady(unit) then 
            return A.ShadowBolt:Show(icon)
        end 
        
    end 
	
    -- Defensive
   -- local SelfDefensive = SelfDefensives()
   -- if SelfDefensive then 
   --     return SelfDefensive:Show(icon)
   -- end
   
    if not Pet:IsActive() then 
        return PreBuff("target")
    --elseif A.IsUnitFriendly("target") then
    --    return Friendly("target")
    end 

    if A.IsUnitEnemy("mouseover") then 
        return DamageRotation("mouseover")
    --elseif A.IsUnitFriendly("mouseover") then 
    --    return Friendly("mouseover")
    end 
    
    if A.IsUnitEnemy("target") then 
        return DamageRotation("target")
    --elseif A.IsUnitFriendly("target") then
    --    return Friendly("target")
    end  
    
end 