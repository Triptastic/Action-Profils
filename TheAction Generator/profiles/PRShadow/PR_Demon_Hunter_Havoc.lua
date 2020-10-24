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

Action[ACTION_CONST_DEMONHUNTER_HAVOC] = {
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
    Metamorphosis                          = Create({ Type = "Spell", ID = 191427 }),
    Demonic                                = Create({ Type = "Spell", ID = 213410 }),
    ChaoticTransformation                  = Create({ Type = "Spell", ID = 288754 }),
    EyeBeam                                = Create({ Type = "Spell", ID = 198013 }),
    BladeDance                             = Create({ Type = "Spell", ID = 188499 }),
    SinfulBrand                            = Create({ Type = "Spell", ID =  }),
    SinfulBrandDebuff                      = Create({ Type = "Spell", ID =  }),
    TheHunt                                = Create({ Type = "Spell", ID =  }),
    FodderTotheFlame                       = Create({ Type = "Spell", ID =  }),
    ElysianDecree                          = Create({ Type = "Spell", ID =  }),
    MetamorphosisBuff                      = Create({ Type = "Spell", ID = 162264 }),
    FelBarrage                             = Create({ Type = "Spell", ID = 258925 }),
    FelRush                                = Create({ Type = "Spell", ID = 195072 }),
    UnboundChaos                           = Create({ Type = "Spell", ID =  }),
    UnboundChaosBuff                       = Create({ Type = "Spell", ID =  }),
    DeathSweep                             = Create({ Type = "Spell", ID = 210152 }),
    GlaiveTempest                          = Create({ Type = "Spell", ID =  }),
    ThrowGlaive                            = Create({ Type = "Spell", ID = 185123 }),
    ExposedWoundDebuff                     = Create({ Type = "Spell", ID =  }),
    RevolvingBlades                        = Create({ Type = "Spell", ID = 279581 }),
    ImmolationAura                         = Create({ Type = "Spell", ID = 258920 }),
    Annihilation                           = Create({ Type = "Spell", ID = 201427 }),
    Felblade                               = Create({ Type = "Spell", ID = 232893 }),
    ChaosStrike                            = Create({ Type = "Spell", ID = 162794 }),
    DemonBlades                            = Create({ Type = "Spell", ID = 203555 }),
    DemonsBite                             = Create({ Type = "Spell", ID = 162243 }),
    BurningWoundDebuff                     = Create({ Type = "Spell", ID =  }),
    VengefulRetreat                        = Create({ Type = "Spell", ID = 198793 }),
    EssenceBreak                           = Create({ Type = "Spell", ID =  }),
    EssenceBreakDebuff                     = Create({ Type = "Spell", ID =  }),
    CyclingVariable                        = Create({ Type = "Spell", ID =  }),
    BreathoftheDying                       = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    Momentum                               = Create({ Type = "Spell", ID = 206476 }),
    PreparedBuff                           = Create({ Type = "Spell", ID = 203650 }),
    BlindFury                              = Create({ Type = "Spell", ID = 203550 }),
    FirstBlood                             = Create({ Type = "Spell", ID = 206416 }),
    TrailofRuin                            = Create({ Type = "Spell", ID = 258881 }),
    MomentumBuff                           = Create({ Type = "Spell", ID = 208628 }),
    Disrupt                                = Create({ Type = "Spell", ID = 183752 }),
    PickUpFragment                         = Create({ Type = "Spell", ID =  }),
    EyesofRage                             = Create({ Type = "Spell", ID = 278500 }),
    FelBombardmentBuff                     = Create({ Type = "Spell", ID =  }),
    ImmolationAuraBuff                     = Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_HAVOC)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_HAVOC], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolingForMeta = 0;
local VarBladeDance = 0;
local VarPoolingForBladeDance = 0;
local VarPoolingForEyeBeam = 0;
local VarFelBarrageSync = 0;
local VarWaitingForMomentum = 0;
local VarReapingDelay = 0;
local VarWaitingForEssenceBreak = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolingForMeta = 0
  VarBladeDance = 0
  VarPoolingForBladeDance = 0
  VarPoolingForEyeBeam = 0
  VarFelBarrageSync = 0
  VarWaitingForMomentum = 0
  VarReapingDelay = 0
  VarWaitingForEssenceBreak = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- HAVOC PRE APL SETUP ------------
------------------------------------------

