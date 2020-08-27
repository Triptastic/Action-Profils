---------------------------------------------------
------------ CUSTOM CHANGELOG FUNCTIONS -----------
---------------------------------------------------
local TMW                                   = TMW
local A     								= Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local UnitIsUnit                            = UnitIsUnit
local StdUi 								= LibStub("StdUi")
-- Lua
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert
local TR                                    = Action.TasteRotation

-------------------------------------------------------------------------------
-- Profil Loader
-------------------------------------------------------------------------------
-- Load default profils for each class
local currentClass = select(2, UnitClass("player"))
local currentSpec = GetSpecialization()
local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"

-- Druid
if currentClass == "WARRIOR" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warrior"
end

-- Warlock
if currentClass == "WARLOCK" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warlock"
end

-- Rogue
if currentClass == "ROGUE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Rogue"
end

-- Shaman
if currentClass == "SHAMAN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Shaman"
end

-- DeathKnight
if currentClass == "DEATHKNIGHT" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Death Knight"
end

-- Priest
if currentClass == "PRIEST" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Priest"
end

-- Paladin
if currentClass == "PALADIN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Paladin"
end

-- Mage
if currentClass == "MAGE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Mage"
end

-- Hunter
if currentClass == "HUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Hunter"
end

-- Demon Hunter
if currentClass == "DEMONHUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Demon Hunter"
end

-- Druid
if currentClass == "DRUID" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Druid"
end



--------------------------------------
--------- POPUP/CHANGELOG API --------
--------------------------------------
-- Return a popup message on player login that show all the latest change for rotations. 
-- Each classes got a ProfileUI button to enable/disable this option. (In case of Streaming)

-- Init popup
TR.Popup = {
    popupname = Action.PlayerSpec,
    message = "",
	button1 = "",
	button2 = "",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,	
}

-- Popup Creation function.
-- @Return string depending of current player specialization
-- @Usage TR:CreatePopup(PlayerSpec, TR.PlayerSpec.Changelog, "OK", nil, 0, true, true)
function TR:CreatePopup(popupname, message, button1, button2, timeout, whileDead, hideOnEscape)
    local Errormessage = "Error on popup : You did not set any message."
    local Errorbutton = "Cancel"
	--local PlayerSpec = Action.PlayerSpec
	
	if popupname then
	    TR.Popup.popupname = popupname
	else
	    TR.Popup.popupname = 999
	end
	
	if message then 
	    TR.Popup.message = message
	else
	    TR.Popup.message = Errormessage
	end
	
	if button1 then
	    TR.Popup.button1 = button1
	else
	    TR.Popup.button1 = Errorbutton
	end
	
	if button2 then
	    TR.Popup.button2 = button2
	else
	    TR.Popup.button2 = Errorbutton
	end	
	
	if timeout then 
	    TR.Popup.timeout = timeout
	else
	    TR.Popup.timeout = 0
	end
	
	if whileDead then
	    TR.Popup.whileDead = whileDead
	end
	
	if hideOnEscape then
	    TR.Popup.hideOnEscape = hideOnEscape
	end   
	
	return TR.Popup.popupname, TR.Popup.message, TR.Popup.button1, TR.Popup.button2, TR.Popup.timeout, TR.Popup.whileDead, TR.Popup.hideOnEscape
	
end

-- Changelog handler for each specialisation
-- @To do: find a way to improve ingame indentation and presentation
function TR:UpdateChangeLog()
local PlayerSpec = Action.PlayerSpec

