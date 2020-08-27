local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local pairs = pairs

Env.oDHBurstBuffs = {
    MetamorphosisBuff = 162264,
    [577] = {162264}, -- Havoc
    [581] = {-162264}, -- Vengeance
}

-- Cache
Env.oDH = {}   
function Env.RefreshDH()       
    -- General     
    Env.oDH["MyBurstBuffs"] = Env.MyBurstBuffs()
    Env.oDH["AbleBurst"] = burst_toggle and Env.MyBurst()
    Env.oDH["DeffBuffs"] = Env.PvPBuffs("player", "DeffBuffs")        
    -- ======================= HAVOC =======================
    if Env.UNITSpec("player", 577) then             
        Env.oDH["TargetInMelee"] = (TMW.time - SpellLastCast("player", 232893) <= Env.GCD() and TMW.time - SpellLastCast("player", 198793) > 1) or Env.SpellInRange("target", 162794)
        Env.oDH["TargetRange8"] = Env.SpellInteract("target", 8)
        Env.oDH["AoE_2"] = AoE(2, 8)  
        -- Simcraft 
        --talent.first_blood.enabled|spell_targets.blade_dance1>=(3-talent.trail_of_ruin.enabled)
        Env.oDH["blade_dance"] = Env.TalentLearn(206416) or AoE(2, 7)
        --!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60)
        Env.oDH["waiting_for_nemesis"] = not 
        (
            not Env.TalentLearn(206491) or 
            Env.SpellCD(206491) > TimeToDie("target") or
            Env.SpellCD(206491) > 60 
        ) 
        --!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10)
        Env.oDH["pooling_for_meta"] = 
        not Env.TalentLearn(213410) and 
        Env.SpellCD(191427) < 6 and 
        Env.FuryDeficit() > 30 and 
        (
            not Env.oDH["waiting_for_nemesis"] or 
            Env.SpellCD(206491) < 10
        )
        --variable.blade_dance&(fury<75-talent.first_blood.enabled*20)
        if Env.oDH["blade_dance"] then 
            if Env.TalentLearn(206416) then 
                Env.oDH["pooling_for_blade_dance"] = Env.Fury() < 55
            else 
                Env.oDH["pooling_for_blade_dance"] = Env.Fury() < 75
            end 
        else 
            Env.oDH["pooling_for_blade_dance"] = false
        end 
        -- talent.demonic.enabled&!talent.blind_fury.enabled&cooldown.eye_beam.remains<(gcd.max*2)&fury.deficit>20
        Env.oDH["pooling_for_eye_beam"] =
        Env.TalentLearn(213410) and 
        not Env.TalentLearn(203550) and 
        Env.SpellCD(198013) < Env.GCD() * 2 and
        Env.FuryDeficit() > 20
        --talent.dark_slash.enabled&!variable.pooling_for_blade_dance&!variable.pooling_for_meta&cooldown.dark_slash.up
        Env.oDH["waiting_for_dark_slash"] =
        Env.TalentLearn(258860) and 
        not Env.oDH["pooling_for_blade_dance"] and 
        not Env.oDH["pooling_for_meta"] and 
        Env.SpellCD(258860) <= 0.1
        --talent.momentum.enabled&!buff.momentum.up
        Env.oDH["waiting_for_momentum"] = Env.TalentLearn(206476) and Env.Buffs("player", 206476, "player") == 0    
        -- PvP
        Env.oDH["IsInRainFromAbove"] = Env.InPvP() and Env.IsInRainFromAbove()
        -- ======================= VENGEANCE =======================    
    elseif Env.UNITSpec("player", 581) then        
        Env.oDH["TargetInMelee"] = Env.SpellInRange("target", 228477)        
        Env.oDH["TargetRange8"] = Env.SpellInteract("target", 8)
        Env.oDH["Souls"] = Env.BuffStack("player", 203981, "player")        
        Env.oDH["TargetRange"] = Env.UNITRange("target")              
    end -- finish    
    if Env.InPvP() then          
        Env.oDH["PvPTargetingMe"] = Env.PvPTargeting("player")
        Env.A.FriendlyTeam("HEALER"):GetCC() = Env.Get_PvPFriendlyHealerInCC()
        Env.Unit("player"):UseDeff() = Env.PvPNeedDeff("player")
        Env.oDH["PvPAbleBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
        Env.oDH["PvPBreakAble8"] = Env.PvPBreakAble(8)
    end    
end

for k, v in pairs({"PLAYER_ENTERING_WORLD", "ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_SPECIALIZATION_CHANGED"}) do
    Listener:Add('DH_GeneralEvents', v, function()
            wipe(Env.oDH) 
            if v == "PLAYER_ENTERING_WORLD" then 
                Env.oDH["GameBuild"] = GetBuildInfo() 
            end 
            Env.RefreshDH()            
    end)
end

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
            Env.RefreshDH()
            self.elapsed = 0
        end        
end)


