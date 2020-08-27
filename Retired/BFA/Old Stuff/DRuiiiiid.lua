local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local strlowerCache = TMW.strlowerCache
local pairs, tableexist = pairs, tableexist
local Feral_Registration = 0

local GetSpellInfo = GetSpellInfo

Env.oDruidBurstBuffs = {
    [102] = {194223, 102560}, 
    [103] = {106951, 102543},
    [104] = {102558},
    [105] = {33891},
}

-- Cache
Env.oDruid = {
    ["Stance"] = Env.GetStance(),
    ["AstralPower"] = 0,
    ["lively_spirit"] = 0,
    ["AstralPowerDeficit"] = 0,  
    ["Tree"] = 0,
}
function Env.RefreshDruid()       
    -- General     
    Env.oDruid["DamageSpellRace"] = Env.SpellRace("DAMAGE")
    Env.oDruid["MyBurstBuffs"] = Env.MyBurstBuffs()
    Env.oDruid["MyBurst"] = burst_toggle and Env.MyBurst()
    Env.oDruid["DeffBuffs"] = Env.PvPBuffs("player", "DeffBuffs")    
    if Env.oDruid["Stance"] == 2 then
        Env.oDruid["ComboPoints"] = Env.ComboPoints()
    end
    -- ======================= BOOMKIN =======================
    if Env.UNITSpec("player", 102) then     
        -- Simcraft
        Env.oDruid["ca_inc"] = Env.Buffs("player", Env.oDruidBurstBuffs[Env.PlayerSpec], "player") or 0        
        Env.oDruid["lively_spirit"] = AzeriteRank(279642) -- lively_spirit
        Env.oDruid["az_streak"] = AzeriteRank(272871) -- Streaking Stars       
        Env.oDruid["az_ds"] = AzeriteRank(276152) -- Dawning Sun
        Env.oDruid["az_sb"] = AzeriteRank(274397) -- Sunblaze
        if Env.TalentLearn(279620) then -- Twin Moons
            Env.oDruid["az_potm"] = AzeriteRank(273389) -- Power of the Moon
        elseif not Env.oDruid["az_potm"] then
            Env.oDruid["az_potm"] = 0
        end        
        -- BuffStacks
        Env.oDruid["LunarEmpowerment"] = Env.BuffStack("player", 164547, "player") 
        Env.oDruid["SolarEmpowerment"] = Env.BuffStack("player", 164545, "player")
        -- v11 Finally figured how to fix that (double over casting)
        local CastingID = select(4, Env.CastTime())
        if CastingID == 194153 then
            if Env.oDruid["LunarEmpowerment"] > 1 then
                Env.oDruid["LunarEmpowerment"] = Env.oDruid["LunarEmpowerment"] - 1 
            else
                Env.oDruid["LunarEmpowerment"] = 0
            end
        end
        
        if CastingID == 190984 then
            if Env.oDruid["SolarEmpowerment"] > 1 then
                Env.oDruid["SolarEmpowerment"] = Env.oDruid["SolarEmpowerment"] - 1 
            else
                Env.oDruid["SolarEmpowerment"] = 0
            end
        end
        --
        Env.oDruid["AstralPower"] = Env.AstralPower()    
        Env.oDruid["AstralPowerDeficit"] = Env.AstralPowerDeficit()
        Env.oDruid["TargetRange40"] = Env.SpellInteract("target", 40)
        if AoE_Toggle then
            Env.oDruid["active_enemies"] = active_enemies() or 1
            Env.oDruid["spell_targets.moonfire"] = MultiDots(40, 8921, 5, 3)
        else
            Env.oDruid["active_enemies"] = 1
            Env.oDruid["spell_targets.moonfire"] = 0
        end
        if Env.InPvP() then          
            Env.oDruid["PvPTargetingMe"] = Env.PvPTargeting("player")
            Env.oDruid["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
            Env.oDruid["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
            Env.oDruid["PvPUseBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
            Env.oDruid["PvPBreakAble40"] = Env.PvPBreakAble(40)
        end 
        -- ======================= FERAL =======================    
    elseif Env.UNITSpec("player", 103) then
        -- Reset
        if CombatTime("player") == 0 and not Env.global_invisible() then
            Env.oDruid["LastResource"] = 0 -- Pool Resource by latest spell
        end        
        -- Precombat simcraft
        if AzeriteRank(279527) > 0 then -- Wild Fleshrending
            Env.oDruid["use_thrash"] = 2
        else
            Env.oDruid["use_thrash"] = 0
        end
        -- ,if=talent.sabertooth.enabled&talent.bloodtalons.enabled&!talent.lunar_inspiration.enabled
        if Env.TalentLearn(202031) and Env.TalentLearn(155672) and not Env.TalentLearn(155580) then
            Env.oDruid["delayed_tf_opener"] = 1
        else
            Env.oDruid["delayed_tf_opener"] = 0
        end
        -- Simcraft
        if CombatTime("player") == 0 or not Env.oDruid["opener_done"] then
            Env.oDruid["opener_done"] = 0
        elseif Env.oDruid["opener_done"] and Env.oDruid["opener_done"] == 0 then
            if Env.DeBuffs("target", 1079, "player") > 0 then
                Env.oDruid["opener_done"] = 1
            end
        end
        --
        Env.oDruid["TargetInMelee"] = Env.SpellInRange("target", 5221) -- Shred
        Env.oDruid["BloodtalonsStack"] = Env.BuffStack("player", 145152, "player")
        Env.oDruid["AoE_2"] = AoE(2, 8)
        if Env.InPvP() then          
            Env.oDruid["PvPTargetingMe"] = Env.PvPTargeting("player")
            Env.oDruid["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
            Env.oDruid["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
            Env.oDruid["PvPUseBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
            Env.oDruid["PvPBreakAble8"] = Env.PvPBreakAble(8)
        end        
        -- ======================= GUARDIAN =======================    
    elseif Env.UNITSpec("player", 104) then
        -- Mangle
        Env.oDruid["TargetInMelee"] = Env.SpellInRange("target", 33917) 
        Env.oDruid["ThrashStack"] = Env.DeBuffStack("target", 192090, "player")
        Env.oDruid["AoE_3"] = AoE(3, 8)
        if Env.InPvP() then          
            Env.oDruid["PvPTargetingMe"] = Env.PvPTargeting("player")
            Env.oDruid["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
            Env.oDruid["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
            Env.oDruid["PvPUseBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
            Env.oDruid["PvPBreakAble8"] = Env.PvPBreakAble(8)
        end   
        -- ======================= RESTOR =======================    
    elseif Env.UNITSpec("player", 105) then
        Env.oDruid["Tree"] = Env.Buffs("player", Env.oDruidBurstBuffs[Env.PlayerSpec], "player") or 0
        Env.oDruid["Innervate"] = Env.Buffs("player", 29166, "player")
        Env.oDruid["TargetRange40"] = Env.SpellInteract("target", 40)
        Env.oDruid["MouseRange40"] = Env.SpellInteract("mouseover", 40)
        -- HealingEngine
        Env.oDruid["AVG_DMG"] = Env.AVG_DMG()
        Env.oDruid["AVG_HPS"] = Env.AVG_HPS()
        Env.oDruid["Last5sec_DMG"] = Env.Last5sec_DMG()
        if Env.InPvP() then          
            Env.oDruid["PvPTargetingMe"] = Env.PvPTargeting("player")
            --Env.oDruid["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
            Env.oDruid["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
            Env.oDruid["PvPMouseoverCyclone"] = Env.DeBuffs("mouseover", 33786)
            Env.oDruid["PvPTargetCyclone"] = Env.DeBuffs("target", 33786)
            --Env.oDruid["PvPUseBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
            --Env.oDruid["PvPBreakAble40"] = Env.PvPBreakAble(40)
        end 
    end -- finish    
end

local function CreateDruid()
    Env.oDruid["GameBuild"] = GetBuildInfo()             
    Env.RefreshDruid()   
    TMW.COUNTERS["moon"] = 1
    Env.oDruid["Stance"] = Env.GetStance()
    Env.oDruid["ComboPoints"] = Env.ComboPoints()         
    -- Simcraft PMultiplier snippet
    --[[
    if Env.UNITSpec("player", 103) then              
        if Feral_Registration == 0 then                    
            Feral_Registration = 1                    
            RegisterPMultiplier( -- Rake dot and action
                1822,    -- Rake action
                155722,  -- Rake dot
                {function ()
                        return Env.global_invisible() and 2 or 1
                end},
                -- BloodtalonsBuff, SavageRoar, TigersFury
                {145152, 1.2}, {52610, 1.15}, {5217, 1.15}
            )
            RegisterPMultiplier(
                1079, -- Rip action
                -- BloodtalonsBuff, SavageRoar, TigersFury
                {145152, 1.2}, {52610, 1.15}, {5217, 1.15}
            )
        end
        Env.oDruid["LastResource"] = 0 -- Pool Resource by latest spell
    end  
    ]]
    if Env.UNITSpec("player", 105) then
        Env.oDruid["Tree"] = 0
    end
end

for k, v in pairs({"ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_SPECIALIZATION_CHANGED"}) do
    Listener:Add('Class_Events_1', v, CreateDruid)
end

Listener:Add('Class_Events_2', "UPDATE_SHAPESHIFT_FORM", function()
        Env.oDruid["Stance"] = Env.GetStance()            
end)

Listener:Add('Feral_Events', "COMBAT_LOG_EVENT_UNFILTERED", function(...)
        local _, EVENT, _, SourceGUID, _,_,_, DestGUID, _, _, _, SpellID  = CombatLogGetCurrentEventInfo()
        if EVENT=="SPELL_CAST_SUCCESS" and SourceGUID==UnitGUID("player") then
            for k, v in pairs({
                    52610,     -- Savage Roar
                    285381,    -- Primal Wrath
                    22568,     -- Ferocious Bite
                    1079,      -- Rip
                    202028,    -- Brutal Slash
                    106830,    -- Thrash
                    106785,    -- Swipe
                    1822,      -- Rake
                    5221,      -- Shred
                    22570,     -- Maim
                    236026,    -- Enraged Maim
            }) do
                if SpellID == v then
                    -- Pool Resource by latest spell
                    Env.oDruid["LastResource"] = SpellID 
                end
            end
        end        
end)


local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function (self, elapsed)
        self.elapsed = (self.elapsed or 0) + elapsed;
        local refresh = 1 
        if select(2, Env.CastTime()) > 0 then
            refresh = TMW.db.global.Interval + 0.001
        elseif CombatTime("player") > 0 then 
            local FPS = GetFramerate() or 0
            if FPS >= 0 and FPS < 100 then
                refresh = (100 - FPS) / 90
            else
                refresh = 0.1
            end
        end
        
        if (self.elapsed > refresh) then            
            Env.RefreshDruid()
            self.elapsed = 0
        end        
end)


-- General
function Env.MyBurstBuffs()
    local dmgracespell = Env.oDruid["DamageSpellRace"]
    return 
    Env.Buffs("player", Env.oDruidBurstBuffs[Env.PlayerSpec], "player")>0 or
    Env.PvPBuffs("player", "BurstHaste")>0 or
    (
        dmgracespell and
        Env.Buffs("player", dmgracespell, "player")>0
    )
end
function Env.Decurse(unit, Icon)
    return
    (
        (
            Icon and
            MacroSpells(Icon, "Dispel")
        ) or 
        dispel_toggle
    ) and
    UnitExists(unit) and
    not Env.InLOS(unit) and    
    Env.SpellInRange(unit, 2782) and    
    (
        Env.PvPDeBuffs(unit, "Curse")>2 or
        Env.PvPDeBuffs(unit, "Poison")>2 or 
        Env.PvEDispel(unit)
    )
end
function Env.Dispel(unit, Icon)
    return
    (
        (
            Icon and
            MacroSpells(Icon, "Dispel")
        ) or         
        dispel_toggle
    ) and
    UnitExists(unit) and
    not Env.InLOS(unit) and    
    Env.SpellInRange(unit, 88423) and    
    Env.LastPlayerCastID~=88423 and
    (
        (
            Env.InPvP() and 
            (
                Env.PvPDeBuffs(unit, "Curse")>2 or
                Env.PvPDeBuffs(unit, "Poison")>2 or
                Env.PvPDeBuffs(unit, "Magic")>2 or
                (
                    select(2, UnitClass(unit)) ~= "DRUID" and
                    Env.PvPUnitIsMelee(unit) and
                    Env.PvPDeBuffs(unit, "MagicRooted")>2
                )
            ) 
        ) or         
        Env.PvEDispel(unit)    
    )
end
function Env.NoUsedLastGCDReshift()
    return
    Env.LastPlayerCastName ~= strlower(GetSpellInfo(5487)) and -- Bear
    Env.LastPlayerCastName ~= strlower(GetSpellInfo(768)) and -- Cat
    Env.LastPlayerCastID ~= 783 and -- Travel
    Env.LastPlayerCastName ~= strlower(GetSpellInfo(24858)) and -- Boomkin
    Env.LastPlayerCastName ~= strlower(GetSpellInfo(33891))-- Tree
end

-- PvE
function Env.PvESoothe(unit)
    -- https://questionablyepic.com/bfa-dungeon-debuffs/
    return Env.Buffs(unit, {
            228318, -- Raging (Raging Affix)
            255824, -- Fanatic's Rage (Dazar'ai Juggernaut)
            257476, -- Bestial Wrath (Irontide Mastiff)
            269976, -- Ancestral Fury (Shadow-Borne Champion)
            262092, -- Inhale Vapors (Addled Thug)
            272888, -- Ferocity (Ashvane Destroyer)
            259975, -- Enrage (The Sand Queen)
            265081, -- Warcry (Chosen Blood Matron)
            266209, -- Wicked Frenzy (Fallen Deathspeaker)
    })>2
end

-- PvP
function Env.NOPhysicImun(unit)
    return Env.PvPBuffs(unit, "TotalImun")==0 and Env.PvPBuffs(unit, "DamagePhysImun")==0
end
function Env.NOMagicImun(unit)
    return Env.PvPBuffs(unit, "TotalImun")==0 and Env.PvPBuffs(unit, "DamageMagicImun")==0 
end
function Env.GetDurationPhysImun(unit)
    local total = Env.PvPBuffs(unit, "TotalImun")
    if total > 0 then
        return total
    end
    total = Env.PvPBuffs(unit, "CCTotalImun")
    if total > 0 then
        return total
    end
    total = Env.PvPBuffs(unit, "DamagePhysImun")
    return total
end
function Env.GetDurationMagicImun(unit)
    local total = Env.PvPBuffs(unit, "TotalImun")
    if total > 0 then
        return total
    end
    total = Env.PvPBuffs(unit, "CCMagicImun")
    return total
end
function Env.PvPEntanglingRoots(unit)
    return
    Env.PvPUnitIsMelee(unit) and
    not UnitIsUnit(unit, "target") and
    not Env.InLOS(unit) and 
    Env.PvPBuffs(unit, "DamageBuffs") > 0 and
    Env.SpellInRange(unit, 339) and
    (
        (
            Env.UNITSpec("player", 103) and -- Feral
            Env.Buffs("player", 69369, "player") > 0
        ) or
        (
            Env.UNITSpec("player", 105) and -- Restor
            Env.oDruid["Tree"] > 0
        ) or
        Env.UNITCurrentSpeed("player")==0
    ) 
end

-- Boomkin
function Env.AstralPower()
    return Env.UnitPower("player", Enum.PowerType.LunarPower) or 0
end
function Env.AstralPowerDeficit()
    local max = Env.UnitPowerMax("player", Enum.PowerType.LunarPower) or 0
    return max - Env.AstralPower()
end
function Env.Moon()
    local moon, id = TMW.COUNTERS["moon"], 202767
    if moon == 1 then
        id = 202767
    elseif moon == 2 then
        id = 202768
    else
        moon = 3
        id = 202771
    end    
    return id, moon
end

-- Feral
function Env.FerociousBiteMaxEnergy()
    local MaxEnergy = 50
    if Env.Buffs("player", Env.oDruidBurstBuffs[Env.PlayerSpec], "player")>0 then
        MaxEnergy = 25
    end
    return UnitPower("player") >= MaxEnergy
end
function Env.PvPRipAndTear(sID)
    -- Save energy when it can be refreshed
    if 
    not sID or
    not Env.PvPTalentLearn(203242) or 
    not UnitIsPlayer("target") or
    not Env.oDruid["TargetInMelee"] or 
    Env.SpellCD(203242) > 3 or
    Env.Buffs("player", 135700, "player") > 0 or -- Clearcasting 
    (
        not Env.PT("target", 1079, "debuff") and -- Rip dot
        not Env.PT("target", 155722, "debuff") -- Rake dot
    ) or
    Env.Energy()>=Env.GetPowerCost(203242)+Env.GetPowerCost(sID)
    then
        return true
    end
    return false
end
function Env.PvPBearSprint()
    --#1 Use when fhealer has Boomkin silence with roots near by you
    --#2 Use when fhealer has been targeted by emelee and he is slowled and not in stun
    --#3 Use when melee fdamager has burst stage and he is rooted
    if Env.Zone ~= "none" and Env.PvPTalentLearn(213200) then
        -- #1 -> #2
        if tableexist(Env.PvPCache["FriendlyHealerUnitID"]) then 
            for k, member in pairs(Env.PvPCache["FriendlyHealerUnitID"]) do
                if Env.SpellInteract(member, 15) then
                    -- #1
                    if 
                    Env.DeBuffs(member, 78675)>0 and 
                    Env.PvPDeBuffs(member, "Rooted")>0 
                    then
                        return true
                        -- #2
                    elseif 
                    Env.PvPTargeting_Melee(member, true) and 
                    Env.PvPDeBuffs(member, "Stuned")==0 and
                    Env.PvPDeBuffs(member, "Slowed")>0
                    then 
                        return true
                    end
                end
            end
        end
        -- #3
        if tableexist(Env.PvPCache["FriendlyDamagerUnitID"]) then 
            for k, member in pairs(Env.PvPCache["FriendlyDamagerUnitID"]) do
                if 
                Env.PvPBuffs(member, "DamageBuffs_Melee") > 3 and
                Env.PvPDeBuffs(member, "Rooted") > 0 and
                Env.PvPDeBuffs(member, "Disarmed") == 0 and
                Env.PvPDeBuffs(member, "Stuned") == 0 and
                Env.SpellInteract(member, 15) 
                then
                    return true
                end
            end
        end
    end
    return false
end

local DamageTaken = {}
Listener:Add('Starfall_Events', 'COMBAT_LOG_EVENT_UNFILTERED', function(...)
        local _, EVENT, _, SourceGUID, _,_,_, DestGUID, _,_,_, spellID, spellName, school, Amount = CombatLogGetCurrentEventInfo()
        if EVENT == "SPELL_DAMAGE" and SourceGUID == UnitGUID("player") and
        (spellName == GetSpellInfo(191034) or spellID == 191037) then
            local prev = (DamageTaken[DestGUID] and DamageTaken[DestGUID].AMOUNT) or 0
            DamageTaken[DestGUID] = { TIME = TMW.time, AMOUNT = prev + Amount }
        end
end)

function Env.GetDamageTakenByMyStarfall(unit)
    local DestGUID = UnitGUID(unit)
    return ((not DamageTaken[DestGUID] or TMW.time - DamageTaken[DestGUID].TIME > 8) and 0) or DamageTaken[DestGUID].AMOUNT    
end

-- Guardian
-- none

-- Restor
-- Get averange inc dmg/heal for raid/group
Env.gHE = {}
local gHEupdate = CreateFrame("Frame")
gHEupdate:SetScript("OnUpdate", function (self, elapsed)
        self.elapsed = (self.elapsed or 0) + elapsed;
        if (self.elapsed >= 1 and Env.UNITSpec("player", 105) and CombatTime("player") > 0 and Env.PvPCache["Group_FriendlySize"] > 1) then
            table.insert(Env.gHE, {DMG = Group_incDMG(), HEAL = Group_getHEAL()})
            self.elapsed = 0                
        end
end)

Listener:Add('HE_Events', "PLAYER_REGEN_ENABLED", function()
        wipe(Env.gHE)
end)

function Env.AVG_DMG()
    local total = 0
    if tableexist(Env.gHE) then
        for i = 1, #Env.gHE do
            total = total + Env.gHE[i].DMG
        end
        total = total / #Env.gHE
    end
    return total
end

function Env.AVG_HPS()
    local total = 0
    if tableexist(Env.gHE) then
        for i = 1, #Env.gHE do
            total = total + Env.gHE[i].HEAL
        end
        total = total / #Env.gHE
    end
    return total
end

function Env.Last5sec_DMG()
    local total = 0
    if tableexist(Env.gHE) and #Env.gHE >= 6 then
        for i = #Env.gHE - 5, #Env.gHE do
            total = total + Env.gHE[i].DMG
        end
        total = total / 5
    end
    return total
end


-- PLAYER LOGIN 
local function LoginTemp()
    local saved = Env.InPvP_Status
    Env.InPvP_Status = true
    Env.RefreshDruid()
    Env.InPvP_Status = saved
    saved = nil
end 
-- Some lazy trick to avoid empty PvP tables at startup due stupid TMW query
Listener:Add('DruidFix_Events', "PLAYER_LOGIN", LoginTemp)

Listener:Add('DruidFix_Events', "PLAYER_ENTERING_WORLD", CreateDruid)

LoginTemp()
CreateDruid()






