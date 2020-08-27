local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local Action = Action
local MultiUnits = Action.MultiUnits
local next, pairs, type, print  = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID = UnitIsPlayer, UnitExists, UnitGUID
local PetLib = LibStub("PetLibrary")
local ActionUnit    = Action.Unit 
-------------------------------------------------------------------------------
-- UI Toggles
-------------------------------------------------------------------------------
-- AoE Status on Main Icon
function Action.AoEToggleMode()
    Action.UseAoE = Action.GetToggle(2, "AoE")    
    if Action.UseAoE == false then 
        Action.UseAoE = true
    else
        Action.UseAoE = false
    end
    Action.SetToggle({2, "AoE"})        
    Action.Print(Action.UseAoE and "Mode AoE: On" or not Action.UseAoE and "Mode AoE: Off")
    TMW:Fire("TMW_ACTION_AOE_MODE_CHANGED")
end 

-------------------------------------------------------------------------------
-- Profil Loader
-------------------------------------------------------------------------------
-- Load default profils for each class
local currentClass = select(2, UnitClass("player"))

if currentClass == "WARRIOR" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warrior"
    Action.Print("Automatically loaded profile : [Taste]Action - Warrior")
end

if currentClass == "WARLOCK" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warlock"
    Action.Print("Automatically loaded profile : [Taste]Action - Warlock")
end

if currentClass == "ROGUE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Rogue"
    Action.Print("Automatically loaded profile : [Taste]Action - Rogue")
end

if currentClass == "SHAMAN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Shaman"
    Action.Print("Automatically loaded profile : [Taste]Action - Shaman")
end

if currentClass == "DEATHKNIGHT" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Death Knight"
    Action.Print("Automatically loaded profile : [Taste]Action - Death Knight")
end

if currentClass == "PRIEST" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Priest"
    Action.Print("Automatically loaded profile : [Taste]Action - Priest")
end

if currentClass == "PALADIN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Paladin"
    Action.Print("Automatically loaded profile : [Taste]Action - Paladin")
end

if currentClass == "MAGE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Mage"
    Action.Print("Automatically loaded profile : [Taste]Action - Mage")
end

if currentClass == "HUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Classic - Hunter by Wolftech"
    Action.Print("Automatically loaded profile : [Taste]Classic - Hunter by Wolftech")
end

if currentClass == "DRUID" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Druid"
    Action.Print("Automatically loaded profile : [Taste]Action - Druid")
end

if currentClass == "DEMONHUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Demon Hunter"
    Action.Print("Automatically loaded profile : [Taste]Action - Demon Hunter")
end