-- General
function Env.MyBurstBuffs()
    return 
    ( 
        -- Vengeance
        not Env.UNITSpec("player", 581) and 
        Env.Buffs("player", Env.oDHBurstBuffs[Env.PlayerSpec], "player") > 0
    ) or    
    Env.PvPBuffs("player", "BurstHaste") > 0 or
    (
        -- Havoc
        Env.UNITSpec("player", 577) and 
        Env.DeBuffs("target", 206491, "player") > 6 -- Nemesis
    )
end
function Env.Fury()
    return Env.UnitPower("player", Enum.PowerType.Fury) or 0
end
function Env.FuryDeficit()
    local max = Env.UnitPowerMax("player", Enum.PowerType.Fury) or 0
    return max - Env.Fury()
end

function Env.Pain()
    return Env.UnitPower("player", Enum.PowerType.Pain) or 0
end
function Env.PainDeficit()
    local max = Env.UnitPowerMax("player", Enum.PowerType.Pain) or 0
    return max - Env.Pain()
end

-- Havoc 
function Env.IsMetaExtendedByDemonic()
    if Env.Buffs("player", Env.oDHBurstBuffs.MetamorphosisBuff, "player") == 0 then
        return false
    elseif(SpellLastCast("player", 198013) < SpellLastCast("player", 191427)) then
        return true
    end
    
    return false
end

function Env.DeffensiveConditions() 
    return
    (    
        not Env.oDH["MyBurstBuffs"] and 
        Env.oDH["DeffBuffs"] == 0
    ) or
    (
        Env.oDH["MyBurstBuffs"] and 
        Env.oDH["DeffBuffs"] == 0 and 
        not Env.IsIconShown("TMW:icon:1S2PESqQFiMf") and -- Blur
        not Env.IsIconShown("TMW:icon:1S2PESqDwuYV") and -- Darkness
        not Env.IsIconShown("TMW:icon:1S2PESqEtYSD") and -- Darkness
        not Env.IsIconShown("TMW:icon:1Qb8jTkfFcH7") -- Netherwalk
    )
end 

function Env.IsInRainFromAbove()
    return Env.PvPTalentLearn(206803) and Env.Buffs("player", 206803, "player") > 0
end

function Env.ManaBreakerConditions(unit) 
    local HP = UnitHealth(unit) * 100 / UnitHealthMax(unit)
    if HP <= 5 then 
        return true 
    end 
    if select(2, UnitPowerType(unit)) ~= "MANA" then 
        return false 
    end 
    local bBuff, total_time = Env.Buffs("player", Env.oDHBurstBuffs.MetamorphosisBuff, "player")
    local bDeBuff = Env.DeBuffs(unit, 206491, "player")
    local MANA = 100 - (UnitPower(unit) * 100 / UnitPowerMax(unit))
    return 
    (
        bBuff > 3 and 
        total_time > 10
    ) or 
    (
        bDeBuff > 0 and 
        bDeBuff < 3 
    ) or 
    HP <= MANA * 0.2 + 5
end

local SwingDamage = {}
Listener:Add('DH_HavocEvents1', "COMBAT_LOG_EVENT_UNFILTERED", function(...)
        if not Env.UNITSpec("player", 577) then -- Havoc
            return
        end
        
        local _, EVENT,_, SourceGUID, _,_,_, DestGUID, DestName,_,_, spellID, spellName,_, auraType, Amount = CombatLogGetCurrentEventInfo()        
        if (EVENT == "SWING_DAMAGE" or EVENT == "SWING_MISSED") and SourceGUID == UnitGUID("player") then            
            SwingDamage[DestGUID] = {TIME = TMW.time, FACE = GetPlayerFacing()}
        end        
end)

