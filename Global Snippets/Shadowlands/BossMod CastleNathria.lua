local TMW                                   = TMW
local _G, pairs, type, table, string, error = _G, pairs, type, table, string, error	  
local format						        = string.format	 
local tremove						        = table.remove 	  
local tinsert						        = table.insert 	  
local hooksecurefunc				        = _G.hooksecurefunc	  
local TMW 							        = _G.TMW 
local A	 							        = _G.Action
local DBM 							        = _G.DBM
local BigWigsLoader					        = _G.BigWigsLoader
local A                         			= _G.Action
local TeamCache								= A.TeamCache
local EnemyTeam								= A.EnemyTeam
local FriendlyTeam							= A.FriendlyTeam
local LoC									= A.LossOfControl
local Player								= A.Player 
local MultiUnits							= A.MultiUnits
local UnitCooldown							= A.UnitCooldown
local HealingEngine                         = A.HealingEngine
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local toStr                     			= A.toStr
local toNum                     			= A.toNum
local Toaster                               = _G.Action.Toaster 
local GetSpellTexture                       = _G.TMW.GetSpellTexture
local next, print                           = next, print
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

-- Registers specific BossMods toast
Toaster:Register("TR_BossMods", function(toast, ...)
	local title, message, spellID = ...
	toast:SetTitle(title or "nil")
	toast:SetText(message or "nil")
	if spellID then 
		if type(spellID) ~= "number" then 
			error(tostring(spellID) .. " (spellID) is not a number for 'MyOwnToast'!")
			toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
		else 
			toast:SetIconTexture((GetSpellTexture(spellID)))
		end 
	else 
		toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
	end 
	toast:SetUrgencyLevel("high") 
end)

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
		ShouldCCAdds = false,
		DeathlyRoarTimeToCast = 9999999,
		BurstHeal = false,
		IncomingAdds = false,
		IncomingAddsTime = 9999999,
	},
    HungeringDestroyer = {
        GluttonousMiasmaUnit = "", -- need to Ask Ayni
		ConsumeTimeToCast = 9999999,
		IncomingRaidDamage = false,
		DesolateTimeToCast = 9999999,
		IsInDanger = false,
		Overwhelm = 9999999,
	},
    ArtificerXyMox = {
	    BurstHeal = false,
		Hyperlight = 9999999,
		DimensionalTearUnit = false,

	},
    LadyInvervaDarkvein = {

	},
    TheCouncilofBlood = {

	},
    Sludgefist = {

	},
    StoneborneGenerals = {

	},
    SireDenathrius = {

	},
}

