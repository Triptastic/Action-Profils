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

Action[ACTION_CONST_WARRIOR_ARMS] = {
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
    FervorofBattle                         = Create({ Type = "Spell", ID = 202316 }),
    Massacre                               = Create({ Type = "Spell", ID = 281001 }),
    RendDebuff                             = Create({ Type = "Spell", ID = 772 }),
    Rend                                   = Create({ Type = "Spell", ID = 772 }),
    Skullsplitter                          = Create({ Type = "Spell", ID = 260643 }),
    DeadlyCalmBuff                         = Create({ Type = "Spell", ID = 262228 }),
    Ravager                                = Create({ Type = "Spell", ID = 152277 }),
    ColossusSmash                          = Create({ Type = "Spell", ID = 167105 }),
    Warbreaker                             = Create({ Type = "Spell", ID = 262161 }),
    DeadlyCalm                             = Create({ Type = "Spell", ID = 262228 }),
    Bladestorm                             = Create({ Type = "Spell", ID = 227847 }),
    TestofMightBuff                        = Create({ Type = "Spell", ID = 275540 }),
    Cleave                                 = Create({ Type = "Spell", ID = 845 }),
    Slam                                   = Create({ Type = "Spell", ID = 1464 }),
    CrushingAssaultBuff                    = Create({ Type = "Spell", ID = 278826 }),
    MortalStrike                           = Create({ Type = "Spell", ID = 12294 }),
    OverpowerBuff                          = Create({ Type = "Spell", ID = 7384 }),
    Dreadnaught                            = Create({ Type = "Spell", ID = 262150 }),
    ExecutionersPrecisionBuff              = Create({ Type = "Spell", ID = 242188 }),
    Execute                                = Create({ Type = "Spell", ID = 163201 }),
    ColossusSmashDebuff                    = Create({ Type = "Spell", ID = 208086 }),
    Overpower                              = Create({ Type = "Spell", ID = 7384 }),
    SweepingStrikesBuff                    = Create({ Type = "Spell", ID = 260708 }),
    TestofMight                            = Create({ Type = "Spell", ID = 275529 }),
    DeepWoundsDebuff                       = Create({ Type = "Spell", ID = 262115 }),
    SuddenDeathBuff                        = Create({ Type = "Spell", ID = 52437 }),
    StoneHeartBuff                         = Create({ Type = "Spell", ID = 225947 }),
    SweepingStrikes                        = Create({ Type = "Spell", ID = 260708 }),
    Whirlwind                              = Create({ Type = "Spell", ID = 1680 }),
    AngerManagement                        = Create({ Type = "Spell", ID = 152278 }),
    SeismicWave                            = Create({ Type = "Spell", ID = 277639 }),
    Charge                                 = Create({ Type = "Spell", ID = 100 }),
    GuardianofAzerothBuff                  = Create({ Type = "Spell", ID =  }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    SeethingRageBuff                       = Create({ Type = "Spell", ID =  }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    Avatar                                 = Create({ Type = "Spell", ID = 107574 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
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
A:CreateCovenantsFor(ACTION_CONST_WARRIOR_ARMS)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- ARMS PRE APL SETUP ------------
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

local function InMelee(unit)
    -- @return boolean 
    return A.MortalStrike:IsInRange(unit)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function InRange(unit)
    -- @return boolean 
    return A.MortalStrike:IsInRange(unit)
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

local function UpdateExecuteID()
    Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
end

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
    if    A.StormboltGreen:IsReady(nil, nil, nil, true) and 
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
        if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
            return A.Pummel
        end 
    
        -- Stormbolt
        if useCC and A.Stormbolt:IsReady(unit) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) and Unit(unit):IsControlAble("stun", 0) then
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
end
--- ======= ACTION LISTS =======
local function APL()
        local Precombat, Execute, FiveUnit(unit), Hac, SingleUnit(unit)
  UpdateRanges()
  Everyone.AoEToggleEnemiesUpdate()
  UpdateExecuteID()
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
            
            -- memory_of_lucid_dreams,if=talent.fervor_of_battle.enabled|!talent.fervor_of_battle.enabled&target.time_to_die>150
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.FervorofBattle:IsSpellLearned() or not A.FervorofBattle:IsSpellLearned() and Unit(unit):TimeToDie() > 150) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- guardian_of_azeroth,if=talent.fervor_of_battle.enabled|talent.massacre.enabled&target.time_to_die>210|talent.rend.enabled&(target.time_to_die>210|target.time_to_die<145)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.FervorofBattle:IsSpellLearned() or A.Massacre:IsSpellLearned() and Unit(unit):TimeToDie() > 210 or A.Rend:IsSpellLearned() and (Unit(unit):TimeToDie() > 210 or Unit(unit):TimeToDie() < 145)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- potion,name=potion_of_unbridled_fury,if=essence.condensed_lifeforce.major
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- potion,name=potion_of_focused_resolve,if=essence.memory_of_lucid_dreams.major
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
        end
        
        --Execute
        local function Execute(unit)
        
            -- skullsplitter,if=rage<52&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 52 and Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.Skullsplitter:Show(icon)
            end
            
            -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            
            -- colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
            if A.ColossusSmash:IsReady(unit) and (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or A.MemoryofLucidDreams:GetCooldown() > 10)) then
                return A.ColossusSmash:Show(icon)
            end
            
            -- warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or A.MemoryofLucidDreams:GetCooldown() > 10)) then
                return A.Warbreaker:Show(icon)
            end
            
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            
            -- bladestorm,if=!buff.memory_of_lucid_dreams.up&buff.test_of_might.up&rage<30&!buff.deadly_calm.up
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) and Player:Rage() < 30 and not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true)) then
                return A.Bladestorm:Show(icon)
            end
            
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            
            -- slam,if=buff.crushing_assault.up&buff.memory_of_lucid_dreams.down
            if A.Slam:IsReady(unit) and (Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.Slam:Show(icon)
            end
            
            -- rend,if=remains<=duration*0.3&target.time_to_die>7
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration() * 0.3 and Unit(unit):TimeToDie() > 7) then
                return A.Rend:Show(icon)
            end
            
            -- mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2
            if A.MortalStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and A.Dreadnaught:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2) then
                return A.MortalStrike:Show(icon)
            end
            
            -- execute,if=buff.memory_of_lucid_dreams.up|buff.deadly_calm.up|debuff.colossus_smash.up|buff.test_of_might.up
            if A.Execute:IsReady(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.Execute:Show(icon)
            end
            
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            
            -- execute
            if A.Execute:IsReady(unit) then
                return A.Execute:Show(icon)
            end
            
        end
        
        --FiveUnit(unit)
        local function FiveUnit(unit)(unit)
        
            -- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 60 and (not A.DeadlyCalm:IsSpellLearned() or Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true))) then
                return A.Skullsplitter:Show(icon)
            end
            
            -- ravager,if=(!talent.warbreaker.enabled|cooldown.warbreaker.remains<2)
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and ((not A.Warbreaker:IsSpellLearned() or A.Warbreaker:GetCooldown() < 2)) then
                return A.Ravager:Show(icon)
            end
            
            -- colossus_smash,if=debuff.colossus_smash.down
            if A.ColossusSmash:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true)) then
                return A.ColossusSmash:Show(icon)
            end
            
            -- warbreaker,if=debuff.colossus_smash.down
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true)) then
                return A.Warbreaker:Show(icon)
            end
            
            -- bladestorm,if=buff.sweeping_strikes.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.SweepingStrikesBuff.ID, true) and (not A.DeadlyCalm:IsSpellLearned() or Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 4.5 and not A.TestofMight:GetAzeriteRank() > 0) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            
            -- cleave
            if A.Cleave:IsReady(unit) then
                return A.Cleave:Show(icon)
            end
            
            -- execute,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|(buff.sudden_death.react|buff.stone_heart.react)&(buff.sweeping_strikes.up|cooldown.sweeping_strikes.remains>8)
            if A.Execute:IsReady(unit) and ((not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or (Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true) or Unit("player"):HasBuffsStacks(A.StoneHeartBuff.ID, true)) and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) or A.SweepingStrikes:GetCooldown() > 8)) then
                return A.Execute:Show(icon)
            end
            
            -- mortal_strike,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sweeping_strikes.up&buff.overpower.stack=2&(talent.dreadnaught.enabled|buff.executioners_precision.stack=2)
            if A.MortalStrike:IsReady(unit) and ((not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) and Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and (A.Dreadnaught:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2)) then
                return A.MortalStrike:Show(icon)
            end
            
            -- whirlwind,if=debuff.colossus_smash.up|(buff.crushing_assault.up&talent.fervor_of_battle.enabled)
            if A.Whirlwind:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or (Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) and A.FervorofBattle:IsSpellLearned())) then
                return A.Whirlwind:Show(icon)
            end
            
            -- whirlwind,if=buff.deadly_calm.up|rage>60
            if A.Whirlwind:IsReady(unit) and (Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or Player:Rage() > 60) then
                return A.Whirlwind:Show(icon)
            end
            
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            
            -- whirlwind
            if A.Whirlwind:IsReady(unit) then
                return A.Whirlwind:Show(icon)
            end
            
        end
        
        --Hac
        local function Hac(unit)
        
            -- rend,if=remains<=duration*0.3&(!raid_event.adds.up|buff.sweeping_strikes.up)
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration() * 0.3 and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true))) then
                return A.Rend:Show(icon)
            end
            
            -- skullsplitter,if=rage<60&(cooldown.deadly_calm.remains>3|!talent.deadly_calm.enabled)
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 60 and (A.DeadlyCalm:GetCooldown() > 3 or not A.DeadlyCalm:IsSpellLearned())) then
                return A.Skullsplitter:Show(icon)
            end
            
            -- deadly_calm,if=(cooldown.bladestorm.remains>6|talent.ravager.enabled&cooldown.ravager.remains>6)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.DeadlyCalm:IsReady(unit) and ((A.Bladestorm:GetCooldown() > 6 or A.Ravager:IsSpellLearned() and A.Ravager:GetCooldown() > 6) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.DeadlyCalm:Show(icon)
            end
            
            -- ravager,if=(raid_event.adds.up|raid_event.adds.in>target.time_to_die)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or IncomingAddsIn > Unit(unit):TimeToDie()) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            
            -- colossus_smash,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
            if A.ColossusSmash:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or IncomingAddsIn > 40 or (IncomingAddsIn > 20 and A.AngerManagement:IsSpellLearned())) then
                return A.ColossusSmash:Show(icon)
            end
            
            -- warbreaker,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or IncomingAddsIn > 40 or (IncomingAddsIn > 20 and A.AngerManagement:IsSpellLearned())) then
                return A.Warbreaker:Show(icon)
            end
            
            -- bladestorm,if=(debuff.colossus_smash.up&raid_event.adds.in>target.time_to_die)|raid_event.adds.up&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and IncomingAddsIn > Unit(unit):TimeToDie()) or (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 4.5 and not A.TestofMight:GetAzeriteRank() > 0) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            
            -- overpower,if=!raid_event.adds.up|(raid_event.adds.up&azerite.seismic_wave.enabled)
            if A.Overpower:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) and A.SeismicWave:GetAzeriteRank() > 0)) then
                return A.Overpower:Show(icon)
            end
            
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            
            -- execute,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sudden_death.react
            if A.Execute:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or (not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true)) then
                return A.Execute:Show(icon)
            end
            
            -- mortal_strike,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)
            if A.MortalStrike:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or (not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2)) then
                return A.MortalStrike:Show(icon)
            end
            
            -- whirlwind,if=raid_event.adds.up
            if A.Whirlwind:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return A.Whirlwind:Show(icon)
            end
            
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            
            -- whirlwind,if=talent.fervor_of_battle.enabled
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned()) then
                return A.Whirlwind:Show(icon)
            end
            
            -- slam,if=!talent.fervor_of_battle.enabled&!raid_event.adds.up
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned() and not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return A.Slam:Show(icon)
            end
            
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
        
            -- skullsplitter,if=rage<56&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
            if A.Skullsplitter:IsReady(unit) and (Player:Rage() < 56 and Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.Skullsplitter:Show(icon)
            end
            
            -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            
            -- colossus_smash,if=!essence.condensed_lifeforce.enabled&!talent.massacre.enabled&(target.time_to_pct_20>10|target.time_to_die>50)|essence.condensed_lifeforce.enabled&!talent.massacre.enabled&(target.time_to_pct_20>10|target.time_to_die>80)|talent.massacre.enabled&(target.time_to_pct_35>10|target.time_to_die>50)
            if A.ColossusSmash:IsReady(unit) and (not A.CondensedLifeforce:IsSpellLearned() and not A.Massacre:IsSpellLearned() and (target.time_to_pct_20 > 10 or Unit(unit):TimeToDie() > 50) or A.CondensedLifeforce:IsSpellLearned() and not A.Massacre:IsSpellLearned() and (target.time_to_pct_20 > 10 or Unit(unit):TimeToDie() > 80) or A.Massacre:IsSpellLearned() and (target.time_to_pct_35 > 10 or Unit(unit):TimeToDie() > 50)) then
                return A.ColossusSmash:Show(icon)
            end
            
            -- warbreaker,if=!essence.condensed_lifeforce.enabled&!talent.massacre.enabled&(target.time_to_pct_20>10|target.time_to_die>50)|essence.condensed_lifeforce.enabled&!talent.massacre.enabled&(target.time_to_pct_20>10|target.time_to_die>80)|talent.massacre.enabled&(target.time_to_pct_35>10|target.time_to_die>50)
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (not A.CondensedLifeforce:IsSpellLearned() and not A.Massacre:IsSpellLearned() and (target.time_to_pct_20 > 10 or Unit(unit):TimeToDie() > 50) or A.CondensedLifeforce:IsSpellLearned() and not A.Massacre:IsSpellLearned() and (target.time_to_pct_20 > 10 or Unit(unit):TimeToDie() > 80) or A.Massacre:IsSpellLearned() and (target.time_to_pct_35 > 10 or Unit(unit):TimeToDie() > 50)) then
                return A.Warbreaker:Show(icon)
            end
            
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            
            -- execute,if=buff.sudden_death.react
            if A.Execute:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true)) then
                return A.Execute:Show(icon)
            end
            
            -- bladestorm,if=cooldown.mortal_strike.remains&debuff.colossus_smash.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.up&!azerite.test_of_might.enabled)|buff.test_of_might.up)&buff.memory_of_lucid_dreams.down&rage<40
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (A.MortalStrike:GetCooldown() and Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true) and (not A.DeadlyCalm:IsSpellLearned() or Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not A.TestofMight:GetAzeriteRank() > 0) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and Player:Rage() < 40) then
                return A.Bladestorm:Show(icon)
            end
            
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            
            -- overpower,if=(!talent.rend.enabled&dot.deep_wounds.remains&rage<70&buff.memory_of_lucid_dreams.down&debuff.colossus_smash.down)|(talent.rend.enabled&dot.deep_wounds.remains&dot.rend.remains>gcd&rage<70&buff.memory_of_lucid_dreams.down&debuff.colossus_smash.down)
            if A.Overpower:IsReady(unit) and ((not A.Rend:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) and Player:Rage() < 70 and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true)) or (A.Rend:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) and Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) > GetGCD() and Player:Rage() < 70 and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Overpower:Show(icon)
            end
            
            -- mortal_strike
            if A.MortalStrike:IsReady(unit) then
                return A.MortalStrike:Show(icon)
            end
            
            -- rend,if=remains<=duration*0.3
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration() * 0.3) then
                return A.Rend:Show(icon)
            end
            
            -- whirlwind,if=(((buff.memory_of_lucid_dreams.up)|(debuff.colossus_smash.up)|(buff.deadly_calm.up))&talent.fervor_of_battle.enabled)|((buff.memory_of_lucid_dreams.up|rage>89)&debuff.colossus_smash.up&buff.test_of_might.down&!talent.fervor_of_battle.enabled)
            if A.Whirlwind:IsReady(unit) and ((((Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) or (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) or (Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true))) and A.FervorofBattle:IsSpellLearned()) or ((Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Player:Rage() > 89) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and Unit("player"):HasBuffsDown(A.TestofMightBuff.ID, true) and not A.FervorofBattle:IsSpellLearned())) then
                return A.Whirlwind:Show(icon)
            end
            
            -- slam,if=!talent.fervor_of_battle.enabled&(buff.memory_of_lucid_dreams.up|debuff.colossus_smash.up)
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned() and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.Slam:Show(icon)
            end
            
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            
            -- whirlwind,if=talent.fervor_of_battle.enabled&(buff.test_of_might.up|debuff.colossus_smash.down&buff.test_of_might.down&rage>60)
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned() and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true) and Unit("player"):HasBuffsDown(A.TestofMightBuff.ID, true) and Player:Rage() > 60)) then
                return A.Whirlwind:Show(icon)
            end
            
            -- slam,if=!talent.fervor_of_battle.enabled
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned()) then
                return A.Slam:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end
  if Everyone.TargetIsValid() then
            -- charge
            if A.Charge:IsReady(unit) then
                return A.Charge:Show(icon)
            end
            
            -- auto_attack
            -- potion,if=(target.health.pct<21|talent.massacre.enabled&target.health.pct<36)&(buff.memory_of_lucid_dreams.up|buff.guardian_of_azeroth.up)|!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major&(target.health.pct<21|talent.massacre.enabled&target.health.pct<36)&debuff.colossus_smash.up|target.time_to_die<25
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and ((Unit(unit):HealthPercent() < 21 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 36) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true)) or not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and (Unit(unit):HealthPercent() < 21 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 36) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit(unit):TimeToDie() < 25) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- blood_fury,if=buff.memory_of_lucid_dreams.up&buff.test_of_might.up|buff.guardian_of_azeroth.up&debuff.colossus_smash.up|buff.seething_rage.up|(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major&debuff.colossus_smash.up)
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=buff.memory_of_lucid_dreams.up&buff.test_of_might.up|buff.guardian_of_azeroth.up&debuff.colossus_smash.up|buff.seething_rage.up|(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major&debuff.colossus_smash.up)
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_torrent,if=buff.memory_of_lucid_dreams.down&rage<50&(cooldown.mortal_strike.remains>gcd|(target.health.pct<20|talent.massacre.enabled&target.health.pct<35))
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and Player:Rage() < 50 and (A.MortalStrike:GetCooldown() > GetGCD() or (Unit(unit):HealthPercent() < 20 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35))) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- lights_judgment,if=debuff.colossus_smash.down&buff.memory_of_lucid_dreams.down&cooldown.mortal_strike.remains
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and A.MortalStrike:GetCooldown()) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=buff.memory_of_lucid_dreams.up&buff.test_of_might.up|buff.guardian_of_azeroth.up&debuff.colossus_smash.up|buff.seething_rage.up|(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major&debuff.colossus_smash.up)
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=buff.memory_of_lucid_dreams.up&buff.test_of_might.up|buff.guardian_of_azeroth.up&debuff.colossus_smash.up|buff.seething_rage.up|(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major&debuff.colossus_smash.up)
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks,if=debuff.colossus_smash.down&buff.memory_of_lucid_dreams.down&cooldown.mortal_strike.remains
            if A.BagofTricks:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and A.MortalStrike:GetCooldown()) then
                return A.BagofTricks:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=!debuff.razor_coral_debuff.up|((target.health.pct<20.1|talent.massacre.enabled&target.health.pct<35.1)&(buff.memory_of_lucid_dreams.up&(cooldown.memory_of_lucid_dreams.remains<106|cooldown.memory_of_lucid_dreams.remains<117&target.time_to_die<20&!talent.massacre.enabled)|buff.guardian_of_azeroth.up&debuff.colossus_smash.up))|essence.condensed_lifeforce.major&target.health.pct<20|(target.health.pct<30.1&debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major)|(!debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major&debuff.colossus_smash.up)
            if A.AshvanesRazorCoral:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) or ((Unit(unit):HealthPercent() < 20.1 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35.1) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and (A.MemoryofLucidDreams:GetCooldown() < 106 or A.MemoryofLucidDreams:GetCooldown() < 117 and Unit(unit):TimeToDie() < 20 and not A.Massacre:IsSpellLearned()) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) or Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit(unit):HealthPercent() < 20 or (Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) or (not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8)
            if A.Avatar:IsReady(unit) and A.BurstIsON(unit) and (A.ColossusSmash:GetCooldown() < 8 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 8)) then
                return A.Avatar:Show(icon)
            end
            
            -- sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled)
            if A.SweepingStrikes:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and (A.Bladestorm:GetCooldown() > 10 or A.ColossusSmash:GetCooldown() > 8 or A.TestofMight:GetAzeriteRank() > 0)) then
                return A.SweepingStrikes:Show(icon)
            end
            
            -- blood_of_the_enemy,if=(buff.test_of_might.up|(debuff.colossus_smash.up&!azerite.test_of_might.enabled))&(target.time_to_die>90|(target.health.pct<20|talent.massacre.enabled&target.health.pct<35))
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) or (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not A.TestofMight:GetAzeriteRank() > 0)) and (Unit(unit):TimeToDie() > 90 or (Unit(unit):HealthPercent() < 20 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35))) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- purifying_blast,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- focused_azerite_beam,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- reaping_flames,if=!debuff.colossus_smash.up&!buff.test_of_might.up
            if A.ReapingFlames:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true)) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- concentrated_flame,if=!debuff.colossus_smash.up&!buff.test_of_might.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- guardian_of_azeroth,if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<5&(target.time_to_die>210|(target.health.pct<20|talent.massacre.enabled&target.health.pct<35)|target.time_to_die<31)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.Warbreaker:IsSpellLearned() and A.ColossusSmash:GetCooldown() < 5 and (Unit(unit):TimeToDie() > 210 or (Unit(unit):HealthPercent() < 20 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35) or Unit(unit):TimeToDie() < 31)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- guardian_of_azeroth,if=talent.warbreaker.enabled&cooldown.warbreaker.remains<5&(target.time_to_die>210|(target.health.pct<20|talent.massacre.enabled&target.health.pct<35)|target.time_to_die<31)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 5 and (Unit(unit):TimeToDie() > 210 or (Unit(unit):HealthPercent() < 20 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35) or Unit(unit):TimeToDie() < 31)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<1&(target.time_to_die>150|(target.health.pct<20|talent.massacre.enabled&target.health.pct<35))
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.Warbreaker:IsSpellLearned() and A.ColossusSmash:GetCooldown() < 1 and (Unit(unit):TimeToDie() > 150 or (Unit(unit):HealthPercent() < 20 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35))) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=talent.warbreaker.enabled&cooldown.warbreaker.remains<1&(target.time_to_die>150|(target.health.pct<20|talent.massacre.enabled&target.health.pct<35))
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 1 and (Unit(unit):TimeToDie() > 150 or (Unit(unit):HealthPercent() < 20 or A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35))) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- run_action_list,name=hac,if=raid_event.adds.exists
            if ((MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return Hac(unit);
            end
            
            -- run_action_list,name=five_target,if=spell_targets.whirlwind>4
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) > 4) then
                return FiveUnitunit(unit);
            end
            
            -- run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
            if ((A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35) or Unit(unit):HealthPercent() < 20) then
                return Execute(unit);
            end
            
            -- run_action_list,name=single_target
            return SingleUnitunit(unit);
            
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

