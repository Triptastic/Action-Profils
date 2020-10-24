local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
-- All
function Env.RuneOfPower()
    local have, name, start, duration = GetTotemInfo(1)
    return duration and duration ~= 0 and (duration - (TMW.time - start)) or 0
end

function Env.MyDamageBuffs()
    local dmgracespell = Env.SpellRace("DAMAGE")
    return 
    Env.Buffs("player", {12042, 190319, 12472}, "player")>0 or
    Env.PvPBuffs("player", "BurstHaste")>0 or
    (
        dmgracespell and
        Env.Buffs("player", dmgracespell, "player")>0
    )
end

function Env.Decurse(unit, Icon)
    return
    (
        MacroSpells(Icon, "Dispel") or 
        dispel_toggle
    ) and
    not Env.InLOS(unit) and
    UnitExists(unit) and
    Env.SpellInRange(unit, 475) and    
    Env.PvPDeBuffs(unit, "Curse")>2 
end

-- Arcane
Env.Arcane = {
    burn_phase = false,
    average_burn_length = 0, 
    burn_phase_duration = 0, 
    total_burns = 0,
}
function Env.RefreshArcane() 
    Env.Arcane["precast"] = Env.ArcanePreCast()
    Env.Arcane["burn"] = (
        Env.Arcane["burn_phase"] or 
        (
            Env.InPvP() and 
            Env.oMage["MyDamageBuffs"]
        ) or
        TimeToDie("target")<Env.Arcane["average_burn_length"] or 
        (
            (
                not Env.InPvP() or
                Env.oMage["PvPUseBurst"]
            ) and           
            Env.SpellCD(12042)==0 and  -- arcane_power
            -- evocation
            Env.SpellCD(12051)<=Env.Arcane["average_burn_length"] and 
            (                
                Env.Arcane["precast"] or 
                (   -- charged_up
                    Env.TalentLearn(205032) and 
                    Env.SpellCD(205032)==0 and
                    Env.ArcanePowerCharge()<=1
                )
            )
        )        
    )
    if Env.Arcane["burn"] then -- start
        Env.Arcane["conserve_phase"] = false        
        if not Env.Arcane["burn_phase"] then            
            Env.Arcane["burn_phase"] = true
            Env.Arcane["total_burns"] = Env.Arcane["total_burns"] + 1
            Env.Arcane["start_burn_phase"] = GetTime()                       
        elseif  -- stop
        (        
            (               
                (
                    Env.SpellCD(12051)>0 or -- evocation
                    Env.LastPlayerCastID==12051
                ) and 
                TimeToDie("target")>Env.Arcane["average_burn_length"] and 
                Env.Arcane["burn_phase_duration"]>0
            ) --[[ or -- Might be removed            
            (                                        
                Env.Buffs("player", 12042, "player")==0 and  -- arcane_power
                Env.SpellCD(12042)>0 and
                TimeToDie("target")>Env.Arcane["average_burn_length"] and 
                Env.Arcane["burn_phase_duration"]>0
            ) ]]
        ) then          
            Env.Arcane["burn_phase"] = false        
            Env.Arcane["average_burn_length"] = (
                (
                    Env.Arcane["average_burn_length"]*Env.Arcane["total_burns"]-Env.Arcane["average_burn_length"]+Env.Arcane["burn_phase_duration"]
                ) % Env.Arcane["total_burns"]            
            )            
        end 
        Env.Arcane["burn_phase_duration"] = GetTime() - Env.Arcane["start_burn_phase"]        
    else        
        Env.Arcane["conserve_phase"] = true
    end    
end

function Env.ArcanePreCast()
    return 
    Env.LastPlayerCastID==205032 or    
    Env.ArcanePowerCharge()>=4 or
    (
        Env.ArcanePowerCharge()>=3 and 
        select(2, Env.CastTime(30451))>0 -- Arcane Blast
    )     
end

function Env.ArcanePowerCharge()
    return Env.UnitPower("player", Enum.PowerType.ArcaneCharges) or 0
end

-- Fire
Env.Fire = {}
function Env.RefreshFire()
    -- combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)&(!talent.firestarter.enabled|!firestarter.active|active_enemies>=4|active_enemies>=2&talent.flame_patch.enabled)|buff.combustion.up
    local talent_var, RoP_CastTime = 0, select(1, Env.CastTime(116011))
    if Env.TalentLearn(155148) then talent_var = 1 end;    
    Env.Fire["combustion_phase"] = 
    (
        not Env.InPvP() or 
        Env.oMage["PvPUseBurst"]
    ) and   
    (
        (        
            Env.SpellCD(190319)<=RoP_CastTime+(talent_var * Env.GCD()) and 
            (
                not Env.TalentLearn(205026) or 
                UnitHealth("target")<UnitHealthMax("target")*0.9 or 
                (
                    AoE_Toggle and
                    (
                        Env.oMage["active_enemies"]>=4 or 
                        (
                            Env.oMage["active_enemies"]>=2 and 
                            Env.TalentLearn(205037)
                        ) 
                    )
                )
            )            
        ) or 
        Env.Buffs("player",190319,"player")>0 or
        Env.SpellCD(190319)<=0.2
    )
    
    -- rop_phase,if=buff.rune_of_power.up&buff.combustion.down
    Env.Fire["rop_phase"] = 
    (Env.Buffs("player", 116011, "player")>0 or Env.RuneOfPower()>0) and 
    Env.Buffs("player", 190319, "player")==0  
    
    -- PvP
    Env.Fire["SkipFireball"] = not Env.PvPTalentLearn(203275) or not Env.TalentLearn(205026) or not Env.TalentLearn(155148) or not Env.PvPTalentLearn(203283)
