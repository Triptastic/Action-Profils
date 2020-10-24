-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
--local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_HUNTER_MARKSMANSHIP] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
	BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    -- Generics
    HuntersMarkDebuff                      = Action.Create({ Type = "Spell", ID = 257284 , Hidden = true     }),
    HuntersMark                            = Action.Create({ Type = "Spell", ID = 257284 }),
    DoubleTap                              = Action.Create({ Type = "Spell", ID = 260402 }),
    TrueshotBuff                           = Action.Create({ Type = "Spell", ID = 288613 , Hidden = true     }),
    Trueshot                               = Action.Create({ Type = "Spell", ID = 288613 }),
    AimedShot                              = Action.Create({ Type = "Spell", ID = 19434 }),
    RapidFire                              = Action.Create({ Type = "Spell", ID = 257044 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({ Type = "Spell", ID = 26297 , Hidden = true     }),
    CarefulAim                             = Action.Create({ Type = "Spell", ID = 260228 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Action.Create({ Type = "Spell", ID = 20572 , Hidden = true     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    PreciseShotsBuff                       = Action.Create({ Type = "Spell", ID = 260242 , Hidden = true     }),
    ExplosiveShot                          = Action.Create({ Type = "Spell", ID = 212431 }),
    Barrage                                = Action.Create({ Type = "Spell", ID = 120360 }),
    AMurderofCrows                         = Action.Create({ Type = "Spell", ID = 131894 }),
    SerpentSting                           = Action.Create({ Type = "Spell", ID = 271788 }),
    SerpentStingDebuff                     = Action.Create({ Type = "Spell", ID = 271788 , Hidden = true     }),
    UnerringVisionBuff                     = Action.Create({ Type = "Spell", ID = 274447 , Hidden = true     }),
    UnerringVision                         = Action.Create({ Type = "Spell", ID = 274444 }),
    ArcaneShot                             = Action.Create({ Type = "Spell", ID = 185358 }),
    MasterMarksmanBuff                     = Action.Create({ Type = "Spell", ID = 269576 , Hidden = true     }),
    DoubleTapBuff                          = Action.Create({ Type = "Spell", ID = 260402 , Hidden = true     }),
    PiercingShot                           = Action.Create({ Type = "Spell", ID = 198670 }),
    FocusedFire                            = Action.Create({ Type = "Spell", ID = 278531 }),
    SteadyShot                             = Action.Create({ Type = "Spell", ID = 56641 }),
    TrickShotsBuff                         = Action.Create({ Type = "Spell", ID = 257622 , Hidden = true     }),
    IntheRhythm                            = Action.Create({ Type = "Spell", ID = 264198 }),
    SurgingShots                           = Action.Create({ Type = "Spell", ID = 287707 }),
    Streamline                             = Action.Create({ Type = "Spell", ID = 260367 }),
    Multishot                              = Action.Create({ Type = "Spell", ID = 257620 }),
    CallingtheShots                        = Action.Create({ Type = "Spell", ID = 260404 }),
	FeignDeath                             = Action.Create({ Type = "Spell", ID = 5384 }),
    -- Pet
    CallPet                                = Action.Create({ Type = "Spell", ID = 883, Texture = 136 }),
    MendPet                                = Action.Create({ Type = "Spell", ID = 136, Texture = 136  }),
    RevivePet                              = Action.Create({ Type = "Spell", ID = 982, Texture = 136 }),
    SpiritShock                            = Action.Create({ Type = "SpellSingleColor", ID = 264265, Color = "BLUE" }), -- Pet dispell/purge
    SonicBlast                             = Action.Create({ Type = "SpellSingleColor", ID = 264263, Color = "YELLOW" }), -- Pet dispell/purge
    CounterShot                            = Action.Create({ Type = "Spell", ID = 147362 }),
    Exhilaration                           = Action.Create({ Type = "Spell", ID = 109304 }),
	SpiritMend                             = Action.Create({ Type = "SpellSingleColor", ID = 90361, Color = "YELLOW"}), 
	BindingShot                            = Action.Create({ Type = "Spell", ID = 109248  }), 
	Smack                                  = Action.Create({ Type = "Spell", ID = 49966  }), 
	Claw                                   = Action.Create({ Type = "Spell", ID = 16827  }), 
	Bite                                   = Action.Create({ Type = "Spell", ID = 17253  }), 
    SurvivaloftheFittest                   = Action.Create({ Type = "SpellSingleColor", ID = 264735, Color = "PINK"  }),
    PrimalRage                             = Action.Create({ Type = "SpellSingleColor", ID = 264667, Color = "PINK"  }),
    MastersCall                            = Action.Create({ Type = "SpellSingleColor", ID = 53271, Color = "PINK"  }),	
	Intimidation                           = Action.Create({ Type = "Spell", ID = 19577  }),
	-- Utilities
    CounterShot                            = Action.Create({ Type = "Spell", ID = 147362 }),
	BindingShot                            = Action.Create({ Type = "Spell", ID = 109248  }),
	AspectoftheTurtle                      = Action.Create({ Type = "Spell", ID = 274441 }),
	ConcussiveShot                         = Action.Create({ Type = "Spell", ID = 5116 }),
	-- Pet Spells
	Exhilaration                           = Action.Create({ Type = "Spell", ID = 109304 }),
	SpiritMend                             = Action.Create({ Type = "SpellSingleColor", ID = 90361, Color = "YELLOW"}),
	SpiritShock                            = Action.Create({ Type = "SpellSingleColor", ID = 264265, Color = "BLUE" }), -- Pet dispell/purge
	SonicBlast                             = Action.Create({ Type = "SpellSingleColor", ID = 264263, Color = "YELLOW" }), -- Pet dispell/purge
	-- General Hunter Legendaries
	CalloftheWild                          = Action.Create({ Type = "Spell", ID = 336742  }),
    NessingwarysTrappingApparatus          = Action.Create({ Type = "Spell", ID = 336743  }),
    SoulforgeEmbers                        = Action.Create({ Type = "Spell", ID = 336745  }),
    CravenStrategem                        = Action.Create({ Type = "Spell", ID = 336747  }),
	-- Marksmanship Hunter Legendaries  
	EagletalonsTrueFocus                   = Action.Create({ Type = "Spell", ID = 336849  }),
    SurgingShots                           = Action.Create({ Type = "Spell", ID = 336867  }),
    SerpentstalkersTrickery                = Action.Create({ Type = "Spell", ID = 336870  }),
    SecretsoftheUnblinkingVigil            = Action.Create({ Type = "Spell", ID = 336878  }),
	-- Oils
	EmbalmersOil                           = Action.Create({ Type = "Spell", ID = 171286, QueueForbidden = true }), 
    ShadowcoreOil                          = Action.Create({ Type = "Spell", ID = 171285, QueueForbidden = true }),  
    -- Potions
	-- stats
    PotionofSpectralAgility                = Action.Create({ Type = "Potion", ID = 171270, QueueForbidden = true }), 
    PotionofSpectralIntellect              = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }), 
	PotionofSpectralStrength               = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }), 
	PotionofSpectralStamina                = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }), 
	-- heal
	SpiritualHealingPotion                 = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }), 
	SpiritualManaPotion                    = Action.Create({ Type = "Potion", ID = 171268, QueueForbidden = true }), 
	SpiritualRejuvenationPotion            = Action.Create({ Type = "Potion", ID = 171269, QueueForbidden = true }), 
	PotionofSpiritualClarity               = Action.Create({ Type = "Potion", ID = 171272, QueueForbidden = true }), 
	-- combat effects potions
	PotionofDeathlyFixation                = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }), 
    PotionofEmpoweredExorcisms             = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
	PotionofPhantomFire                    = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
	PotionofDivineAwakening                = Action.Create({ Type = "Potion", ID = 171350, QueueForbidden = true }),
	PotionofSacrificialAnima               = Action.Create({ Type = "Potion", ID = 176811, QueueForbidden = true }),
    -- utilities potions
	PotionofHardenedShadows                = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofShadedSight                    = Action.Create({ Type = "Potion", ID = 171264, QueueForbidden = true }),
    PotionofSoulPurity                     = Action.Create({ Type = "Potion", ID = 171263, QueueForbidden = true }),
    PotionofSpecterSwiftness               = Action.Create({ Type = "Potion", ID = 171370, QueueForbidden = true }),
    PotionoftheHiddenSpirit                = Action.Create({ Type = "Potion", ID = 171266, QueueForbidden = true }),
    PotionofthePsychopompsSpeed            = Action.Create({ Type = "Potion", ID = 184090, QueueForbidden = true }),
    PotionofUnhinderedPassing              = Action.Create({ Type = "Potion", ID = 183823, QueueForbidden = true }),
    -- Nathria Trinkets
	SanguineVintage                        = Action.Create({ Type = "Trinket", ID = 184031 }),
	ManaboundMirror                        = Action.Create({ Type = "Trinket", ID = 184029 }),
	GluttonousSpike                        = Action.Create({ Type = "Trinket", ID = 184023 }),
	DreadfireVessel                        = Action.Create({ Type = "Trinket", ID = 184030 }),
	MemoryofPastSins                       = Action.Create({ Type = "Trinket", ID = 184025 }),
	ConsumptiveInfusion                    = Action.Create({ Type = "Trinket", ID = 184022 }),
	StoneLegionHeraldry                    = Action.Create({ Type = "Trinket", ID = 184027 }),
	BargastsLeash                          = Action.Create({ Type = "Trinket", ID = 184017 }),
	-- OP Dungeons Trinkets
	BloodSpatteredScale                    = Action.Create({ Type = "Trinket", ID = 179331 }),
	OverwhelmingPowerCrystal               = Action.Create({ Type = "Trinket", ID = 179342 }),
	SunbloodAmethyst                       = Action.Create({ Type = "Trinket", ID = 178826 }),
	PulsatingStoneheart                    = Action.Create({ Type = "Trinket", ID = 178825 }),
	BladedancersArmorKit                   = Action.Create({ Type = "Trinket", ID = 178862 }), 
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
};

