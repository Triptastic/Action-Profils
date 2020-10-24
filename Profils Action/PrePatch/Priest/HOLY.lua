-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local HealingEngine                             = Action.HealingEngine
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")
local A                         			    = _G.Action
local Listener                                  = Action.Listener
local Create                                    = Action.Create
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
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local strElemBuilder     = Action.strElemBuilder
local tableexist, pairs, setmetatable, unpack = tableexist, pairs, setmetatable, unpack
local GetTotemInfo, GetSpellInfo, GetNetStats, GetInventoryItemID = GetTotemInfo, GetSpellInfo, GetNetStats, GetInventoryItemID
local UnitExists, UnitIsPlayer, UnitClass, UnitCreatureType, UnitInRange, UnitInRaid, UnitInParty, UnitGUID, UnitPower, UnitPowerMax = 
UnitExists, UnitIsPlayer, UnitClass, UnitCreatureType, UnitInRange, UnitInRaid, UnitInParty, UnitGUID, UnitPower, UnitPowerMax

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_PRIEST_HOLY] = {
    -- Racial
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                 = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                             = Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                               = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                               = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                 = Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                               = Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                         = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                        = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
	-- Healing Spells
	Heal                                      = Create({ Type = "Spell", ID = 2060, predictName = "Heal"    }),
	FlashHeal                                 = Create({ Type = "Spell", ID = 2061, predictName = "FlashHeal"    }),
	Renew                                     = Create({ Type = "Spell", ID = 139, predictName = "Renew"    }),
	HolyWordSerenity                          = Create({ Type = "Spell", ID = 2050, predictName = "HolyWordSerenity"    }),
	HolyWordSanctify                          = Create({ Type = "Spell", ID = 34861, predictName = "HolyWordSanctify"    }),
	PrayerofHealing                           = Create({ Type = "Spell", ID = 596, predictName = "PrayerofHealing"    }),
	PrayerofMending                           = Create({ Type = "Spell", ID = 33076, predictName = "PrayerofMending"    }),
	PrayerOfMendingHoT                        = Create({ Type = "Spell", ID = 33076, Hidden = true, predictName = "PrayerOfMendingHoT"    }), -- needed for PredictHeal predict name
	DivineHymn                                = Create({ Type = "Spell", ID = 64843, predictName = "DivineHymn"    }), -- Burst CD
	-- Damage Spells
    HolyWordChastise                          = Create({ Type = "Spell", ID = 88625    }),
	Smite                                     = Create({ Type = "Spell", ID = 585    }),
	HolyNova                                  = Create({ Type = "Spell", ID = 132157, predictName = "HolyNova"    }),
	HolyFire                                  = Create({ Type = "Spell", ID = 14914    }),	
	-- Talents
    AngelicFeather                            = Create({ Type = "Spell", ID = 121536    }),	
    HolyWordSalvation                         = Create({ Type = "Spell", ID = 265202    }),	
	Halo                                      = Create({ Type = "Spell", ID = 120517, predictName = "Halo"    }),	
	Apotheosis                                = Create({ Type = "Spell", ID = 200183, predictName = "Apotheosis"    }),	
	CircleofHealing                           = Create({ Type = "Spell", ID = 204883, predictName = "CircleOfHealing"    }),	
    ShiningForce                              = Create({ Type = "Spell", ID = 204263    }),	
    BindingHeal                               = Create({ Type = "Spell", ID = 32546, predictName = "BindingHeal"    }),	
	TrailofLight                              = Create({ Type = "Spell", ID = 200128    }),	
	GuardianAngel                             = Create({ Type = "Spell", ID = 200209    }),	
	SurgeofLight                              = Create({ Type = "Spell", ID = 109186    }),
    CosmicRipple                              = Create({ Type = "Spell", ID = 238136    }),	
    Censure                                   = Create({ Type = "Spell", ID = 200199    }),	
	DivineStar                                = Create({ Type = "Spell", ID = 110744    }),	
	PsychicVoice                              = Create({ Type = "Spell", ID = 196704    }),	
	EnduringRenewal                           = Create({ Type = "Spell", ID = 200153    }),
    LightoftheNaaru                           = Create({ Type = "Spell", ID = 196985    }),	
    Afterlife                                 = Create({ Type = "Spell", ID = 196707    }),	
	Benediction                               = Create({ Type = "Spell", ID = 193157    }),	
	AngelsMercy                               = Create({ Type = "Spell", ID = 238100    }),	
	PrayerCircle                              = Create({ Type = "Spell", ID = 321377    }),    
	Perseverance                              = Create({ Type = "Spell", ID = 235189    }),	
    -- PvP
	RayofHope                                 = Create({ Type = "Spell", ID = 197268    }),
	RapidMending                              = Create({ Type = "Spell", ID = 196559    }),
	MiracleWorker                             = Create({ Type = "Spell", ID = 235587    }),
	HolyWordConcentration                     = Create({ Type = "Spell", ID = 289657    }),
	HolyWard                                  = Create({ Type = "Spell", ID = 213610    }),
	GreaterHeal                               = Create({ Type = "Spell", ID = 289666, predictName = "GreaterHeal"    }),
	CardinalMending                           = Create({ Type = "Spell", ID = 328529    }),
	SpiritoftheRedeemer                       = Create({ Type = "Spell", ID = 215982    }),		
	-- Utilities
	SymbolofHope                              = Create({ Type = "Spell", ID = 64901    }),
	Fade                                      = Create({ Type = "Spell", ID = 586    }),
	DispelMagic                               = Create({ Type = "Spell", ID = 528    }),
	GuardianSpirit                            = Create({ Type = "Spell", ID = 47788    }),
	LeapofFaith                               = Create({ Type = "Spell", ID = 73325    }),
	MindControl                               = Create({ Type = "Spell", ID = 605    }),
	MassDispel                                = Create({ Type = "Spell", ID = 32375    }),
	SpiritofRedemption                        = Create({ Type = "Spell", ID = 20711    }),
    MassResurrection	                      = Create({ Type = "Spell", ID = 212036    }),
	Resurrection   	                          = Create({ Type = "Spell", ID = 2006    }),
	Purify          	                      = Create({ Type = "Spell", ID = 527    }),
	PowerWordFortitude                        = Create({ Type = "Spell", ID = 21562}),
	-- Buffs 
	SurgeofLightBuff                          = Create({ Type = "Spell", ID = 114255, Hidden = true     }),	
    -- Items
    PotionofUnbridledFury                     = Create({ Type = "Potion",  ID = 169299 }), 
    -- Hidden 
    PoolResource                              = Create({ Type = "Spell", ID = 97238, Hidden = true}),
    Channeling                                = Create({ Type = "Spell", ID = 209274, Hidden = true}),    
    EchoingBlades                             = Create({ Type = "Spell", ID = 287649, Hidden = true}), -- Simcraft Azerite
    -- Items
    PotionofReconstitution                    = Create({ Type = "Potion", ID = 168502     }),     
    CoastalManaPotion                         = Create({ Type = "Potion", ID = 152495     }), 
    -- Hidden 
    PoolResource                              = Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    DummyTest                                 = Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon    
    --Mythic Plus Spells 
    Quake                                     = Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
    Burst                                     = Create({ Type = "Spell", ID = 240443, Hidden = true     }), -- Bursting (Mythic Plus Affix) Upon death the creature Bursts, inflicting damage equal to (35 / 10)% of maximum health every 1 sec.
    GrievousWound                             = Create({ Type = "Spell", ID = 240559, Hidden = true     }), -- Grievous (Mythic Plus Affix) 2% of a player's maximum health every 3 sec
    Slow                                      = Create({ Type = "Spell", ID = 313255, Hidden = true     }), -- Shadhar slow
    Fixate                                    = Create({ Type = "Spell", ID = 318078, Hidden = true     }), -- Wrathion Fixate
}

Action:CreateEssencesFor(ACTION_CONST_PRIEST_HOLY)
local A = setmetatable(Action[ACTION_CONST_PRIEST_HOLY], { __index = Action })

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
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"

-- Call to avoid lua limit of 60upvalues 
-- Call RotationsVariables in each function that need these vars
local function RotationsVariables()
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	MouseOver = GetToggle(2, "mouseover")
    -- ProfileUI vars
	UseRotationPassive = GetToggle(2, "UseRotationPassive")
	ManaManagement = GetToggle(2, "ManaManagement")
	ManaPotion = GetToggle(2, "ManaPotion")
	StopCastOverHeal = GetToggle(2, "StopCastOverHeal")
	StartByPreCast = GetToggle(2, "StartByPreCast")
	SniperFriendly = GetToggle(2, "SniperFriendly")
	AutoDispel = GetToggle(2, "AutoDispel")
	MythicPlusLogic = GetToggle(2, "MythicPlusLogic")
	StopCastOverHeal = GetToggle(2, "StopCastOverHeal")
	StopCastQuake = GetToggle(2, "StopCastQuake")
	StopCastQuakeSec = GetToggle(2, "StopCastQuakeSec")
	RacialBurstHealing = GetToggle(2, "RacialBurstHealing")
	RacialBurstDamaging = GetToggle(2, "RacialBurstDamaging")
	TrinketBurstSyncUP = GetToggle(2, "TrinketBurstSyncUP")
	TrinketMana = GetToggle(2, "TrinketMana")
	TrinketBurstHealing = GetToggle(2, "TrinketBurstHealing")
	LucidDreamManaPercent = GetToggle(2, "LucidDreamManaPercent")
	LifeBindersInvocationUnits = GetToggle(2, "LifeBindersInvocationUnits")
	LifeBindersInvocationHP = GetToggle(2, "LifeBindersInvocationHP")
    GuardianSpiritSelfDeff = GetToggle(2, "GuardianSpiritSelfDeff")
	GuardianSpiritTeamDeff = GetToggle(2, "GuardianSpiritTeamDeff")
	RenewRefresh  = GetToggle(2, "RenewRefresh")
	
	
end

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

-- [1] CC AntiFake Rotation
--local function AntiFakeStun(unit) 


       
--end 
--A[1] = function(icon)

                                        
--end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy(mouseover) then 
        unit = mouseover
    elseif A.IsUnitEnemy(target) then 
        unit = target
    elseif A.IsUnitEnemy(targettarget) then 
        unit = targettarget
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     

            
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

-- Mana Management
local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID, true) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit(player):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)


local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    	
    -- Stoneform on defensive
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP(player, nil, nil, true) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit(player):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit(player):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end     
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:AutoRacial(player, true, nil, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = Action.MakeFunctionCachedDynamic(SelfDefensives)

-- Interrupts
local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")         
    
    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, true) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, true) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, true) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, true) then 
        return A.BullRush
    end      
    
end 
Interrupts = Action.MakeFunctionCachedDynamic(Interrupts)

local function GetMobsBySpell(count, spellId, reaction)
	if reaction == "friendly" then 
		return 0
	end 
    return MultiUnits:GetBySpell(spellId, count)
end

local function GetMobsByRange(count, range, reaction)
	if reaction == "friendly" then 
		return 0
	end 
    return MultiUnits:GetByRange(range)
end

local function AoE(count, num, reaction) 
    if not reaction  then reaction = "enemy" end  
    if not num 	 then num = 40 end 
	
	local units 
	if num <= ACTION_CONST_CACHE_DEFAULT_NAMEPLATE_MAX_DISTANCE then
		units = GetMobsByRange(count, num, reaction)
	else 
		units = GetMobsBySpell(count, num, reaction)
	end                         
               
    if not count then
        return units or 0
    else
        return units and units >= count
    end    
end

-- Return valid members that can be healed
--@parameter IsPlayer : return only members that are real players
local function GetValidMembers(IsPlayer)
    local HealingEngineMembersALL = A.HealingEngine.GetMembersAll()
    if not IsPlayer then 
        return #HealingEngineMembersALL
    else 
        local total = 0 
        if #HealingEngineMembersALL > 0 then 
            for i = 1, #HealingEngineMembersALL do
                if Unit(HealingEngineMembersALL[i].Unit):IsPlayer() then
                    total = total + 1
                end
            end 
        end 
        return total 
    end 
end

function FriendlyTeam:GetLastTimeDMGX(x, range)
    -- @return number, number, number
    -- [1] Average received damage latest 'x' seconds 
    -- [2] Summary received damage latest 'x' seconds 
    -- [3] Count of members valid for conditions
    -- Nill-able: range
    local ROLE                            = self.ROLE
    local lastDMG, members                = 0, 0
    local member
    
    if TeamCacheFriendly.Size <= 1 then 
        if Unit(player):Role(ROLE) then  
            lastDMG = Unit(player):GetLastTimeDMGX(x)
            return lastDMG, 1     
        end 
        
        return lastDMG, members
    end         
    
    if ROLE and TeamCacheFriendly[ROLE] then 
        for member in pairs(TeamCacheFriendly[ROLE]) do
            if Unit(member):InRange() and (not range or Unit(member):GetRange() <= range) then
                lastDMG = lastDMG + Unit(member):GetLastTimeDMGX(x)   
                members = members + 1
            end             
        end             
    else
        for i = 1, TeamCacheFriendly.MaxSize do
            member = TeamCacheFriendlyIndexToPLAYERs[i]                
            if member and Unit(member):InRange() and (not range or Unit(member):GetRange() <= range) then
                lastDMG = lastDMG + Unit(member):GetLastTimeDMGX(x)   
                members = members + 1
            end 
        end  
        
        if TeamCacheFriendly.Type ~= "raid" then
            lastDMG = lastDMG + Unit(player):GetLastTimeDMGX(x)  
            members = members + 1
        end 
    end      
    
    if lastDMG == 0 and members == 0 then 
        return 0, lastDMG, members
    else 
        return lastDMG / members, lastDMG, members
    end 
