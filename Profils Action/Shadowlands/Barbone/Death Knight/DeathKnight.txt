--- 
--- 05.06.2019

local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env

local pairs, tostring, tableexist = pairs, tostring, tableexist
local UnitGUID, UnitAttackSpeed, UnitIsUnit, UnitExists = UnitGUID, UnitAttackSpeed, UnitIsUnit, UnitExists
local GetTotemInfo, GetInventoryItemID, GetRuneCooldown, GetPlayerFacing = GetTotemInfo, GetInventoryItemID, GetRuneCooldown, GetPlayerFacing

--- ============================ Toggles ============================
--- Note: /script TMW.CNDT.Env.Toggle("name here") 
function Env.Toggle(name)
    local statement
    if name == "MOUSEOVER" then         
        MouseOver_Toggle = not MouseOver_Toggle
        statement = MouseOver_Toggle
        if TellMeWhen_Group3_Icon1.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 2")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 1")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 1")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 2")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "BURST" then         
        burst_toggle = not burst_toggle
        statement = burst_toggle
        if TellMeWhen_Group3_Icon3.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 4")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 3")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 3")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 4")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "KICK" then         
        kick_toggle = not kick_toggle
        statement = kick_toggle
        if TellMeWhen_Group3_Icon5.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 6")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 5")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 5")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 6")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "AOE" then         
        AoE_Toggle = not AoE_Toggle
        statement = AoE_Toggle
        if TellMeWhen_Group3_Icon7.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 8")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 7")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 7")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 8")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "DS" then         
        DS_Toggle = not DS_Toggle
        statement = DS_Toggle
        if TellMeWhen_Group3_Icon9.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 10")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 9")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 9")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 10")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "DEFF" then         
        Deff_Toggle = not Deff_Toggle
        statement = Deff_Toggle
        if TellMeWhen_Group3_Icon11.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 12")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 11")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 11")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 12")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "DG" then         
        DG_Toggle = not DG_Toggle 
        statement = DG_Toggle
        if TellMeWhen_Group3_Icon13.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 14")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 13")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 13")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 14")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "SM" then         
        SM_Toggle = not SM_Toggle
        statement = SM_Toggle
        if TellMeWhen_Group3_Icon15.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 16")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 15")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 15")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 16")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "AMS" then         
        AMS_Toggle = not AMS_Toggle
        statement = AMS_Toggle
        if TellMeWhen_Group3_Icon17.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 18")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 17")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 17")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 18")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "SIMULACRUM" then         
        if TellMeWhen_Group3_Icon19.Enabled then
            Simulacrum_Toggle = "CHAIN CC"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 20")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 19")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        elseif TellMeWhen_Group3_Icon20.Enabled then
            Simulacrum_Toggle = "DEFF AGRESS"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 21")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 20")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)            
        elseif TellMeWhen_Group3_Icon21.Enabled then
            Simulacrum_Toggle = "MARKED"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 22")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 21")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        elseif TellMeWhen_Group3_Icon22.Enabled then
            Simulacrum_Toggle = "OFF"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 23")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 22")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)            
        else
            Simulacrum_Toggle = "EVERYTHING"  
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 19")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 23")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)            
        end
        statement = Simulacrum_Toggle             
    end 
    
    if name == "DEATHGRIP" then         
        if TellMeWhen_Group3_Icon25.Enabled then
            DeathGrip_Toggle = "DEFF"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 26")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 25")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)            
        elseif TellMeWhen_Group3_Icon26.Enabled then
            DeathGrip_Toggle = "BURST"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 27")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 26")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)                
        elseif TellMeWhen_Group3_Icon27.Enabled then
            DeathGrip_Toggle = "OFF"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 28")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 27")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        else
            DeathGrip_Toggle = "EVERYTHING"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 25")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 28")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end
        statement = DeathGrip_Toggle             
    end 
    
    if name == "DEFFTEAM" then         
        DeffTeam_Toggle = not DeffTeam_Toggle
        statement = DeffTeam_Toggle
        if TellMeWhen_Group3_Icon29.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 30")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 29")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 29")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 30")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "CC" then         
        UseCC_Toggle = not UseCC_Toggle
        statement = UseCC_Toggle
        if TellMeWhen_Group3_Icon31.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 32")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 31")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 31")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 32")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "PETSTUN" then         
        PetStun_Toggle = not PetStun_Toggle
        statement = PetStun_Toggle
        if TellMeWhen_Group3_Icon33.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 34")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 33")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 33")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 34")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "PETDEFF" then         
        PetDeff_Toggle = not PetDeff_Toggle
        statement = PetDeff_Toggle
        if TellMeWhen_Group3_Icon35.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 36")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 35")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 35")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 36")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "PETATTACK" then         
        if TellMeWhen_Group3_Icon37.Enabled then 
            PetAttack_Toggle = "FOCUS"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 38")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 37")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)      
        elseif TellMeWhen_Group3_Icon38.Enabled then
            PetAttack_Toggle = "OFF"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 39")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 38")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            PetAttack_Toggle = "TARGET"
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 37")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 39")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end  
        statement = PetAttack_Toggle        
    end 
    
    if name == "SLOWTARGET" then         
        Slow_Toggle = not Slow_Toggle
        statement = Slow_Toggle
        if TellMeWhen_Group3_Icon40.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 41")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 40")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 40")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 41")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "SLOWFOCUS" then         
        Slow_Toggle_Focus = not Slow_Toggle_Focus
        statement = Slow_Toggle_Focus
        if TellMeWhen_Group3_Icon42.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 43")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 42")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 42")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 43")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "MASSGRIP" then         
        MassGrip_Toggle = not MassGrip_Toggle
        statement = MassGrip_Toggle
        if TellMeWhen_Group3_Icon44.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 45")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 44")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 44")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 45")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "ARMY" then         
        Army_Toggle = not Army_Toggle
        statement = Army_Toggle
        if TellMeWhen_Group3_Icon46.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 47")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 46")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 46")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 47")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    if name == "PVPCD" then         
        PvPCD_Toggle = not PvPCD_Toggle
        statement = PvPCD_Toggle
        if TellMeWhen_Group3_Icon48.Enabled then 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 49")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 48")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)        
        else 
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw enable " .. ptgroup .. " 48")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
            DEFAULT_CHAT_FRAME.editBox:SetText("/tmw disable " .. ptgroup .. " 49")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end         
    end 
    
    DEFAULT_CHAT_FRAME.editBox:SetHistoryLines(1)
    DEFAULT_CHAT_FRAME.editBox:AddHistoryLine("")
    print("[DK] Toggle " .. name .. ": " .. tostring(statement))
