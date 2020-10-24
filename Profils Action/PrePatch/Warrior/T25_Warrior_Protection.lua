-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable                            = _G, setmetatable
local A                                         = _G.Action
local Listener                                    = Action.Listener
local Create                                    = Action.Create
local GetToggle                                    = Action.GetToggle
local SetToggle                                    = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                                = Action.GetCurrentGCD
local GetPing                                    = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                    = Action.BurstIsON
local AuraIsValid                                = Action.AuraIsValid
local InterruptIsValid                            = Action.InterruptIsValid
local FrameHasSpell                                = Action.FrameHasSpell
local Azerite                                    = LibStub("AzeriteTraits")
local Utils                                        = Action.Utils
local TeamCache                                    = Action.TeamCache
local EnemyTeam                                    = Action.EnemyTeam
local FriendlyTeam                                = Action.FriendlyTeam
local LoC                                        = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                                = Action.UnitCooldown
local Unit                                        = Action.Unit 
local IsUnitEnemy                                = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local ActiveUnitPlates                            = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARRIOR_PROTECTION] = {
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
    -- Generics
    ThunderClap                            = Action.Create({ Type = "Spell", ID = 6343 }),
    AvatarBuff                             = Action.Create({ Type = "Spell", ID = 107574, Hidden = true }),
    DemoralizingShout                      = Action.Create({ Type = "Spell", ID = 1160 }),
    BoomingVoice                           = Action.Create({ Type = "Spell", ID = 202743 }),
    LastStandBuff                          = Action.Create({ Type = "Spell", ID = 12975, Hidden = true     }),
    DragonRoar                             = Action.Create({ Type = "Spell", ID = 118000 }),
    Revenge                                = Action.Create({ Type = "Spell", ID = 6572 }),
    Ravager                                = Action.Create({ Type = "Spell", ID = 228920 }),
    ShieldBlock                            = Action.Create({ Type = "Spell", ID = 2565 }),
    ShieldSlam                             = Action.Create({ Type = "Spell", ID = 23922 }),
    ShieldBlockBuff                        = Action.Create({ Type = "Spell", ID = 132404, Hidden = true }),
    UnstoppableForce                       = Action.Create({ Type = "Spell", ID = 275336 }),
    Avatar                                 = Action.Create({ Type = "Spell", ID = 107574 }),
    Devastate                              = Action.Create({ Type = "Spell", ID = 20243 }),
    Intercept                              = Action.Create({ Type = "Spell", ID = 198304 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    IgnorePain                             = Action.Create({ Type = "Spell", ID = 190456 }),
    LastStand                              = Action.Create({ Type = "Spell", ID = 12975     }),
    ShieldWall                             = Action.Create({ Type = "Spell", ID = 871    }),
    VictoriousBuff                           = Action.Create({ Type = "Spell", ID = 32216, Hidden = true}),
    -- Utilities
    RallyingCry                               = Action.Create({ Type = "Spell", ID = 97462    }),
    VictoryRush                            = Action.Create({ Type = "Spell", ID = 34428     }),
    ImpendingVictory                       = Action.Create({ Type = "Spell", ID = 202168     }),
    HeroicThrow                            = Action.Create({ Type = "Spell", ID = 57755     }),
    Taunt                                  = Action.Create({ Type = "Spell", ID = 355     }),
    Pummel                                 = Action.Create({ Type = "Spell", ID = 6552     }),
    PummelGreen                               = Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true}), 
    IntimidatingShout                      = Action.Create({ Type = "Spell", ID = 5246     }),
    Shockwave                              = Action.Create({ Type = "Spell", ID = 46968    }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
    Stormbolt                              = Action.Create({ Type = "Spell", ID = 107570     }),
    StormboltGreen                         = Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true}),
    SpellReflection                        = Action.Create({ Type = "Spell", ID = 23920     }),
    HeroicLeap                             = Action.Create({ Type = "Spell", ID = 6544      }),
    BattleShout                            = Action.Create({ Type = "Spell", ID = 6673         }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }),  
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
    AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),     
    PotionofFocusedResolve                 = Action.Create({ Type = "Potion", ID = 168506 }),
    SuperiorBattlePotionofStrength         = Action.Create({ Type = "Potion", ID = 168500 }),
    PotionofEmpoweredProximity             = Action.Create({ Type = "Potion", ID = 168529 }),
    -- Trinkets
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314 }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624 }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905 }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305 }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576 }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224 }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614 }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568 }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617 }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866 }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572 }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311 }),
    MalformedHeraldsLegwraps               = Action.Create({ Type = "Trinket", ID = 167835 }),
    HyperthreadWristwraps                  = Action.Create({ Type = "Trinket", ID = 168989 }),
    NotoriousAspirantsBadge                = Action.Create({ Type = "Trinket", ID = 167528 }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380 }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058 }),
    SinisterAspirantsBadge                 = Action.Create({ Type = "Trinket", ID = 165223 }),
    DreadGladiatorsBadge                   = Action.Create({ Type = "Trinket", ID = 161902 }),
    DreadAspirantsBadge                    = Action.Create({ Type = "Trinket", ID = 162966 }),
    DreadCombatantsInsignia                = Action.Create({ Type = "Trinket", ID = 161676 }),
    NotoriousAspirantsMedallion            = Action.Create({ Type = "Trinket", ID = 167525 }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377 }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055 }),
    SinisterAspirantsMedallion             = Action.Create({ Type = "Trinket", ID = 165220 }),
    DreadGladiatorsMedallion               = Action.Create({ Type = "Trinket", ID = 161674 }),
    DreadAspirantsMedallion                = Action.Create({ Type = "Trinket", ID = 162897 }),
    DreadCombatantsMedallion               = Action.Create({ Type = "Trinket", ID = 161811 }),
    IgnitionMagesFuse                      = Action.Create({ Type = "Trinket", ID = 159615 }),
    TzanesBarkspines                       = Action.Create({ Type = "Trinket", ID = 161411 }),
    AzurethosSingedPlumage                = Action.Create({ Type = "Trinket", ID = 161377 }),
    AncientKnotofWisdomAlliance            = Action.Create({ Type = "Trinket", ID = 161417 }),
    AncientKnotofWisdomHorde               = Action.Create({ Type = "Trinket", ID = 166793 }),
    ShockbitersFang                        = Action.Create({ Type = "Trinket", ID = 169318 }),
    NeuralSynapseEnhancer                  = Action.Create({ Type = "Trinket", ID = 168973 }),
    BalefireBranch                         = Action.Create({ Type = "Trinket", ID = 159630 }),
    GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574 }),
    BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936 }),
    RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580 }),
    VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307 }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
    GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379 }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319 }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),    
    GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574 }),
    BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936 }),
    RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580 }),
    VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307 }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
    GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379 }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319 }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611 }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413 }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795 }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163 }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625 }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),     
    BuryTheHatchet                         = Action.Create({ Type = "Spell", ID = 280128, Hidden = true     }),     
    CracklingThunder                       = Action.Create({ Type = "Spell", ID = 203201, Hidden = true     }),     
    GrandDelusionsDebuff                   = Action.Create({ Type = "Spell", ID = 319695, Hidden = true     }), -- Corruption pet chasing you
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

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
    BigDeff                                 = {A.ShieldWall.ID},
}

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName
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

