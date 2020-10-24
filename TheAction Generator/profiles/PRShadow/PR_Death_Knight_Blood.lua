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

Action[ACTION_CONST_DEATHKNIGHT_BLOOD] = {
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
    DancingRuneWeaponBuff                  = Create({ Type = "Spell", ID = 81256 }),
    AnimaofDeath                           = Create({ Type = "Spell", ID =  }),
    VampiricBloodBuff                      = Create({ Type = "Spell", ID = 55233 }),
    DeathStrike                            = Create({ Type = "Spell", ID = 49998 }),
    BloodDrinker                           = Create({ Type = "Spell", ID = 206931 }),
    Marrowrend                             = Create({ Type = "Spell", ID = 195182 }),
    BoneShieldBuff                         = Create({ Type = "Spell", ID = 195181 }),
    BloodBoil                              = Create({ Type = "Spell", ID = 50842 }),
    HemostasisBuff                         = Create({ Type = "Spell", ID = 273947 }),
    Bonestorm                              = Create({ Type = "Spell", ID = 194844 }),
    Heartbreaker                           = Create({ Type = "Spell", ID = 221536 }),
    DeathandDecay                          = Create({ Type = "Spell", ID = 43265 }),
    HeartStrike                            = Create({ Type = "Spell", ID = 206930 }),
    CrimsonScourgeBuff                     = Create({ Type = "Spell", ID = 81141 }),
    RapidDecomposition                     = Create({ Type = "Spell", ID = 194662 }),
    Consumption                            = Create({ Type = "Spell", ID = 205223 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    DancingRuneWeapon                      = Create({ Type = "Spell", ID = 49028 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    ArcanePulse                            = Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    UnholyStrengthBuff                     = Create({ Type = "Spell", ID = 53365 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    VampiricBlood                          = Create({ Type = "Spell", ID = 55233 }),
    Tombstone                              = Create({ Type = "Spell", ID = 219809 })
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
A:CreateCovenantsFor(ACTION_CONST_DEATHKNIGHT_BLOOD)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_BLOOD], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- BLOOD PRE APL SETUP -----------
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
	BigDeff                                 = {A.DancingRuneWeapon.ID, A.IceboundFortitude.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.HeartStrike:IsInRange(unit)
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
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- RuneTap	
    if A.RuneTap:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "RuneTapIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local RT_HP                 = A.GetToggle(2, "RuneTapHP")
        local RT_TTD                = A.GetToggle(2, "RuneTapTTD")
        local RT_UNITS              = A.GetToggle(2, "RuneTapUnits")
        if  (    
                ( RT_HP     >= 0     or RT_TTD                              >= 0                                     ) and 
                ( RT_HP     <= 0     or Unit(player):HealthPercent()     <= RT_HP                                    ) and 
                ( RT_TTD     <= 0     or Unit(player):TimeToDie()         <= RT_TTD                                  ) and
				( RT_UNITS   >= 0 and MultiUnits:GetByRange(8) >= RT_UNITS and Player:AreaTTD(8) > 3 and (Unit(player):HealthPercent() <= RT_HP or Unit(player):TimeToDie() <= RT_TTD) )
            ) 
		    or 
            (
                A.GetToggle(2, "RuneTapCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.RuneTap
        end 
    end 
		
    -- Emergency AntiMagicShell
    local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
	local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellTTDMagic")
    local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellTTDMagicHP")
	local total, Hits, phys, magic = Unit(player):GetDMG()
	local RTtotal, RTHits, RTphys, RTmagic = Unit(player):GetRealTimeDMG()
		
    if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
    (
        (   -- Auto 
            AntiMagicShell >= 100 and 
            (
                -- HP lose per sec >= 10
                magic * 100 / Unit(player):HealthMax() >= 10 or 
                RTmagic >= Unit(player):HealthMax() * 0.10 or 
                -- TTD Magic
                Unit(player):TimeToDieMagicX(AntiMagicShellTTDMagicHP) < AntiMagicShellTTDMagic or 
				-- GGL logic by Ayni on magic inc damage
				Unit(player):GetDMG(4) > Unit(player):GetDMG() / 2 or
				Unit(player):GetDMG(4) * 5 >= A.AntiMagicShell:GetSpellDescription()[1] or
					
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
            AntiMagicShell < 100 and 
            Unit(player):HealthPercent() <= AntiMagicShell
        )
    ) 
    then 
        return A.AntiMagicShell
    end 
		
    -- Icebound Fortitude	
    if A.IceboundFortitude:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "IceboundFortitudeIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local IF_HP                 = A.GetToggle(2, "IceboundFortitudeHP")
        local IF_TTD                = A.GetToggle(2, "IceboundFortitudeTTD")
            
        if  (    
                ( IF_HP     >= 0     or IF_TTD                              >= 0                                     ) and 
                ( IF_HP     <= 0     or Unit(player):HealthPercent()     <= IF_HP                                    ) and 
                ( IF_TTD    <= 0     or Unit(player):TimeToDie()         <= IF_TTD                                   ) 
            ) 
		    or 
            (
                A.GetToggle(2, "IceboundFortitudeCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.IceboundFortitude
        end 
    end 
	
    -- Vampiric Blood
    if A.VampiricBlood:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "VampiricBloodIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local VB_HP                 = A.GetToggle(2, "VampiricBloodHP")
        local VB_TTD                = A.GetToggle(2, "VampiricBloodTTD")
            
        if  (    
                ( VB_HP     >= 0     or VB_TTD                           >= 0                                     ) and 
                ( VB_HP     <= 0     or Unit(player):HealthPercent()     <= VB_HP                                 ) and 
                ( VB_TTD    <= 0     or Unit(player):TimeToDie()         <= VB_TTD                                )  
            ) 
			or 
            (
                A.GetToggle(2, "VampiricBloodCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 30 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then                
            -- VampiricBlood
            return A.VampiricBlood         -- #3                  
             
        end 
    end
	
    -- Dancing Rune Weapon
    if A.DancingRuneWeapon:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "DancingRuneWeaponIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local DRW_HP                 = A.GetToggle(2, "DancingRuneWeaponHP")
        local DRW_TTD                = A.GetToggle(2, "DancingRuneWeaponTTD")
            
        if  (    
                ( DRW_HP     >= 0     or DRW_TTD                          >= 0                                     ) and 
                ( DRW_HP     <= 0     or Unit(player):HealthPercent()     <= DRW_HP                                ) and 
                ( DRW_TTD    <= 0     or Unit(player):TimeToDie()         <= DRW_TTD                               )  
            ) 
			or 
            (
                A.GetToggle(2, "DancingRuneWeaponCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 25 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- Marrowrend
            if A.Marrowrend:IsReadyByPassCastGCD(player, nil, nil, true) and Player:RunicPower() >= A.Marrowrend:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 then  
                return A.Marrowrend        -- #4
            end 
                
            -- DancingRuneWeapon
            return A.DancingRuneWeapon         -- #3                  
             
        end 
    end		

    -- Emergency Death Pact
    local DeathPact = Action.GetToggle(2, "DeathPactHP")
    if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
    (
        (   -- Auto 
            DeathPact >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(10) < 5 or 
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
            DeathPact < 100 and 
            Unit(player):HealthPercent() <= DeathPact
        )
    ) 
    then 
        return A.DeathPact
    end  		

	-- SuperiorSteelskinPotion
    local SuperiorSteelskinPotion = A.GetToggle(2, "SuperiorSteelskinPotionHP")
    if     SuperiorSteelskinPotion >= 0 and A.SuperiorSteelskinPotion:IsReady(player) and 
    (
        (     -- Auto 
            SuperiorSteelskinPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 3 or 
				GetByRange(5, 15) and Unit(player):HealthPercent() <= 25 and Player:AreaTTD(15) > 20 or
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
            SuperiorSteelskinPotion < 100 and 
            Unit(player):HealthPercent() <= SuperiorSteelskinPotion
        )
    ) 
    then 
        return A.SuperiorSteelskinPotion
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
    if not A.MindFreeze:IsReadyByPassCastGCD(unit) or not A.MindFreeze:AbsentImun(unit, Temp.TotalAndMagKick) then
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
    
	-- Check for current cast >= interface latency to avoid wasting interrupt too late
	if castRemainsTime >= A.GetLatency() then
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
	
        -- DeathGrip
        if useCC and A.DeathGrip:IsReady(unit) and DeathGripInterrupt then 
            return A.DeathGrip
   	    end 
	
   	    -- Asphyxiate
   	    if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
   	        return A.Asphyxiate
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

local function PredictDS() 
    local ReceivedLast5sec, HP7 = Unit(player):GetLastTimeDMGX(5) * 0.25, Unit(player):HealthMax() * 0.07  
    -- if this value lower than 7% then set fixed 7% heal    
    if ReceivedLast5sec <= HP7 then         
        ReceivedLast5sec = HP7    
    end 
    -- Extra buff which adding additional +10% heal 
    --[[
    if Env.Buffs("player", 101568, "player") > 0 then 
        ReceivedLast5sec = ReceivedLast5sec + HP10
    end ]]
    return Unit(player):HealthMax() - Unit(player):HealthPercent() >= ReceivedLast5sec or ReceivedLast5sec >= Unit(player):HealthMax() * 0.25
end 

local function TargetWithAgroExsist()

        local agroLevels = {}
        agroLevels[0] = false
        agroLevels[1] = false
        agroLevels[2] = false
        agroLevels[3] = false

        local DarkCommand_Nameplates = MultiUnits:GetActiveUnitPlates()
        if DarkCommand_Nameplates then
            for DarkCommand_UnitID in pairs(DarkCommand_Nameplates) do
                if Unit(DarkCommand_UnitID):CombatTime() > 0
                        and Unit(DarkCommand_UnitID):GetRange() <= 30
                        and not Unit(DarkCommand_UnitID):IsTotem()
                        and not Unit(DarkCommand_UnitID):IsPlayer()
                        and not Unit(DarkCommand_UnitID):IsExplosives()
                        and not Unit(DarkCommand_UnitID):IsDummy()
                then
                    if Unit(player):ThreatSituation(DarkCommand_UnitID) ~= nil then
                        agroLevels[Unit(player):ThreatSituation(DarkCommand_UnitID)] = true
                    end
                end
            end
        end

        return agroLevels
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
            -- potion
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast
            if A.CyclotronicBlast:IsReady(unit) then
                return A.CyclotronicBlast:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- concentrated_flame,if=dot.concentrated_flame_burn.remains<2&!buff.dancing_rune_weapon.up
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) < 2 and not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- anima_of_death,if=buff.vampiric_blood.up&(raid_event.adds.exists|raid_event.adds.in>15)
            if A.AnimaofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.VampiricBloodBuff.ID, true) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 15)) then
                return A.AnimaofDeath:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=rune.time_to_1>gcd&runic_power<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:RuneTimeToX(1) > GetGCD() and Player:RunicPower() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space,if=!buff.dancing_rune_weapon.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
        end
        
        --Standard
        local function Standard(unit)
        
            -- death_strike,if=runic_power.deficit<=10
            if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= 10) then
                return A.DeathStrike:Show(icon)
            end
            
            -- blooddrinker,if=!buff.dancing_rune_weapon.up
            if A.BloodDrinker:IsReady(unit) and (not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.BloodDrinker:Show(icon)
            end
            
            -- marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
            if A.Marrowrend:IsReady(unit) and ((Unit("player"):HasBuffs(A.BoneShieldBuff.ID, true) <= Player:RuneTimeToX(3) or Unit("player"):HasBuffs(A.BoneShieldBuff.ID, true) <= (GetGCD() + num(A.BloodDrinker:GetCooldown() == 0) * num(A.BloodDrinker:IsSpellLearned()) * 2) or Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 3) and Player:RunicPowerDeficit() >= 20) then
                return A.Marrowrend:Show(icon)
            end
            
            -- blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
            if A.BloodBoil:IsReady(unit) and (A.BloodBoil:GetSpellChargesFrac() >= 1.8 and (Unit("player"):HasBuffsStacks(A.HemostasisBuff.ID, true) <= (5 - MultiUnits:GetByRangeInCombat(5, 5, 10)) or MultiUnits:GetByRangeInCombat(5, 5, 10) > 2)) then
                return A.BloodBoil:Show(icon)
            end
            
            -- marrowrend,if=buff.bone_shield.stack<5&runic_power.deficit>=15
            if A.Marrowrend:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 5 and Player:RunicPowerDeficit() >= 15) then
                return A.Marrowrend:Show(icon)
            end
            
            -- bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
            if A.Bonestorm:IsReady(unit) and (Player:RunicPower() >= 100 and not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.Bonestorm:Show(icon)
            end
            
            -- death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|target.1.time_to_die<10
            if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= (15 + num(Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) * 5 + MultiUnits:GetByRangeInCombat(5, 5, 10) * num(A.Heartbreaker:IsSpellLearned()) * 2) or target.1.time_to_die < 10) then
                return A.DeathStrike:Show(icon)
            end
            
            -- death_and_decay,if=spell_targets.death_and_decay>=3
            if A.DeathandDecay:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3) then
                return A.DeathandDecay:Show(icon)
            end
            
            -- heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
            if A.HeartStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) or Player:RuneTimeToX(4) < GetGCD()) then
                return A.HeartStrike:Show(icon)
            end
            
            -- blood_boil,if=buff.dancing_rune_weapon.up
            if A.BloodBoil:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.BloodBoil:Show(icon)
            end
            
            -- death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
            if A.DeathandDecay:IsReady(unit) and (Unit("player"):HasBuffs(A.CrimsonScourgeBuff.ID, true) or A.RapidDecomposition:IsSpellLearned() or MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2) then
                return A.DeathandDecay:Show(icon)
            end
            
            -- consumption
            if A.Consumption:IsReady(unit) then
                return A.Consumption:Show(icon)
            end
            
            -- blood_boil
            if A.BloodBoil:IsReady(unit) then
                return A.BloodBoil:Show(icon)
            end
            
            -- heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
            if A.HeartStrike:IsReady(unit) and (Player:RuneTimeToX(3) < GetGCD() or Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) > 6) then
                return A.HeartStrike:Show(icon)
            end
            
            -- use_item,name=grongs_primal_rage
            if A.GrongsPrimalRage:IsReady(unit) then
                return A.GrongsPrimalRage:Show(icon)
            end
            
            -- arcane_torrent,if=runic_power.deficit>20
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 20) then
                return A.ArcaneTorrent:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.DancingRuneWeapon:GetCooldown() == 0 and (not A.BloodDrinker:GetCooldown() == 0 or not A.BloodDrinker:IsSpellLearned())) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_pulse,if=active_enemies>=2|rune<1&runic_power.deficit>60
            if A.ArcanePulse:AutoRacial(unit) and Racial and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or Player:Rune() < 1 and Player:RunicPowerDeficit() > 60) then
                return A.ArcanePulse:Show(icon)
            end
            
            -- lights_judgment,if=buff.unholy_strength.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- use_items,if=cooldown.dancing_rune_weapon.remains>90
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                return A.RazdunksBigRedButton:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=cooldown.dancing_rune_weapon.remains&!buff.dancing_rune_weapon.up&rune.time_to_4>cast_time
            if A.CyclotronicBlast:IsReady(unit) and (A.DancingRuneWeapon:GetCooldown() and not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) and Player:RuneTimeToX(4) > A.CyclotronicBlast:GetSpellCastTime()) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=(cooldown.dancing_rune_weapon.remains<5&target.time_to_die>15)|(target.time_to_die<34)
            if A.AzsharasFontofPower:IsReady(unit) and ((A.DancingRuneWeapon:GetCooldown() < 5 and Unit(unit):TimeToDie() > 15) or (Unit(unit):TimeToDie() < 34)) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=merekthas_fang,if=(cooldown.dancing_rune_weapon.remains&!buff.dancing_rune_weapon.up&rune.time_to_4>3)&!raid_event.adds.exists|raid_event.adds.in>15
            if A.MerekthasFang:IsReady(unit) and ((A.DancingRuneWeapon:GetCooldown() and not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) and Player:RuneTimeToX(4) > 3) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 15) then
                return A.MerekthasFang:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=target.health.pct<31&equipped.dribbling_inkpod
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HealthPercent() < 31 and A.DribblingInkpod:IsExists()) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=buff.dancing_rune_weapon.up&debuff.razor_coral_debuff.up&!equipped.dribbling_inkpod
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and not A.DribblingInkpod:IsExists()) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- vampiric_blood
            if A.VampiricBlood:IsReady(unit) then
                return A.VampiricBlood:Show(icon)
            end
            
            -- potion,if=buff.dancing_rune_weapon.up
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- dancing_rune_weapon,if=!talent.blooddrinker.enabled|!cooldown.blooddrinker.ready
            if A.DancingRuneWeapon:IsReady(unit) and A.BurstIsON(unit) and (not A.BloodDrinker:IsSpellLearned() or not A.BloodDrinker:GetCooldown() == 0) then
                return A.DancingRuneWeapon:Show(icon)
            end
            
            -- tombstone,if=buff.bone_shield.stack>=7
            if A.Tombstone:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) >= 7) then
                return A.Tombstone:Show(icon)
            end
            
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- call_action_list,name=standard
            if Standard(unit) then
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