end 

Env.oDKBurstBuffs = {
    [252] = {207289}, -- Unholy
    [251] = {51271, 152279, 47568}, -- Frost
    [250] = {81256}, -- Blood
}

-- Cache
Env.oDK = {}   
function Env.RefreshDK()       
    -- General     
    Env.oDK["MyBurstBuffs"] = Env.MyBurstBuffs()
    Env.oDK["AbleBurst"] = burst_toggle and Env.MyBurst()
    Env.oDK["DeffBuffs"] = Env.PvPBuffs("player", "DeffBuffs")  
    Env.oDK["DamageSpellRace"] = Env.SpellRace("DAMAGE")
    Env.oDK["TargetRange"] = Env.PvP.Unit("target"):GetRange()
    -- PvP
    if Env.InPvP() then          
        Env.oDK["PvPTargetingMe"] = Env.PvPTargeting("player")
        Env.oDK["PvPFriendlyHealerID"] = Env.PvPFriendlyHealerID()        
        Env.oDK["PvPFriendlyHealerCC_Duration"]=Env.Get_PvPFriendlyHealerInCC()
        Env.oDK["PvPNeedDeffMe"] = Deff_Toggle and Env.PvPNeedDeff("player")
        Env.oDK["PvPAbleBurst"] = burst_toggle and PvPCD_Toggle and (TimeToDie("target") < 14 or Env.PvPUseBurst("target"))           
        Env.oDK["PvPBreakAble5"] = Env.PvPBreakAble(5)
        Env.oDK["SimulacrumAvailable"] = Env.PvPTalentLearn(77606) and Env.SpellCD(77606) == 0 and not Env.IsIconShown("TMW:icon:1ODmOKrXWpW8")        
    end   
    -- ======================= UNHOLY =======================
    if Env.UNITSpec("player", 252) then             
        Env.oDK["TargetInMelee"] = Env.SpellInRange("target", 85948) or Env.LastPlayerCastID == 49576 -- DeathGrip        
        Env.oDK["AoE_2"] = AoE(2, 5)  -- 5 yards enough for Death and Decay
        Env.oDK["pooling_for_army"] = 
        (
            Army_Toggle and
            Env.IsIconEnabled("TMW:icon:1S5mYpmxlmkf") and 
            Env.oDK["AbleBurst"] and 
            Env.SpellCD(42650) <= Env.RunesTimeCD(3) and 
            (not Env.InPvP() or not Env.PvPTalentLearn(288853)) 
        )        
        Env.oDK["festering_wound"] = Env.DeBuffStack("target", 197147, "player")
        -- Simcraft 
        Env.oDK["pooling_for_gargoyle"] = Env.oDK["AbleBurst"] and Env.TalentLearn(49206) and Env.SpellCD(49206) < 5 
        if Env.InPvP() then
            Env.oDK["PvPDS"] = 
            (
                DS_Toggle and        
                Env.UNITHP("player") < 73 and   
                -- Not Disarmed
                Env.IsIconShown("TMW:icon:1RyPL3Qvp3K9") and
                (
                    -- Extra buff which adding additional +10% heal (free proc)
                    -- or Transfusion
                    (
                        Env.Buffs("player", {101568, 288977}, "player") > 0 and
                        -- PHYS Imun
                        Env.IsIconShown("TMW:icon:1S7iA=JgFoRN")
                    ) or
                    Env.UNITHP("player") < 45 or
                    (
                        Env.PredictDS() and 
                        (
                            (
                                Env.Zone == "pvp" and
                                Env.oDK["PvPTargetingMe"]
                            ) or
                            (
                                Env.UNITHP("player") < 65 and
                                Env.oDK["DeffBuffs"] == 0                
                            ) or
                            (
                                Env.oDK["PvPTargetingMe"] and
                                (
                                    Env.oDK["PvPNeedDeffMe"] or
                                    Env.oDK["PvPFriendlyHealerCC_Duration"] > 0
                                )
                            ) 
                        )                
                    )
                ) 
            )            
        end
    end    
    -- ======================= FROST =======================    
    if Env.UNITSpec("player", 251) then        
        Env.oDK["TargetInMelee"] = Env.SpellInRange("target", 49020) or Env.LastPlayerCastID == 49576 -- DeathGrip       
        Env.oDK["RazoriceStack"] = (not Env.oDK["RuneOfRazorice"] and 5) or Env.DeBuffStack("target", 51714, "player")
        Env.oDK["ColdHeartStack"] = (not Env.TalentLearn(281208) and 0) or Env.BuffStack("player", 281209, "player")                
        -- Simcraft 
        Env.oDK["bos_pooling"] = Env.TalentLearn(152279) and (Env.SpellCD(152279) < 5 or (Env.SpellCD(152279) < 20 and TimeToDie("target") < 35))        
        -- PvP
        if Env.InPvP() then
            Env.oDK["PvPBreakAble8"] = Env.PvPBreakAble(8)
            Env.oDK["PvPDS"] = 
            (
                DS_Toggle and        
                Env.UNITHP("player") < 70 and   
                -- Not Disarmed
                Env.IsIconShown("TMW:icon:1RyPL3Qvp3K9") and
                (
                    -- Extra buff which adding additional +10% heal (free proc)
                    -- or Transfusion
                    (
                        Env.PvP.Unit("player"):HasBuffs({101568, 288977}, "player") > 0 and
                        -- PHYS Imun
                        Env.IsIconShown("TMW:icon:1S7iA=JgFoRN")
                    ) or
                    Env.UNITHP("player") < 45 or
                    (
                        Env.PredictDS() and 
                        (
                            (
                                Env.Zone == "pvp" and
                                Env.oDK["PvPTargetingMe"]
                            ) or
                            (
                                Env.UNITHP("player") < 65 and
                                Env.oDK["DeffBuffs"] == 0                
                            ) or
                            (
                                Env.oDK["PvPTargetingMe"] and
                                (
                                    Env.oDK["PvPNeedDeffMe"] or
                                    Env.oDK["PvPFriendlyHealerCC_Duration"] > 0
                                )
                            ) 
                        )                
                    )
                ) 
            )            
        end
    end 
    -- ======================= BLOOD =======================    
    if Env.UNITSpec("player", 250) then  
        Env.oDK["TargetInMelee"] = 
        (
            Env.SpellInRange("target", 206930) or 
            Env.LastPlayerCastID == 49576 or -- DeathGrip 
            Env.LastPlayerCastID == 108199 -- Gorefiend's Grasp
        )        
        Env.oDK["IsCastingBlooddrinker"] = select(2, Env.CastTime(206931)) > 0
        Env.oDK["BoneShieldStack"] = Env.BuffStack("player", 195181, "player")
    end        
