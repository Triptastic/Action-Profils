local TMW                                   = TMW
local _G, type, error, time     			= _G, type, error, time
local A                         			= _G.Action
local TeamCache								= A.TeamCache
local EnemyTeam								= A.EnemyTeam
local FriendlyTeam							= A.FriendlyTeam
local LoC									= A.LossOfControl
local Player								= A.Player 
local MultiUnits							= A.MultiUnits
local UnitCooldown							= A.UnitCooldown
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local toStr                     			= A.toStr
local toNum                     			= A.toNum
local LibToast                              = LibStub("LibToast-1.0")
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitLevel, UnitPower, UnitPowerMax, UnitStagger, UnitAttackSpeed, UnitRangedDamage, UnitDamage, UnitAura = UnitLevel, UnitPower, UnitPowerMax, UnitStagger, UnitAttackSpeed, UnitRangedDamage, UnitDamage, UnitAura
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
--local Pet                                 = LibStub("PetLibrary") Don't work. Too fast loading snippets ?
local Unit                                  = A.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local EventFrame                            = CreateFrame("Frame", "Taste_EventFrame", UIParent)
local UnitIsUnit                            = UnitIsUnit
local StdUi                                 = A.StdUi -- Custom StdUI with Action shared settings
-- Lua methods
local error                                 = error
local setmetatable 						    = setmetatable
local stringformat 						    = string.format
local stringfind                            = string.find
local stringsub                             = string.sub
local tableinsert 						    = table.insert
local tableremove							= table.remove 
local TR                                    = Action.TasteRotation



------------------------------------------
-- Castle Nathria DeadlyBossMods timers --
------------------------------------------

-- global vars
TR.BossMods = {
    Shriekwing = {
	    TransitionIncoming = false,
		IsInDanger = false,
		IsSanguineCurse = false,
	},
    AltimortheHuntsman = {
	    IsInDanger = false,
		PrioAddsTargetting = false,
	}


}

-- core
function TR.BossMods.CastleNathria()
    
	--------------
    -- Shriekwing
	--------------
	
    -- Exsanguinated
	local Exsanguinated = A.BossMods:GetTimer(328897)
    if (Exsanguinated > 0 and Exsanguinated <= 1 or Unit("player"):HasBuffs(328897, true) > 0) and Unit("player"):HealthPercent() < 50 then -- Reduced healing
        TR.BossMods.Shriekwing.IsInDanger = true 
	else
	    TR.BossMods.Shriekwing.IsInDanger = false
	end

    -- Sanguine Curse (Mythic)
	local SanguineCurse = A.BossMods:GetTimer(336338) 
    if SanguineCurse > 0 and SanguineCurse <= 5 then -- Apply sanguine curse that can be dispelled but not instantly cause it leave a pool after dispell or expiration. Blacklist or Delay
        TR.BossMods.Shriekwing.IsSanguineCurse = true -- Do not dispell
	else
	    TR.BossMods.Shriekwing.IsSanguineCurse = false
	end

    -- Dark Descent
	local DarkDescent = A.BossMods:GetTimer(336235)
    if DarkDescent > 0 and DarkDescent <= 2 and Unit("boss"):GetRange() < 7 then -- Boss jumping to a position and inflicting 10yards aoe damage then jump back to original position and inflict again 10 yards aoe damage
        TR.BossMods.Shriekwing.IsInDanger = true
	else
	    TR.BossMods.Shriekwing.IsInDanger = false
	end
	
    -- Deadly Descent (damage x3 as above)
	local DeadlyDescent = A.BossMods:GetTimer(329370)
    if DeadlyDescent > 0 and DeadlyDescent <= 2 and Unit("boss"):GetRange() < 7 then -- Boss jumping to a position and inflicting 12yards aoe damage then jump back to original position and inflict again 12 yards aoe damage
        TR.BossMods.Shriekwing.IsInDanger = true
	else
	    TR.BossMods.Shriekwing.IsInDanger = false
	end
	
    -- Earsplitting Shriek (mythic)
	local EarsplittingShriek = A.BossMods:GetTimer(330711)
    if EarsplittingShriek > 0 and EarsplittingShriek <= 2 and not Unit("boss"):InLOS() then -- Boss jumping to a position and inflicting 10yards aoe damage then jump back to original position and inflict again 10 yards aoe damage
        TR.BossMods.Shriekwing.IsInDanger = true
	else
	    TR.BossMods.Shriekwing.IsInDanger = false
	end

    -- Sonar Shriek
	local SonarShriek = A.BossMods:GetTimer(340047)
    if SonarShriek > 0 and SonarShriek <= 2 and not Unit("boss"):InLOS() then -- Boss sonar detection if in line of sight
        TR.BossMods.Shriekwing.IsInDanger = true
	else
	    TR.BossMods.Shriekwing.IsInDanger = false
	end

    -- Dark Descent
	local DarkDescent = A.BossMods:GetTimer(336235)
    if DarkDescent > 0 and DarkDescent <= 2 and Unit("boss"):GetRange() < 7 then -- Boss jumping to a position and inflicting 10yards aoe damage then jump back to original position and inflict again 10 yards aoe damage
        TR.BossMods.Shriekwing.IsInDanger = true
	else
	    TR.BossMods.Shriekwing.IsInDanger = false
	end	
	
	-- Bloodgorge Transition Phase2
	local Bloodgorge = A.BossMods:GetTimer(328921)
    if Bloodgorge > 0 and Bloodgorge <= 10 then -- Stage 2 detected in 10sec
        TR.BossMods.Shriekwing.TransitionIncoming = true
	else
	    TR.BossMods.Shriekwing.TransitionIncoming = false
	end
	
    --------------
    -- Altimor the Huntsman
    --------------
	
	-- Tank Jagged Claws
	if Unit("player"):IsTank() and Unit("player"):HasDeBuffsStacks(334971, true) > 10 -- Direct Damage + bleed effect, can stack
	then
        TR.BossMods.AltimortheHuntsman.IsInDanger = true
	else
	    TR.BossMods.AltimortheHuntsman.IsInDanger = false
	end

    -- Shade-of-bargast npcid PRIO TARGET
    for unit in pairs(ActiveUnitPlates) do 
		if Unit(unit):NPCID() == 171557 and not UnitIsUnit("target", unit) then 
			TR.BossMods.AltimortheHuntsman.PrioAddsTargetting = true
		else
		    TR.BossMods.AltimortheHuntsman.PrioAddsTargetting = false
	    end 
	end 
	
    -- Hungering Destroyer

    -- Kael'thas Sunstrider

    -- Artificer Xy'Mox

    -- Lady Inverva Darkvein

    -- The Council of Blood

    -- Sludgefist

    -- Stoneborne Generals

    -- Sire Denathrius
end



------------------------------------------------
-- ShadowLands Dungeons DeadlyBossMods timers --
------------------------------------------------

-- De Other Side

-- Halls of Atonement

-- Mists of Tirna Scithe

-- Necrotic Wake

-- Plaguefall

-- Sanguine Depths

-- Spires of Ascension

-- Theater of Pain


