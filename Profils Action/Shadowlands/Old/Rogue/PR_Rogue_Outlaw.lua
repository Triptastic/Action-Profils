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

Action[ACTION_CONST_ROGUE_OUTLAW] = {
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
                                           = Create({ Type = "Spell", ID =  })
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

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_OUTLAW)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_OUTLAW], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- OUTLAW PRE APL SETUP ----------
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


local function InRange(unit)
	-- @return boolean 
	return A.SinisterStrike:IsInRange(unit)
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

local function GetByRangeTTD(self, count, range)
    -- @return number
    local total, total_ttd = 0, 0
    
    for unit in pairs(ActiveUnitPlates) do 
        if not range or Unit(unit):CanInterract(range) then 
            total = total + 1
            total_ttd = total_ttd + Unit(unit):TimeToDie()
        end 
        
        if count and total >= count then 
            break 
        end 
    end 
    
    if total > 0 then 
        return total_ttd / total     
    else  
        return huge
    end
end 
GetByRangeTTD = A.MakeFunctionCachedDynamic(GetByRangeTTD)

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

-- APL Action Lists (and Variables)
local SappedSoulSpells = {
    {A.Kick.ID, "Cast Kick (Sapped Soul)", function () return Unit(unit):IsInRange(A.SinisterStrike); end},
    {A.Feint.ID, "Cast Feint (Sapped Soul)", function () return true; end},
    {A.CrimsonVial.ID, "Cast Crimson Vial (Sapped Soul)", function () return true; end}
};

-- Roll the bones buff list
local RtB_BuffsList = {
    
    [1] = A.Broadside.ID, 
    [2] = A.GrandMelee.ID, 
    [3] = A.BuriedTreasure.ID, 
    [4] = A.RuthlessPrecision.ID,
    [5] = A.TrueBearing.ID,
    [6] = A.SkullandCrossbones.ID
}

-- Roll the bones list on player checker
local function RtB_List (Type, List)
    if not RtB_List then 
        RtB_List = {}; 
    end
    
    if not RtB_List[Type] then 
        RtB_List[Type] = {}; 
    end
    local Sequence = table.concat(List);
    
    -- All
    if Type == "All" then
        if not RtB_List[Type][Sequence] then
            local Count = 0;
            for i = 1, #List do
                if Unit("player"):HasBuffs(RtB_BuffsList[List[i]], true) > 0 then
                    Count = Count + 1;
                end
            end
            RtB_List[Type][Sequence] = Count == #List and true or false;
        end        
        -- Any
    else
        if not RtB_List[Type][Sequence] then
            RtB_List[Type][Sequence] = false;
            for i = 1, #List do
                if Unit("player"):HasBuffs(RtB_BuffsList[List[i]], true) > 0 then
                    RtB_List[Type][Sequence] = true;
                    break;
                end
            end
        end
    end
    return RtB_List[Type][Sequence];
end

-- Roll the bones current buff remaining time
local function RtB_BuffRemains()
    local RtB_BuffRemainsDuration = 0
    for i = 1, #RtB_BuffsList do
        if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
            RtB_BuffRemainsDuration = Unit("player"):HasBuffs(RtB_BuffsList[i], true)
        end
    end

    return RtB_BuffRemainsDuration
end

-- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs()
    local RtB_Buffs = 0
    for i = 1, #RtB_BuffsList do
        if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
            RtB_Buffs = RtB_Buffs + 1
        end
    end
    return RtB_Buffs
end

