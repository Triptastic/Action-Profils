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
Action[ACTION_CONST_HUNTER_SURVIVAL] = {
    -- Racials
    ArcaneTorrent                         = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                             = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                             = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                         = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                            = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                           = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                           = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                              = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                              = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                              = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                           = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                            = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                             = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                     = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                          = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                    = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
	BagofTricks                           = Action.Create({ Type = "Spell", ID = 312411    }),
    -- Generics Spells    
    SummonPet                             = Action.Create({ Type = "Spell", ID = 883, Texture = 136 }),
    SteelTrap                             = Action.Create({ Type = "Spell", ID = 162488     }),
    Harpoon                               = Action.Create({ Type = "Spell", ID = 190925     }),
    MongooseBiteEagle                     = Action.Create({ Type = "Spell", ID = 265888     }),
    MongooseBite                          = Action.Create({ Type = "Spell", ID = 259387     }),
    RaptorStrikeEagle                     = Action.Create({ Type = "Spell", ID = 265189     }),
    RaptorStrike                          = Action.Create({ Type = "Spell", ID = 186270     }),
    FlankingStrike                        = Action.Create({ Type = "Spell", ID = 269751     }),
    KillCommand                           = Action.Create({ Type = "Spell", ID = 259489     }),
	WingClip                              = Action.Create({ Type = "Spell", ID = 195645     }),
    WildfireBomb                          = Action.Create({ Type = "Spell", ID = 259495, Texture = 269747     }),
    ShrapnelBomb                          = Action.Create({ Type = "Spell", ID = 270335, Texture = 269747     }),
    PheromoneBomb                         = Action.Create({ Type = "Spell", ID = 270323, Texture = 269747     }),
    VolatileBomb                          = Action.Create({ Type = "Spell", ID = 271045, Texture = 269747     }),
    SerpentSting                          = Action.Create({ Type = "Spell", ID = 259491     }),
    AMurderofCrows                        = Action.Create({ Type = "Spell", ID = 131894     }),
    CoordinatedAssault                    = Action.Create({ Type = "Spell", ID = 266779     }),
    Chakrams                              = Action.Create({ Type = "Spell", ID = 259391     }),
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    AspectoftheEagle                      = Action.Create({ Type = "Spell", ID = 186289     }),
    Exhilaration                          = Action.Create({ Type = "Spell", ID = 109304     }),
    Muzzle                                = Action.Create({ Type = "Spell", ID = 187707     }),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368     }),
    Carve                                 = Action.Create({ Type = "Spell", ID = 187708     }),
    GuerrillaTactics                      = Action.Create({ Type = "Spell", ID = 264332     }),
    Butchery                              = Action.Create({ Type = "Spell", ID = 212436     }),
    WildfireInfusion                      = Action.Create({ Type = "Spell", ID = 271014     }),
    TermsofEngagement                     = Action.Create({ Type = "Spell", ID = 265895     }),
    VipersVenom                           = Action.Create({ Type = "Spell", ID = 268501     }),
    AlphaPredator                         = Action.Create({ Type = "Spell", ID = 269737     }),
	CounterShot                           = Action.Create({ Type = "Spell", ID = 147362 }),
    -- Pet
    CallPet                               = Action.Create({ Type = "Spell", ID = 883, Texture = 136   , Hidden = true     }),
    Intimidation                          = Action.Create({ Type = "Spell", ID = 19577     }),
    MendPet                               = Action.Create({ Type = "Spell", ID = 136     }),
    RevivePet                             = Action.Create({ Type = "Spell", ID = 982     }),
	-- Defensives
	AspectoftheTurtle                     = Action.Create({ Type = "Spell", ID = 274441 }),
    -- Misc
    Channeling                            = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368, Hidden = true     }),
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 167672, Hidden = true     }),
    HarmonicDematerializer                = Action.Create({ Type = "Spell", ID = 293512, Hidden = true     }),
    RecklessForceCounter                  = Action.Create({ Type = "Spell", ID = 298409, Hidden = true     }),
    RecklessForceCounter2                 = Action.Create({ Type = "Spell", ID = 302917, Hidden = true     }),
    -- Buffs
    VipersVenomBuff                       = Action.Create({ Type = "Spell", ID = 268552, Hidden = true     }),
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    TipoftheSpearBuff                     = Action.Create({ Type = "Spell", ID = 260286, Hidden = true     }),
    MongooseFuryBuff                      = Action.Create({ Type = "Spell", ID = 259388, Hidden = true     }),
    CoordinatedAssaultBuff                = Action.Create({ Type = "Spell", ID = 266779, Hidden = true     }),
    BlurofTalonsBuff                      = Action.Create({ Type = "Spell", ID = 277969, Hidden = true     }),
    Berserking                            = Action.Create({ Type = "Spell", ID = 26297, Hidden = true     }),
    BloodFury                             = Action.Create({ Type = "Spell", ID = 20572, Hidden = true     }),
	-- Debuffs 
    RazorCoralDebuff                      = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    LatentPoisonDebuff                    = Action.Create({ Type = "Spell", ID = 273286, Hidden = true     }),
    BloodseekerDebuff                     = Action.Create({ Type = "Spell", ID = 259277, Hidden = true     }),
    InternalBleedingDebuff                = Action.Create({ Type = "Spell", ID = 270343, Hidden = true     }),
    SerpentStingDebuff                    = Action.Create({ Type = "Spell", ID = 259491, Hidden = true     }),
    ShrapnelBombDebuff                    = Action.Create({ Type = "Spell", ID = 270339, Hidden = true     }),
    WildfireBombDebuff                    = Action.Create({ Type = "Spell", ID = 269747, Hidden = true     }),
    SteelTrapDebuff                       = Action.Create({ Type = "Spell", ID = 162487, Hidden = true     }),
	-- General Hunter Legendaries
	CalloftheWild                          = Action.Create({ Type = "Spell", ID = 336742  }),
    NessingwarysTrappingApparatus          = Action.Create({ Type = "Spell", ID = 336743  }),
    SoulforgeEmbers                        = Action.Create({ Type = "Spell", ID = 336745  }),
    CravenStrategem                        = Action.Create({ Type = "Spell", ID = 336747  }),
	-- Survival Hunter Legendaries  
	WildfireCluster                        = Action.Create({ Type = "Spell", ID = 336895  }),
    RylakstalkersConfoundingStrikes        = Action.Create({ Type = "Spell", ID = 336901  }),
    LatentPoisonInjectors                  = Action.Create({ Type = "Spell", ID = 336902  }),
    ButchersBoneFragments                  = Action.Create({ Type = "Spell", ID = 336907  }),
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
    DummyTest                            = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon   
	BirdsofPrey                          = Action.Create({ Type = "Spell", ID = 260331, Hidden = true     }),
	
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
--Action:CreateEssencesFor(ACTION_CONST_HUNTER_SURVIVAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_SURVIVAL], { __index = Action })