--------------------
------ SHAMAN ------
--------------------
	-- Elemental
	if PlayerSpec == 262 then
	    ChangeLog = [[
		Welcome to Taste - Elemental Shaman !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Elemental Blast behavior
- Reworked DBM opener
- Fixed Healing Surge				

As always, please report on Discord or message me directly if you need anything !
]]  

	end	
	-- Enhancement
	if PlayerSpec == 263 then
	    ChangeLog = [[
		Welcome to Taste - Enhancement Shaman !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed some Fury of Air logic (need feedbacks)
- Fixed issue with Tremor Totem logic
- Big UI update
- New UnbridledFury settings
- New Focused Azerite Beam settings
- New buff refresh settings
- New SkyFury settings
- New Feral Lounge settings
- New Counterstrike Totem settings
- Added new conditions on Lavalash
- Malestrom should be more used
- Improved PvP Logics
- Fixed Interrupts
- Added logic for Counter Strike Totem				

As always, please report on Discord or message me directly if you need anything !
]]  

	end
	
	-- Restoration
	if PlayerSpec == 264 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end
	
--------------------
----- PALADIN ------
--------------------	
	-- Retribution
	if PlayerSpec == 70 then
	    ChangeLog = [[
		Welcome to Taste - Retribution Paladin !
		
List of latest changes :

- Fixed bug with Cleanse
- New : Blocked Spells Status Frame (see 2nd tab)
- New UI settings
- Added new condition for Unbridled Fury potion
- Added new condition for Focused Azerite Beam
- Templar Verdict now correctly used if AoE Disabled OR enemies around < 2
- Fixed Wake of Ashes
- Fixed Party Dispell texture icon
- Fixed Divine Storm usage
- Fixed Templar Verdict never used				
- Added Interrupt UI settings

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end
	
	-- Protection
	if PlayerSpec == 66 then
	    ChangeLog = [[
		Welcome to Taste - Protection Paladin !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Auto taunt issue
- Fixed Consecration logic
- Added moves in ProfileUI			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end
	
	-- Holy
	if PlayerSpec == 65 then
	    ChangeLog = [[
		Welcome to Taste - Holy Paladin !
	    
		***** TEST BUILD *****	
		
List of latest changes :

- Lot of optimizations done
- New mythic + logic
- New raid logic
- Lot of new UI settings available
- Improved Glimmer spread
- Added Quaking affix support
- Added Bursting affix support
- Fixed cooldowns logic ? 
- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Auto taunt issue
- Fixed Consecration logic
- Added moves in ProfileUI			

As always, please report on Discord or message me directly if you need anything !
]]  				
	end

--------------------
----- WARLOCK ------
--------------------
	-- Affliction
	if PlayerSpec == 265 then
	    ChangeLog = [[
		Welcome to Taste - Affliction Warlock !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed lua error that stuck the rotation
- Added Player ping to spells prediction
- Fixed Fear spam in certain situations			
- Added Interrupt UI settings

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Demonology
	if PlayerSpec == 266 then
	    ChangeLog = [[
		Welcome to Taste - Demonology Warlock !
		
List of latest changes :

- Added Mortal Coil to spell list
- Added Shadow Fury to spell list (Uncheck auto hide in tab3 if spell don't appear)
- New : Blocked Spells Status Frame (see 2nd tab)
- Added CDs check on Summon Demonic Tyran and big cooldowns >= 2min
- Third version of Imp Tracker system. Now really good ! NO MOAR LUA ERROR
- Fixed issue with DreadStalkers
- Added logic for PvP Fear (arena123)
- Added Auto NetherWard in Arena if dangerous or cc is casted by unit
- Pet Stun should be fixed now
- Added more UI settings for Implosion
- Added multiple range detection mode in ProfileUI		
- Added Interrupt UI settings

IMPORTANT: IF YOU SEE THE ROTATION IS NOT USING IMPLOSION AND YOU GOT SUFFISANT NUMBER OF IMPS THEN TRY A /RELOAD 		

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Destruction
	if PlayerSpec == 267 then
	    ChangeLog = [[
		Welcome to Taste - Destruction Warlock !
		
List of latest changes :

- Fixed double Immolation issue
- Added Check for Immolate and Explosives orbs
- Force Conflagrate on Explosives orbs if ready
- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed the fix for Shards being capped at infinite...
- Reworked AoE logic with Havoc
- Fixed issue with Chaos Bolt not being used with 4+ shards
- Fixed issue with Havoc pool when AoE is off
- Fixed Fear spam issue
- Added Interrupt UI settings

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end	
	


--------------------
----- WARRIOR ------
--------------------
	-- Arms
	if PlayerSpec == 71 then
	    ChangeLog = [[
		Welcome to Taste - Arms Warrior !
		
List of latest changes :

- Damn good optimization from Johan (thanks mate)
- Fixed range check with Whirlwind and Warbreaker 
- Added Smart reflect option 
- Added Smart Stormbolt option
- New : Blocked Spells Status Frame (see 2nd tab)
- Arms still missing some stuff but will be worked hard till its good ! (Feedback me)
- Massive update for 8.3
- Fixed issue with Battle Shout spam			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Fury
	if PlayerSpec == 72 then
	    ChangeLog = [[
		Welcome to Taste - Fury Warrior !
		
List of latest changes :

- Damn good optimization from Johan (thanks mate)
- Added Smart reflect option 
- Added Smart Stormbolt option
- Reimported discord optimized file
- Fixed Stormbolt error
- Adjusted some Rage values thanks to feedback !
- New : Blocked Spells Status Frame (see 2nd tab)
- Better state than Arms (Need feedbacks !)
- Massive update for 8.3
- Fixed issue with Battle Shout spam				

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Protection
	if PlayerSpec == 73 then
	    ChangeLog = [[
		Welcome to Taste - Protection Warrior !
		
List of latest changes :

- Added Smart reflect option 
- Added Smart Stormbolt option
- Added New UI for ShieldBlock
- Fixed issue with ThunderClap and massive haste amount
- New : Blocked Spells Status Frame (see 2nd tab)
- Massive 8.3 update
- Massive UI rework
- Reworked all defensives logic
- Fixed ShieldBlock used twice
- Fixed Rallying Cry issue
- Added UI for Rallying Cry
- Heroic Throw fix
- Victory Rush fix
- Revenge free procs should now work as intended			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
--- DEATHKNIGHT ----
--------------------
	-- Blood
	if PlayerSpec == 250 then
	    ChangeLog = [[
		Welcome to Taste - Blood Death Knight !
		
List of latest changes :

- Smart Asphyxiate in next build (Mythic+)
- New : Blocked Spells Status Frame (see 2nd tab)
- Reworked all defensives logic
- Fixed Auto Taunt
- Fixed Arcane Torrent
- Improved DnD logic
- Added Area Time To Die for better AoE logic
- Improved Death Strike logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Frost
	if PlayerSpec == 251 then
	    ChangeLog = [[
		Welcome to Taste - Frost Death Knight !
		
List of latest changes :

- Smart Asphyxiate in next build (Mythic+)
- New : Blocked Spells Status Frame (see 2nd tab)
- Improvement on Profile performance
- APLs update to 8.3
- Added Dummy Test option
- Reworked Breath of Sindragosa 
- Added new special macro for Breath of Sindragosa
- Fixed Pillar of Frost not being used without Breath of Sindragosa
- Added Memory of Lucid Dream UI
- Reworked Defensives logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Unholy
	if PlayerSpec == 252 then
	    ChangeLog = [[
		Welcome to Taste - Unholy Death Knight !
		
List of latest changes :

- Smart Asphyxiate in next build (Mythic+)
- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed issue with rotation stucked in Mythic+
- Improvement on Profile performance
- APLs update to 8.3
- Added Dummy Test option
- Added PvP Features
- Pet Summon fixed
- Added UI for trinkets
- Fixed Single Target Apocalypse usage		
- Fixed Condensed Life Force logic
- Fixed Scourge Strike usage
- Reworked AoE logic with Feastering Wounds	

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
--- DEMON HUNTER ---
--------------------
	-- Havoc
	if PlayerSpec == 577 then
	    ChangeLog = [[
		Welcome to Taste - Havoc Demon Hunter !
		
List of latest changes :

- Fixed Reaping Flame Essence
- Fixed latency check for channeled spells
- Added missing option for Eyebeam when its totally disabled
- Added special Twisted Appendage tentacles rotation
- Improved ConsumeMagic dispell (should dispell more)
- New : Blocked Spells Status Frame (see 2nd tab)
- Changed priority between Eyebeam and Deathsweep (Little dps increase)
- Added UI for BladeDance pool/sync with Eyebeam
- Added FelEruption + Manarift combo
- Added Imprison + Manarift combo
- Fixed DBM pull opener
- Added UI for Felblade PvP
			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Vengeance
	if PlayerSpec == 581 then
	    ChangeLog = [[
		Welcome to Taste - Vengeance Demon Hunter !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Updated to 8.3 APLs
- Added Imprison as interrupt
- Fixed Concentrated Flame usage			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------ ROGUE -------
--------------------
	-- Assassination
	if PlayerSpec == 259 then
	    ChangeLog = [[
		Welcome to Taste - Assassination Rogue !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Rupture not being refreshed
- Fixed Toxic Blade usage
- Added check on Azerite Beam essence
- Fixed Crimson Tempest talent
- Updated APLs to 8.3
- Added Toxic Blade pool UI settings
- Reworked ST opener			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Outlaw
	if PlayerSpec == 260 then
	    ChangeLog = [[
		Welcome to Taste - Outlaw Rogue !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Arcane Torrent logic
- Improved Profile performance
- Updated APLs to 8.3
- Fixed Auto SAP out of combat
- Update Marked For Death snipping on low health units
- Added BladeFlurry UI settings
- Added check on Azerite Beam essence				

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Subtlety
	if PlayerSpec == 261 then
	    ChangeLog = [[
		Welcome to Taste - Subtely Rogue !
		
List of latest changes :

- Fixed Shuriken AoE Logics
- Fixed burst logic
- New : Blocked Spells Status Frame (see 2nd tab)
- Improved Profile performance
- Updated APLs to 8.3 (T25)
- Update Marked For Death snipping on low health units
- Added check on Azerite Beam essence				

As always, please report on Discord or message me directly if you need anything !
]]
					
	end


--------------------
------ HUNTER ------
--------------------
	-- BeastMastery
	if PlayerSpec == 253 then
	    ChangeLog = [[
		Welcome to Taste - BeastMastery Hunter !

List of latest changes :

- Added Intimidation in spell list
- New UI settings for Blood of the Enemy
- New Mythic+ settings ! 
- Aspect of the wild can be forced in Keys with Rapid Reload enabled
- New AoE optimizations ! 
- Fixed some wrong Cobra Shot calls
- New UI settings for Multishot
- Pet revive and heal should work
- Added Masters Call and Survival of the Fittest
- Added RapidReload check with Multishot when 4+ targets are present
- New : Blocked Spells Status Frame (see 2nd tab)
- Changed priority of Barbed Shot
- Changed default Barbed Shot refresh value from 1.8 to 2 considering feedbacks
- Added check on pet type to avoid using spells they don't have
- Reworked the AoE mode a little (don't forget to add pet spell in YOUR spellbar)
- Added little padding and gutter to ProfileUI
- Fixed chat spam cause of pet spell not being in player spell bar (see above)
- Updated to 8.3 APLs
- Bestial Wrath special UI settings
- AoE detection fix
- Added new AoE detection choice for user
- Added Feign Death to avoid Thing from Beyond
- Reworked AoE rotation to improve uptime on Frenzy buff

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Marksmanship
	if PlayerSpec == 254 then
	    ChangeLog = [[
		Welcome to Taste - Marksmanship Hunter !
				
        ***** TEST BUILD *****
		
- Updated to latest T25 APLs
- Fixed most lua errors issues
- Fixed interrupters spells
- Added detection AoE system like BM
- New UI settings
- Test Release Need Feedbacks :) 

As always, please report on Discord or message me directly if you need anything !
]]
					
	end

	-- Survival
	if PlayerSpec == 255 then
	    ChangeLog = [[
		Welcome to Taste - Survival Hunter !
				
        ***** TEST BUILD *****
		
- Fixed Wildfire Infusions talent		
- New : Blocked Spells Status Frame (see 2nd tab)
- Test Release Need Feedbacks :) 

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------- MAGE -------
--------------------
	-- Arcane
	if PlayerSpec == 62 then
	    ChangeLog = [[
		Welcome to Taste - Arcane Mage !
		
        ***** TEST BUILD *****

- Fixed most trinket error
- Fixed Arcane Explosion not always being used
- Reworked Burn & Conserve phase and added mana check
- Added auto Stop Cast on Evocation if we are full mana		
- New : Blocked Spells Status Frame (see 2nd tab)
- Need feedback !!
- Reworked all the rotation
- Updated  to latest T25 APLs
- Fixed most lua errors
- Added Burn & Conserve logic
				

As always, please report on Discord or message me directly if you need anything !

]]  				
	end

	-- Fire
	if PlayerSpec == 63 then
	    ChangeLog = [[
		Welcome to Taste - Fire Mage !
		
        ***** TEST BUILD *****

- Fixed FireBlast issue with double cast in a row
- New : Blocked Spells Status Frame (see 2nd tab)
- Need feedback !!
- Reworked all the rotation
- Updated  to latest T25 APLs
- Initial Test Release				

As always, please report on Discord or message me directly if you need anything !

]] 				
	end

	-- MFrost
	if PlayerSpec == 64 then
	    ChangeLog = [[
		Welcome to Taste - Frost Mage !
		
        ***** TEST BUILD *****

- Fixed Ray of Frost not being properly used
- Fixed IceLance & Flurry logic	
- New : Blocked Spells Status Frame (see 2nd tab)
- Need feedback !!
- Reworked all the rotation
- Updated  to latest T25 APLs
- Fixed most lua errors
- Initial Test Release				

As always, please report on Discord or message me directly if you need anything !

]] 				
	end


--------------------
------ DRUID -------
--------------------
	-- Balance
	if PlayerSpec == 102 then
	    ChangeLog = [[
		Welcome to Taste - Balance Druid !
		
***** TEST BUILD *****

- Fixed Futur Maelstrom prediction
- Fixed Arcanic Pulsar logic
- Reworked all UI
- New Trinkets settings
- New Azerite Beam settings
- Fixed Streaking Star azerite special rotation (should not repeat two spells)
- New : Blocked Spells Status Frame (see 2nd tab)
- Need feedback !!
- Reworked all the rotation
- Updated  to latest T25 APLs
- Fixed most lua errors
- Initial Test Release						

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Feral
	if PlayerSpec == 103 then
	    ChangeLog = [[
		Welcome to Taste - Feral Druid !
		
        ***** TEST BUILD *****

- Added Main support
- Added fix to avoid double Regrowth
- New : Blocked Spells Status Frame (see 2nd tab)
- AutoWild Charge fix
- Range Rotation option
- Blood of the enemy AoE / CD options
- Mass root Thing from Beyond 
- Tigers Fury fix
- Range check on most spells 
- Death check on most spells
- Added Entangling root on mouseover
- Bear Form issue should be fixed (no more spam)
- Trinkets range check
- Reworked all the rotation
- Added Thing From Below mouseover roots
- Updated APLs to latest T25
- Added Damage formula for all simc reference
- Added AttackPowerDamageMod simc reference
- Reworked all the UI 
- Added Party dispell
- Added IsUsablePPool (check next spell cost against primary ressource for pooling)
- Added Wildcharge cat out of range
- Added Wildcharge bear out of range
- Added Stampeding Roar
- Added Dash
				

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Guardian
	if PlayerSpec == 104 then
	    ChangeLog = [[
		Welcome to Taste - Guardian Druid !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Updated to 8.3 APLs
- Fix on AutoTaunt
- Fixed Arcane Torrent logic

TODO : Rework all defensives logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Restoration
	if PlayerSpec == 105 then
	    ChangeLog = [[
		Welcome to Taste - Restoration Druid !
		
List of latest changes :

- Improved burst logic
- Reworked Regrowth usage
- Rotation is now less manavore (less spam)
- Removed Prehot waiting for proper fixes
- Fixed auto DPS feral rotation
- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Catweaving rotation
- Reworked cooldowns usage
- Added more notification for user
- Profile performance improvements

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end


--------------------
------- MONK -------
--------------------
	-- Brewmaster
	if PlayerSpec == 268 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end

	-- Windwalker
	if PlayerSpec == 269 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- Mistweaver
	if PlayerSpec == 270 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end


--------------------
------ PRIEST ------
--------------------
	-- Discipline
	if PlayerSpec == 256 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- PHoly
	if PlayerSpec == 257 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- Shadow
	if PlayerSpec == 258 then
	    ChangeLog = [[
		Welcome to Taste - Shadow Priest !

- Fixed double vampiric Touch issue		
- New Multidot UI settings
- More improvements on AoE Cycle
- Fixed error with mindsear
- Fixed error with mindflay
- Improved Shadowvoid usage
- New reupdated all rotation to T25 APLs
			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	return ChangeLog
end

-- Love Popup
-- This is secret popup :)
StaticPopupDialogs["LOVE_POPUP"] = {
  text = "Hey there ! Thanks for clicking the love button :)\n\nLove is the most important part :)\n\nDon't forget that you can ask me whatever you want on rotations. Feedbacks are really appreciated if you got optimized gear for the current content and see some rotations mistakes !\n\nCreating good profils is long task and take a lot of time as you can imagine. I will always try to do my best to satisfy everyone so do not hesitate to discord me if needed!\n\nAlso if you really like my work you can make a little coffee donation to: paypal.me/roifok\n\nEvery donation is welcome but not mandatory.\n\nHave a good game and thanks for reading !\n\nPS:Don't forget to post logs on discord :)",
  button1 = "Okay :)",
  button2 = "Close",
  OnAccept = function()
      StaticPopup_Hide ("LOVE_POPUP")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

------------------------
-- CHANGELOG CALLBACK --
------------------------ 
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()

-- Spec specific Popup
local PlayerSpec = Action.PlayerSpec
local currentChangelog = TR:UpdateChangeLog()
local Errormessage = "Error on popup : You did not set any message."
local profileName = TMW.db:GetCurrentProfile()
local ChangelogOnStartup = A.GetToggle(2, "ChangelogOnStartup")

    -- Dynamic popup creation
    if Action.PlayerSpec and ChangelogOnStartup then
        TR:CreatePopup(Action.PlayerSpec, currentChangelog, "Okay", "Marry Me", 0, true, true)
    else	 
        TR:CreatePopup(999, "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord.", "OK", nil, 0, true, true)
    end	
	
	-- Create Popup Frame dynamically 
    StaticPopupDialogs[TR.Popup.popupname] = {
        text = TR.Popup.message, --"Do you want to greet the world today?",
        button1 = TR.Popup.button1, --"Yes", -- On ACCEPT
        button2 = TR.Popup.button2, --"No", -- On CANCEL
        OnAccept = function()
            StaticPopup_Hide (TR.Popup.popupname)
        end,
        OnCancel = function()
            StaticPopup_Show ("LOVE_POPUP")
        end,
        timeout = TR.Popup.timeout,
        whileDead = TR.Popup.whileDead,
        hideOnEscape = TR.Popup.hideOnEscape,
        preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }

    -- Check for Taste profils
    if PlayerSpec then
        if profileName:match("Taste") then
            if PlayerSpec and ChangelogOnStartup then
                StaticPopup_Show (PlayerSpec)
	        end
        end
    end
	
end)