local player                                    = "player"
local PartyUnits
local Temp                                        = {
    TotalAndPhys                                = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                            = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                            = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                            = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                    = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                    = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                                    = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                                    = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit    

local function InMelee(unit)
    -- @return boolean 
    return A.ChaosStrike:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InMelee(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end 
        end 
    end
end  

local function num(val)
    if val then return 1 else return 0 end
end

-- EyeBeam Handler UI --
local function HandleEyeBeam()
    local choice = A.GetToggle(2, "EyeBeamMode")
    --print(choice) 
    local unit = "target"
    -- CDs ON
    if choice[1] then 
        return BurstIsON(unit) or false 
        -- AoE Only
    elseif choice[2] then
        -- also checks CDs
        if choice[1] then
            return (BurstIsON(unit) and GetByRange(2, 8) and A.GetToggle(2, "AoE")) or false
        else
            return (GetByRange(2, 8) and A.GetToggle(2, "AoE")) or false
        end
        -- Everytime
    elseif choice[3] then
        return A.EyeBeam:IsReady(unit) or false
    else
        return false
    end        
end

-- FelRush handler
local function UseMoves()
    return Action.GetToggle(2, "UseMoves") --or S.FelRush:Charges() == 2  
end


-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    Action.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 7 and 
    A.ChaosNovaGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.ChaosNovaGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not Action.IsUnitEnemy("mouseover") and 
            not Action.IsUnitEnemy("target") and                     
            (
                (Action.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not Action.IsInPvP and GetByRange(1, 5))
            )
        )
    )
    then 
        return A.ChaosNovaGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if Action.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif Action.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            -- Disrupt
            if not notKickAble and A.DisruptGreen:IsReady(unit, nil, nil, true) and A.DisruptGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.DisruptGreen:Show(icon)                                                  
            end 
            
            -- Imprison
            if A.Imprison:IsReady(unit, nil, nil, true) and A.Imprison:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
                return A.Imprison:Show(icon)                  
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

-- Multidot Handler UI --
local function HandleDarkness()
    local choice = Action.GetToggle(2, "DarknessMode")
    
    if choice == "In Raid" then
        if IsInRaid() then
            return true
        else
            return false
        end
    elseif choice == "In Dungeon" then 
        if IsInGroup() then
            return true
        else
            return false
        end
    elseif choice == "In PvP" then     
        if A.IsInPvP then 
            return true
        else
            return false
        end        
    elseif choice == "Everywhere" then 
        return true
    else
        return false
    end
    --print(choice)
end

-- Fel Blade UI --
local function HandleFelBlade()
    local choice = Action.GetToggle(2, "FelBladeMode")
    
    if choice == "AUTO" then
        -- Add protection for raid
        if not IsInRaid() then
            return true
            -- IF in Raid but in range of current target.
        elseif IsInRaid() and InMelee(unit) then
            return true
        else
            return false
        end
    elseif choice == "PVP" then 
        if A.IsInPvP then 
            return true
        end    
    else
        return false
    end
    
end