------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarCarveCdr = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarCarveCdr = 0
end)

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local player = "player"
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

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local WildfireInfusions = {
  A.ShrapnelBomb,
  A.PheromoneBomb,
  A.VolatileBomb,
}

local function CurrentWildfireInfusion()
    if A.WildfireInfusion:IsSpellLearned() then
        for _, infusion in pairs(WildfireInfusions) do
            if infusion:IsSpellLearned() then 
			    return infusion 
			end
        end
    end
    return A.WildfireBomb
end

local function CurrentRaptorStrike()
     return A.RaptorStrikeEagle:IsSpellLearned() and A.RaptorStrikeEagle or A.RaptorStrike
end

local function CurrentMongooseBite()
    return A.MongooseBiteEagle:IsSpellLearned() and A.MongooseBiteEagle or A.MongooseBite
end

local function InRange(unit)
	-- @return boolean 
	return A.SerpentSting:IsInRange(unit)
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


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
	-- Custom Spells remap
    local WildfireBomb = CurrentWildfireInfusion()
    local CurrentRaptorStrike = CurrentRaptorStrike()
    local MongooseBite = CurrentMongooseBite()
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
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
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        -- variable,name=carve_cdr,op=setif,value=active_enemies,value_else=5,condition=active_enemies<5
		VarCarveCdr = math.min(MultiUnits:GetByRange(8), 5)
		
		-- summon_pet
        if A.SummonPet:IsReady(unit) and not Pet:IsActive() then
            return A.SummonPet:Show(icon)
        end
		
		--Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- augmentation
            -- food
            -- summon_pet
            if A.SummonPet:IsReady(unit) and not Pet:IsActive() then
                return A.SummonPet:Show(icon)
            end
			
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- coordinated_assault
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and Unit("player"):HasBuffsDown(A.CoordinatedAssaultBuff.ID, true) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- potion,dynamic_prepot=1
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- steel_trap
            if A.SteelTrap:IsReady(unit) and Unit("player"):HasDebuffsDown(A.SteelTrapDebuff.ID, true) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.SteelTrap:Show(icon)
            end
			
            -- harpoon
            if A.Harpoon:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.Harpoon:Show(icon)
            end
			
        end
		
		-- Burst Phase
		if BurstIsON(unit) and unit ~= "mouseover" and inCombat and not profileStop and CanCast then
		
            -- blood_fury,if=cooldown.coordinated_assault.remains>30
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.BloodFury:Show(icon)
            end
			
            -- ancestral_call,if=cooldown.coordinated_assault.remains>30
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
			
            -- fireblood,if=cooldown.coordinated_assault.remains>30
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
			
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- berserking,if=cooldown.coordinated_assault.remains>60|time_to_die<13
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 60 or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
			
            -- potion,if=buff.guardian_of_azeroth.up&(buff.berserking.up|buff.blood_fury.up|!race.troll)|(consumable.potion_of_unbridled_fury&target.time_to_die<61|target.time_to_die<26)|!essence.condensed_lifeforce.major&buff.coordinated_assault.up
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and 
			(
			    Unit("player"):HasBuffs(A.GuardianofAzeroth.ID, true) > 0 and 				
				(
				    Unit("player"):HasBuffs(A.Berserking.ID, true) > 0 
				    or
				    Unit("player"):HasBuffs(A.BloodFury.ID, true) > 0 
					or not A.PlayerRace == "Troll"
				)
				or 
				(
				    Unit(unit):HasBuffs(A.PotionofUnbridledFury.ID, true) > 0 and Unit(unit):TimeToDie() < 61 
					or 
					Unit(unit):TimeToDie() < 26
				)
				or 
				not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0
			) 
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- aspect_of_the_eagle,if=target.distance>=6
            if A.AspectoftheEagle:IsReady(unit) and A.BurstIsON(unit) and Unit(unit):GetRange() >= 6 then
                return A.AspectoftheEagle:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=equipped.dribbling_inkpod&(debuff.razor_coral_debuff.down|Unit(unit):TimeToDieX(30)<1|(Unit(unit):HealthPercent()<30&buff.guardian_of_azeroth.up|buff.memory_of_lucid_dreams.up))|(!equipped.dribbling_inkpod&(buff.memory_of_lucid_dreams.up|buff.guardian_of_azeroth.up&cooldown.guardian_of_azeroth.remains>175)|debuff.razor_coral_debuff.down)|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    A.DribblingInkpod:IsExists() and 
				(
				    Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 
					or 
					Unit(unit):TimeToDieX(30) < 1 
					or 
					(
					    Unit(unit):HealthPercent() < 30 and Unit("player"):HasBuffs(A.GuardianofAzeroth.ID, true) > 0 
						or 
						Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0
					)
				)
				or
				(
				    not A.DribblingInkpod:IsExists() and 
					(
					    Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0
						or
						Unit("player"):HasBuffs(A.GuardianofAzeroth.ID, true) > 0 and A.GuardianofAzeroth:GetCooldown() > 175
					)
					or Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0
				)
				or Unit(unit):TimeToDie() < 20
			) 
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=galecallers_boon,if=cooldown.memory_of_lucid_dreams.remains|talent.wildfire_infusion.enabled&cooldown.coordinated_assault.remains|!essence.memory_of_lucid_dreams.major&cooldown.coordinated_assault.remains
            if A.GalecallersBoon:IsReady(unit) and 
			(
			    A.MemoryofLucidDreams:GetCooldown() > 0 
				or 
				A.WildfireInfusion:IsSpellLearned() and A.CoordinatedAssault:GetCooldown() > 0 
				or 
				not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and A.CoordinatedAssault:GetCooldown() > 0
			)
			then
                return A.GalecallersBoon:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- blood_of_the_enemy,if=buff.coordinated_assault.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end
			
            -- concentrated_flame,if=full_recharge_time<1*gcd
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < 1 * A.GetGCD()) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- reaping_flames,if=target.Unit(unit):HealthPercent()>80|target.Unit(unit):HealthPercent()<=20|Unit(unit):TimeToDieX(20)>30
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and 
			(
			    Unit(unit):HealthPercent() > 80 
				or 
				Unit(unit):HealthPercent() <= 20 
				or 
				Unit(unit):TimeToDieX(20) > 30
			)
			then
                return A.ReapingFlames:Show(icon)
            end
			
            -- mongoose_bite,if=essence.memory_of_lucid_dreams.major&!cooldown.memory_of_lucid_dreams.remains
            if MongooseBite:IsReady(unit) and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and A.MemoryofLucidDreams:GetCooldown() == 0) then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=essence.memory_of_lucid_dreams.major&full_recharge_time<1.5*gcd&focus<action.mongoose_bite.cost&!cooldown.memory_of_lucid_dreams.remains
            if WildfireBomb:IsReady(unit) and 
			(
			    Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() and Player:Focus() < MongooseBite:GetSpellPowerCostCache() and A.MemoryofLucidDreams:GetCooldown() == 0
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=focus<action.mongoose_bite.cost&buff.coordinated_assault.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:Focus() < MongooseBite:GetSpellPowerCostCache() and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
        end
			
        -- mongoose_bite,if=active_enemies=1&(talent.alpha_predator.enabled&target.time_to_die<10|target.time_to_die<5)
        if MongooseBite:IsReady(unit) and 
		(
			GetByRange(2, 8, false, true) and
			(
			    A.AlphaPredator:IsSpellLearned() and Unit(unit):TimeToDie() < 10 
				or 
				Unit(unit):TimeToDie() < 5
			)
		)
		then
            return MongooseBite:Show(icon)
        end
		
        -- call_action_list,name=apwfi,if=active_enemies<3&talent.chakrams.enabled&talent.alpha_predator.enabled
        if (GetByRange(3, 8, false, true) and A.Chakrams:IsSpellLearned() and A.AlphaPredator:IsSpellLearned()) then
		
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if CurrentRaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- serpent_sting,if=!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) == 0) then
                return A.SerpentSting:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd|focus+cast_regen<focus.max&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if WildfireBomb:IsReady(unit) and 
			(
			    WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD()
				or 
				Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() and 
				(
				    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5
					or 
					A.PheromoneBomb:IsSpellLearned() and Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0 and
					Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() - Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) * 3
				)
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- coordinated_assault
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- mongoose_bite,if=buff.mongoose_fury.remains&next_wi_bomb.pheromone
            if MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) > 0 and A.PheromoneBomb:IsSpellLearned()) then
                return MongooseBite:Show(icon)
            end
			
            -- kill_command,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max-20
            if A.KillCommand:IsReady(unit) and (A.KillCommand:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() and Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() - 20) then
                return A.KillCommand:Show(icon)
            end
			
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.SteelTrap:GetSpellCastTime()) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
			
            -- raptor_strike,if=buff.tip_of_the_spear.stack=3|dot.shrapnel_bomb.ticking
            if CurrentRaptorStrike:IsReady(unit) and 
			(
			    Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) == 3 
				or 
				Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0
			)
			then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking
            if MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0) then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&focus>30&dot.serpent_sting.remains>5*gcd
            if WildfireBomb:IsReady(unit) and (A.ShrapnelBomb:IsSpellLearned() and Player:Focus() > 30 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * A.GetGCD()) then
                return WildfireBomb:Show(icon)
            end
			
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0) then
                return A.Chakrams:Show(icon)
            end
			
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5) then
                return A.SerpentSting:Show(icon)
            end
			
            -- kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) and 
			(
			    Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() and 
				(
				    Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 
					or 
					Player:Focus() < MongooseBite:GetSpellPowerCostCache()
				)
			)
			then
                return A.KillCommand:Show(icon)
            end
			
            -- raptor_strike
            if CurrentRaptorStrike:IsReady(unit) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>40|dot.shrapnel_bomb.ticking
            if MongooseBite:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) > 0 
				or 
				Player:Focus() > 40
				or 
				Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0
			)
			then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
            if WildfireBomb:IsReady(unit) and 
			(
			    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) 
				or 
				A.PheromoneBomb:IsSpellLearned() or A.ShrapnelBomb:IsSpellLearned() and Player:Focus() > 50
			)
			then
                return WildfireBomb:Show(icon)
            end
			
        end
		
		-- call_action_list,name=wfi,if=active_enemies<3&talent.chakrams.enabled
        if (GetByRange(3, 8, false, true) and A.Chakrams:IsSpellLearned()) then
		
            -- harpoon,if=focus+cast_regen<focus.max&talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.Harpoon:GetSpellCastTime()) < Player:FocusMax() and A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
			
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if CurrentRaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1.5*gcd|!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1.5 * A.GetGCD() 
				or 
				Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) == 0
			)
			then
                return A.SerpentSting:Show(icon)
            end
			
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max|(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if WildfireBomb:IsReady(unit) and 
			(
			    WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() and Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() 
				or 
				(
				    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5
					or 
					A.PheromoneBomb:IsSpellLearned() and Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0 and 
					Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() - Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) * 3
				)
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- kill_command,if=focus+cast_regen<focus.max-focus.regen
            if A.KillCommand:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() - Player:FocusRegen()) then
                return A.KillCommand:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.SteelTrap:GetSpellCastTime()) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
			
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd
            if WildfireBomb:IsReady(unit) and (WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD()) then
                return WildfireBomb:Show(icon)
            end
			
            -- coordinated_assault
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * A.GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
			
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking|buff.mongoose_fury.stack=5
            if MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) == 5) then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&dot.serpent_sting.remains>5*gcd
            if WildfireBomb:IsReady(unit) and (A.ShrapnelBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * A.GetGCD()) then
                return WildfireBomb:Show(icon)
            end
			
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5) then
                return A.SerpentSting:Show(icon)
            end
			
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0) then
                return A.Chakrams:Show(icon)
            end
			
            -- mongoose_bite
            if MongooseBite:IsReady(unit) then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike
            if CurrentRaptorStrike:IsReady(unit) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0) then
                return A.SerpentSting:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel
            if WildfireBomb:IsReady(unit) and 
			(
			    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 0 
				or 
				A.PheromoneBomb:IsSpellLearned() or A.ShrapnelBomb:IsSpellLearned()
			)
			then
                return WildfireBomb:Show(icon)
            end
			
        end		
		
        -- call_action_list,name=st,if=active_enemies<3&!talent.alpha_predator.enabled&!talent.wildfire_infusion.enabled
        if (GetByRange(3, 8, false, true) and not A.AlphaPredator:IsSpellLearned() and not A.WildfireInfusion:IsSpellLearned()) then
            
			-- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
			
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.FlankingStrike:GetSpellCastTime()) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
			
            -- raptor_strike,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if CurrentRaptorStrike:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0 and 
				(
				    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() 
					or 
					Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD()
				)
			)
			then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- mongoose_bite,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if MongooseBite:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0 and 
				(
				    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD()
					or 
					Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD()
				)
			)
			then
                return MongooseBite:Show(icon)
            end
			
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.BloodseekerDebuff.ID, true) > 0 and Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() then 
                    return A.KillCommand:Show(icon) 
                end
            end
			
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1 * A.GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
			
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.SteelTrap:GetSpellCastTime()) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
			
            -- wildfire_bomb,if=focus+cast_regen<focus.max&!ticking&!buff.memory_of_lucid_dreams.up&(full_recharge_time<1.5*gcd|!dot.wildfire_bomb.ticking&!buff.coordinated_assault.up|!dot.wildfire_bomb.ticking&buff.mongoose_fury.stack<1)|time_to_die<18&!dot.wildfire_bomb.ticking
            if WildfireBomb:IsReady(unit) and 
			(
			    Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() and Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and 
				(
				    WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() 
					or 
					Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0 
					or
					Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 1
				)
				or Unit(unit):TimeToDie() < 18 and Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd|dot.serpent_sting.refreshable&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * A.GetGCD() 
				or 
				Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0
			)
			then
                return A.SerpentSting:Show(icon)
            end
			
            -- a_murder_of_crows,if=!buff.coordinated_assault.up
            if A.AMurderofCrows:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- coordinated_assault,if=!buff.coordinated_assault.up
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- mongoose_bite,if=buff.mongoose_fury.up|focus+cast_regen>focus.max-20&talent.vipers_venom.enabled|focus+cast_regen>focus.max-1&talent.terms_of_engagement.enabled|buff.coordinated_assault.up
            if MongooseBite:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) > 0
				or 
				Player:Focus() + Player:FocusCastRegen(MongooseBite:GetSpellCastTime()) > Player:FocusMax() - 20 and A.VipersVenom:IsSpellLearned() 
				or 
				Player:Focus() + Player:FocusCastRegen(MongooseBite:GetSpellCastTime()) > Player:FocusMax() - 1 and A.TermsofEngagement:IsSpellLearned() 
				or 
				Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0
			)
			then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike
            if CurrentRaptorStrike:IsReady(unit) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable
            if WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) < 5) then
                return WildfireBomb:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0) then
                return A.SerpentSting:Show(icon)
            end
			
        end		

        -- call_action_list,name=apst,if=active_enemies<3&talent.alpha_predator.enabled&!talent.wildfire_infusion.enabled
        if (GetByRange(3, 8, false, true) and A.AlphaPredator:IsSpellLearned() and not A.WildfireInfusion:IsSpellLearned()) then
		
            -- mongoose_bite,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if MongooseBite:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0 and 
				(
				    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() 
				    or 
				    Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD()
				)
			)
			then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if CurrentRaptorStrike:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0 and 
				(
				    Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() 
					or 
					Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD()
				)
			)
			then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.FlankingStrike:GetSpellCastTime()) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
			
            -- kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.BloodseekerDebuff.ID, true) > 0 and A.KillCommand:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() and Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() then 
                    return A.KillCommand:Show(icon) 
                end
            end
			
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.SteelTrap:GetSpellCastTime()) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
			
            -- wildfire_bomb,if=focus+cast_regen<focus.max&!ticking&!buff.memory_of_lucid_dreams.up&(full_recharge_time<1.5*gcd|!dot.wildfire_bomb.ticking&!buff.coordinated_assault.up|!dot.wildfire_bomb.ticking&buff.mongoose_fury.stack<1)|time_to_die<18&!dot.wildfire_bomb.ticking
            if WildfireBomb:IsReady(unit) and 
			(
			    Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() and Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and 
				(
				    WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() 
					or 
					Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0 
					or 
					Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0 and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 1
				)
				or Unit(unit):TimeToDie() < 18 and Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- serpent_sting,if=!dot.serpent_sting.ticking&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0) then
                return A.SerpentSting:Show(icon)
            end
			
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.BloodseekerDebuff.ID, true) > 0 and Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 or Player:Focus() < MongooseBite:GetSpellPowerCostCache()) then 
                    return A.KillCommand:Show(icon) 
                end
            end
			
            -- serpent_sting,if=refreshable&!buff.coordinated_assault.up&buff.mongoose_fury.stack<5
            if A.SerpentSting:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 
				and 
				Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0 
				and 
				Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5
			)
			then
                return A.SerpentSting:Show(icon)
            end
			
            -- a_murder_of_crows,if=!buff.coordinated_assault.up
            if A.AMurderofCrows:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- coordinated_assault,if=!buff.coordinated_assault.up
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) == 0) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- mongoose_bite,if=buff.mongoose_fury.up|focus+cast_regen>focus.max-10|buff.coordinated_assault.up
            if MongooseBite:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) 
				or 
				Player:Focus() + Player:FocusCastRegen(MongooseBite:GetSpellCastTime()) > Player:FocusMax() - 10 
				or 
				Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) > 0
			)
			then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike
            if CurrentRaptorStrike:IsReady(unit) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- wildfire_bomb,if=!ticking
            if WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) == 0) then
                return WildfireBomb:Show(icon)
            end
			
        end

        -- call_action_list,name=apwfi,if=active_enemies<3&talent.alpha_predator.enabled&talent.wildfire_infusion.enabled
        if (GetByRange(3, 8, false, true) and A.AlphaPredator:IsSpellLearned() and A.WildfireInfusion:IsSpellLearned()) then
		
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if CurrentRaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return CurrentRaptorStrike:Show(icon)
            end

            -- serpent_sting,if=!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) == 0) then
                return A.SerpentSting:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd|focus+cast_regen<focus.max&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if WildfireBomb:IsReady(unit) and 
			(
			    WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() 
				or 
				Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() and 
				(
				    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5
					or 
					A.PheromoneBomb:IsSpellLearned() and Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0 and Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() - Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) * 3
				)
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- coordinated_assault
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- mongoose_bite,if=buff.mongoose_fury.remains&next_wi_bomb.pheromone
            if MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) > 0 and A.PheromoneBomb:IsSpellLearned()) then
                return MongooseBite:Show(icon)
            end
			
            -- kill_command,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max-20
            if A.KillCommand:IsReady(unit) and (A.KillCommand:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() and Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() - 20) then
                return A.KillCommand:Show(icon)
            end
			
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.SteelTrap:GetSpellCastTime()) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
			
            -- raptor_strike,if=buff.tip_of_the_spear.stack=3|dot.shrapnel_bomb.ticking
            if CurrentRaptorStrike:IsReady(unit) and 
			(
			    Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) == 3 
				or
				Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0
			)
			then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking
            if MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0) then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&focus>30&dot.serpent_sting.remains>5*gcd
            if WildfireBomb:IsReady(unit) and (A.ShrapnelBomb:IsSpellLearned() and Player:Focus() > 30 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * A.GetGCD()) then
                return WildfireBomb:Show(icon)
            end
			
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0) then
                return A.Chakrams:Show(icon)
            end
			
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5) then
                return A.SerpentSting:Show(icon)
            end
			
            -- kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) and 
			(
			    Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() and 
				(
				    Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 
					or 
					Player:Focus() < MongooseBite:GetSpellPowerCostCache()
				)
			)
			then
                return A.KillCommand:Show(icon)
            end
			
            -- raptor_strike
            if CurrentRaptorStrike:IsReady(unit) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>40|dot.shrapnel_bomb.ticking
            if MongooseBite:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) > 0
				or 
				Player:Focus() > 40 
				or 
				Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0
			)
			then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
            if WildfireBomb:IsReady(unit) and 
			(
			    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 0 
				or 
				A.PheromoneBomb:IsSpellLearned()
				or 
				A.ShrapnelBomb:IsSpellLearned() and Player:Focus() > 50
			)
			then
                return WildfireBomb:Show(icon)
            end
			
        end	
		
        -- call_action_list,name=wfi,if=active_enemies<3&!talent.alpha_predator.enabled&talent.wildfire_infusion.enabled
        if (GetByRange(3, 8, false, true) and not A.AlphaPredator:IsSpellLearned() and A.WildfireInfusion:IsSpellLearned()) then
		
            -- harpoon,if=focus+cast_regen<focus.max&talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.Harpoon:GetSpellCastTime()) < Player:FocusMax() and A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
			
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if CurrentRaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1.5*gcd|!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and 
			(
			    Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1.5 * A.GetGCD() 
				or 
				Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) == 0
			)
			then
                return A.SerpentSting:Show(icon)
            end
			
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max|(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if WildfireBomb:IsReady(unit) and 
			(
			    WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD() and Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() 
				or 
				(
				    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 
					or 
					A.PheromoneBomb:IsSpellLearned() and Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0 and Player:Focus() + Player:FocusCastRegen(WildfireBomb:GetSpellCastTime()) < Player:FocusMax() - Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) * 3
				)
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- kill_command,if=focus+cast_regen<focus.max-focus.regen
            if A.KillCommand:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() - Player:FocusRegen()) then
                return A.KillCommand:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.SteelTrap:GetSpellCastTime()) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
			
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd
            if WildfireBomb:IsReady(unit) and (WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * A.GetGCD()) then
                return WildfireBomb:Show(icon)
            end
			
            -- coordinated_assault
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * A.GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
			
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking|buff.mongoose_fury.stack=5
            if MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) == 5) then
                return MongooseBite:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&dot.serpent_sting.remains>5*gcd
            if WildfireBomb:IsReady(unit) and (A.ShrapnelBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * A.GetGCD()) then
                return WildfireBomb:Show(icon)
            end
			
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5) then
                return A.SerpentSting:Show(icon)
            end
			
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) == 0) then
                return A.Chakrams:Show(icon)
            end
			
            -- mongoose_bite
            if MongooseBite:IsReady(unit) then
                return MongooseBite:Show(icon)
            end
			
            -- raptor_strike
            if CurrentRaptorStrike:IsReady(unit) then
                return CurrentRaptorStrike:Show(icon)
            end
			
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) > 0) then
                return A.SerpentSting:Show(icon)
            end
			
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel
            if WildfireBomb:IsReady(unit) and 
			(
			    A.VolatileBomb:IsSpellLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 0 
				or 
				A.PheromoneBomb:IsSpellLearned() 
				or 
				A.ShrapnelBomb:IsSpellLearned()
			)
			then
                return WildfireBomb:Show(icon)
            end
			
        end

        -- call_action_list,name=cleave,if=active_enemies>1&!talent.birds_of_prey.enabled|active_enemies>2
        if ((GetByRange(2, 8) and not A.BirdsofPrey:IsSpellLearned()) or GetByRange(3, 8)) then
            			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- coordinated_assault
            if A.CoordinatedAssault:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
			
            -- carve,if=dot.shrapnel_bomb.ticking
            if A.Carve:IsReady(player) and Unit(unit):GetRange() <= 8 and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0) then
                return A.Carve:Show(icon)
            end
						
            -- wildfire_bomb,if=!talent.guerrilla_tactics.enabled|full_recharge_time<gcd
            if WildfireBomb:IsReady(unit) and 
			(
			    not A.GuerrillaTactics:IsSpellLearned() 
				or 
				WildfireBomb:GetSpellChargesFullRechargeTime() < A.GetGCD()
			)
			then
                return WildfireBomb:Show(icon)
            end
			
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack=10
            if MongooseBite:IsReady(unit) then
                if Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true) == 10 then 
                    return MongooseBite:Show(icon) 
                end
            end
			
            -- chakrams
            if A.Chakrams:IsReady(unit) then
                return A.Chakrams:Show(icon)
            end
			
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.BloodseekerDebuff.ID, true) > 0 and Player:Focus() + Player:FocusCastRegen(A.KillCommand:GetSpellCastTime()) < Player:FocusMax() then 
                    return A.KillCommand:Show(icon) 
                end
            end
			
            -- butchery,if=full_recharge_time<gcd|!talent.wildfire_infusion.enabled|dot.shrapnel_bomb.ticking&dot.internal_bleeding.stack<3
            if A.Butchery:IsReady(unit) and 
			(
			    A.Butchery:GetSpellChargesFullRechargeTime() < A.GetGCD() 
				or
				not A.WildfireInfusion:IsSpellLearned()
				or
				Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) > 0 and Unit(unit):HasDeBuffsStacks(A.InternalBleedingDebuff.ID, true) < 3
			)
			then
                return A.Butchery:Show(icon)
            end
			
            -- carve,if=talent.guerrilla_tactics.enabled
            if A.Carve:IsReady(player) and Unit(unit):GetRange() <= 8 and (A.GuerrillaTactics:IsSpellLearned()) then
                return A.Carve:Show(icon)
            end
			
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Player:FocusCastRegen(A.FlankingStrike:GetSpellCastTime()) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
			
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable|talent.wildfire_infusion.enabled
            if WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) < 5 or A.WildfireInfusion:IsSpellLearned()) then
                return WildfireBomb:Show(icon)
            end
			
            -- serpent_sting,target_if=min:remains,if=buff.vipers_venom.react
            if A.SerpentSting:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 and Unit("player"):HasBuffsStacks(A.VipersVenomBuff.ID, true) > 0 then 
                    return A.SerpentSting:Show(icon) 
                end
            end
			
            -- carve,if=cooldown.wildfire_bomb.remains>variable.carve_cdr%2
            if A.Carve:IsReady(player) and Unit(unit):GetRange() <= 8 and (WildfireBomb:GetCooldown() > VarCarveCdr / 2) then
                return A.Carve:Show(icon)
            end

            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
			
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
			
            -- serpent_sting,target_if=min:remains,if=refreshable&buff.tip_of_the_spear.stack<3
            if A.SerpentSting:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 5 and Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) < 3 then 
                    return A.SerpentSting:Show(icon) 
                end
            end
			
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack
            if MongooseBite:IsReady(unit) then
                if Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true) > 0 then 
                    return MongooseBite:Show(icon) 
                end
            end
			
            -- raptor_strike,target_if=max:debuff.latent_poison.stack
            if CurrentRaptorStrike:IsReady(unit) then
                if Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true) > 0 then 
                    return CurrentRaptorStrike:Show(icon) 
                end
            end
			
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
			
        -- concentrated_flame
        if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
            return A.ConcentratedFlame:Show(icon)
        end
		
        -- arcane_torrent
        if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
            return A.ArcaneTorrent:Show(icon)
        end
		
        -- bag_of_tricks
        if A.BagofTricks:AutoRacial(unit) then
            return A.BagofTricks:Show(icon)
        end        
    end


    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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
    --local Party = PartyRotation("party1") 
   -- if Party then 
    --    return Party:Show(icon)
   -- end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
   -- local Party = PartyRotation("party2") 
   -- if Party then 
   --     return Party:Show(icon)
   -- end     
    return ArenaRotation(icon, "arena3")
end

