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

Action[ACTION_CONST_DEMONHUNTER_VENGEANCE] = {
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
    SigilofFlame                           = Create({ Type = "Spell", ID = 204596 }),
    FieryBrand                             = Create({ Type = "Spell", ID =  }),
    InfernalStrike                         = Create({ Type = "Spell", ID = 189110 }),
    ImmolationAura                         = Create({ Type = "Spell", ID = 178740 }),
    FieryBrandDebuff                       = Create({ Type = "Spell", ID =  }),
    LifebloodBuff                          = Create({ Type = "Spell", ID = 295078 }),
    HeartEssence                           = Create({ Type = "Spell", ID = 298554 }),
    DemonSpikes                            = Create({ Type = "Spell", ID = 203720 }),
    Metamorphosis                          = Create({ Type = "Spell", ID = 191427 }),
    BulkExtraction                         = Create({ Type = "Spell", ID =  }),
    SpiritBomb                             = Create({ Type = "Spell", ID =  }),
    MetamorphosisBuff                      = Create({ Type = "Spell", ID = 162264 }),
    SoulCleave                             = Create({ Type = "Spell", ID = 228477 }),
    Felblade                               = Create({ Type = "Spell", ID = 232893 }),
    Fracture                               = Create({ Type = "Spell", ID =  }),
    Shear                                  = Create({ Type = "Spell", ID = 203782 }),
    ThrowGlaive                            = Create({ Type = "Spell", ID = 204157 }),
    ConsumeMagic                           = Create({ Type = "Spell", ID = 183752 })
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
A:CreateCovenantsFor(ACTION_CONST_DEMONHUNTER_VENGEANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_VENGEANCE], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------- VENGEANCE PRE APL SETUP ---------
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
    AuraTaunt                               = {A.Torment.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Disrupt:IsReadyByPassCastGCD(unit) or not A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick) then
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
    local EnemiesCasting = MultiUnits:GetByRangeCasting(30, 5, true, "TargetMouseover")
	
	if castRemainsTime >= A.GetLatency() then    
	
	    -- Sigil of Chains (Snare)
	    if useCC and A.SigilofChains:IsReady("player") and A.SigilofChains:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):GetRange() > 5 then 
            return A.SigilofChains              
        end 
	
	    -- Sigil of Misery (Disorient)
	    if useCC and A.SigilofMisery:IsReady("player") and EnemiesCasting > 1 and A.SigilofMisery:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.SigilofMisery              
        end 
	
	    -- Sigil of Silence (Silence)
	    if useKick and (not A.Disrupt:IsReady(unit) or EnemiesCasting > 1) and A.SigilofSilence:IsReady("player") and A.SigilofSilence:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.SigilofSilence              
        end 

	    -- Imprison    
        if useCC and A.Imprison:IsReady(unit) and not A.Disrupt:IsReady(unit) then        
	    	return A.Imprison              
        end 
	
        -- Chaos Nova    
        if useCC and A.ChaosNova:IsReady(unit) and EnemiesCasting > 1 and A.ChaosNova:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.ChaosNova              
        end 
	
	    -- Disrupt
        if useKick and A.Disrupt:IsReady(unit) and A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            return A.Disrupt
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

-- Soul Fragments function taking into consideration aura lag
local function UpdateSoulFragments()
    SoulFragments = Unit("player"):HasBuffsStacks(A.SoulFragments.ID, true)
		
    -- Casting Spirit Bomb or Soul Cleave immediately updates the buff
    if Unit("player"):GetSpellLastCast(A.SpiritBomb.ID, true) < A.GetGCD()
    or Unit("player"):GetSpellLastCast(A.SoulCleave.ID, true) < A.GetGCD() then
        SoulFragmentsAdjusted = 0
        return;
    end

    -- Check if we have cast Fracture or Shear within the last GCD and haven't "snapshot" yet
    if SoulFragmentsAdjusted == 0 then
        if A.Fracture:IsSpellLearned() then
            if Unit("player"):GetSpellLastCast(A.Fracture.ID, true) < A.GetGCD() and A.Fracture:GetSpellTimeSinceLastCast() ~= LastSoulFragmentAdjustment then
                SoulFragmentsAdjusted = math.min(SoulFragments + 2, 5)
                LastSoulFragmentAdjustment = A.Fracture:GetSpellTimeSinceLastCast()
            end
        else
            if A.Shear:GetSpellTimeSinceLastCast() < A.GetGCD() and A.Fracture.Shear ~= LastSoulFragmentAdjustment then
                SoulFragmentsAdjusted = math.min(SoulFragments + 1, 5)
                LastSoulFragmentAdjustment = A.Shear:GetSpellTimeSinceLastCast()
            end
        end
    else
        -- If we have a soul fragement "snapshot", see if we should invalidate it based on time
        if A.Fracture:IsSpellLearned() then
            if A.Fracture:GetSpellTimeSinceLastCast() >= A.GetGCD() then
                SoulFragmentsAdjusted = 0
            end
        else
            if A.Shear:GetSpellTimeSinceLastCast() >= A.GetGCD() then
                SoulFragmentsAdjusted = 0
            end
        end
    end

    -- If we have a higher Soul Fragment "snapshot", use it instead
    if SoulFragmentsAdjusted > SoulFragments then
        SoulFragments = SoulFragmentsAdjusted
    elseif SoulFragmentsAdjusted > 0 then
        -- Otherwise, the "snapshot" is invalid, so reset it if it has a value
        -- Relevant in cases where we use a generator two GCDs in a row
        SoulFragmentsAdjusted = 0
    end