-- Auto Darkness Handler
local function CanDarkness()
    if A.Darkness:IsReady(player) then 
        -- Darkness
        local AutoDarkness = A.GetToggle(2, "AutoDarkness")
        local DarknessUnits = A.GetToggle(2, "DarknessUnits")
        local DarknessUnitsHP = A.GetToggle(2, "DarknessUnitsHP")    
        local DarknessUnitsTTD = A.GetToggle(2, "DarknessUnitsTTD")
        local totalMembers = HealingEngine.GetMembersAll()
		
        -- Auto Counter
        if DarknessUnits > 1 then 
            DarknessUnits = HealingEngine.GetMinimumUnits(1)
            -- Reduce size in raid by 20%
            if DarknessUnits > 5 then 
                DarknessUnits = DarknessUnits - (#totalMembers * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif DarknessUnits >= TeamCache.Friendly.Size then 
            DarknessUnits = TeamCache.Friendly.Size
        end 
        
        if DarknessUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if DarknessUnitsHP >= 100 and totalMembers[i].HP <= 30 then 
                counter = counter + 1
            end 
            
            -- Auto TTD 
            if DarknessUnitsTTD >= 100 and Unit(totalMembers[i].Unit):TimeToDie() <= 5 then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if DarknessUnitsHP < 100 and totalMembers[i].HP <= DarknessUnitsHP then 
                counter = counter + 1
            end
            
            -- Custom TTD 
            if DarknessUnitsTTD < 100 and Unit(totalMembers[i].Unit):TimeToDie() <= DarknessUnitsTTD then 
                counter = counter + 1
            end             
            
            if counter >= DarknessUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanDarkness = A.MakeFunctionCachedStatic(CanDarkness)

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
    
    -- Darkness
    if   AutoDarkness and HandleDarkness and CanDarkness() then 
        -- Notification                    
        Action.SendNotification("Defensive Darkness", A.Darkness.ID)
        return A.Darkness
    end
    
    -- Netherwalk
    local Netherwalk = A.GetToggle(2, "Netherwalk")
    if     Netherwalk >= 0 and A.Netherwalk:IsReady(player) and 
    (
        (     -- Auto 
            Netherwalk >= 100 and 
            (
                -- HP lose per sec >= 10
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
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
        ) or 
        (    -- Custom
            Netherwalk < 100 and 
            Unit(player):HealthPercent() <= Netherwalk
        )
    ) 
    then 
        -- Notification                    
        Action.SendNotification("Defensive Netherwalk", A.Netherwalk.ID)
        return A.Netherwalk
    end
    
    -- Blur
    local Blur = A.GetToggle(2, "Blur")
    if     Blur >= 0 and A.Blur:IsReady(player) and 
    (
        (     -- Auto 
            Blur >= 100 and 
            (
                -- HP lose per sec >= 10
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
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
        ) or 
        (    -- Custom
            Blur < 100 and 
            Unit(player):HealthPercent() <= Blur
        )
    ) 
    then 
        -- Notification                    
        Action.SendNotification("Defensive Blur", A.Blur.ID)
        return A.Blur
    end
    
    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
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
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
    
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

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
    
	if castRemainsTime >= A.GetLatency() then
        -- Disrupt
        if useKick and not notInterruptable and A.Disrupt:IsReady(unit) then 
            return A.Disrupt
        end

        -- Fel Eruption
        if useCC and A.FelEruption:IsSpellLearned() and A.FelEruption:IsReady(unit) and GetByRange(1, 20) and A.FelEruption:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CC : Fel Eruption", A.FelEruption.ID)
            return A.FelEruption              
        end 
    
        -- Chaos Nova    
        if useCC and A.ChaosNova:IsReady(unit) and GetByRange(2, 10) and A.ChaosNova:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CC : Chaos Nova", A.ChaosNova.ID)        
            return A.ChaosNova              
        end 
    
        -- Imprison    
        if useCC and A.Imprison:IsReady(unit) and A.GetToggle(2, "ImprisonAsInterrupt") then 
            -- Notification                    
            Action.SendNotification("CC : Imprison", A.Imprison.ID)        
            return A.Imprison              
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

-- ExpectedCombatLength
local function ExpectedCombatLength()
    local BossTTD = 0
    if not A.IsInPvP then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() then 
                BossTTD = Unit("boss" .. i):TimeToDie()
            end 
        end 
    end 
    return BossTTD
end 
ExpectedCombatLength = A.MakeFunctionCachedStatic(ExpectedCombatLength)

local profileStop = false

local function ShouldDelayEyeBeam()
	local CurrentChannelTime = Action.GetSpellDescription(198013)[3]
		
    -- Check for M+ Quake Affix
    if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= CurrentChannelTime + A.GetGCD() then
        return true
    end
end

local function ShouldDelayFelBarrage()
	local CurrentChannelTime = Action.GetSpellDescription(258925)[3]
		
    -- Check for M+ Quake Affix
    if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= CurrentChannelTime + A.GetGCD() then
        return true
    end
end

local function ShouldDelayFocusedAzeriteBeam()
    local CurrentCastTime = Unit("player"):CastTime(295258)
	local CurrentChannelTime = Action.GetSpellDescription(295258)[2]
		
    -- Check for M+ Quake Affix
    if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= CurrentCastTime + CurrentChannelTime + A.GetGCD() then
        return true
    end
end

local function EvaluateTargetIfFilterDemonsBite148(unit)
  return Unit(unit):HasDeBuffs(A.BurningWoundDebuff.ID, true)
end

local function EvaluateTargetIfDemonsBite157(unit)
  return runeforge.burning_wound.equipped and Unit(unit):HasDeBuffs(A.BurningWoundDebuff.ID, true) < 4
end


local function EvaluateCycleReapingFlames290(unit)
    return Unit(unit):TimeToDie() < 1.5 or ((Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or VarReapingDelay > 29)) or (target.time_to_pct_20 > 30 and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or VarReapingDelay > 44))
end

local function EvaluateTargetIfFilterDemonsBite424(unit)
  return Unit(unit):HasDeBuffs(A.BurningWoundDebuff.ID, true)
end

local function EvaluateTargetIfDemonsBite433(unit)
  return runeforge.burning_wound.equipped and Unit(unit):HasDeBuffs(A.BurningWoundDebuff.ID, true) < 4
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
        
        --Cooldown
        local function Cooldown(unit)
        
            -- metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta)|target.time_to_die<25
            if A.Metamorphosis:IsReady(unit) and (not (A.Demonic:IsSpellLearned() or VarPoolingForMeta) or Unit(unit):TimeToDie() < 25) then
                return A.Metamorphosis:Show(icon)
            end
            
            -- metamorphosis,if=talent.demonic.enabled&(!azerite.chaotic_transformation.enabled|(cooldown.eye_beam.remains>20&(!variable.blade_dance|cooldown.blade_dance.remains>gcd.max)))
            if A.Metamorphosis:IsReady(unit) and (A.Demonic:IsSpellLearned() and (not A.ChaoticTransformation:GetAzeriteRank() > 0 or (A.EyeBeam:GetCooldown() > 20 and (not VarBladeDance or A.BladeDance:GetCooldown() > GetGCD())))) then
                return A.Metamorphosis:Show(icon)
            end
            
            -- sinful_brand,if=!dot.sinful_brand.ticking
            if A.SinfulBrand:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.SinfulBrandDebuff.ID, true)) then
                return A.SinfulBrand:Show(icon)
            end
            
            -- the_hunt
            if A.TheHunt:IsReady(unit) then
                return A.TheHunt:Show(icon)
            end
            
            -- fodder_to_the_flame
            if A.FodderTotheFlame:IsReady(unit) then
                return A.FodderTotheFlame:Show(icon)
            end
            
            -- elysian_decree
            if A.ElysianDecree:IsReady(unit) then
                return A.ElysianDecree:Show(icon)
            end
            
            -- potion,if=buff.metamorphosis.remains>25|target.time_to_die<60
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 25 or Unit(unit):TimeToDie() < 60) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=!talent.fel_barrage.enabled|cooldown.fel_barrage.ready
            if A.GalecallersBoon:IsReady(unit) and (not A.FelBarrage:IsSpellLearned() or A.FelBarrage:GetCooldown() == 0) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.metamorphosis.up&buff.memory_of_lucid_dreams.down&(!variable.blade_dance|!cooldown.blade_dance.ready)
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and (not VarBladeDance or not A.BladeDance:GetCooldown() == 0)) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(debuff.conductive_ink_debuff.up|buff.metamorphosis.remains>20)&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or (Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 20) and Unit(unit):HealthPercent() < 31 or Unit(unit):TimeToDie() < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=cooldown.metamorphosis.remains<10|cooldown.metamorphosis.remains>60
            if A.AzsharasFontofPower:IsReady(unit) and (A.Metamorphosis:GetCooldown() < 10 or A.Metamorphosis:GetCooldown() > 60) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_items,if=buff.metamorphosis.up
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
        end
        
        --Demonic
        local function Demonic(unit)
        
            -- fel_rush,if=(talent.unbound_chaos.enabled&buff.unbound_chaos.up)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if A.FelRush:IsReady(unit) and ((A.UnboundChaos:IsSpellLearned() and Unit("player"):HasBuffs(A.UnboundChaosBuff.ID, true)) and (A.FelRush:GetSpellCharges() == 2 or (IncomingAddsIn > 10 and IncomingAddsIn > 10))) then
                return A.FelRush:Show(icon)
            end
            
            -- death_sweep,if=variable.blade_dance
            if A.DeathSweep:IsReady(unit) and (VarBladeDance) then
                return A.DeathSweep:Show(icon)
            end
            
            -- glaive_tempest,if=active_enemies>desired_targets|raid_event.adds.in>10
            if A.GlaiveTempest:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or IncomingAddsIn > 10) then
                return A.GlaiveTempest:Show(icon)
            end
            
            -- throw_glaive,if=conduit.serrated_glaive.enabled&cooldown.eye_beam.remains<6&!buff.metamorphosis.up&!debuff.exposed_wound.up
            if A.ThrowGlaive:IsReady(unit) and (conduit.serrated_glaive.enabled and A.EyeBeam:GetCooldown() < 6 and not Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and not Unit(unit):HasDeBuffs(A.ExposedWoundDebuff.ID, true)) then
                return A.ThrowGlaive:Show(icon)
            end
            
            -- eye_beam,if=raid_event.adds.up|raid_event.adds.in>25
            if A.EyeBeam:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(20, 5, 10) > 1) or IncomingAddsIn > 25) then
                return A.EyeBeam:Show(icon)
            end
            
            -- blade_dance,if=variable.blade_dance&!cooldown.metamorphosis.ready&(cooldown.eye_beam.remains>(5-azerite.revolving_blades.rank*3)|(raid_event.adds.in>cooldown&raid_event.adds.in<25))
            if A.BladeDance:IsReady(unit) and (VarBladeDance and not A.Metamorphosis:GetCooldown() == 0 and (A.EyeBeam:GetCooldown() > (5 - A.RevolvingBlades:GetAzeriteRank() * 3) or (IncomingAddsIn > cooldown and IncomingAddsIn < 25))) then
                return A.BladeDance:Show(icon)
            end
            
            -- immolation_aura
            if A.ImmolationAura:IsReady(unit) then
                return A.ImmolationAura:Show(icon)
            end
            
            -- annihilation,if=!variable.pooling_for_blade_dance
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and (not VarPoolingForBladeDance) then
                return A.Annihilation:Show(icon)
            end
            
            -- felblade,if=fury.deficit>=40
            if A.Felblade:IsReady(unit) and (Player:FuryDeficit() >= 40) then
                return A.Felblade:Show(icon)
            end
            
            -- chaos_strike,if=!variable.pooling_for_blade_dance&!variable.pooling_for_eye_beam
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and (not VarPoolingForBladeDance and not VarPoolingForEyeBeam) then
                return A.ChaosStrike:Show(icon)
            end
            
            -- fel_rush,if=talent.demon_blades.enabled&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if A.FelRush:IsReady(unit) and (A.DemonBlades:IsSpellLearned() and not A.EyeBeam:GetCooldown() == 0 and (A.FelRush:GetSpellCharges() == 2 or (IncomingAddsIn > 10 and IncomingAddsIn > 10))) then
                return A.FelRush:Show(icon)
            end
            
            -- demons_bite,target_if=min:debuff.burning_wound.remains,if=runeforge.burning_wound.equipped&debuff.burning_wound.remains<4
            if A.DemonsBite:IsReady(unit) and IsInMeleeRange() then
                if Action.Utils.CastTargetIf(A.DemonsBite, 40, "min", EvaluateTargetIfFilterDemonsBite148, EvaluateTargetIfDemonsBite157) then 
                    return A.DemonsBite:Show(icon) 
                end
            end
            -- demons_bite
            if A.DemonsBite:IsReady(unit) and IsInMeleeRange() then
                return A.DemonsBite:Show(icon)
            end
            
            -- throw_glaive,if=buff.out_of_range.up
            if A.ThrowGlaive:IsReady(unit) and (Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true)) then
                return A.ThrowGlaive:Show(icon)
            end
            
            -- fel_rush,if=movement.distance>15|buff.out_of_range.up
            if A.FelRush:IsReady(unit) and (Unit(unit):GetRange() > 15 or Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true)) then
                return A.FelRush:Show(icon)
            end
            
            -- vengeful_retreat,if=movement.distance>15
            if A.VengefulRetreat:IsReady(unit) and (Unit(unit):GetRange() > 15) then
                return A.VengefulRetreat:Show(icon)
            end
            
            -- throw_glaive,if=talent.demon_blades.enabled
            if A.ThrowGlaive:IsReady(unit) and (A.DemonBlades:IsSpellLearned()) then
                return A.ThrowGlaive:Show(icon)
            end
            
        end
        
        --EssenceBreak
        local function EssenceBreak(unit)
        
            -- essence_break,if=fury>=80&(cooldown.blade_dance.ready|!variable.blade_dance)
            if A.EssenceBreak:IsReady(unit) and (Player:Fury() >= 80 and (A.BladeDance:GetCooldown() == 0 or not VarBladeDance)) then
                return A.EssenceBreak:Show(icon)
            end
            
            -- death_sweep,if=variable.blade_dance&debuff.essence_break.up
            if A.DeathSweep:IsReady(unit) and (VarBladeDance and Unit(unit):HasDeBuffs(A.EssenceBreakDebuff.ID, true)) then
                return A.DeathSweep:Show(icon)
            end
            
            -- blade_dance,if=variable.blade_dance&debuff.essence_break.up
            if A.BladeDance:IsReady(unit) and (VarBladeDance and Unit(unit):HasDeBuffs(A.EssenceBreakDebuff.ID, true)) then
                return A.BladeDance:Show(icon)
            end
            
            -- annihilation,if=debuff.essence_break.up
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and (Unit(unit):HasDeBuffs(A.EssenceBreakDebuff.ID, true)) then
                return A.Annihilation:Show(icon)
            end
            
            -- chaos_strike,if=debuff.essence_break.up
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and (Unit(unit):HasDeBuffs(A.EssenceBreakDebuff.ID, true)) then
                return A.ChaosStrike:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- variable,name=fel_barrage_sync,if=talent.fel_barrage.enabled,value=cooldown.fel_barrage.ready&(((!talent.demonic.enabled|buff.metamorphosis.up)&!variable.waiting_for_momentum&raid_event.adds.in>30)|active_enemies>desired_targets)
            if (A.FelBarrage:IsSpellLearned()) then
                VarFelBarrageSync = num(A.FelBarrage:GetCooldown() == 0 and (((not A.Demonic:IsSpellLearned() or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true)) and not VarWaitingForMomentum and IncomingAddsIn > 30) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1))
            end
            
            -- concentrated_flame,if=(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- blood_of_the_enemy,if=(!talent.fel_barrage.enabled|cooldown.fel_barrage.remains>45)&!variable.waiting_for_momentum&((!talent.demonic.enabled|buff.metamorphosis.up&!cooldown.blade_dance.ready)|target.time_to_die<=10)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((not A.FelBarrage:IsSpellLearned() or A.FelBarrage:GetCooldown() > 45) and not VarWaitingForMomentum and ((not A.Demonic:IsSpellLearned() or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and not A.BladeDance:GetCooldown() == 0) or Unit(unit):TimeToDie() <= 10)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- blood_of_the_enemy,if=talent.fel_barrage.enabled&variable.fel_barrage_sync
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.FelBarrage:IsSpellLearned() and VarFelBarrageSync) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth,if=(buff.metamorphosis.up&cooldown.metamorphosis.ready)|buff.metamorphosis.remains>25|target.time_to_die<=30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and A.Metamorphosis:GetCooldown() == 0) or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 25 or Unit(unit):TimeToDie() <= 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.metamorphosis.up|variable.fel_barrage_sync
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) or VarFelBarrageSync) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=fury<40&buff.metamorphosis.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:Fury() < 40 and Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
            if A.CyclingVariable:IsReady(unit) and (Azerite:EssenceHasMajor(A.BreathoftheDying.ID)) then
                return A.CyclingVariable:Show(icon) = math.min(return A.CyclingVariable:Show(icon), Unit(unit):TimeToDie())
            end
            
            -- reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(target.time_to_pct_20>30&(active_enemies=1|variable.reaping_delay>44))
            if A.ReapingFlames:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ReapingFlames, 40, "min", EvaluateCycleReapingFlames290) then
                    return A.ReapingFlames:Show(icon) 
                end
            end
        end
        
        --Normal
        local function Normal(unit)
        
            -- vengeful_retreat,if=talent.momentum.enabled&buff.prepared.down&time>1
            if A.VengefulRetreat:IsReady(unit) and (A.Momentum:IsSpellLearned() and Unit("player"):HasBuffsDown(A.PreparedBuff.ID, true) and Unit("player"):CombatTime() > 1) then
                return A.VengefulRetreat:Show(icon)
            end
            
            -- fel_rush,if=(variable.waiting_for_momentum|talent.unbound_chaos.enabled&buff.unbound_chaos.up)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if A.FelRush:IsReady(unit) and ((VarWaitingForMomentum or A.UnboundChaos:IsSpellLearned() and Unit("player"):HasBuffs(A.UnboundChaosBuff.ID, true)) and (A.FelRush:GetSpellCharges() == 2 or (IncomingAddsIn > 10 and IncomingAddsIn > 10))) then
                return A.FelRush:Show(icon)
            end
            
            -- fel_barrage,if=active_enemies>desired_targets|raid_event.adds.in>30
            if A.FelBarrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or IncomingAddsIn > 30) then
                return A.FelBarrage:Show(icon)
            end
            
            -- death_sweep,if=variable.blade_dance
            if A.DeathSweep:IsReady(unit) and (VarBladeDance) then
                return A.DeathSweep:Show(icon)
            end
            
            -- immolation_aura
            if A.ImmolationAura:IsReady(unit) then
                return A.ImmolationAura:Show(icon)
            end
            
            -- glaive_tempest,if=!variable.waiting_for_momentum&(active_enemies>desired_targets|raid_event.adds.in>10)
            if A.GlaiveTempest:IsReady(unit) and (not VarWaitingForMomentum and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or IncomingAddsIn > 10)) then
                return A.GlaiveTempest:Show(icon)
            end
            
            -- throw_glaive,if=conduit.serrated_glaive.enabled&cooldown.eye_beam.remains<6&!buff.metamorphosis.up&!debuff.exposed_wound.up
            if A.ThrowGlaive:IsReady(unit) and (conduit.serrated_glaive.enabled and A.EyeBeam:GetCooldown() < 6 and not Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and not Unit(unit):HasDeBuffs(A.ExposedWoundDebuff.ID, true)) then
                return A.ThrowGlaive:Show(icon)
            end
            
            -- eye_beam,if=active_enemies>1&(!raid_event.adds.exists|raid_event.adds.up)&!variable.waiting_for_momentum
            if A.EyeBeam:IsReady(unit) and (MultiUnits:GetByRangeInCombat(20, 5, 10) > 1 and (not (MultiUnits:GetByRangeInCombat(20, 5, 10) > 1) or (MultiUnits:GetByRangeInCombat(20, 5, 10) > 1)) and not VarWaitingForMomentum) then
                return A.EyeBeam:Show(icon)
            end
            
            -- blade_dance,if=variable.blade_dance
            if A.BladeDance:IsReady(unit) and (VarBladeDance) then
                return A.BladeDance:Show(icon)
            end
            
            -- felblade,if=fury.deficit>=40
            if A.Felblade:IsReady(unit) and (Player:FuryDeficit() >= 40) then
                return A.Felblade:Show(icon)
            end
            
            -- eye_beam,if=!talent.blind_fury.enabled&!variable.waiting_for_essence_break&raid_event.adds.in>cooldown
            if A.EyeBeam:IsReady(unit) and (not A.BlindFury:IsSpellLearned() and not VarWaitingForEssenceBreak and IncomingAddsIn > cooldown) then
                return A.EyeBeam:Show(icon)
            end
            
            -- annihilation,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance&!variable.waiting_for_essence_break
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and ((A.DemonBlades:IsSpellLearned() or not VarWaitingForMomentum or Player:FuryDeficit() < 30 or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) < 5) and not VarPoolingForBladeDance and not VarWaitingForEssenceBreak) then
                return A.Annihilation:Show(icon)
            end
            
            -- chaos_strike,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30)&!variable.pooling_for_meta&!variable.pooling_for_blade_dance&!variable.waiting_for_essence_break
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and ((A.DemonBlades:IsSpellLearned() or not VarWaitingForMomentum or Player:FuryDeficit() < 30) and not VarPoolingForMeta and not VarPoolingForBladeDance and not VarWaitingForEssenceBreak) then
                return A.ChaosStrike:Show(icon)
            end
            
            -- eye_beam,if=talent.blind_fury.enabled&raid_event.adds.in>cooldown
            if A.EyeBeam:IsReady(unit) and (A.BlindFury:IsSpellLearned() and IncomingAddsIn > cooldown) then
                return A.EyeBeam:Show(icon)
            end
            
            -- demons_bite,target_if=min:debuff.burning_wound.remains,if=runeforge.burning_wound.equipped&debuff.burning_wound.remains<4
            if A.DemonsBite:IsReady(unit) and IsInMeleeRange() then
                if Action.Utils.CastTargetIf(A.DemonsBite, 40, "min", EvaluateTargetIfFilterDemonsBite424, EvaluateTargetIfDemonsBite433) then 
                    return A.DemonsBite:Show(icon) 
                end
            end
            -- demons_bite
            if A.DemonsBite:IsReady(unit) and IsInMeleeRange() then
                return A.DemonsBite:Show(icon)
            end
            
            -- fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10&talent.demon_blades.enabled
            if A.FelRush:IsReady(unit) and (not A.Momentum:IsSpellLearned() and IncomingAddsIn > A.FelRush:GetSpellCharges() * 10 and A.DemonBlades:IsSpellLearned()) then
                return A.FelRush:Show(icon)
            end
            
            -- felblade,if=movement.distance>15|buff.out_of_range.up
            if A.Felblade:IsReady(unit) and (Unit(unit):GetRange() > 15 or Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true)) then
                return A.Felblade:Show(icon)
            end
            
            -- fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
            if A.FelRush:IsReady(unit) and (Unit(unit):GetRange() > 15 or (Unit("player"):HasBuffs(A.OutofRangeBuff.ID, true) and not A.Momentum:IsSpellLearned())) then
                return A.FelRush:Show(icon)
            end
            
            -- vengeful_retreat,if=movement.distance>15
            if A.VengefulRetreat:IsReady(unit) and (Unit(unit):GetRange() > 15) then
                return A.VengefulRetreat:Show(icon)
            end
            
            -- throw_glaive,if=talent.demon_blades.enabled
            if A.ThrowGlaive:IsReady(unit) and (A.DemonBlades:IsSpellLearned()) then
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
            -- variable,name=blade_dance,value=talent.first_blood.enabled|spell_targets.blade_dance1>=(3-talent.trail_of_ruin.enabled)
            VarBladeDance = num(A.FirstBlood:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) >= (3 - num(A.TrailofRuin:IsSpellLearned())))
            
            -- variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30
            VarPoolingForMeta = num(not A.Demonic:IsSpellLearned() and A.Metamorphosis:GetCooldown() < 6 and Player:FuryDeficit() > 30)
            
            -- variable,name=pooling_for_blade_dance,value=variable.blade_dance&(fury<75-talent.first_blood.enabled*20)
            VarPoolingForBladeDance = num(VarBladeDance and (Player:Fury() < 75 - num(A.FirstBlood:IsSpellLearned()) * 20))
            
            -- variable,name=pooling_for_eye_beam,value=talent.demonic.enabled&!talent.blind_fury.enabled&cooldown.eye_beam.remains<(gcd.max*2)&fury.deficit>20
            VarPoolingForEyeBeam = num(A.Demonic:IsSpellLearned() and not A.BlindFury:IsSpellLearned() and A.EyeBeam:GetCooldown() < (GetGCD() * 2) and Player:FuryDeficit() > 20)
            
            -- variable,name=waiting_for_essence_break,value=talent.essence_break.enabled&!variable.pooling_for_blade_dance&!variable.pooling_for_meta&cooldown.essence_break.up
            VarWaitingForEssenceBreak = num(A.EssenceBreak:IsSpellLearned() and not VarPoolingForBladeDance and not VarPoolingForMeta and A.EssenceBreak:GetCooldown() == 0)
            
            -- variable,name=waiting_for_momentum,value=talent.momentum.enabled&!buff.momentum.up
            VarWaitingForMomentum = num(A.Momentum:IsSpellLearned() and not Unit("player"):HasBuffs(A.MomentumBuff.ID, true))
            
            -- disrupt
            if A.Disrupt:IsReady(unit) then
                return A.Disrupt:Show(icon)
            end
            
            -- call_action_list,name=cooldown,if=gcd.remains=0
            if (GetCurrentGCD() == 0) then
                if Cooldown(unit) then
                    return true
                end
            end
            
            -- pick_up_fragment,if=demon_soul_fragments>0
            if A.PickUpFragment:IsReady(unit) and (demon_soul_fragments > 0) then
                return A.PickUpFragment:Show(icon)
            end
            
            -- pick_up_fragment,if=fury.deficit>=35&(!azerite.eyes_of_rage.enabled|cooldown.eye_beam.remains>1.4)
            if A.PickUpFragment:IsReady(unit) and (Player:FuryDeficit() >= 35 and (not A.EyesofRage:GetAzeriteRank() > 0 or A.EyeBeam:GetCooldown() > 1.4)) then
                return A.PickUpFragment:Show(icon)
            end
            
            -- throw_glaive,if=buff.fel_bombardment.stack=5&(buff.immolation_aura.up|!buff.metamorphosis.up)
            if A.ThrowGlaive:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.FelBombardmentBuff.ID, true) == 5 and (Unit("player"):HasBuffs(A.ImmolationAuraBuff.ID, true) or not Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true))) then
                return A.ThrowGlaive:Show(icon)
            end
            
            -- call_action_list,name=essence_break,if=talent.essence_break.enabled&(variable.waiting_for_essence_break|debuff.essence_break.up)
            if (A.EssenceBreak:IsSpellLearned() and (VarWaitingForEssenceBreak or Unit(unit):HasDeBuffs(A.EssenceBreakDebuff.ID, true))) then
                if EssenceBreak(unit) then
                    return true
                end
            end
            
            -- run_action_list,name=demonic,if=talent.demonic.enabled
            if (A.Demonic:IsSpellLearned()) then
                return Demonic(unit);
            end
            
            -- run_action_list,name=normal
            return Normal(unit);
            
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