end

for k, v in pairs({"PLAYER_ENTERING_WORLD", "ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_SPECIALIZATION_CHANGED"}) do
    Listener:Add('DK_GeneralEvents', v, function()
            wipe(Env.oDK)  
            Env.oDK["GameBuild"] = GetBuildInfo() 
            Env.RefreshDK()            
    end)
end

-- General
function Env.MyBurstBuffs()
    return 
    (
        -- Unholy
        Env.UNITSpec("player", 252) and 
        (
            -- Unholy Frenzy
            not Env.TalentLearn(207289) and        
            -- Gargoyle
            (
                not Env.TalentLearn(49206) or 
                Env.Gargoyle() > 0 
            )
        )
    ) or
    Env.Buffs("player", Env.oDKBurstBuffs[Env.PlayerSpec], "player") > 0 or    
    Env.PvPBuffs("player", "BurstHaste") > 0 
end

function Env.RP()
    return Env.UnitPower("player", Enum.PowerType.RunicPower) or 0
end

function Env.RPDeficit()
    local max = Env.UnitPowerMax("player", Enum.PowerType.RunicPower) or 0
    return max - Env.RP()
end

local function ReturnGCD(runes)
    -- return summary total gcd time
    local fmod = math.fmod(runes, 2)
    local NeedGCD = 0
    -- Get how much GCD's we need to spend totally to generate X
    if runes > 1 then
        if fmod ~= 0 then     -- if 3, 5
            NeedGCD = (runes - 1) / 2 + fmod
        else                  -- if 2, 4, 6
            NeedGCD = runes / 2
        end            
    else                      -- if 1
        NeedGCD = runes
    end   
    return NeedGCD or 0