-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = math.max((Unit(player):GetDMG() * 100 / Unit(player):HealthMax()) - (Unit(player):GetHEAL() * 100 / Unit(player):HealthMax()), 0)
    local istanking = isCurrentlyTanking()
    
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
    if Player:Rage() >= A.ShieldBlock:GetSpellPowerCost() and 
    --HPLoosePerSecond >= ShieldBlockHPLost and 
    A.ShieldBlock:IsReady(player) and 
    Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and 
    --Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 and 
    --Unit(player):GetRealTimeDMG(3) > 0 and
    istanking and
    not A.LastPlayerCastName == A.ShieldBlock:Info()
    then 
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
    if    RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
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
        
        if useCC and A.Shockwave:IsReady(player) and not Unit(unit):IsBoss() and GetByRange(2, 8, true, false) and A.Shockwave:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("Shockwave interrupting...", A.Shockwave.ID)
            return A.Shockwave              
        end 
        
        -- Stormbolt
        if useCC and A.Stormbolt:IsReady(unit) and not Unit(unit):IsBoss() and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun") then
            return A.Stormbolt              
        end  
        
        -- IntimidatingShout
        if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear") then 
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
    local Pull = Action.BossMods:GetPullTimer()
    local DBM = GetToggle(1 ,"DBM")
    local Potion = GetToggle(1, "Potion")
    local Racial = GetToggle(1, "Racial")
    local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
    local offensiveRage = offensiveRage()
    local offensiveShieldBlock = offensiveShieldBlock()
    local shouldCastIp = shouldCastIp()
    local isCurrentlyTanking = isCurrentlyTanking()
    local SmartReflect = Action.GetToggle(2, "SmartReflect")
    local SmartReflectPercent = Action.GetToggle(2, "SmartReflectPercent")
    local UseCharge = GetToggle(2, "UseCharge")
    local ChargeTime = GetToggle(2, "ChargeTime")
    local UseHeroicLeap = GetToggle(2, "UseHeroicLeap") 
    local HeroicLeapTime = GetToggle(2, "HeroicLeapTime")    
    ThunderClapRange()
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        
        --Precombat
        if combatTime == 0 and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player)
            and (Pull > 0 and Pull <= 8 or not A.GetToggle(1, "BossMods"))
            then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and A.BurstIsON(unit) 
            and (Pull > 0 and Pull <= 4 or not A.GetToggle(1, "BossMods"))
            then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- guardian_of_azeroth
            --   if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and A.BurstIsON(unit) then
            --       return A.GuardianofAzeroth:Show(icon)
            --   end
            
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
            and (Pull > 0 and Pull <= 3 or not A.GetToggle(1, "BossMods"))
            then
                return A.PotionofUnbridledFury:Show(icon)
            end
            
            -- offensive Shield Block
            if not A.GetToggle(2, "UseShieldBlockDefensively") and Player:Rage() >= A.ShieldBlock:GetSpellPowerCost() and A.ShieldBlock:GetSpellCharges() > 0 and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 
            and (Pull > 0 and Pull <= 2 or not A.GetToggle(1, "BossMods"))
            --and not A.LastPlayerCastName == A.ShieldBlock:Info() 
            then
                return A.ShieldBlock:Show(icon)
            end
            
            -- Intercept
            if A.Intercept:IsReadyByPassCastGCD(unit) and not InRange(unit) and Unit(unit):GetRange() >= 8 and Unit(unit):GetRange() <= 20 and UseCharge 
            and (Pull > 0 and Pull <= 1.5 or not A.GetToggle(1, "BossMods"))
            then
                return A.Intercept:Show(icon)
            end
            
            -- devastate
            if A.Devastate:IsReady(unit) and InRange(unit) 
            and (Pull > 0 and Pull <= 1 or not A.GetToggle(1, "BossMods"))
            then
                return A.Devastate:Show(icon)
            end
            
        end
        
        -- BattleShout
        if A.BattleShout:IsReady(player) and A.BattleShout:GetSpellTimeSinceLastCast() >= 30 and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 and not A.LastPlayerCastName == A.BattleShout:Info() then
            return A.BattleShout:Show(icon)
        end  
        
        -- HeroicThrow pull with option
        if A.HeroicThrow:IsReady(unit) and Action.GetToggle(2, "HeroicThrowPull") and Unit(unit):GetRange() > 5 and Unit(unit):GetRange() <= 30 then
            return A.HeroicThrow:Show(icon)
        end
        
        if inCombat and unit ~= "mouseover" then
            -- auto_attack
            
            -- Spell Reflect Thing from Beyond
            if Unit(player):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 and Action.GetToggle(2, "ReflectThingFromBeyond") and A.SpellReflection:IsReady(player) then
                return A.SpellReflection:Show(icon)
            end
            
            -- HeroicThrow pull with option
            if A.HeroicThrow:IsReady(unit) and Action.GetToggle(2, "HeroicThrowPull") and Unit(unit):GetRange() > 5 and Unit(unit):GetRange() <= 30 and Unit(unit):CombatTime() == 0 and Unit(unit):IsExists() then
                return A.HeroicThrow:Show(icon)
            end
            
            -- Intercept
            if A.Intercept:IsReady(unit) and Unit(unit):GetRange() >= 8 and Unit(unit):GetRange() <= 20 and UseCharge and isMovingFor > ChargeTime then
                return A.Intercept:Show(icon)
            end
            
            -- run_action_list,name=movement,if=movement.distance>5
            if Unit(unit):GetRange() > 5 then
                -- heroic_leap
                if A.HeroicLeap:IsReady(unit) and UseHeroicLeap and isMovingFor > HeroicLeapTime then
                    return A.HeroicLeap:Show(icon)
                end
            end    
            
            -- Smart Reflect            
            if SmartReflect then
                local Reflect_Nameplates = MultiUnits:GetActiveUnitPlates()
                if Reflect_Nameplates then                                         
                    for Reflect_UnitID in pairs(Reflect_Nameplates) do    
                        local _, _, _, startCast, endCast, _, _, _, spellcastID = UnitCastingInfo(Reflect_UnitID)                            
                        if UnitIsUnit(Reflect_UnitID .. "target", player) and TR.Lists.ReflectID[spellcastID] and (((GetTime() * 1000) - startCast) / (endCast - startCast) * 100) > SmartReflectPercent then
                            if A.SpellReflection:IsReadyByPassCastGCD(player) then
                                return A.SpellReflection:Show(icon)
                            end
                        end     
                    end 
                end                        
            end            
            
            -- Smart Stormbolt            
            if SmartStormbolt then
                local Stormbolt_Nameplates = MultiUnits:GetActiveUnitPlates()
                if Stormbolt_Nameplates then                                         
                    for Stormbolt_UnitID in pairs(Stormbolt_Nameplates) do                            
                        for k, v in pairs(TR.Lists.Storm_Spells_List) do
                            if (TR.Lists.Storm_Unit_List[select(6, Unit(Stormbolt_UnitID):InfoGUID())] ~= nil or UnitCastingInfo(Stormbolt_UnitID) == GetSpellInfo(v) or UnitChannelInfo(Stormbolt_UnitID) == GetSpellInfo(v)) and Unit(Stormbolt_UnitID):GetRange() <= 20 then                           
                                if A.Stormbolt:IsSpellLearned() and A.Stormbolt:IsReadyByPassCastGCD(player) then
                                    return A.Stormbolt:Show(icon)
                                end
                            end
                        end    
                    end 
                end                        
            end    
            
            -- intercept,if=time=0
            --  if A.Intercept:IsReady(unit) and (Unit(player):CombatTime() == 0) then
            --      return A.Intercept:Show(icon)
            --  end
            
            
            -- offensive Shield Block
            if not A.GetToggle(2, "UseShieldBlockDefensively") and Player:Rage() >= A.ShieldBlock:GetSpellPowerCost() and A.ShieldBlock:GetSpellCharges() > 0 and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 
            --and not A.LastPlayerCastName == A.ShieldBlock:Info() 
            then
                return A.ShieldBlock:Show(icon)
            end
            
            -- VigilantProtector
            if A.VigilantProtector:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.VigilantProtector:Show(icon)
            end
            
            -- Taunt Taunt
            if A.GetToggle(2, "AutoTaunt") 
            and combatTime > 0     
            then 
                -- if not fully aggroed or we are not current target then use taunt
                if A.Taunt:IsReady(unit) and not Unit(unit):IsDummy() and not Unit(unit):IsBoss() and Unit(unit):GetRange() <= 30 and Unit(player):ThreatSituation(unit) <= 2 --and ( Unit("targettarget"):InfoGUID() ~= Unit(player):InfoGUID() ) 
                then 
                    return A.Taunt:Show(icon)
                    -- else if all good on current target, switch to another one we know we dont currently tank
                else
                    local Taunt_Nameplates = MultiUnits:GetActiveUnitPlates()
                    if Taunt_Nameplates then  
                        for Taunt_UnitID in pairs(Taunt_Nameplates) do             
                            if not UnitIsUnit("target", Taunt_UnitID) and Unit(Taunt_UnitID):CombatTime() > 0 and A.Taunt:IsReady(Taunt_UnitID) and not Unit(Taunt_UnitID):IsDummy() and not Unit(Taunt_UnitID):IsBoss() and Unit(Taunt_UnitID):GetRange() <= 30 and not Unit(Taunt_UnitID):InLOS() and Unit(player):ThreatSituation(Taunt_UnitID) <= 2 then 
                                return A:Show(icon, ACTION_CONST_AUTOTARGET)
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
            
            -- VictoryRush
            if A.VictoryRush:IsReady(unit) and not ShouldStop and
            (
                Unit(player):HealthPercent() < 80 
                or
                -- Bury The Hatchet azerite shield
                (A.BuryTheHatchet:GetAzeriteRank() > 0 and (Unit(player):HasBuffs(A.VictoriousBuff.ID, true) <= A.GetGCD() + A.GetCurrentGCD()) and Unit(player):HealthPercent() < 99)
            )
            then
                return A.VictoryRush:Show(icon)
            end
            
            -- ImpendingVictory
            if Unit(player):HealthPercent() < 80 and A.ImpendingVictory:IsReady(unit) and not ShouldStop then
                return A.ImpendingVictory:Show(icon)
            end
            
            -- demoralizing_shout defensive smart
            if A.DemoralizingShout:IsReady(player) and not Action.GetToggle(2, "DSOnCD") and Unit(unit):GetRange() < 10 and 
            (
                -- HP lose per sec >= 10
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 5 
                or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.05 
            )
            then
                return A.DemoralizingShout:Show(icon)
            end            
            
            -- demoralizing_shout on cd
            if A.DemoralizingShout:IsReady(player) and Action.GetToggle(2, "DSOnCD") and Unit(unit):GetRange() < 10 
            then
                return A.DemoralizingShout:Show(icon)
            end
            
            -- Offensive Trinkets
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end 
            
            -- use_item,name=ashvanes_razor_coral,target_if=debuff.razor_coral_debuff.stack=0
            if A.AshvanesRazorCoral:IsReady(unit) then
                if Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0 then
                    return A.AshvanesRazorCoral:Show(icon) 
                end
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack>7&(cooldown.avatar.remains<5|buff.avatar.up)
            if A.AshvanesRazorCoral:IsReady(unit) and 
            (
                Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 7 and 
                (
                    A.Avatar:GetCooldown() < 5 
                    or 
                    Unit(player):HasBuffs(A.AvatarBuff.ID, true) > 0
                )
            )
            then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_items,if=cooldown.avatar.remains<=gcd|buff.avatar.up
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_torrent
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- potion,if=buff.avatar.up|target.time_to_die<25
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(player):HasBuffs(A.AvatarBuff.ID, true) > 0 or Unit(unit):TimeToDie() < 25) then
                return A.PotionofUnbridledFury:Show(icon)
            end
            
            -- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready
            if A.IgnorePain:IsReady(unit) and (Player:RageDeficit() < 25 + 20 * num(A.BoomingVoice:IsSpellLearned()) * num(A.DemoralizingShout:GetCooldown() == 0)) and 
            shouldCastIp and 
            isCurrentlyTanking and 
            not A.LastPlayerCastName == A.IgnorePain:Info() 
            then
                return A.IgnorePain:Show(icon)
            end
            
            -- Shockwave
            if A.Shockwave:IsReady(player) and not Unit(unit):IsBoss() 
            then
                return A.Shockwave:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.avatar.remains<=2
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Avatar:GetCooldown() <= 2) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end
            
            -- concentrated_flame,if=buff.avatar.down&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and Unit(player):HasBuffsDown(A.AvatarBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- avatar
            if A.Avatar:IsReady(unit) and A.GetToggle(2, "AvatarOnCD") and A.BurstIsON(unit) and combatTime > 3 then
                return A.Avatar:Show(icon)
            end
            
            -- run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
            if GetByRange(2, 12) and A.GetToggle(2, "AoE") then
                
                -- thunder_clap
                if A.ThunderClap:IsReadyByPassCastGCD(unit, true, true, nil) and Unit(unit):GetRange() <= ThunderClapRange() then
                    return A.ThunderClap:Show(icon)
                end
                
                -- revenge
                if A.Revenge:IsReady(player) and (Player:Rage() > 60 or A.Revenge:GetSpellPowerCost() == 0) then
                    return A.Revenge:Show(icon)
                end        
                
                -- dragon_roar
                if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                    return A.DragonRoar:Show(icon)
                end            
                
                -- ravager
                if A.Ravager:IsReady(player) then
                    return A.Ravager:Show(icon)
                end
                
                -- shield_slam
                if A.ShieldSlam:IsReady(unit) then
                    return A.ShieldSlam:Show(icon)
                end
                
                
            end
        end
        
        -- thunder_clap,if=spell_targets.thunder_clap=2&talent.unstoppable_force.enabled&buff.avatar.up
        if A.ThunderClap:IsReadyByPassCastGCD(unit, true, true, nil) and Unit(unit):GetRange() <= ThunderClapRange() and (A.UnstoppableForce:IsSpellLearned() and Unit(player):HasBuffs(A.AvatarBuff.ID, true) > 0) then
            return A.ThunderClap:Show(icon)
        end                            
        
        -- shield_slam,if=buff.shield_block.up
        if A.ShieldSlam:IsReady(unit) and (Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) > 0) then
            return A.ShieldSlam:Show(icon)
        end
        
        -- anima_of_death,if=buff.last_stand.up
        if A.AnimaofDeath:IsReady(unit) and (Unit(player):HasBuffs(A.LastStandBuff.ID, true) > 0) then
            return A.AnimaofDeath:Show(icon)
        end
        
        -- shield_slam 
        if A.ShieldSlam:IsReady(unit) then
            return A.ShieldSlam:Show(icon)
        end
        
        -- thunder_clap,if=spell_targets.thunder_clap=2&talent.unstoppable_force.enabled&buff.avatar.up
        if A.ThunderClap:IsReadyByPassCastGCD(unit, true, true, nil) and Unit(unit):GetRange() <= ThunderClapRange() then
            return A.ThunderClap:Show(icon)
        end    
        
        -- revenge
        if A.Revenge:IsReady(player) and InRange(unit) and 
        (
            Player:Rage() > 60 and offensiveRage 
            or 
            A.Revenge:GetSpellPowerCost() == 0
            or
            Player:Rage() > 85
        )
        then
            return A.Revenge:Show(icon)
        end  
		
        -- ignore pain
        if A.IgnorePain:IsReady(player) and InRange(unit) and 
        (
            Player:Rage() > 70 and offensiveRage 
            or
            Player:Rage() > 95
			or
			shouldCastIp -- Predict list
            or			
            isCurrentlyTanking -- currently tanking a unit
        )
        then
            return A.IgnorePain:Show(icon)
        end            
        
        -- dragon_roar
        if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
            return A.DragonRoar:Show(icon)
        end
        
        -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.shield_slam.remains>=4
        if A.GrongsPrimalRage:IsReady(unit) and (Unit(player):HasBuffs(A.AvatarBuff.ID, true) == 0 or A.ShieldSlam:GetCooldown() >= 4) then
            return A.GrongsPrimalRage:Show(icon)
        end
        
        -- ravager
        if A.Ravager:IsReady(player) then
            return A.Ravager:Show(icon)
        end
        
        -- devastate
        if A.Devastate:IsReady(unit) and InRange(unit) then
            return A.Devastate:Show(icon)
        end
        
    end
    -- End on EnemyRotation()
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Defensives trinkets
    if Unit(player):CombatTime() > 0 and (Unit(player):HealthPercent() < 50 or Unit(player):TimeToDie() < 5) then 
        if A.Trinket1:IsReady(player) and A.Trinket1:GetItemCategory() ~= "DPS" then 
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady(player) and A.Trinket2:GetItemCategory() ~= "DPS" then 
            return A.Trinket2:Show(icon)
        end
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
    --  local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    --  local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end