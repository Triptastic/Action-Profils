local Action                                        = Action
local A                                                = Action
local WL                                             = A[A.PlayerClass]
local L                                             = {
    MOUSEOVER               = { 
	                            enUS = "Use\n@mouseover", 
                                ruRU = "Использовать\n@mouseover" },
    MOUSEOVERTT             = { 
	                            enUS = "Will unlock use actions for @mouseover units\nExample: Pummel, Charge,  Intercept, Disarm", 
                                ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Зуботычина, Рывок, Перехват, Обезоруживание" },
    AOE                     = { 
	                            enUS = "Use\nAoE",
                                ruRU = "Использовать\nAoE" },
    AOETT                   = { 
	                            enUS = "Enable multiunits actions",
                                ruRU = "Включает действия для нескольких целей" },    
    CORRUPTION              = { 
	                            enUS = "Allow Corruption",
                                ruRU = "Разрешить коррупцию" },
    CORRUPTIONTT            = { 
	                            enUS = "Allow use of Corruption depending of your current raid setup.\nAlways ask before using this in raid since dots spots are limited.",
                                ruRU = "Разрешите использование коррупции в зависимости от вашей текущей настройки рейда.\nВсегда спрашивайте перед использованием этого в рейде, так как точки точек ограничены." },
    PETCHOICE               = { 
                                enUS = "Pet selection", 
                                ruRU = "Выбор питомца", 
                                frFR = "Sélection du familier" },
    PETCHOICETT             = { 
                                enUS = "Choose the pet to summon.", 
                                ruRU = "Выберите питомца для призыва.", 
                                frFR = "Choisir le familier à invoquer." },								
    CURSECHOICE             = { 
                                enUS = "Curse selection",  
                                ruRU = "Проклятие выбора",
                                frFR = "Sélection de la malediction" },
    CURSECHOICETT           = { 
                                enUS = "Choose the Curse to use.", 
                                ruRU = "Выберите проклятие для использования.", 
                                frFR = "Choisir la malédiction à utiliser." },
}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v1 (02.10.2019)",
    [2]                                             = { LayoutOptions = { gutter = 2, padding = { left = 5, right = 5 } }  }, 
    [7]                                             = { 
        ["fear"] = { Enabled = true, Key = "Fear", LUAVER = 1, LUA = [[
                -- This will not switch stance!
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "DamagePhysImun", "KickImun"}
                local castLeft, _, _, _, notInterruptAble = Unit(thisunit):IsCastingRemains() 
                return     Obj.Fear and 
                        Obj.Fear:IsReadyM(thisunit) and 
                        Obj.Fear:AbsentImun(thisunit, Temp) and 
                        castLeft > 0 and     
                        not notInterruptAble 
            ]] },       
    },
}
A.Data.ProfileUI[2][1]                                = {
    {
        E         = "Checkbox", 
        DB         = "mouseover",
        DBV     = true,
        L         = L.MOUSEOVER,
        TT         = L.MOUSEOVERTT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "AoE",
        DBV     = true,
        L         = L.AOE,
        TT         = L.AOETT,
        M         = {},
    },        
}
A.Data.ProfileUI[2][2]                                = {    -- Rotation
    {
        E         = "Header",
        L = {
            ANY = " -- Rotation -- ",
            }, 
    },
}

A.Data.ProfileUI[2][3]                                = {    -- Pets
    {
        E = "Dropdown",                                                         
        OT = {
                { text = A.GetSpellInfo(688), value = "IMP" },
                { text = A.GetSpellInfo(697), value = "VOIDWALKER" },                    
                { text = A.GetSpellInfo(691), value = "FELHUNTER" },
                { text = A.GetSpellInfo(712), value = "SUCCUBUS" },                    
        },
        DB = "PetChoice",
        DBV = "IMP",
        L         = L.PETCHOICE,
        TT         = L.PETCHOICETT,
        M = {},
    },
}

A.Data.ProfileUI[2][4]                                = {    -- Curses
    {
        E = "Dropdown",                                                         
        OT = {
                { text = A.GetSpellInfo(702), value = "CurseofWeakness" },
                { text = A.GetSpellInfo(980), value = "CurseofAgony" },                    
                { text = A.GetSpellInfo(704), value = "CurseofRecklessness" },
                { text = A.GetSpellInfo(1714), value = "CurseofTongues" }, 
                { text = A.GetSpellInfo(1490), value = "CurseoftheElements" },
                { text = A.GetSpellInfo(17862), value = "CurseofShadow" },				
        },
        DB = "CurseChoice",
        DBV = "CurseofAgony",
        L         = L.CURSECHOICE,
        TT         = L.CURSECHOICETT,
        M = {},
    },
}

A.Data.ProfileUI[2][5]                                = { -- Allowed to Corruption
    {
        E         = "Checkbox", 
        DB         = "CorruptionAllow",
        DBV     = true,
        L         = L.CORRUPTION,
        TT         = L.CORRUPTIONTT,
        M         = {},
    },        
}

function Action.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    -- SingeMagic Queue Message 
    --if A[A.PlayerSpec] and A[A.PlayerSpec].SingeMagic:IsReadyM(unit) then                         
    --    return true         
    --end   
end 

function Action.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 
