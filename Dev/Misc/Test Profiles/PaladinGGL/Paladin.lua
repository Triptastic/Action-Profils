---
--- 22.03.2020
---
local TMW                     = TMW
local CNDT                     = TMW.CNDT
local Env                     = CNDT.Env

local Action                 = Action 
local Unit                     = Action.Unit

local pairs, select, wipe     = pairs, select, wipe
local GetSpecializationInfo = GetSpecializationInfo 
local GetSpecialization        = GetSpecialization
local GetFramerate            = GetFramerate
local CreateFrame            = CreateFrame
local UnitGUID                = UnitGUID
local UnitIsUnit            = UnitIsUnit
local UnitExists            = UnitExists
local UnitIsPlayer            = UnitIsPlayer
local UnitInParty            = UnitInParty
local UnitInRaid            = UnitInRaid
local UnitHealth            = UnitHealth
local UnitHealthMax            = UnitHealthMax

local tableexist            = tableexist
local tinsert                = table.insert
local MacroSpells            = MacroSpells
local CombatTime            = CombatTime

local HolyPower             = Enum.PowerType.HolyPower

Env.oPLBurstBuffs = {
    [70] = {31884, 231895}, -- Retribution
    [66] = {31884}, -- Protection
    [65] = {31884, 216331}, -- Holy
}