end

function Env.Runes()
    local total = 0
    for i = 1, 6 do
        local start, duration, runeReady = GetRuneCooldown(i) 
        if not start then
            return 0
        end
        
        if not runeReady then 
            total = total + 1 
        end 
    end 
    return UnitPower("player", Enum.PowerType.Runes) - total
end

function Env.RunesTimeCD(runes)
    -- Return how much time left until get available "runes" count or 0 if available 
    local runeAmount, summary, oRunes = 0, 0, {}
    for i = 1, 6 do
        local start, duration, runeReady = GetRuneCooldown(i) 
        if not start then
            return 0
        end
        
        if runeReady then 
            runeAmount = runeAmount + 1
            table.insert(oRunes, 0)    
        else 
            table.insert(oRunes, duration - (TMW.time - start))        
        end
        
        if runeAmount >= runes then             
            return 0 
        end
    end 
    table.sort(oRunes, function(x, y)
            return x < y
    end)   
    for i = 1, #oRunes do 
        summary = summary + oRunes[i]
    end 
    return (runes - runeAmount) * summary
end 

function Env.GetLowestRuneTimeCD()
    local oRunes = {}
    for i = 1, 6 do
        local start, duration, runeReady = GetRuneCooldown(i) 
        if not start then
            return 0
        end
        
        if not runeReady then 
            table.insert(oRunes, duration - (TMW.time - start))
        end 
    end 
    table.sort(oRunes, function (x, y)
            return x < y
    end)
    return #oRunes == 0 and 0 or oRunes[1]