end

local function noDamageCheck(unit)
    if isChecked("Dont DPS spotter") and GetObjectID(unit) == 135263 then
        return true
    end
    if isCC(unit) then
        return true
    end
    if isCasting(302415, unit) then
        -- emmisary teleporting home
        return true
    end

    if hasBuff(263246, unit) then
        -- shields on first boss in temple
        return true
    end
    if hasBuff(260189, unit) then
        -- shields on last boss in MOTHERLODE
        return true
    end
    if hasBuff(261264, unit) or hasBuff(261265, unit) or hasBuff(261266, unit) then
        -- shields on witches in wm
        return true
    end

    if GetObjectID(thisUnit) == 155432 then
        --emmisaries to punt, dealt with seperately
        return true
    end
    return false --catchall
end
noDamageCheck = Action.MakeFunctionCachedDynamic(noDamageCheck)

local StunsBlackList = {
    -- Atal'Dazar
    [87318] = "Dazar'ai Colossus",
    [122984] = "Dazar'ai Colossus",
    [128455] = "T'lonja",
    [129553] = "Dinomancer Kish'o",
    [129552] = "Monzumi",
    -- Freehold
    [129602] = "Irontide Enforcer",
    [130400] = "Irontide Crusher",
    -- King's Rest
    [133935] = "Animated Guardian",
    [134174] = "Shadow-Borne Witch Doctor",
    [134158] = "Shadow-Borne Champion",
    [137474] = "King Timalji",
    [137478] = "Queen Wasi",
    [137486] = "Queen Patlaa",
    [137487] = "Skeletal Hunting Raptor",
    [134251] = "Seneschal M'bara",
    [134331] = "King Rahu'ai",
    [137484] = "King A'akul",
    [134739] = "Purification Construct",
    [137969] = "Interment Construct",
    [135231] = "Spectral Brute",
    [138489] = "Shadow of Zul",
    -- Shrine of the Storm
    [134144] = "Living Current",
    [136214] = "Windspeaker Heldis",
    [134150] = "Runecarver Sorn",
    [136249] = "Guardian Elemental",
    [134417] = "Deepsea Ritualist",
    [136353] = "Colossal Tentacle",
    [136295] = "Sunken Denizen",
    [136297] = "Forgotten Denizen",
    -- Siege of Boralus
    [129369] = "Irontide Raider",
    [129373] = "Dockhound Packmaster",
    [128969] = "Ashvane Commander",
    [138255] = "Ashvane Spotter",
    [138465] = "Ashvane Cannoneer",
    [135245] = "Bilge Rat Demolisher",
    -- Temple of Sethraliss
    [134991] = "Sandfury Stonefist",
    [139422] = "Scaled Krolusk Tamer",
    [136076] = "Agitated Nimbus",
    [134691] = "Static-charged Dervish",
    [139110] = "Spark Channeler",
    [136250] = "Hoodoo Hexer",
    [139946] = "Heart Guardian",
    -- MOTHERLODE!!
    [130485] = "Mechanized Peacekeeper",
    [136139] = "Mechanized Peacekeeper",
    [136643] = "Azerite Extractor",
    [134012] = "Taskmaster Askari",
    [133430] = "Venture Co. Mastermind",
    [133463] = "Venture Co. War Machine",
    [133436] = "Venture Co. Skyscorcher",
    [133482] = "Crawler Mine",
    -- Underrot
    [131436] = "Chosen Blood Matron",
    [133912] = "Bloodsworn Defiler",
    [138281] = "Faceless Corruptor",
    -- Tol Dagor
    [130025] = "Irontide Thug",
    -- Waycrest Manor
    [131677] = "Heartsbane Runeweaver",
    [135329] = "Matron Bryndle",
    [131812] = "Heartsbane Soulcharmer",
    [131670] = "Heartsbane Vinetwister",
    [135365] = "Matron Alma",
}

local precast_spell_list = {
    --spell_id	, precast_time	,	spell_name
    { 214652, 5, 'Acidic Fragments' },
    { 205862, 5, 'Slam' },
    { 259832, 1.5, 'Massive Glaive - Stormbound Conqueror (Warport Wastari, Zuldazar, for testing purpose only)' },
    { 218774, 5, 'Summon Plasma Spheres' },
    { 206949, 5, 'Frigid Nova' },
    { 206517, 5, 'Fel Nova' },
    { 207720, 5, 'Witness the Void' },
    { 206219, 5, 'Liquid Hellfire' },
    { 211439, 5, 'Will of the Demon Within' },
    { 209270, 5, 'Eye of Guldan' },
    { 227071, 5, 'Flame Crash' },
    { 233279, 5, 'Shattering Star' },
    { 233441, 5, 'Bone Saw' },
    { 235230, 5, 'Fel Squall' },
    { 231854, 5, 'Unchecked Rage' },
    { 232174, 5, 'Frosty Discharge' },
    { 230139, 5, 'Hydra Shot' },
    { 233264, 5, 'Embrace of the Eclipse' },
    { 236542, 5, 'Sundering Doom' },
    { 236544, 5, 'Doomed Sundering' },
    { 235059, 5, 'Rupturing Singularity' },
    { 288693, 3, 'Tormented Soul - Grave Bolt (Reaping affix)' },
    { 262347, 5, 'Static Pulse' },
    { 302420, 5, 'Queen\'s Decree: Hide' },
    { 260333, 7, 'Tantrum - Underrot 2nd boss' },
    { 255577, 5, 'Transfusion' }, -- https://www.wowhead.com/spell=255577/transfusion
    { 259732, 5, 'Festering Harvest' }, --https://www.wowhead.com/spell=259732/festering-harvest
    { 285388, 5, 'Vent Jets' }, --https://www.wowhead.com/spell=285388/vent-jets
    { 291626, 3, 'Cutting Beam' }, --https://www.wowhead.com/spell=291626/cutting-beam
    { 300207, 3, 'shock-coil' }, -- https://www.wowhead.com/spell=300207/shock-coil
    { 297261, 5, 'rumble' }, -- https://www.wowhead.com/spell=297261/rumble
    { 262347, 5, 'pulse' }, --https://www.wowhead.com/spell=262347/static-pulse
}
--end of dbm list

local DebuffSniperList = {

    --junkyard
    { spellID = 298669, stacks = 0, secs = 1 }, -- Taze
    -- Uldir
    { spellID = 262313, stacks = 0, secs = 5 }, -- Malodorous Miasma
    { spellID = 262314, stacks = 0, secs = 3 }, -- Putrid Paroxysm
    { spellID = 264382, stacks = 0, secs = 1 }, -- Eye Beam
    { spellID = 264210, stacks = 0, secs = 5 }, -- Jagged Mandible
    { spellID = 265360, stacks = 0, secs = 5 }, -- Roiling Deceit
    { spellID = 265129, stacks = 0, secs = 5 }, -- Omega Vector
    { spellID = 266948, stacks = 0, secs = 5 }, -- Plague Bomb
    { spellID = 274358, stacks = 0, secs = 5 }, -- Rupturing Blood
    { spellID = 274019, stacks = 0, secs = 1 }, -- Mind Flay
    { spellID = 272018, stacks = 0, secs = 1 }, -- Absorbed in Darkness
    { spellID = 273359, stacks = 0, secs = 5 }, -- Shadow Barrage
    -- Freehold
    { spellID = 257437, stacks = 0, secs = 5 }, -- Poisoning Strike
    { spellID = 267523, stacks = 0, secs = 5 }, -- Cutting Surge
    { spellID = 256363, stacks = 0, secs = 5 }, -- Ripper Punch
    -- Shrine of the Storm
    { spellID = 264526, stacks = 0, secs = 5 }, -- Grasp from the Depths
    { spellID = 264166, stacks = 0, secs = 1 }, -- Undertow
    { spellID = 268214, stacks = 0, secs = 1 }, -- Carve Flesh
    { spellID = 276297, stacks = 0, secs = 5 }, -- Void Seed
    { spellID = 268322, stacks = 0, secs = 5 }, -- Touch of the Drowned
    -- Siege of Boralus
    { spellID = 256897, stacks = 0, secs = 5 }, -- Clamping Jaws
    { spellID = 273470, stacks = 0, secs = 3 }, -- Gut Shot
    { spellID = 275014, stacks = 0, secs = 5 }, -- Putrid Waters
    -- Tol Dagor
    { spellID = 258058, stacks = 0, secs = 1 }, -- Squeeze
    { spellID = 260016, stacks = 0, secs = 3 }, -- Itchy Bite
    { spellID = 260067, stacks = 0, secs = 5 }, -- Vicious Mauling
    { spellID = 258864, stacks = 0, secs = 5 }, -- Suppression Fire
    { spellID = 258917, stacks = 0, secs = 3 }, -- Righteous Flames
    { spellID = 256198, stacks = 0, secs = 5 }, -- Azerite Rounds: Incendiary
    { spellID = 256105, stacks = 0, secs = 1 }, -- Explosive Burst
    -- Waycrest Manor
    { spellID = 266035, stacks = 0, secs = 1 }, -- Bone Splinter
    { spellID = 260703, stacks = 0, secs = 1 }, -- Unstable Runic Mark
    { spellID = 260741, stacks = 0, secs = 1 }, -- Jagged Nettles
    { spellID = 264050, stacks = 0, secs = 3 }, -- Infected Thorn
    { spellID = 264556, stacks = 0, secs = 2 }, -- Tearing Strike
    { spellID = 264150, stacks = 0, secs = 1 }, -- Shatter
    { spellID = 265761, stacks = 0, secs = 1 }, -- Thorned Barrage
    { spellID = 263905, stacks = 0, secs = 1 }, -- Marking Cleave
    { spellID = 264153, stacks = 0, secs = 3 }, -- Spit
    { spellID = 278456, stacks = 0, secs = 3 }, -- Infest
    { spellID = 271178, stacks = 0, secs = 3 }, -- Ravaging Leap
    { spellID = 265880, stacks = 0, secs = 1 }, -- Dread Mark
    { spellID = 265882, stacks = 0, secs = 1 }, -- Lingering Dread
    { spellID = 264378, stacks = 0, secs = 5 }, -- Fragment Soul
    { spellID = 261438, stacks = 0, secs = 1 }, -- Wasting Strike
    { spellID = 261440, stacks = 0, secs = 1 }, -- Virulent Pathogen
    { spellID = 268202, stacks = 0, secs = 1 }, -- Death Lens
    -- Atal'Dazar
    { spellID = 253562, stacks = 0, secs = 3 }, -- Wildfire
    { spellID = 254959, stacks = 0, secs = 2 }, -- Soulburn
    { spellID = 255558, stacks = 0, secs = 5 }, -- Tainted Blood
    { spellID = 255814, stacks = 0, secs = 5 }, -- Rending Maul
    { spellID = 250372, stacks = 0, secs = 5 }, -- Lingering Nausea
    { spellID = 250096, stacks = 0, secs = 1 }, -- Wracking Pain
    { spellID = 256577, stacks = 0, secs = 5 }, -- Soulfeast
    -- King's Rest
    { spellID = 269932, stacks = 0, secs = 3 }, -- Gust Slash
    { spellID = 265773, stacks = 0, secs = 4 }, -- Spit Gold
    { spellID = 270084, stacks = 0, secs = 3 }, -- Axe Barrage
    { spellID = 270865, stacks = 0, secs = 3 }, -- Hidden Blade
    { spellID = 270289, stacks = 0, secs = 3 }, -- Purification Beam
    { spellID = 271564, stacks = 0, secs = 3 }, -- Embalming
    { spellID = 267618, stacks = 0, secs = 3 }, -- Drain Fluids
    { spellID = 270487, stacks = 0, secs = 3 }, -- Severing Blade
    { spellID = 270507, stacks = 0, secs = 5 }, -- Poison Barrage
    { spellID = 266231, stacks = 0, secs = 3 }, -- Severing Axe
    { spellID = 267273, stacks = 0, secs = 3 }, -- Poison Nova
    { spellID = 268419, stacks = 0, secs = 3 }, -- Gale Slash
    -- MOTHERLODE!!
    { spellID = 269298, stacks = 0, secs = 1 }, -- Widowmaker
    { spellID = 262347, stacks = 0, secs = 1 }, -- Static Pulse
    { spellID = 263074, stacks = 0, secs = 3 }, -- Festering Bite
    { spellID = 262270, stacks = 0, secs = 1 }, -- Caustic Compound
    { spellID = 262794, stacks = 0, secs = 1 }, -- Energy Lash
    { spellID = 259853, stacks = 0, secs = 3 }, -- Chemical Burn
    { spellID = 269092, stacks = 0, secs = 1 }, -- Artillery Barrage
    { spellID = 262348, stacks = 0, secs = 1 }, -- Mine Blast
    { spellID = 260838, stacks = 0, secs = 1 }, -- Homing Missile
    -- Temple of Sethraliss
    { spellID = 263371, stacks = 0, secs = 1 }, -- Conduction
    { spellID = 272657, stacks = 0, secs = 3 }, -- Noxious Breath
    { spellID = 267027, stacks = 0, secs = 1 }, -- Cytotoxin
    { spellID = 272699, stacks = 0, secs = 3 }, -- Venomous Spit
    { spellID = 268013, stacks = 0, secs = 5 }, -- Flame Shock
    -- Underrot
    { spellID = 265019, stacks = 0, secs = 1 }, -- Savage Cleave
    { spellID = 265568, stacks = 0, secs = 1 }, -- Dark Omen
    { spellID = 260685, stacks = 0, secs = 5 }, -- Taint of G'huun
    { spellID = 278961, stacks = 0, secs = 5 }, -- Decaying Mind
    { spellID = 260455, stacks = 0, secs = 1 }, -- Serrated Fangs
    { spellID = 273226, stacks = 0, secs = 1 }, -- Decaying Spores
    { spellID = 269301, stacks = 0, secs = 5 }, -- Putrid Blood
    -- all
    { spellID = 302421, stacks = 0, secs = 5 }, -- Queen's Decree
}