-- Used to handle different UI choices and return Roll the Bones conditions
local function CheckGoodBuffs()
    local choice = Action.GetToggle(2, "RolltheBonesLogic")
    local GotGoodBuff = false
    local unit = "target"
	
    if choice == "1BUFF" then
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and RtB_Buffs() < 1 and true) or false;
    elseif choice == "MYTHICPLUS" then
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and (Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0) and not (RtB_Buffs() >= 2) and true) or false
    elseif choice == "AOESTRAT" then   
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and (Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0) and not (RtB_Buffs() >= 2) and true) or false
    elseif choice == "BROADSIDE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0 and true) or false;
    elseif choice == "BURIEDTREASURE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.BuriedTreasure.ID, true) == 0 and true) or false;
    elseif choice == "GRANDMELEE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and true) or false;
    elseif choice == "SKULLANDCROSS" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and true) or false;
    elseif choice == "RUTHLESSPRECISION" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and true) or false;
    elseif choice == "TRUEBEARING" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.TrueBearing.ID, true) == 0 and true) or false;		
	elseif choice == "AUTO" then
        if A.GetToggle(2, "AoE") and GetByRange(2, 20, false, true) and Player:AreaTTD(20) >= 4 then
            local buffsCount = RtB_Buffs()
        
            if Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) > 0 then
                buffsCount = buffsCount - 1
            end
        
            if (A.Vigor:IsSpellLearned() or A.MarkedforDeath:IsSpellLearned()) and buffsCount < 2 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 then
                GotGoodBuff = true
            end
        
            if A.DeeperStratagem:IsSpellLearned() and buffsCount < 2 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 then
                GotGoodBuff = true
            end
        
            if Unit("player"):HasBuffs(A.BladeFlurry.ID, true) == 0 and RtB_Buffs() > 0 and RtB_BuffRemains()  > 3 then
                GotGoodBuff = false
            end
			
        elseif (not A.GetToggle(2, "AoE") or GetByRange(2, 20, false, true) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() > 10 then
            if (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs() < 2 and 
			(
			    Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 
				or
                Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown()
			)
			then
                GotGoodBuff = true
			end
        elseif RtB_Buffs() < 2 and 
		(
		    Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 
			or 
			Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0
		)
		then
            GotGoodBuff = true
        end	
    -- SimC Default
    elseif choice == "SIMC" then  
        -- # Reroll for 2+ buffs with Loaded Dice up. Otherwise reroll for 2+ or Grand Melee or Ruthless Precision.
        -- actions=variable,name=rtb_reroll,value=rtb_buffs<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up)
        -- # Reroll for 2+ buffs or Broadside with Deadshot.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.deadshot.enabled,value=rtb_buffs<2&(buff.loaded_dice.up|!buff.broadside.up)
        -- # Reroll for 2+ buffs or Ruthless Precision with Ace up your Sleeve, unless there are more Deadshot ranks.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.ace_up_your_sleeve.enabled&azerite.ace_up_your_sleeve.rank>=azerite.deadshot.rank,value=rtb_buffs<2&(buff.loaded_dice.up|buff.ruthless_precision.remains<=cooldown.between_the_eyes.remains)
        -- # Always reroll for 2+ buffs with Snake Eyes.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.snake_eyes.rank>=2,value=rtb_buffs<2
        -- actions+=/variable,name=rtb_reroll,op=set,if=buff.blade_flurry.up,value=rtb_buffs-buff.skull_and_crossbones.up<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up&!buff.broadside.up)
        if Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 then
            GotGoodBuff = (RtB_Buffs() - num(Unit("player"):HasBuffs(A.BuriedTreasure.ID, true)) < 2 or RtB_BuffRemains() <= 12.6) and true or false;
        elseif Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0 then
            GotGoodBuff = (RtB_Buffs() - num(Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true)) < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
            (Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0))) and true or false;
        elseif A.SnakeEyesPower:GetAzeriteRank() >= 2 then
            GotGoodBuff = (RtB_Buffs() < 2) and true or false;
            -- # Do not reroll if Snake Eyes is at 2+ stacks of the buff (1+ stack with Broadside up)
            -- actions+=/variable,name=rtb_reroll,op=reset,if=azerite.snake_eyes.rank>=2&buff.snake_eyes.stack>=2-buff.broadside.up
            if Unit("player"):HasBuffsStacks(A.SnakeEyesBuff.ID, true) >= 2 - num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) then
                GotGoodBuff = false;
            end
        elseif A.AceUpYourSleeve:GetAzeriteRank() > 0 and A.AceUpYourSleeve:GetAzeriteRank() >= A.Deadshot:GetAzeriteRank() and Player:CritChancePct() < 42 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
            Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown())) and true or false;
        elseif A.Deadshot:GetAzeriteRank() > 0 or Player:CritChancePct() >= 42 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.Broadside.ID, true) == 0)) and true or false;
        else
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) or
            (Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0))) and true or false;
        end
    else
        return
    end
    return GotGoodBuff
end

-- Roll the Bones rerolling strategy, return true if we should reroll
local function RtB_Reroll()
    
    local RtB_Reroll = false
    
    -- Defensive Override : Grand Melee if HP < 60
    if Action.GetToggle(2, "SoloMode") and Unit("player"):HealthPercent() < Action.GetToggle(2, "RolltheBonesLeechHP") then
        RtB_Reroll = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0) and true or false;
        -- 1+ Buff
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "1BUFF" then
        RtB_Reroll = CheckGoodBuffs()
        -- Mythic+
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "MYTHICPLUS" then
        RtB_Reroll = CheckGoodBuffs()
        -- Broadside
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "AOESTRAT" and GetByRange(2, 10) or (not Unit("target"):IsBoss()) then
        RtB_Reroll = CheckGoodBuffs()
        -- Broadside
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "BROADSIDE" then
        RtB_Reroll = CheckGoodBuffs()
        -- Buried Treasure
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "BURIEDTREASURE" then
        RtB_Reroll = CheckGoodBuffs()
        -- Grand Melee
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "GRANDMELEE" then
        RtB_Reroll = CheckGoodBuffs()
        -- Skull and Crossbones
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "SKULLANDCROSS" then
        RtB_Reroll = CheckGoodBuffs()
        -- Ruthless Precision
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "RUTHLESSPRECISION" then
        RtB_Reroll = CheckGoodBuffs()
        -- True Bearing
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "TRUEBEARING" then
        RtB_Reroll = CheckGoodBuffs()
        -- SimC Default
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "SIMC" then
        RtB_Reroll = CheckGoodBuffs()
    else
        return false
    end
    return RtB_Reroll;
