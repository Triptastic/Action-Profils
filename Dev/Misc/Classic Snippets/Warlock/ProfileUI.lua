local A                                                = Action
local WL                                             = A[A.PlayerClass]
local L                                             = {}
L.AUTO                                                 = {
    enUS = "Auto",
    ruRU = "Авто",
}
L.OFF                                                 = {
    enUS = "Off",
    ruRU = "Выкл.",
}
L.AND                                                = {
    enUS = "AND",
    ruRU = "И",
}
L.OR                                                 = {
    enUS = "OR",
    ruRU = "ИЛИ",
}
L.OPERATOR                                            = {
    enUS = "Operator",
    ruRU = "Оператор",
}
L.OPERATOR_TT                                        = {
    enUS = "An operator is a separator between two standing conditions\nThe operator is interpreted verbatim as it is\nIf the both side conditions are 'OFF', then the operator doesn't work",
    ruRU = "Оператор - это разделитель между двумя по бокам стоящими условиями\nОператор трактуется дословно как есть\nЕсли оба боковых условия 'OFF', то оператор не работает",
}
L.GENERAL                                             = {
    enUS = "General", 
    ruRU = "Общее",
}
L.MOUSEOVER                                         = {
    enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover",
}
L.MOUSEOVER_TT                                         = {
    enUS = "Will unlock use actions for @mouseover units\nExample: Fire Shield, Devour Magic, Spell Lock, Banish\n\nFriendly @mouseover will work only through frames\nEnemy @mouseover works through any type (nameplate, 3D model, frame)",
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Огненный щит, Пожирание магии, Запрет чар, Изгнание\n\nДружелюбный @mouseover будет работать только через фреймы\nВражеский @mouseover работает через любой тип (индикатор, 3D модель, фрейм)",
}
L.TARGETTARGET                                         = {
    enUS = "Use\n@targettarget", 
    ruRU = "Использовать\n@targettarget",
}
L.TARGETTARGET_TT                                     = {
    enUS = "Will unlock use actions for @targettarget units\nExample: Fire Shield",
    ruRU = "Разблокирует использование действий для @targettarget юнитов\nНапример: Огненный щит",
}
L.AOE                                                  = {
    enUS = "Use\nAoE", 
    ruRU = "Использовать\nAoE",
}
L.AOE_TT                                             = {
    enUS = "Enable multiunits actions",
    ruRU = "Включает действия для нескольких целей",
}
L.FEARONMC                                            = { 
    enUS = "Use Fear\non charm",
    ruRU = "Использовать Страх\nна подчинении", 
}
L.FEARONMC_TT                                        = { 
    enUS = "This function only works for members of party or raid\nThe unit must be in @target/@mouseover(if enabled)",
    ruRU = "Данная функция работает только на участников группы или рейда\nЮнит должен быть в @target/@mouseover(если включено)", 
}
L.USERACIALONLOC                                    = { 
    enUS = "Auto Racial\nLoss of Control",
    ruRU = "Авто Расовая\nПотеря контроля", 
}
L.USERACIALONLOC_TT                                    = {
    enUS = "The appropriate racial ability will be used as soon as you lose control of the character",
    ruRU = "Будет использоваться соответствующая расовая способность как только вы потеряете контроль над персонажем",
}
L.ROTATION_CONTROL                                    = {
    enUS = "Rotation Control",
    ruRU = "Контроль Ротации",
}
L.FEARMODE                                            = {
    enUS = "Fear Mode",
    ruRU = "Режима Страха",
}
L.FEARMODE_TT                                        = {
    enUS = "Turns on the pre-shutdown mode, which starts\nusing fear control spells of primeval targets",
    ruRU = "Включает режим, работающий до отключения,\nкоторый начинает использовать заклинания контроля страхом первопопавшихся целей",
}
L.POTIONTOUSE                                        = {
    enUS = "Used Potion",
    ruRU = "Используемое Зелье",
}
L.MANAPOTION                                        = {
    enUS = "Mana Potion\n(Mana %) <=",
    ruRU = "Зелье Маны\n(Мана %) <=",
}
L.MANAPOTION_TT                                        = {
    enUS = "In 'Used Potion' must be selected " .. WL.MajorManaPotion:Info(),
    ruRU = "В 'Используемое Зелье' должно быть выбрано " .. WL.MajorManaPotion:Info(),
}
L.MANARUNES                                            = {
    enUS = "Mana Runes\n(Mana %) <=",
    ruRU = "Руны Маны\n(Мана %) <=",
}
L.DARKPACTPLAYERPWR                                    = {
    enUS = WL.DarkPact:Info() .. "\n(@player Mana %) <=",
    ruRU = WL.DarkPact:Info() .. "\n(@player Мана %) <=",
}
L.DARKPACTPETPWR                                    = {
    enUS = WL.DarkPact:Info() .. "\n(@pet Mana %) >=",
    ruRU = WL.DarkPact:Info() .. "\n(@pet Мана %) >=",
}
L.DARKPACTPETPWR_TT                                    = {
    enUS = "This is PET mana!",
    ruRU = "Это мана Питомца!",
}
L.LIFETAPPWR                                        = {
    enUS = WL.LifeTap:Info() .. "\n(Mana %) <=",
    ruRU = WL.LifeTap:Info() .. "\n(Мана %) <=",
}
L.LIFETAPHP                                            = {
    enUS = WL.LifeTap:Info() .. "\n(Health %) >=",
    ruRU = WL.LifeTap:Info() .. "\n(Здоровье %) >=",
}
L.LIFETAPATFULLHP                                    = {
    enUS = WL.LifeTap:Info() .. "\nOn Full Health",
    ruRU = WL.LifeTap:Info() .. "\nНа Полном Здоровье",
}
L.LIFETAPATFULLHP_TT                                = {
    enUS = WL.LifeTap:Info() .. " will be used in free time to\nreplenish the mana of any available missing mana\nOnly if your health is full!",
    ruRU = WL.LifeTap:Info() .. " будет использоваться в свободное\nвремя для восполнения маны любой доступной недостающей маны\nТолько если ваше здоровье полное!",
}
L.DRAINMANAPWR                                        = {
    enUS = WL.DrainMana:Info() .. "\n(Mana %) <=",
    ruRU = WL.DrainMana:Info() .. "\n(Мана %) <=",
}
L.CURSEBOSSORPLAYERPVP                                = {
    enUS = "PvP Curse Boss|Player",
    ruRU = "PvP Проклятие Босс|Игрок",
}
L.CURSEBOSSORPLAYERPVE                                = {
    enUS = "PvE Curse Boss|Player",
    ruRU = "PvE Проклятие Босс|Игрок",
}
L.CURSEOTHERSPVP                                    = {
    enUS = "PvP Curse Others",
    ruRU = "PvP Проклятие Остальные",
}
L.CURSEOTHERSPVE                                    = {
    enUS = "PvE Curse Others",
    ruRU = "PvE Проклятие Остальные",
}
L.PVPDOTSBOSSORPLAYER                                = {
    enUS = "PvP DoTs Boss|Player",
    ruRU = "PvP ДоТы Босс|Игрок",
}
L.PVEDOTSBOSSORPLAYER                                = {
    enUS = "PvE DoTs Boss|Player",
    ruRU = "PvE ДоТы Босс|Игрок",
}
L.DOTSOTHERS                                        = {
    enUS = "PvP|PvE DoTs Others",
    ruRU = "PvP|PvE ДоТы Остальные",
}
L.DRAINSOULTTD                                        = {
    enUS = WL.DrainSoul:Info() .. " (Rank 1)\nTime To Die (sec) <=",
    ruRU = WL.DrainSoul:Info() .. " (Ранк 1)\nВремя смерти (сек) <=",
}
L.DRAINSOULSHARDS                                    = {
    enUS = WL.DrainSoul:Info() .. " (Rank 1)\nSoul Shards <=",
    ruRU = WL.DrainSoul:Info() .. " (Ранк 1)\nОсколки Души <=",
}
L.DEATHCOILMODE                                        = {
    enUS = WL.DeathCoil:Info() .. " Settings",
    ruRU = WL.DeathCoil:Info() .. " Настройки",
}
L.DEFENSE                                            = {
    enUS = "Defense",
    ruRU = "Защита",
}
L.INTERRUPT                                            = {
    enUS = "Interrupt",
    ruRU = "Прерывание",
}
L.BURSTMODE                                            = {
    enUS = "Burst Mode",
    ruRU = "Режим Бурстов",
}
L.DEFENSE_CONTROL                                    = {
    enUS = "Defense Control",
    ruRU = "Контроль Защиты",
}
L.DRAINLIFEHP                                        = {
    enUS = WL.DrainLife:Info() .. "\n(Health %) <=",
    ruRU = WL.DrainLife:Info() .. "\n(Здоровье %) <=",
}
L.SHADOWWARDPERSECHP                                = {
    enUS = WL.ShadowWard:Info() .. "\n(Shadow damage per sec %) >=",
    ruRU = WL.ShadowWard:Info() .. "\n(Урон от тьмы в сек %) >=",
}
L.SHADOWWARDPVP                                        = {
    enUS = "PvP " .. WL.ShadowWard:Info(),
    ruRU = "PvP " .. WL.ShadowWard:Info(),
}
L.SHADOWWARDPVP_TT                                    = {
    enUS = "Use " .. WL.ShadowWard:Info() .. "\n1. With any incoming damage from shadow if it's aimed at you by Priest|Warlock\n2. If in duel you aimed at Priest|Warlock",
    ruRU = "Использовать " .. WL.ShadowWard:Info() .. "\n1. При любом входящем уроне от тьмы если на вас нацелен Жрец|Чернокнижник\n2. Если в дуэле вы нацелены на Жрец|Чернокнижник",
}
L.SACRIFICETTD                                        = {
    enUS = WL.Sacrifice:Info() .. "\nTime To Die (sec) <=",
    ruRU = WL.Sacrifice:Info() .. "\nВремя смерти (сек) <=",
}
L.SACRIFICEHP                                        = {
    enUS = WL.Sacrifice:Info() .. "\n(Health %) <=",
    ruRU = WL.Sacrifice:Info() .. "\n(Здоровье %) <=",
}
L.PET_CONTROL                                        = {
    enUS = "Pet Control",
    ruRU = "Контроль Питомца",
}
L.PHASESHIFTTTD                                        = {
    enUS = WL.PhaseShift:Info() .. "\nTime To Die (sec) <=",
    ruRU = WL.PhaseShift:Info() .. "\nВремя смерти (сек) <=",
}
L.PHASESHIFTHP                                        = {
    enUS = WL.PhaseShift:Info() .. "\n(Health %) <=",
    ruRU = WL.PhaseShift:Info() .. "\n(Здоровье %) <=",
}
L.PHASESHIFTCANCELATHP                                = {
    enUS = WL.PhaseShift:Info() .. " Cancel\n(Health %) >=",
    ruRU = WL.PhaseShift:Info() .. " Отмена\n(Здоровье %) >=",
}
L.CONSUMESHADOWSHP                                    = {
    enUS = WL.ConsumeShadows:Info() .. "\n(Health %) <=",
    ruRU = WL.ConsumeShadows:Info() .. "\n(Здоровье %) <=",
}
L.HEALTHFUNNELSTOPCASTHP                            = {
    enUS = WL.HealthFunnel:Info() .. " StopCast\n(Health %) >=",
    ruRU = WL.HealthFunnel:Info() .. " СтопКаст\n(Здоровье %) >=",
}
L.HEALTHFUNNELSTOPCASTHP_TT                            = {
    enUS = "Only works if 'StopCast' checkbox is enabled in 'General' tab",
    ruRU = "Работает только если 'СтопКаст' чекбокс включен в 'Общей' вкладке",
}
L.HEALTHFUNNELHP                                    = {
    enUS = WL.HealthFunnel:Info() .. "\n(Health %) <=",
    ruRU = WL.HealthFunnel:Info() .. "\n(Здоровье %) <=",
}
L.DEMONICSACRIFICEPET                                = {
    enUS = WL.DemonicSacrifice:Info() .. " On Pets",
    ruRU = WL.DemonicSacrifice:Info() .. " На Питомцах",
}
L.IMP                                                = {
    enUS = "Imp",
    ruRU = "Бес",
}
L.VOIDWALKER                                        = {
    enUS = "Voidwalker",
    ruRU = "Демон Бездны",
}
L.SUCCUBUS                                            = {
    enUS = "Succubus",
    ruRU = "Суккуб",
}
L.FELHUNTER                                            = {
    enUS = "Felhunter",
    ruRU = "Охотник Скверны",
}
L.DOOMGUARD                                            = {
    enUS = "Doomguard",
    ruRU = "Стражник Ужаса",
}
L.OTHERS                                            = {
    enUS = "Others",
    ruRU = "Остальные",
}
L.FIRESHIELDDESINATION                                = {
    enUS = WL.FireShield:Info() .. " Units",
    ruRU = WL.FireShield:Info() .. " Юниты",
}
L.USEINTERRUPTBYPETPVP                                = {
    enUS = "PvP Interrupt By Pet",
    ruRU = "PvP Прерывать Питомцем",
}
L.USEINTERRUPTBYPETPVE                                = {
    enUS = "PvE Interrupt By Pet",
    ruRU = "PvE Прерывать Питомцем",
}
L.USEINTERRUPTBYPET_TT                                = {
    enUS = "This setting affects the MSG system",
    ruRU = "Эта настройка влияет на MSG систему",
}
L.SUMMONPVP                                            = {
    enUS = "PvP Summon Pet",
    ruRU = "PvP Призыв Питомца",
}
L.SUMMONPVE                                            = {
    enUS = "PvE Summon Pet",
    ruRU = "PvE Призыв Питомца",
}
L.TRYTOFINDINVISIBLE                                = {
    enUS = "Try to catch invisible",
    ruRU = "Пытаться поймать невидимок",
}
L.TRYTOFINDINVISIBLE_TT                                = {
    enUS = "Racial ability will be used" .. WL.Perception:Info() .. "\nOnly if the sensor for using a nearby invisibility spell worked",
    ruRU = "Будет использована расовая способность " .. WL.Perception:Info() .. "\nТолько если сработал датчик использования рядом заклинания невидимости",
}
L.MISC                                                = {
    enUS = "Misc",
    ruRU = "Разное",
}
L.HANDSTONETOUSE                                    = {
    enUS = "Use stone in left hand",
    ruRU = "Использовать камень в левой руке",
}
L.FIRESTONE                                            = {
    enUS = "Firestone",
    ruRU = "Камень огня",
}
L.SPELLSTONE                                        = {
    enUS = "Spellstone",
    ruRU = "Камень чар",
}
L.SPELLSTONEUSEDISPEL                                = {
    enUS = L.SPELLSTONE.enUS .. "\nUse as " .. L.DEFENSE.enUS,
    ruRU = L.SPELLSTONE.ruRU .. "\nИспользовать как " .. L.DEFENSE.ruRU,
}
L.SPELLSTONEUSEDISPEL_TT                            = {
    enUS = "Display settings are set in the 'Auras' tab",
    ruRU = "Настройки Диспела задаются во вкладке 'Ауры'",
}
L.SPELLSTONEUSEDEFENSE                                = {
    enUS = L.SPELLSTONE.enUS .. "\nUse as Dispel",
    ruRU = L.SPELLSTONE.ruRU .. "\nИспользовать как Диспел",
}