-- Castle Nathria API
-- Provide several informations about incoming fights events 
-- @usage: TR.BossMods.CastleNathria(icon, unit) call inside A[3] 
-- @return: real time updated Global Vars like TR.BossMods.Shriekwing.IsSanguineCurse 
-- @todo: change global vars to local vars inside rotation. 
function TR.BossMods.CastleNathria(icon, unit)

    -- local vars
    local _, Event, _, SourceGUID, _, SourceFlags, _, DestGUID, DestName, DestFlags,_, SpellID, SpellName = CombatLogGetCurrentEventInfo()
	local UseBossMods = A.GetToggle(1, "BossMods")
    local getmembersAll = A.HealingEngine.GetMembersAll()
	
	-- Ensure DBM is activated and check for Bigwigs
	if not DBM and BigWigsLoader then
	    A.Print("It seems you are using Bigwigs.\nNot all the raid events prediction will work cause DBM addon is needed to 100% compatibility.\nYou can still install DBM in addition to Bigwigs and disable DBM bars.")
	end
	
	-- Check if setting is activated in UI 
	-- Since not all API is DBM based, we dont need to check if DBM addon is enabled. User already informed that it may have bug with BW only
    if UseBossMods then
	
		--------------
        -- Shriekwing
		--------------
		
        -- Exsanguinated - major healing cooldowns
		local ExsanguinatedDebuffTime, ExsanguinatedUnitID = FriendlyTeam():GetDeBuffs(328897, true) 
		if ExsanguinatedDebuffTime > 0 and Unit("player"):HealthPercent() < 70 -- Reduced healing and low HP
		then
            TR.BossMods.Shriekwing.ExsanguinatedUnit = ExsanguinatedUnitID
			-- Set Target if we are healer
			if Unit("player"):IsHealer() then
			    HealingEngine.SetTarget(ExsanguinatedUnitID, 2)				
			end
		else
		    TR.BossMods.Shriekwing.ExsanguinatedUnit = ""
		end	

        -- Sanguine Curse (Mythic)
		local SanguineCurse = A.BossMods:GetTimer(336338) 
        if SanguineCurse > 0 and SanguineCurse <= 5 then -- Apply sanguine curse that can be dispelled but not instantly cause it leave a pool after dispell or expiration. Blacklist or Delay
            TR.BossMods.Shriekwing.IsSanguineCurse = true -- Do not dispell
		else
		    TR.BossMods.Shriekwing.IsSanguineCurse = false
		end

		-- Earsplitting Shriek - Minor healing cooldowns
        if Event == "SPELL_CAST_START" and SpellID == 334708 then
            TR.BossMods.Shriekwing.EarsplittingShriek = 6 -- initiate the 6sec cast time 
		else
		    TR.BossMods.Shriekwing.EarsplittingShriek = 9999999
		end	

        -- Dark Descent
		local DarkDescent = A.BossMods:GetTimer(336235)
        if DarkDescent > 0 and DarkDescent <= 2 and Unit("boss1"):GetRange() < 7 then -- Boss jumping to a position and inflicting 10yards aoe damage then jump back to original position and inflict again 10 yards aoe damage
            TR.BossMods.Shriekwing.IsInDanger = true
		else
		    TR.BossMods.Shriekwing.IsInDanger = false
		end
		
        -- Deadly Descent (damage x3 as above) (predict healers)
		local DeadlyDescent = A.BossMods:GetTimer(329370)
        if DeadlyDescent > 0 and DeadlyDescent <= 2 and Unit("boss1"):GetRange() < 7 then -- Boss jumping to a position and inflicting 12yards aoe damage then jump back to original position and inflict again 12 yards aoe damage
            TR.BossMods.Shriekwing.IsInDanger = true
		else
		    TR.BossMods.Shriekwing.IsInDanger = false
		end
		
        -- Earsplitting Shriek (mythic)
		local EarsplittingShriek = A.BossMods:GetTimer(330711)
        if EarsplittingShriek > 0 and EarsplittingShriek <= 2 and not Unit("boss1"):InLOS() then -- Boss jumping to a position and inflicting 10yards aoe damage then jump back to original position and inflict again 10 yards aoe damage
            TR.BossMods.Shriekwing.IsInDanger = true
		else
		    TR.BossMods.Shriekwing.IsInDanger = false
		end

        -- Sonar Shriek
		local SonarShriek = A.BossMods:GetTimer(340047)
        if SonarShriek > 0 and SonarShriek <= 2 and not Unit("boss1"):InLOS() then -- Boss sonar detection if in line of sight
            TR.BossMods.Shriekwing.IsInDanger = true
		else
		    TR.BossMods.Shriekwing.IsInDanger = false
		end

        -- Dark Descent
		local DarkDescent = A.BossMods:GetTimer(336235)
        if DarkDescent > 0 and DarkDescent <= 2 and Unit("boss1"):GetRange() < 7 then -- Boss jumping to a position and inflicting 10yards aoe damage then jump back to original position and inflict again 10 yards aoe damage
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
		
		-- Tank Jagged Claws (use also for healers to predict incoming damage)
		if Unit("player"):IsTank() and Unit("player"):HasDeBuffsStacks(334971, true) > 0 -- Direct Damage + bleed effect, can stack
		then
            TR.BossMods.AltimortheHuntsman.IsInDanger = true
		else
		    TR.BossMods.AltimortheHuntsman.IsInDanger = false
		end

		-- Shade of bargast incoming time
		local ShadeofBargast = A.BossMods:GetTimer(334757)
        if ShadeofBargast > 0 and ShadeofBargast <= 10 then -- Create a soul of a random player that need to be healed asap
            TR.BossMods.AltimortheHuntsman.IncomingAdds = true
			TR.BossMods.AltimortheHuntsman.IncomingAddsTime = ShadeofBargast
		else
		    TR.BossMods.AltimortheHuntsman.IncomingAdds = false
		    TR.BossMods.AltimortheHuntsman.IncomingAddsTime = 9999999
		end		

        -- Shade-of-bargast npcid PRIO TARGET 
        for unit in pairs(ActiveUnitPlates) do 
			if Unit(unit):NPCID() == 171557 then
			    -- auto target
			    if not UnitIsUnit("target", unit) then
				    TR.BossMods.AltimortheHuntsman.PrioAddsTargetting = true
			   	    return A:Show(icon, ACTION_CONST_AUTOTARGET)
				else
				    TR.BossMods.AltimortheHuntsman.PrioAddsTargetting = false
				end
				-- (100% increased damage per stacks if add is in cc)
				if Unit(unit):InCC() < A.GetGCD() then
				    TR.BossMods.AltimortheHuntsman.ShouldCCAdds = true
			    else				        
				    TR.BossMods.AltimortheHuntsman.ShouldCCAdds = false
			    end
		    end 
		end 
		
		-- Deathly Roar (big aoe for all raid)		
        if Event == "SPELL_CAST_START" and SpellID == 334708 then
            TR.BossMods.AltimortheHuntsman.DeathlyRoarTimeToCast = 6 -- initiate the 6sec cast time https://ptr.wowhead.com/spell=334708
		else
		    TR.BossMods.AltimortheHuntsman.DeathlyRoarTimeToCast = 9999999
		end		
		
		-- Rip Soul
		local RipSoul = A.BossMods:GetTimer(334797)
        if RipSoul > 0 and RipSoul <= A.GetGCD() then -- Create a soul of a random player that need to be healed asap
            TR.BossMods.AltimortheHuntsman.BurstHeal = true
		else
		    TR.BossMods.AltimortheHuntsman.BurstHeal = false
		end		
		
		--------------
        -- Hungering Destroyer
        --------------
		
        -- Gluttonous Miasma (blacklist non healable units)	
		local GluttonousMiasmaDebuffTime, GluttonousMiasmaUnitID = FriendlyTeam():GetDeBuffs(329298, true)
		if GluttonousMiasmaDebuffTime > 0 -- 100% Healing immune and dot
		then
            TR.BossMods.HungeringDestroyer.GluttonousMiasmaUnit = GluttonousMiasmaUnitID
		else
		    TR.BossMods.HungeringDestroyer.GluttonousMiasmaUnit = "" -- need to Ask Ayni
		end
		
		-- Essence Sap
		local EssenceSap = Unit("player"):HasBuffs(334755, true)
		if EssenceSap > 0 -- 100% Healing immune and dot
		then
            Action.Toaster:Spawn("TR_BossMods", "Warning", "Essence Sap debuff detected on you.\nSPREAD NOW or you will die !", 334755)
		end
		
		-- Consume (aoe raid damage) - major cooldowns
        if Event == "SPELL_CAST_START" and SpellID == 334522 then
            TR.BossMods.HungeringDestroyer.ConsumeTimeToCast = 2 -- initiate the 2sec cast time to heal prediction
		else
		    TR.BossMods.HungeringDestroyer.ConsumeTimeToCast = 9999999
		end	
		
		-- Boss High Energy
		if Unit("boss1"):Energy() >= 85 then
		    TR.BossMods.HungeringDestroyer.IncomingRaidDamage = true
		end
		
		-- Desolate (aoe raid damage) - minor cooldowns
        if Event == "SPELL_CAST_START" and SpellID == 329455 then
            TR.BossMods.HungeringDestroyer.DesolateTimeToCast = 3 -- initiate the 2sec cast time to heal prediction
		else
		    TR.BossMods.HungeringDestroyer.DesolateTimeToCast = 9999999
		end	
		
		-- Expunge (spread from other)
		local Expunge = Unit("player"):HasBuffs(329725, true)
		if Expunge > 0 -- 100% Healing immune and dot
		then
            Action.Toaster:Spawn("TR_BossMods", "Warning", "Expunge debuff detected on you.\nSPREAD NOW !", 334755)
		end
		
		-- Growing Hunger (Tank debuff)
		if Unit("player"):IsTank() and Unit("player"):HasDeBuffsStacks(332295, true) > 2 -- damage of Hungering Strikes is increased by 8%. This effect stacks.
		then
            TR.BossMods.HungeringDestroyer.IsInDanger = true 
		else
		    TR.BossMods.HungeringDestroyer.IsInDanger = false
		end	
		
		-- Overwhelm (tank damage prediction or mitigation)
        if Event == "SPELL_CAST_START" and SpellID == 329774 then
            TR.BossMods.HungeringDestroyer.Overwhelm = 2 -- initiate the 2sec cast time to heal prediction
		else
		    TR.BossMods.HungeringDestroyer.Overwhelm = 9999999
		end	
				
		--------------
        -- Artificer Xy'Mox
		--------------
		
        -- Dimensional Tear - Mythic ? (aoe raid damage after when debuff fade)
		local DimensionalTearDebuffTime, DimensionalTearUnitID = FriendlyTeam():GetDeBuffs(328437, true) -- not sure about spellid 
		if DimensionalTearDebuffTime > 0 -- 100% Healing immune and dot
		then
            TR.BossMods.ArtificerXyMox.DimensionalTearUnit = DimensionalTearUnitID
		else
		    TR.BossMods.ArtificerXyMox.DimensionalTearUnit = "" -- need to Ask Ayni
		end		

        -- Hyperlight Spark ( jumps between all players, inflicting aoe Arcane damage.)
        if Event == "SPELL_CAST_START" and SpellID == 325399 then
            TR.BossMods.ArtificerXyMox.HyperlightSparkTimeToCast = 0.5 + A.GetGCD() -- initiate the 0.5sec + gcd cast time to heal prediction
			TR.BossMods.ArtificerXyMox.BurstHeal = true
			TR.BossMods.ArtificerXyMox.CanPreHeal = true
		else
		    TR.BossMods.ArtificerXyMox.HyperlightSparkTimeToCast = 9999999
			TR.BossMods.ArtificerXyMox.BurstHeal = false
			TR.BossMods.ArtificerXyMox.CanPreHeal = false
		end			
				
		-- Glyph of Destruction Mythic Tank mechanic, apply a debuff on tank that explode after 4sec, damage reduced the more we are far from raid
		-- Allow fast speed if we are tank
		if Unit("player"):IsTank() and Unit("player"):HasBuffs(325236, true) > 0 and Unit("player"):HasBuffs(325236, true) < 3 then
		    TR.BossMods.ArtificerXyMox.UseMoveSpeed = true
		else
			TR.BossMods.ArtificerXyMox.UseMoveSpeed = false
		end
		-- Then check for all raid if we are healer and preheal before damage occur
    	if Unit("player"):IsHealer() and getmembersAll then
			for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasDeBuffs(325236, true) > 0 then  
			        HealingEngine.SetTarget(getmembersAll[i].Unit)                  										
                end				
            end
        end
        
		-- Possession - Mythic 
		local PossessionDebuffTime, PossessionUnitID = FriendlyTeam():GetDeBuffs(327414, true) 
		if PossessionDebuffTime > 0 -- (mind controlled players that were hit by spirit need to be prio target)
		then
            TR.BossMods.ArtificerXyMox.PossessionUnit = PossessionUnitID
			if not UnitIsUnit("target", PossessionUnitID) then
			    return A:Show(icon, ACTION_CONST_AUTOTARGET)
			end
		else
		    TR.BossMods.ArtificerXyMox.PossessionUnit = "" -- need to Ask Ayni
		end	

		
		--------------
        -- Sun King's Salvation
        --------------
				
		-- Burning Remnants - Tank fire dot stackable
		if Unit("player"):IsTank() and Unit("player"):HasDeBuffsStacks(326456, true) > 3 then
		    TR.BossMods.SunKingsSalvation.NeedMitigation = true
			else
			TR.BossMods.SunKingsSalvation.NeedMitigation = false
		end
		
		-- Cloak of Flame DMG mythic (burst damage boss to remove his absorb and then interrupt his 6sec cast else it will oneshot raid)
		if not Unit("player"):IsHealer() and Unit("boss1"):HasBuffs(343026, true) > 0 then
		    -- TR.BossMods.SunKingsSalvation.PrioTargetting = true
			if not UnitIsUnit("target", "boss1") then
			    return A:Show(icon, ACTION_CONST_AUTOTARGET)
			end
		end		

		-- Cloak of Flame HEAL mythic (burst heal boss to remove his absorb and then interrupt his 6sec cast else it will oneshot raid)
		if Unit("player"):IsHealer() and Unit("boss1"):HasBuffs(338600, true) > 0 then
		    -- TR.BossMods.SunKingsSalvation.PrioTargetting = true
			if not UnitIsUnit("target", "boss1") then
			    --return A:Show(icon, ACTION_CONST_AUTOTARGET)
				Action.Toaster:Spawn("TR_BossMods", "Warning", "TARGET BOSS NOW TO BURST HEAL SHIELD", 338600)
			end
		end	

        -- Reborn Phoenix npcid PRIO TARGET 
        for unit in pairs(ActiveUnitPlates) do 
			if Unit(unit):NPCID() == 168962 then
			    -- auto target
			    if not UnitIsUnit("target", unit) then
				    TR.BossMods.SunKingsSalvation.PrioAddsTargetting = true
			   	    return A:Show(icon, ACTION_CONST_AUTOTARGET)
				else
				    TR.BossMods.SunKingsSalvation.PrioAddsTargetting = false
				end
		    end 
		end 

		-- Vanquished - Tank physical bleed stackable
		if Unit("player"):IsTank() and Unit("player"):HasDeBuffsStacks(325442, true) > 3 then
		    TR.BossMods.SunKingsSalvation.NeedMitigation = true
			else
			TR.BossMods.SunKingsSalvation.NeedMitigation = false
		end
		
		-- Infuser's Boon - Increase healing done for player by 50% (mythic)
		if Unit("player"):IsHealer() and Unit("player"):HasBuffs(326078, true) > 0 then
		    TR.BossMods.SunKingsSalvation.IncreasedHealing = true
		else
		    TR.BossMods.SunKingsSalvation.IncreasedHealing = false
		end			

        -- Ember Blast (aoe damage) minor cooldowns
        if Event == "SPELL_CAST_START" and SpellID == 325877 then
            TR.BossMods.SunKingsSalvation.EmberBlastTimeToCast = 5 -- initiate the 5sec cast time to heal prediction
		else
		    TR.BossMods.SunKingsSalvation.EmberBlastTimeToCast = 9999999
		end		

        -- Concussive Smash (aoe damage) minor cooldowns - prehot
        if Event == "SPELL_CAST_START" and SpellID == 325506 then
            TR.BossMods.SunKingsSalvation.CanPreHeal = true
		else
		    TR.BossMods.SunKingsSalvation.CanPreHeal = false
		end				

    	-- Bulgar Brand - Dispel Sniper
		-- Todo : Add dispell IsReady check for all specs
     	if Unit("player"):IsHealer() and getmembersAll then
			for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasDeBuffs(333002, true) > 0 then  
			        HealingEngine.SetTarget(getmembersAll[i].Unit)                  										
                end				
            end
        end
		
        --------------
        -- Lady Inerva Darkvein
        --------------	
		
		-- Boss High Energy - AoE raid damage on 100% energy
		if Unit("boss1"):Energy() >= 98 then
		    TR.BossMods.LadyInervaDarkvein.IncomingRaidDamage = true
		else
		    TR.BossMods.LadyInervaDarkvein.IncomingRaidDamage = false
		end		
		
		-- Loose Anima -  Shadow damage to all players every 1 sec
     	if Unit("player"):IsHealer() and getmembersAll then
			for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):HasDeBuffs(333002, true) > 0 then  
			        HealingEngine.SetTarget(getmembersAll[i].Unit)                  										
                end				
            end
        end	
		
		
		
		--------------
        -- The Council of Blood
		--------------
		
        --------------
        -- Sludgefist
        --------------
		
		--------------
        -- Stoneborne Generals
		--------------
		
        --------------
        -- Sire Denathrius
		--------------
		
		
		
		
		
	end
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


