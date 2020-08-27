--------------------------------
-- Taste TMW Action ProfileUI --
--------------------------------
local TMW											= TMW 
local CNDT											= TMW.CNDT
local Env											= CNDT.Env

local A												= Action
local GetToggle										= A.GetToggle
local InterruptIsValid								= A.InterruptIsValid

local UnitCooldown									= A.UnitCooldown
local Unit											= A.Unit 
local Player										= A.Player 
local Pet											= A.Pet
local LoC											= A.LossOfControl
local MultiUnits									= A.MultiUnits
local EnemyTeam										= A.EnemyTeam
local FriendlyTeam									= A.FriendlyTeam
local TeamCache										= A.TeamCache
local InstanceInfo									= A.InstanceInfo
local TR                                            = Action.TasteRotation
local select, setmetatable							= select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v4.3.8 (02.08.2020)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_HUNTER_BEASTMASTERY] = { 
		LayoutOptions = { gutter = 4, padding = { left = 5, right = 5 } },
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },		
            { -- [1] 1st Row
		
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                },    
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Range By Pet", value = "RangeByPet" },
                        { text = "Range By Nameplate", value = "RangeByNameplate" },                    
                        { text = "Range By CLEU", value = "RangeByCLEU" },
                    },
                    DB = "AoEMode",
                    DBV = "RangeByPet",
                    L = { 
                        ANY = "AoE\nDetection Mode",
                    }, 
                    TT = { 
                        enUS = "Set the mode you want to use.\nRange By Pet: Get number of enemies in pet range by checking Bite, Smack and Claw attack. \nRange By Nameplate: Get number of enemies with nameplates. \nRange By CLEU: Get number of enemies with combat events logs.\n!!!DON'T FORGET TO ADD BITE, SMACK OR CLAW IN YOUR SPELLBAR. NOT THE PET SPELLBAR.", 
                        ruRU = "Установите режим, который вы хотите использовать.\nRange By Pet: Получите количество врагов в радиусе действия питомца, проверив атаку Укус, Чмок и Коготь.\nRange By Nameplate: Получить количество врагов с именными табличками.\nRange By CLEU: получите количество врагов с журналами боевых событий.\n !!! НЕ ЗАБУДЬТЕ ДОБАВИТЬ Укус, ОЗОР ИЛИ КОЛОДОК В ВАШУ КОЛОНКУ. НЕ ЛЮБИМЫЙ КОЛЛЕКТОР.",
                        frFR = "Définissez le mode que vous souhaitez utiliser.\nRange By Pet: Obtenez le nombre d'ennemis à portée de familier en vérifiant l'attaque Bite, Smack et Claw.\nRange By Nameplate: Obtenez le nombre d'ennemis avec les nameplates.\nRange By CLEU: Obtenez le nombre d'ennemis avec les journaux des événements de combat.\n!!! N'OUBLIEZ PAS D'AJOUTER UNE MORSURE, UNE FUMÉE OU UNE GRIFFE DANS VOTRE SPELLBAR. PAS LE SPELLBAR PET."
  				    }, 
                    M = {},
                },	
                {
                    E = "Checkbox", 
                    DB = "TasteInterruptList",
                    DBV = true,
                    L = { 
                        enUS = "Use BFA Mythic+ & Raid\nsmart interrupt list", 
                        ruRU = "использование BFA Mythic+ & Raid\nумный список прерываний", 
                        frFR = "Liste d'interrupts intelligente\nBFA Mythic+ & Raid",
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will force a special interrupt list containing all the BFA Mythic+ and Raid stuff WHEN YOU ARE IN MYTHIC+ OR RAID ZONE.\nYou can edit this list in the Interrupts tab\nand customize it as you want",
                        ruRU = "Если включено : Запустит специальный список прерываний, содержащий все BFA Mythic+ и Raid stuff КОГДА ВЫ НАХОДИТЕСЬ В МИФИЧЕСКОЙ + ИЛИ ЗОНЕ RAID.\nВы можете редактировать этот список на вкладке Прерывания\nи настраивай как хочешь",
                        frFR = "Si activé : Force une liste d'interruption spéciale contenant tous les éléments BFA Mythic + et Raid QUAND VOUS ETES EN MYTHIC+ OU EN RAID.\nVous pouvez modifier cette liste dans l'onglet Interruptions\net la personnaliser comme vous le souhaitez", 
                    }, 
                    M = {},
                },					
            }, 
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },	
			{
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
							TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
                {
                    E = "Checkbox", 
                    DB = "ChangelogOnStartup",
                    DBV = true,
                    L = { 
                        enUS = "Changelog On Startup", 
                        ruRU = "Журнал изменений при запуске", 
                        frFR = "Journal des modifications au démarrage",
                    }, 
                    TT = { 
                        enUS = "Will show latest changelog of the current rotation when you enter in game.\nDisable this option to block the popup when you enter the game.", 
                        ruRU = "При входе в игру будет отображаться последний список изменений текущего вращения.\nОтключить эту опцию, чтобы заблокировать всплывающее окно при входе в игру.", 
                        frFR = "Affiche le dernier journal des modifications de la rotation actuelle lorsque vous entrez dans le jeu.\nDésactivez cette option pour bloquer la fenêtre contextuelle lorsque vous entrez dans le jeu..", 
                    }, 
                    M = {},
                }, 
			},	
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Checkbox", 
                    DB = "UseFeignDeathOnThingFromBeyond",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(5384) .. "\nThing From Beyond", 
                        ruRU = A.GetSpellInfo(5384) .. "\nThing From Beyond", 
                        frFR = A.GetSpellInfo(5384) .. "\nThing From Beyond", 
                    }, 
                    TT = { 
                        enUS = "Completly avoid the Thing from Beyond that spawn with more than 40+ corruption.", 
                        ruRU = "Полностью избегайте «Вещи из-за» этого спавна с более чем 40+ порчей.", 
                        frFR = "Évitez complètement la Chose d'Au-delà qui apparaît avec plus de 40+ corruption.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AspectoftheWildOnCDRapidReload",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(193530) .. "\non CD Rapid Reload", 
                        ruRU = A.GetSpellInfo(193530) .. "\non CD Rapid Reload", 
                        frFR = A.GetSpellInfo(193530) .. "\non CD Rapid Reload", 
                    }, 
                    TT = { 
                        enUS = "Force " .. A.GetSpellInfo(193530) .. " to be used on CD in Dungeon with Rapid Reload azerite enabled.", 
                        ruRU = "Force " .. A.GetSpellInfo(193530) .. " Это может быть использовано в Dunge Les Dungeon с чертой характера.", 
                        frFR = "Force " .. A.GetSpellInfo(193530) .. " à être utilisé dès que possible dans les Dungeon avec le trait azerite Rapid Reload activé.", 
                    }, 
                    M = {},
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "TrinketsAoE",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nAoE only", 
                        ruRU = "Trinkets\nAoE only",  
                        frFR = "Trinkets\nAoE only",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets for AoE usage ONLY.", 
                        ruRU = "Включите эту опцию для Брелков ТОЛЬКО для использования AoE.", 
                        frFR = "Activez cette option pour les trinkets pour une utilisation AoE UNIQUEMENT.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "TrinketsMinTTD",
                    DBV = 5, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min TTD",
                    },
                    TT = { 
                        enUS = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        ruRU = "Минимальное время до смерти для юнитов в радиусе действия до использования Брелков.\nПРИМЕЧАНИЕ. При этом будет рассчитано время до смерти текущей цели ИЛИ время до смерти в случае обнаружения нескольких единиц.", 
                        frFR = "Temps minimum pour mourir pour les unités à portée avant d'utiliser des Trinkets.\nREMARQUE: Cela calculera le temps de mourir de votre cible actuelle OU le temps de mourir de la zone si plusieurs unités sont détectées.", 
                    },					
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "TrinketsMinUnits",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min Units",
                    },
                    TT = { 
                        enUS = "Minimum number of units in range to activate Trinkets.", 
                        ruRU = "Минимальное количество юнитов в радиусе действия для активации Брелков.", 
                        frFR = "Nombre minimum d'unités à portée pour activer les Trinkets.",  
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "TrinketsUnitsRange",
                    DBV = 30, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate trinkets.", 
                        ruRU = "Максимальная дальность обнаружения юнитов для автоматической активации безделушек.", 
                        frFR = "Portée maximale de détection des unités pour activer automatiquement les trinkets.",  
                    },					
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(2643) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "CheckLatency",
                    DBV = true,
                    L = { 
                        enUS = "Latency Prediction", 
                        ruRU = "Прогноз латентности",
                        frFR = "Prédiction de latence", 
                    }, 
                    TT = { 
                        enUS = "Enable this to option to check for latency before refreshing buffs.", 
                        ruRU = "Включите эту опцию, чтобы проверить задержку перед обновлением баффов.", 
                        frFR = "Activez cette option pour vérifier la latence avant d'actualiser les buffs.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5,                            
                    DB = "MultishotMinAoETargets",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(2643) .. "\nmin AoE units",
                    },
                    TT = { 
                        enUS = "Minimum units in range to automatically activate " .. A.GetSpellInfo(2643) .. ".", 
                        ruRU = "Минимальные единицы в диапазоне для автоматической активации " .. A.GetSpellInfo(2643) .. ".", 
                        frFR = "Unités minimales à portée pour activer automatiquement " .. A.GetSpellInfo(2643) .. ".",
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "MultishotMaxAoERange",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(2643) .. "\nmax AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate " .. A.GetSpellInfo(2643) .. ".", 
                        ruRU = "Максимальная дальность обнаружения единиц для автоматической активации " .. A.GetSpellInfo(2643) .. ".", 
                        frFR = "Plage maximale pour la détection des unités pour activer automatiquement " .. A.GetSpellInfo(2643) .. ".",  
                    },					
                    M = {},
                },
			},
			{
                {
                    E = "Checkbox", 
                    DB = "MultiShotForceAoE",
                    DBV = false,
                    L = { 
                        enUS = A.GetSpellInfo(2643) .. "\nforce in AoE", 
                        ruRU = A.GetSpellInfo(2643) .. "\nforce in AoE", 
                        frFR = A.GetSpellInfo(2643) .. "\nforce in AoE",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to force usage of " .. A.GetSpellInfo(2643) .. " in AoE.\nIMPORTANT: This will bypass all logic with Rapid Reload azerite!", 
                        ruRU = "Включите эту опцию, чтобы принудительно использовать " .. A.GetSpellInfo(2643) .. " in AoE.\nВАЖНО: Это обойдет всю логику с азеритом Rapid Reload!", 
                        frFR = "Activez cette option pour forcer l'utilisation de " .. A.GetSpellInfo(2643) .. " in AoE.\nIMPORTANT: Cela contournera toute logique avec l'azérite de rechargement rapide!", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0.25, 
                    MAX = 5,                            
                    DB = "BeastCleaveBuffRefresh",
                    DBV = 1.8, -- Set healthpercentage @60% life. 
					Precision = 1,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(118455) .. "\nrefresh sec",
                    },
                    TT = { 
                        enUS = "Minimum time remaining on pet buff " .. A.GetSpellInfo(118455) .. " before using " .. A.GetSpellInfo(2643) .. ".\nDefault: 1", 
                        ruRU = "Минимальное время, оставшееся на баффе " .. A.GetSpellInfo(118455) .. " Перед использованием " .. A.GetSpellInfo(2643) .. ".\nDefault: 1", 
                        frFR = "Temps minimum restant sur le buff " .. A.GetSpellInfo(118455) .. " avant d'utiliser " .. A.GetSpellInfo(2643) .. ".\nDefault: 1", 
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "BarbedShotRefreshSec",
                    DBV = 2, -- Set healthpercentage @60% life. 
					Precision = 1,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(217200) .. "\nrefresh sec",
                    },
                    TT = { 
                        enUS = "Minimum time remaining on pet buff Frenzy before using " .. A.GetSpellInfo(217200) .. ".\nDefault: 2\nIMPORTANT !!! This value can really change your DPS so play with setting to get the most optimized one.", 
                        ruRU = "Минимальное время, оставшееся на любителях безумия до использования " .. A.GetSpellInfo(217200) .. ".\nDefault: 2\nВАЖНЫЙ !!! Это значение может реально изменить ваш DPS, поэтому поиграйте с настройками, чтобы получить наиболее оптимизированный.",
                        frFR = "Temps minimum restant sur Frenzy buff animal avant d'utiliser " .. A.GetSpellInfo(217200) .. ".\nDefault: 2\nIMPORTANT !!! Cette valeur peut vraiment changer votre DPS, alors jouez avec le réglage pour obtenir le plus optimisé.",  
                    },					
                    M = {},
                },
			},
            -- Bestial Wrath
            -- Aspect of the WIld
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(19574) .. " -- ",
                    },
                },
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(193530) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "BestialWrathTTD",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(19574) .. " TTD",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "AspectoftheWildTTD",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(193530) .. " TTD",
                    }, 
                    M = {},
                },
			},
			{
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Burst Only", value = 1 },
                        { text = "Aoe Only", value = 2 },
                        { text = "Everytime", value = 3 },
                    },
                    MULT = true,
                    DB = "BestialWrathMode",
                    DBV = {
                        [1] = false, 
                        [2] = false,
                        [3] = true,
                    }, 
                    L = { 
                        ANY = A.GetSpellInfo(19574) .. " settings",
                    }, 
                    TT = { 
                        enUS = "Customize your " .. A.GetSpellInfo(19574) .. " options.\nMultiple checks possible.", 
                        ruRU = "Настройте параметры " .. A.GetSpellInfo(19574) .. ".\nМножественные проверки возможны.", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Burst Only", value = 1 },
                        { text = "Aoe Only", value = 2 },
                        { text = "Everytime", value = 3 },
                    },
                    MULT = true,
                    DB = "AspectoftheWildMode",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                        [3] = false,
                    }, 
                    L = { 
                        ANY = A.GetSpellInfo(193530) .. " settings",
                    }, 
                    TT = { 
                        enUS = "Customize your " .. A.GetSpellInfo(193530) .. " options.\nMultiple checks possible.", 
                        ruRU = "Настройте параметры " .. A.GetSpellInfo(193530) .. ".\nМножественные проверки возможны.", 
                    }, 
                    M = {},
                },
			},
            -- Blood of the enemy
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(298277) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "BloodoftheEnemySyncAoE",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(298277) .. " AoE sync", 
                        ruRU = A.GetSpellInfo(298277) .. " AoE sync",  
                        frFR = A.GetSpellInfo(298277) .. " AoE sync", 
                    }, 
                    TT = { 
                        enUS = "Enable this to option to keep " .. A.GetSpellInfo(298277) .. " for maximum AoE damage.", 
                        ruRU = "Включите эту опцию, чтобы сохранить " .. A.GetSpellInfo(298277) .. " для максимального AoE урона.", 
                        frFR = "Activez cette option pour conserver " .. A.GetSpellInfo(298277) .. " pour des dégâts AoE maximum.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 20,                            
                    DB = "BloodoftheEnemyAoETTD",
                    DBV = 10, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(298277) .. " AoE TTD",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 8,                            
                    DB = "BloodoftheEnemyUnits",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(298277) .. " AoE units",
                    }, 
                    TT = { 
                        enUS = "Minimum active units around before using " .. A.GetSpellInfo(298277) .. ".", 
                        ruRU = "Минимальное количество активных единиц перед использованием " .. A.GetSpellInfo(298277) .. ".", 
                        frFR = "Unités actives minimum autour avant d'utiliser " .. A.GetSpellInfo(298277) .. ".", 
                    },
                    M = {},
                },
			},
            { -- [7]  Azerite Beam settings
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(295258) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 				
		
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 50,                            
                    DB = "FocusedAzeriteBeamTTD",
                    DBV = 10, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(295258) .. "\nTTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(295258) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(295258) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "FocusedAzeriteBeamUnits",
                    DBV = 3, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(295258) .. "\nunits",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(295258) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(295258) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                }, 				
            },
            { -- [7] UnbridledFuryAuto
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(300714) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryAuto",
                    DBV = false,
                    L = { 
                        enUS = "Burst Potion", 
                        ruRU = "Burst Potion",
                        frFR = "Burst Potion",
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots depending of the settings of this section.", 
                        ruRU = "Если этот параметр активирован, произойдет автоматическая перезагрузка в зависимости от настроек этого раздела.", 
                        frFR = "Si cette option est activée, les potions seront automatiquement réactivés en fonction des paramètres de cette section", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithExecute",
                    DBV = false,
                    L = { 
                        enUS = "Sync execute phase", 
                        ruRU = "Sync выполнить этап",
                        frFR = "Sync phase d'exécution",   
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        ruRU = "Если этот параметр активирован, автоматическое повторение будет выполнено, как только будет обнаружена фаза выполнения.", 
                        frFR = "Si elle est activée, les pots seront automatiquement remis en marche dès que la phase d'exécution est détectée.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 60,      					
                    DB = "UnbridledFuryTTD",
                    DBV = 40, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(300714) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(300714) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(300714) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(300714) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },				
            },	

            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dummy DPS Test -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "DummyTime",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DPS Testing Time",
                    },
                    TT = { 
                        enUS = "Set the desired time for test in minutes.\nWill show a notification icon when time is expired.\nMin: 1 / Max: 10.", 
                        ruRU = "Установите желаемое время для теста в минутах.\nПо истечении времени будет отображаться значок уведомления.\nMin: 1 / Max: 10.",  
                        frFR = "Définissez la durée souhaitée pour le test en minutes.\nAffiche une icône de notification lorsque le temps est écoulé.\nMin: 1 / Max: 10.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "DummyStopDelay",
                    DBV = 10, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Stop Delay",
                    },
                    TT = { 
                        enUS = "After the dummy test is concluded, how much time should we stop the rotation. (In seconds)\nThis value is mainly used as a protection when you are out of combat to avoid auto attack.\nDefault value : 10 seconds.", 
                        ruRU = "После того, как фиктивный тест закончен, сколько времени мы должны остановить вращение. (В секундах)\nЭто значение в основном используется в качестве защиты, когда вы находитесь вне боя, чтобы избежать автоматической атаки.\nЗначение по умолчанию: 10 секунд.", 
                        frFR = "Une fois le test fictif terminé, combien de temps devons-nous arrêter la rotation. (En secondes)\nCette valeur est principalement utilisée comme protection lorsque vous êtes hors de combat pour éviter l'attaque automatique.\nValeur par défaut: 10 secondes.", 
                    }, 					
                    M = {},
                },
			},
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Сделаем ротацию, чтобы объявить импортерам информацию.\nПолезно, чтобы получить быстрый и четкий статус того, что делает ротация и почему она делает.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Fera la rotation pour annoncer des informations importantes.\nUtile pour obtenir un état rapide et clair de ce que fait la rotation et pourquoi elle le fait.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Будет использовать Smart Announcer только в бою.\nОтключите его, чтобы Smart Announcer работал вне боя, если доступны предварительные действия.\nFor example : Sap out of combat, pre potion.",
                        frFR = "N'utilisera Smart Announcer qu'en combat.\nDésactiver cela fera fonctionner Smart Announcer hors combat si des actions de précombat sont disponibles.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Вынудит определенную задержку прежде, чем исчезнут предупреждения.\nDefault value : 2 seconds.", 
                        frFR = "Forcer un délai spécifique avant la disparition des alertes.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Self Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ExhilarationHP",
                    DBV = 100, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(109304) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "SpiritMendHP",
                    DBV = 100, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(90361) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Turtle",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(186265) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Pet Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "MendPet",
                    DBV = 100, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(136) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "FreezingTrapPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(187650),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "FreezingTrapPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(187650) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_HUNTER_SURVIVAL] = { 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },		
            { -- [1] 1st Row
		
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                }, 
                {
                    E = "Checkbox", 
                    DB = "TasteInterruptList",
                    DBV = true,
                    L = { 
                        enUS = "Use BFA Mythic+ & Raid\nsmart interrupt list", 
                        ruRU = "использование BFA Mythic+ & Raid\nумный список прерываний", 
                        frFR = "Liste d'interrupts intelligente\nBFA Mythic+ & Raid",
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will force a special interrupt list containing all the BFA Mythic+ and Raid stuff WHEN YOU ARE IN MYTHIC+ OR RAID ZONE.\nYou can edit this list in the Interrupts tab\nand customize it as you want",
                        ruRU = "Если включено : Запустит специальный список прерываний, содержащий все BFA Mythic+ и Raid stuff КОГДА ВЫ НАХОДИТЕСЬ В МИФИЧЕСКОЙ + ИЛИ ЗОНЕ RAID.\nВы можете редактировать этот список на вкладке Прерывания\nи настраивай как хочешь",
                        frFR = "Si activé : Force une liste d'interruption spéciale contenant tous les éléments BFA Mythic + et Raid QUAND VOUS ETES EN MYTHIC+ OU EN RAID.\nVous pouvez modifier cette liste dans l'onglet Interruptions\net la personnaliser comme vous le souhaitez", 
                    }, 
                    M = {},
                },					
            },
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },	
			{
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
							TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
                {
                    E = "Checkbox", 
                    DB = "ChangelogOnStartup",
                    DBV = true,
                    L = { 
                        enUS = "Changelog On Startup", 
                        ruRU = "Журнал изменений при запуске", 
                        frFR = "Journal des modifications au démarrage",
                    }, 
                    TT = { 
                        enUS = "Will show latest changelog of the current rotation when you enter in game.\nDisable this option to block the popup when you enter the game.", 
                        ruRU = "При входе в игру будет отображаться последний список изменений текущего вращения.\nОтключить эту опцию, чтобы заблокировать всплывающее окно при входе в игру.", 
                        frFR = "Affiche le dernier journal des modifications de la rotation actuelle lorsque vous entrez dans le jeu.\nDésactivez cette option pour bloquer la fenêtre contextuelle lorsque vous entrez dans le jeu..", 
                    }, 
                    M = {},
                }, 
			},	
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "TrinketsAoE",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nAoE only", 
                        ruRU = "Trinkets\nAoE only",  
                        frFR = "Trinkets\nAoE only",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets for AoE usage ONLY.", 
                        ruRU = "Включите эту опцию для Брелков ТОЛЬКО для использования AoE.", 
                        frFR = "Activez cette option pour les trinkets pour une utilisation AoE UNIQUEMENT.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "TrinketsMinTTD",
                    DBV = 5, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min TTD",
                    },
                    TT = { 
                        enUS = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        ruRU = "Минимальное время до смерти для юнитов в радиусе действия до использования Брелков.\nПРИМЕЧАНИЕ. При этом будет рассчитано время до смерти текущей цели ИЛИ время до смерти в случае обнаружения нескольких единиц.", 
                        frFR = "Temps minimum pour mourir pour les unités à portée avant d'utiliser des Trinkets.\nREMARQUE: Cela calculera le temps de mourir de votre cible actuelle OU le temps de mourir de la zone si plusieurs unités sont détectées.", 
                    },					
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "TrinketsMinUnits",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min Units",
                    },
                    TT = { 
                        enUS = "Minimum number of units in range to activate Trinkets.", 
                        ruRU = "Минимальное количество юнитов в радиусе действия для активации Брелков.", 
                        frFR = "Nombre minimum d'unités à portée pour activer les Trinkets.",  
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "TrinketsUnitsRange",
                    DBV = 30, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate trinkets.", 
                        ruRU = "Максимальная дальность обнаружения юнитов для автоматической активации безделушек.", 
                        frFR = "Portée maximale de détection des unités pour activer automatiquement les trinkets.",  
                    },					
                    M = {},
                },
			},
            { -- [1] 1st Row
                {
                    E = "Checkbox", 
                    DB = "AspectoftheEagle",
                    DBV = true,
                    L = { 
                        enUS = "Show Aspect of the Eagle", 
                        ruRU = "Show Aspect of the Eagle", 
                        frFR = "Show Aspect of the Eagle",
                    }, 
                    TT = { 
                        enUS = "Show Aspect of the Eagle when out of Melee Range.", 
                        ruRU = "Show Aspect of the Eagle when out of Melee Range.", 
                        frFR = "Show Aspect of the Eagle when out of Melee Range.",
                    }, 
                    M = {},
                },  
                {
                    E = "Checkbox", 
                    DB = "UseSteelTrap",
                    DBV = true,
                    L = { 
                        enUS = "Use Steel Trap when available", 
                        ruRU = "Use Steel Trap when available", 
                        frFR = "Use Steel Trap when available",
                    }, 
                    TT = { 
                        enUS = "Show Steel Trap if available and out of Melee Range.", 
                        ruRU = "Show Steel Trap if available and out of Melee Range.", 
                        frFR = "Show Steel Trap if available and out of Melee Range.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseHarpoonOOR",
                    DBV = true,
                    L = { 
                        enUS = "Use Harpoon when available", 
                        ruRU = "Use Harpoon Trap when available", 
                        frFR = "Use Harpoon Trap when available",
                    }, 
                    TT = { 
                        enUS = "Show Harpoon if available and out of Melee Range.", 
                        ruRU = "Show Harpoon if available and out of Melee Range.", 
                        frFR = "Show Harpoon if available and out of Melee Range.", 
                    }, 
                    M = {},
                },  				
            }, 			
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ExhilarationHP",
                    DBV = 90, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(109304) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Turtle",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(186265) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "MendPet",
                    DBV = 90, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(136) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [7] UnbridledFuryAuto
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(300714) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryAuto",
                    DBV = false,
                    L = { 
                        enUS = "Burst Potion", 
                        ruRU = "Burst Potion",
                        frFR = "Burst Potion",
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots depending of the settings of this section", 
                        ruRU = "If activated, will auto re pots depending of the settings of this section", 
                        frFR = "If activated, will auto re pots depending of the settings of this section", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithExecute",
                    DBV = false,
                    L = { 
                        enUS = "Sync execute phase", 
                        ruRU = "Sync execute phase",
                        frFR = "Sync execute phase",   
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        ruRU = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        frFR = "If activated, will auto re pots as soon as Execute phase is detected.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 60,      					
                    DB = "UnbridledFuryTTD",
                    DBV = 40, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(300714) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(300714) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(300714) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(300714) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },				
            },	
            
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dummy DPS Test -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "DummyTime",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DPS Testing Time",
                    },
                    TT = { 
                        enUS = "Set the desired time for test in minutes.\nWill show a notification icon when time is expired.\nMin: 1 / Max: 10.", 
                        ruRU = "Установите желаемое время для теста в минутах.\nПо истечении времени будет отображаться значок уведомления.\nMin: 1 / Max: 10.",  
                        frFR = "Définissez la durée souhaitée pour le test en minutes.\nAffiche une icône de notification lorsque le temps est écoulé.\nMin: 1 / Max: 10.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "DummyStopDelay",
                    DBV = 10, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Stop Delay",
                    },
                    TT = { 
                        enUS = "After the dummy test is concluded, how much time should we stop the rotation. (In seconds)\nThis value is mainly used as a protection when you are out of combat to avoid auto attack.\nDefault value : 10 seconds.", 
                        ruRU = "После того, как фиктивный тест закончен, сколько времени мы должны остановить вращение. (В секундах)\nЭто значение в основном используется в качестве защиты, когда вы находитесь вне боя, чтобы избежать автоматической атаки.\nЗначение по умолчанию: 10 секунд.", 
                        frFR = "Une fois le test fictif terminé, combien de temps devons-nous arrêter la rotation. (En secondes)\nCette valeur est principalement utilisée comme protection lorsque vous êtes hors de combat pour éviter l'attaque automatique.\nValeur par défaut: 10 secondes.", 
                    }, 					
                    M = {},
                },
			},
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "FreezingTrapPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(187650),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "FreezingTrapPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(187650) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_HUNTER_MARKSMANSHIP] = { 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },		
            { -- [1] 1st Row
		
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                },				
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Range By Pet", value = "RangeByPet" },
                        { text = "Range By Nameplate", value = "RangeByNameplate" },                    
                        { text = "Range By CLEU", value = "RangeByCLEU" },
                    },
                    DB = "AoEMode",
                    DBV = "RangeByPet",
                    L = { 
                        ANY = "AoE\nDetection Mode",
                    }, 
                    TT = { 
                        enUS = "Set the mode you want to use. \nRange By Pet: Get number of enemies in pet range by checking Bite, Smack and Claw attack. \nRange By Nameplate: Get number of enemies with nameplates. \nRange By CLEU: Get number of enemies with combat events logs.\n!!!DON'T FORGET TO ADD BITE, SMACK OR CLAW IN YOUR SPELLBAR. NOT THE PET SPELLBAR.", 
                        ruRU = "Set the mode you want to use. \nRange By Pet: Get number of enemies in pet range. \nRange By Nameplate: Get number of enemies with nameplates. \nRange By CLEU: Get number of enemies with combat events logs.\n!!!DON'T FORGET TO ADD BITE, SMACK OR CLAW IN YOUR SPELLBAR. NOT THE PET SPELLBAR.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "TasteInterruptList",
                    DBV = true,
                    L = { 
                        enUS = "Use BFA Mythic+ & Raid\nsmart interrupt list", 
                        ruRU = "использование BFA Mythic+ & Raid\nумный список прерываний", 
                        frFR = "Liste d'interrupts intelligente\nBFA Mythic+ & Raid",
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will force a special interrupt list containing all the BFA Mythic+ and Raid stuff WHEN YOU ARE IN MYTHIC+ OR RAID ZONE.\nYou can edit this list in the Interrupts tab\nand customize it as you want",
                        ruRU = "Если включено : Запустит специальный список прерываний, содержащий все BFA Mythic+ и Raid stuff КОГДА ВЫ НАХОДИТЕСЬ В МИФИЧЕСКОЙ + ИЛИ ЗОНЕ RAID.\nВы можете редактировать этот список на вкладке Прерывания\nи настраивай как хочешь",
                        frFR = "Si activé : Force une liste d'interruption spéciale contenant tous les éléments BFA Mythic + et Raid QUAND VOUS ETES EN MYTHIC+ OU EN RAID.\nVous pouvez modifier cette liste dans l'onglet Interruptions\net la personnaliser comme vous le souhaitez", 
                    }, 
                    M = {},
                },					
            }, 
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },	
			{
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
							TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
                {
                    E = "Checkbox", 
                    DB = "ChangelogOnStartup",
                    DBV = true,
                    L = { 
                        enUS = "Changelog On Startup", 
                        ruRU = "Журнал изменений при запуске", 
                        frFR = "Journal des modifications au démarrage",
                    }, 
                    TT = { 
                        enUS = "Will show latest changelog of the current rotation when you enter in game.\nDisable this option to block the popup when you enter the game.", 
                        ruRU = "При входе в игру будет отображаться последний список изменений текущего вращения.\nОтключить эту опцию, чтобы заблокировать всплывающее окно при входе в игру.", 
                        frFR = "Affiche le dernier journal des modifications de la rotation actuelle lorsque vous entrez dans le jeu.\nDésactivez cette option pour bloquer la fenêtre contextuelle lorsque vous entrez dans le jeu..", 
                    }, 
                    M = {},
                }, 
			},	
            { -- [1] 1st Row
                {
                    E = "Checkbox", 
                    DB = "UseFeignDeathOnThingFromBeyond",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(5384) .. "\nThing From Beyond", 
                        ruRU = A.GetSpellInfo(5384) .. "\nThing From Beyond", 
                        frFR = A.GetSpellInfo(5384) .. "\nThing From Beyond", 
                    }, 
                    TT = { 
                        enUS = "Completly avoid the Thing from Beyond that spawn with more than 40+ corruption.", 
                        ruRU = "Completly avoid the Thing from Beyond that spawn with more than 40+ corruption.", 
                        frFR = "Completly avoid the Thing from Beyond that spawn with more than 40+ corruption.", 
                    }, 
                    M = {},
                },		
                {
                    E = "Checkbox", 
                    DB = "UseLoneWolf",
                    DBV = true,
                    L = { 
                        enUS = "Use Lone Wolf", 
                        ruRU = "Use Lone Wolf", 
                        frFR = "Use Lone Wolf", 
                    }, 
                    TT = { 
                        enUS = "Enable this if you want to use Lone Wolf and not be notified to summon a pet.", 
                        ruRU = "Enable this if you want to use Lone Wolf and not be notified to summon a pet.", 
                        frFR = "Enable this if you want to use Lone Wolf and not be notified to summon a pet.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "EnableMovementRotation",
                    DBV = true,
                    L = { 
                        enUS = "Enable Movement Rotation", 
                        ruRU = "Enable Movement Rotation", 
                        frFR = "Enable Movement Rotation",
                    }, 
                    TT = { 
                        enUS = "Enable this to show a special rotation while Moving. The optimal standing ability will be shown as a suggestion.", 
                        ruRU = "Enable this to show a special rotation while Moving. The optimal standing ability will be shown as a suggestion.", 
                        frFR = "Enable this to show a special rotation while Moving. The optimal standing ability will be shown as a suggestion.",
                    }, 
                    M = {},
                },                 
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "TrinketsAoE",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nAoE only", 
                        ruRU = "Trinkets\nAoE only",  
                        frFR = "Trinkets\nAoE only",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets for AoE usage ONLY.", 
                        ruRU = "Enable this to option to trinkets for AoE usage ONLY.", 
                        frFR = "Enable this to option to trinkets for AoE usage ONLY.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 30,                            
                    DB = "TrinketsMinTTD",
                    DBV = 10, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min TTD",
                    },
                    TT = { 
                        enUS = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        ruRU = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        frFR = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                    },					
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "TrinketsMinUnits",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min Units",
                    },
                    TT = { 
                        enUS = "Minimum number of units in range to activate Trinkets.", 
                        ruRU = "Minimum number of units in range to activate Trinkets.", 
                        frFR = "Minimum number of units in range to activate Trinkets.",  
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "TrinketsUnitsRange",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate trinkets.", 
                        ruRU = "Maximum range for units detection to automatically activate trinkets.", 
                        frFR = "Maximum range for units detection to automatically activate trinkets.",  
                    },					
                    M = {},
                },
			},
            { -- [7]  Azerite Beam settings
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(295258) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 				
		
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 50,                            
                    DB = "FocusedAzeriteBeamTTD",
                    DBV = 10, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(295258) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(295258) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(295258) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "FocusedAzeriteBeamUnits",
                    DBV = 3, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(295258) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(295258) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(295258) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                }, 				
            },
            { -- [7] UnbridledFuryAuto
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(300714) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryAuto",
                    DBV = false,
                    L = { 
                        enUS = "Burst Potion", 
                        ruRU = "Burst Potion",
                        frFR = "Burst Potion",
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots depending of the settings of this section", 
                        ruRU = "If activated, will auto re pots depending of the settings of this section", 
                        frFR = "If activated, will auto re pots depending of the settings of this section", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithExecute",
                    DBV = false,
                    L = { 
                        enUS = "Sync execute phase", 
                        ruRU = "Sync execute phase",
                        frFR = "Sync execute phase",   
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        ruRU = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        frFR = "If activated, will auto re pots as soon as Execute phase is detected.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 60,      					
                    DB = "UnbridledFuryTTD",
                    DBV = 40, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(300714) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(300714) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(300714) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(300714) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },				
            },	
           
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dummy DPS Test -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "DummyTime",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DPS Testing Time",
                    },
                    TT = { 
                        enUS = "Set the desired time for test in minutes.\nWill show a notification icon when time is expired.\nMin: 1 / Max: 10.", 
                        ruRU = "Установите желаемое время для теста в минутах.\nПо истечении времени будет отображаться значок уведомления.\nMin: 1 / Max: 10.",  
                        frFR = "Définissez la durée souhaitée pour le test en minutes.\nAffiche une icône de notification lorsque le temps est écoulé.\nMin: 1 / Max: 10.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "DummyStopDelay",
                    DBV = 10, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Stop Delay",
                    },
                    TT = { 
                        enUS = "After the dummy test is concluded, how much time should we stop the rotation. (In seconds)\nThis value is mainly used as a protection when you are out of combat to avoid auto attack.\nDefault value : 10 seconds.", 
                        ruRU = "После того, как фиктивный тест закончен, сколько времени мы должны остановить вращение. (В секундах)\nЭто значение в основном используется в качестве защиты, когда вы находитесь вне боя, чтобы избежать автоматической атаки.\nЗначение по умолчанию: 10 секунд.", 
                        frFR = "Une fois le test fictif terminé, combien de temps devons-nous arrêter la rotation. (En secondes)\nCette valeur est principalement utilisée comme protection lorsque vous êtes hors de combat pour éviter l'attaque automatique.\nValeur par défaut: 10 secondes.", 
                    }, 					
                    M = {},
                },
			},
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Self Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ExhilarationHP",
                    DBV = 100, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(109304) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "SpiritMendHP",
                    DBV = 100, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(90361) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Turtle",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(186265) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Pet Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "MendPet",
                    DBV = 100, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(136) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ExhilarationHP",
                    DBV = 90, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(109304) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Turtle",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(186265) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7] UnbridledFuryAuto
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(300714) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryAuto",
                    DBV = false,
                    L = { 
                        enUS = "Burst Potion", 
                        ruRU = "Burst Potion",
                        frFR = "Burst Potion",
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots depending of the settings of this section", 
                        ruRU = "If activated, will auto re pots depending of the settings of this section", 
                        frFR = "If activated, will auto re pots depending of the settings of this section", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithExecute",
                    DBV = false,
                    L = { 
                        enUS = "Sync execute phase", 
                        ruRU = "Sync execute phase",
                        frFR = "Sync execute phase",   
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        ruRU = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        frFR = "If activated, will auto re pots as soon as Execute phase is detected.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 60,      					
                    DB = "UnbridledFuryTTD",
                    DBV = 40, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(300714) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(300714) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(300714) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(300714) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Interrupts Settings -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "MinInterrupt",
                    DBV = 25, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min interrupt %",
                    },
                    TT = { 
                        enUS = "Set the minimum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                        ruRU = "Set the minimum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                        frFR = "Set the minimum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.",  
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "MaxInterrupt",
                    DBV = 70, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max interrupt %",
                    },
                    TT = { 
                        enUS = "Set the maximum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.",  
                        ruRU = "Set the maximum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                        frFR = "Set the maximum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                    }, 					
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dummy DPS Test -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "DummyTime",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DPS Testing Time",
                    },
                    TT = { 
                        enUS = "Set the desired time for test in minutes.\nWill show a notification icon when time is expired.\nMin: 1 / Max: 10.", 
                        ruRU = "Установите желаемое время для теста в минутах.\nПо истечении времени будет отображаться значок уведомления.\nMin: 1 / Max: 10.",  
                        frFR = "Définissez la durée souhaitée pour le test en minutes.\nAffiche une icône de notification lorsque le temps est écoulé.\nMin: 1 / Max: 10.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "DummyStopDelay",
                    DBV = 10, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Stop Delay",
                    },
                    TT = { 
                        enUS = "After the dummy test is concluded, how much time should we stop the rotation. (In seconds)\nThis value is mainly used as a protection when you are out of combat to avoid auto attack.\nDefault value : 10 seconds.", 
                        ruRU = "После того, как фиктивный тест закончен, сколько времени мы должны остановить вращение. (В секундах)\nЭто значение в основном используется в качестве защиты, когда вы находитесь вне боя, чтобы избежать автоматической атаки.\nЗначение по умолчанию: 10 секунд.", 
                        frFR = "Une fois le test fictif terminé, combien de temps devons-nous arrêter la rotation. (En secondes)\nCette valeur est principalement utilisée comme protection lorsque vous êtes hors de combat pour éviter l'attaque automatique.\nValeur par défaut: 10 secondes.", 
                    }, 					
                    M = {},
                },
			},
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "FreezingTrapPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(187650),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "FreezingTrapPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(187650) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
    },
    -- MSG Actions UI
    [7] = {
        [ACTION_CONST_HUNTER_BEASTMASTERY] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
        [ACTION_CONST_HUNTER_MARKSMANSHIP] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
        [ACTION_CONST_HUNTER_SURVIVAL] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------
 

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].Counterspell and A[A.PlayerSpec].Counterspell:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Counterspell:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "PolymorphPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Polymorph and A[A.PlayerSpec].Polymorph:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Polymorph:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 


