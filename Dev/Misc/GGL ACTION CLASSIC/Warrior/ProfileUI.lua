local Action                                        = Action
local A                                                = Action
local WR                                             = A[A.PlayerClass]
local L                                             = {
    MOUSEOVER                 = { enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover" },
    MOUSEOVERTT             = { enUS = "Will unlock use actions for @mouseover units\nExample: Pummel, Charge,  Intercept, Disarm", 
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Зуботычина, Рывок, Перехват, Обезоруживание" },
    AOE                     = { enUS = "Use\nAoE",
    ruRU = "Использовать\nAoE" },
    AOETT                     = { enUS = "Enable multiunits actions",
    ruRU = "Включает действия для нескольких целей" },    
    CANCELPOWS                = { enUS = "Cancelaura Power Word: Shield",
    ruRU = "Отмена эффекта Слово Силы: Щит" },    
    CANCELPOWSTT            = { enUS = "Automatically removes the buff effect Power Word: Shield on you if the rage is less than 30 and in combat",
    ruRU = "Автоматически снимает положительный эффект Слово Силы: Щит с Вас, если ярости меньше 30 и в бою" },        
    CANCELBOP                = { enUS = "Cancelaura Blessing of Protection",
    ruRU = "Отмена эффекта Благословение защиты" },    
    CANCELBOPTT                = { enUS = "Automatically removes the buff effect Blessing of Protection on you if your health more than 50% and in combat",
    ruRU = "Автоматически снимает положительный эффект Благословение защиты, если здоровье больше 50% и в бою" },        
    STANCES                    = { enUS = "Stances",
    ruRU = "Стойки" },
    STANCESTT                = { enUS = "The maximum rage limit for switching to this stance\nIf the value of the rage is greater than the set slider, then this stance will not be involved in the main rotation\nDigital value (not percent)\nOFF use by default",
    ruRU = "Максимальный ограничитель ярости для перехода в данную стойку\nЕсли значение ярости больше установленного ползунка, то данная стойка не будет задействована главной ротацией\nЦифровое значение (не процентное)\nOFF использовать по умолчанию" },                            
    BATTLESTANCE            = { enUS = WR.BattleStance:Info() .. "\n<= rage",
        ruRU = WR.BattleStance:Info() .. "\n<= ярости" },
    DEFENSIVESTANCE            = { enUS = WR.DefensiveStance:Info() .. "\n<= rage",
        ruRU = WR.DefensiveStance:Info() .. "\n<= ярости" },
    BERSERKERSTANCE            = { enUS = WR.BerserkerStance:Info() .. "\n<= rage",
        ruRU = WR.BerserkerStance:Info() .. "\n<= ярости" },
    ROTATION                = { enUS = "Rotation Configuration",
    ruRU = "Конфигурация Ротации" },    
    HAMSTRING_PWR            = { enUS = WR.Hamstring:Info() .. "\n" .. WR.Flurry:Info() .. " spam\n>= rage (value)",
        ruRU = WR.Hamstring:Info() .. "\n" .. WR.Flurry:Info() .. " спам\n>= ярости (значение)" },    
    HAMSTRING_PWRTT            = { enUS = "OFF - By default,\n0->200 More than or equal to the specified rage (numerical value, not percent!)",
    ruRU = "OFF - По умолчанию\n0->200 Больше или равно указанной ярости (цифровое значение, не проценты!)" },                    
    BLOODRAGE_DAMAGER        = { enUS = WR.Bloodrage:Info() .. "\nOnly role 'Damager'",
        ruRU = WR.Bloodrage:Info() .. "\nТолько роль 'Урон'" },    
    BLOODRAGE_DAMAGERTT        = { enUS = "If enabled, this ability will be used in rotation if the 'Damage' role is selected\nThis setting does not affect passive rotation and other settings below, as well as AntiFake functions",
    ruRU = "Если включено, то данная способность будет использоваться в ротации если выбрана роль 'Урон'\nДанная настройка не влияет на пассивную ротацию и другие настройки ниже, а также AntiFake функции" },        
    BLOODRAGE_ATCOMBAT        = { enUS = WR.Bloodrage:Info() .. "\n<= start combat (sec)",
        ruRU = WR.Bloodrage:Info() .. "\n<= начала боя (сек)" },    
    BLOODRAGE_ATCOMBATTT    = { enUS = "0 - Out of combat (preparation)\n1->60 less than or equal to seconds from the start of the combat\nOFF - Will not be used BEFORE and AFTER the combat\nAny of these conditions doesn't completely\ndisable the ability’s functionality, but simply sets the option how to start the fight",
    ruRU = "0 - Вне боя (подготовка)\n1->60 меньше или равно секунд с начала боя\nOFF - Не будет использоваться ДО и ПОСЛЕ боя\nЛюбое из этих состояний полностью не отключает функционал способности,\nа просто задает вариант начала боя" },                                
    BLOODRAGE_LIMITHP        = { enUS = WR.Bloodrage:Info() .. "\n>= health (%)",
        ruRU = WR.Bloodrage:Info() .. "\n>= здоровья (%)" },
    BLOODRAGE_LIMITHPTT        = { enUS = "Use if your health is greater than or equal to the specified percentage\nSomething like a limit, so as not to kill yourself",
    ruRU = "Использовать если Ваше здоровье больше или равно указанного процента\nЧто-то вроде лимита, чтобы не убить себя" },
    HEROICSTRIKE_PWR        = { enUS = WR.HeroicStrike:Info() .. "\n>= rage (value)",
        ruRU = WR.HeroicStrike:Info() .. "\n>= ярости (значение)" },    
    HEROICSTRIKE_PWRTT        = { enUS = "OFF - By default,\n0->200 More than or equal to the specified rage (numerical value, not percent!)",
    ruRU = "OFF - По умолчанию\n0->200 Больше или равно указанной ярости (цифровое значение, не проценты!)" },    
    CLEAVE_PWR                = { enUS = WR.Cleave:Info() .. "\n>= rage (value)",
        ruRU = WR.Cleave:Info() .. "\n>= ярости (значение)" },    
    CLEAVE_PWRTT            = { enUS = "OFF - By default,\n0->200 More than or equal to the specified rage (numerical value, not percent!)",
    ruRU = "OFF - По умолчанию\n0->200 Больше или равно указанной ярости (цифровое значение, не проценты!)" },    
    OVERPOWER_PWR            = { enUS = WR.Overpower:Info() .. "\n<= rage (value)",
        ruRU = WR.Overpower:Info() .. "\n<= ярости (значение)" },                
    OVERPOWER_PWRTT            = { enUS = "OFF - By default,\n0->200 Less than or equal to the specified rage (numerical value, not percent!)",
    ruRU = "OFF - По умолчанию\n0->200 Меньше или равно указанной ярости (цифровое значение, не проценты!)" },    
    USEBERSERKERRAGE_GAIN    = { enUS = WR.BerserkerRage:Info() .. "\nUse to generate rage",
        ruRU = WR.BerserkerRage:Info() .. "\nИспользовать для генерации ярости" },    
    USEBERSERKERRAGE_GAINTT    = { enUS = "Will use " .. WR.BerserkerRage:Info() .. " if not enough rage in combat\nIf choisen talent " .. WR.ImprovedBerserkerRage:Info(),
        ruRU = "Будет использовать " .. WR.BerserkerRage:Info() .. " если недостаточно ярости в бою\nЕсли взят талант " .. WR.ImprovedBerserkerRage:Info() },                            
    USEHAMSTRING_OUTSIDE    = { enUS = WR.Hamstring:Info() .. "\nUse for kite mobs",
        ruRU = WR.Hamstring:Info() .. "\nИспользовать для кайта мобов" },    
    USEHAMSTRING_OUTSIDETT    = { enUS = "Will use " .. WR.Hamstring:Info() .. " outside instances in solo playing to kite mobs",
        ruRU = "Будет использовать " .. WR.Hamstring:Info() .. " вне подземелий в одиночной игре для кайта мобов" },
    LOC_TT                    = { enUS = "It will be used in the desired rotation order to remove the available effects of loss of control over the character",
    ruRU = "Будет использовано в нужном порядке ротации для снятия доступных эффектов потери контроля над персонажем" },
    USEBERSERKERRAGE_LOC    = { enUS = WR.BerserkerRage:Info() .. "\nLoss of Control",
        ruRU = WR.BerserkerRage:Info() .. "\nПотеря контроля" },
    USEDEATHWISH_LOC        = { enUS = WR.DeathWish:Info() .. "\nLoss of Control",
        ruRU = WR.DeathWish:Info() .. "\nПотеря контроля" },
    USERACIAL_LOC            = { enUS = "Auto Racial\nLoss of Control",
    ruRU = "Авто Расовая\nПотеря контроля" },
    USERACIAL_LOCTT            = { enUS = "It will be used in the desired rotation order to remove the available effects of loss of control over the character\nWARNING: Checkbox for 'Racial' in first tab must be enabled!",
    ruRU = "Будет использовано в нужном порядке ротации для снятия доступных эффектов потери контроля над персонажем\nВНИМАНИЕ: Чекбокс для 'Расовая' в первой вкладке должен быть включен!" },                
    THREATLIMIT                = { enUS = "Only 'Damager'\nThreat limit(agro,>= %)",
    ruRU = "Только 'Урон'\nЛимит угрозы(агро,>= %)" },    
    THREATLIMITTT            = { enUS = "OFF - No limit\nIf the percentage of the threat (agro) is greater than\nor equal to the specified one, then the\n'safe' rotation will be performed. As far as possible, the\nabilities causing too many threats will be stopped until the\nthreat level (agro) is normalized",
    ruRU = "OFF - Нет лимита\nЕсли процент угрозы (агро) больше или равен указанному,\nто будет выполняться 'безопасная' ротация\nПо мере возможности перестанут использоваться способности\nвызывающие слишком много угрозы пока\nуровень угрозы (агро) не нормализуется" },                                    
    LEVELING                = { enUS = "Leveling rotation",
    ruRU = "Ротация прокачки" },
    LEVELINGTT                = { enUS = "It doesn’t work if you have reached the maximum level\nIf not, then all abilities will be used,\nto eliminate downtime in rotation",
    ruRU = "Не работает если вы достигли максимального уровня\nЕсли же нет, то будут задействованы все способности,\nчтобы исключить простои в ротации" },    
    BURST_CONFIGURATION        = { enUS = "Burst | Taunt Configuration",
    ruRU = "Конфигурация Бурстов | Провокации" },
    BURST_TIMING            = { enUS = "PvE\nTiming 20% boss HP",
    ruRU = "PvE\nРасчет 20% босса ХП" },    
    BURST_TIMINGTT            = { enUS = "It stops using bursts if the time to 20% health\nboss is less than the recovery time of each individual burst\nWorks only in boss fights in PvE mode even if you don't target boss itself!",
    ruRU = "Перестает использовать бурсты, если время до 20% здоровья\nбосса меньше времени восстановления каждого отдельного бурста\nРаботает только в бою с боссом в PvE режиме даже если в цели не сам босс!" },    
    CHALLENGINGSHOUT        = { enUS = WR.ChallengingShout:Info() .. "(only 'Tank')\nunits, >",
        ruRU = WR.ChallengingShout:Info() .. "(только 'Танк')\nцелей, >" },    
    CHALLENGINGSHOUTTT         = { enUS = "Your Role must be 'Tank'\nOption works only in PvE mode",
    ruRU = "Ваша Роль должна быть 'Танк'\nОпция работает в PvE режиме только" },    
    DEFENSE                    = { enUS = "Defense",
    ruRU = "Оборона" },                            
    SHIELDWALL_KILLSTRIKE    = { enUS = WR.ShieldWall:Info() .. "\nCatch death hit",
        ruRU = WR.ShieldWall:Info() .. "\nПоймать смерт. удар" },    
    SHIELDWALL_KILLSTRIKETT    = { enUS = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!",
    ruRU = "Пытаться успеть использовать\nспособность до получения смертельного удара\nЭта опция не связана с другими триггерами!" },                            
    SHIELDWALL_HP            = { enUS = WR.ShieldWall:Info() .. "\n<= health (%)",
        ruRU = WR.ShieldWall:Info() .. "\n<= здоровье (%)" },                
    SHIELDWALL_HPTT            = { enUS = "OFF - The trigger is disabled\n0-> 100 Less than or equal to the specified percentage of health\nWARNING: Must have at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->100 Меньше или равно указанному проценту здоровья\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },                                
    SHIELDWALL_TTD            = { enUS = WR.ShieldWall:Info() .. "\n<= time to die (sec)",
        ruRU = WR.ShieldWall:Info() .. "\n<= время смерти (сек)" },                
    SHIELDWALL_TTDTT        = { enUS = "OFF - The trigger is disabled\n0->20 Less than or equal to the specified time of death\nWARNING: Must have at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->20 Меньше или равно указанному времени смерти\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },    
    RETALIATIONATTACKUNITS    = { enUS = WR.Retaliation:Info() .. "\n>= attacking units",
        ruRU = WR.Retaliation:Info() .. "\n>= атакующих целей" },    
    RETALIATIONATTACKUNITSTT = { enUS = "OFF - The trigger is disabled\n0->30 More than or equal to the targets attacking you\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->30 Больше или равно атакующих Вас целей\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },    
    RETALIATIONRANGEUNITS    = { enUS = WR.Retaliation:Info() .. "\n<= attacker's distance",
        ruRU = WR.Retaliation:Info() .. "\n<= дистанция атакующих" },    
    RETALIATIONRANGEUNITSTT = { enUS = "OFF - The trigger is disabled\n0->20 Less than or equal to the distance to the attackers\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->20 Меньше или равно расстоянию до атакующих\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },    
    RETALIATIONHP            = { enUS = WR.Retaliation:Info() .. "\n<= health (%)",
        ruRU = WR.Retaliation:Info() .. "\n<= здоровья (%)" },    
    RETALIATIONHPTT            = { enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->100 Меньше или равно указанному проценту Вашего здоровья\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },    
    RETALIATIONTTD            = { enUS = WR.Retaliation:Info() .. "\n<= time to die (sec)",
        ruRU = WR.Retaliation:Info() .. "\n<= время смерти (сек)" },                
    RETALIATIONTTDTT        = { enUS = "OFF - The trigger is disabled\n0->20 Less than or equal to the specified time of death\nWARNING: Must have at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->20 Меньше или равно указанному времени смерти\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },    
    RETALIATIONHITS            = { enUS = WR.Retaliation:Info() .. "\n>= number of hits",
        ruRU = WR.Retaliation:Info() .. "\n>= кол-ва ударов" },    
    RETALIATIONHITSTT         = { enUS = "OFF - The trigger is disabled\n0->30 More than or equal to the number of hits received per GCD\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->30 Больше или равно кол-ву полученных ударов за ГКД\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },
    RETALIATIONPHYSHP        = { enUS = WR.Retaliation:Info() .. "\n>= inc. phys. dmg (%)",
        ruRU = WR.Retaliation:Info() .. "\n>= вхд. физ. урона (%)" },    
    RETALIATIONPHYSHPTT     = { enUS = "OFF - The trigger is disabled\n0->100 More than or equal by the percentage of health of incoming physical damage per GCD\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->100 Больше или равно по проценту здоровья входящего физического урона за ГКД\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },
    LASTSTAND_KILLSTRIKE    = { enUS = WR.LastStand:Info() .. "\nCatch death hit",
        ruRU = WR.LastStand:Info() .. "\nПоймать смерт. удар" },    
    LASTSTAND_KILLSTRIKETT    = { enUS = "Try to manage to use\nability before receiving a fatal strike\nThis option is not related to other triggers!",
    ruRU = "Пытаться успеть использовать\nспособность до получения смертельного удара\nЭта опция не связана с другими триггерами!" },                                
    LASTSTANDHP                = { enUS = WR.LastStand:Info() .. "\n<= health (%)",
        ruRU = WR.LastStand:Info() .. "\n<= здоровья (%)" },    
    LASTSTANDHPTT            = { enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->100 Меньше или равно указанному проценту Вашего здоровья\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },
    LASTSTANDTTD            = { enUS = WR.LastStand:Info() .. "\n<= time to die (sec)",
        ruRU = WR.LastStand:Info() .. "\n<= время смерти (сек)" },    
    LASTSTANDTTDTT            = { enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
    ruRU = "OFF - Триггер отключен\n0->100 Меньше или равно указанному проценту Вашего здоровья\nВНИМАНИЕ: Должен быть хотя бы один из нескольких тригеров включен\nПри выборе нескольких триггеров они будут синхронизированы как одно общее условие" },                                
    STONEFORM                = { enUS = WR.Stoneform:Info() .. "\n<= health (%)",
        ruRU = WR.Stoneform:Info() .. "\n<= здоровья (сек)" },                                
    LASTSTAND_IGNORE        = { enUS = WR.LastStand:Info() .. "\nSkip if " .. WR.Retaliation:Info() .. " or " .. WR.ShieldWall:Info() .. " used",
        ruRU = WR.LastStand:Info() .. "\nПропускать если " .. WR.Retaliation:Info() .. " или " .. WR.ShieldWall:Info() .. " бафнуты" },    
    INTERRUPTS                = { enUS = "Interrupts",
    ruRU = "Прерывания" },    
    USESHIELD_TT            = { enUS = "Will equip shield to use ability\nDo nothing if you haven't shields in bags",
    ruRU = "Будет менять экипировать щит для использования способности\nНичего не делает если в сумках отсутствуют щиты" },                                
    USESTANCE_TT            = { enUS = "Will switch stance to use ability\nWARNING: This option is dependent on the rage limiter for specific stances",
    ruRU = "Будет менять стойку в нужную для использования способности\nВНИМАНИЕ: Эта опция зависима от ограничителя ярости по конкретным стойкам" },    
    USEBLOODRAGE_TT            = { enUS = "Will cast " .. WR.Bloodrage:Info() .. " if not enough rage to use ability\nIf your health percentage is greater than or equal to the set value",
        ruRU = "Будет использовать " .. WR.Bloodrage:Info() .. " если не хватает ярости для использования способности\nЕсли Ваш процент здоровья больше или равен выставленному значению" },
    USEBERSERKERRAGE_TT        = { enUS = "Will cast " .. WR.BerserkerRage:Info() .. " if not enough rage to use ability",
        ruRU = "Будет использовать " .. WR.BerserkerRage:Info() .. " если не хватает ярости для использования способности" },                    
    USESHIELD_SHIELDBASH    = { enUS = WR.ShieldBash:Info() .. "\nEquip Shield",
        ruRU = WR.ShieldBash:Info() .. "\nЭкипировать Щит" },
    USESTANCE_SHIELDBASH    = { enUS = WR.ShieldBash:Info() .. "\nSwitch Stance",
        ruRU = WR.ShieldBash:Info() .. "\nМенять Стойку" },
    USEBLOODRAGE_SHIELDBASH    = { enUS = WR.ShieldBash:Info() .. "\n" .. WR.Bloodrage:Info() .. "\n>= health (%)",
        ruRU = WR.ShieldBash:Info() .. "\n" .. WR.Bloodrage:Info() .. "\n>= здоровья (%)" },    
    USEBERSERKERRAGE_PUMMEL    = { enUS = WR.Pummel:Info() .. "\nUse " .. WR.BerserkerRage:Info(),
        ruRU = WR.Pummel:Info() .. "\nИспользовать " .. WR.BerserkerRage:Info() },
    USESTANCE_PUMMEL        = { enUS = WR.Pummel:Info() .. "\nSwitch Stance",
        ruRU = WR.Pummel:Info() .. "\nМенять Стойку" },
    USEBLOODRAGE_PUMMEL        = { enUS = WR.Pummel:Info() .. "\n" .. WR.Bloodrage:Info() .. "\n>= health (%)",
        ruRU = WR.Pummel:Info() .. "\n" .. WR.Bloodrage:Info() .. "\n>= здоровья (%)" },
    DISARM                    = { enUS = "PvP - Disarm",
    ruRU = "PvP - Обезоруживание" },
    USEBERSERKERRAGE_DISARM    = { enUS = WR.Disarm:Info() .. "\nUse " .. WR.BerserkerRage:Info(),
        ruRU = WR.Disarm:Info() .. "\nИспользовать " .. WR.BerserkerRage:Info() },
    USESTANCE_DISARM        = { enUS = WR.Disarm:Info() .. "\nSwitch Stance",
        ruRU = WR.Disarm:Info() .. "\nМенять Стойку" },
    USEBLOODRAGE_DISARM        = { enUS = WR.Disarm:Info() .. "\n" .. WR.Bloodrage:Info() .. "\n>= health (%)",
        ruRU = WR.Disarm:Info() .. "\n" .. WR.Bloodrage:Info() .. "\n>= здоровья (%)" },    
    TRIGGER                    = { enUS = "Triggers",
    ruRU = "Триггеры" },
    UNITS                    = { enUS = "Units",
    ruRU = "Цели" },    
    UNITS_TT                = { enUS = "@arena1-3 working only on BG\n@primary is @target and @mouseover (if checkbox enabled)",
    ruRU = "@arena1-3 работают только на БГ\n@primary это @target и @mouseover (если чекбокс включен)" },    
    DISARM_TRIGGER_TT        = { enUS = "'ON COOLDOWN' as soon as available on melee unit\n'ON BURST' only if melee unit has burst buffs\n'OFF' doesn't work at all",
    ruRU = "'ON COOLDOWN' как только доступно по ближ.-бой цели\n'ON BURST' только если ближ.-бой цель в бурст бафах\n'OFF' выключено полностью" },            
    PVP                        = { ANY = "PvP" },    
    DEFENSIVESTANCE_PVP        = { enUS = WR.DefensiveStance:Info() .. "\nTry uptime",
        ruRU = WR.DefensiveStance:Info() .. "\nПытаться поддерживать"},    
    DEFENSIVESTANCE_PVP_TT    = { enUS = "Try to be in this stance in combat if there is no way to attack",
    ruRU = "Пытаться быть в данной стойке в бою если нет возможности атаковать" },                                
    TRYTOFINDINVISIBLE        = { enUS = "Try To\nFind Invisible",
    ruRU = "Пытаться\nНайти Невидимок" },    
    TRYTOFINDINVISIBLETT     = { enUS = "Will use Perception\nAs soon as any one around entered combat and in enemy team exist stealthed units\nAlso will use Perception by react on used stealth spells around",
    ruRU = "Будет использовать Внимательность\nКак только кто-нибудь поблизости войдет в бой и в команде противника есть скрытые юниты\nТакже использует Внимательность на недавно использованные способности невидимости рядом" },                        
    INTERRUPTSPVP            = { enUS = "Interrupt Units",
    ruRU = "Цели Прерываний" },    
    INTERRUPTSPVP_TT        = { enUS = "@arena1-3 working only on BG",
    ruRU = "@arena1-3 работают только на БГ" },
    QUEUEBASE                = { enUS = "Queue Base",
    ruRU = "База Очереди" },    
    QUEUE_SWALL                = { enUS = "Set Queue\n" .. WR.ShieldWall:Info(),
        ruRU = "Установить Очередь\n" .. WR.ShieldWall:Info() },    
    QUEUE_SWALL_TT            = { enUS = "Left Click: Launch combo\nRight Click: Create macro\nThere will be a notification in the chat if the queue cannot be started\nYou can spam this macro, already existed queue will not be canceled!\n\nPriority of this combo:\n1. " .. WR.ShieldWall:Info() .. "\n2. " .. WR.ShieldBlock:Info() .. "\n3. " .. WR.DefensiveStance:Info() .. "\n4. " .. WR.SwapWeapon:Info(),
        ruRU = "Левый щелчок: Запустить комбо\nПравый щелчок: Создать макрос\nВ чате будет уведомление если очередь не может быть запущена\nВы можете спамить данный макрос, уже существующая очередь не будет отменена!\n\nПриоритет данного комбо:\n1. " .. WR.ShieldWall:Info() .. "\n2. " .. WR.ShieldBlock:Info() .. "\n3. " .. WR.DefensiveStance:Info() .. "\n4. " .. WR.SwapWeapon:Info() },                                    
    QUEUE_SBLOCK            = { enUS = "Set Queue\n" .. WR.ShieldBlock:Info(),
        ruRU = "Установить Очередь\n" .. WR.ShieldBlock:Info() },    
    QUEUE_SBLOCK_TT            = { enUS = "Left Click: Launch combo\nRight Click: Create macro\nThere will be a notification in the chat if the queue cannot be started\nYou can spam this macro, already existed queue will not be canceled!\n\nPriority of this combo:\n1. " .. WR.ShieldBlock:Info() .. "\n2. " .. WR.DefensiveStance:Info() .. "\n3. " .. WR.SwapWeapon:Info(),
        ruRU = "Левый щелчок: Запустить комбо\nПравый щелчок: Создать макрос\nВ чате будет уведомление если очередь не может быть запущена\nВы можете спамить данный макрос, уже существующая очередь не будет отменена!\n\nПриоритет данного комбо:\n1. " .. WR.ShieldBlock:Info() .. "\n2. " .. WR.DefensiveStance:Info() .. "\n3. " .. WR.SwapWeapon:Info() },
    QUEUE_SSTRIKES            = { enUS = "Set Queue\n" .. WR.SweepingStrikes:Info(),
        ruRU = "Установить Очередь\n" .. WR.SweepingStrikes:Info() },    
    QUEUE_SSTRIKES_TT        = { enUS = "Left Click: Launch combo\nRight Click: Create macro\nThere will be a notification in the chat if the queue cannot be started\nYou can spam this macro, already existed queue will not be canceled!\n\nPriority of this combo:\n1. " .. WR.SweepingStrikes:Info() .. "\n2. " .. WR.Bloodrage:Info() .. "\n3. " .. WR.BattleStance:Info() .. "\nWARNING: " .. WR.Bloodrage:Info() .. " Depends on the limit of your health settings (above)!",
        ruRU = "Левый щелчок: Запустить комбо\nПравый щелчок: Создать макрос\nВ чате будет уведомление если очередь не может быть запущена\nВы можете спамить данный макрос, уже существующая очередь не будет отменена!\n\nПриоритет данного комбо:\n1. " .. WR.SweepingStrikes:Info() .. "\n2. " .. WR.Bloodrage:Info() .. "\n3. " .. WR.BattleStance:Info() .. "\nВНИМАНИЕ: " .. WR.Bloodrage:Info() .. " зависит от лимита настройки Вашего здоровья (выше)!" },                            
}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v1 (02.10.2019)",
    [2]                                             = { LayoutOptions = { gutter = 2, padding = { left = 5, right = 5 } }  }, 
    [7]                                             = { 
        ["kick"] = { Enabled = true, Key = "Pummel", LUAVER = 1, LUA = [[
                -- This will not switch stance!
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "DamagePhysImun", "KickImun"}
                local castLeft, _, _, _, notInterruptAble = Unit(thisunit):IsCastingRemains() 
                return     Obj.Pummel and 
                        Obj.Pummel:IsReadyM(thisunit) and 
                        Obj.Pummel:AbsentImun(thisunit, Temp) and 
                        castLeft > 0 and     
                        not notInterruptAble 
            ]] },
        ["kick "] = { Enabled = true, Key = "ShieldBash", LUAVER = 1, LUA = [[
                -- This will not switch stance and equip shield!
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "DamagePhysImun", "KickImun"}
                local castLeft, _, _, _, notInterruptAble = Unit(thisunit):IsCastingRemains() 
                return     Obj.ShieldBash and 
                        Obj.ShieldBash:IsReadyM(thisunit) and 
                        Obj.ShieldBash:AbsentImun(thisunit, Temp) and 
                        castLeft > 0 and     
                        not notInterruptAble 
            ]] },    
        ["fear"] = { Enabled = true, Key = "IntimidatingShout", LUAVER = 1, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "DamagePhysImun", "FearImun"}
                return     Obj.IntimidatingShout and 
                        Obj.IntimidatingShout:IsReadyM(thisunit) and 
                        Obj.IntimidatingShout:AbsentImun(thisunit, Temp) and 
                        Unit(thisunit):IsControlAble("fear") 
            ]] },
        ["disarm"] = { Enabled = true, Key = "Disarm", LUAVER = 1, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "DamagePhysImun", "CCTotalImun"}
                return     Obj.Disarm and 
                        Obj.Disarm:IsReadyM(thisunit) and 
                        Obj.Disarm:AbsentImun(thisunit, Temp) and 
                        Unit(thisunit):IsControlAble("disarm")  
            ]] },        
        ["stun"] = { Enabled = true, Key = "ConcussionBlow", LUAVER = 1, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"}
                return     Obj.ConcussionBlow and 
                        Obj.ConcussionBlow:IsReadyM(thisunit) and 
                        Obj.ConcussionBlow:AbsentImun(thisunit, Temp) and 
                        Unit(thisunit):IsControlAble("stun")  
            ]] },
        ["laststand"] = { Enabled = true, Key = "LastStand", LUAVER = 1, LUA = [[
                -- Only if word 'laststand player' is exactly player (you), otherwise use 'laststand raid1' if there are few warriors with it
                -- Just 'laststand' is not working!
                local Obj     = Action[Action.PlayerClass]                
                return     Obj.LastStand and 
                        Obj.LastStand:IsReadyM(thisunit) and 
                        thisunit and 
                        UnitIsUnit(thisunit, "player")
            ]] },    
        ["retaliation"] = { Enabled = true, Key = "Retaliation", LUAVER = 1, LUA = [[
                -- This will not change stance!
                -- Only if word 'retaliation player' is exactly player (you), otherwise use 'retaliation raid1' if there are few warriors with it
                -- Just 'retaliation' is not working!
                local Obj     = Action[Action.PlayerClass]            
                return     Obj.Retaliation and 
                        Obj.Retaliation:IsReadyM(thisunit) and 
                        thisunit and 
                        UnitIsUnit(thisunit, "player")
            ]] },    
        ["shieldwall"] = { Enabled = true, Key = "ShieldWall", LUAVER = 1, LUA = [[
                -- This will not equip shield and change stance!
                -- Only if word 'shieldwall player' is exactly player (you), otherwise use 'shieldwall raid1' if there are few warriors with it
                -- Just 'shieldwall' is not working!
                local Obj     = Action[Action.PlayerClass]            
                return     Obj.ShieldWall and 
                        Obj.ShieldWall:IsReadyM(thisunit) and 
                        thisunit and 
                        UnitIsUnit(thisunit, "player")
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
    {
        E         = "Checkbox", 
        DB         = "CancelauraPOWS",
        DBV     = true,
        L         = L.CANCELPOWS,
        TT        = L.CANCELPOWSTT,
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "CancelauraBOP",
        DBV     = true,
        L         = L.CANCELBOP,
        TT        = L.CANCELBOPTT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][2]                                = {    -- Stances 
    {
        E         = "Header",
        L         = L.STANCES, 
    },
}
A.Data.ProfileUI[2][3]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "BattleStancePowerLimit",
        DBV     = -1,
        ONLYOFF = true,
        L         = L.BATTLESTANCE,
        TT        = L.STANCESTT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "DefensiveStancePowerLimit",
        DBV     = -1,
        ONLYOFF = true,
        L         = L.DEFENSIVESTANCE,
        TT        = L.STANCESTT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "BerserkerStancePowerLimit",
        DBV     = -1,
        ONLYOFF = true,
        L         = L.BERSERKERSTANCE,
        TT        = L.STANCESTT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][4]                                = {    -- Rotation
    {
        E         = "Header",
        L         = L.ROTATION, 
    },
}
A.Data.ProfileUI[2][5]                                = {
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 200,                            
        DB         = "Hamstring-PWR",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.HAMSTRING_PWR,
        TT        = L.HAMSTRING_PWRTT,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "IsLevelingRotation",
        DBV     = true,
        L         = L.LEVELING,
        TT         = L.LEVELINGTT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "Bloodrage-OnlyDamager",
        DBV     = false,
        L         = L.BLOODRAGE_DAMAGER,
        TT        = L.BLOODRAGE_DAMAGERTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][6]                                = {
    RowOptions = { margin = { top = 5 } },    
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "ThreatDamagerLimit",
        DBV     = 95,
        ONLYOFF    = true,
        L         = L.THREATLIMIT,
        TT        = L.THREATLIMITTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 60,                            
        DB         = "Bloodrage-AtCombatTime",
        DBV     = 7,
        ONLYOFF    = true,
        L         = L.BLOODRAGE_ATCOMBAT,
        TT        = L.BLOODRAGE_ATCOMBATTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "Bloodrage-LimitHP",
        DBV     = 70,
        ONOFF     = false,
        L         = L.BLOODRAGE_LIMITHP,
        TT        = L.BLOODRAGE_LIMITHPTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][7]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 200,                            
        DB         = "HeroicStrike-PWR",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.HEROICSTRIKE_PWR,
        TT        = L.HEROICSTRIKE_PWRTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 200,                            
        DB         = "Cleave-PWR",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.CLEAVE_PWR,
        TT        = L.CLEAVE_PWRTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 200,                            
        DB         = "Overpower-PWR-Below",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.OVERPOWER_PWR,
        TT        = L.OVERPOWER_PWRTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][8]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Checkbox", 
        DB         = "UseBerserkerRage-GainRage",
        DBV     = true,
        L         = L.USEBERSERKERRAGE_GAIN,
        TT         = L.USEBERSERKERRAGE_GAINTT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseHamstring-Outside",
        DBV     = true,
        L         = L.USEHAMSTRING_OUTSIDE,
        TT         = L.USEHAMSTRING_OUTSIDETT, 
        M         = {},
    },
}
A.Data.ProfileUI[2][9]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Checkbox", 
        DB         = "UseBerserkerRage-LoC",
        DBV     = true,
        L         = L.USEBERSERKERRAGE_LOC,
        TT         = L.LOC_TT, 
        M         = {},
    },    
    {
        E         = "Checkbox", 
        DB         = "UseDeathWish-LoC",
        DBV     = false,
        L         = L.USEDEATHWISH_LOC,
        TT         = L.LOC_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseRacial-LoC",
        DBV     = true,
        L         = L.USERACIAL_LOC,
        TT         = L.USERACIAL_LOCTT, 
        M         = {},
    },
}
A.Data.ProfileUI[2][10]                                = { -- Burst Configuration
    {
        E         = "Header",
        L         = L.BURST_CONFIGURATION, 
    },
}
A.Data.ProfileUI[2][11]                                = {
    {
        E         = "Checkbox", 
        DB         = "BurstTimingTo20",
        DBV     = true,
        L         = L.BURST_TIMING,
        TT         = L.BURST_TIMINGTT, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "ChallengingShout-Units",
        DBV     = 8,
        ONLYOFF    = true,
        L         = L.CHALLENGINGSHOUT,
        TT        = L.CHALLENGINGSHOUTTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][12]                                = { -- Defense
    {
        E         = "Header",
        L         = L.DEFENSE, 
    },
}
A.Data.ProfileUI[2][13]                                = { 
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Checkbox", 
        DB         = "ShieldWallCatchKillStrike",
        DBV     = true,
        L         = L.SHIELDWALL_KILLSTRIKE,
        TT         = L.SHIELDWALL_KILLSTRIKETT, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "ShieldWallHP",
        DBV     = 20,
        ONLYOFF    = true,
        L         = L.SHIELDWALL_HP,
        TT        = L.SHIELDWALL_HPTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 20,                            
        DB         = "ShieldWallTTD",
        DBV     = 5,
        ONLYOFF    = true,
        L         = L.SHIELDWALL_TTD,
        TT        = L.SHIELDWALL_TTDTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][14]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 30,                            
        DB         = "RetaliationAttackUnits",
        DBV     = 1,
        ONLYOFF    = true,
        L         = L.RETALIATIONATTACKUNITS,
        TT        = L.RETALIATIONATTACKUNITSTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 20,                            
        DB         = "RetaliationRangeUnits",
        DBV     = 8,
        ONLYOFF    = true,
        L         = L.RETALIATIONRANGEUNITS,
        TT        = L.RETALIATIONRANGEUNITSTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "RetaliationHP",
        DBV     = 20,
        ONLYOFF    = true,
        L         = L.RETALIATIONHP,
        TT        = L.RETALIATIONHPTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][15]                                = {
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 20,                            
        DB         = "RetaliationTTD",
        DBV     = 5,
        ONLYOFF    = true,
        L         = L.RETALIATIONTTD,
        TT        = L.RETALIATIONTTDTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 30,                            
        DB         = "RetaliationHits",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.RETALIATIONHITS,
        TT        = L.RETALIATIONHITSTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "RetaliationPhysHP",
        DBV     = -1,
        ONLYOFF    = true,
        L         = L.RETALIATIONPHYSHP,
        TT        = L.RETALIATIONPHYSHPTT,
        M         = {},
    },
}
A.Data.ProfileUI[2][16]                                = {  
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Checkbox", 
        DB         = "LastStandCatchKillStrike",
        DBV     = true,
        L         = L.LASTSTAND_KILLSTRIKE,
        TT         = L.LASTSTAND_KILLSTRIKETT, 
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "LastStandHP",
        DBV     = 20,
        ONLYOFF    = true,
        L         = L.LASTSTANDHP,
        TT        = L.LASTSTANDHPTT,
        M         = {},
    },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 20,                            
        DB         = "LastStandTTD",
        DBV     = 5,
        ONLYOFF    = true,
        L         = L.LASTSTANDTTD,
        TT        = L.LASTSTANDTTDTT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][17]                                = {  
    RowOptions = { margin = { top = 5 } },
    {
        E         = "Slider",                                                     
        MIN     = -1, 
        MAX     = 100,                            
        DB         = "Stoneform",
        DBV     = 100,
        ONOFF    = true,
        L         = L.STONEFORM,
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "LastStandIgnoreBigDeff",
        DBV     = true,
        L         = L.LASTSTAND_IGNORE,
        M         = {},
    },
}
A.Data.ProfileUI[2][18]                                = { -- Interrupts
    {
        E         = "Header",
        L         = L.INTERRUPTS, 
    },
}
A.Data.ProfileUI[2][19]                                = { 
    RowOptions = { margin = { top = 15 } },
    {
        E         = "Checkbox", 
        DB         = "UseShield-ShieldBash",
        DBV     = true,
        L         = L.USESHIELD_SHIELDBASH,
        TT         = L.USESHIELD_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseStance-ShieldBash",
        DBV     = true,
        L         = L.USESTANCE_SHIELDBASH,
        TT         = L.USESTANCE_TT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "UseBloodrage-ShieldBash",
        DBV     = 70,
        ONLYOFF    = true,
        L         = L.USEBLOODRAGE_SHIELDBASH,
        TT        = L.USEBLOODRAGE_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][20]                                = {
    RowOptions = { margin = { top = 15 } },
    {
        E         = "Checkbox", 
        DB         = "UseBerserkerRage-Pummel",
        DBV     = true,
        L         = L.USEBERSERKERRAGE_PUMMEL,
        TT         = L.USEBERSERKERRAGE_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseStance-Pummel",
        DBV     = true,
        L         = L.USESTANCE_PUMMEL,
        TT         = L.USESTANCE_TT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "UseBloodrage-Pummel",
        DBV     = 70,
        ONLYOFF    = true,
        L         = L.USEBLOODRAGE_PUMMEL,
        TT        = L.USEBLOODRAGE_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][21]                                = { -- Disarm 
    {
        E         = "Header",
        L         = L.DISARM, 
    },
}
A.Data.ProfileUI[2][22]                                = {
    RowOptions = { margin = { top = 15 } },
    {
        E         = "Checkbox", 
        DB         = "UseBerserkerRage-Disarm",
        DBV     = true,
        L         = L.USEBERSERKERRAGE_DISARM,
        TT         = L.USEBERSERKERRAGE_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "UseStance-Disarm",
        DBV     = true,
        L         = L.USESTANCE_DISARM,
        TT         = L.USESTANCE_TT,
        M         = {},
    },    
    {
        E         = "Slider",                                                     
        MIN     = 0, 
        MAX     = 100,                            
        DB         = "UseBloodrage-Disarm",
        DBV     = 70,
        ONLYOFF    = true,
        L         = L.USEBLOODRAGE_DISARM,
        TT        = L.USEBLOODRAGE_TT,
        M         = {},
    },
}
A.Data.ProfileUI[2][23]                                = {
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "ON COOLDOWN", value = "ON COOLDOWN" },
            { text = "ON BURST",     value = "ON BURST" },
            { text = "OFF",         value = "OFF" },
        },
        DB         = "Trigger-Disarm",
        DBV     = "ON BURST", 
        L         = L.TRIGGER,
        TT         = L.DISARM_TRIGGER_TT,
        M = {},                                    
    },        
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "@arena1",  value = 1 },
            { text = "@arena2",  value = 2 },
            { text = "@arena3",  value = 3 },
            { text = "@primary", value = 4 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "OFF" },
        DB         = "Units-Disarm",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
            [4] = true,
        }, 
        L         = L.UNITS,
        TT         = L.UNITS_TT,
        M = {},                                    
    },    
}
A.Data.ProfileUI[2][24]                                = { -- PvP
    {
        E         = "Header",
        L         = L.PVP,
    },
}
A.Data.ProfileUI[2][25]                                = {
    {
        E         = "Checkbox", 
        DB         = "PvP-DefensiveStance",
        DBV     = true,
        L         = L.DEFENSIVESTANCE_PVP,
        TT         = L.DEFENSIVESTANCE_PVP_TT, 
        M         = {},
    },
    {
        E         = "Checkbox", 
        DB         = "TryToFindInvisible",
        DBV     = true,
        L         = L.TRYTOFINDINVISIBLE,
        TT         = L.TRYTOFINDINVISIBLETT,
        M         = {},
    },    
}
A.Data.ProfileUI[2][26]                                = { 
    {
        E         = "Dropdown",                                                         
        OT         = {
            { text = "@arena1",  value = 1 },
            { text = "@arena2",  value = 2 },
            { text = "@arena3",  value = 3 },
        },
        MULT     = true,    
        SetPlaceholder = { ANY = "OFF" },
        DB         = "InterruptsPvP",
        DBV     = {
            [1] = true, 
            [2] = true,
            [3] = true,
        }, 
        L         = L.INTERRUPTSPVP,
        TT         = L.INTERRUPTSPVP_TT,
        M = {},                                    
    },    
}
A.Data.ProfileUI[2][27]                                = { -- Queue Base
    {
        E         = "Header",
        L         = L.QUEUEBASE,
    },
}
A.Data.ProfileUI[2][28]                                = {  
    RowOptions = { margin = { top = -10 } },
    {
        E         = "Button",
        H         = 35,
        OnClick = function(self, button, down)     
            if button == "LeftButton" then 
                Action.QueueBase("ShieldWall")
            else                
                Action.CraftMacro("QB:SW", [[#showtip ]] .. WR.ShieldWall:Info() .. "\n" .. [[/run Action.QueueBase("ShieldWall")]], 1, true, true) 
            end 
        end, 
        L         = L.QUEUE_SWALL,
        TT         = L.QUEUE_SWALL_TT,                            
    },    
    {
        E         = "Button",
        H         = 35,
        OnClick = function(self, button, down)     
            if button == "LeftButton" then 
                Action.QueueBase("ShieldBlock")
            else                
                Action.CraftMacro("QB:SB", [[#showtip ]] .. WR.ShieldBlock:Info() .. "\n" .. [[/run Action.QueueBase("ShieldBlock")]], 1, true, true) 
            end 
        end, 
        L         = L.QUEUE_SBLOCK,
        TT         = L.QUEUE_SBLOCK_TT,                            
    },    
    {
        E         = "Button",
        H         = 35,
        OnClick = function(self, button, down)     
            if button == "LeftButton" then 
                Action.QueueBase("SweepingStrikes")
            else                
                Action.CraftMacro("QB:SS", [[#showtip ]] .. WR.SweepingStrikes:Info() .. "\n" .. [[/run Action.QueueBase("SweepingStrikes")]], 1, true, true) 
            end 
        end, 
        L         = L.QUEUE_SSTRIKES,
        TT         = L.QUEUE_SSTRIKES_TT,                            
    },    
}