end

function Env.PredictDS() 
    local ReceivedLast5sec, HP10 = LastIncDMG("player", 5) * 0.4, UnitHealthMax("player") * 0.1
    -- if this value lower than 10% then set fixed 10% heal    
    if ReceivedLast5sec <= HP10 then         
        ReceivedLast5sec = HP10    
    end 
    -- Extra buff which adding additional +10% heal 
    if Env.Buffs("player", 101568, "player") > 0 then 
        ReceivedLast5sec = ReceivedLast5sec + HP10
    end 
    return UnitHealthMax("player") - UnitHealth("player") >= ReceivedLast5sec or ReceivedLast5sec >= UnitHealthMax("player") * 0.3
end 

-- Unholy 
function Env.Gargoyle()
    local have, name, start, duration = GetTotemInfo(3)
    return duration and duration ~= 0 and (duration - (TMW.time - start)) or 0
end

function Env.RaiseAbomination()
    local have, name, start, duration = GetTotemInfo(1)
    return duration and duration ~= 0 and (duration - (TMW.time - start)) or 0
end

-- Frost 
-- #1 Track Weapon RunicGrave Enchant
-- #2 Track Facing by swing damage for Glacial Advance
local SwingDamage = {}
local LastCastTimeForAMS = 0
Listener:Add('DK_FrostEvents1', "COMBAT_LOG_EVENT_UNFILTERED", function(...)
        local _, EVENT,_, SourceGUID, _,_,_, DestGUID, DestName,_,_, spellID, spellName,_, auraType, Amount = CombatLogGetCurrentEventInfo()
        if EVENT == "SPELL_CAST_SUCCESS" and (spellID == 116858 or spellID == 203286) and DestGUID == UnitGUID("player") then 
            LastCastTimeForAMS = TMW.time
        end 
        
        if not Env.UNITSpec("player", 251) then -- Frost
            return
        end
        
        -- #1
        if not Env.oDK["RuneOfRazorice"] and EVENT == "SPELL_AURA_APPLIED_DOSE" and spellID == 51714 and SourceGUID == UnitGUID("player") then             
            Env.oDK["RuneOfRazorice"] = true                  
        end  
        -- #2
        if (EVENT == "SWING_DAMAGE" or EVENT == "SWING_MISSED") and SourceGUID == UnitGUID("player") then            
            SwingDamage[DestGUID] = {TIME = TMW.time, FACE = GetPlayerFacing()}
        end        
end)

Listener:Add('DK_FrostEvents2', 'PLAYER_REGEN_ENABLED', function()        
        wipe(SwingDamage)
        wipe(Env.oDK)  
        Env.oDK["GameBuild"] = GetBuildInfo() 
        Env.RefreshDK()    
end)

Listener:Add('DK_FrostEvents3', 'PLAYER_REGEN_DISABLED', function()        
        wipe(SwingDamage) 
        Env.oDK["RuneOfRazorice"] = false      
end)

