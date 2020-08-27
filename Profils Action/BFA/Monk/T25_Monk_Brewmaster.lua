--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_MONK_BREWMASTER] = {
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
    ChiBurst                               = Action.Create({ Type = "Spell", ID = 123986 }),
    ChiWave                                = Action.Create({ Type = "Spell", ID = 115098 }),
    DampenHarm                             = Action.Create({ Type = "Spell", ID = 122278 }),
    FortifyingBrewBuff                     = Action.Create({ Type = "Spell", ID = 115203 }),
    FortifyingBrew                         = Action.Create({ Type = "Spell", ID = 115203 }),
    DampenHarmBuff                         = Action.Create({ Type = "Spell", ID = 122278 }),
    DiffuseMagicBuff                       = Action.Create({ Type = "Spell", ID =  }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  }),
    InvokeNiuzaotheBlackOx                 = Action.Create({ Type = "Spell", ID = 132578 }),
    IronskinBrew                           = Action.Create({ Type = "Spell", ID = 115308 }),
    BlackoutComboBuff                      = Action.Create({ Type = "Spell", ID = 228563 }),
    ElusiveBrawlerBuff                     = Action.Create({ Type = "Spell", ID =  }),
    IronskinBrewBuff                       = Action.Create({ Type = "Spell", ID = 215479 }),
    Brews                                  = Action.Create({ Type = "Spell", ID = 115308 }),
    BlackOxBrew                            = Action.Create({ Type = "Spell", ID = 115399 }),
    PurifyingBrew                          = Action.Create({ Type = "Spell", ID = 119582 }),
    KegSmash                               = Action.Create({ Type = "Spell", ID = 121253 }),
    TigerPalm                              = Action.Create({ Type = "Spell", ID = 100780 }),
    RushingJadeWind                        = Action.Create({ Type = "Spell", ID = 116847 }),
    RushingJadeWindBuff                    = Action.Create({ Type = "Spell", ID = 116847 }),
    SpecialDelivery                        = Action.Create({ Type = "Spell", ID =  }),
    ExpelHarm                              = Action.Create({ Type = "Spell", ID =  }),
    BlackoutStrike                         = Action.Create({ Type = "Spell", ID = 205523 }),
    ConcentratedFlameDebuff                = Action.Create({ Type = "Spell", ID =  }),
    HeartEssence                           = Action.Create({ Type = "Spell", ID = 298554 }),
    TheCrucibleofFlame                     = Action.Create({ Type = "Spell", ID =  }),
    BreathofFire                           = Action.Create({ Type = "Spell", ID = 115181 }),
    BreathofFireDotDebuff                  = Action.Create({ Type = "Spell", ID = 123725 }),
    BlackoutCombo                          = Action.Create({ Type = "Spell", ID = 196736 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 })
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
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
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
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
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- gift_of_the_ox,if=health<health.max*0.65
            -- dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down
            if A.DampenHarm:IsReady(unit) and (bool(incoming_damage_1500ms) and bool(Unit("player"):HasBuffsDown(A.FortifyingBrewBuff.ID, true))) then
                return A.DampenHarm:Show(icon)
            end
            -- fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)
            if A.FortifyingBrew:IsReady(unit) and (bool(incoming_damage_1500ms) and (bool(Unit("player"):HasBuffsDown(A.DampenHarmBuff.ID, true)) or bool(Unit("player"):HasBuffsDown(A.DiffuseMagicBuff.ID, true)))) then
                return A.FortifyingBrew:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):HealthPercent() < 31 or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_items
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
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
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            -- invoke_niuzao_the_black_ox,if=target.time_to_die>25
            if A.InvokeNiuzaotheBlackOx:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):TimeToDie() > 25) then
                return A.InvokeNiuzaotheBlackOx:Show(icon)
            end
            -- ironskin_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2&!buff.ironskin_brew.up
            if A.IronskinBrew:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff.ID, true)) and incoming_damage_1999ms > (health.max * 0.1 + stagger.last_tick_damage_4) and Unit("player"):HasBuffsStacks(A.ElusiveBrawlerBuff.ID, true) < 2 and not Unit("player"):HasBuffs(A.IronskinBrewBuff.ID, true)) then
                return A.IronskinBrew:Show(icon)
            end
            -- ironskin_brew,if=cooldown.brews.charges_fractional>1&cooldown.black_ox_brew.remains<3&buff.ironskin_brew.remains<15
            if A.IronskinBrew:IsReady(unit) and (A.Brews:ChargesFractionalP() > 1 and A.BlackOxBrew:GetCooldown() < 3 and Unit("player"):HasBuffs(A.IronskinBrewBuff.ID, true) < 15) then
                return A.IronskinBrew:Show(icon)
            end
            -- purifying_brew,if=stagger.pct>(6*(3-(cooldown.brews.charges_fractional)))&(stagger.last_tick_damage_1>((0.02+0.001*(3-cooldown.brews.charges_fractional))*stagger.last_tick_damage_30))
            if A.PurifyingBrew:IsReady(unit) and (stagger.pct > (6 * (3 - (A.Brews:ChargesFractionalP()))) and (stagger.last_tick_damage_1 > ((0.02 + 0.001 * (3 - A.Brews:ChargesFractionalP())) * stagger.last_tick_damage_30))) then
                return A.PurifyingBrew:Show(icon)
            end
            -- black_ox_brew,if=cooldown.brews.charges_fractional<0.5
            if A.BlackOxBrew:IsReady(unit) and (A.Brews:ChargesFractionalP() < 0.5) then
                return A.BlackOxBrew:Show(icon)
            end
            -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
            if A.BlackOxBrew:IsReady(unit) and ((Player:EnergyPredicted() + (Player:EnergyRegen() * A.KegSmash:GetCooldown())) < 40 and bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff.ID, true)) and A.KegSmash:GetCooldown() == 0) then
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
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ConcentratedFlameDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- heart_essence,if=!essence.the_crucible_of_flame.major
            if A.HeartEssence:IsReady(unit) and (not bool(Azerite:EssenceHasMajor(A.TheCrucibleofFlame.ID))) then
                return A.HeartEssence:Show(icon)
            end
            -- expel_harm,if=buff.gift_of_the_ox.stack>=3
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff.ID, true) >= 3) then
                return A.ExpelHarm:Show(icon)
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true))) then
                return A.RushingJadeWind:Show(icon)
            end
            -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable))
            if A.BreathofFire:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff.ID, true)) and (Unit("player"):HasNotHeroism or (Unit("player"):HasHeroism and true and Unit(unit):HasDeBuffsRefreshable(A.BreathofFireDotDebuff.ID, true)))) then
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
            if A.TigerPalm:IsReady(unit) and (not A.BlackoutCombo:IsSpellLearned() and A.KegSmash:GetCooldown() > A.GetGCD() and (Player:EnergyPredicted() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + A.GetGCD()))) >= 65) then
                return A.TigerPalm:Show(icon)
            end
            -- arcane_torrent,if=energy<31
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyPredicted() < 31) then
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
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
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

