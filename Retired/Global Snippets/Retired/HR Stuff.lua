------------------------------------------
--------- HERO ROTATION STUFF ----------
------------------------------------------
-- Updated 30-08-2019

local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local Action = Action
-- HeroRotation
local HR = HeroRotation
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
-- Lua
local next, pairs, type, print  = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID = UnitIsPlayer, UnitExists, UnitGUID
local PetLib = LibStub("PetLibrary")
local ActionUnit = Action.Unit 

-- File Locals
HR.Commons = {};
local Commons = {};
HR.Commons.Everyone = Commons;

--- ============================ CONTENT ============================
-- Is the current target valid ?
function Commons.TargetIsValid ()
   return Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost();
end

-- Put EnemiesCount to 1 if we have AoEON or are targetting an AoE insensible unit
local AoEInsensibleUnit = {
    --- Legion
    ----- Dungeons (7.0 Patch) -----
    --- Mythic+ Affixes
    -- Fel Explosives (7.2 Patch)
        [120651] = true
}
function Commons.AoEToggleEnemiesUpdate ()
    if not HR.AoEON() or AoEInsensibleUnit[Target:NPCID()] then
        for Key, Value in pairs(Cache.EnemiesCount) do
            Cache.EnemiesCount[Key] = math.min(1, Cache.EnemiesCount[Key]);
        end
    end
end

-- Is the current unit valid during cycle ?
function Commons.UnitIsCycleValid (Unit, BestUnitTTD, TimeToDieOffset)
    return not Unit:IsFacingBlacklisted() and not Unit:IsUserCycleBlacklisted() and (not BestUnitTTD or Unit:FilteredTimeToDie(">", BestUnitTTD, TimeToDieOffset));
end

-- Is it worth to DoT the unit ?
function Commons.CanDoTUnit (Unit, HealthThreshold)
    return Unit:Health() >= HealthThreshold or Unit:IsDummy();
end

-- Load default profils for each class
local currentClass = select(2, UnitClass("player"))

if currentClass == "DEATHKNIGHT" then
    -- Unholy Virulent Plague Debuff
    if ActionUnit("player"):HasSpec(252) then 
        Spell(191587):RegisterAuraTracking();
	end
end

if currentClass == "ROGUE" then
    Spell(303568):RegisterAuraTracking();
	Spell(302565):RegisterAuraTracking();
end