Listener:Add('DH_HavocEvents2', 'PLAYER_REGEN_ENABLED', function()        
        wipe(SwingDamage)            
end)

Listener:Add('DH_HavocEvents3', 'PLAYER_REGEN_DISABLED', function()        
        wipe(SwingDamage)             
end)

function Env.IsFacing(unit) 
    local GUID = UnitGUID(unit)               
    return 
    not Facing_Toggle or
    not GetPlayerFacing() or
    ( 
        SwingDamage[GUID] and 
        TMW.time - SwingDamage[GUID].TIME <= Env.GCD() * 3 and 
        math.abs(GetPlayerFacing() - SwingDamage[GUID].FACE) < 0.53  
    ) or 
    Env.PvP.Unit(unit):GetRange() > 20 
end

-- Vengeance
function Env.NotUsedMassKick()
    local dur = 2
    -- Quickened Sigils
    if Env.TalentLearn(209281) then
        dur = 1
    end    
    return 
    -- Silence
    (
        Env.LastPlayerCastID ~= 202137 or
        Env.SpellCD(202137) < 59 - dur
    ) and
    -- Disoriend
    
    (
        Env.LastPlayerCastID ~= 207684 or
        Env.SpellCD(207684) < 88 - dur
    ) and
    -- Mass Taunt
    (
        not Env.TalentLearn(202138) or
        Env.LastPlayerCastID ~= 202138 or
        Env.SpellCD(202138) < 88 - dur
    )
end

-- PvE

-- PvP
function Env.NOPhysicImun(unit)
    return Env.A.Unit(unit):HasBuffs("TotalImun")==0 and Env.A.Unit(unit):HasBuffs("DamagePhysImun")==0
end
function Env.NOMagicImun(unit)
    return Env.A.Unit(unit):HasBuffs("TotalImun")==0 and Env.A.Unit(unit):HasBuffs("DamageMagicImun")==0 
end
function Env.GetDurationPhysImun(unit)
    local total = Env.A.Unit(unit):HasBuffs("TotalImun")
    if total > 0 then
        return total
    end
    total = Env.A.Unit(unit):HasBuffs("CCTotalImun")
    if total > 0 then
        return total
    end
    total = Env.A.Unit(unit):HasBuffs("DamagePhysImun")
    return total
end
function Env.GetDurationMagicImun(unit)
    local total = Env.A.Unit(unit):HasBuffs("TotalImun")
    if total > 0 then
        return total
    end
    total = Env.A.Unit(unit):HasBuffs("CCMagicImun")
    return total
end

-- Markers
Env.EoL_Mark = {}
function SetMarkEoL(unit)
    if unit and UnitExists(unit) then 
        Env.EoL_Mark[UnitGUID(unit)] = true
    end
end

local A = Action
local unit = "arena1"
return
select(2, GetSpellCooldown(183752)) == 0 and
A.IsSpellInRange(183752, unit) and
A.Unit(unit):HasBuffs("TotalImun") == 0 and
A.Unit(unit):HasBuffs("DamageMagicImun") == 0 and
A.Unit(unit):HasBuffs("KickImun") == 0 --[[and
(
    -- Soothing Mist, Penance, Essence Font, Tranquility
    PvPMultiCast(unit, {209525, 47540, 191837, 740}) == 0 or
    RandomKick(unit)    
)
]]

local A = Action
local unit = "arena1"
return
select(2, GetSpellCooldown(183752)) == 0 and
A.IsSpellInRange(183752, unit) and
(
    (
        A.FriendlyTeam("HEALER"):GetCC() == 0 and
        A.Player:FuryDeficit() >= 30        
    ) or
    (
        A.FriendlyTeam("HEALER"):GetCC() > 0 and
        A.FriendlyTeam("HEALER"):GetCC() < 2 
    ) or
    A.Unit(unit):UseBurst()  or
    A.Unit("player"):UseDeff()
) and
A.Unit(unit):HasBuffs("TotalImun") == 0 and
A.Unit(unit):HasBuffs("DamageMagicImun") == 0 and
A.Unit(unit):HasBuffs("KickImun") == 0 and
-- Dark simulacrum
A.Unit(unit):HasDeBuffs(77606, true) == 0


-- Group Condition
local A = Action
return 
A.Unit("player"):HasBuffs(206803, true) == 0 and
(
    A.Zone == "arena" or 
    A.Zone == "pvp"
)