local function SetFriendlyToSnipe()
    local getmembersAll = A.HealingEngine.GetMembersAll()
    for i = 1, #getmembersAll do
        if Unit(getmembersAll[i].Unit):GetRange() <= 40 then
            for k, v in pairs(DebuffSniperList) do
                if Unit(getmembersAll[i].Unit):HasDeBuffs(v.spellID, true) > v.secs and Unit(getmembersAll[i].Unit):HasDeBuffsStacks(v.spellID, true) >= v.stacks and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, player, true) == 0 then
                    if A.Germination:IsSpellLearned() and Unit(getmembersAll[i].Unit):HasBuffs(A.RejuvenationGermimation.ID, player, true) == 0 then
                        if A.Rejuvenation:IsReady(getmembersAll[i].Unit) then
                            A.HealingEngine.SetTarget(getmembersAll[i].Unit)
                        end
                    elseif Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, player, true) == 0 then
                        if A.Rejuvenation:IsReady(getmembersAll[i].Unit) then
                            A.HealingEngine.SetTarget(getmembersAll[i].Unit)
                        end
                    end
                end
            end
        end
	end
end
SetFriendlyToSnipe = Action.MakeFunctionCachedDynamic(SetFriendlyToSnipe)

local pre_hot_list = {   --snipe list
    --Battle of Dazar'alor
    [283572] = { targeted = true }, --"Sacred Blade"
    [284578] = { targeted = true }, --"Penance"
    [286988] = { targeted = true }, --Divine Burst"
    [282036] = { targeted = true }, --"Fireball"
    [282182] = { targeted = false }, --"Buster Cannon"
    --Uldir
    [279669] = { targeted = false }, --"Bacterial Outbreak"
    [279660] = { targeted = false }, --"Endemic Virus"
    [274262] = { targeted = false }, --"Explosive Corruption"
    --Reaping
    [288693] = { targeted = true }, --"Grave Bolt",
    --Atal'Dazar
    [250096] = { targeted = true }, --"Wracking Pain"
    [253562] = { targeted = true }, --"Wildfire"
    [252781] = { targeted = true }, --"Unstable Hex"
    [252923] = { targeted = true }, --"Venom Blast"
    [253239] = { targeted = true }, -- Dazarai Juggernaut - Merciless Assault },
    [256846] = { targeted = true }, --'Dinomancer Kisho - Deadeye Aim'},
    [257407] = { targeted = true }, -- Rezan - Pursuit},
    --Kings Rest
    [267618] = { targeted = true }, --"Drain Fluids"
    [267308] = { targeted = true }, --"Lighting Bolt"
    [270493] = { targeted = true }, --"Spectral Bolt"
    [269973] = { targeted = true }, --"Deathly Chill"
    [270923] = { targeted = true }, --"Shadow Bolt"
    [272388] = { targeted = true }, --"Shadow Barrage"
    [266231] = { targeted = true }, -- Kula the Butcher - Severing Axe},
    [270507] = { targeted = true }, --  Spectral Beastmaster - Poison Barrage},
    [265773] = { targeted = true }, -- The Golden Serpent - Spit Gold},
    [270506] = { targeted = true }, -- Spectral Beastmaster - Deadeye Shot},
    [265773] = { targeted = true }, -- https://www.wowhead.com/spell=270487/severing-blade
    [268586] = { targeted = true }, -- https://www.wowhead.com/spell=268586/blade-combo
    --Free Hold
    [259092] = { targeted = true }, --"Lightning Bolt"
    [281420] = { targeted = true }, --"Water Bolt"
    [257267] = { targeted = false }, --"Swiftwind Saber"
    [257739] = { targeted = true }, -- Blacktooth Scrapper - Blind Rage},
    [258338] = { targeted = true }, -- Captain Raoul - Blackout Barrel},
    [256979] = { targeted = true }, -- Captain Eudora - Powder Shot},
    --Siege of Boralus
    [272588] = { targeted = true }, --"Rotting Wounds"
    [272827] = { targeted = false }, --"Viscous Slobber"
    [272581] = { targeted = true }, -- "Water Spray"
    [257883] = { targeted = false }, -- "Break Water"
    [257063] = { targeted = true }, --"Brackish Bolt"
    [272571] = { targeted = true }, --"Choking Waters"
    [257641] = { targeted = true }, -- Kul Tiran Marksman - Molten Slug},
    [272874] = { targeted = true }, -- Ashvane Commander - Trample},
    [272581] = { targeted = true }, -- Bilge Rat Tempest - Water Spray},
    [272528] = { targeted = true }, -- Ashvane Sniper - Shoot},
    [272542] = { targeted = true }, -- Ashvane Sniper - Ricochet},
    -- Temple of Sethraliss
    [263775] = { targeted = true }, --"Gust"
    [268061] = { targeted = true }, --"Chain Lightning"
    [272820] = { targeted = true }, --"Shock"
    [263365] = { targeted = true }, --"https://www.wowhead.com/spell=263365/a-peal-of-thunder"
    [268013] = { targeted = true }, --"Flame Shock"
    [274642] = { targeted = true }, --"Lava Burst"
    [268703] = { targeted = true }, --"Lightning Bolt"
    [272699] = { targeted = true }, --"Venomous Spit"
    [268703] = { targeted = true }, -- Charged Dust Devil - Lightning Bolt},
    [272670] = { targeted = true }, -- Sandswept Marksman - Shoot},
    [267278] = { targeted = true }, -- Static-charged Dervish - Electrocute},
    [272820] = { targeted = true }, -- Spark Channeler - Shock},
    [274642] = { targeted = true }, -- Hoodoo Hexer - Lava Burst},
    [268061] = { targeted = true }, -- Plague Doctor - Chain Lightning},
    --Shrine of the Storm
    [265001] = { targeted = true }, --"Sea Blast"
    [268347] = { targeted = true }, --"Void Bolt"
    [267969] = { targeted = true }, --"Water Blast"
    [268233] = { targeted = true }, --"Electrifying Shock"
    [268315] = { targeted = true }, --"Lash"
    [268177] = { targeted = true }, --"Windblast"
    [268273] = { targeted = true }, --"Deep Smash"
    [268317] = { targeted = true }, --"Rip Mind"
    [265001] = { targeted = true }, --"Sea Blast"
    [274703] = { targeted = true }, --"Void Bolt"
    [268214] = { targeted = true }, --"Carve Flesh"
    [264166] = { targeted = true }, -- Aqusirr - Undertow},
    [268214] = { targeted = true }, -- Runecarver Sorn - Carve Flesh},
    --Motherlode
    [259856] = { targeted = true }, --"Chemical Burn"
    [260318] = { targeted = true }, --"Alpha Cannon"
    [262794] = { targeted = true }, --"Energy Lash"
    [263202] = { targeted = true }, --"Rock Lance"
    [262268] = { targeted = true }, --"Caustic Compound"
    [263262] = { targeted = true }, --"Shale Spit"
    [263628] = { targeted = true }, --"Charged Claw"
    [268185] = { targeted = true }, -- Refreshment Vendor, Iced Spritzer},
    [258674] = { targeted = true }, -- Off-Duty Laborer - Throw Wrench},
    [276304] = { targeted = true }, -- Rowdy Reveler - Penny For Your Thoughts},
    [263209] = { targeted = true }, -- Mine Rat - Throw Rock},
    [263202] = { targeted = true }, -- Venture Co. Earthshaper - Rock Lance},
    [262794] = { targeted = true }, -- Venture Co. Mastermind - Energy Lash},
    [260669] = { targeted = true }, -- Rixxa Fluxflame - Propellant Blast},
    [271456] = { targeted = true }, -- https://www.wowhead.com/spell=271456/drill-smash},
    --Underrot
    [260879] = { targeted = true }, --"Blood Bolt"
    [265084] = { targeted = true }, --"Blood Bolt"
    [259732] = { targeted = false }, --"Festering Harvest"
    [266209] = { targeted = false }, --"Wicked Frenzy"
    [265376] = { targeted = true }, -- Fanatical Headhunter - Barbed Spear},
    [265625] = { targeted = true }, -- Befouled Spirit - Dark Omen},
    --Tol Dagor
    [257777] = { targeted = true }, --"Crippling Shiv"
    [258150] = { targeted = true }, --"Salt Blast"
    [258869] = { targeted = true }, --"Blaze"
    [256039] = { targeted = true }, -- Overseer Korgus - Deadeye},
    [185857] = { targeted = true }, -- Ashvane Spotter - Shoot},

    --work shop_
    [294195] = { targeted = true }, --https://www.wowhead.com/spell=294195/arcing-zap
    [293827] = { targeted = true }, --https://www.wowhead.com/spell=293827/giga-wallop
    [292264] = { targeted = true }, -- https://www.wowhead.com/spell=292264/giga-zap
    --junk yard
    [300650] = { targeted = true }, --https://www.wowhead.com/spell=300650/suffocating-smog
    [299438] = { targeted = true }, --https://www.wowhead.com/spell=299438/sledgehammer
    [300188] = { targeted = true }, -- https://www.wowhead.com/spell=300188/scrap-cannon#used-by-npc
    [302682] = { targeted = true }, --https://www.wowhead.com/spell=302682/mega-taze

    --Waycrest Manor
    [260701] = { targeted = true }, --"Bramble Bolt"
    [260700] = { targeted = true }, --"Ruinous Bolt"
    [260699] = { targeted = true }, --"Soul Bolt"
    [261438] = { targeted = true }, --"Wasting Strike"
    [266225] = { targeted = true }, --Darkened Lightning"
    [273653] = { targeted = true }, --"Shadow Claw"
    [265881] = { targeted = true }, --"Decaying Touch"
    [264153] = { targeted = true }, --"Spit"
    [278444] = { targeted = true }, --"Infest"
    [167385] = { targeted = true }, --"Infest"
    [263891] = { targeted = true }, -- Heartsbane Vinetwister - Grasping Thorns},
    [264510] = { targeted = true }, -- Crazed Marksman - Shoot},
    [260699] = { targeted = true }, -- Coven Diviner - Soul Bolt},
    [260551] = { targeted = true }, -- Soulbound Goliath - Soul Thorns},
    [260741] = { targeted = true }, -- Heartsbane Triad - Jagged Nettles},
    [268202] = { targeted = true } -- Gorak Tul - Death Lens},
}
local CC_CreatureTypeList = { "Beast", "Dragonkin" }
local StunsBlackList = {
    -- Atal'Dazar
    [87318] = "Dazar'ai Colossus",
    [122984] = "Dazar'ai Colossus",
    [128455] = "T'lonja",
    [129553] = "Dinomancer Kish'o",
    [129552] = "Monzumi",
    -- Freehold
    [129602] = "Irontide Enforcer",
    [130400] = "Irontide Crusher",
    -- King's Rest
    [133935] = "Animated Guardian",
    [134174] = "Shadow-Borne Witch Doctor",
    [134158] = "Shadow-Borne Champion",
    [137474] = "King Timalji",
    [137478] = "Queen Wasi",
    [137486] = "Queen Patlaa",
    [137487] = "Skeletal Hunting Raptor",
    [134251] = "Seneschal M'bara",
    [134331] = "King Rahu'ai",
    [137484] = "King A'akul",
    [134739] = "Purification Construct",
    [137969] = "Interment Construct",
    [135231] = "Spectral Brute",
    [138489] = "Shadow of Zul",
    -- Shrine of the Storm
    [134144] = "Living Current",
    [136214] = "Windspeaker Heldis",
    [134150] = "Runecarver Sorn",
    [136249] = "Guardian Elemental",
    [134417] = "Deepsea Ritualist",
    [136353] = "Colossal Tentacle",
    [136295] = "Sunken Denizen",
    [136297] = "Forgotten Denizen",
    -- Siege of Boralus
    [129369] = "Irontide Raider",
    [129373] = "Dockhound Packmaster",
    [128969] = "Ashvane Commander",
    [138255] = "Ashvane Spotter",
    [138465] = "Ashvane Cannoneer",
    [135245] = "Bilge Rat Demolisher",
    -- Temple of Sethraliss
    [134991] = "Sandfury Stonefist",
    [139422] = "Scaled Krolusk Tamer",
    [136076] = "Agitated Nimbus",
    [134691] = "Static-charged Dervish",
    [139110] = "Spark Channeler",
    [136250] = "Hoodoo Hexer",
    [139946] = "Heart Guardian",
    -- MOTHERLODE!!
    [130485] = "Mechanized Peacekeeper",
    [136139] = "Mechanized Peacekeeper",
    [136643] = "Azerite Extractor",
    [134012] = "Taskmaster Askari",
    [133430] = "Venture Co. Mastermind",
    [133463] = "Venture Co. War Machine",
    [133436] = "Venture Co. Skyscorcher",
    [133482] = "Crawler Mine",
    -- Underrot
    [131436] = "Chosen Blood Matron",
    [133912] = "Bloodsworn Defiler",
    [138281] = "Faceless Corruptor",
    -- Tol Dagor
    [130025] = "Irontide Thug",
    -- Waycrest Manor
    [131677] = "Heartsbane Runeweaver",
    [135329] = "Matron Bryndle",
    [131812] = "Heartsbane Soulcharmer",
    [131670] = "Heartsbane Vinetwister",
    [135365] = "Matron Alma",
    --mini bosses
    [161241] = "Voidweaver Mal'thir",
}