-- To create essences use next code:
--Action:CreateEssencesFor(ACTION_CONST_HUNTER_MARKSMANSHIP)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_MARKSMANSHIP], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local pet = "pet"

local VarCAExecute = false;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarCAExecute = false
end)

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

-- API - Spell
Pet:AddActionsSpells(254, {

	-- number accepted
	17253, -- Bite
	16827, -- Claw
	49966, -- Smack 
}, true)

local GameLocale = GetLocale()    
local PetLocalization = {
    [GameLocale] = {},
    ruRU = {
	    SPIRITBEAST = "Дух зверя",
		TENACITY = "Упорство",
		FEROCITY = "Свирепость",
		CUNNING = "Хитрость",
	},
    enGB = {
    	SPIRITBEAST = "Spirit Beast",
		TENACITY = "Tenacity",
		FEROCITY = "Ferocity",
		CUNNING = "Cunning",
	},
    enUS = {
    	SPIRITBEAST = "Spirit Beast",
		TENACITY = "Tenacity",
		FEROCITY = "Ferocity",
		CUNNING = "Cunning",
	},
    deDE = {
	    SPIRITBEAST = "Geisterbestie",
		TENACITY = "Hartnäckigkeit",
		FEROCITY = "Wildheit",
		CUNNING = "Gerissenheit",
	},
    esES = {
    	SPIRITBEAST = "Bestia espíritu",
		TENACITY = "Tenacidad",
		FEROCITY = "Ferocidad",
		CUNNING = "Astucia",
	},
    esMX = {
	    SPIRITBEAST = "Bestia espíritu",
		TENACITY = "Tenacidad",
		FEROCITY = "Ferocidad",
		CUNNING = "Astucia",
	},
    frFR = {
	    SPIRITBEAST = "Esprit de bête",
		TENACITY = "Tenacité",
		FEROCITY = "Férocité",
		CUNNING = "Ruse",
	},
    itIT = {
	    SPIRITBEAST = "Bestia Eterea",
		TENACITY = "Tenacia",
		FEROCITY = "Ferocia",
		CUNNING = "Scaltrezza",
	},
    ptBR = {
    	SPIRITBEAST = "Fera Espiritual",
		TENACITY = "Tenacidade",
		FEROCITY = "Ferocidade",
		CUNNING = "Astúcia",
	},
    koKR = {
    	SPIRITBEAST = "야수 정령",
		TENACITY = "끈기",
		FEROCITY = "야성",
		CUNNING = "교활",
	},
    zhCN = {
	    SPIRITBEAST = "灵魂兽",
		TENACITY = "坚韧",
		FEROCITY = "狂野",
		CUNNING = "狡诈",
	},
    zhTW = {
	    SPIRITBEAST = "靈獸",
		TENACITY = "",
		FEROCITY = "",
		CUNNING = "",
	},
}
local LP = setmetatable(PetLocalization[GameLocale], { __index = PetLocalization.enUS })

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
	
    -- Exhilaration
    local Exhilaration = GetToggle(2, "ExhilarationHP")
    if     Exhilaration >= 0 and A.Exhilaration:IsReady(player) and 
    (
        (     -- Auto 
            Exhilaration >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Exhilaration < 100 and 
            Unit(player):HealthPercent() <= Exhilaration
        )
    ) 
    then 
	    -- Notification					
        Action.SendNotification("[DEF] Exhilaration", A.Exhilaration.ID)
        return A.Exhilaration
    end

    -- SpiritMend
	local CurrentCreatureFamily = UnitCreatureFamily(pet)
    local SpiritMend = GetToggle(2, "SpiritMendHP")
	--Pet:GetMainPet()
    if     SpiritMend >= 0 and A.SpiritMend:IsReady() and CurrentCreatureFamily == "Esprit de bête" and --and not A.AnimalCompanion:IsSpellLearned()
    (
        (     -- Auto 
            SpiritMend >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(15) < 3 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            SpiritMend < 100 and 
            Unit(player):HealthPercent() <= SpiritMend
        )
    ) 
    then 
		    -- Notification					
        Action.SendNotification("[DEF] Spirit Mend", A.SpiritMend.ID)
        return A.SpiritMend
    end	
	
    -- AspectoftheTurtle
    local AspectoftheTurtle = GetToggle(2, "Turtle")
    if     AspectoftheTurtle >= 0 and A.AspectoftheTurtle:IsReady(player) and 
    (
        (     -- Auto 
            AspectoftheTurtle >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AspectoftheTurtle < 100 and 
            Unit(player):HealthPercent() <= AspectoftheTurtle
        )
    ) 
    then
		    -- Notification					
        Action.SendNotification("[DEF] Aspect of the Turtle", A.AspectoftheTurtle.ID)	
        return A.AspectoftheTurtle
    end     
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.CounterShot:IsReadyByPassCastGCD(unit) or not A.CounterShot:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
	    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
	
	if castRemainsTime >= A.GetLatency() then
        -- CounterShot
        if useKick and not notInterruptable and A.CounterShot:IsReady(unit) then 
            return A.CounterShot
        end

        -- ConcussiveShot
        if useCC and A.ConcussiveShot:IsReady(unit) then 
            return A.ConcussiveShot
   	    end  
	
        -- BindingShot
        if useCC and A.BindingShot:IsReady(unit) and Unit(unit):IsControlAble("stun", 0) then 
            return A.BindingShot
   	    end  
		    
   	    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
   	        return A.QuakingPalm
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial(unit) then 
            return A.Haymaker
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial(unit) then 
            return A.WarStomp
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial(unit) then 
            return A.BullRush
   	    end 
    end
