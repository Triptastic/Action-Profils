-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local Action                                    = Action
local Listener                                  = Action.Listener
local Create                                    = Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Azerite                                   = LibStub("AzeriteTraits")
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert
local select, unpack, table                     = select, unpack, table
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local _G, setmetatable, select, math            = _G, setmetatable, select, math
local huge                                      = math.huge
local UIParent                                  = _G.UIParent
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType

--- ============================ CONTENT =========================== ---
--- ======================= SPELLS DECLARATION ===================== ---

Action[ACTION_CONST_WARRIOR_PROTECTION] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    ThunderClap                            = Create({ Type = "Spell", ID = 6343 }),
    DemoralizingShout                      = Create({ Type = "Spell", ID = 1160 }),
    BoomingVoice                           = Create({ Type = "Spell", ID = 202743 }),
    ShieldBlock                            = Create({ Type = "Spell", ID = 2565 }),
    ShieldSlam                             = Create({ Type = "Spell", ID = 23922 }),
    ShieldBlockBuff                        = Create({ Type = "Spell", ID = 132404 }),
    DragonRoar                             = Create({ Type = "Spell", ID = 118000 }),
    Revenge                                = Create({ Type = "Spell", ID = 6572 }),
    AvatarBuff                             = Create({ Type = "Spell", ID = 107574 }),
    Ravager                                = Create({ Type = "Spell", ID = 228920 }),
    UnstoppableForce                       = Create({ Type = "Spell", ID = 275336 }),
    Avatar                                 = Create({ Type = "Spell", ID = 107574 }),
    Devastate                              = Create({ Type = "Spell", ID = 20243 }),
    Intercept                              = Create({ Type = "Spell", ID = 198304 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    IgnorePain                             = Create({ Type = "Spell", ID = 190456 }),
    TheCrucibleofFlame                     = Create({ Type = "Spell", ID =  }),
    LastStand                              = Create({ Type = "Spell", ID =  }),
    AnimaofLifeandDeath                    = Create({ Type = "Spell", ID =  }),
    HeartEssence                           = Create({ Type = "Spell", ID = 298554 })
    -- Trinkets
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Create({ Type = "Spell", ID = 302565, Hidden = true     }),
};

-- To create covenant use next code:
A:CreateCovenantsFor(ACTION_CONST_WARRIOR_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------- PROTECTION PRE APL SETUP --------
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
	BigDeff                                 = {A.ShieldWall.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.Devastate:IsInRange(unit)
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

local function isCurrentlyTanking()
    -- is player currently tanking any enemies within 16 yard radius
    local IsTanking = Unit(player):IsTankingAoE(16) or Unit(player):IsTanking("target", 16);
    return IsTanking;
end

local function shouldCastIp()
    if Unit(player):HasBuffs(A.IgnorePain.ID, true) > 0 then 
        local castIP = tonumber((GetSpellDescription(190456):match("%d+%S+%d"):gsub("%D","")))
        local IPCap = math.floor(castIP * 1.3);
        local currentIp = Unit(player):HasBuffs(A.IgnorePain.ID, true)

        -- Dont cast IP if we are currently at 50% of IP Cap remaining
        if currentIp  < (0.5 * IPCap) then
            return true
        else
            return false
        end
    else
        -- No IP buff currently
        return true
    end
end

local function offensiveShieldBlock()
    return not Action.GetToggle(2, "UseShieldBlockDefensively") and true or false
end

local function offensiveRage()
    return not Action.GetToggle(2, "UseRageDefensively") and true or false 
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    A.StormboltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
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

-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = math.max((Unit(player):GetDMG() * 100 / Unit(player):HealthMax()) - (Unit(player):GetHEAL() * 100 / Unit(player):HealthMax()), 0)

	
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
	
    -- memory_of_lucid_dreams
    if A.MemoryofLucidDreams:AutoHeartOfAzerothP(player, true) and Action.GetToggle(1, "HeartOfAzeroth") then 
	    local LucidDreamTTD = GetToggle(2, "LucidDreamTTD")	
	    local LucidDreamHP = GetToggle(2, "LucidDreamHP")
            
        if  (    
                ( LucidDreamHP      >= 0     or LucidDreamTTD                    >= 0                                        ) and 
                ( LucidDreamHP      <= 0     or Unit(player):HealthPercent()     <= LucidDreamHP                             ) and 
                ( LucidDreamTTD     <= 0     or Unit(player):TimeToDie()         <= LucidDreamTTD                            ) 
            )                 
        then                
            return A.MemoryofLucidDreams
        end 
    end
			
    -- ShieldBlock (any role, whenever have physical damage)
	local ShieldBlockHPLost = GetToggle(2, "ShieldBlockHPLost")
    if Player:Rage() >= A.ShieldBlock:GetSpellPowerCost() and HPLoosePerSecond >= ShieldBlockHPLost and A.ShieldBlock:IsReady(player) and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 and Unit(player):GetRealTimeDMG(3) > 0 then 
        return A.ShieldBlock
    end 
	
    -- LastStand
    if A.LastStand:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "LastStandIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff) == 0) then 
        local LS_HP                 = A.GetToggle(2, "LastStandHP")
        local LS_TTD                = A.GetToggle(2, "LastStandTTD")
            
        if  (    
                ( LS_HP     >= 0     or LS_TTD                              >= 0                                        ) and 
                ( LS_HP     <= 0     or Unit(player):HealthPercent()     <= LS_HP                                    ) and 
                ( LS_TTD     <= 0     or Unit(player):TimeToDie()         <= LS_TTD                                      ) 
            ) 
		    or 
            (
                A.GetToggle(2, "LastStandCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.LastStand
        end 
    end
		
		
    -- ShieldWall
    if A.ShieldWall:IsReadyByPassCastGCD(player) then 
        local SW_HP                 = A.GetToggle(2, "ShieldWallHP")
        local SW_TTD                = A.GetToggle(2, "ShieldWallTTD")
            
        if  (    
                ( SW_HP     >= 0     or SW_TTD                              >= 0                                        ) and 
                ( SW_HP     <= 0     or Unit(player):HealthPercent()     <= SW_HP                                    ) and 
                ( SW_TTD     <= 0     or Unit(player):TimeToDie()         <= SW_TTD      )  
            ) 
			or 
            (
                A.GetToggle(2, "ShieldWallCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- ShieldBlock
            if A.ShieldBlock:IsReadyByPassCastGCD(player) and Player:Rage() >= A.ShieldBlock:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 then  
                return A.ShieldBlock        -- #4
            end 
                
            -- ShieldWall
            return A.ShieldWall         -- #3                  
             
        end 
    end

    -- RallyingCry 
	local RallyingCry = A.GetToggle(2, "RallyingCryHP")
    if	RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
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
	
	-- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
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
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 			

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Pummel:IsReadyByPassCastGCD(unit) or not A.Pummel:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- Pummel
        if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true)  then 
            return A.Pummel
        end 
		
        if useCC and A.Shockwave:IsReady(player) and GetByRange(2, 8, true, false) and A.Shockwave:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	        -- Notification					
            Action.SendNotification("Shockwave interrupting...", A.Shockwave.ID)
            return A.Shockwave              
        end 
	
        -- Stormbolt
        if useCC and A.Stormbolt:IsReady(unit) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then
            return A.Stormbolt              
        end  
    
        -- IntimidatingShout
        if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear", 0) then 
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
end

local function EvaluateCycleAshvanesRazorCoral84(unit)
    return Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0
end

local function ThunderClapRange()
    return A.CracklingThunder:IsSpellLearned() and 12 or 8
end

local function EvaluateCycleAshvanesRazorCoral78(unit)
    return Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0
end

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
    local DBM = Action.GetToggle(1, "DBM")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
        
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
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
            
            -- potion
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- thunder_clap
            if A.ThunderClap:IsReady(unit) then
                return A.ThunderClap:Show(icon)
            end
            
            -- demoralizing_shout,if=talent.booming_voice.enabled
            if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
                return A.DemoralizingShout:Show(icon)
            end
            
            -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down&buff.memory_of_lucid_dreams.up
            if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.ShieldBlockBuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ShieldBlock:Show(icon)
            end
            
            -- shield_slam,if=buff.memory_of_lucid_dreams.up
            if A.ShieldSlam:IsReady(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ShieldSlam:Show(icon)
            end
            
            -- dragon_roar
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                return A.DragonRoar:Show(icon)
            end
            
            -- revenge
            if A.Revenge:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
            
            -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.thunder_clap.remains>=4
            if A.GrongsPrimalRage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) or A.ThunderClap:GetCooldown() >= 4) then
                return A.GrongsPrimalRage:Show(icon)
            end
            
            -- ravager
            if A.Ravager:IsReady(unit) then
                return A.Ravager:Show(icon)
            end
            
            -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down
            if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.ShieldBlockBuff.ID, true)) then
                return A.ShieldBlock:Show(icon)
            end
            
            -- shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
            
        end
        
        --St
        local function St(unit)
        
            -- thunder_clap,if=spell_targets.thunder_clap=2&talent.unstoppable_force.enabled&buff.avatar.up
            if A.ThunderClap:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) == 2 and A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff.ID, true)) then
                return A.ThunderClap:Show(icon)
            end
            
            -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down
            if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.ShieldBlockBuff.ID, true)) then
                return A.ShieldBlock:Show(icon)
            end
            
            -- shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
            
            -- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up)
            if A.ThunderClap:IsReady(unit) and ((A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff.ID, true))) then
                return A.ThunderClap:Show(icon)
            end
            
            -- demoralizing_shout,if=talent.booming_voice.enabled
            if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
                return A.DemoralizingShout:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,target_if=debuff.razor_coral_debuff.stack=0
            if A.AshvanesRazorCoral:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.AshvanesRazorCoral, 40, "min", EvaluateCycleAshvanesRazorCoral78) then
                    return A.AshvanesRazorCoral:Show(icon) 
                end
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack>7&(cooldown.avatar.remains<5|buff.avatar.up)
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 7 and (A.Avatar:GetCooldown() < 5 or Unit("player"):HasBuffs(A.AvatarBuff.ID, true))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- dragon_roar
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                return A.DragonRoar:Show(icon)
            end
            
            -- thunder_clap
            if A.ThunderClap:IsReady(unit) then
                return A.ThunderClap:Show(icon)
            end
            
            -- revenge
            if A.Revenge:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
            
            -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.shield_slam.remains>=4
            if A.GrongsPrimalRage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) or A.ShieldSlam:GetCooldown() >= 4) then
                return A.GrongsPrimalRage:Show(icon)
            end
            
            -- ravager
            if A.Ravager:IsReady(unit) then
                return A.Ravager:Show(icon)
            end
            
            -- devastate
            if A.Devastate:IsReady(unit) then
                return A.Devastate:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- intercept,if=time=0
            if A.Intercept:IsReady(unit) and (Unit("player"):CombatTime() == 0) then
                return A.Intercept:Show(icon)
            end
            
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- potion,if=buff.avatar.up|target.time_to_die<25
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.AvatarBuff.ID, true) or Unit(unit):TimeToDie() < 25) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready
            if A.IgnorePain:IsReady(unit) and (Player:RageDeficit() < 25 + 20 * num(A.BoomingVoice:IsSpellLearned()) * num(A.DemoralizingShout:GetCooldown() == 0)) then
                return A.IgnorePain:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.avatar.remains<=2
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Avatar:GetCooldown() <= 2) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=cooldown.avatar.remains<=gcd
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Avatar:GetCooldown() <= GetGCD()) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- concentrated_flame,if=buff.avatar.down&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true) and num(not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true)) > 0 or A.TheCrucibleofFlame:GetAzeriteRank() < 3) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- last_stand,if=essence.anima_of_life_and_death.major
            if A.LastStand:IsReady(unit) and (Azerite:EssenceHasMajor(A.AnimaofLifeandDeath.ID)) then
                return A.LastStand:Show(icon)
            end
            
            -- heart_essence,if=!(essence.the_crucible_of_flame.major|essence.worldvein_resonance.major|essence.anima_of_life_and_death.major|essence.memory_of_lucid_dreams.major)
            if A.HeartEssence:IsReady(unit) and (not (Azerite:EssenceHasMajor(A.TheCrucibleofFlame.ID) or Azerite:EssenceHasMajor(A.WorldveinResonance.ID) or Azerite:EssenceHasMajor(A.AnimaofLifeandDeath.ID) or Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID))) then
                return A.HeartEssence:Show(icon)
            end
            
            -- use_items,if=cooldown.avatar.remains<=gcd|buff.avatar.up
            -- avatar
            if A.Avatar:IsReady(unit) and A.BurstIsON(unit) then
                return A.Avatar:Show(icon)
            end
            
            -- run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
            if (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3) then
                return Aoe(unit);
            end
            
            -- call_action_list,name=st
            if St(unit) then
                return true
            end
            
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
--[[local function FreezingTrapUsedByEnemy()
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

