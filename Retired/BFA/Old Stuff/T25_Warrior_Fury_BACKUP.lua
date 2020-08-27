-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local Action									= Action
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
local Azerite									= LibStub("AzeriteTraits")
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
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARRIOR_FURY] = {
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
    RecklessnessBuff                       = Action.Create({ Type = "Spell", ID = 1719, Hidden = true     }),
    Recklessness                           = Action.Create({ Type = "Spell", ID = 1719      }),
    HeroicLeap                             = Action.Create({ Type = "Spell", ID = 6544      }),
    Siegebreaker                           = Action.Create({ Type = "Spell", ID = 280772      }),
    Rampage                                = Action.Create({ Type = "Spell", ID = 184367      }),
    FrothingBerserker                      = Action.Create({ Type = "Spell", ID = 215571      }),
    Carnage                                = Action.Create({ Type = "Spell", ID = 202922      }),
    EnrageBuff                             = Action.Create({ Type = "Spell", ID = 184362, Hidden = true     }),
    Massacre                               = Action.Create({ Type = "Spell", ID = 206315      }),
    Execute                                = Action.Create({ Type = "Spell", ID = 5308      }),
    FuriousSlash                           = Action.Create({ Type = "Spell", ID = 100130      }),
    FuriousSlashBuff                       = Action.Create({ Type = "Spell", ID = 202539, Hidden = true     }),
    Bladestorm                             = Action.Create({ Type = "Spell", ID = 46924      }),
    Bloodthirst                            = Action.Create({ Type = "Spell", ID = 23881      }),
    ColdSteelHotBlood					   = Action.Create({ Type = "Spell", ID = 288080, Hidden = true     }), 
    DragonRoar                             = Action.Create({ Type = "Spell", ID = 118000      }),
    RagingBlow                             = Action.Create({ Type = "Spell", ID = 85288      }),
    Whirlwind                              = Action.Create({ Type = "Spell", ID = 190411      }),
    Charge                                 = Action.Create({ Type = "Spell", ID = 100      }),
    MeatCleaverBuff                        = Action.Create({ Type = "Spell", ID = 85739, Hidden = true     }), --85739 -- 280392
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297      }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647      }),
    SiegebreakerDebuff                     = Action.Create({ Type = "Spell", ID = 280773, Hidden = true     }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221      }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738      }),
	BattleShout                            = Action.Create({ Type = "Spell", ID = 6673         }),
	-- Self Defensive
	EnragedRegeneration                    = Action.Create({ Type = "Spell", ID = 184364         }),
	BerserkerRage                          = Action.Create({ Type = "Spell", ID = 18499         }),
	VictoryRush	                           = Action.Create({ Type = "Spell", ID = 34428         }),
	ImpendingVictory                       = Action.Create({ Type = "Spell", ID = 202168         }),
	RallyingCry	                           = Action.Create({ Type = "Spell", ID = 97462         }),
	Interception                           = Action.Create({ Type = "Spell", ID = 198304         }),
	-- CrownControl
	Stormbolt                              = Action.Create({ Type = "Spell", ID = 107570    }),
	StormboltGreen                         = Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true    }),
	Pummel	                               = Action.Create({ Type = "Spell", ID = 6552    }),
	PummelGreen	                           = Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true    }),  
	IntimidatingShout                      = Action.Create({ Type = "Spell", ID = 5246, Hidden = true     }),
	PiercingHowl                           = Action.Create({ Type = "Spell", ID = 23600    }), 
	PiercingHowlDebuff                     = Action.Create({ Type = "Spell", ID = 23600, Hidden = true     }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
	PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

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

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 


local function InRange(unit)
	-- @return boolean 
	return A.Bloodthirst:IsInRange(unit)
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

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
	(
        (A.IsInPvP and Unit(unit):IsControlAble("stun", 0)) 
        or
        not A.IsInPvP		
    ) 
	and A.StormboltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if	A.StormboltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormboltGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then 
            -- Pummel		
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
			-- Stormbolt
            if A.Stormbolt:IsReady(unit, nil, nil, true) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.Stormbolt:Show(icon)                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

local function SelfDefensives()
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
 
	-- Enraged Regeneration
	local EnragedRegeneration = A.GetToggle(2, "EnragedRegeneration")
    if     EnragedRegeneration >= 0 and A.EnragedRegeneration:IsReady(player) and 
    (
        (   -- Auto 
            EnragedRegeneration >= 100 and 
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
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
		or 
        (   -- Custom
            EnragedRegeneration < 100 and 
            Unit(player):HealthPercent() <= EnragedRegeneration
        )
    ) 
    then 
        return A.EnragedRegeneration
    end 
 
	-- Rallying Cry
    local RallyingCry = A.GetToggle(2, "RallyingCry")
    if     RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
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
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
		or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(player):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
	 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
	-- Pummel
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        return A.Pummel
    end 
	
 	-- Stormbolt
    if A.Stormbolt:IsReady(unit, nil, nil, true) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) and Unit(unit):IsControlAble("stun", 0) then
        return A.Stormbolt                 
    end 
 
	-- IntimidatingShout
    if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) and Unit(unit):IsControlAble("fear", 0) then 
        return A.IntimidatingShout              
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
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
	local DBM = GetToggle(1 ,"DBM")
	local Potion = GetToggle(1, "Potion")
	local Racial = GetToggle(1, "Racial")
	local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
	local BloodoftheEnemySyncAoE = GetToggle(2, "BloodoftheEnemySyncAoE")
	local BloodoftheEnemyAoETTD = GetToggle(2, "BloodoftheEnemyAoETTD")
	local BloodoftheEnemyUnits = GetToggle(2, "BloodoftheEnemyUnits")
	local MinAoETargets = GetToggle(2, "MinAoETargets")
	local MaxAoERange = GetToggle(2, "MaxAoERange")
	
	
	local UseCharge = GetToggle(2, "UseCharge")
	local ChargeTime = GetToggle(2, "ChargeTime")
	local UseHeroicLeap = GetToggle(2, "UseHeroicLeap") 
	local HeroicLeapTime = GetToggle(2, "HeroicLeapTime")
	local SmartStormbolt = GetToggle(2, "SmartStormbolt")
	local profileStop = false
	local CanCast = true
	-- FocusedAzeriteBeam protection channel
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
		-- @return:
		-- [1] Currect Casting Left Time (seconds) (@number)
		-- [2] Current Casting Left Time (percent) (@number)
		-- [3] spellID (@number)
		-- [4] spellName (@string)
		-- [5] notInterruptable (@boolean, false is able to be interrupted)
		-- [6] isChannel (@boolean)
	if percentLeft > 0.01 and spellName == A.FocusedAzeriteBeam:Info() then 
	    CanCast = false
	else
	    CanCast = true
	end	
	
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
	-- Mounted
	if Player:IsMounted() then
	    profileStop = true
	end
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        
		-- BattleShout
        if A.BattleShout:IsReady(player) and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 then
            return A.BattleShout:Show(icon)
        end	
		
        --Precombat
        if combatTime == 0 and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
			
			-- BattleShout
            if A.BattleShout:IsReady(player) and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 and not A.LastPlayerCastName == A.BattleShout:Info() then
                return A.BattleShout:Show(icon)
            end	
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- recklessness
            if A.Recklessness:IsReady(unit) and Unit(player):HasBuffs(A.BattleShout.ID, true) > 0 and Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and A.BurstIsON(unit) then
                return A.Recklessness:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Potion then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- auto_attack
            -- charge
            if A.Charge:IsReady(unit) and UseCharge then
                return A.Charge:Show(icon)
            end	
			
        end
                        
        -- In Combat
        if inCombat and Unit(unit):IsExists() then
	
			-- Smart Stormbolt			
            if SmartStormbolt then
                local Stormbolt_Nameplates = MultiUnits:GetActiveUnitPlates()
                if Stormbolt_Nameplates then                         				
                    for Stormbolt_UnitID in pairs(Stormbolt_Nameplates) do    						
                        for k, v in pairs(TR.Lists.Storm_Spells_List) do
                            if (TR.Lists.Storm_Unit_List[select(6, Unit(Stormbolt_UnitID):InfoGUID())] ~= nil or UnitCastingInfo(Stormbolt_UnitID) == GetSpellInfo(v) or UnitChannelInfo(Stormbolt_UnitID) == GetSpellInfo(v)) and Unit(Stormbolt_UnitID):GetRange() <= 20 then                           
						        if A.Stormbolt:IsSpellLearned() and A.Stormbolt:IsReadyByPassCastGCD("player") then
                                    return A.Stormbolt:Show(icon)
                                end
                            end
                        end    
                    end 
                end						
            end	  

    	    -- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end	

            -- charge
            if A.Charge:IsReady(unit) and UseCharge and isMovingFor > ChargeTime then
                return A.Charge:Show(icon)
            end
			
            -- run_action_list,name=movement,if=movement.distance>5
            if Unit(unit):GetRange() > 5 then
                -- heroic_leap
                if A.HeroicLeap:IsReady(unit) and UseHeroicLeap and isMovingFor > HeroicLeapTime then
                    return A.HeroicLeap:Show(icon)
                end
            end
			
			-- BattleShout
            if A.BattleShout:IsReady(player) and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 and not A.LastPlayerCastName == A.BattleShout:Info() then
                return A.BattleShout:Show(icon)
            end	
			
            -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
           -- if A.HeroicLeap:IsReady(unit) and ((raid_event.movement.distance > 25 and 10000000000 > 45)) then
           --     return A.HeroicLeap:Show(icon)
           -- end
		   
            -- rampage,if=cooldown.recklessness.remains<3
            if A.Rampage:IsReadyByPassCastGCD(unit) and (A.Recklessness:GetCooldown() < 3) then
                return A.Rampage:Show(icon)
            end	

            -- victory.rush,if=health.percent<value
	    	if A.VictoryRush:IsReady(unit) and Unit(player):HealthPercent() <= A.GetToggle(2, "VictoryRush") then
	    		return A.VictoryRush:Show(icon)
	    	end

	    	-- PiercingHowl (slow)
            if A.PiercingHowl:IsReady(unit) and Unit(unit):HasDeBuffs(A.PiercingHowl.ID) <= 2 and not Unit(unit):IsBoss() and Unit(unit):GetRange() <= 14 and 
	    	Unit(unit):GetMaxSpeed() >= 100 and Unit(unit):HasDeBuffs("Slowed") == 0 and not Unit(unit):IsTotem() and Unit(unit):IsMovingOut() 
			then 
                return A.PiercingHowl:Show(icon)
            end
			
		    -- Cooldowns PvE
		    if unit ~= "mouseover" and A.BurstIsON(unit) then 
			
                -- potion,if=buff.guardian_of_azeroth.up|(!essence.condensed_lifeforce.major&target.time_to_die=60)
                if A.PotionofUnbridledFury:IsReady(unit) and Potion and 
			    (
			        Unit(player):HasBuffs(A.GuardianofAzeroth.ID, true) > 0
			    	or
				    (not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID) and Unit(unit):TimeToDie() == 60)
			    )
			    then
                    return A.PotionofUnbridledFury:Show(icon)
                end

                -- blood_of_the_enemy,if=(cooldown.death_and_decay.remains&spell_targets.death_and_decay>1)|(cooldown.defile.remains&spell_targets.defile>1)|(cooldown.apocalypse.remains&cooldown.death_and_decay.ready)
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) > 0 and BurstIsON(unit) and HeartOfAzeroth and 
			    (
			        not BloodoftheEnemySyncAoE and Unit(unit):TimeToDie() >= BloodoftheEnemyAoETTD
				    or
				    BloodoftheEnemySyncAoE and Player:AreaTTD(MaxAoERange) >= BloodoftheEnemyAoETTD and GetByRange(BloodoftheEnemyUnits, MaxAoERange) 
					or
					Unit(unit):IsBoss()
			    )
			    then
                    return A.BloodoftheEnemy:Show(icon)
                end
			
                -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
                if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			    (
		    	    Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SiegebreakerBuff.ID, true) == 0
		    	)
		    	then
                    return A.PurifyingBlast:Show(icon)
                end
			
                -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
                if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SiegebreakerBuff.ID, true) == 0
		    	)
			    then
                    return A.RippleinSpace:Show(icon)
                end
			
                -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
                if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SiegebreakerBuff.ID, true) == 0
			    )
			    then
                    return A.WorldveinResonance:Show(icon)
                end
			
                -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
                if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SiegebreakerBuff.ID, true) == 0
			    )
			    then
                    return A.FocusedAzeriteBeam:Show(icon)
                end
			
                -- reaping_flames,if=!buff.recklessness.up&!buff.siegebreaker.up
                if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SiegebreakerBuff.ID, true) == 0) then
                    return A.ReapingFlames:Show(icon)
               end
			
                -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
                if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(player):HasBuffs(A.SiegebreakerBuff.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0
			    )
			    then
                    return A.ConcentratedFlame:Show(icon)
                end
			
                -- the_unbound_force,if=buff.reckless_force.up
                if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                    return A.TheUnboundForce:Show(icon)
                end
			
                -- guardian_of_azeroth,if=!buff.recklessness.up&(target.time_to_die>195|target.health.pct<20)
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and (Unit(unit):TimeToDie() > 195 or Unit(unit):HealthPercent() < 20)
			    )
			    then
                    return A.GuardianofAzeroth:Show(icon)
               end
			
                -- memory_of_lucid_dreams,if=!buff.recklessness.up
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0) then
                    return A.MemoryofLucidDreams:Show(icon)
                end
			
                -- recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>1|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
                if A.Recklessness:IsReady(unit) and A.BurstIsON(unit) and 
			    (
		    	    not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) 
		    		or
		    		A.GuardianofAzeroth:GetCooldown() > 1 
		    		or
			    	Unit(player):HasBuffs(A.GuardianofAzeroth.ID, true) > 0 
		    		or
		    		A.BloodoftheEnemy:GetCooldown() < A.GetGCD()
		    	)
		    	then
                    return A.Recklessness:Show(icon)
                end
			
			end
			-- Burst end
			
			-- here is the maintain MeatCleaverBuff for AoE 			
            -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
            if A.Whirlwind:IsReady(player) and 
			(
			    GetByRange(2, 5) and Unit(player):HasBuffsStacks(A.MeatCleaverBuff.ID, true) == 0
			)
			and A.LastPlayerCastName ~= A.Whirlwind:Info()
			--and (A.LastPlayerCastName ~= A.Whirlwind:Info() and not A.RagingBlow:IsReady(unit) and not A.Bloodthirst:IsReady(unit) and (not A.Siegebreaker:IsReady(unit) or not A.Siegebreaker:IsSpellLearned()) and not A.Rampage:IsReady(unit) )
			then
                return A.Whirlwind:Show(icon)
            end

            -- dragon_roar,if=buff.enrage.up
            if A.DragonRoar:IsReadyByPassCastGCD(player) and (Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0) then
                return A.DragonRoar:Show(icon)
            end

	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and CanCast and    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then 
      	        return A.Trinket1:Show(icon)
   	        end 	        
		
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and CanCast and	    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then
      	       	return A.Trinket2:Show(icon) 	
	        end
			
            -- use_item,name=ashvanes_razor_coral,if=target.time_to_die<20|!debuff.razor_coral_debuff.up|(target.health.pct<30.1&debuff.conductive_ink_debuff.up)|(!debuff.conductive_ink_debuff.up&buff.memory_of_lucid_dreams.up|prev_gcd.2.guardian_of_azeroth|prev_gcd.2.recklessness&(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major))
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    Unit(unit):TimeToDie() < 20 
				or
				not Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) 
				or 
				(Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true)) 
				or
				(
				    not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 
					or
					A.LastPlayerCastName == A.GuardianofAzeroth:Info()
					or 
					A.LastPlayerCastName == A.Recklessness:Info() and 
					(
					    not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID)
					)
				)
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- blood_fury,if=buff.recklessness.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) > 0) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking,if=buff.recklessness.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) > 0) then
                return A.Berserking:Show(icon)
            end
			
            -- lights_judgment,if=buff.recklessness.down&debuff.siegebreaker.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- fireblood,if=buff.recklessness.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) > 0) then
                return A.Fireblood:Show(icon)
            end
			
            -- ancestral_call,if=buff.recklessness.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) > 0) then
                return A.AncestralCall:Show(icon)
            end
			
            -- bag_of_tricks,if=buff.recklessness.down&debuff.siegebreaker.down&buff.enrage.up
            if A.BagofTricks:AutoRacial(unit) and 
			(
			    Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0 and Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0
			)
			then
                return A.BagofTricks:Show(icon)
            end
			
            -- run_action_list,name=single_target
            -- siegebreaker
            if A.Siegebreaker:IsReadyByPassCastGCD(unit) and 
			(   
			    GetByRange(2, 5) and Unit(player):HasBuffsStacks(A.MeatCleaverBuff.ID, true) > 0 
				or 
				GetByRange(2, 5, false, true)
            )
            then			
				return A.Siegebreaker:Show(icon)
            end
			
            -- rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
            if A.Rampage:IsReadyByPassCastGCD(unit) and 
			(
			    (
				    Unit(player):HasBuffs(A.RecklessnessBuff.ID, true) > 0 or Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0
				)
				or 
				(
				    A.FrothingBerserker:IsSpellLearned() and Player:Rage() >= 95
					or
					A.Carnage:IsSpellLearned() and 
					(
					    Unit(player):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() 
					    or
					    Player:Rage() >= 75
					) 
					or A.Massacre:IsSpellLearned() and 
					(
					    Unit(player):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() 
						or
						Player:Rage() >= 85
					)
				)
			)
			then
                return A.Rampage:Show(icon)
            end
			
            -- execute
            if A.Execute:IsReadyByPassCastGCD(unit) then
                return A.Execute:Show(icon)
            end
			
            -- furious_slash,if=!buff.bloodlust.up&buff.furious_slash.remains<3
            if A.FuriousSlash:IsReady(unit) and (not Unit(player):HasHeroism() and Unit(player):HasBuffs(A.FuriousSlashBuff.ID, true) < 3) then
                return A.FuriousSlash:Show(icon)
            end
			
            -- bladestorm,if=prev_gcd.1.rampage
            if A.Bladestorm:IsReady(player) and A.BurstIsON(unit) and A.LastPlayerCastName == A.Rampage:Info() then
                return A.Bladestorm:Show(icon)
            end
			
            -- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
            if A.Bloodthirst:IsReady(unit) and (Unit(player):HasBuffs(A.EnrageBuff.ID, true) == 0 or A.ColdSteelHotBlood:GetAzeriteRank() > 1) then
                return A.Bloodthirst:Show(icon)
            end
			
            -- dragon_roar,if=buff.enrage.up
            if A.DragonRoar:IsReadyByPassCastGCD(player) and (Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0) then
                return A.DragonRoar:Show(icon)
            end
			
            -- raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90)
            if A.RagingBlow:IsReadyByPassCastGCD(unit) and
			(
			    (A.Carnage:IsSpellLearned() and Player:Rage() < 75)
				or
				(A.Massacre:IsSpellLearned() and Player:Rage() < 85)
				or 
				(A.FrothingBerserker:IsSpellLearned() and Player:Rage() < 95)
			)
			then
                return A.RagingBlow:Show(icon)
            end	
			
            -- raging_blow,if=charges=2
            if A.RagingBlow:IsReadyByPassCastGCD(unit) and (A.RagingBlow:GetSpellCharges() == 2) then
                return A.RagingBlow:Show(icon)
            end
			
            -- bloodthirst
            if A.Bloodthirst:IsReady(unit) then
                return A.Bloodthirst:Show(icon)
            end
						
            -- furious_slash,if=talent.furious_slash.enabled
            if A.FuriousSlash:IsReady(unit) and (A.FuriousSlash:IsSpellLearned()) then
                return A.FuriousSlash:Show(icon)
            end
			
            -- whirlwind
            if A.Whirlwind:IsReady(player) and A.LastPlayerCastName ~= A.Whirlwind:Info() then --and (A.LastPlayerCastName ~= A.Whirlwind:Info() and not A.RagingBlow:IsReady(unit) and not A.Bloodthirst:IsReady(unit) and (not A.Siegebreaker:IsReady(unit) or not A.Siegebreaker:IsSpellLearned()) and not A.Rampage:IsReady(unit) ) then
                return A.Whirlwind:Show(icon)
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
--[[local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit(player):GetDR("incapacitate") >= 50 
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
        if unit == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end]]--