function Env.IsFacing(unit) 
    local GUID = UnitGUID(unit)
    if SwingDamage[GUID] then             
        return TMW.time - SwingDamage[GUID].TIME <= UnitAttackSpeed("player") and (not GetPlayerFacing() or math.abs(GetPlayerFacing()-SwingDamage[GUID].FACE) < 0.53)        
    end
    return false
end

function Env.FrostItem(slot)
    if Env.Item(slot):IsUsable() and Env.Item(slot):IsDPS() then
        local itemID = GetInventoryItemID("player", slot) 
        return 
        (
            -- Razdunk's Big Red Button
            -- On CD
            itemID == 159611 or 
            (
                -- Knot of Ancient Fury
                -- if=cooldown.empower_rune_weapon.remains>40
                itemID == 166795 and
                Env.SpellCD(47568) > 40
            ) or
            (
                -- Grong's Primal Rage
                -- if=rune<=3&!buff.pillar_of_frost.up&(!buff.breath_of_sindragosa.up|!talent.breath_of_sindragosa.enabled)
                itemID == 165574 and
                Env.Runes() <= 3 and
                Env.Unit("player"):HasBuffs(51271, "player") == 0 and
                (
                    not Env.TalentLearn(152279) or
                    Env.Unit("player"):HasBuffs(152279, "player") == 0 
                )
            ) or
            (
                -- Merektha's Fang
                --if=!buff.breath_of_sindragosa.up&!buff.pillar_of_frost.up
                itemID == 158367 and
                Env.Unit("player"):HasBuffs(152279, "player") == 0 and
                Env.Unit("player"):HasBuffs(51271, "player") == 0
            ) or
            -- if=(cooldown.pillar_of_frost.ready|cooldown.pillar_of_frost.remains>20)&(!talent.breath_of_sindragosa.enabled|cooldown.empower_rune_weapon.remains>95)
            (
                itemID ~= 159611 and
                itemID ~= 166795 and
                itemID ~= 165574 and
                itemID ~= 158367 and
                (
                    Env.SpellCD(51271) == 0 or
                    Env.SpellCD(51271) > 20
                ) and
                (
                    not Env.TalentLearn(152279) or
                    Env.SpellCD(47568) > 95
                )
            )
        )
    end
    return false
end

-- Blood
function Env.IsItemDPS(slot)
    local itemID = GetInventoryItemID("player", slot)
    return 
    itemID and 
    (
        itemID == 159611 or -- Razdunk's Big Red Button
        itemID == 158367 -- Merektha's Fang
    )
end
function Env.BloodPredictDS() 
    local ReceivedLast5sec, HP7 = LastIncDMG("player", 5) * 0.25, UnitHealthMax("player") * 0.07
    -- if this value lower than 7% then set fixed 7% heal    
    if ReceivedLast5sec <= HP7 then         
        ReceivedLast5sec = HP7    
    end 
    -- Extra buff which adding additional +10% heal 
    --[[
    if Env.Buffs("player", 101568, "player") > 0 then 
        ReceivedLast5sec = ReceivedLast5sec + HP10
    end ]]
    return UnitHealthMax("player") - UnitHealth("player") >= ReceivedLast5sec or ReceivedLast5sec >= UnitHealthMax("player") * 0.25
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

function Env.GetLastCastTimeForAMS()
    return LastCastTimeForAMS