local function Shadowfiend()
    local have, name, start, duration = GetTotemInfo(1)
    return duration and duration ~= 0 and (duration - (TMW.time - start)) or 0
end

local function Dispel(unit)
    return
    (
        --MacroSpells(ICON, "Dispel") or
        A.GetToggle(2, "Dispel")
    ) and
    A.Purify:IsReady() and
    UnitExists(unit) and
    --not A.InLOS(unit) and      
    A.Purify:IsSpellInRange(unit) and    
    A.LastPlayerCastID ~= 527 and
    Unit(unit):DeBuffCyclone() == 0 and
    (
        (
            A.IsInPvP and 
            (                             
                Unit(unit):HasDeBuffs("Magic") > 2 or
                (
                    select(2, UnitClass(unit)) ~= "DRUID" and
                    Unit(unit):IsMelee() and
                    Unit(unit):HasDeBuffs("MagicRooted") > 2
                )
            ) 
        ) or 
        (
            not A.IsInPvP and 
            AuraIsValid(unit, "UseDispel", "Dispel")
        )
    )
end

local function MassDispel(unit)
    return     
    A.GetToggle(2, "MassDispel") and     
    A.MassDispel:IsReady() and
    UnitExists(unit) and      
    (
        -- Enemy 
        (
            Unit(unit):IsEnemy() and
            Unit(unit):GetRange() <= 30 and 
            (
                -- PvP 
                (
                    A.IsInPvP and 
                    Unit(unit):HasBuffs("ImportantPurje") > 3
                ) or
                -- PvE 
                (
                    not A.IsInPvP and 
                    (
                        Unit("player"):PowerPercent() > 50 or 
                        -- Inervate
                        Unit("player"):HasBuffs(29166, true) > 0
                    ) and 
                    Unit(unit):HasBuffs("PvEPurje") > 3
                )
            )            
        ) or
        -- Friendly 
        (
            not Unit(unit):IsEnemy() and
            A.LastPlayerCastID ~= 527 and -- Cleanse (normal dispel)
            UnitInRange(unit) and 
            (
                -- PvP 
                (
                    A.IsInPvP and 
                    (
                        -- Mind Control (exactly Buff)
                        Unit(unit):HasBuffs(605) > 0 or 
                        (
                            ( 
                                Unit("player"):PowerPercent() > 50 or                                 
                                -- Inervate
                                Unit("player"):HasBuffs(29166, true) > 0
                            ) and 
                            Unit(unit):HasDeBuffs("Magic") > 3
                        ) or
                        Unit(unit):DeBuffCyclone() > Unit("player"):CastTime(32375)
                    )
                ) or 
                -- PvE 
                (
                    not A.IsInPvP and
                    (
                        Unit("player"):PowerPercent() > 60 or 
                        -- Inervate
                        Unit("player"):HasBuffs(29166, true) > 0
                    ) and 
                    AuraIsValid(unit, "UseDispel", "Dispel")
                )
            )
        )
    )    
end

local function Purje(unit)
    return
    (
        --MacroSpells(ICON, "Dispel") or
        A.GetToggle(2, "Purje")
    ) and
    A.DispelMagic:IsReady() and
    UnitExists(unit) and    
    --not A.InLOS(unit) and  
    A.DispelMagic:IsSpellInRange(unit) and   
    Unit(unit):DeBuffCyclone() == 0 and    
    (
        (
            A.IsInPvP and 
            (                             
                -- Friendly Mind Control (this is a BUFF type)
                (
                    (UnitInRaid(unit) or UnitInParty(unit)) and                     
                    Unit(unit):HasBuffs(605, true) > 0
                ) or
                -- Enemy 
                (
                    Unit(unit):IsEnemy() and 
                    not UnitInRaid(unit) and 
                    not UnitInParty(unit) and 
                    (
                        Unit(unit):HasBuffs("ImportantPurje") > GetCurrentGCD() or 
                        Unit(unit):HasBuffs("SecondPurje") > GetCurrentGCD()
                    )
                )
            ) 
        ) or 
        (
            not A.IsInPvP and 
            Unit(unit):IsEnemy() and 
            Unit(unit):HasBuffs("PvEPurje") > GetCurrentGCD()
        )
    )
end

--- Halo 
local function CanHealHaloHOLY(VARIATION) 
    local members = A.HealingEngine.GetMembersAll() 
    if tableexist(members) and (not A.IsInPvP or not EnemyTeam():IsBreakAble(30)) then 
        local total = 0
        local units = GetValidMembers(true)
        if units < 2 then 
            return false 
        end     
        for i = 1, #members do    
            -- In range
            if Unit(members[i].Unit):GetRange() <= 30 and A.Halo:PredictHeal(members[i].Unit, VARIATION) then                               
                total = total + 1                 
            end
            -- If we reached limit of required units               
            if total >= units then 
                return true 
            end 
        end
    end 
    return false 
end 

local PriestVars = {
    ["TargetTargetLOS"] = {},
    ["active_enemies"] = 0,
}

local PriestBurstBuffs = {
    [256] = 197871, -- Discipline
    --[257] = {}, -- Holy
    [258] = 194249, -- Shadow
}

local function Shadowfiend()
    local have, name, start, duration = GetTotemInfo(1)
    return duration and duration ~= 0 and (duration - (TMW.time - start)) or 0
end

local function PriestBurst()
    local sf = Shadowfiend()
    local spec_burst = (PriestBurstBuffs[A.PlayerSpec] and Unit("player"):HasBuffs(PriestBurstBuffs[A.PlayerSpec], "player", true)) or 0
    local heroism = Unit("player"):HasBuffs("BurstHaste")
    return (sf > 0 and sf) or (spec_burst > 0 and spec_burst) or (heroism > 0 and heroism) or 0
end

local function RefreshVars()

    -- Holy 
    if Unit(player):HasSpec(257) then 
        local CurrentSpeed = Unit("player"):GetCurrentSpeed()
        -- HealingEngine 
        VarGetMembers = HealingEngine.GetMembersAll()
        -- Symvol of Hope & Divine Hymn
        VarIsChanneling = select(2, Unit("player"):CastTime(64901)) > 0 or select(2, Unit("player"):CastTime(64843)) > 0
        -- Apotheosis
        VarApotheosis = (A.Apotheosis:IsSpellLearned() and Unit("player"):HasBuffs(200183, "player", true)) or 0
        -- Member's controllers
        VarFrequency = HealingEngine.GetHealthFrequency(GetGCD() * 3 + GetCurrentGCD())
        -- Enemies >= 2
        VarAoE12 = AoE(2, 12)
        -- AoE healing 
        VarCanHealHalo = A.GetToggle(2, "AoE") and not VarIsChanneling and A.Halo:IsSpellLearned() and CurrentSpeed == 0 and A.Halo:IsReady() and CanHealHaloHOLY() 
    end 
   
end

--- PSEUDO CLASS
local function PseudoClass(methods)
    local Class = setmetatable(methods, {
            __call = function(self, ...)
                self:New(...)
                return self                 
            end,
    })
    return Class
end

local Cache = {
    bufer = {},    
    newEl = function(this, inv, keyArg, func, ...)
        if not this.bufer[func][keyArg] then 
            this.bufer[func][keyArg] = {}
        end 
        this.bufer[func][keyArg].t = TMW.time + (inv or ACTION_CONST_CACHE_DEFAULT_TIMER_UNIT) + 0.001  -- Add small delay to make sure what it's not previous corroute  
        this.bufer[func][keyArg].v = { func(...) } 
        
        return unpack(this.bufer[func][keyArg].v)
    end,
    Wrap = function(this, func, name)
        if ACTION_CONST_CACHE_DISABLE then 
            return func 
        end 
        
        if not this.bufer[func] then 
            this.bufer[func] = setmetatable({}, { __mode == "kv" })
        end
        
        return function(...)   
            -- The reason of all this view look is memory hungry eating, this way use less memory 
            local self = ...        
            local keyArg = strElemBuilder(UnitGUID(name) or name, ...)        
            
            if TMW.time > (this.bufer[func][keyArg] and this.bufer[func][keyArg].t or 0) then
                return this:newEl(self.Refresh, keyArg, func, ...)
            else
                return unpack(this.bufer[func][keyArg].v)
            end
        end        
    end,
}

--- Unit to heal conditions
TR.CanHeal = PseudoClass({
        Mouse = Cache:Wrap(function(self, isPlayer)       
                return 
                A.GetToggle(2, "mouseover") and
                A.MouseHasFrame() and
                Unit("mouseover"):IsExists() and
                not Unit("mouseover"):IsEnemy() and
                ( not isPlayer or Unit("mouseover"):IsPlayer() ) and
                (
                    -- Mass Dispel     
                    self.SpellID == 32375 or
                    Unit("mouseover"):DeBuffCyclone() <= self.CastTime
                )  
        end, "mouseover"),
        Target = Cache:Wrap(function(self, isPlayer)       
                return 
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit("mouseover"):IsExists() or 
                    Unit("mouseover"):IsEnemy()
                ) and        
                not Unit("target"):IsEnemy() and
                ( not isPlayer or Unit("target"):IsPlayer() ) and
                (
                    -- Mass Dispel
                    self.SpellID == 32375 or
                    Unit("target"):DeBuffCyclone() <= self.CastTime                 
                )    
        end, "target"),
})
function TR.CanHeal:New(Spell, Refresh) 
    -- Exception Penance (this is for Cyclone prediction)
    self.CastTime = (Spell and Spell ~= 47540 and Unit("player"):CastTime(Spell)) or 0
    self.SpellID = Spell or 0 
    self.Refresh = Refresh or 0.01
end

--- Unit to damage conditions
TR.CanDMG = PseudoClass({
        Mouse = Cache:Wrap(function (self, isPlayer)       
                return 
                A.GetToggle(2, "mouseover") and
                Unit("mouseover"):IsEnemy() and
                ( not isPlayer or Unit("mouseover"):IsPlayer() ) and
                Unit("mouseover"):DeBuffCyclone() <= self.CastTime and 
                -- 107079 Pandaren Kick, 232633 Arcane Torrent 
                ( self.SpellID == 107079 or self.SpellID == 232633 or not A.IsInPvP or Unit("mouseover"):WithOutKarmed() )
        end, "mouseover"),
        Target = Cache:Wrap(function (self, isPlayer)       
                return 
                (
                    not A.GetToggle(2, "mouseover") or
                    not A.MouseHasFrame()
                ) and        
                Unit("target"):IsEnemy() and
                ( not isPlayer or Unit("target"):IsPlayer() ) and
                Unit("target"):DeBuffCyclone() <= self.CastTime and 
                -- 107079 Pandaren Kick, 232633 Arcane Torrent 
                ( self.SpellID == 107079 or self.SpellID == 232633 or not A.IsInPvP or Unit("target"):WithOutKarmed() )  
        end, "target"),
        TargetTarget = Cache:Wrap(function (self, isPlayer)   
                if not A.GetToggle(2, "targettarget") then 
                    return false 
                end 
                local NotInLOS = true 
                if Action.GetToggle(1, "LOSCheck") then 
                    local TimeLOS = PriestVars["TargetTargetLOS"][UnitGUID("targettarget")] or 0
                    NotInLOS = not TimeLOS or TMW.time - TimeLOS > 0
                end     
                return 
                (
                    not A.GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() or
                    not Unit("mouseover"):IsEnemy()
                ) and
                -- LOS Checking
                NotInLOS and 
                -- Exception to don't pull by mistake mob
                Unit("targettarget"):CombatTime() > 0 and
                not Unit("target"):IsEnemy() and
                Unit("targettarget"):IsEnemy() and
                ( not isPlayer or UnitIsPlayer("targettarget") ) and
                Unit("targettarget"):DeBuffCyclone() <= self.CastTime and 
                -- 107079 Pandaren Kick, 232633 Arcane Torrent 
                ( self.SpellID == 107079 or self.SpellID == 232633 or not A.IsInPvP or Unit("targettarget"):WithOutKarmed() )  
        end, "targettarget"),
})

function TR.CanDMG:New(Spell, Refresh) 
    -- Exception Penance (this is for Cyclone prediction)
    self.CastTime = (Spell and Spell ~= 47540 and Unit("player"):CastTime(Spell)) or 0
    self.SpellID = Spell or 0
    self.Refresh = Refresh or 0.01
end

--- PvE
local function WipeAgro()
    local units = MultiUnits:GetActiveUnitPlates()
    if tableexist(units) then
        for k, unit in pairs(units) do
            if CombatTime(unit) > 0 and Unit("player"):IsTanking(unit) then
                return true
            end
        end
    end
    return false
end