end

function Env.Blast_Wave()
    local check = false
    if Env.TalentLearn(157981) then-- Blast Wave
        if Env.SpellUsable(157981) then
            if Env.InPvP() then
                for i = 1, Env.PvPCache["Group_EnemySize"] do
                    local arena = "arena" .. i
                    if Env.UNITRange(arena)<=7 then
                        if Env.PvPDeBuffs(arena, "BreakAble")>0 then
                            check = false
                            break
                        elseif Env.UNITCurrentSpeed(arena)>=100 and Env.PvPBuffs(arena, "Freedom")==0 and Env.PvPBuffs(arena, "TotalImun")==0 and Env.Buffs(arena, {31224, 48707, 227847, 213610})==0 then                    
                            check = true
                        end
                    end            
                end
            elseif Env.UNITEnemy("target") and Env.UNITLevel("target")>0 and AoE(2, 8) then            
                check = true
            end    
        end  
    end    
    return check
end

-- Frost
Env.Frost = {}
function Env.RefreshFrost() 
    -- if=talent.rune_of_power.enabled&active_enemies=1&cooldown.rune_of_power.full_recharge_time<cooldown.frozen_orb.remains
    Env.Frost["talent_rop"] =
    Env.TalentLearn(116011) and -- RoP
    Env.oMage["active_enemies"]==1 and
    80-(Env.ChargesFrac(116011)*40)<Env.SpellCD(84714)
    -- if=active_enemies>3&talent.freezing_rain.enabled|active_enemies>4
    Env.Frost["aoe"] =
    Env.oMage["active_enemies"]>3 and
    (
        Env.TalentLearn(238092) or -- freezing_rain
        Env.oMage["active_enemies"]>4
    )
end

function Env.UsageFrostBolt()
    local casttime = select(1, Env.CastTime(116))
    return 
    (
        Env.LastPlayerCastID~=116 or -- FrostBolt        
        Env.Buffs("player", 190447, "player")==0 -- brain_freeze
    ) and
    (
        Env.UNITCurrentSpeed("player")==0 or 
        Env.Buffs("player", 108839, "player")>casttime+0.1
    )    
end

function Env.FlurryPreCast()
    local casting = select(2, Env.CastTime(44614))
    return Env.LastPlayerCastID==44614 or casting>0
end


-- Cache
Env.oMage = { 
    conserve_mana = UnitPowerMax("player")*0.6,
    active_enemies = 0,
}
function Env.RefreshMage()
    if not TMW then
        return false
    end      
    Env.oMage["MyDamageBuffs"] = Env.MyDamageBuffs()    
    Env.oMage["TargetRange40"] = Env.SpellInteract("target", 40) 
    Env.oMage["MyBurst"] = burst_toggle and Env.MyBurst()
    Env.oMage["active_enemies"] = active_enemies() or 0
    if Env.UNITSpec("player", 62) then 
        Env.RefreshArcane()                
    elseif Env.UNITSpec("player", 63) then
        Env.RefreshFire()
    elseif Env.UNITSpec("player", 64) then
        Env.RefreshFrost() 
    end
    if Env.InPvP() then          
        Env.oMage["PvPTargetingMe"] = Env.PvPTargeting("player")
        Env.oMage["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
        local FHealerCCdur = Env.Get_PvPFriendlyHealerInCC() 
        Env.oMage["PvPFriendlyHealerInCC_KickGroup"] = FHealerCCdur > 0 and FHealerCCdur < 2     
        Env.oMage["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
        Env.oMage["PvPUseBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
        Env.oMage["PvPBreakAble12"] = Env.Zone=="arena" and Env.PvPBreakAble(12) -- Frost Nova
        Env.oMage["PvPBreakAble40"] = Env.PvPBreakAble(40)
        Env.oMage["CheckRaidTTD"] = Env.CheckRaidTTD(1, 4)    FriendlyTeam():GetTTD(1, 4)     
    end       
end

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function (self, elapsed)
        self.elapsed = (self.elapsed or 0) + elapsed;        
        if (self.elapsed > 0.9) then            
            Env.RefreshMage()
            self.elapsed = 0
        end        
end)

for k, v in pairs({"PLAYER_ENTERING_WORLD", "ACTIVE_TALENT_GROUP_CHANGED"}) do
    Listener:Add('Class_Events', v, function()
            wipe(Env.oMage)  
            Env.oMage = { 
                conserve_mana = UnitPowerMax("player")*0.6,
                active_enemies = 0,
            }
            Env.RefreshMage()
    end)
end

Listener:Add('Class_Events', "PLAYER_REGEN_DISABLED", function()
        wipe(Env.Arcane)  
        Env.Arcane = {
            burn_phase = false,
            average_burn_length = 0, 
            burn_phase_duration = 0, 
            total_burns = 0,
        }
        wipe(Env.Fire)
        wipe(Env.Frost)
end)














