end
function Env.AntiMagicZone()
    if MacroSpells("Icon6", "Zone-AntiMagic") then 
        return true 
    end 
    if not IsMounted() and CombatTime("player") > 0 and TELLMEWHEN_VERSIONNUMBER >= 85602 and Env.PvPTalentLearn(51052) and Env.PvPCache["Group_FriendlyType"] and tableexist(Env.PvPCache["Group_FriendlySize"]) then 
        for i = 1, Env.PvPCache["Group_FriendlySize"] do 
            local member = Env.PvPCache["Group_FriendlyType"] .. i
            if not Env.UNITDead(member) and Env.PvP.Unit(member):DeBuffCyclone() == 0 and 
            (
                (Deff_Toggle and UnitIsUnit(member, "player")) or 
                (DeffTeam_Toggle and not UnitIsUnit(member, "player") and Env.PvP.Unit(member):GetRange() <= 3)
            ) then 
                local ThisUnitDeff = Env.PvP.Unit(member):HasBuffs("DeffBuffsMagic")
                local ThisUnitHP = Env.UNITHP(member)
                
                -- #1 Against Magic burst if Member without MagicDeff
                if ThisUnitDeff == 0 and ThisUnitHP < 80 and Env.PvP.Unit(member):IsFocused({102, 62, 63, 64, 258, 262, 265, 266, 267}, true) then 
                    local speed = Env.UNITCurrentSpeed(member)
                    return speed == 0 or speed < 70 or Env.PvP.Unit(member):HasDeBuffs("Stuned") > 0 or (Env.PvP.Unit(member):IsHealer() and Env.PvP.Unit(member):HasDeBuffs("Silenced") > 0)
                end 
                
                -- #2 Against casted Greatest Pyroblast or Chaos Bolt 
                if Env.PvP.Unit(member):IsFocused({63, 265, 267}) and tableexist(Env.PvPCache["EnemyDamagerUnitID_Range"]) then
                    for k, arena in pairs(Env.PvPCache["EnemyDamagerUnitID_Range"]) do 
                        if UnitIsUnit(arena .. "target", member) then
                            -- Greatest Pyroblast
                            if TMW.time - SpellLastCast(arena, 203286) < 2 and ThisUnitHP <= 60 and (ThisUnitDeff == 0 or ThisUnitHP <= 40) then 
                                return true 
                            end  
                            
                            -- Chaos Bolt
                            if TMW.time - SpellLastCast(arena, 116858) <= Env.GCD() + Env.CurrentTimeGCD() and
                            (
                                ThisUnitHP <= 35 or
                                (
                                    ThisUnitHP <= 75 and 
                                    Env.PvP.Unit(arena):HasBuffs("DamageBuffs") > 0 and 
                                    ( ThisUnitDeff == 0 or (ThisUnitHP <= 55 and Env.PvP.Unit(member):HasBuffs("CCMagicImun") == 0) )
                                )
                            ) then
                                return true 
                            end                             
                        end 
                    end 
                end 
                
                -- #3 [Arena] Rogue Mage 
                if Env.Zone == "arena" and Env.PvP.Unit(member):IsFocused({259, 260, 261}) and Env.PvP.Unit(member):IsFocused({62, 63, 64}) then 
                    if (ThisUnitDeff == 0 and (Env.PvP.Unit(member):HasDeBuffs(76577) > 0 or (Env.PvP.FriendlyTeam("HEALER"):GetCC() > 2 and Env.PvP.Unit(member):HasDeBuffs("Stuned") > 0))) or 
                    (Env.PvP.Unit(member):IsHealer() and Env.PvP.Unit(member):HasDeBuffs("Silenced") > 0) then 
                        return true 
                    end 
                end 
                
                -- #4 Otherwise 
                if TimeToDieMagic(member) < 7 and ThisUnitHP <= 40 and (ThisUnitDeff == 0 or ThisUnitHP <= 20) then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end


-- Markers
Env.Simulacrum_Mark = {}
function SetMarkSimulacrum(unit)
    if unit and UnitExists(unit) then 
        if Env.Simulacrum_Mark[UnitGUID(unit)] then 
            Env.Simulacrum_Mark[UnitGUID(unit)] = nil 
            print("[DK] Toggle Simulacrum UNMarked: " .. UnitName(unit))
        else 
            Env.Simulacrum_Mark[UnitGUID(unit)] = true
            print("[DK] Toggle Simulacrum Marked: " .. UnitName(unit))            
        end 
    end
end