end

-- Melee Is In Range w/ Movement Handlers
local function UpdateIsInMeleeRange()
    if A.Felblade:GetSpellTimeSinceLastCast() < A.GetGCD()
    or A.InfernalStrike:GetSpellTimeSinceLastCast() < A.GetGCD() then
        IsInMeleeRange = true;
        IsInAoERange = true;
        return;
    end
			
    local IsInMeleeRange = Unit("target"):GetRange() <= 5
    local IsInAoERange = IsInMeleeRange or MultiUnits:GetByRange(8, 5, 10) > 0;
end

-- Current HPS > Incoming damage
local function IsInDanger(unit)
    return Unit("player"):GetHPS() < Unit("player"):GetDMG()
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
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
        end
        
        --Brand
        local function Brand(unit)
        
            -- sigil_of_flame,if=cooldown.fiery_brand.remains<2
            if A.SigilofFlame:IsReady(unit) and (A.FieryBrand:GetCooldown() < 2) then
                return A.SigilofFlame:Show(icon)
            end
            
            -- infernal_strike,if=cooldown.fiery_brand.remains=0
            if A.InfernalStrike:IsReady(unit) and (A.FieryBrand:GetCooldown() == 0) then
                return A.InfernalStrike:Show(icon)
            end
            
            -- fiery_brand
            if A.FieryBrand:IsReady(unit) then
                return A.FieryBrand:Show(icon)
            end
            
            -- immolation_aura,if=dot.fiery_brand.ticking
            if A.ImmolationAura:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.ImmolationAura:Show(icon)
            end
            
            -- infernal_strike,if=dot.fiery_brand.ticking
            if A.InfernalStrike:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.InfernalStrike:Show(icon)
            end
            
            -- sigil_of_flame,if=dot.fiery_brand.ticking
            if A.SigilofFlame:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.SigilofFlame:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- potion
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- concentrated_flame,if=(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- heart_essence
            if A.HeartEssence:IsReady(unit) then
                return A.HeartEssence:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.memory_of_lucid_dreams.down
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):HealthPercent() < 31 or Unit(unit):TimeToDie() < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_items
        end
        
        --Defensives
        local function Defensives(unit)
        
            -- demon_spikes
            if A.DemonSpikes:IsReady(unit) then
                return A.DemonSpikes:Show(icon)
            end
            
            -- metamorphosis
            if A.Metamorphosis:IsReady(unit) then
                return A.Metamorphosis:Show(icon)
            end
            
            -- fiery_brand
            if A.FieryBrand:IsReady(unit) then
                return A.FieryBrand:Show(icon)
            end
            
        end
        
        --Normal
        local function Normal(unit)
        
            -- infernal_strike
            if A.InfernalStrike:IsReady(unit) then
                return A.InfernalStrike:Show(icon)
            end
            
            -- bulk_extraction
            if A.BulkExtraction:IsReady(unit) then
                return A.BulkExtraction:Show(icon)
            end
            
            -- spirit_bomb,if=((buff.metamorphosis.up&soul_fragments>=3)|soul_fragments>=4)
            if A.SpiritBomb:IsReady(unit) and (((Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and soul_fragments >= 3) or soul_fragments >= 4)) then
                return A.SpiritBomb:Show(icon)
            end
            
            -- soul_cleave,if=(!talent.spirit_bomb.enabled&((buff.metamorphosis.up&soul_fragments>=3)|soul_fragments>=4))
            if A.SoulCleave:IsReady(unit) and ((not A.SpiritBomb:IsSpellLearned() and ((Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and soul_fragments >= 3) or soul_fragments >= 4))) then
                return A.SoulCleave:Show(icon)
            end
            
            -- soul_cleave,if=talent.spirit_bomb.enabled&soul_fragments=0
            if A.SoulCleave:IsReady(unit) and (A.SpiritBomb:IsSpellLearned() and soul_fragments == 0) then
                return A.SoulCleave:Show(icon)
            end
            
            -- immolation_aura,if=fury<=90
            if A.ImmolationAura:IsReady(unit) and (Player:Fury() <= 90) then
                return A.ImmolationAura:Show(icon)
            end
            
            -- felblade,if=fury<=70
            if A.Felblade:IsReady(unit) and (Player:Fury() <= 70) then
                return A.Felblade:Show(icon)
            end
            
            -- fracture,if=soul_fragments<=3
            if A.Fracture:IsReady(unit) and (soul_fragments <= 3) then
                return A.Fracture:Show(icon)
            end
            
            -- sigil_of_flame
            if A.SigilofFlame:IsReady(unit) then
                return A.SigilofFlame:Show(icon)
            end
            
            -- shear
            if A.Shear:IsReady(unit) then
                return A.Shear:Show(icon)
            end
            
            -- throw_glaive
            if A.ThrowGlaive:IsReady(unit) then
                return A.ThrowGlaive:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- consume_magic
            if A.ConsumeMagic:IsReady(unit) then
                return A.ConsumeMagic:Show(icon)
            end
            
            -- call_action_list,name=brand
            if Brand(unit) then
                return true
            end
            
            -- call_action_list,name=defensives
            if Defensives(unit) then
                return true
            end
            
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
            -- call_action_list,name=normal
            if Normal(unit) then
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