--- =========================== HOLY ================================
local TrailOfLightGUID = {}
Listener:Add('Taste_Holy_Events', "COMBAT_LOG_EVENT_UNFILTERED", function(...)
        local _, EVENT, _, SourceGUID, _,_,_, DestGUID, _, _, _, SpellID, SpellName = CombatLogGetCurrentEventInfo()
        if Unit(player):HasSpec(257) and EVENT == "SPELL_CAST_SUCCESS" and SourceGUID == UnitGUID("player") and (SpellName == GetSpellInfo(2060) or SpellName == GetSpellInfo(2061)) then 
            if TrailOfLightGUID[#TrailOfLightGUID] ~= DestGUID then 
                TrailOfLightGUID[#TrailOfLightGUID + 1] = DestGUID
            end 
        end 
end)        

local function UnitIsTrailOfLight(unit) 
    local GUID = UnitGUID(unit)    
    return (A.TrailofLight:IsSpellLearned() and ((#TrailOfLightGUID == 1 and TrailOfLightGUID[#TrailOfLightGUID] == GUID) or (#TrailOfLightGUID > 1 and TrailOfLightGUID[#TrailOfLightGUID - 1] == GUID))) or false 
end     

--- Condition if we can heal previous unit 
local function PredictTrailOfLight(SpellName) 
    if #TrailOfLightGUID > 1 then
        local members = A.HealingEngine.GetMembersAll()
        for i = 1, #members do 
            if UnitIsTrailOfLight(members[i].Unit) then
                if not Unit(members[i].Unit):IsDead() and A.FlashHeal:PredictHeal(members[i].Unit, 35) and Unit(members[i].Unit):DeBuffCyclone() <= 1 then 
                    return true 
                end 
                break 
            end 
        end 
    end 
    return false 
end 

--- AoE ( 2+ units minimum )
--- Holy Word: Sanctify 
local function CanHealHolyWordSanctify(unit) 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then 
        local total = 0
        local units = GetValidMembers(true)
        if units < 2 then 
            return false 
        end         
        if UnitIsUnit("player", unit) then 
            -- Clear true position
            for i = 1, #members do    
                -- In range
                if Unit(members[i].Unit):GetRange() <= 10 and A.HolyWordSanctify:PredictHeal(members[i].Unit) then
                    total = total + 1
                end 
                -- If we reached limit of required units
                if total >= units then 
                    return true 
                end 
            end 
        else  
            -- Worn rest position 
            for i = 1, #members do    
                -- In range (they are already into by table of members) 
                if A.HolyWordSanctify:PredictHeal(members[i].Unit) then
                    total = total + 1
                end
                -- If we reached limit of required units
                if total >= units then 
                    return true 
                end 
            end
        end 
    end 
    return false 
end 

--- Circle of Healing 
local function CanHealCircleOfHealing(unit) 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then 
        local total = 0
        local units = GetValidMembers(true)
        if units < 2 then 
            return false 
        end         
        if UnitIsUnit("player", unit) then 
            -- Clear true position
            for i = 1, #members do    
                -- In range
                if Unit(members[i].Unit):GetRange() <= 30 and A.CircleofHealing:PredictHeal(members[i].Unit) then
                    total = total + 1
                end 
                -- If we reached limit of required units
                if total >= units then 
                    return true 
                end 
            end 
        else  
            -- Worn rest position 
            for i = 1, #members do    
                -- In range (they are already into by table of members) 
                if A.CircleofHealing:PredictHeal(members[i].Unit) then
                    total = total + 1
                end
                -- If we reached limit of required units
                if total >= units then 
                    return true 
                end 
            end
        end 
    end 
    return false 
end 

--- Prayer Of Mending (fixed >= 2 units)
local function CanHealPrayerOfMending(unit) 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then 
        local total = 0                
        if UnitIsUnit("player", unit) then 
            -- Clear true position
            for i = 1, #members do    
                -- In range
                if Unit(members[i].Unit):GetRange() <= 20 and A.PrayerofMendingHoT:PredictHeal(members[i].Unit) then
                    total = total + 1
                end 
                -- If we reached limit of required units
                if total >= 2 then 
                    return true 
                end 
            end 
        else  
            -- Worn rest position 
            for i = 1, #members do    
                -- In range (they are already into by table of members) 
                if A.PrayerofMendingHoT:PredictHeal(members[i].Unit) then
                    total = total + 1
                end
                -- If we reached limit of required units
                if total >= 2 then 
                    return true 
                end 
            end
        end 
    end 
    return false 
end 

--- Halo 
local function CanHealHaloHOLY(VARIATION) 
    local members = A.HealingEngine.GetMembersAll() 
    if tableexist(members) and (not A.IsInPvP or not EnemyTeam():IsBreakAble(30)) then 
        local total = 0
        local units = GetValidMembers(true)
        if units < 2 then 
            return false 
        end     
        for i = 1, #members do    
            -- In range
            if Unit(members[i].Unit):GetRange() <= 30 and A.Halo:PredictHeal(members[i].Unit, VARIATION) then                               
                total = total + 1                 
            end
            -- If we reached limit of required units               
            if total >= units then 
                return true 
            end 
        end
    end 
    return false 
end 

--- Prayer Of Healing
local function CanHealPrayerOfHealing() 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then 
        local total = 0    
        local units = GetValidMembers(true)
        if units < 2 then 
            return false 
        end     
        -- Worn rest position 
        for i = 1, #members do    
            -- In range (they are already into by table of members) 
            if A.PrayerofHealing:PredictHeal(members[i].Unit) then
                total = total + 1
            end
            -- If we reached limit of required units
            if total >= units then 
                return true 
            end 
        end         
    end 
    return false 
end 

--- Binding Heal ( fixed 2+ units )
local function CanHealBindingHeal(unit) 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then 
        local total = 0    
        -- Worn rest position 
        for i = 1, #members do            
            -- In range (they are already into by table of members) and it's not our target/mouseover unit 
            if not UnitIsUnit(unit, members[i].Unit) and A.BindingHeal:PredictHeal(members[i].Unit) then
                total = total + 1
            end
            -- If we reached limit of required units
            if total >= 1 then 
                return true 
            end 
        end                  
    end 
    return false 
end 

--- Divine Star
local function CanHealDivineStarHOLY() 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then 
        local total = 0    
        local units = GetValidMembers(true)
        if units < 2 then 
            return false 
        end     
        -- Worn rest position 
        for i = 1, #members do    
            -- In range
            if Unit(members[i].Unit):GetRange() <= 24 and A.PrayerofHealing:PredictHeal(members[i].Unit) then
                total = total + 1
            end
            -- If we reached limit of required units
            if total >= units then 
                return true 
            end 
        end         
    end 
    return false 
end 

--- Holy Nova (if in range 1+ or self)
local function CanHealHolyNovaHOLY() 
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) and (not A.IsInPvP or not EnemyTeam():IsBreakAble(12)) then    
        for i = 1, #members do                
            -- In range
            if Unit(members[i].Unit):GetRange() <= 12 and A.HolyNova:PredictHeal(members[i].Unit) then
                return true 
            end           
        end
    end 
    return false 
end 

--- Symbol of Hope
local function CanSymbolOfHope(offset)
    local members = A.HealingEngine.GetMembersAll()    
    if tableexist(members) then    
        for i = 1, #members do                
            -- In range
            if Unit(members[i].Unit):IsHealer() and Unit(members[i].Unit):PowerPercent() <= offset then
                return true 
            end           
        end
    end 
    return false 
end 

local function UnitMagicImun(unit)
    local total = Unit(unit):HasBuffs("TotalImun")
    if total > 0 then
        return total
    end
    total = Unit(unit):HasBuffs("DamageMagicImun")
    return total
end

local function UnitPhysImun(unit)
    local total = Unit(unit):HasBuffs("TotalImun")
    if total > 0 then
        return total
    end
    total = Unit(unit):HasBuffs("DamagePhysImun")
    return total
end

-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
	RotationsVariables()
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
	local ReceivedLast5sec = FriendlyTeam("ALL"):GetLastTimeDMGX(5)
	local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
	local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
    RefreshVars()
	
	local ApotheosisReason1 = false
	local ApotheosisReason2 = false
	local ApotheosisReason3 = false
	local ApotheosisReason4 = false
	
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingDamageRotation(unit)
	
		-- Vars
		local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unit)
        local unitGUID = UnitGUID(unit)
		
        -- RESS ALL PEOPLE
        if A.MassResurrection:IsReady(player) and
        Unit(player):CombatTime() == 0 and
        Unit("player"):GetCurrentSpeed() == 0 and
        (
            (
                TR.CanHeal():Mouse(true) and       
                Unit("mouseover"):IsDead() and               
                (UnitInRaid("mouseover") or UnitInParty("mouseover")) and        
                Unit("mouseover"):GetRange() <= 100
            ) or 
            (
                TR.CanHeal():Target(true) and
                Unit("target"):IsDead() and        
                (UnitInRaid("target") or UnitInParty("target")) and
                Unit("target"):GetRange() <= 100
            )
        )
        then
		    return A.MassResurrection:Show(icon)
		end

        -- RESS Single
        if A.Resurrection:IsReady(unit) and
        Unit(player):CombatTime() == 0 and
        Unit("player"):GetCurrentSpeed() == 0 and
        (
            (
                TR.CanHeal():Mouse(true) and       
                Unit("mouseover"):IsDead() and               
                A.Resurrection:IsSpellInRange("mouseover")
            ) or 
            (
                TR.CanHeal():Target(true) and
                Unit("target"):IsDead() and        
                A.Resurrection:IsSpellInRange("target")
            )   
        )
        then
		    return A.Resurrection:Show(icon)
		end

        -- General Purje
        if A.Purify:IsReady(unit) and
        A.GetToggle(2, "Purje") and
        (    
            (
                (
                    TR.CanHeal(A.Purify.ID):Mouse(true) or
                    TR.CanDMG(A.Purify.ID):Mouse()
                ) and
                Purje("mouseover") 
            ) or 
            (
                (
                    TR.CanHeal(A.Purify.ID):Target(true) or
                    TR.CanDMG(A.Purify.ID):Target()
                ) and
                Purje("target") 
            )
        ) 
        then
		    return A.Purify:Show(icon)
		end

        -- General Dispel
        if A.DispelMagic:IsReady(unit) and
        A.GetToggle(2, "Dispel") and
        (
            (
                TR.CanHeal(A.DispelMagic.ID):Mouse(true) and        
                Dispel("mouseover")
            ) or 
            (
                TR.CanHeal(A.DispelMagic.ID):Target(true) and        
                Dispel("target")
            )
        )
        then
		    return A.DispelMagic:Show(icon)
		end

        -- General Mass Dispel
        if A.MassDispel:IsReady(player) and
        A.GetToggle(2, "Dispel") and
        not IsMouselooking() and
        (
            (
                TR.CanHeal(A.MassDispel.ID):Mouse(true) and               
                MassDispel("mouseover")
            ) or 
            (
                TR.CanHeal(A.MassDispel.ID):Target(true) and
                MassDispel("target") 
            )
        )
        then
		    return A.MassDispel:Show(icon)
		end

        -- General Power Word: Fortitude
        if A.PowerWordFortitude:IsReady(player) and
        not VarIsChanneling and
        not Player:IsMounted() and
        Unit(player):CombatTime() == 0 and
        TMW.time - SpellLastCast("player", A.PowerWordFortitude.ID, true) > 20 and
        FriendlyTeam(nil, 10):MissedBuffs(A.PowerWordFortitude.ID)
        then
		    return A.PowerWordFortitude:Show(icon)
		end

        -- General #1 Leap of Faith
        if A.LeapofFaith:IsReady(unit) and
        A.GetToggle(2, "LeapofFaith") and
        Unit(player):CombatTime() > 0 and
        (
            (
                TR.CanHeal(A.LeapofFaith.ID):Mouse(true) and 
                A.LeapofFaith:IsSpellInRange("mouseover") and      
                not UnitIsUnit("mouseover", "player") and
                not Unit("mouseover"):IsTank() and        
                Unit("mouseover"):TimeToDie() <= GetGCD() + GetCurrentGCD() and
                Unit("mouseover"):HasBuffs("TotalImun") == 0 and
                Unit("mouseover"):HasDeBuffs("Rooted") == 0
            ) or 
            (
                TR.CanHeal(A.LeapofFaith.ID):Target(true) and
                A.LeapofFaith:IsSpellInRange("target") and       
                not UnitIsUnit("target", "player") and
                not Unit("target"):IsTank() and
                Unit("target"):TimeToDie() <= GetGCD() + GetCurrentGCD() and
                Unit("target"):HasBuffs("TotalImun") == 0 and
                Unit("target"):HasDeBuffs("Rooted") == 0
            )
        )
        then
		    return A.LeapofFaith:Show(icon)
		end

        -- General #2 Leap of Faith (Smoke Bomb)
        if A.LeapofFaith:IsReady(unit) and
        A.Zone ~= "none" and
        A.GetToggle(2, "LeapofFaith") and
        Unit(player):CombatTime() > 0 and
        (
            (
                TR.CanHeal(A.LeapofFaith.ID):Mouse(true) and 
                A.LeapofFaith:IsSpellInRange("mouseover") and      
                not UnitIsUnit("mouseover", "player") and                     
                Unit("mouseover"):HasDeBuffs("Stuned") > 4 and
                Unit("mouseover"):IsFocused("MELEE", true)
            ) or 
            (
                TR.CanHeal(A.LeapofFaith.ID):Target(true) and
                A.LeapofFaith:IsSpellInRange("target") and       
                not UnitIsUnit("target", "player") and                        
                Unit("target"):HasDeBuffs("Stuned") > 4 and
                Unit("target"):IsFocused("MELEE", true)
            )
        )
        then
		    return A.LeapofFaith:Show(icon)
		end
		
        -- General Angelic Feather
        if A.AngelicFeather:IsReady(unit) and
        A.GetToggle(2, "AngelicFeather") and
        not VarIsChanneling and
        not Player:IsMounted() and
        Unit(player):CombatTime() == 0 and
        A.AngelicFeather:IsSpellLearned() and
        (
            (
                TR.CanHeal(ID):Mouse(true) and               
                UnitInRange("mouseover") and
                Unit("mouseover"):HealthPercent() > 90 and
                not UnitInVehicle("mouseover") and        
                Unit("mouseover"):GetCurrentSpeed() > 0 and
                Unit("mouseover"):GetMaxSpeed() < 140 and
                Unit("mouseover"):HasBuffs("Speed") == 0 and
                (
                    UnitIsUnit("mouseover", "player") or
                    not IsMouselooking() 
                ) 
            ) or 
            (
                TR.CanHeal(ID):Target(true) and
                UnitInRange("target") and
                Unit("target"):HealthPercent() > 90 and
                not UnitInVehicle("target") and 
                Unit("target"):GetCurrentSpeed() > 0 and
                Unit("target"):GetMaxSpeed() < 140 and
                Unit("target"):HasBuffs("Speed") == 0 and
                (
                    UnitIsUnit("target", "player") or
                    not IsMouselooking() 
                )
            )
        ) and
        (
            not A.IsInPvP or
            TMW.time - A.TimeStampZone > 70
        ) 
        then
		    return A.AngelicFeather:Show(icon)
		end


        -- General PvE Fade
        if A.Fade:IsReady(player) and
        not VarIsChanneling and
        Unit("player"):CombatTime() > 0 and
        not Player:IsMounted() and
        WipeAgro() and
        (
            not Unit(player):HasSpec(257) or
            -- Spirit of Redemption
            Unit("player"):HasBuffs(215769, true) == 0
        )
        then
		    return A.Fade:Show(icon)
		end

        -- HPvE Mouse Holy Word: Chastise
        if A.HolyWordChastise:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        (
            TR.CanDMG(A.HolyWordChastise.ID):Mouse() and 
            A.HolyWordChastise:IsSpellInRange("mouseover") and           
            (
                not Unit("mouseover"):IsPlayer() or
                (
                    UnitMagicImun("mouseover") <= GetCurrentGCD() and
                    Unit("mouseover"):HasBuffs("CCMagicImun") <= GetCurrentGCD()
                )
            )
        ) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.HolyWordChastise:Show(icon)
		end

        -- HPvE Mouse Holy Fire
        if A.HolyFire:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        (
            TR.CanDMG(A.HolyFire.ID):Mouse() and 
            A.HolyFire:IsSpellInRange("mouseover") and           
            (
                not Unit("mouseover"):IsPlayer() or
                UnitMagicImun("mouseover") <= GetCurrentGCD() 
            )
        ) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.HolyFire:Show(icon)
		end

        -- HPvE Mouse Smite
        if A.Smite:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        Unit("player"):GetCurrentSpeed() == 0 and
        (
            TR.CanDMG(A.Smite.ID):Mouse() and 
            A.Smite:IsSpellInRange("mouseover") and           
            (
                not Unit("mouseover"):IsPlayer() or
                UnitMagicImun("mouseover") <= GetCurrentGCD() + Unit("player"):CastTime(A.Smite.ID)
            )
        ) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.Smite:Show(icon)
		end

        -- HPvE Mouse Divine Star
        if A.DivineStar:IsReady(unit) and    
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        A.DivineStar:IsSpellLearned() and
        (
            TR.CanDMG(A.DivineStar.ID):Mouse() and        
            Unit("mouseover"):GetRange() <= 24 and
            (
                not Unit("mouseover"):IsPlayer() or
                UnitMagicImun("mouseover") <= GetCurrentGCD() + 0.2
            )
        )
        then
		    return A.DivineStar:Show(icon)
		end

        -- HPvE Guardian Spirit
        if A.GuardianSpirit:IsReady(unit) and 
        not Player:IsMounted() and
        Unit(player):HasSpec(257) and
        Unit("player"):CombatTime() > 0 and
        (
            (
                TR.CanHeal(A.GuardianSpirit.ID):Mouse(true) and 
                A.GuardianSpirit:IsSpellInRange("mouseover") and        
                Unit("mouseover"):TimeToDieX(25) <= GetGCD() * 2 and
                Unit("mouseover"):GetRealTimeDMG() > 0 and
                -- Check Toggle conditions by preference
                (
                    -- Self
                    (
                        UnitIsUnit("mouseover", "player") and
                        GuardianSpiritSelfDeff
                    ) or
                    -- Group
                    (
                        not UnitIsUnit("mouseover", "player") and
                        GuardianSpiritTeamDeff
                    )
                ) and
                -- HP Limit by role
                (
                    (
                        Unit("mouseover"):IsTank() and
                        Unit("mouseover"):HealthPercent() < 25
                    ) or 
                    (
                        not Unit("mouseover"):IsTank() and
                        Unit("mouseover"):HealthPercent() < 30
                    )
                ) and
                -- Immediate Interruption
                (
                    not VarIsChanneling or
                    -- Penance
                    Unit("mouseover"):TimeToDie() <= 3
                ) and
                -- If already is not deffensed or still will die
                (
                    Unit("mouseover"):TimeToDie() <= 3 or
                    Unit("mouseover"):HasBuffs("DeffBuffs") <= GetCurrentGCD() 
                ) and
                Unit("mouseover"):HasBuffs("TotalImun") == 0
            ) or 
            (
                TR.CanHeal(A.GuardianSpirit.ID):Target(true) and
                A.GuardianSpirit:IsSpellInRange("target") and        
                Unit("target"):TimeToDieX(25) <= GetGCD() * 2 and
                Unit("target"):GetRealTimeDMG() > 0 and
                -- Check Toggle conditions by preference
                (
                    -- Self
                    (
                        UnitIsUnit("target", "player") and
                        GuardianSpiritSelfDeff
                    ) or
                    -- Group
                    (
                        not UnitIsUnit("target", "player") and
                        GuardianSpiritTeamDeff
                    )
                ) and
                -- HP Limit by role
                (
                    (
                        Unit("target"):IsTank() and
                        Unit("target"):HealthPercent() < 25
                    ) or 
                    (
                        not Unit("target"):IsTank() and
                        Unit("target"):HealthPercent() < 30
                    )
                ) and
                -- Immediate Interruption
                (
                    not VarIsChanneling or
                    -- Penance
                    Unit("target"):TimeToDie() <= 3
                ) and
                -- If already is not deffensed or still will die
                (
                    Unit("target"):TimeToDie() <= 3 or
                    Unit("target"):HasBuffs("DeffBuffs") <= GetCurrentGCD()
                ) and
                Unit("target"):HasBuffs("TotalImun") == 0
            )
        )
        then
		    return A.GuardianSpirit:Show(icon)
		end

        -- HPvE #1 Renew (Toggle)
        if A.Renew:IsReady(unit) and
        Unit(player):HasSpec(257) and
		Unit(unit):HasBuffs(A.Renew.ID, true) < 3 and
        not VarIsChanneling and
        RenewRefresh and
        (
            (
                TR.CanHeal(A.Renew.ID):Mouse() and  
                A.Renew:IsSpellInRange("mouseover") and
                Unit("mouseover"):HasBuffs(A.Renew.ID, "player", true) <= GetCurrentGCD()
            ) or 
            (
                TR.CanHeal(A.Renew.ID):Target() and      
                A.Renew:IsSpellInRange("target") and
                Unit("target"):HasBuffs(A.Renew.ID, "player", true) <= GetCurrentGCD()
            )
        )
        then
		    return A.Renew:Show(icon)
		end
		
		
        -- HPvE Divine Hymn
        if A.DivineHymn:IsReady(player) and
        not Player:IsMounted() and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        Unit("player"):CombatTime() > 0 and
        Unit("player"):IsStayingTime() > 4 and
        (
            (
                TR.CanHeal(A.DivineHymn.ID):Mouse(true) and 
                UnitInRange("mouseover")
            ) or 
            (
                TR.CanHeal(A.DivineHymn.ID):Target(true) and
                UnitInRange("target")
            )
        ) and
        (
            (
                VarFrequency and
                (
                    (
                        TeamCache.Friendly.Size <= 5 and
                        (
                            VarFrequency >= 40 or
                            HealingEngine.GetBelowHealthPercentUnits(45) >= 3
                        )                        
                    ) or
                    (
                        TeamCache.Friendly.Size > 5 and
                        VarFrequency >= 30
                    )
                )
            ) or    
            HealingEngine.GetBelowHealthPercentUnits(60) >= 6
        )
        then
		    return A.DivineHymn:Show(icon)
		end

        -- HPvE Holy Word: Salvation 
        if A.HolyWordSalvation:IsReady(player) and
        not Player:IsMounted() and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        A.HolyWordSalvation:IsSpellLearned() and
        Unit("player"):CombatTime() > 0 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.HolyWordSalvation.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.HolyWordSalvation.ID):Mouse(true) and 
                UnitInRange("mouseover")
            ) or 
            (
                TR.CanHeal(A.HolyWordSalvation.ID):Target(true) and
                UnitInRange("target")
            )
        ) and
        (
            (
                VarFrequency and
                (
                    (
                        TeamCache.Friendly.Size <= 5 and
                        (
                            VarFrequency >= 35 or
                            HealingEngine.GetBelowHealthPercentUnits(35) >= 3
                        )                        
                    ) or
                    (
                        TeamCache.Friendly.Size > 5 and
                        VarFrequency >= 40
                    )
                )
            ) or    
            HealingEngine.GetBelowHealthPercentUnits(40) >= 6
        )
        then
		    return A.HolyWordSalvation:Show(icon)
		end
		
        -- HPvE AoE Apotheosis
        if A.Apotheosis:IsReady(player) and
        --A.BurstIsON(unit) and
        not Player:IsMounted() and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        A.Apotheosis:IsSpellLearned() and
        Unit("player"):CombatTime() > 0 and
        (
            -- Holy Word: Sanctify 
            A.HolyWordSanctify:GetCooldown() <= GetGCD() + GetCurrentGCD() and
            -- Holy Word: Serenity
            A.HolyWordSerenity:GetCooldown() <= GetGCD() + GetCurrentGCD() 
        ) and
        (
            (
                TR.CanHeal(A.Apotheosis.ID):Mouse(true) and 
                UnitInRange("mouseover") and
                Unit("mouseover"):TimeToDie() > GetGCD() + GetCurrentGCD() + 1 and
                A.Apotheosis:PredictHeal("mouseover", 250)
            ) or 
            (
                TR.CanHeal(A.Apotheosis.ID):Target(true) and
                UnitInRange("target") and
                Unit("target"):TimeToDie() > GetGCD() + GetCurrentGCD() + 1 and
                A.Apotheosis:PredictHeal("target", 250)
            )
        ) and
        (		    
            -- PvE: Single
            (
                -- #1 Holy Word: Sanctify (RAID)
                ApotheosisReason1 or
                -- #2 Holy Word: Sanctify (PARTY)
                ApotheosisReason2 or 
				-- #3 Holy Word: Sanctify movement
				ApotheosisReason3
            ) and
            -- Holy Word: Serenity (RAID & PARTY)
            ApotheosisReason4
        )
        then
		    return A.Apotheosis:Show(icon)
		end


        -- HPvE AoE Holy Word: Sanctify 
        if A.HolyWordSanctify:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        (
            (
                TR.CanHeal(A.HolyWordSanctify.ID):Mouse() and               
                A.HolyWordSanctify:PredictHeal("mouseover") and
                CanHealHolyWordSanctify("mouseover") and
                (
                    UnitIsUnit("mouseover", "player") or
                    not IsMouselooking() 
                )
            ) or 
            (
                TR.CanHeal(A.HolyWordSanctify.ID):Target() and             
                A.HolyWordSanctify:PredictHeal("target") and
                CanHealHolyWordSanctify("target") and
                (
                    UnitIsUnit("target", "player") or
                    not IsMouselooking() 
                )
            )
        )
        then
		    return A.HolyWordSanctify:Show(icon)
		end

        -- HPvE #1 Holy Word: Sanctify (RAID)
        if A.HolyWordSanctify:IsReady(unit) and
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size > 5 and
        (
            (
                TR.CanHeal(A.HolyWordSanctify.ID):Mouse() and       
                UnitInRange("mouseover") and        
                A.HolyWordSanctify:PredictHeal("mouseover") and
                CanHealHolyWordSanctify("mouseover") and
                (
                    UnitIsUnit("mouseover", "player") or
                    not IsMouselooking() 
                )
            ) or 
            (
                TR.CanHeal(A.HolyWordSanctify.ID):Target() and  
                UnitInRange("target") and
                A.HolyWordSanctify:PredictHeal("target") and
                CanHealHolyWordSanctify("target") and
                (
                    UnitIsUnit("target", "player") or
                    not IsMouselooking() 
                )
            )
        )
        then
		    ApotheosisReason2 = true
		    return A.HolyWordSanctify:Show(icon)
		end
        

        -- HPvE Holy Word: Serenity (RAID & PARTY)
        if A.HolyWordSerenity:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        (
            (
                TR.CanHeal(A.HolyWordSerenity.ID):Mouse() and 
                A.HolyWordSerenity:IsSpellInRange("mouseover") and        
                A.HolyWordSerenity:PredictHeal("mouseover")
            ) or 
            (
                TR.CanHeal(A.HolyWordSerenity.ID):Target() and
                A.HolyWordSerenity:IsSpellInRange("target") and       
                A.HolyWordSerenity:PredictHeal("target")
            )
        )
        then
		    ApotheosisReason4 = true
		    return A.HolyWordSerenity:Show(icon)
		end
        

        -- HPvE #2 Holy Word: Sanctify (PARTY)
        if A.HolyWordSanctify:IsReady(unit) and
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size <= 5 and
        (
            (
                TR.CanHeal(ID):Mouse() and    
                UnitInRange("mouseover") and
                A.HolyWordSanctify:PredictHeal("mouseover") and
                CanHealHolyWordSanctify("mouseover") and
                (
                    UnitIsUnit("mouseover", "player") or
                    not IsMouselooking() 
                )
            ) or 
            (
                TR.CanHeal(ID):Target() and             
                UnitInRange("target") and
                A.HolyWordSanctify:PredictHeal("target") and
                CanHealHolyWordSanctify("target") and
                (
                    UnitIsUnit("target", "player") or
                    not IsMouselooking() 
                )
            )
        )
        then
		    ApotheosisReason1 = true
		    return A.HolyWordSanctify:Show(icon)
		end
        

        -- HPvE #1 Flash Heal (PARTY) emergency
        if A.FlashHeal:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size <= 5 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.FlashHeal.ID) == 0 or
            -- Surge of Light
            Unit("player"):HasBuffs(114255, "player", true) > 0    
        ) and
        (
            (
                TR.CanHeal(A.FlashHeal.ID):Mouse() and  
                A.FlashHeal:IsSpellInRange("mouseover") and          
                A.FlashHeal:PredictHeal("mouseover") and
                (
                    Unit("mouseover"):HealthPercent() < 55 or
                    Unit("mouseover"):TimeToDieX(35) < GetGCD() * 3.5
                )
            ) or 
            (
                TR.CanHeal(A.FlashHeal.ID):Target() and      
                A.FlashHeal:IsSpellInRange("target") and         
                A.FlashHeal:PredictHeal("target") and
                ( 
                    Unit("target"):HealthPercent() < 55 or
                    Unit("target"):TimeToDieX(35) < GetGCD() * 3.5
                )
            )
        )
        then
		    return A.FlashHeal:Show(icon)
		end
		
        -- HPvE #1 Divine Star
        if A.DivineStar:IsReady(unit) and  
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        A.DivineStar:IsSpellLearned() and
        -- Conditions in combat or don't use while combat if we can hit near mob
        (
            Unit("player"):CombatTime() > 0 or
            not AoE(1, 24)
        ) and
        (
            (        
                TR.CanHeal(A.DivineStar.ID):Mouse() and  
                Unit("mouseover"):GetRange() <= 24 and
                A.DivineStar:PredictHeal("mouseover")
            ) or
            (        
                TR.CanHeal(A.DivineStar.ID):Target() and         
                Unit("target"):GetRange() <= 24 and
                A.DivineStar:PredictHeal("target")
            )     
        ) and
        CanHealDivineStarHOLY()
        then
		    return A.DivineStar:Show(icon)
		end

        -- HPvE AoE Circle of Healing
        if A.CircleofHealing:IsReady(unit) and  
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        A.CircleofHealing:IsSpellLearned() and
        (
            (
                TR.CanHeal(A.CircleofHealing.ID):Mouse() and  
                A.CircleofHealing:IsSpellInRange("mouseover") and             
                A.CircleofHealing:PredictHeal("mouseover") 
            ) or 
            (
                TR.CanHeal(A.CircleofHealing.ID):Target() and   
                A.CircleofHealing:IsSpellInRange("target") and          
                A.CircleofHealing:PredictHeal("target") 
            )
        )
        then
		    return A.CircleofHealing:Show(icon)
		end



        -- HPvE #1 Circle of Healing (RAID & PARTY)
        if A.CircleofHealing:IsReady(unit) and 
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        A.CircleofHealing:IsSpellLearned() and
        (
            (
                TR.CanHeal(A.CircleofHealing.ID):Mouse() and         
                A.CircleofHealing:IsSpellInRange("mouseover") and
                A.CircleofHealing:PredictHeal("mouseover") and
                CanHealCircleOfHealing("mouseover")
            ) or 
            (
                TR.CanHeal(A.CircleofHealing.ID):Target() and       
                A.CircleofHealing:IsSpellInRange("target") and      
                A.CircleofHealing:PredictHeal("target") and
                CanHealCircleOfHealing("target")
            )
        )
        then
		    return A.CircleofHealing:Show(icon)
		end
		
		
        -- HPvE AoE Halo
        if A.Halo:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        Unit("player"):GetCurrentSpeed() == 0 and
        A.Halo:IsSpellLearned() and
        (
            (
                TR.CanHeal(A.Halo.ID):Mouse() and 
                Unit("mouseover"):GetRange() <= 30 and
                A.Halo:PredictHeal("mouseover")
            ) or 
            (
                TR.CanHeal(A.Halo.ID):Target() and
                Unit("target"):GetRange() <= 30  and
                A.Halo:PredictHeal("target")
            )
        )
        then
		    return A.Halo:Show(icon)
		end


        -- HPvE Halo (RAID & PARTY)
        if A.Halo:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        VarApotheosis == 0 and
        VarCanHealHalo and
        (
            (
                TR.CanHeal(A.Halo.ID):Mouse() --and 
                --Unit("mouseover"):GetRange() <= 30 
            ) or 
            (
                TR.CanHeal(A.Halo.ID):Target() --and
                --Unit("target"):GetRange() <= 30 
            )
        )
        then
		    return A.Halo:Show(icon)
		end

        -- HPvE #2 Flash Heal (PARTY) Trail of Light 
        if A.FlashHeal:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size <= 5 and
        -- Trail of Light 
        A.TrailofLight:IsSpellLearned() and 
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.FlashHeal.ID) == 0 or
            -- Surge of Light
            Unit("player"):HasBuffs(114255, "player", true) > 0
        ) and
        (
            (
                TR.CanHeal(A.FlashHeal.ID):Mouse() and  
                A.FlashHeal:IsSpellInRange("mouseover") and          
                A.FlashHeal:PredictHeal("mouseover") 
            ) or 
            (
                TR.CanHeal(A.FlashHeal.ID):Target() and      
                A.FlashHeal:IsSpellInRange("target") and         
                A.FlashHeal:PredictHeal("target") 
            )
        ) and
        -- If we can heal previous unit
        PredictTrailOfLight("FlashHeal")
        then
		    return A.FlashHeal:Show(icon)
		end

        -- HPvE AoE Prayer of Healing
        if A.PrayerofHealing:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.PrayerofHealing.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.PrayerofHealing.ID):Mouse() and  
                A.PrayerofHealing:IsSpellInRange("mouseover") and
                A.PrayerofHealing:PredictHeal("mouseover")
            ) or 
            (
                TR.CanHeal(A.PrayerofHealing.ID):Target() and      
                A.PrayerofHealing:IsSpellInRange("target") and
                A.PrayerofHealing:PredictHeal("target")
            )
        ) and
        CanHealPrayerOfHealing()
        then
		    return A.PrayerofHealing:Show(icon)
		end


        -- HPvE #1 Prayer of Healing (PARTY)
        if A.PrayerofHealing:IsReady(unit) and 
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size <= 5 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.PrayerofHealing.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.PrayerofHealing.ID):Mouse() and  
                A.PrayerofHealing:IsSpellInRange("mouseover") and
                A.PrayerofHealing:PredictHeal("mouseover")
            ) or 
            (
                TR.CanHeal(A.PrayerofHealing.ID):Target() and      
                A.PrayerofHealing:IsSpellInRange("target") and
                A.PrayerofHealing:PredictHeal("target")
            )
        ) and
        CanHealPrayerOfHealing()
        then
		    return A.PrayerofHealing:Show(icon)
		end

        -- HPvE #1 Prayer of Mending (RAID & PARTY)
        if A.PrayerofMending:IsReady(unit) and  
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.PrayerofMending.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.PrayerofMending.ID):Mouse() and  
                A.PrayerofMending:IsSpellInRange("mouseover") and  
                Unit("mouseover"):TimeToDieX(25) > GetGCD() * 2 and
                (
                    Unit("mouseover"):IsTank() or
                    (
                        Unit("mouseover"):GetRealTimeDMG() > 0 and
                        A.PrayerofMending:PredictHeal("mouseover") 
                    )
                ) and
                CanHealPrayerOfMending("mouseover") and
                Unit("mouseover"):HasBuffsStacks(A.PrayerofMending.ID, "player", true) <= 5        
            ) or 
            (
                TR.CanHeal(A.PrayerofMending.ID):Target() and      
                A.PrayerofMending:IsSpellInRange("target") and  
                Unit("target"):TimeToDieX(25) > GetGCD() * 2 and
                (
                    Unit("target"):IsTank() or
                    (
                        Unit("target"):GetRealTimeDMG() > 0 and
                        A.PrayerofMending:PredictHeal("target")
                    ) 
                ) and
                CanHealPrayerOfMending("target") and
                Unit("target"):HasBuffsStacks(A.PrayerofMending.ID, "player", true) <= 5 
            )
        )
        then
		    return A.PrayerofMending:Show(icon)
		end
		
        -- HPvE #3 Flash Heal (RAID) emergency
        if A.FlashHeal:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size > 5 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.FlashHeal.ID) == 0 or
            -- Surge of Light
            Unit("player"):HasBuffs(114255, "player", true) > 0    
        ) and
        (
            (
                TR.CanHeal(A.FlashHeal.ID):Mouse() and  
                A.FlashHeal:IsSpellInRange("mouseover") and          
                A.FlashHeal:PredictHeal("mouseover") and
                (
                    Unit("mouseover"):HealthPercent() < 40 or
                    Unit("mouseover"):TimeToDieX(20) < GetGCD() * 3
                )
            ) or 
            (
                TR.CanHeal(A.FlashHeal.ID):Target() and      
                A.FlashHeal:IsSpellInRange("target") and         
                A.FlashHeal:PredictHeal("target") and
                ( 
                    Unit("target"):HealthPercent() < 40 or
                    Unit("target"):TimeToDieX(20) < GetGCD() * 3
                )
            )
        )
        then
		    return A.FlashHeal:Show(icon)
		end
		
        -- HPvE #2 Prayer of Healing (RAID)
        if A.PrayerofHealing:IsReady(unit) and 
        A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size > 5 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.PrayerofHealing.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.PrayerofHealing.ID):Mouse() and  
                A.PrayerofHealing:IsSpellInRange("mouseover") and
                A.PrayerofHealing:PredictHeal("mouseover")
            ) or 
            (
                TR.CanHeal(A.PrayerofHealing.ID):Target() and      
                A.PrayerofHealing:IsSpellInRange("target") and
                A.PrayerofHealing:PredictHeal("target")
            )
        ) and
        CanHealPrayerOfHealing()
        then
		    return A.PrayerofHealing:Show(icon)
		end
		
        -- HPvE #2 Renew (PARTY)
        if A.Renew:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
		Unit(unit):HasBuffs(A.Renew.ID, true) < 3 and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size <= 5 and
        (
            (
                TR.CanHeal(A.Renew.ID):Mouse() and  
                A.Renew:IsSpellInRange("mouseover") and
                Unit("mouseover"):PT(A.Renew.ID) and        
                A.Renew:PredictHeal("mouseover") 
            ) or 
            (
                TR.CanHeal(A.Renew.ID):Target() and      
                A.Renew:IsSpellInRange("target") and    
                Unit("target"):PT(A.Renew.ID) and  
                A.Renew:PredictHeal("target") 
            )
        )
        then
		    return A.Renew:Show(icon)
		end
		
        -- HPvE Binding Heal
        if A.BindingHeal:IsReady(unit) and 
        --A.GetToggle(2, "AoE") and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        A.BindingHeal:IsSpellLearned() and 
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.BindingHeal.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.BindingHeal.ID):Mouse() and  
                not UnitIsUnit("player", "mouseover") and 
                A.BindingHeal:IsSpellInRange("mouseover") and
                A.BindingHeal:PredictHeal("mouseover") and
                -- Check if it can heal as well any another unit
                CanHealBindingHeal("mouseover")        
            ) or 
            (
                TR.CanHeal(A.BindingHeal.ID):Target() and    
                not UnitIsUnit("player", "target") and   
                A.BindingHeal:IsSpellInRange("target") and
                A.BindingHeal:PredictHeal("target") and
                -- Check if it can heal as well any another unit
                CanHealBindingHeal("target")
            )
        )
        then
		    return A.BindingHeal:Show(icon)
		end

        -- HPvE Heal (filler)
        if A.Heal:IsReady(unit) and 
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.Heal.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.Heal.ID):Mouse() and  
                A.Heal:IsSpellInRange("mouseover") and          
                A.Heal:PredictHeal("mouseover")       
            ) or 
            (
                TR.CanHeal(A.Heal.ID):Target() and      
                A.Heal:IsSpellInRange("target") and         
                A.Heal:PredictHeal("target") 
            )
        )
        then
		    return A.Heal:Show(icon)
		end

        -- HPvE Symbol of Hope
        if A.SymbolofHope:IsReady(unit) and
        A.BurstIsON(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        Unit("player"):CombatTime() > 150 and -- 2.5 min
        Unit("player"):IsStayingTime() > 4 and
        -- Around Safe phase to cast that
        VarFrequency < 20 and
        -- Inervate
        Unit("player"):HasBuffs(29166, true) == 0 and
        -- If some one healer has < 40% mana
        CanSymbolOfHope(40) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.SymbolofHope:Show(icon)
		end

        -- HPvE #4 Flash Heal (filler)
        if A.FlashHeal:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.FlashHeal.ID) == 0 or
            -- Surge of Light
            Unit("player"):HasBuffs(114255, "player", true) > 0    
        ) and
        (
            (
                TR.CanHeal(A.FlashHeal.ID):Mouse() and  
                A.FlashHeal:IsSpellInRange("mouseover") and          
                A.FlashHeal:PredictHeal("mouseover")       
            ) or 
            (
                TR.CanHeal(A.FlashHeal.ID):Target() and      
                A.FlashHeal:IsSpellInRange("target") and         
                A.FlashHeal:PredictHeal("target") 
            )
        )
        then
		    return A.FlashHeal:Show(icon)
		end

        -- HPvE #2 Prayer of Mending (RAID & PARTY) PreHoT
        if A.PrayerofMending:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
        VarApotheosis == 0 and
        (
            Unit("player"):GetCurrentSpeed() == 0 or
            Unit("player"):CastTime(A.PrayerofMending.ID) == 0    
        ) and
        (
            (
                TR.CanHeal(A.PrayerofMending.ID):Mouse() and  
                A.PrayerofMending:IsSpellInRange("mouseover") and          
                Unit("mouseover"):HasBuffsStacks(A.PrayerofMending.ID, "player", true) <= 5       
            ) or 
            (
                TR.CanHeal(A.PrayerofMending.ID):Target() and      
                A.PrayerofMending:IsSpellInRange("target") and         
                Unit("target"):HasBuffsStacks(A.PrayerofMending.ID, "player", true) <= 5 
            )
        )
        then
		    return A.PrayerofMending:Show(icon)
		end

        -- HPvE #3 Renew (RAID)
        if A.Renew:IsReady(unit) and
        Unit(player):HasSpec(257) and
        not VarIsChanneling and
		Unit(unit):HasBuffs(A.Renew.ID, true) < 3 and
        TeamCache.Friendly.Size and
        TeamCache.Friendly.Size > 5 and
        (
            (
                TR.CanHeal(ID):Mouse() and  
                A.Renew:IsSpellInRange("mouseover") and    
                Unit("mouseover"):PT(A.Renew.ID) and
                A.Renew:PredictHeal("mouseover")         
            ) or 
            (
                TR.CanHeal(ID):Target() and      
                A.Renew:IsSpellInRange("target") and 
                Unit("target"):PT(A.Renew.ID) and
                A.Renew:PredictHeal("target") 
            )
        )
        then
		    return A.Renew:Show(icon)
		end

        -- HPvE #3 Holy Word: Sanctify (single - movement)
        if A.HolyWordSanctify:IsReady(unit) and
        not VarIsChanneling and
        (
            not A.GetToggle(2, "AoE") or
            Unit("player"):GetCurrentSpeed() > 0 
        ) and
        (
            (
                TR.CanHeal(A.HolyWordSanctify.ID):Mouse() and               
                A.HolyWordSanctify:PredictHeal("mouseover") and
                (
                    UnitIsUnit("mouseover", "player") or
                    not IsMouselooking() 
                )
            ) or 
            (
                TR.CanHeal(A.HolyWordSanctify.ID):Target() and             
                A.HolyWordSanctify:PredictHeal("target") and
                (
                    UnitIsUnit("target", "player") or
                    not IsMouselooking() 
                )
            )
        )
        then
		    ApotheosisReason3 = true
		    return A.HolyWordSanctify:Show(icon)
		end
        

        -- HPvE #2 Circle of Healing (RAID & PARTY) (single - movement)
        if A.CircleofHealing:IsReady(unit) and
        not VarIsChanneling and
        ID:IsSpellLearned() and
        (
            not A.GetToggle(2, "AoE") or
            Unit("player"):GetCurrentSpeed() > 0 
        ) and
        (
            (
                TR.CanHeal(A.CircleofHealing.ID):Mouse() and  
                A.CircleofHealing:IsSpellInRange("mouseover") and             
                A.CircleofHealing:PredictHeal("mouseover") 
            ) or 
            (
                TR.CanHeal(A.CircleofHealing.ID):Target() and   
                A.CircleofHealing:IsSpellInRange("target") and          
                A.CircleofHealing:PredictHeal("target") 
            )
        )
        then
		    return A.CircleofHealing:Show(icon)
		end

        -- HPvE #2 Divine Star (single - movement)
        if A.DivineStar:IsReady(unit) and       
        not VarIsChanneling and
        ID:IsSpellLearned() and
        (
            not A.GetToggle(2, "AoE") or
            Unit("player"):GetCurrentSpeed() > 0 
        ) and
        -- Conditions in combat or don't use while combat if we can hit near mob
        (
            Unit("player"):CombatTime() > 0 or
            not AoE(1, 24)
        ) and
        (
            (        
                TR.CanHeal(A.DivineStar.ID):Mouse() and  
                Unit("mouseover"):GetRange() <= 24 and
                A.DivineStar:PredictHeal("mouseover", 200)
            ) or
            (        
                TR.CanHeal(A.DivineStar.ID):Target() and         
                Unit("target"):GetRange() <= 24 and
                A.DivineStar:PredictHeal("target", 200)
            ) 
        )
        then
		    return A.DivineStar:Show(icon)
		end

        -- HPvE #4 Renew (filler)
        if A.Renew:IsReady(unit) and
        not VarIsChanneling and
		Unit(unit):HasBuffs(A.Renew.ID, true) < 3 and
        (
            (
                TR.CanHeal(A.Renew.ID):Mouse() and  
                A.Renew:IsSpellInRange("mouseover") and    
                (Unit("mouseover"):PT(A.Renew.ID) or Unit("mouseover"):HealthPercent() <= 25)
                and
                -- Echo of Light
                Unit("mouseover"):HasBuffs(77489, "player", true) <= GetCurrentGCD()       
            ) or 
            (
                TR.CanHeal(A.Renew.ID):Target() and      
                A.Renew:IsSpellInRange("target") and  
                (Unit("target"):PT(A.Renew.ID) or Unit("target"):HealthPercent() <= 25)
                and
                -- Echo of Light
                Unit("target"):HasBuffs(77489, "player", true) <= GetCurrentGCD()
            )
        )
        then
		    return A.Renew:Show(icon)
		end

        -- HPvE PW:F (Rebuff)
        if A.PowerWordFortitude:IsReady(unit) and
        not VarIsChanneling and
        Unit("player"):CombatTime() > 0 and
        PriestBurst() <= GetCurrentGCD() and
        (
            (
                CanHeal():Mouse(true) and  
                Unit("mouseover"):HasBuffs(A.PowerWordFortitude.ID, true) <= GetCurrentGCD() 
            ) or
            (
                CanHeal():Target(true) and
                Unit("target"):HasBuffs(A.PowerWordFortitude.ID, true) <= GetCurrentGCD() 
            ) or
            (
                not UnitExists("target") and
                not Unit("mouseover"):IsExists() and
                FriendlyTeam(_, 10):MissedBuffs(21562) and
                TMW.time - SpellLastCast("player", 21562) > 10
            )
        )
        then
		    return A.PowerWordFortitude:Show(icon)
		end

        -- HPvE Holy Word: Chastise (DMG)
        if A.HolyWordChastise:IsReady(unit) and
        not VarIsChanneling and
        (
            (
                TR.CanDMG(A.HolyWordChastise.ID):Target() and
                A.HolyWordChastise:IsSpellInRange("target") and                
                (
                    not Unit("target"):IsPlayer() or
                    UnitMagicImun("target") == 0
                )
            ) or
            (
                TR.CanDMG(A.HolyWordChastise.ID):TargetTarget() and 
                A.HolyWordChastise:IsSpellInRange("targettarget") and         
                (
                    not UnitIsPlayer("targettarget") or
                    UnitMagicImun("targettarget") == 0
                )
            ) 
        ) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.HolyWordChastise:Show(icon)
		end

        -- HPvE Holy Fire (DMG)
        if A.HolyFire:IsReady(unit) and
        not VarIsChanneling and
        (
            (
                TR.CanDMG(A.HolyFire.ID):Target() and
                A.HolyFire:IsSpellInRange("target") and                
                (
                    not Unit("target"):IsPlayer() or
                    UnitMagicImun("target") == 0
                )
            ) or
            (
                TR.CanDMG(A.HolyFire.ID):TargetTarget() and 
                A.HolyFire:IsSpellInRange("targettarget") and         
                (
                    not UnitIsPlayer("targettarget") or
                    UnitMagicImun("targettarget") == 0
                )
            ) 
        ) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.HolyFire:Show(icon)
		end

        -- HPvE Smite (DMG)
        if A.Smite:IsReady(unit) and
        not VarIsChanneling and
        Unit("player"):GetCurrentSpeed() == 0 and
        (
            (
                TR.CanDMG(A.Smite.ID):Target() and
                A.Smite:IsSpellInRange("target") and                
                (
                    not Unit("target"):IsPlayer() or
                    UnitMagicImun("target") <= GetCurrentGCD() + Unit("player"):CastTime(A.Smite.ID)
                )
            ) or
            (
                TR.CanDMG(A.Smite.ID):TargetTarget() and 
                A.Smite:IsSpellInRange("targettarget") and         
                (
                    not UnitIsPlayer("targettarget") or
                    UnitMagicImun("targettarget") <= GetCurrentGCD() + Unit("player"):CastTime(A.Smite.ID)
                )
            ) 
        ) and
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.Smite:Show(icon)
		end

        -- HPvE Divine Star (DMG)
        if A.DivineStar:IsReady(unit) and
        not VarIsChanneling and
        A.DivineStar:IsSpellLearned() and
        (
            (
                TR.CanDMG(A.DivineStar.ID):Target() and
                Unit("target"):GetRange() <= 24 and              
                (
                    not Unit("target"):IsPlayer() or
                    UnitMagicImun("target") <= GetCurrentGCD() + 0.2
                )
            ) or
            (
                TR.CanDMG(A.DivineStar.ID):TargetTarget() and 
                Unit("targettarget"):GetRange() <= 24 and      
                (
                    not UnitIsPlayer("targettarget") or
                    UnitMagicImun("targettarget") <= GetCurrentGCD() + 0.2
                )
            ) 
        )
        then
		    return A.DivineStar:Show(icon)
		end

        -- HPvE Angelic Feather
        if A.AngelicFeather:IsReady(unit) and
        AngelicFeather_Toggle and
        not VarIsChanneling and
        not Player:IsMounted() and
        Unit("player"):CombatTime() > 0 and
        A.AngelicFeather:IsSpellLearned() and
        (
            (
                TR.CanHeal(A.AngelicFeather.ID):Mouse(true) and               
                UnitInRange("mouseover") and
                Unit("mouseover"):GetCurrentSpeed() > 90 and
                Unit("mouseover"):GetMaxSpeed() < 130 and
                Unit("mouseover"):HasBuffs("Speed") == 0 and
                (
                    UnitIsUnit("mouseover", "player") or
                    (
                        not IsMouselooking() and
                        TMW.time - SpellLastCast("player", ID) > 3
                    )
                )
            ) or 
            (
                TR.CanHeal(A.AngelicFeather.ID):Target(true) and
                UnitInRange("target") and
                Unit("target"):GetCurrentSpeed() > 90 and
                Unit("target"):GetMaxSpeed() < 130 and
                Unit("target"):HasBuffs("Speed") == 0 and
                (
                    UnitIsUnit("target", "player") or
                    (
                        not IsMouselooking() and
                        TMW.time - SpellLastCast("player", ID) > 3
                    )            
                )
            )
        ) and
        -- Spirit of Redemption -- STOP CAST
        Unit("player"):HasBuffs(215769, true) == 0
        then
		    return A.AngelicFeather:Show(icon)
		end     
		
    end 
    HealingDamageRotation = Action.MakeFunctionCachedDynamic(HealingDamageRotation)
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
	
	-- Heal / DPS mouseover
	if Unit("mouseover"):IsExists() then
	    unit = mouseover 
		
        if HealingDamageRotation(unit) then 
            return true 
        end             
    end		

	-- Heal / DPS target
	if Unit("target"):IsExists() then
	    unit = target 
		
        if HealingDamageRotation(unit) then 
            return true 
        end             
    end	
	
	-- Heal / DPS targettarget
	if Unit("targettarget"):IsExists() then
	    unit = targettarget 
		
        if HealingDamageRotation(unit) then 
            return true 
        end             
    end	
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    --if Player:IsMovingTime() < 2.5 then 
    --    return 
    --end 
        
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