-- Cache
Env.oPL = {}   
function Env.RefreshPL()       
    -- General     
    Env.oPL["DamageSpellRace"] = Env.SpellRace("DAMAGE")
    Env.oPL["MyBurstBuffs"] = Env.MyBurstBuffs()
    Env.oPL["AbleBurst"] = burst_toggle and Env.MyBurst()
    Env.oPL["DeffBuffs"] = Env.PvPBuffs("player", "DeffBuffs") 
    Env.oPL["TargetRange40"] = Env.SpellInteract("target", 40)     
    -- ======================= HOLY =======================
    if Env.UNITSpec("player", 65) then                     
        Env.oPL["MouseRange40"] = MouseOver_Toggle and Env.SpellInteract("mouseover", 40)
        if Env.PvPCache["Group_FriendlySize"] and Env.PvPCache["Group_FriendlySize"] > 1 then 
            Env.oPL["Innervate"] = Env.Buffs("player", 29166)
        end
        Env.oPL["PvPTargetCyclone"] = Env.DeBuffs("target", 33786)
        if MouseOver_Toggle then 
            Env.oPL["PvPMouseoverCyclone"] = Env.DeBuffs("mouseover", 33786)  
        else
            Env.oPL["PvPMouseoverCyclone"] = 0
        end 
        -- HealingEngine
        Env.oPL["AVG_DMG"] = Env.AVG_DMG()
        Env.oPL["AVG_HPS"] = Env.AVG_HPS()
        Env.oPL["Last5sec_DMG"] = Env.Last5sec_DMG()
        if Env.InPvP() then          
            Env.oPL["PvPTargetingMe"] = Env.PvPTargeting("player")            
            Env.oPL["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")            
            --Env.oPL["PvPAbleBurst"] =  burst_toggle and Env.PvPUseBurst("target") 
            Env.oPL["PvPBreakAble5"] = Env.PvPBreakAble(5)
            --Env.oPL["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
        end 
        -- ======================= PROTECTION =======================    
    elseif Env.UNITSpec("player", 66) then        
        Env.oPL["TargetInMelee"] = Env.UNITRange("target") <= 4
        --Env.oPL["AoE_2"] = AoE(2, 8)
        if Env.InPvP() then          
            Env.oPL["PvPTargetingMe"] = Env.PvPTargeting("player")
            Env.oPL["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
            Env.oPL["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
            Env.oPL["PvPAbleBurst"] =  burst_toggle and (Env.PvPUseBurst("target") or Env.UNITHP("target")<70)
            Env.oPL["PvPBreakAble5"] = Env.PvPBreakAble(5)
        end                
        -- ======================= RETRIBUTION =======================    
    elseif Env.UNITSpec("player", 70) then
        Env.oPL["TargetInMelee"] = Env.SpellInRange("target", 35395) -- Crusader Strike
        Env.oPL["AoE_2"] = AoE(2, 5)      
        Env.oPL["SelflessHealer"] = Env.BuffStack("player",  114250, "player")                    
        Env.oPL["DivinePurpose"] = Env.Buffs("player", 223819, "player")          
        -- (!talent.hammer_of_wrath.enabled|target.health.pct>=20&(buff.avenging_wrath.down|buff.crusade.down)) 
        Env.oPL["HoW"] = 
        not Env.TalentLearn(24275) or 
        (
            UnitHealth("target") >= UnitHealthMax("target") * 0.2 and
            Env.Buffs("player", Env.oPLBurstBuffs[Env.PlayerSpec], "player") == 0
        )
        if Env.InPvP() then          
            Env.oPL["PvPTargetingMe"] = Env.PvPTargeting("player")
            Env.oPL["PvPFriendlyHealerInCC"] = Env.PvPFriendlyHealerInCC()
            Env.oPL["PvPNeedDeffMe"] = Env.PvPNeedDeff("player")
            Env.oPL["PvPAbleBurst"] =  burst_toggle and (Env.PvPUseBurst("target") or Env.UNITHP("target")<70)
            Env.oPL["PvPBreakAble5"] = Env.PvPBreakAble(5)
        end 
    end -- finish    
end
local function PaladinInit()
    wipe(Env.oPL) 
    Env.oPL["GameBuild"] = GetBuildInfo()     
    Env.oPL["ComboPoints"] = Env.PaladinComboPoints()   
    Env.oPL["PvPTargetCyclone"] = 0
    Env.oPL["PvPMouseoverCyclone"] = 0
    Env.RefreshPL()
    -- Retribution 
    if Env.UNITSpec("player", 70) then 
        Env.oPL["SelflessHealer"] = 0
        -- PvP Talent DivinePunisher
        if Env.PvPTalentLearn(204914) then
            Listener:Add('Retri_Events', "COMBAT_LOG_EVENT_UNFILTERED", function(...)
                    local _, EVENT, _, SourceGUID, _,_,_, DestGUID, _, _, _, SpellID  = CombatLogGetCurrentEventInfo()
                    if EVENT=="SPELL_CAST_SUCCESS" and SourceGUID==UnitGUID("player") then    
                        -- Judgement
                        if SpellID == 20271 then    
                            if not Env.oPL["LastGUIDbyJudgement"] or 
                            Env.oPL["LastGUIDbyJudgement"] ~=  DestGUID then
                                Env.oPL["LastGUIDbyJudgement_Counter"] = 0 
                            end
                            Env.oPL["LastGUIDbyJudgement"] = UnitGUID("target")
                            Env.oPL["LastGUIDbyJudgement_Counter"] = Env.oPL["LastGUIDbyJudgement_Counter"]  + 1
                            if Env.oPL["LastGUIDbyJudgement_Counter"] >= 2 then
                                Env.oPL["LastGUIDbyJudgement_Counter"]= 0 
                            end
                        end
                    end                               
            end)
        else 
            Listener:Remove('Retri_Events', "COMBAT_LOG_EVENT_UNFILTERED")
        end                
    end             
end

for k, v in pairs({"ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_SPECIALIZATION_CHANGED"}) do
    Listener:Add('PL_Events', v,  PaladinInit)
end

Listener:Add('Class_Events_CP', "UNIT_POWER_FREQUENT", function()
        Env.oPL["ComboPoints"] = Env.PaladinComboPoints()        
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
            Env.RefreshPL()
            self.elapsed = 0
        end        
end)


-- General
function Env.MyBurstBuffs()
    local dmgracespell = Env.oPL["DamageSpellRace"]
    return 
    Env.Buffs("player", Env.oPLBurstBuffs[Env.PlayerSpec or GetSpecializationInfo(GetSpecialization())], "player")>0 or
    Env.PvPBuffs("player", "BurstHaste")>0 or
    (
        dmgracespell and
        Env.Buffs("player", dmgracespell, "player")>0
    )
end
function Env.PaladinComboPoints()
    return Env.UnitPower("player", HolyPower) or 0
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
function Env.Dispel(unit, Icon)    
    return 
    (
        (
            Icon and 
            MacroSpells(Icon, "Dispel") 
        ) or 
        dispel_toggle
    ) and
    (
        -- SELF 
        (
            UnitIsUnit(unit, "player") and 
            (
                (
                    not Env.UNITSpec("player", 65) and -- Holy            
                    Env.PvPTalentLearn(DispelSpell["CleansingLight"]) and -- AoE Dispel 
                    Env.SpellUsable(DispelSpell["CleansingLight"]) and 
                    Env.LastPlayerCastID ~= DispelSpell["CleansingLight"]
                ) or 
                (
                    not Env.PvPTalentLearn(DispelSpell["CleansingLight"]) and -- AoE Dispel 
                    Env.SpellUsable(DispelSpell[Env.PlayerSpec]) and 
                    Env.LastPlayerCastID ~= DispelSpell[Env.PlayerSpec]
                )
            ) and 
            Env.DeBuffs(unit, DispelSpell["Slow"]) > 2 and 
            Env.UNITCurrentSpeed(unit) > 0 and
            Env.UNITCurrentSpeed(unit) < 100 and
            (
                not Env.UNITSpec("player", 65) or -- Holy
                (
                    not HoF_toggle or 
                    not Env.SpellUsable(1044) -- Freedom
                )
            )
        ) or 
        -- PvE: ANOTHER UNIT   
        (
            -- Useable conditions
            not Env.InPvP() and
            UnitExists(unit) and
            --not UnitIsUnit(unit, "player") and 
            Env.DeBuffs(unit, 33786) == 0 and -- Cyclone
            Env.PvEDispel(unit)             
        ) or
        -- PvP: ANOTHER UNIT   
        (
            -- Useable conditions
            Env.InPvP() and
            UnitExists(unit) and
            --not UnitIsUnit(unit, "player") and 
            Env.DeBuffs(unit, 33786) == 0 and -- Cyclone
            (
                (
                    not Env.UNITSpec("player", 65) and -- Holy            
                    Env.PvPTalentLearn(DispelSpell["CleansingLight"]) and -- AoE Dispel 
                    Env.SpellUsable(DispelSpell["CleansingLight"]) and 
                    Env.LastPlayerCastID ~= DispelSpell["CleansingLight"] and
                    Env.UNITRange(unit) <= 15 
                ) or 
                (
                    not Env.PvPTalentLearn(DispelSpell["CleansingLight"]) and -- AoE Dispel 
                    Env.SpellUsable(DispelSpell[Env.PlayerSpec]) and 
                    Env.LastPlayerCastID ~= DispelSpell[Env.PlayerSpec] and
                    not Env.InLOS(unit) and 
                    Env.SpellInRange(unit, DispelSpell[Env.PlayerSpec])
                )
            ) and 
            -- Dispel types 
            (
                -- Poison CC 
                Env.PvPDeBuffs(unit, "Poison") > 2 or
                (
                    -- Holy Paladin Magic CC 
                    Env.UNITSpec("player", 65) and -- Holy
                    (
                        Env.PvPDeBuffs(unit, "Magic") > 2 or 
                        -- Magic Rooted (if not available freedom)
                        (                            
                            (
                                not HoF_toggle or 
                                not Env.SpellUsable(1044) -- Freedom
                            ) and 
                            select(2, UnitClass(unit)) ~= "DRUID" and
                            Env.PvPDeBuffs(unit, "MagicRooted") > 3 and 
                            Env.PvPUnitIsMelee(unit) and
                            getRealTimeDMG(unit) <= UnitHealthMax(unit) * 0.1 
                        )
                    )
                ) or 
                -- Poison Slowed 
                (
                    not Env.UNITSpec("player", 65) and -- Holy 
                    (
                        not HoF_toggle or 
                        not Env.SpellUsable(1044) -- Freedom
                    ) and     
                    select(2, UnitClass(unit)) ~= "DRUID" and
                    Env.DeBuffs(unit, DispelSpell["Slow"]) > 5 and                        
                    Env.PvPBuffs(unit, "DamageBuffs_Melee") > 6
                )
            )
        )
    ) and
    -- Check another CC types     
    Env.PvPDeBuffs(unit, "Physical") <= Env.CurrentTimeGCD() and 
    -- Hex
    Env.DeBuffs(unit, 51514) <= Env.CurrentTimeGCD()
end

function Env.CleansingLight()
    local check = false 
    if dispel_toggle and Env.PvPTalentLearn(DispelSpell["CleansingLight"]) and Env.SpellUsable(DispelSpell["CleansingLight"]) then
        if not Env.SpellUsable(1044) and -- Freedom
        Env.PvPCache["Group_FriendlyType"] and 
        Env.PvPCache["Group_FriendlyType"] == "party" and         
        Env.DeBuffs("player", DispelSpell["Slow"]) > 2 then 
            check = true 
        elseif tableexist(Env.PvPCache["Group_FriendlySize"]) and Env.PvPCache["Group_FriendlySize"] > 1 then         
            for i = 1, #Env.PvPCache["Group_FriendlySize"] do 
                local member = Env.PvPCache["Group_FriendlyType"] .. i 
                if UnitIsPlayer(member) and 
                Env.DeBuffs(unit, 33786) == 0 and -- Cyclone
                Env.UNITRange(member) <= 15 and 
                (
                    Env.PvPDeBuffs(unit, "Poison") > 2 or 
                    ( 
                        select(2, UnitClass(unit)) ~= "DRUID" and                    
                        Env.DeBuffs(unit, DispelSpell["Slow"]) > 5
                    )
                ) then 
                    check = true 
                    break
                end
            end
        end
    end 
    return check 
end 

function Env.HoF(unit, Icon)    
    local msg = MacroSpells(Icon, "Freedom")
    return
    (
        msg or 
        HoF_toggle  
    ) and
    Env.SpellUsable(1044) and 
    UnitIsPlayer(unit) and
    (
        -- SELF
        (
            UnitIsUnit(unit, "player") and 
            (
                Env.PvPDeBuffs(unit, "Rooted") > Env.CurrentTimeGCD() + Env.GCD() or 
                (
                    Env.UNITCurrentSpeed("player") > 0 and 
                    Env.UNITMaxSpeed("player") < 100
                )
            )
        ) or
        -- ANOTHER UNIT 
        (
            -- Useable conditions
            UnitExists(unit) and 
            not UnitIsUnit(unit, "player") and 
            select(2, UnitClass(unit)) ~= "DRUID" and
            not Env.InLOS(unit) and         
            Env.SpellInRange(unit, 1044) and 
            Env.DeBuffs(unit, 33786) == 0 and -- Cyclone    
            (
                -- MSG System
                msg or 
                -- Rooted and Solar Beam
                (
                    Env.DeBuffs(unit, 78675) > 0 and  
                    Env.PvPDeBuffs(unit, "Rooted") > Env.CurrentTimeGCD()
                ) or 
                -- Rooted without inc dmg 
                (
                    Env.PvPDeBuffs(unit, "Rooted") > 3 and
                    getRealTimeDMG(unit) <= UnitHealthMax(unit) * 0.1 
                ) or 
                -- Slowed (if we no need freedom for self)
                (
                    (
                        -- 8.2 changes Unbound Freedom
                        Env.PvPTalentLearn(305394) or 
                        not Env.oPL["PvPTargetingMe"] or 
                        Env.UNITMaxSpeed("player") >= 100
                    ) and
                    Env.UNITCurrentSpeed(unit) > 0 and 
                    Env.UNITMaxSpeed(unit) < 80 and 
                    (
                        (
                            -- 8.2 changes Unbound Freedom
                            Env.PvPTalentLearn(305394) and 
                            Env.UNITCurrentSpeed("player") < 100
                        ) or 
                        (
                            Env.PvPBuffs(unit, "DamageBuffs") > 6 and 
                            Env.PvPDeBuffs(unit, "Slowed") > 0 and 
                            Env.PvPDeBuffs(unit, "Disarmed") <= Env.CurrentTimeGCD()
                        )
                    )
                ) or 
                (                
                    Action.ZoneID == 1580 and                   -- Ny'alotha - Vision of Destiny
                    Unit(unit):HasDeBuffsStacks(307056) >= 40 -- Burning Madness
                )
            )
        )
    ) and
    -- Check another CC types 
    -- Hex, Polly, Repentance, Blind, Wyvern Sting, Ring of Frost, Paralysis, Freezing Trap, Mind Control
    Env.DeBuffs(unit, {51514, 118, 20066, 2094, 19386, 82691, 115078, 3355, 605}) <= Env.CurrentTimeGCD() and 
    Env.PvPDeBuffs(unit, "Incapacitated") <= Env.CurrentTimeGCD() and 
    Env.PvPDeBuffs(unit, "Disoriented") <= Env.CurrentTimeGCD() and 
    Env.PvPDeBuffs(unit, "Fear") <= Env.CurrentTimeGCD() and 
    Env.PvPDeBuffs(unit, "Stuned") <= Env.CurrentTimeGCD()  
end    

function Env.BoP(unit, Icon)
    local id = 1022
    if Env.PvPTalentLearn(204018) then -- Blessing of Spellwarding (Protection spell replace)
        id = 204018
    end 
    return
    Env.SpellUsable(id) and 
    UnitExists(unit) and 
    UnitIsPlayer(unit) and
    not Env.UNITRole(unit, "TANK") and
    (
        not UnitIsUnit(unit, "player") or
        -- Divine Shield
        Env.SpellCD(642) > 5
    ) and
    not Env.InLOS(unit) and    
    (UnitInRaid(unit) or UnitInParty(unit)) and
    Env.SpellInRange(unit, id) and     
    Env.DeBuffs(unit, {33786, 25771}) == 0 and -- Cyclone and Forbearance   
    ( 
        not Env.InPvP() or
        not Env.PvP.Unit(unit):HasFlags()       
    ) and
    (
        ( 
            Icon and 
            MacroSpells(Icon, "BoP")
        ) or 
        (
            BoP_toggle and 
            id == 1022 and 
            (
                -- Deffensive
                (            
                    incdmgphys(unit) > 0 and 
                    (
                        (
                            Env.UNITSpec("player", 65) and -- Holy
                            Env.UNITHP(unit) <= 38 and 
                            -- Physical real damage still appear
                            select(3, getRealTimeDMG(unit)) > 0
                        ) or
                        (
                            not Env.UNITSpec("player", 65) and -- Holy                            
                            Env.UNITHP(unit) <= 31 and 
                            (
                                Env.oPL["PvPFriendlyHealerInCC"] or
                                TimeToDieX(unit, 20) < 2
                            ) and
                            Env.PvP.Unit(unit):HasBuffs("DeffBuffs") == 0 
                        )
                    ) and                     
                    (
                        -- PvP 
                        (
                            Env.InPvP() and
                            (
                                Env.Unit(unit):IsFocused("MELEE") or
                                (
                                    Env.PvP.Unit(unit):UseDeff() and 
                                    -- Physical real damage still appear
                                    select(3, getRealTimeDMG(unit)) > 0
                                )
                            )
                        ) or
                        -- PvE 
                        not Env.InPvP() 
                    )
                ) or 
                -- Damage DeBuffs
                Env.DeBuffs(unit, {115080, 122470}) > 4 or -- Touch of Death and KARMA
                Env.DeBuffs(unit, 79140) > 15 or -- Vendetta
                -- CC Physical DeBuffs
                (
                    (
                        -- Disarmed
                        (
                            not Env.UNITSpec("player", 70) and -- Retribution
                            Env.PvPUnitIsMelee(unit) and 
                            Env.PvPDeBuffs(unit, "Disarmed") > 4.5 and                             
                            Env.PvPBuffs(unit, "DamageBuffs") > 4                      
                        ) or 
                        -- Another BreakAble CC 
                        (
                            (
                                Env.DeBuffs(unit, 2094) > 3.2 or -- Blind
                                (
                                    Env.DeBuffs(unit, 5246) > 3.2 and -- Intimidating Shout
                                    (
                                        not Env.UNITSpec("player", 70) or -- Retribution
                                        -- Blessing of Sanctuary
                                        not Env.PvPTalentLearn(210256) or 
                                        not Env.SpellUsable(210256)
                                    )
                                )
                            ) and 
                            (
                                not Env.InPvP() or 
                                not Env.PvPTargeting(unit)
                            )
                        ) or 
                        -- HEALER HELP 
                        (
                            Env.UNITRole(unit, "HEALER") and 
                            (
                                Env.PvPDeBuffs(unit, "Stuned") >= 4 or 
                                -- Garrote
                                Env.DeBuffs(unit, 1330) >= 2.5
                            ) and 
                            (
                                not Env.UNITSpec("player", 70) or -- Retribution
                                -- Blessing of Sanctuary
                                not Env.PvPTalentLearn(210256) or  
                                not Env.SpellUsable(210256)
                            ) and 
                            Env.PvPBuffs(unit, "DeffBuffs") <= Env.CurrentTimeGCD() and
                            (
                                not Env.InPvP() or 
                                -- if enemy melee bursting 
                                Env.PvPTargeting_Melee(unit, true) 
                            )
                        ) 
                    ) and 
                    -- Check for non physical CC 
                    (
                        Env.PvPDeBuffs(unit, "Silenced") <= Env.CurrentTimeGCD() or 
                        -- Garrote
                        Env.DeBuffs(unit, 1330) >= 2.5
                    ) and 
                    Env.PvPDeBuffs(unit, "Magic") <= Env.CurrentTimeGCD() and 
                    -- Hex
                    Env.DeBuffs(unit, 51514) <= Env.CurrentTimeGCD()
                )
            )
        )
    )
end



-- PvE

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

-- Retribution
function Env.DivinePunisher(unit)
    return 
    Env.oPL["LastGUIDbyJudgement"] and 
    Env.oPL["LastGUIDbyJudgement"] == UnitGUID(unit) and 
    Env.oPL["LastGUIDbyJudgement_Counter"] and 
    Env.oPL["LastGUIDbyJudgement_Counter"] == 1
end

-- Blessing of Sanctuary
function Env.BoS(unit, Icon)    
    return
    Env.PvPTalentLearn(210256) and 
    Env.SpellUsable(210256) and 
    UnitExists(unit) and 
    not Env.InLOS(unit) and     
    Env.SpellInRange(unit, 210256) and     
    Env.DeBuffs(unit, 33786) == 0 and -- Cyclone
    (
        (
            MacroSpells(Icon, "HoS") and 
            (
                Env.PvPDeBuffs(unit, "Stuned") > 1.5 or 
                Env.PvPDeBuffs(unit, "Fear") > 1.5 or 
                (
                    Env.PvPDeBuffs(unit, "Silenced") > 1.5 and 
                    Env.DeBuffs(unit, 78675) == 0 -- Solar Beam
                )
            )
        ) or 
        (
            HoS_toggle and 
            (
                Env.DeBuffs(unit, {115080, 79140}) == 0 or -- Touch of Death, Vendetta
                not Env.SpellUsable(1022) or -- BoP
                Env.DeBuffs(unit, 25771) > 1 -- Forbearance
            ) and 
            (
                (
                    (
                        Env.DeBuffs(unit, 5246) > 3.5 and -- Intimidating Shout                
                        not Env.PvPTargeting(unit) 
                    ) or 
                    (
                        Env.PvPDeBuffs(unit, "PhysStuned") > 3.5 and 
                        (
                            Env.PvPBuffs(unit, "DamageBuffs") > 3 or 
                            (
                                Env.DeBuffs(unit, 76577) > 0 and -- Smoke Bomb
                                Env.PvPTargeting_Melee(unit, true)
                            )
                        )
                    ) or             
                    (
                        Env.UNITRole(unit, "HEALER") and 
                        (
                            Env.PvPDeBuffs(unit, "Stuned") > 3.5 or
                            Env.PvPDeBuffs(unit, "Fear") > 3.5 or 
                            (
                                Env.PvPDeBuffs(unit, "Silenced") > 3.5 and 
                                Env.DeBuffs(unit, 78675) == 0 -- Solar Beam
                            ) 
                        )  
                    ) 
                ) and 
                -- Hex, Polly, Repentance, Blind, Wyvern Sting, Ring of Frost, Paralysis, Freezing Trap, Mind Control
                Env.DeBuffs(unit, {51514, 118, 20066, 2094, 19386, 82691, 115078, 3355, 605}) <= Env.CurrentTimeGCD() 
            )
        ) 
    )
end

-- Protection
function Env.SacrifaceAble(unit)
    -- Function to check if we can use sacriface with max profit time duration on unit
    local dmg, u_ttd, bubble, shield = incdmg(unit) * 0.7, TimeToDie(unit) * 0.7, Env.Buffs("player", 642, "player"), 1
    -- -20% incoming damage
    local shield_buff = Env.Buffs("player", 498, "player")  
    if shield_buff > 0 then 
        shield = dmg * ( 0.2 - (0.2 - (shield_buff * 0.2 / 8)) )
    end
    
    local p_ttd, p_chp = 0, UnitHealth("player")
    if not Env.PvPTalentLearn(199452) or not Env.InPvP() then
        -- Real player's ttd to lower 20% under sacriface and shield buff
        local p_mhp = UnitHealthMax("player") * 0.2
        if p_chp > p_mhp and dmg > 0 and u_ttd > 0 then 
            local muliplier = 0.75
            -- If Protection then 100% receiving damage by Sacriface
            if Env.UNITSpec("player", 66) then 
                muliplier = 1
            end     
            p_ttd = math.abs(        
                -- Current HP without 20% / incdmg by Sacriface + already exist incdmg for yourself
                (p_chp - p_mhp) /
                (( dmg * muliplier * (1-(GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)/2/100)) ) + getDMG("player") )
            )     
        end
    else
        p_ttd = math.abs(        
            -- Current HP / incdmg by Sacriface + already exist incdmg for yourself
            p_chp /
            (( dmg * (1-(GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)/2/100)) ) + getDMG("player") )
        )    
    end 
    
    if bubble > 0 then 
        p_ttd = p_ttd + bubble
    end
    
    return p_ttd + Env.CurrentTimeGCD() >= u_ttd, p_ttd
end
function Env.HoS(unit, Icon, hp, IsRealDMG, IsDeffensed)  
    return 
    not Env.UNITSpec("player", 70) and -- Retribution
    UnitExists(unit) and 
    UnitIsPlayer(unit) and
    not UnitIsUnit(unit, "player") and
    not Env.InLOS(unit) and 
    (UnitInRaid(unit) or UnitInParty(unit)) and
    Env.SpellUsable(6940) and 
    Env.SpellInRange(unit, 6940) and 
    Env.DeBuffs(unit, 33786) == 0 and -- Cyclone 
    UnitHealth("player") > UnitHealthMax("player") * 0.2 and       
    (
        -- MSG System
        (
            Icon and 
            MacroSpells(Icon, "HoS") 
        ) or  
        -- HoS conditions 
        (
            HoS_toggle and 
            Env.SacrifaceAble(unit) and 
            Env.Buffs(unit, 1022) == 0 and -- BoP 
            -- Check args
            (
                not IsRealDMG or
                getRealTimeDMG(unit) > 0
            ) and 
            ( 
                not IsDeffensed or 
                Env.PvPBuffs(unit, "DeffBuffs") == 0
            ) and 
            -- Check if unit don't will be killed 
            (
                not Env.UNITSpec("player", 65) or -- Holy
                TimeToDie(unit) >= 4 
            ) and 
            -- Conditions
            (
                -- Check for HP arg
                ( 
                    hp and 
                    UnitHealth(unit) <= UnitHealthMax(unit) * (hp / 100)
                ) or 
                -- Another check 
                (
                    TimeToDie(unit) < 14 and 
                    (
                        (
                            UnitHealth(unit) <= UnitHealthMax(unit) * 0.35 and 
                            (
                                getHEAL(unit) * 1.4 < incdmg(unit) or
                                UnitHealth(unit) <= incdmg(unit) * 3.5 
                            ) 
                        ) or 
                        -- if unit has 35% dmg per sec 
                        getRealTimeDMG(unit) >= UnitHealthMax(unit) * 0.35 or 
                        -- if unit has sustain 20% dmg per sec 
                        incdmg(unit) >= UnitHealthMax(unit) * 0.2
                    )
                )
            )
        )
    )
end 

-- Holy
-- Get averange inc dmg/heal for raid/group
Env.gHE = {}
local gHEupdate = CreateFrame("Frame")
gHEupdate:SetScript("OnUpdate", function (self, elapsed)
        self.elapsed = (self.elapsed or 0) + elapsed;
        if (self.elapsed >= 1 and Env.UNITSpec("player", 65) and CombatTime("player") > 0 and Env.PvPCache["Group_FriendlySize"] > 1) then
            tinsert(Env.gHE, {DMG = Group_incDMG(), HEAL = Group_getHEAL()})
            self.elapsed = 0                
        end
end)

Listener:Add('HE_Events', "PLAYER_REGEN_ENABLED", function()
        wipe(Env.gHE)
end)

function Env.AVG_DMG()
    local total = 0
    if tableexist(Env.gHE) and #Env.gHE >= 1 then
        for i = 1, #Env.gHE do
            total = total + Env.gHE[i].DMG
        end
        total = total / #Env.gHE
    end
    return total
end

function Env.AVG_HPS()
    local total = 0
    if tableexist(Env.gHE) and #Env.gHE >= 1 then
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

-- Markers
Env.BoF_Mark = nil
Env.BoL_Mark = nil
function SetMarkBoF(unit)
    if unit and UnitExists(unit) then 
        Env.BoF_Mark = UnitGUID(unit)
    end
    return Env.BoF_Mark 
end
function SetMarkBoL(unit)
    if unit and UnitExists(unit)  then 
        Env.BoL_Mark = UnitGUID(unit)
    end
    return Env.BoL_Mark
end

-- PLAYER LOGIN
PaladinInit()     

