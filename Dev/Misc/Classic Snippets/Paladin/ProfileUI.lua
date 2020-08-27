local A                                                = Action
local PL                                             = A[A.PlayerClass]

local ClassName                                        = _G.LOCALIZED_CLASS_NAMES_MALE
local WARRIOR                                        = ClassName.WARRIOR 
local PALADIN                                        = ClassName.PALADIN 
local HUNTER                                        = ClassName.HUNTER 
local ROGUE                                            = ClassName.ROGUE 
local PRIEST                                        = ClassName.PRIEST 
local MAGE                                            = ClassName.MAGE 
local WARLOCK                                        = ClassName.WARLOCK 
local DRUID                                            = ClassName.DRUID 
local SHAMAN                                        = ClassName.SHAMAN 

local L                                             = {}
L.PVP                                                = {
    ANY = "PvP",
}
L.AND                                                = {
    enUS = "AND",
    ruRU = "И",
}
L.OR                                                 = {
    enUS = "OR",
    ruRU = "ИЛИ",
}
L.OPERATOR_BETWEEN_TT                                = {
    enUS = "An operator is a separator between two standing conditions\nThe operator is interpreted verbatim as it is\nIf the side conditions are OFF, then the operator doesn't work",
    ruRU = "Оператор - это разделитель между двумя по бокам стоящими условиями\nОператор трактуется дословно как есть\nЕсли боковые условия OFF, то оператор не работает",
}
L.UNITS_TT                                            = {
    enUS = A.LTrim([=[
        @raid, @party are valid provided that these units are not the @primary
        @primary is the main unit, it can be @target @mouseover @targettarget
        @HealingEngine members of your group or raid (causes a load on the CPU)
    ]=]),
    ruRU = A.LTrim([=[
        @raid, @party валидны при условии, что эти юниты не являются @primary
        @primary это главная цель, она может быть @target @mouseover @targettarget 
        @HealingEngine участники вашей группы или рейда (вызывает нагрузку на CPU) 
    ]=]),
}
L.MOUSEOVER                                         = {
    enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover",
}
L.MOUSEOVER_TT                                         = {
    enUS = "Will unlock use actions for @mouseover units\nExample: Flash of Light\nSupported macros which have text [@mouseover]",
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Вспышка Светае\nПоддерживает макросы которые имеют [@mouseover]",
}
L.TARGETTARGET                                        = { 
    enUS = "Use\n@targettarget",
    ruRU = "Использовать\n@targettarget" 
}
L.TARGETTARGET_TT                                    = { 
    enUS = "Will unlock use actions\nfor enemy @targettarget units\nSupported macros which have text [@targettarget]",
    ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов\nПоддерживает макросы которые имеют [@targettarget]" 
}
L.AOE                                                 = { 
    enUS = "Use\nAoE",
    ruRU = "Использовать\nAoE" 
}
L.AOE_TT                                             = { 
    enUS = "Enable multiunits actions\nIf this turned off profile will not use spells\nsuch as Consecration, Holy Wrath",
    ruRU = "Включает действия для нескольких целей\nЕсли это выключено профиль не будет использовать способности\nтакие как Освящение, Гнев небес"
}
L.CANCELRF                                             = {
    enUS = "Cancelaura " .. PL.RighteousFury:Info(),
    ruRU = "Отмена эффекта " .. PL.RighteousFury:Info(),
}
L.CANCELRF_TT                                         = {
    enUS = "Automatically removes " .. PL.RighteousFury:Info() .. " if you're not tank and in PvE raid or dungeon",
    ruRU = "Автоматически снимает " .. PL.RighteousFury:Info() .. " если вы не танк и в PvE рейде или подземелье",
}
L.CANCELBOP                                         = {
    enUS = "Cancelaura Invulnerability",
    ruRU = "Отмена эффекта Неуязвимости",
}
L.CANCELBOP_TT                                         = {
    enUS = "Automatically removes if your health more than 50%,\nyou're in combat, you're in melee and using damage rotation\nthe next buff effects:\nBlessing of Protection, Divine Protection, Divine Shield",
    ruRU = "Автоматически снимает если здоровье больше 50%,\nвы в бою, вы в ближнем бою и используете урон ротацию\nслед. положительные эффекты:\nБлагословение защиты, Божественная защита, Божественный щит",
}
L.SHAREDROTATION                                    = {
    enUS = "Shared Rotation",
    ruRU = "Общая Ротация",
}
L.POTIONTOUSE                                        = {
    enUS = "Use potion",
    ruRU = "Использовать зелье",
}
L.POTIONTOUSE_TT                                    = {
    enUS = A.LTrim([[    Use the selected potion as the main
                        Do not forget to update the macro!
                        
                        Healing potion macro:
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
}
L.MANAPOTION                                        = { 
    enUS = "Mana Potion\nMana % <=",
    ruRU = "Зелье Маны\nМана % <=", 
}
L.MANAPOTION_TT                                        = { 
    enUS = "Only if 'Use potion' is " .. PL.MajorManaPotion:Info(),
    ruRU = "Только если 'Использовать зелье' является " .. PL.MajorManaPotion:Info(), 
}
L.USERACIAL_LOC                                        = {
    enUS = "Auto Racial\nLoss of Control",
    ruRU = "Авто Расовая\nПотеря контроля",
}
L.USERACIAL_LOC_TT                                    = {
    enUS = "The appropriate racial ability will be used as soon as you lose control of the character",
    ruRU = "Будет использоваться соответствующая расовая способность как только вы потеряете контроль над персонажем",
}
L.RUNES                                                = { 
    enUS = "Mana Runes\nMana % <=",
    ruRU = "Руны Маны\nМана % <=",
}
L.DAMAGE_ROTATION                                    = {
    enUS = "Damage Rotation",
    ruRU = "Ротация Урона",
}
L.DOWNRANKDAMAGE                                    = {
    enUS = "Downranking Damage",
    ruRU = "Урон пониженными ранками",
}
L.DOWNRANKDAMAGE_TT                                    = {
    enUS = "Damage Rotation will use lower ranks on spells\nif you're out of mana for higher ranks",
    ruRU = "Ротация Урона будет использовать ниже ранки на способностях\nесли у вас недостаточно маны для высших ранков",
}
L.HOLYSHOCKCANDAMAGE                                = {
    enUS = "Use " .. PL.HolyShock:Info() .. " on enemy",
    ruRU = "Использовать " .. PL.HolyShock:Info() .. " на противнике",
}
L.HOLYSHOCKCANDAMAGE_TT                                = {
    enUS = "Spell will be used in damage rotation for @target/@mouseover on enemy",
    ruRU = "Способность будет использоваться в ротации урона для @target/@mouseover на противнике",
}
L.SELFROTATION                                        = {
    enUS = "Self Rotation",
    ruRU = "Личная Ротация",
}
L.SELFROTATION_TT                                    = {
    enUS = "It will enable heal and supportive actions on\nself (@player) while your @target is enemy\nThis can apply unexpected behaivor and sometimes issues in solo mode\nfor example when you will casting heal too often!",
    ruRU = "Это разблокирует исцеляющие и поддерживающие способности\nна себе (@player) пока ваш @target является противником\nЭто может добавить неожиданное поведение и в некоторых случаях затруднения в одиноч. режиме\nнапример, когда вы произносите исцеляющее заклинание слишком часто!",
}
L.HEALING_ROTATION                                    = {
    enUS = "Healing Rotation",
    ruRU = "Ротация Исцеления",
}
L.HEALINGTRINKETSHP                                    = {
    enUS = "Trinkets - Health Percent <=",
    ruRU = "Аксессуары - Процент Здоровья <=",
}
L.HEALINGTRINKETSHP_TT                                = {
    enUS = "Set percentage of health of primary friendly unit (@target/@mouseover)\non which to use trinkets of the support category",
    ruRU = "Выставить процент здоровья главной дружественой цели (@target/@mouseover)\nна котором использовать аксессуары категории поддержки",
}
L.STANCE_AURA                                        = {
    enUS = "Main Aura",
    ruRU = "Главная Аура",
}
L.STANCE_AURA_PVP                                    = {
    enUS = "PvP: Aura",
    ruRU = "PvP: Аура",
}
L.STANCE_AURA_PVE                                    = {
    enUS = "PvE: Aura",
    ruRU = "PvE: Аура",
}
L.STANCE_AURA_TT                                    = {
    enUS = "Auto - Automatically selects aura depending on\already existing auras of other paladins, your talents and your role,\nand other conditions, for example, if you're a healer in PvP and you're focused,\nwhile you are standing this mode can switch the aura in " .. PL.ConcentrationAura:Info(),
    ruRU = "Auto - Автоматический выбор ауры в зависимости\nот уже существующих аур других паладинов, ваших талантов и вашей роли,\nа также других условий, например, если вы лекарь в PvP и в вас играют,\nто в момент когда вы будете стоять этот режим может переключить ауру в " .. PL.ConcentrationAura:Info(),
}
L.SEAL                                                = {
    enUS = "Main Seal",
    ruRU = "Главная Печать",
}
L.SEAL_PVP                                            = {
    enUS = "PvP: Seal",
    ruRU = "PvP: Печать",
}
L.SEAL_PVE                                            = {
    enUS = "PvE: Seal",
    ruRU = "PvE: Печать",
}
L.SEAL_TT                                            = {
    enUS = "Auto - Automatic selection of seal depending on your role, talents and other conditions such as\nif you're in PvP and unit is on a vehicle or under effects accelerating movement, then\nthis mode can switch seal to " .. PL.SealofJustice:Info(),
    ruRU = "Auto - Автоматический выбор печати в зависимости\nот вашей роли, талантов и других условий таких как\nесли вы в PvP и цель на средстве передвижения или под ускоряющими передвижение эффектами, то\nэтот режим может переключить печать в " .. PL.SealofJustice:Info(),
}
L.BLESSINGBUFF                                        = {
    enUS = "Blessing Buff",
    ruRU = "Благословение Бафф",
}
L.BLESSINGBUFFHEALINGENGINEPVP                        = {
    enUS = "PvP: Use in HealingEngine",
    ruRU = "PvP: Использовать в HealingEngine",
}
L.BLESSINGBUFFHEALINGENGINEPVE                        = {
    enUS = "PvE: Use in HealingEngine",
    ruRU = "PvE: Использовать в HealingEngine",
}
L.BLESSINGBUFFHEALINGENGINE_TT                        = {
    enUS = "HealingEngine - this is a system for target select among the members of your group\nAn included option will allow you to select members with missing buffs",
    ruRU = "HealingEngine - это система выбора цели среди участников вашей группы\nВключенная опция позволит выбирать участников с отсутствющими баффами",
}
L.BLESSINGBUFFREMAINDURATIONPVP                        = {
    enUS = "PvP: Remaining duration (sec) <=",
    ruRU = "PvP: Оставшаяся продолж. (сек) <=",
}
L.BLESSINGBUFFREMAINDURATIONPVE                        = {
    enUS = "PvE: Remaining duration (sec) <=",
    ruRU = "PvE: Оставшаяся продолж. (сек) <=",
}
L.BLESSINGBUFFREMAINDURATION_TT                        = {
    enUS = "Time in seconds from which to renew the effect",
    ruRU = "Время в секундах с которого переобновить эффект",
}
L.BLESSINGBUFFSOLOPVP                                = {
    enUS = "PvP: Solo Mode",
    ruRU = "PvP: Одиночный Режим",
}
L.BLESSINGBUFFSOLOPVE                                = {
    enUS = "PvE: Solo Mode",
    ruRU = "PvE: Одиночный Режим",
}
L.BLESSINGBUFFSOLO_TT                                = {
    enUS = "Solo Mode - this is when you are outside the group\nAuto - Choose a buff depending on your role, talents and\nother buffs previously buffed by other paladins",
    ruRU = "Одиночный Режим - это тогда, когда вы вне группы\nAuto - Выбирать бафф в зависимости от вашей роли, талантов и\nдругих ранее наложенных баффами другими паладинами",
}
L.BLESSINGOFKINGSPVP                                = {
    enUS = "Group | Others\nPvP: " .. PL.BlessingofKings:Info(),
    ruRU = "Группа | Другие\nPvP: " .. PL.BlessingofKings:Info(),
}
L.BLESSINGOFKINGSPVE                                = {
    enUS = "Group | Others\nPvE: " .. PL.BlessingofKings:Info(),
    ruRU = "Группа | Другие\nPvE: " .. PL.BlessingofKings:Info(),
}
L.BLESSINGOFLIGHTPVP                                = {
    enUS = "Group | Others\nPvP: " .. PL.BlessingofLight:Info(),
    ruRU = "Группа | Другие\nPvP: " .. PL.BlessingofLight:Info(),
}
L.BLESSINGOFLIGHTPVE                                = {
    enUS = "Group | Others\nPvE: " .. PL.BlessingofLight:Info(),
    ruRU = "Группа | Другие\nPvE: " .. PL.BlessingofLight:Info(),
}
L.BLESSINGOFMIGHTPVP                                = {
    enUS = "Group | Others\nPvP: " .. PL.BlessingofMight:Info(),
    ruRU = "Группа | Другие\nPvP: " .. PL.BlessingofMight:Info(),
}
L.BLESSINGOFMIGHTPVE                                = {
    enUS = "Group | Others\nPvE: " .. PL.BlessingofMight:Info(),
    ruRU = "Группа | Другие\nPvE: " .. PL.BlessingofMight:Info(),
}
L.BLESSINGOFSALVATIONPVP                            = {
    enUS = "Group | Others\nPvP: " .. PL.BlessingofSalvation:Info(),
    ruRU = "Группа | Другие\nPvP: " .. PL.BlessingofSalvation:Info(),
}
L.BLESSINGOFSALVATIONPVE                            = {
    enUS = "Group | Others\nPvE: " .. PL.BlessingofSalvation:Info(),
    ruRU = "Группа | Другие\nPvE: " .. PL.BlessingofSalvation:Info(),
}
L.BLESSINGOFSANCTUARYPVP                            = {
    enUS = "Group | Others\nPvP: " .. PL.BlessingofSanctuary:Info(),
    ruRU = "Группа | Другие\nPvP: " .. PL.BlessingofSanctuary:Info(),
}
L.BLESSINGOFSANCTUARYPVE                            = {
    enUS = "Group | Others\nPvE: " .. PL.BlessingofSanctuary:Info(),
    ruRU = "Группа | Другие\nPvE: " .. PL.BlessingofSanctuary:Info(),
}
L.BLESSINGOFWISDOMPVP                                = {
    enUS = "Group | Others\nPvP: " .. PL.BlessingofWisdom:Info(),
    ruRU = "Группа | Другие\nPvP: " .. PL.BlessingofWisdom:Info(),
}
L.BLESSINGOFWISDOMPVE                                = {
    enUS = "Group | Others\nPvE: " .. PL.BlessingofWisdom:Info(),
    ruRU = "Группа | Другие\nPvE: " .. PL.BlessingofWisdom:Info(),
}
L.BLESSINGGROUPOTHERS_TT                            = {
    enUS = A.LTrim([=[
        Choose the classes you want to bless
        You can choose the same classes for different blessings
        Rotation checks and verifies different ranks of both great and normal effects
        If the effect was previously applied by another paladin, this blessing will not be used
        In the group will be in priority a great blessing, if you want the normal, then put
        'set blocker' in the Actions tab for a great blessing
        Outside the group, casual players will use the normal blessing anyway
    ]=]),
    ruRU = A.LTrim([=[
        Выберите классы которые вы хотите благословить
        Вы можете выбрать одни и те же классы для разных благословений
        Ротация проверяет и сверяет разные ранки как великих так и обычных эффектов 
        Если эффект был ранее наложен другим паладином, то это благословение не будет использовано 
        В группе будет в приоритете великое благословение, если вы хотите обычное, то  
        'установите блокировку' во вкладке Действия для великого благословения 
        Вне группы на случайных игроках будет использовано обычное благословение в любом случае
    ]=]),
}
L.BLESSINGOFPROTECTION                                = {
    ANY = PL.BlessingofProtection:Info(),
}
L.BLESSINGOFPROTECTIONHP                            = {
    enUS = "B. of Protection\nHealth % <=",
    ruRU = PL.BlessingofProtection:Info() .. "\nЗдоровье % <=",
}
L.BLESSINGOFPROTECTIONOPERATOR                        = {
    enUS = "B. of Protection\nOperator",
    ruRU = PL.BlessingofProtection:Info() .. "\nОператор",
}
L.BLESSINGOFPROTECTIONTTD                            = {
    enUS = "B. of Protection\nTime to die (sec) <=",
    ruRU = PL.BlessingofProtection:Info() .. "\nВремя смерти (сек) % <=",
}
L.BLESSINGOFPROTECTIONUNITS                            = {
    enUS = PL.BlessingofProtection:Info() .. " - Units",
    ruRU = PL.BlessingofProtection:Info() .. " - Цели",
}
L.BLESSINGOFPROTECTIONADDITIONAL                    = {
    enUS = PL.BlessingofProtection:Info() .. " - Additional Settings",
    ruRU = PL.BlessingofProtection:Info() .. " - Дополнительные Настройки",
}
L.BLESSINGOFPROTECTIONADDITIONAL_1                    = {
    enUS = "PvE Threat",
    ruRU = "PvE Угроза",
}
L.BLESSINGOFPROTECTIONADDITIONAL_2                    = {
    enUS = "PvE Skip tanks",
    ruRU = "PvE Пропускать танков",
}
L.BLESSINGOFPROTECTIONADDITIONAL_3                    = {
    enUS = "Auras",
    ruRU = "Ауры",
}
L.BLESSINGOFPROTECTIONADDITIONAL_4                    = {
    enUS = "Only Self",
    ruRU = "Только на себя",
}
L.BLESSINGOFPROTECTIONADDITIONAL_TT                    = {
    enUS = A.LTrim([=[
        PvE Threat - Then when a unit has a 100% threat to its target
        PvE Skip Tanks - Do not use on tanks
        Auras - See the 'Auras' tab for this ability category for PvE and PvP modes
        Self only - Will use the ability only on himself (@player)
    ]=]),
    ruRU = A.LTrim([=[
        PvE Угроза - Тогда когда юнит имеет по отноешнию к своей цели 100% угрозу
        PvE Пропускать танков - Не использовать на танках
        Ауры - Смотрите вкладку 'Ауры' в категории данной способности для PvE и PvP режимов
        Только на себя - Будет использовать способность только на себе (@player)
    ]=]),
}
L.BLESSINGOFSACRIFICE                                = {
    ANY = PL.BlessingofSacrifice:Info(),
}
L.BLESSINGOFSACRIFICEHP                                = {
    enUS = "B. of Sacrifice\nHealth % <=",
    ruRU = "Б. жертвенности\nЗдоровье % <=",
}
L.BLESSINGOFSACRIFICEOPERATOR                        = {
    enUS = "B. of Sacrifice\nOperator",
    ruRU = "Б. жертвенности\nОператор",
}
L.BLESSINGOFSACRIFICETTD                            = {
    enUS = "B. of Sacrifice\nTime to die (sec) <=",
    ruRU = "Б. жертвенности\nВремя смерти (сек) % <=",
}
L.BLESSINGOFSACRIFICEUNITS                            = {
    enUS = PL.BlessingofSacrifice:Info() .. " - Units",
    ruRU = PL.BlessingofSacrifice:Info() .. " - Цели",
}
L.BLESSINGOFSACRIFICEADDITIONAL                        = {
    enUS = PL.BlessingofSacrifice:Info() .. " - Additional Settings",
    ruRU = PL.BlessingofSacrifice:Info() .. " - Дополнительные Настройки",
}
L.BLESSINGOFSACRIFICEADDITIONAL_1                    = {
    enUS = "Auras",
    ruRU = "Ауры",
}
L.BLESSINGOFSACRIFICEADDITIONAL_2                    = {
    enUS = "PvP Dodge casters spell control",
    ruRU = "PvP Уклоняться от кастующих контроль заклинаний",
}
L.BLESSINGOFSACRIFICEADDITIONAL_3                    = {
    enUS = "PvP Support on the flag courier",
    ruRU = "PvP Поддерживать на флагоносце",
}
L.BLESSINGOFSACRIFICEADDITIONAL_TT                    = {
    enUS = A.LTrim([=[
        Auras - See the 'Auras' tab for this ability category for PvE and PvP modes
        PvP Dodge casters spell control - Only if you're not focused and enemy want to control
        PvP Support on the flag courier - Keep the effect on the unit with the flag on the battlefield
    ]=]),
    ruRU = A.LTrim([=[
        Ауры - Смотрите вкладку 'Ауры' в категории данной способности для PvE и PvP режимов
        PvP Уклоняться от кастующих контроль заклинаний - Только если в вас не играют и хотят законтролить
        PvP Поддерживать на флагоносце - Держать эффект на юните с флагом на полях боя
    ]=]),
}
L.BLESSINGOFFREEDOM                                    = {
    ANY = PL.BlessingofFreedom:Info(),
}
L.BLESSINGOFFREEDOMUNITS                            = {
    enUS = PL.BlessingofFreedom:Info() .. " - Units",
    ruRU = PL.BlessingofFreedom:Info() .. " - Цели",
}
L.BLESSINGOFFREEDOMADDITIONAL                        = {
    enUS = PL.BlessingofSacrifice:Info() .. " - Additional Settings",
    ruRU = PL.BlessingofSacrifice:Info() .. " - Дополнительные Настройки",
}
L.BLESSINGOFFREEDOMADDITIONAL_1                        = {
    enUS = "Auras",
    ruRU = "Ауры",
}
L.BLESSINGOFFREEDOMADDITIONAL_2                        = {
    enUS = "Slowed",
    ruRU = "Замедленный",
}
L.BLESSINGOFFREEDOMADDITIONAL_3                        = {
    enUS = "Only self",
    ruRU = "Только на себе",
}
L.BLESSINGOFFREEDOMADDITIONAL_4                        = {
    enUS = "Without another CC",
    ruRU = "Без другого CC",
}
L.BLESSINGOFFREEDOMADDITIONAL_TT                    = {
    enUS = A.LTrim([=[
        Auras - See the 'Auras' tab for this ability category for PvE and PvP modes
        Slowed - If the unit's movement speed is more than 68 and less than or equal to 90
        Only on myself - Will use the ability only on myself (@player)
        Without another CC - If there is no other effect of loss of control
    ]=]),
    ruRU = A.LTrim([=[
        Ауры - Смотрите вкладку 'Ауры' в категории данной способности для PvE и PvP режимов
        Замедленный - Если скорость передвижения юнита более 68 и меньше или равно 90
        Только на себе - Будет использовать способность только на себе (@player)
        Без другого CC - Если нет другого эффекта потери контроля
    ]=]),
}
L.DISPEL                                            = {
    enUS = "Dispel\n" .. PL.Cleanse:Info() .. " | " .. PL.Purify:Info(),
    ruRU = "Рассеивание\n" .. PL.Cleanse:Info() .. " | " .. PL.Purify:Info(),
}
L.DISPELUNITS                                        = {
    enUS = "Dispel - Units",
    ruRU = "Рассеивание - Цели",
}
L.DISPELADDITIONAL                                    = {
    enUS = "Dispel - Additional Settings",
    ruRU = "Рассеивание - Дополнительные Настройки",
}
L.DISPELADDITIONAL_1                                = {
    enUS = "Magic Auras",
    ruRU = "Магические Ауры",
}
L.DISPELADDITIONAL_2                                = {
    enUS = "Poison Auras",
    ruRU = "Ядовитые Ауры",
}
L.DISPELADDITIONAL_3                                = {
    enUS = "Disease Auras",
    ruRU = "Ауры Болезней",
}
L.DISPELADDITIONAL_4                                = {
    enUS = "Only Self",
    ruRU = "Только Себя",
}
L.DIVINEINTERVENTION                                = {
    ANY = PL.DivineIntervention:Info(),
}
L.DIVINEINTERVENTIONHP                                = {
    enUS = "D. Intervention\nHealth % <=",
    ruRU = "Б. Вмешательство\nЗдоровье % <=",
}
L.DIVINEINTERVENTIONOPERATOR                        = {
    enUS = "D. Intervention\nOperator",
    ruRU = "Б. Вмешательство\nОператор",
}
L.DIVINEINTERVENTIONTTD                                = {
    enUS = "D. Intervention\nTime to die (sec) <=",
    ruRU = "Б. Вмешательство\nВремя смерти (сек) % <=",
}
L.DIVINEINTERVENTIONMANA                            = {
    enUS = "D. Intervention\nYour Mana % <=",
    ruRU = "Б. Вмешательство\nВаша Мана % <=",
}
L.DIVINEINTERVENTIONMANA_TT                            = {
    enUS = "This is an additional condition that does not depend on the operator\nIt limits the fulfillment of any conditions depending on the value of your mana",
    ruRU = "Это дополнительное условие, которое не зависит от оператора\nОграничивает выполнений любых условий в зависимости от значения вашей маны",
}
L.DIVINEINTERVENTIONONRAIDWIPEPVE                    = {
    enUS = PL.DivineIntervention:Info() .. "\nOn Raid Wipe",
    ruRU = PL.DivineIntervention:Info() .. "\nНа Рейд Вайпе",
}
L.DIVINEINTERVENTIONONRAIDWIPEPVE_TT                = {
    enUS = "Only PvE\nWill sacrifice a paladin on a unit that can revive if more than 60% of the raid is dead",
    ruRU = "Только PvE\nБудет жертвовать паладином на юните, который может возродить, если более 60% рейда мертвы",
}
L.DEFENSE                                            = {
    enUS = "Defense",
    ruRU = "Защита",
}
L.STONEFORM                                            = {
    enUS = PL.Stoneform:Info() .. " - Health % <=",
    ruRU = PL.Stoneform:Info() .. " - Здоровье % <=",
}
L.DIVINESHIELDHP                                    = {
    enUS = PL.DivineShield:Info() .. "\nHealth % <=",
    ruRU = PL.DivineShield:Info() .. "\nЗдоровье % <=",
}
L.DIVINESHIELDOPERATOR                                = {
    enUS = PL.DivineShield:Info() .. "\nOperator",
    ruRU = PL.DivineShield:Info() .. "\nОператор",
}
L.DIVINESHIELDTTD                                    = {
    enUS = PL.DivineShield:Info() .. "\nTime to die (sec) <=",
    ruRU = PL.DivineShield:Info() .. "\nВремя смерти (сек) % <=",
}
L.DIVINEPROTECTIONHP                                = {
    enUS = PL.DivineProtection:Info() .. "\nHealth % <=",
    ruRU = PL.DivineProtection:Info() .. "\nЗдоровье % <=",
}
L.DIVINEPROTECTIONOPERATOR                            = {
    enUS = PL.DivineProtection:Info() .. "\nOperator",
    ruRU = PL.DivineProtection:Info() .. "\nОператор",
}
L.DIVINEPROTECTIONTTD                                = {
    enUS = PL.DivineProtection:Info() .. "\nTime to die (sec) <=",
    ruRU = PL.DivineProtection:Info() .. "\nВремя смерти (сек) % <=",
}
L.FIND_INVISIBLE                                    = {
    enUS = "Try to catch invisible",
    ruRU = "Пытаться поймать невидимок",
}
L.FIND_INVISIBLE_TT                                    = {
    enUS = "Racial ability will be used" .. PL.Perception:Info() .. " and " .. PL.Consecration:Info() .. "\nOnly if the sensor for using a nearby invisibility spell worked",
    ruRU = "Будет использована расовая способность " .. PL.Perception:Info() .. " и " .. PL.Consecration:Info() .. "\nТолько если сработал датчик использования рядом заклинания невидимости",
}
L.RANK_HEALING                                        = {
    enUS = "Rank Healing Management",
    ruRU = "Управление Ранк Исцелением",
}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v5 (23.02.2020)",
    [2]                                             = { LayoutOptions = { gutter = 3, padding = { left = 3, right = 3 } }  }, 
    [7]                                             = { 
        ["dispel"] = { Enabled = true, Key = "Cleanse", LUAVER = 1, LUA = [[
            return not Unit(currunit):IsEnemy() and IsAbleDispel(thisunit or "target", nil, true)
        ]] },
        ["blessing of protection"] = { Enabled = true, Key = "BlessingofProtection", LUAVER = 1, LUA = [[
            return not Unit(currunit):IsEnemy() and IsAbleBoP(thisunit or "target", nil, true)
        ]] },
        ["blessing of sacrifice"] = { Enabled = true, Key = "BlessingofSacrifice", LUAVER = 1, LUA = [[
            return not Unit(currunit):IsEnemy() and IsAbleBoS(thisunit or "target", nil, true)
        ]] },
        ["blessing of freedom"] = { Enabled = true, Key = "BlessingofFreedom", LUAVER = 1, LUA = [[
            return not Unit(currunit):IsEnemy() and IsAbleBoF(thisunit or "target", nil, true)
        ]] },
        ["stun"] = { Enabled = true, Key = "HammerofJustice", LUAVER = 1, LUA = [[
            local Obj         = Action[Action.PlayerClass]
            local currunit     = thisunit or "target"
            return     Obj and
                    Obj.HammerofJustice and 
                    Obj.HammerofJustice:IsReadyM(currunit) and 
                    LossOfControl:Get("SILENCE") == 0 and 
                    LossOfControl:Get("SCHOOL_INTERRUPT", "HOLY") == 0 and 
                    Unit(currunit):IsEnemy() and 
                    Unit(currunit):IsControlAble("stun", 0) and 
                    Obj.HammerofJustice:AbsentImun(currunit, {"TotalImun", "CCTotalImun", "StunImun", "Reflect"})
        ]] },
        ["kick"] = { Enabled = true, Key = "Repentance", LUAVER = 1, LUA = [[
            local Obj         = Action[Action.PlayerClass]
            local currunit     = thisunit or "target"
            return     Obj and
                    Obj.Repentance and 
                    Obj.Repentance:IsReadyM(currunit) and 
                    LossOfControl:Get("SILENCE") == 0 and 
                    LossOfControl:Get("SCHOOL_INTERRUPT", "HOLY") == 0 and 
                    Unit(currunit):IsEnemy() and 
                    Unit(currunit):IsCastingRemains() > 0 and 
                    Unit(currunit):IsControlAble("incapacitate", 0) and 
                    Obj.Repentance:AbsentImun(currunit, {"TotalImun", "CCTotalImun", "Reflect"})
        ]] },
        ["fear"] = { Enabled = true, Key = "TurnUndead", LUAVER = 1, LUA = [[
            local Obj         = Action[Action.PlayerClass]
            local currunit     = thisunit or "target"
            return     Obj and
                    Obj.TurnUndead and 
                    Obj.TurnUndead:IsReadyM(currunit) and 
                    Player:IsStaying() and 
                    LossOfControl:Get("SILENCE") == 0 and 
                    LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0 and 
                    Unit(currunit):IsEnemy() and 
                    Unit(currunit):IsUndead() and 
                    Unit(currunit):IsControlAble("fear", 0) and 
                    Obj.TurnUndead:AbsentImun(currunit, {"TotalImun", "CCTotalImun", "FearImun", "Reflect"})
        ]] },
        ["divineshield"] = { Enabled = true, Key = "DivineShield", LUAVER = 1, LUA = [[
            -- Only if word 'divineshield player' is exactly player (you), otherwise use 'divineshield raid1' if there are few paladins with it
            -- Just 'divineshield' is not working!
            local Obj         = Action[Action.PlayerClass]
            local currunit     = thisunit or "target"            
            return     Obj and
                    Obj.DivineShield and         
                    Obj.DivineShield:IsReadyM("player", true) and 
                    LossOfControl:Get("SCHOOL_INTERRUPT", "HOLY") == 0 and 
                    UnitIsUnit(currunit, "player") and 
                    Unit("player"):HasDeBuffs(Obj.Forbearance.ID) == 0                    
        ]] },    
        ["divineprotection"] = { Enabled = true, Key = "DivineProtection", LUAVER = 1, LUA = [[
            -- Only if word 'divineprotection player' is exactly player (you), otherwise use 'divineprotection raid1' if there are few paladins with it
            -- Just 'divineprotection' is not working!
            local Obj         = Action[Action.PlayerClass]
            local currunit     = thisunit or "target"            
            return     Obj and
                    Obj.DivineProtection and         
                    Obj.DivineProtection:IsReadyM("player", true) and 
                    LossOfControl:Get("SCHOOL_INTERRUPT", "HOLY") == 0 and 
                    UnitIsUnit(currunit, "player") and 
                    Unit("player"):HasDeBuffs(Obj.Forbearance.ID) == 0
        ]] },    
    },
}
A.Data.ProfileUI[2][1]                                = {
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
        TT         = L.TARGETTARGET_TT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "AoE",
        DBV     = true,
        L         = L.AOE,
        TT         = L.AOE_TT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][2]                                = {    
    {
        E         = "Checkbox", 
        DB         = "CancelAuraRighteousFury",
        DBV     = true,
        L         = L.CANCELRF,
        TT         = L.CANCELRF_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "CancelAura",
        DBV     = true,
        L         = L.CANCELBOP,
        TT         = L.CANCELBOP_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][3]                                = { -- Shared Rotation 
    {
        E         = "Header",
        L         = L.SHAREDROTATION, 
    },    
}
A.Data.ProfileUI[2][4]                                = { 
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                                     value = "OFF"                             },
            { text = PL.MajorManaPotion:Info(),                 value = "MajorManaPotion"                 },
            { text = PL.HealingPotion:Info(),                     value = "HealingPotion"                 },
            { text = PL.LimitedInvulnerabilityPotion:Info(),     value = "LimitedInvulnerabilityPotion"    },
            { text = PL.LivingActionPotion:Info(),                 value = "LivingActionPotion"             },
            { text = PL.RestorativePotion:Info(),                 value = "RestorativePotion"             },
            { text = PL.SwiftnessPotion:Info(),                 value = "SwiftnessPotion"                 },
        },
        DB         = "PotionToUse",
        DBV     = "MajorManaPotion",
        L         = L.POTIONTOUSE,
        TT         = L.POTIONTOUSE_TT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "ManaPotion",
        DBV     = 30,
        ONOFF    = false,
        L         = L.MANAPOTION,
        TT        = L.MANAPOTION_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][5]                                = {     
    {
        E         = "Checkbox", 
        DB         = "UseRacial-LoC",
        DBV     = true,
        L         = L.USERACIAL_LOC,
        TT         = L.USERACIAL_LOC_TT, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "Runes",
        DBV     = 100,
        ONOFF    = true,
        L         = L.RUNES,
        M         = {},
    },
}
A.Data.ProfileUI[2][6]                                = { -- Damage Rotation 
    {
        E         = "Header",
        L         = L.DAMAGE_ROTATION, 
    },    
}
A.Data.ProfileUI[2][7]                                = {
    {
        E         = "Checkbox", 
        DB         = "DownrankDamage",
        DBV     = true,
        L         = L.DOWNRANKDAMAGE,
        TT         = L.DOWNRANKDAMAGE_TT, 
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "HolyShockCanDamage",
        DBV     = false,
        L         = L.HOLYSHOCKCANDAMAGE,
        TT         = L.HOLYSHOCKCANDAMAGE_TT, 
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "SelfRotation",
        DBV     = false,
        L         = L.SELFROTATION,
        TT         = L.SELFROTATION_TT, 
        M         = {},
    },    
}
A.Data.ProfileUI[2][8]                                = { -- Healing Rotation 
    {
        E         = "Header",
        L         = L.HEALING_ROTATION, 
    },    
}
A.Data.ProfileUI[2][9]                                = {    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "HealingTrinketsHP",
        DBV     = 65,
        ONLYOFF    = true,
        L         = L.HEALINGTRINKETSHP,
        TT        = L.HEALINGTRINKETSHP_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][10]                                = { -- Stance Aura 
    {
        E         = "Header",
        L         = L.STANCE_AURA, 
    },    
}
A.Data.ProfileUI[2][11]                                = { 
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                              value = "OFF"                     },
            { text = "Auto",                              value = "AUTO"                     },
            { text = PL.ConcentrationAura:Info(),          value = "ConcentrationAura"     },
            { text = PL.DevotionAura:Info(),              value = "DevotionAura"             },
            { text = PL.FireResistanceAura:Info(),      value = "FireResistanceAura"     },
            { text = PL.FrostResistanceAura:Info(),      value = "FrostResistanceAura"     },
            { text = PL.RetributionAura:Info(),          value = "RetributionAura"         },
            { text = PL.ShadowResistanceAura:Info(),      value = "ShadowResistanceAura"     },
            { text = PL.SanctityAura:Info(),              value = "SanctityAura"             },
        },
        DB         = "StanceAuraPvP",
        DBV     = "AUTO",
        L         = L.STANCE_AURA_PVP,
        TT         = L.STANCE_AURA_TT,
        M         = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                              value = "OFF"                     },
            { text = "Auto",                              value = "AUTO"                     },
            { text = PL.ConcentrationAura:Info(),          value = "ConcentrationAura"     },
            { text = PL.DevotionAura:Info(),              value = "DevotionAura"             },
            { text = PL.FireResistanceAura:Info(),      value = "FireResistanceAura"     },
            { text = PL.FrostResistanceAura:Info(),      value = "FrostResistanceAura"     },
            { text = PL.RetributionAura:Info(),          value = "RetributionAura"         },
            { text = PL.ShadowResistanceAura:Info(),      value = "ShadowResistanceAura"     },
            { text = PL.SanctityAura:Info(),              value = "SanctityAura"             },
        },
        DB         = "StanceAuraPvE",
        DBV     = "AUTO",
        L         = L.STANCE_AURA_PVE,
        TT         = L.STANCE_AURA_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][12]                                = {    -- Seal
    {
        E         = "Header",
        L         = L.SEAL, 
    },
}
A.Data.ProfileUI[2][13]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                                                                                                      value = "OFF"                                                         },
            { text = "Auto",                                                                                                      value = "AUTO"                                                         },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealoftheCrusader:Info(),      value = "SealofCommand/SealofRighteousness + SealoftheCrusader"     },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealofWisdom:Info(),          value = "SealofCommand/SealofRighteousness + SealofWisdom"             },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealofLight:Info(),          value = "SealofCommand/SealofRighteousness + SealofLight"             },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealofJustice:Info(),          value = "SealofCommand/SealofRighteousness + SealofJustice"         },
            { text = PL.SealofJustice:Info(),                                                                                      value = "SealofJustice"                                             },
            { text = PL.SealofLight:Info(),                                                                                      value = "SealofLight"                                                 },
            { text = PL.SealofWisdom:Info(),                                                                                      value = "SealofWisdom"                                                 },
            { text = PL.SealofRighteousness:Info(),                                                                              value = "SealofRighteousness"                                         },
            { text = PL.SealofCommand:Info(),                                                                                      value = "SealofCommand"                                             },
            { text = PL.SealoftheCrusader:Info(),                                                                                  value = "SealoftheCrusader"                                         },
        },
        DB         = "SealPvP",
        DBV     = "AUTO",
        L         = L.SEAL_PVP,
        TT         = L.SEAL_TT,
        M = {},                                    
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                                                                                                      value = "OFF"                                                         },
            { text = "Auto",                                                                                                      value = "AUTO"                                                         },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealoftheCrusader:Info(),      value = "SealofCommand/SealofRighteousness + SealoftheCrusader"     },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealofWisdom:Info(),          value = "SealofCommand/SealofRighteousness + SealofWisdom"             },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealofLight:Info(),          value = "SealofCommand/SealofRighteousness + SealofLight"             },
            { text = PL.SealofCommand:Info() .. "/" .. PL.SealofRighteousness:Info() .. " + " .. PL.SealofJustice:Info(),          value = "SealofCommand/SealofRighteousness + SealofJustice"         },
            { text = PL.SealofJustice:Info(),                                                                                      value = "SealofJustice"                                             },
            { text = PL.SealofLight:Info(),                                                                                      value = "SealofLight"                                                 },
            { text = PL.SealofWisdom:Info(),                                                                                      value = "SealofWisdom"                                                 },
            { text = PL.SealofRighteousness:Info(),                                                                              value = "SealofRighteousness"                                         },
            { text = PL.SealofCommand:Info(),                                                                                      value = "SealofCommand"                                             },
            { text = PL.SealoftheCrusader:Info(),                                                                                  value = "SealoftheCrusader"                                         },
        },
        DB         = "SealPvE",
        DBV     = "AUTO",
        L         = L.SEAL_PVE,
        TT         = L.SEAL_TT,
        M = {},                                    
    },
}
A.Data.ProfileUI[2][14]                                = {    -- BlessingBuff
    {
        E         = "Header",
        L         = L.BLESSINGBUFF, 
    },
}
A.Data.ProfileUI[2][15]                                = {
    {
        E         = "Checkbox", 
        DB         = "BlessingBuffHealingEnginePvP",
        DBV     = true,
        L         = L.BLESSINGBUFFHEALINGENGINEPVP,
        TT         = L.BLESSINGBUFFHEALINGENGINE_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "BlessingBuffHealingEnginePvE",
        DBV     = true,
        L         = L.BLESSINGBUFFHEALINGENGINEPVE,
        TT         = L.BLESSINGBUFFHEALINGENGINE_TT, 
        M         = {},
    },
}
A.Data.ProfileUI[2][16]                                = {
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 300,                            
        DB         = "BlessingBuffRemainDurationPvP",
        DBV     = 60,
        ONOFF    = false,
        L         = L.BLESSINGBUFFREMAINDURATIONPVP,
        TT         = L.BLESSINGBUFFREMAINDURATION_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 300,                            
        DB         = "BlessingBuffRemainDurationPvE",
        DBV     = 60,
        ONOFF    = false,
        L         = L.BLESSINGBUFFREMAINDURATIONPVE,
        TT         = L.BLESSINGBUFFREMAINDURATION_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][17]                                = {    -- BlessingBuff - Solo 
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                                     value = "OFF"                             },
            { text = "Auto",                                     value = "AUTO"                             },
            { text = PL.BlessingofKings:Info(),                 value = "BlessingofKings"                 },
            { text = PL.BlessingofLight:Info(),                 value = "BlessingofLight"                },
            { text = PL.BlessingofMight:Info(),                 value = "BlessingofMight"                 },
            { text = PL.BlessingofSalvation:Info(),             value = "BlessingofSalvation"             },
            { text = PL.BlessingofSanctuary:Info(),             value = "BlessingofSanctuary"             },
            { text = PL.BlessingofWisdom:Info(),                 value = "BlessingofWisdom"                 },
        },
        DB         = "BlessingBuffSoloPvP",
        DBV     = "AUTO",
        L         = L.BLESSINGBUFFSOLOPVP,
        TT         = L.BLESSINGBUFFSOLO_TT,
        M         = {},
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "Off",                                     value = "OFF"                             },
            { text = "Auto",                                     value = "AUTO"                             },
            { text = PL.BlessingofKings:Info(),                 value = "BlessingofKings"                 },
            { text = PL.BlessingofLight:Info(),                 value = "BlessingofLight"                },
            { text = PL.BlessingofMight:Info(),                 value = "BlessingofMight"                 },
            { text = PL.BlessingofSalvation:Info(),             value = "BlessingofSalvation"             },
            { text = PL.BlessingofSanctuary:Info(),             value = "BlessingofSanctuary"             },
            { text = PL.BlessingofWisdom:Info(),                 value = "BlessingofWisdom"                 },
        },
        DB         = "BlessingBuffSoloPvE",
        DBV     = "AUTO",
        L         = L.BLESSINGBUFFSOLOPVE,
        TT         = L.BLESSINGBUFFSOLO_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][18]                                = { -- BlessingBuff - Group / Others 
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofKingsPvP",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFKINGSPVP,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofKingsPvE",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFKINGSPVE,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][19]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofLightPvP",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFLIGHTPVP,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofLightPvE",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFLIGHTPVE,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][20]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofMightPvP",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFMIGHTPVP,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofMightPvE",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFMIGHTPVE,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][21]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofSalvationPvP",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFSALVATIONPVP,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofSalvationPvE",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFSALVATIONPVE,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][22]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofSanctuaryPvP",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFSANCTUARYPVP,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofSanctuaryPvE",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFSANCTUARYPVE,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M = {},                                    
    },
}
A.Data.ProfileUI[2][23]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofWisdomPvP",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFWISDOMPVP,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = WARRIOR,      value = 1 },
            { text = PALADIN,      value = 2 },
            { text = HUNTER,      value = 3 },
            { text = ROGUE,      value = 4 },
            { text = PRIEST,      value = 5 },
            { text = MAGE,      value = 6 },
            { text = WARLOCK,      value = 7 },
            { text = DRUID,      value = 8 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofWisdomPvE",
        DBV     = {
            [1] = false, 
            [2] = false,
            [3] = false,
            [4] = false,            
            [5] = false,            
            [6] = false,            
            [7] = false,            
            [8] = false,            
        }, 
        L         = L.BLESSINGOFWISDOMPVE,
        TT         = L.BLESSINGGROUPOTHERS_TT,
        M         = {},                                    
    },
}
A.Data.ProfileUI[2][24]                                = { -- BlessingofProtection
    {
        E         = "Header",
        L         = L.BLESSINGOFPROTECTION, 
    },
}
A.Data.ProfileUI[2][25]                                = {    
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "BlessingofProtectionHP",
        DBV     = 25,
        ONLYOFF    = true,
        L         = L.BLESSINGOFPROTECTIONHP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,     value = "AND"     },
            { text = L.OR,         value = "OR"     },
        },
        DB         = "BlessingofProtectionOperator",
        DBV     = "AND",
        L         = L.BLESSINGOFPROTECTIONOPERATOR,
        TT         = L.OPERATOR_BETWEEN_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "BlessingofProtectionTTD",
        DBV     = 8,
        ONLYOFF    = true,
        L         = L.BLESSINGOFPROTECTIONTTD,
        M         = {},
    },
}
A.Data.ProfileUI[2][26]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "@raid1, @party1",      value = 1 },
            { text = "@raid2, @party2",      value = 2 },
            { text = "@raid3, @party3",      value = 3 },
            { text = "@primary",              value = 4 },
            { text = "@HealingEngine",      value = 5 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofProtectionUnits",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = true,            
            [5] = true,                                    
        }, 
        L         = L.BLESSINGOFPROTECTIONUNITS,
        TT         = L.UNITS_TT,
        M         = {},                                    
    },
}
A.Data.ProfileUI[2][27]                                = {    
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.BLESSINGOFPROTECTIONADDITIONAL_1,      value = 1 },
            { text = L.BLESSINGOFPROTECTIONADDITIONAL_2,      value = 2 },
            { text = L.BLESSINGOFPROTECTIONADDITIONAL_3,      value = 3 },
            { text = L.BLESSINGOFPROTECTIONADDITIONAL_4,      value = 4 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofProtectionAdditional",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = false,                                            
        }, 
        L         = L.BLESSINGOFPROTECTIONADDITIONAL,
        TT         = L.BLESSINGOFPROTECTIONADDITIONAL_TT,
        M         = {},                                    
    },
}
A.Data.ProfileUI[2][28]                                = { -- BlessingofSacrifice
    {
        E         = "Header",
        L         = L.BLESSINGOFSACRIFICE, 
    },    
}
A.Data.ProfileUI[2][29]                                = {
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "BlessingofSacrificeHP",
        DBV     = 25,
        ONLYOFF    = true,
        L         = L.BLESSINGOFSACRIFICEHP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,     value = "AND"     },
            { text = L.OR,         value = "OR"     },
        },
        DB         = "BlessingofSacrificeOperator",
        DBV     = "AND",
        L         = L.BLESSINGOFSACRIFICEOPERATOR,
        TT         = L.OPERATOR_BETWEEN_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "BlessingofSacrificeTTD",
        DBV     = 8,
        ONLYOFF    = true,
        L         = L.BLESSINGOFSACRIFICETTD,
        M         = {},
    },
}
A.Data.ProfileUI[2][30]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "@raid1, @party1",      value = 1 },
            { text = "@raid2, @party2",      value = 2 },
            { text = "@raid3, @party3",      value = 3 },
            { text = "@primary",              value = 4 },
            { text = "@HealingEngine",      value = 5 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofSacrificeUnits",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = true,            
            [5] = true,                                    
        }, 
        L         = L.BLESSINGOFSACRIFICEUNITS,
        TT         = L.UNITS_TT,
        M         = {},                                    
    },
}
A.Data.ProfileUI[2][31]                                = { 
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.BLESSINGOFSACRIFICEADDITIONAL_1,      value = 1 },
            { text = L.BLESSINGOFSACRIFICEADDITIONAL_2,      value = 2 },
            { text = L.BLESSINGOFSACRIFICEADDITIONAL_3,      value = 3 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofSacrificeAdditional",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,                                            
        }, 
        L         = L.BLESSINGOFSACRIFICEADDITIONAL,
        TT         = L.BLESSINGOFSACRIFICEADDITIONAL_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][32]                                = {    -- BlessingofFreedom 
    {
        E         = "Header",
        L         = L.BLESSINGOFFREEDOM, 
    },
}
A.Data.ProfileUI[2][33]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "@raid1, @party1",      value = 1 },
            { text = "@raid2, @party2",      value = 2 },
            { text = "@raid3, @party3",      value = 3 },
            { text = "@primary",              value = 4 },
            { text = "@HealingEngine",      value = 5 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofFreedomUnits",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = true,            
            [5] = false,                                    
        }, 
        L         = L.BLESSINGOFFREEDOMUNITS,
        TT         = L.UNITS_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][34]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.BLESSINGOFFREEDOMADDITIONAL_1,      value = 1 },
            { text = L.BLESSINGOFFREEDOMADDITIONAL_2,      value = 2 },
            { text = L.BLESSINGOFFREEDOMADDITIONAL_3,      value = 3 },
            { text = L.BLESSINGOFFREEDOMADDITIONAL_4,      value = 4 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "BlessingofFreedomAdditional",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = false,                                            
            [4] = false,                                            
        }, 
        L         = L.BLESSINGOFFREEDOMADDITIONAL,
        TT         = L.BLESSINGOFFREEDOMADDITIONAL_TT,
        M         = {},                                    
    },        
}
A.Data.ProfileUI[2][35]                                = {    -- Dispel 
    {
        E         = "Header",
        L         = L.DISPEL, 
    },
}
A.Data.ProfileUI[2][36]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "@raid1, @party1",      value = 1 },
            { text = "@raid2, @party2",      value = 2 },
            { text = "@raid3, @party3",      value = 3 },
            { text = "@primary",              value = 4 },
            { text = "@HealingEngine",      value = 5 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "DispelUnits",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = true,            
            [5] = true,                                    
        }, 
        L         = L.DISPELUNITS,
        TT         = L.UNITS_TT,
        M         = {},                                    
    },    
}
A.Data.ProfileUI[2][37]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.DISPELADDITIONAL_1,      value = 1 },
            { text = L.DISPELADDITIONAL_2,      value = 2 },
            { text = L.DISPELADDITIONAL_3,      value = 3 },
            { text = L.DISPELADDITIONAL_4,      value = 4 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "Off" },
        DB         = "AdditionalDispel",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,                                            
            [4] = false,                                            
        }, 
        L         = L.DISPELADDITIONAL,
        M         = {},                                    
    },        
}
A.Data.ProfileUI[2][38]                                = {    -- DivineIntervention 
    {
        E         = "Header",
        L         = L.DIVINEINTERVENTION, 
    },
}
A.Data.ProfileUI[2][39]                                = {
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineInterventionHP",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.DIVINEINTERVENTIONHP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,     value = "AND"     },
            { text = L.OR,         value = "OR"     },
        },
        DB         = "DivineInterventionOperator",
        DBV     = "AND",
        L         = L.DIVINEINTERVENTIONOPERATOR,
        TT         = L.OPERATOR_BETWEEN_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineInterventionTTD",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.DIVINEINTERVENTIONTTD,
        M         = {},
    },
}
A.Data.ProfileUI[2][40]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineInterventionMana",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.DIVINEINTERVENTIONMANA,
        TT         = L.DIVINEINTERVENTIONMANA_TT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "DivineInterventionOnRaidWipePvE",
        DBV     = true,
        L         = L.DIVINEINTERVENTIONONRAIDWIPEPVE,
        TT         = L.DIVINEINTERVENTIONONRAIDWIPEPVE_TT, 
        M         = {},
    },
}
A.Data.ProfileUI[2][41]                                = {    -- Defense 
    {
        E         = "Header",
        L         = L.DEFENSE, 
    },
}
A.Data.ProfileUI[2][42]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "Stoneform",
        DBV     = 100,
        ONLYOFF    = true,
        L         = L.STONEFORM,
        M         = {},
    },
}
A.Data.ProfileUI[2][43]                                = {
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineShieldHP",
        DBV     = 20,
        ONLYOFF    = true,
        L         = L.DIVINESHIELDHP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,     value = "AND"     },
            { text = L.OR,         value = "OR"     },
        },
        DB         = "DivineShieldOperator",
        DBV     = "OR",
        L         = L.DIVINESHIELDOPERATOR,
        TT         = L.OPERATOR_BETWEEN_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineShieldTTD",
        DBV     = 3,
        ONLYOFF    = true,
        L         = L.DIVINESHIELDTTD,
        M         = {},
    },
}
A.Data.ProfileUI[2][44]                                = {
    RowOptions = { margin = { top = 10 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineProtectionHP",
        DBV     = 20,
        ONLYOFF    = true,
        L         = L.DIVINEPROTECTIONHP,
        M         = {},
    },
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = L.AND,     value = "AND"     },
            { text = L.OR,         value = "OR"     },
        },
        DB         = "DivineProtectionOperator",
        DBV     = "OR",
        L         = L.DIVINEPROTECTIONOPERATOR,
        TT         = L.OPERATOR_BETWEEN_TT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DivineProtectionTTD",
        DBV     = 3,
        ONLYOFF    = true,
        L         = L.DIVINEPROTECTIONTTD,
        M         = {},
    },
}
A.Data.ProfileUI[2][45]                                = {    -- PvP 
    {
        E         = "Header",
        L         = L.PVP, 
    },
}
A.Data.ProfileUI[2][46]                                = {
    {
        E         = "Checkbox", 
        DB         = "TryToFindInvisible",
        DBV     = true,
        L         = L.FIND_INVISIBLE,
        TT         = L.FIND_INVISIBLE_TT, 
        M         = {},
    },
}
A.Data.ProfileUI[2][47]                                = { -- Rank Healing Management
    {
        E         = "Header",
        L         = L.RANK_HEALING, 
    },    
}
A.Data.ProfileUI[2][48]                                = { 
    RowOptions = { margin = { top = 20 } },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyShock1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyShock:Info() .. "\n#1 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyShock2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyShock:Info() .. "\n#2 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyShock3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyShock:Info() .. "\n#3 (<= %)",
        }, 
        M         = {},
    },
} 
A.Data.ProfileUI[2][49]                                = { 
    RowOptions = { margin = { top = 20 } },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#1 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#2 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#3 (<= %)",
        }, 
        M         = {},
    },
} 
A.Data.ProfileUI[2][50]                                = { 
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#4 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight5",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#5 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight6",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#6 (<= %)",
        }, 
        M         = {},
    },
} 
A.Data.ProfileUI[2][51]                                = { 
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight7",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#7 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight8",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#8 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "HolyLight9",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.HolyLight:Info() .. "\n#9 (<= %)",
        }, 
        M         = {},
    },
} 
A.Data.ProfileUI[2][52]                                = { 
    RowOptions = { margin = { top = 20 } },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashofLight1",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.FlashofLight:Info() .. "\n#1 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashofLight2",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.FlashofLight:Info() .. "\n#2 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashofLight3",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.FlashofLight:Info() .. "\n#3 (<= %)",
        }, 
        M         = {},
    },
} 
A.Data.ProfileUI[2][53]                                = { 
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashofLight4",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.FlashofLight:Info() .. "\n#4 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashofLight5",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.FlashofLight:Info() .. "\n#5 (<= %)",
        }, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 1, 
        MAX     = 100,                            
        DB         = "FlashofLight6",
        DBV     = 100,
        ONLYON     = true,
        L         = {
            ANY = PL.FlashofLight:Info() .. "\n#6 (<= %)",
        }, 
        M         = {},
    },
} 