local function RotationPassive(icon)
    if not GetToggle(2, "UseRotationPassive") then 
        return 
    end 
    RotationsVariables()





  
end 


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
end ]]--


local function ArenaRotation(icon, unit)
    RotationsVariables()
    
    if A.IsInPvP and (A.Zone == "arena") and (unit == "arena1" or unit == "arena2" or unit == "arena3") and not Player:IsStealthed() and not Player:IsMounted() then
        return

    end 
end 

local function PartyRotation(unit)
    RotationsVariables()
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
    
    -- Party Dispel
    if A.DispelMagic:IsReady(unit) and
    A.GetToggle(2, "Dispel") and
    AuraIsValid(unit, "UseDispel", "Dispel")
    then
	    return A.DispelMagic
	end
	
    -- Party Purje
    if A.Purify:IsReady(unit) and
    A.GetToggle(2, "Purje") and
    Purje(unit) and
    (
        -- Spirit of Redemption
        Unit("player"):HasBuffs(215769, true) == 0
    )
    then
	    return A.Purify
	end
    
end 

A[6] = function(icon)
    -- Call rotations variables
    RotationsVariables()
    
    -- StopCast OverHeal
   -- if Temp.LastPrimaryUnitID and CanStopCastingOverHeal() and StopCastOverHeal then 
   --     return A:Show(icon, ACTION_CONST_STOPCAST)
  --  end

    -- Stop Cast M+ Quake Affix
    if Unit(player):IsCastingRemains() > 0 and StopCastQuake and Unit(player):HasDeBuffs(A.Quake.ID) <= StopCastQuakeSec and Unit(player):HasDeBuffs(A.Quake.ID) > 0 then
        return A:Show(icon, ACTION_CONST_STOPCAST)
    end
  
    if RotationPassive(icon) then 
        return true 
    end 
    
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
    
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end   
    
    local Arena = ArenaRotation("arena2")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[8] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
    
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end