L.DEFENSE_CONTROL                                    = {
    enUS = "Defense Control",
    ruRU = "Контроль Защиты",
}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v5 (09.03.2019)",
    [2]                                             = { LayoutOptions = { gutter = 3, padding = { left = 3, right = 3 } }  }, 
    [7]                                             = { 
        ["kick"] = { Enabled = true, Key = "SpellLock", LUAVER = 1, LUA = [[ 
                -- This is used for SpellLock, Seduction, Warstomp since they used shared texture with macro
                return     WarlockMSG_CanInterrupt(thisunit ~= "" and thisunit or "target")
            ]] },
        ["dispel"] = { Enabled = true, Key = "DevourMagic", LUAVER = 1, LUA = [[
                -- This is used for DevourMagic, DispelMagic since they used shared texture with macro 
                return     WarlockMSG_CanDispel(thisunit ~= "" and thisunit or "target")
            ]] },
        ["stun"] = { Enabled = true, Key = "Warstomp", LUAVER = 1, LUA = [[
                return     WarlockMSG_CanStun(thisunit ~= "" and thisunit or "target")
            ]] },
        ["fear"] = { Enabled = true, Key = "Fear", LUAVER = 1, LUA = [[
                return     WarlockMSG_CanFear(thisunit ~= "" and thisunit or "target")
            ]] },                    
    },
}
A.Data.ProfileUI[2][1]                                = { -- GENERAL
    RowOptions = { margin = { top = -10 } },
    {
        E         = "Header",
        L         = L.GENERAL, 
    },
}
A.Data.ProfileUI[2][2]                                = {    
    RowOptions = { margin = { top = -5 } },
    {
        E         = "Checkbox", 
        DB         = "mouseover",
        DBV     = true,
        L         = L.MOUSEOVER,
        TT         = L.MOUSEOVER_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "targettarget",
        DBV     = true,
        L         = L.TARGETTARGET,
        TT        = L.TARGETTARGET_TT,
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "AoE",
        DBV     = true,
        L         = L.AOE,
        TT        = L.AOE_TT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][3]                                = {
    {
        E         = "Checkbox", 
        DB         = "FearOnMC",
        DBV     = true,
        L         = L.FEARONMC,
        TT         = L.FEARONMC_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseRacialOnLoC",
        DBV     = true,
        L         = L.USERACIALONLOC,
        TT        = L.USERACIALONLOC_TT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][4]                                = { -- ROTATION CONTROL
    {
        E         = "Header",
        L         = L.ROTATION_CONTROL, 
    },    
}
A.Data.ProfileUI[2][5]                                = { 
    RowOptions = { margin = { top = -20 } },
    {
        E         = "Button",
        H         = 30,
        OnClick = function(self, button, down)     
            if button == "LeftButton" then 
                Action.ToggleFearMode()
            else                
                Action.CraftMacro("FearMode", [[#showtip ]] .. WL.Fear:Info() .. "\n" .. [[/run Action.ToggleFearMode()]], 1, true, true) 
            end 
        end, 
        L         = L.FEARMODE,
        TT         = L.FEARMODE_TT,                            
    },    
}
A.Data.ProfileUI[2][6]                                = {     
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.OFF,                                      value = "OFF"                             },
            { text = WL.HealingPotion:Info(),                     value = "HealingPotion"                 },
            { text = WL.LimitedInvulnerabilityPotion:Info(),     value = "LimitedInvulnerabilityPotion"    },
            { text = WL.LivingActionPotion:Info(),                 value = "LivingActionPotion"             },
            { text = WL.RestorativePotion:Info(),                 value = "RestorativePotion"             },
            { text = WL.SwiftnessPotion:Info(),                 value = "SwiftnessPotion"                 },
            { text = WL.MajorManaPotion:Info(),                 value = "MajorManaPotion"                 },
        },    
        DB         = "PotionToUse",
        DBV     = "MajorManaPotion",
        L         = L.POTIONTOUSE,
        TT         = {
            enUS = A.LTrim([[    Use the selected potion as the main
                                Do not forget to update the macro!
                                
                                HealingPotion macro:
                                /use Major Healing Potion
                                /use Superior Healing Potion
                                /use Greater Healing Potion
                                /use Healing Potion
                                /use Lesser Healing Potion
                                /use Minor Healing Potion
            ]]),
            ruRU = A.LTrim([[    Использовать выбранное зeлье в качестве основного
                                Не забудьте обновить макрос!
                                
                                Макрос зелья исцеления:
                                /use Хорошее лечебное зелье
                                /use Наилучшее лечебное зелье
                                /use Сильное лечебное зелье
                                /use Лечебное зелье
                                /use Простое лечебное зелье
                                /use Слабое лечебное зелье
            ]]),
        },
        M         = {},    
    },    
}
A.Data.ProfileUI[2][7]                                = { 
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 99,                            
        DB         = "ManaPotion",
        DBV     = 25,
        ONLYOFF    = true,
        L         = L.MANAPOTION,
        TT        = L.MANAPOTION_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "Runes",
        DBV     = 100,
        ONOFF     = true,
        L         = L.MANARUNES,
        M         = {},
    },
}
A.Data.ProfileUI[2][8]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 99,                            
        DB         = "DarkPactPlayerPWR",
        DBV     = 50,
        ONLYOFF    = true,
        L         = L.DARKPACTPLAYERPWR,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DarkPactPetPWR",
        DBV     = 25,
        ONLYOFF    = true,
        L         = L.DARKPACTPETPWR,
        TT         = L.DARKPACTPETPWR_TT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][9]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 99,                            
        DB         = "LifeTapPWR",
        DBV     = 50,
        ONLYOFF    = true,
        L         = L.LIFETAPPWR,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "LifeTapHP",
        DBV     = 35,
        ONLYOFF    = true,
        L         = L.LIFETAPHP,
        M         = {},
    },    
}
A.Data.ProfileUI[2][10]                                = {    
    {
        E         = "Checkbox", 
        DB         = "LifeTapAtFullHP",
        DBV     = true,
        L         = L.LIFETAPATFULLHP,
        TT         = L.LIFETAPATFULLHP_TT, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 99,                            
        DB         = "DrainManaPWR",
        DBV     = 8,
        ONLYOFF    = true,
        L         = L.DRAINMANAPWR,
        M         = {},
    },    
}
A.Data.ProfileUI[2][11]                                = { 
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = L.AUTO,                                     value = "AUTO"                             },
            { text = WL.CurseofShadow:Info(),                     value = "CurseofShadow"                 },
            { text = WL.CurseoftheElements:Info(),                 value = "CurseoftheElements"            },
            { text = WL.CurseofRecklessness:Info(),             value = "CurseofRecklessness"             },
            { text = WL.CurseofDoom:Info(),                     value = "CurseofDoom"                     },
            { text = WL.CurseofTongues:Info(),                     value = "CurseofTongues"                 },
            { text = WL.CurseofExhaustion:Info(),                 value = "CurseofExhaustion"                 },
            { text = WL.CurseofAgony:Info(),                     value = "CurseofAgony"                     },
            { text = WL.CurseofWeakness:Info(),                 value = "CurseofWeakness"                 },
            { text = L.OFF,                                     value = "OFF"                             },    
        },
        DB         = "CurseBossOrPlayerPvP",
        DBV     = "AUTO",
        L         = L.CURSEBOSSORPLAYERPVP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = L.AUTO,                                     value = "AUTO"                             },
            { text = WL.CurseofShadow:Info(),                     value = "CurseofShadow"                 },
            { text = WL.CurseoftheElements:Info(),                 value = "CurseoftheElements"            },
            { text = WL.CurseofRecklessness:Info(),             value = "CurseofRecklessness"             },
            { text = WL.CurseofDoom:Info(),                     value = "CurseofDoom"                     },
            { text = WL.CurseofTongues:Info(),                     value = "CurseofTongues"                 },
            { text = WL.CurseofExhaustion:Info(),                 value = "CurseofExhaustion"                 },
            { text = WL.CurseofAgony:Info(),                     value = "CurseofAgony"                     },
            { text = WL.CurseofWeakness:Info(),                 value = "CurseofWeakness"                 },
            { text = L.OFF,                                     value = "OFF"                             },    
        },
        DB         = "CurseBossOrPlayerPvE",
        DBV     = "AUTO",
        L         = L.CURSEBOSSORPLAYERPVE,
        M         = {},
    },
}
A.Data.ProfileUI[2][12]                                = { 
    RowOptions = { margin = { top = -10 } },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = L.AUTO,                                     value = "AUTO"                             },
            { text = WL.CurseofShadow:Info(),                     value = "CurseofShadow"                 },
            { text = WL.CurseoftheElements:Info(),                 value = "CurseoftheElements"            },
            { text = WL.CurseofRecklessness:Info(),             value = "CurseofRecklessness"             },
            { text = WL.CurseofDoom:Info(),                     value = "CurseofDoom"                     },
            { text = WL.CurseofTongues:Info(),                     value = "CurseofTongues"                 },
            { text = WL.CurseofExhaustion:Info(),                 value = "CurseofExhaustion"                 },
            { text = WL.CurseofAgony:Info(),                     value = "CurseofAgony"                     },
            { text = WL.CurseofWeakness:Info(),                 value = "CurseofWeakness"                 },
            { text = L.OFF,                                     value = "OFF"                             },    
        },
        DB         = "CurseOthersPvP",
        DBV     = "AUTO",
        L         = L.CURSEOTHERSPVP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = L.AUTO,                                     value = "AUTO"                             },
            { text = WL.CurseofShadow:Info(),                     value = "CurseofShadow"                 },
            { text = WL.CurseoftheElements:Info(),                 value = "CurseoftheElements"            },
            { text = WL.CurseofRecklessness:Info(),             value = "CurseofRecklessness"             },
            { text = WL.CurseofDoom:Info(),                     value = "CurseofDoom"                     },
            { text = WL.CurseofTongues:Info(),                     value = "CurseofTongues"                 },
            { text = WL.CurseofExhaustion:Info(),                 value = "CurseofExhaustion"                 },
            { text = WL.CurseofAgony:Info(),                     value = "CurseofAgony"                     },
            { text = WL.CurseofWeakness:Info(),                 value = "CurseofWeakness"                 },
            { text = L.OFF,                                     value = "OFF"                             },    
        },
        DB         = "CurseOthersPvE",
        DBV     = "AUTO",
        L         = L.CURSEOTHERSPVE,
        M         = {},
    },    
}
A.Data.ProfileUI[2][13]                                = {    
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = WL.Corruption:Info(),                 value = 1        },
            { text = WL.SiphonLife:Info(),                 value = 2        },
            { text = WL.Immolate:Info(),                 value = 3        },
        },
        DB         = "PvPDoTsBossOrPlayer",
        DBV     = {
            [1]    = true,
            [2] = true,
            [3] = true,
        },
        MULT    = true,
        SetPlaceholder = L.OFF,
        L         = L.PVPDOTSBOSSORPLAYER,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = WL.Corruption:Info(),                 value = 1        },
            { text = WL.SiphonLife:Info(),                 value = 2        },
            { text = WL.Immolate:Info(),                 value = 3        },
        },
        DB         = "PvEDoTsBossOrPlayer",
        DBV     = {
            [1]    = true,
            [2] = false,
            [3] = false,
        },
        MULT    = true,
        SetPlaceholder = L.OFF,
        L         = L.PVEDOTSBOSSORPLAYER,
        M         = {},
    },
}
A.Data.ProfileUI[2][14]                                = {
    RowOptions = { margin = { top = -10 } },
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = WL.Corruption:Info(),                 value = 1        },
            { text = WL.SiphonLife:Info(),                 value = 2        },
            { text = WL.Immolate:Info(),                 value = 3        },
        },
        DB         = "DoTsOthers",
        DBV     = {
            [1]    = true,
            [2] = true,
            [3] = true,
        },
        MULT    = true,
        SetPlaceholder = L.OFF,
        L         = L.DOTSOTHERS,
        M         = {},
    },
}
A.Data.ProfileUI[2][15]                                = {    
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "DrainSoulTTD",
        DBV     = 2,
        ONOFF    = false,
        L         = L.DRAINSOULTTD,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DrainSoulShards",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.DRAINSOULSHARDS,
        M         = {},
    },
}
A.Data.ProfileUI[2][16]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = L.DEFENSE,                 value = 1        },
            { text = L.INTERRUPT,                 value = 2        },
            { text = L.FEARMODE,                 value = 3        },
            { text = L.BURSTMODE,                 value = 4        },
        },
        DB         = "DeathCoilMode",
        DBV     = {
            [1]    = true,
            [2] = true,
            [3] = false,
            [4]    = true,
        },
        MULT    = true,
        SetPlaceholder = L.OFF,
        L         = L.DEATHCOILMODE,
        M         = {},
    },
}
A.Data.ProfileUI[2][17]                                = {    -- DEFENSE CONTROL
    {
        E         = "Header",
        L         = L.DEFENSE_CONTROL, 
    },
}
A.Data.ProfileUI[2][18]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DrainLifeHP",
        DBV     = 10,
        ONLYOFF    = true,
        L         = L.DRAINLIFEHP,
        M         = {},
    },
}
A.Data.ProfileUI[2][19]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "ShadowWardPerSecHP",
        DBV     = 5,
        ONLYOFF    = true,
        L         = L.SHADOWWARDPERSECHP,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "ShadowWardPvP",
        DBV     = true,
        L         = L.SHADOWWARDPVP,
        TT        = L.SHADOWWARDPVP_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][20]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "SacrificeTTD",
        DBV     = 5,
        ONLYOFF    = true,
        L         = L.SACRIFICETTD,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,          value = "AND"     },
            { text = L.OR,          value = "OR"    },
        },
        DB         = "SacrificeOperator",
        DBV     = "AND", 
        L         = L.OPERATOR,
        TT         = L.OPERATOR_TT,
        M = {},                                    
    },    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "SacrificeHP",
        DBV     = 25,
        ONLYOFF    = true,
        L         = L.SACRIFICEHP,
        M         = {},
    },
}
A.Data.ProfileUI[2][21]                                = { -- PET CONTROL
    {
        E         = "Header",
        L         = L.PET_CONTROL, 
    },
}
A.Data.ProfileUI[2][22]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "PhaseShiftTTD",
        DBV     = 8,
        ONLYOFF    = true,
        L         = L.PHASESHIFTTTD,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,          value = "AND"     },
            { text = L.OR,          value = "OR"    },
        },
        DB         = "PhaseShiftOperator",
        DBV     = "AND", 
        L         = L.OPERATOR,
        TT         = L.OPERATOR_TT,
        M = {},                                    
    },    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "PhaseShiftHP",
        DBV     = 30,
        ONLYOFF    = true,
        L         = L.PHASESHIFTHP,
        M         = {},
    },
}
A.Data.ProfileUI[2][23]                                = {    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "PhaseShiftCancelAtHP",
        DBV     = 70,
        ONLYOFF    = true,
        L         = L.PHASESHIFTCANCELATHP,
        M         = {},
    },
}
A.Data.ProfileUI[2][24]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "ConsumeShadowsHP",
        DBV     = 80,
        ONLYOFF    = true,
        L         = L.CONSUMESHADOWSHP,
        M         = {},
    },
}
A.Data.ProfileUI[2][25]                                = {    
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "HealthFunnelStopCastHP",
        DBV     = 100,
        ONOFF    = false,
        L         = L.HEALTHFUNNELSTOPCASTHP,
        TT        = L.HEALTHFUNNELSTOPCASTHP_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "HealthFunnelHP",
        DBV     = 35,
        ONLYOFF    = true,
        L         = L.HEALTHFUNNELHP,
        M         = {},
    },
}
A.Data.ProfileUI[2][26]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = L.IMP,                     value = 1        },
            { text = L.VOIDWALKER,                 value = 2        },
            { text = L.SUCCUBUS,                 value = 3        },
            { text = L.FELHUNTER,                 value = 4        },
            { text = L.DOOMGUARD,                 value = 5        },
            { text = L.OTHERS,                     value = 6        },
        },
        DB         = "DemonicSacrificePet",
        DBV     = {
            [1]    = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = false,
            [6] = false,
        },
        MULT    = true,
        SetPlaceholder = L.OFF,
        L         = L.DEMONICSACRIFICEPET,
        M         = {},
    },
}
A.Data.ProfileUI[2][27]                                = { 
    {
        E         = "Dropdown",                                                         
        OT         = {    
            { text = "@raid1 / @party1",                                            value = 1        },
            { text = "@raid2 / @party2",                                             value = 2        },
            { text = "@raid3 / @party3",                                             value = 3        },
            { text = "@primary (@target, @targettarget, @mouseover)",                 value = 4        },
            { text = "@player",                                                     value = 5        },
        },
        DB         = "FireShieldDesination",
        DBV     = {
            [1]    = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = true,
        },
        MULT    = true,
        SetPlaceholder = L.OFF,
        L         = L.FIRESHIELDDESINATION,
        M         = {},
    },
}
A.Data.ProfileUI[2][28]                                = { 
    {
        E         = "Checkbox", 
        DB         = "UseInterruptByPetPvP",
        DBV     = true,
        L         = L.USEINTERRUPTBYPETPVP,
        TT        = L.USEINTERRUPTBYPET_TT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseInterruptByPetPvE",
        DBV     = true,
        L         = L.USEINTERRUPTBYPETPVE,
        TT        = L.USEINTERRUPTBYPET_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][29]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AUTO,                              value = "AUTO" },
            { text = WL.SummonVoidwalker:Info(),          value = "SummonVoidwalker" },
            { text = WL.SummonSuccubus:Info(),          value = "SummonSuccubus" },
            { text = WL.SummonFelhunter:Info(),          value = "SummonFelhunter" },
            { text = WL.SummonImp:Info(),                  value = "SummonImp" },
            { text = L.OFF,                              value = "OFF" },
        },
        DB         = "SummonPvP",
        DBV     = "AUTO", 
        L         = L.SUMMONPVP,
        M = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AUTO,                              value = "AUTO" },
            { text = WL.SummonVoidwalker:Info(),          value = "SummonVoidwalker" },
            { text = WL.SummonSuccubus:Info(),          value = "SummonSuccubus" },
            { text = WL.SummonFelhunter:Info(),          value = "SummonFelhunter" },
            { text = WL.SummonImp:Info(),                  value = "SummonImp" },
            { text = L.OFF,                              value = "OFF" },
        },
        DB         = "SummonPvE",
        DBV     = "AUTO", 
        L         = L.SUMMONPVE,
        M = {},                                    
    },    
}
A.Data.ProfileUI[2][30]                                = {    -- PvP 
    {
        E         = "Header",
        L         = { ANY = "PvP" }, 
    },
}
A.Data.ProfileUI[2][31]                                = { 
    RowOptions = { margin = { top = -10 } },
    {
        E         = "Checkbox", 
        DB         = "TryToFindInvisible",
        DBV     = true,
        L         = L.TRYTOFINDINVISIBLE,
        TT         = L.TRYTOFINDINVISIBLE_TT, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][32]                                = { -- MISC    
    {
        E         = "Header",
        L         = L.MISC, 
    },
}
A.Data.ProfileUI[2][33]                                = {
    RowOptions = { margin = { top = -5 } },
    {
        E         = "Dropdown",                                                         
        OT         = {            
            { text = L.FIRESTONE,          value = "Firestone"     },
            { text = L.SPELLSTONE,      value = "Spellstone"     },
            { text = L.OFF,              value = "OFF" },
        },
        DB         = "HandStoneToUse",
        DBV     = "Spellstone", 
        L         = L.HANDSTONETOUSE,
        M = {},                                    
    },    
}
A.Data.ProfileUI[2][34]                                = {
    RowOptions = { margin = { top = -5 } },
    {
        E         = "Checkbox", 
        DB         = "SpellstoneUseDispel",
        DBV     = true,
        L         = L.SPELLSTONEUSEDISPEL,
        TT        = L.SPELLSTONEUSEDISPEL_TT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "SpellstoneUseDefense",
        DBV     = true,
        L         = L.SPELLSTONEUSEDEFENSE,
        M         = {},
    },
}