end


-- Offensive dispel rotation
local function PurgeDispellMagic(unit)
	local CurrentCreatureFamily = UnitCreatureFamily("pet") 
	
	-- SpiritShock
	if A.SpiritShock:IsReady(unit) and CurrentCreatureFamily == "Spirit Beast" and not ShouldStop and (Action.AuraIsValid(unit, "UseExpelEnrage", "Enrage") or Action.AuraIsValid(unit, "UseDispel", "Magic")) then
		return A.SpiritShock:Show(icon)
    end
			
    -- SonicBlast
    if A.SonicBlast:IsReady(unit) and CurrentCreatureFamily == "Bat" and not ShouldStop and (Action.AuraIsValid(unit, "UseExpelEnrage", "Enrage") or Action.AuraIsValid(unit, "UseDispel", "Magic")) then
        return A.SonicBlast:Show(icon)
    end		
end
PurgeDispellMagic = A.MakeFunctionCachedDynamic(PurgeDispellMagic)

local function InRange(unit)
	-- @return boolean 
	return A.Trueshot:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	
	if isStrictlySuperior == nil then
	    isStrictlySuperior = false
	end

	if isStrictlyInferior == nil then
	    isStrictlyInferior = false
	end	
	
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
			if InRange(unit) then 
				c = c + 1
			elseif range then 
				local r = Unit(unit):GetRange()
				if r > 0 and r <= range then 
					c = c + 1
				end 
			end 
			-- Strictly superior than >
			if isStrictlySuperior and not isStrictlyInferior then
			    if c > count then
				    return true
				end
			end
			
			-- Stryctly inferior <
			if isStrictlyInferior and not isStrictlySuperior then
			    if c < count then
			        return true
				end
			end
			
			-- Classic >=
			if not isStrictlyInferior and not isStrictlySuperior then
			    if c >= count then 
				    return true 
			    end 
			end
		end 
		
	end
	
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
	local profileStop = false
	local MendPet = Action.GetToggle(2, "MendPet")
	local DBM = Action.GetToggle(1, "BossMods")
	local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
	local Racial = Action.GetToggle(1, "Racial")
	local Potion = Action.GetToggle(1, "Potion")
	local UnbridledFuryAuto = GetToggle(2, "UnbridledFuryAuto")
	local UnbridledFuryTTD = GetToggle(2, "UnbridledFuryTTD")
	local UnbridledFuryWithBloodlust = GetToggle(2, "UnbridledFuryWithBloodlust")
	local UnbridledFuryHP = GetToggle(2, "UnbridledFuryHP")
	local UnbridledFuryWithExecute = GetToggle(2, "UnbridledFuryWithExecute")
	local FocusedAzeriteBeamTTD = GetToggle(2, "FocusedAzeriteBeamTTD")
	local FocusedAzeriteBeamUnits = GetToggle(2, "FocusedAzeriteBeamUnits")
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
	local UseFeignDeathOnThingFromBeyond = GetToggle(2, "UseFeignDeathOnThingFromBeyond")
	local AoEMode = A.GetToggle(2, "AoEMode")
	-- Azerite beam protection channel
	local CanCast = true
	local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
	local _, castStartedTime, castEndTime = Unit(player):IsCasting()
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
	-- Ensure all channel and cast are really safe
	-- Double protection with check on current casts and also timestamp of the cast
	if (spellID == A.FocusedAzeriteBeam.ID) then 
	    if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
		    if TMW.time < castEndTime then			
			    CanCast = false
	        else
	            CanCast = true
			end
		end
	end
	-- FeignDeath protection 
   	if Unit(player):HasBuffs(A.FeignDeath.ID, true) >= 358 then
            CanCast = false	
	else	
   	    if Unit(player):HasBuffs(A.FeignDeath.ID, true) < 358 then
            CanCast = true	
		end
	end	
	-- Showing icon PoolResource to make sure nothing else is read by GG
	if not CanCast then
	    return A.PoolResource:Show(icon)
	end
	
	------------------------------------
	---------- DUMMY DPS TEST ----------
	------------------------------------
	local DummyTime = GetToggle(2, "DummyTime")
	if DummyTime > 0 then
    	local unit = "target"
		local endtimer = 0
		
    	if Unit(unit):IsExists() and Unit(unit):IsDummy() then
        	if Unit(player):CombatTime() >= (DummyTime * 60) then
            	StopAttack()
				endtimer = TMW.time
            	--ClearTarget() -- Protected ? 
	       	    -- Notification					
          	    Action.SendNotification(DummyTime .. " Minutes Dummy Test Concluded - Profile Stopped", A.DummyTest.ID)			
         	    
				if endtimer < TMW.time + 5 then
				    profileStop = true
				    --return A.DummyTest:Show(icon)
				end
    	    end
  	    end
	end	
		
	-- Feign Death Thing from Beyond
	if Unit(player):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 and A.FeignDeath:IsReady(player) then
	    return A.FeignDeath:Show(icon)
	end
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
	
		VarCAExecute = (Unit(unit):HealthPercent() < 20 or Unit(unit):HealthPercent() > 80)
		
		-- Interrupt Handler
 	 	
  		local unit = "target"
   		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
        local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		    
		-- Interrupt
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end  

		
		-- Freezing Trap Thing from Beyond
		if Unit(player):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 and not A.LastPlayerCastName == A.FeignDeath:Info() and unit == "mouseover" and A.FreezingTrap:IsReady(player) then
		    return A.FreezingTrap:Show(icon)
		end
		
        -- mendpet
        if A.MendPet:IsReady(player) and Pet:IsActive() and Unit(pet):HealthPercent() > 0 and
        (
 			-- AUTO
			(
			    MendPet >= 100 and
			    (
		             -- HP lose per sec >= 30
                    Unit(pet):GetDMG() * 100 / Unit(pet):HealthMax() >= 30 or 
                    Unit(pet):GetRealTimeDMG() >= Unit(pet):HealthMax() * 0.30 or 
                    -- TTD 
                    Unit(pet):TimeToDieX(15) < 2  
				)				
			) 
			or  
			-- MANUAL
		    (
			    MendPet < 100 and
				Unit(pet):HealthPercent() <= MendPet and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0
			)
             
		)
		then
		    return A.MendPet:Show(icon)
        end
			
	    -- summon_pet if not active
        if not Pet:IsActive() and A.MendPet:IsReady(player) and not A.LastPlayerCastName == A.MendPet:Info() then
		    return A.MendPet:Show(icon)
        end
		
		--Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
			
            -- hunters_mark
            if A.HuntersMark:IsReady(unit) and Unit(unit):HasDeBuffs(A.HuntersMarkDebuff.ID, true) == 0 and
			((Pull > 0.1 and Pull < 10) or not DBM)
			then
                return A.HuntersMark:Show(icon)
            end
			
            -- double_tap,precast_time=10
            if A.DoubleTap:IsReady("player") and
			((Pull > 0.1 and Pull < 9) or not DBM)
			then
                return A.DoubleTap:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) and
			((Pull > 0.1 and Pull < 8) or not DBM)
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and
			((Pull > 0.1 and Pull < 4) or not DBM)
			then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and
			((Pull > 0.1 and Pull < 4) or not DBM)
			then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and
			((Pull > 0.1 and Pull < 4) or not DBM)
			then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- potion,dynamic_prepot=1
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and
			((Pull > 0.1 and Pull < 3) or not DBM)
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- trueshot,precast_time=1.5,if=active_enemies>2
            if A.Trueshot:IsReadyByPassCastGCD(unit) and Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 and GetByRange(2, 40, true, false) and 
			((Pull > 0.1 and Pull < 1.5) or not DBM)
			then
                return A.Trueshot:Show(icon)
            end
			
            -- aimed_shot,if=active_enemies<3
            if A.AimedShot:IsReady(unit) and GetByRange(3, 40, false, true) and
			((Pull > 0.1 and Pull < 1) or not DBM)
			then
                return A.AimedShot:Show(icon)
            end
			
        end
        
		-- Burst Phase
		if BurstIsON(unit) and unit ~= "mouseover" and inCombat and not profileStop and CanCast  then
            
			-- double_tap,if=cooldown.rapid_fire.remains<gcd|cooldown.rapid_fire.remains<cooldown.aimed_shot.remains|target.time_to_die<20
            if A.DoubleTap:IsReady("player") and (A.RapidFire:GetCooldown() < A.GetGCD() or A.RapidFire:GetCooldown() < A.AimedShot:GetCooldown() or Unit(unit):TimeToDie() < 20) then
                return A.DoubleTap:Show(icon)
            end
			
			-- auto_shot
            -- use_item,name=lurkers_insidious_gift,if=A.Trueshot:GetCooldown()<15|target.time_to_die<30
            if A.LurkersInsidiousGift:IsReady(unit) and (A.Trueshot:GetCooldown() < 15 or Unit(unit):TimeToDie() < 30) then
                return A.LurkersInsidiousGift:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=(target.time_to_die>cooldown+34|target.health.pct<20|Unit(unit):TimeToDieX(20)<15)&A.Trueshot:GetCooldown()<15|target.time_to_die<35
            if A.AzsharasFontofPower:IsReady(player) and ((Unit(unit):TimeToDie() > A.AzsharasFontofPower:GetCooldown() + 34 or Unit(unit):HealthPercent() < 20 or Unit(unit):TimeToDieX(20) < 15) and A.Trueshot:GetCooldown() < 15 or Unit(unit):TimeToDie() < 35) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=lustrous_golden_plumage,if=A.Trueshot:GetCooldown()<5|target.time_to_die<20
            if A.LustrousGoldenPlumage:IsReady(unit) and (A.Trueshot:GetCooldown() < 5 or Unit(unit):TimeToDie() < 20) then
                return A.LustrousGoldenPlumage:Show(icon)
            end
			
            -- use_item,name=galecallers_boon,if=buff.trueshot.up|!talent.calling_the_shots.enabled|target.time_to_die<10
            if A.GalecallersBoon:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 or not A.CallingtheShots:IsSpellLearned() or Unit(unit):TimeToDie() < 10) then
                return A.GalecallersBoon:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=buff.trueshot.up&(buff.guardian_of_azeroth.up|!essence.condensed_lifeforce.major&target.health.pct<20)|debuff.razor_coral_debuff.down|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) > 0 or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit(unit):HealthPercent() < 20) or Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 or Unit(unit):TimeToDie() < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=pocketsized_computation_device,if=!buff.trueshot.up&!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up|target.time_to_die<5
            if A.PocketsizedComputationDevice:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or Unit(unit):HasDeBuffs(A.BloodoftheEnemy.ID, true) > 0 or Unit(unit):TimeToDie() < 5) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
			
            -- hunters_mark,if=debuff.hunters_mark.down&!buff.trueshot.up
            if A.HuntersMark:IsReady(unit) and (Unit(unit):HasDeBuffs(A.HuntersMarkDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0) then
                return A.HuntersMark:Show(icon)
            end
						
            -- berserking,if=buff.trueshot.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<13
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and (Unit(unit):TimeToDie() > 180 + A.Berserking:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
			
            -- blood_fury,if=buff.trueshot.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and (Unit(unit):TimeToDie() > 120 + A.BloodFury:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.BloodFury:Show(icon)
            end
			
            -- ancestral_call,if=buff.trueshot.up&(target.time_to_die>cooldown.ancestral_call.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and (Unit(unit):TimeToDie() > 120 + A.AncestralCall:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.AncestralCall:Show(icon)
            end
			
            -- fireblood,if=buff.trueshot.up&(target.time_to_die>cooldown.fireblood.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<9
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and (Unit(unit):TimeToDie() > 120 + A.Fireblood:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 9) then
                return A.Fireblood:Show(icon)
            end
			
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) then
                return A.BagofTricks:Show(icon)
            end
			
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|Unit(unit):TimeToDieX(20)>30
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or Unit(unit):TimeToDieX(20) > 30) then
                return A.ReapingFlames:Show(icon)
            end
			
            -- worldvein_resonance,if=(A.AzsharasFontofPower:GetCooldown()>20|!equipped.azsharas_font_of_power|target.time_to_die<trinket.azsharas_font_of_power.cooldown.duration+34&target.health.pct>20)&(A.Trueshot:GetCooldown()<3|(essence.vision_of_perfection.minor&target.time_to_die>cooldown+buff.worldvein_resonance.duration))|target.time_to_die<20
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((A.AzsharasFontofPower:GetCooldown() > 20 or not A.AzsharasFontofPower:IsExists() or Unit(unit):TimeToDie() < 120 + 34 and Unit(unit):HealthPercent() > 20) and (A.Trueshot:GetCooldown() < 3 or (Azerite:EssenceHasMinor(A.VisionofPerfection.ID) and Unit(unit):TimeToDie() > A.WorldveinResonance:GetCooldown() + 18)) or Unit(unit):TimeToDie() < 20) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- guardian_of_azeroth,if=(ca_execute|target.time_to_die>cooldown+30)&(buff.trueshot.up|cooldown.trueshot.remains<16)|target.time_to_die<31
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((VarCAExecute or Unit(unit):TimeToDie() > 180 + 30) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 or A.Trueshot:GetCooldown() < 16) or Unit(unit):TimeToDie() < 31) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- ripple_in_space,if=cooldown.trueshot.remains<7
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Trueshot:GetCooldown() < 7) then
                return A.RippleinSpace:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=!buff.trueshot.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
           -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and UnbridledFuryAuto
			and 
			(
				(UnbridledFuryWithBloodlust and Unit(player):HasHeroism())
				or
				(UnbridledFuryWithExecute and Unit(unit):HealthPercent() <= 30)
			)
			and Unit(unit):TimeToDie() > UnbridledFuryTTD
			then
 	            -- Notification					
                Action.SendNotification("Burst: Potion of Unbridled Fury", A.PotionofUnbridledFury.ID)	
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- trueshot,if=focus>60&(buff.precise_shots.down&cooldown.rapid_fire.remains&target.time_to_die>A.Trueshot:GetCooldown()+buff.trueshot.duration|(target.health.pct<20|!talent.careful_aim.enabled)&(!equipped.azsharas_font_of_power|A.AzsharasFontofPower:GetCooldown()>15))|target.time_to_die<15
            if A.Trueshot:IsReadyByPassCastGCD(unit) and 
			(
			    Player:Focus() > 60 and 
				(
				    Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) == 0 and A.RapidFire:GetCooldown() > 0 and Unit(unit):TimeToDie() > A.Trueshot:GetCooldown() + A.TrueshotBuff:BaseDuration() 
					or
					(
					    Unit(unit):HealthPercent() < 20 
						or 
						not A.CarefulAim:IsSpellLearned()
					)
					and 
					(
					    not A.AzsharasFontofPower:IsExists() 
						or 
						A.AzsharasFontofPower:GetCooldown() > 15
					)
				)
				or Unit(unit):TimeToDie() < 15
			)
			then
                return A.Trueshot:Show(icon)
            end
			
	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then 
      	        return A.Trinket1:Show(icon)
   	        end 		
	        
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and	    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then
      	       	return A.Trinket2:Show(icon) 	
	        end	
			
        end


		-- SINGLE TARGET
		
        -- call_action_list,name=st,if=active_enemies<3
        if inCombat and not profileStop and
		(
            -- Range by pet
			AoEMode == "RangeByPet" and 
			(
			    Pet:GetMultiUnitsBySpell(17253) < 3 or -- Bite
			    Pet:GetMultiUnitsBySpell(16827) < 3 or -- Claw
			    Pet:GetMultiUnitsBySpell(49966) < 3 -- Smack					
			)
			or 
			-- Range by nameplate
			AoEMode == "RangeByNameplate" and
			(					    
			    GetByRange(3, 40, false, true)
			)
			or
			-- Range by active enemies CLEU
			AoEMode == "RangeByCLEU" and
			(        				
				MultiUnits:GetActiveEnemies() < 3					     
			)
		)
		then
            -- explosive_shot
            if A.ExplosiveShot:IsReady(unit) then
                return A.ExplosiveShot:Show(icon)
            end
			
            -- barrage,if=active_enemies>1
            if A.Barrage:IsReady(unit) and GetByRange(1, 40, true, false) then
                return A.Barrage:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- serpent_sting,if=refreshable&!action.serpent_sting.in_flight
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 and not A.SerpentSting:IsSpellInFlight()) then
                return A.SerpentSting:Show(icon)
            end
			
            -- rapid_fire,if=buff.trueshot.down|focus<70
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 or Player:Focus() < 70) then
                return A.RapidFire:Show(icon)
            end
			
            -- blood_of_the_enemy,if=buff.trueshot.up&(buff.unerring_vision.stack>4|!azerite.unerring_vision.enabled)|target.time_to_die<11
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and (Unit("player"):HasBuffsStacks(A.UnerringVisionBuff.ID, true) > 4 or A.UnerringVision:GetAzeriteRank() == 0) or Unit(unit):TimeToDie() < 11) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- focused_azerite_beam,if=!buff.trueshot.up|target.time_to_die<5
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 or Unit(unit):TimeToDie() < 5) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&!buff.memory_of_lucid_dreams.up
            if A.ArcaneShot:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 
				and 
				Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) > 0 
				and
				Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0
			)
			then
                return A.ArcaneShot:Show(icon)
            end
			
            -- aimed_shot,if=buff.trueshot.up|(buff.double_tap.down|ca_execute)&buff.precise_shots.down|full_recharge_time<cast_time&cooldown.trueshot.remains
            if A.AimedShot:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 
				or 
				(
				    Unit("player"):HasBuffs(A.DoubleTapBuff.ID, true) == 0 
					or 
					VarCAExecute
				)
				and Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) == 0 
				or 
				A.AimedShot:GetSpellChargesFullRechargeTime() < A.AimedShot:GetSpellCastTime() and A.Trueshot:GetCooldown() > 0
			)
			then
                return A.AimedShot:Show(icon)
            end
			
            -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&buff.memory_of_lucid_dreams.up
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0) then
                return A.ArcaneShot:Show(icon)
            end
			
            -- piercing_shot
            if A.PiercingShot:IsReady(unit) then
                return A.PiercingShot:Show(icon)
            end
			
            -- purifying_blast,if=!buff.trueshot.up|target.time_to_die<8
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 or Unit(unit):TimeToDie() < 8) then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.trueshot.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:Focus() + Player:FocusRegen() * A.GetGCD() < Player:FocusMax() and Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD() or Unit(unit):TimeToDie() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForce.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10 or Unit(unit):TimeToDie() < 5) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- arcane_shot,if=buff.trueshot.down&(buff.precise_shots.up&(focus>41|buff.master_marksman.up)|(focus>50&azerite.focused_fire.enabled|focus>75)&(cooldown.trueshot.remains>5|focus>80)|target.time_to_die<5)
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 and (Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) > 0 and (Player:Focus() > 41 or Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) > 0) or (Player:Focus() > 50 and A.FocusedFire:GetAzeriteRank() > 0 or Player:Focus() > 75) and (A.Trueshot:GetCooldown() > 5 or Player:Focus() > 80) or Unit(unit):TimeToDie() < 5)) then
                return A.ArcaneShot:Show(icon)
            end
			
            -- steady_shot
            if A.SteadyShot:IsReady(unit) then
                return A.SteadyShot:Show(icon)
            end
			
        end
 
        --Trickshots
        -- call_action_list,name=trickshots,if=active_enemies>2
        if inCombat and not profileStop and
		(
            -- Range by pet
			AoEMode == "RangeByPet" and 
			(
			    Pet:GetMultiUnitsBySpell(17253) > 2 or -- Bite
			    Pet:GetMultiUnitsBySpell(16827) > 2 or -- Claw
			    Pet:GetMultiUnitsBySpell(49966) > 2 -- Smack					
			)
			or 
			-- Range by nameplate
			AoEMode == "RangeByNameplate" and
			(					    
			    GetByRange(2, 40, true, false)
			)
			or
			-- Range by active enemies CLEU
			AoEMode == "RangeByCLEU" and
			(        				
				MultiUnits:GetActiveEnemies() > 2					     
			)
		)
		then            
			-- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
			
            -- explosive_shot
            if A.ExplosiveShot:IsReady(unit) then
                return A.ExplosiveShot:Show(icon)
            end
			
            -- aimed_shot,if=buff.trick_shots.up&ca_execute&buff.double_tap.up
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) > 0 and VarCAExecute and Unit("player"):HasBuffs(A.DoubleTapBuff.ID, true) > 0) then
                return A.AimedShot:Show(icon)
            end
			
            -- rapid_fire,if=buff.trick_shots.up&(azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled)
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) > 0 and (A.FocusedFire:GetAzeriteRank() > 0 or A.IntheRhythm:GetAzeriteRank() > 1 or A.SurgingShots:GetAzeriteRank() > 0 or A.Streamline:IsSpellLearned())) then
                return A.RapidFire:Show(icon)
            end
			
            -- aimed_shot,if=buff.trick_shots.up&(buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time|buff.trueshot.up)
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) > 0 and (Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) == 0 or A.AimedShot:GetSpellChargesFullRechargeTime() < A.AimedShot:GetSpellCastTime() or Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) > 0)) then
                return A.AimedShot:Show(icon)
            end
			
            -- rapid_fire,if=buff.trick_shots.up
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) > 0) then
                return A.RapidFire:Show(icon)
            end
			
            -- multishot,if=buff.trick_shots.down|buff.precise_shots.up&!buff.trueshot.up|focus>70
            if A.Multishot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) == 0 or Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) == 0 or Player:Focus() > 70) then
                return A.Multishot:Show(icon)
            end
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForce.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- piercing_shot
            if A.PiercingShot:IsReady(unit) then
                return A.PiercingShot:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- serpent_sting,if=refreshable&!action.serpent_sting.in_flight
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 and not A.SerpentSting:IsSpellInFlight()) then
                return A.SerpentSting:Show(icon)
            end
			
            -- steady_shot
            if A.SteadyShot:IsReady(unit) then
                return A.SteadyShot:Show(icon)
            end
			
        end
        
    end

    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
			-- Interrupt
   		    local Interrupt = Interrupts(unit)
  		    if Interrupt then 
  		        return Interrupt:Show(icon)
  		    end	
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
   -- local Party = PartyRotation("party1") 
   -- if Party then 
   --     return Party:Show(icon)
  --  end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
   -- local Party = PartyRotation("party2") 
    --if Party then 
   --     return Party:Show(icon)
   -- end     
    return ArenaRotation(icon, "arena3")
end

