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

Action[ACTION_CONST_MONK_BREWMASTER] = {
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
    ChiBurst                               = Create({ Type = "Spell", ID = 123986 }),
    ChiWave                                = Create({ Type = "Spell", ID = 115098 }),
    DampenHarm                             = Create({ Type = "Spell", ID = 122278 }),
    FortifyingBrewBuff                     = Create({ Type = "Spell", ID = 115203 }),
    FortifyingBrew                         = Create({ Type = "Spell", ID = 115203 }),
    DampenHarmBuff                         = Create({ Type = "Spell", ID = 122278 }),
    DiffuseMagicBuff                       = Create({ Type = "Spell", ID =  }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    InvokeNiuzaotheBlackOx                 = Create({ Type = "Spell", ID = 132578 }),
    IronskinBrew                           = Create({ Type = "Spell", ID = 115308 }),
    BlackoutComboBuff                      = Create({ Type = "Spell", ID = 228563 }),
    ElusiveBrawlerBuff                     = Create({ Type = "Spell", ID =  }),
    IronskinBrewBuff                       = Create({ Type = "Spell", ID = 215479 }),
    Brews                                  = Create({ Type = "Spell", ID = 115308 }),
    BlackOxBrew                            = Create({ Type = "Spell", ID = 115399 }),
    PurifyingBrew                          = Create({ Type = "Spell", ID = 119582 }),
    KegSmash                               = Create({ Type = "Spell", ID = 121253 }),
    TigerPalm                              = Create({ Type = "Spell", ID = 100780 }),
    RushingJadeWind                        = Create({ Type = "Spell", ID = 116847 }),
    RushingJadeWindBuff                    = Create({ Type = "Spell", ID = 116847 }),
    SpecialDelivery                        = Create({ Type = "Spell", ID =  }),
    ExpelHarm                              = Create({ Type = "Spell", ID =  }),
    BlackoutStrike                         = Create({ Type = "Spell", ID = 205523 }),
    ConcentratedFlameDebuff                = Create({ Type = "Spell", ID =  }),
    HeartEssence                           = Create({ Type = "Spell", ID = 298554 }),
    TheCrucibleofFlame                     = Create({ Type = "Spell", ID =  }),
    BreathofFire                           = Create({ Type = "Spell", ID = 115181 }),
    BreathofFireDotDebuff                  = Create({ Type = "Spell", ID = 123725 }),
    BlackoutCombo                          = Create({ Type = "Spell", ID = 196736 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 })
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
Action:CreateEssencesFor(ACTION_CONST_MONK_BREWMASTER)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MONK_BREWMASTER], { __index = Action })





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
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
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
            if A.ProlongedPower:IsReady(unit) and Potion then
                return A.ProlongedPower:Show(icon)
            end
            
            -- chi_burst
            if A.ChiBurst:IsReady(unit) then
                return A.ChiBurst:Show(icon)
            end
            
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- gift_of_the_ox,if=health<health.max*0.65
            -- dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down
            if A.DampenHarm:IsReady(unit) and (incoming_damage_1500ms and Unit("player"):HasBuffsDown(A.FortifyingBrewBuff.ID, true)) then
                return A.DampenHarm:Show(icon)
            end
            
            -- fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)
            if A.FortifyingBrew:IsReady(unit) and (incoming_damage_1500ms and (Unit("player"):HasBuffsDown(A.DampenHarmBuff.ID, true) or Unit("player"):HasBuffsDown(A.DiffuseMagicBuff.ID, true))) then
                return A.FortifyingBrew:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):HealthPercent() < 31 or Unit(unit):TimeToDie() < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_items
            -- potion
            if A.ProlongedPower:IsReady(unit) and Potion then
                return A.ProlongedPower:Show(icon)
            end
            
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
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
            
            -- invoke_niuzao_the_black_ox,if=target.time_to_die>25
            if A.InvokeNiuzaotheBlackOx:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):TimeToDie() > 25) then
                return A.InvokeNiuzaotheBlackOx:Show(icon)
            end
            
            -- ironskin_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2&!buff.ironskin_brew.up
            if A.IronskinBrew:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BlackoutComboBuff.ID, true) and incoming_damage_1999ms > (health.max * 0.1 + stagger.last_tick_damage_4) and Unit("player"):HasBuffsStacks(A.ElusiveBrawlerBuff.ID, true) < 2 and not Unit("player"):HasBuffs(A.IronskinBrewBuff.ID, true)) then
                return A.IronskinBrew:Show(icon)
            end
            
            -- ironskin_brew,if=cooldown.brews.charges_fractional>1&cooldown.black_ox_brew.remains<3&buff.ironskin_brew.remains<15
            if A.IronskinBrew:IsReady(unit) and (A.Brews:GetSpellChargesFrac() > 1 and A.BlackOxBrew:GetCooldown() < 3 and Unit("player"):HasBuffs(A.IronskinBrewBuff.ID, true) < 15) then
                return A.IronskinBrew:Show(icon)
            end
            
            -- purifying_brew,if=stagger.pct>(6*(3-(cooldown.brews.charges_fractional)))&(stagger.last_tick_damage_1>((0.02+0.001*(3-cooldown.brews.charges_fractional))*stagger.last_tick_damage_30))
            if A.PurifyingBrew:IsReady(unit) and (stagger.pct > (6 * (3 - (A.Brews:GetSpellChargesFrac()))) and (stagger.last_tick_damage_1 > ((0.02 + 0.001 * (3 - A.Brews:GetSpellChargesFrac())) * stagger.last_tick_damage_30))) then
                return A.PurifyingBrew:Show(icon)
            end
            
            -- black_ox_brew,if=cooldown.brews.charges_fractional<0.5
            if A.BlackOxBrew:IsReady(unit) and (A.Brews:GetSpellChargesFrac() < 0.5) then
                return A.BlackOxBrew:Show(icon)
            end
            
            -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
            if A.BlackOxBrew:IsReady(unit) and ((Player:EnergyPredicted() + (Player:EnergyRegen() * A.KegSmash:GetCooldown())) < 40 and Unit("player"):HasBuffsDown(A.BlackoutComboBuff.ID, true) and A.KegSmash:GetCooldown() == 0) then
                return A.BlackOxBrew:Show(icon)
            end
            
            -- keg_smash,if=spell_targets>=2
            if A.KegSmash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.KegSmash:Show(icon)
            end
            
            -- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
            if A.TigerPalm:IsReady(unit) and (A.RushingJadeWind:IsSpellLearned() and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) and Unit("player"):HasBuffs(A.RushingJadeWindBuff.ID, true)) then
                return A.TigerPalm:Show(icon)
            end
            
            -- tiger_palm,if=(talent.invoke_niuzao_the_black_ox.enabled|talent.special_delivery.enabled)&buff.blackout_combo.up
            if A.TigerPalm:IsReady(unit) and ((A.InvokeNiuzaotheBlackOx:IsSpellLearned() or A.SpecialDelivery:IsSpellLearned()) and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true)) then
                return A.TigerPalm:Show(icon)
            end
            
            -- expel_harm,if=buff.gift_of_the_ox.stack>4
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff.ID, true) > 4) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- blackout_strike
            if A.BlackoutStrike:IsReady(unit) then
                return A.BlackoutStrike:Show(icon)
            end
            
            -- keg_smash
            if A.KegSmash:IsReady(unit) then
                return A.KegSmash:Show(icon)
            end
            
            -- concentrated_flame,if=dot.concentrated_flame.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.ConcentratedFlameDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- heart_essence,if=!essence.the_crucible_of_flame.major
            if A.HeartEssence:IsReady(unit) and (not Azerite:EssenceHasMajor(A.TheCrucibleofFlame.ID)) then
                return A.HeartEssence:Show(icon)
            end
            
            -- expel_harm,if=buff.gift_of_the_ox.stack>=3
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff.ID, true) >= 3) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true)) then
                return A.RushingJadeWind:Show(icon)
            end
            
            -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable))
            if A.BreathofFire:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BlackoutComboBuff.ID, true) and (Unit("player"):HasNotHeroism or (Unit("player"):HasHeroism and true and Unit(unit):HasDeBuffsRefreshable(A.BreathofFireDotDebuff.ID, true)))) then
                return A.BreathofFire:Show(icon)
            end
            
            -- chi_burst
            if A.ChiBurst:IsReady(unit) then
                return A.ChiBurst:Show(icon)
            end
            
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            
            -- expel_harm,if=buff.gift_of_the_ox.stack>=2
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff.ID, true) >= 2) then
                return A.ExpelHarm:Show(icon)
            end
            
            -- tiger_palm,if=!talent.blackout_combo.enabled&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
            if A.TigerPalm:IsReady(unit) and (not A.BlackoutCombo:IsSpellLearned() and A.KegSmash:GetCooldown() > GetGCD() and (Player:EnergyPredicted() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + GetGCD()))) >= 65) then
                return A.TigerPalm:Show(icon)
            end
            
            -- arcane_torrent,if=energy<31
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:EnergyPredicted() < 31) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- rushing_jade_wind
            if A.RushingJadeWind:IsReady(unit) then
                return A.RushingJadeWind:Show(icon)
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