end

-- # Condition to use Stealth cooldowns for Ambush
local function Ambush_Condition ()
    -- actions+=/variable,name=ambush_condition,value=combo_pointA.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossboneA.up&!buff.keep_your_wits_about_you.up
    return Player:ComboPointsDeficit() >= 2 + 2 * ((A.GhostlyStrike:IsSpellLearned() and A.GhostlyStrike:GetCooldown() < 1) and 1 or 0)
    + (Unit("player"):HasBuffs(A.Broadside.ID, true) > 0 and 1 or 0) and Player:EnergyPredicted() > 60 and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and Unit("player"):HasBuffs(A.KeepYourWitsBuff.ID, true) == 0;
end

-- actions+=/variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_boneA.up
local function BtECondition ()
    return Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) > 0 or (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs() >= 1;
end

-- # With multiple targets, this variable is checked to decide whether some CDs should be synced with Blade Flurry
-- actions+=/variable,name=blade_flurry_sync,value=spell_targetA.blade_flurry<2&raid_event.addA.in>20|buff.blade_flurry.up
local function Blade_Flurry_Sync ()
    return not Action.GetToggle(2,"AoE") or GetByRange(2, 10, false, true) or Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0
end

local function EnergyTimeToMaxRounded()
    -- Round to the nearesth 10th to reduce prediction instability on very high regen rates
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

-- Marked for Death Sniping
-- Will try to get best unit to apply Marked for Death considering time to die to get cooldown reset
local BestUnit, BestUnitTTD;
local function MfDSniping (MarkedforDeath)
    local unit = "target"
    
    if MarkedforDeath:IsReady(unit) and A.MarkedforDeath:IsSpellLearned() then
        -- Get Units up to 30y for MfD.
        
        BestUnit, BestUnitTTD = nil, 60;
        local unit = "target"
        local MOunit = "mouseover"
        local MOTTD = Unit("mouseover"):GetRange() <= 30 and Unit("mouseover"):TimeToDie() or 11111;
        local TTD = Unit(unit):TimeToDie()
        
        for _, CycleUnit in pairs(MultiUnits:GetActiveUnitPlates()) do
            
            -- Note: Increased the SimC condition by 50% since we are slower.
            -- TEST - REMOVED 50% lowered value on Action
            if not Unit(CycleUnit):IsMfdBlacklisted() and TTD < Player:ComboPointsDeficit() * 1 and TTD < BestUnitTTD then
                if MOTTD - TTD > 1 then
                    BestUnit, BestUnitTTD = Unit(CycleUnit), TTD;
                else
                    BestUnit, BestUnitTTD = MouseOver, MOTTD;
                end
            end
        end
        if BestUnit and BestUnit:InfoGUID() ~= Unit(CycleUnit):InfoGUID() then
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end
    end
end


-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
    
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    -- Emergency Riposte
    local Riposte = Action.GetToggle(2, "RiposteHP")
    if     Riposte >= 0 and A.Riposte:IsReady("player") and 
    (
        (   -- Auto 
            Riposte >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Riposte < 100 and 
            Unit("player"):HealthPercent() <= Riposte
        )
    ) 
    then 
        return A.Riposte
    end  
    
    -- Emergency Feint
    local Feint = Action.GetToggle(2, "FeintHP")
    if     Feint >= 0 and A.Feint:IsReady("player") and 
    (
        (   -- Auto 
            Feint >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Feint < 100 and 
            Unit("player"):HealthPercent() <= Feint
        )
    ) 
    then 
        return A.Feint
    end          
    
    -- Emergency CrimsonVial
    local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
    if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
    (
        (   -- Auto 
            CrimsonVial >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and  
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            CrimsonVial < 100 and 
            Unit("player"):HealthPercent() <= CrimsonVial
        )
    ) 
    then 
        return A.CrimsonVial
    end          
    
    -- Emergency Cloak of Shadow
    local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
    if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
    (
        (   -- Auto 
            CloakofShadow >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            CloakofShadow < 100 and 
            Unit("player"):HealthPercent() <= CloakofShadow
        )
    ) 
    then 
        return A.CloakofShadow
    end 
    
    -- Emergency Vanish
    local Vanish = Action.GetToggle(2, "VanishDefensive")
    if     Vanish >= 0 and A.Vanish:IsReady("player") and 
    (
        (   -- Auto 
            Vanish >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Vanish < 100 and 
            Unit("player"):HealthPercent() <= Vanish
        )
    ) 
    then 
        return A.Vanish
    end  
    
    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
    
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Kick:IsReadyByPassCastGCD(unit) or not A.Kick:AbsentImun(unit, Temp.TotalAndMagKick) then
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

        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) then 
            -- Notification                    
            Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
            return A.CheapShot              
        end

        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            -- Notification                    
            Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
            return A.Kick
        end 
    
        if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) then 
            -- Notification                    
            Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
            return A.Gouge              
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
    local DBM = Action.GetToggle(1, "DBM")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

    
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- 
            if A.:IsReady(unit) then
                return A.:Show(icon)
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

