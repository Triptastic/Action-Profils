local TMW                                     = TMW 
local Env                                     = TMW.CNDT.Env
local Action                                = Action
local Create                                = Action.Create
local Print                                    = Action.Print
local TimerSet                                = Action.TimerSet
local Listener                                = Action.Listener
local IsEnemy                                = Action.Bit.isEnemy
local toStr                                 = Action.toStr
local GetCL                                 = Action.GetCL
local GetToggle                             = Action.GetToggle
local TeamCache                                = Action.TeamCache
local TeamCacheFriendly                        = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs        = TeamCacheFriendly.IndexToPLAYERs
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local ActiveUnitPlates                        = MultiUnits:GetActiveUnitPlates()
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local Pet                                     = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local GetPing                                = Action.GetPing
local IsUnitEnemy                            = Action.IsUnitEnemy
local IsUnitFriendly                        = Action.IsUnitFriendly
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local BossMods_Pulling                        = Action.BossMods_Pulling
local BurstIsON                                = Action.BurstIsON

local _G, setmetatable, ipairs, pairs, next, select, math    = 
_G, setmetatable, ipairs, pairs, next, select, math

local UnitIsUnit                            = _G.UnitIsUnit

Action[ACTION_CONST_WARRIOR_PROTECTION] = {
    -- Racial
    ArcaneTorrent                            = Create({ Type = "Spell", ID = 50613}),
    BloodFury                                = Create({ Type = "Spell", ID = 20572}),
    BagofTricks                                = Create({ Type = "Spell", ID = 312411}),
    LightsJudgment                            = Create({ Type = "Spell", ID = 255647}),
    Fireblood                                = Create({ Type = "Spell", ID = 265221}),
    AncestralCall                            = Create({ Type = "Spell", ID = 274738}),
    Berserking                                = Create({ Type = "Spell", ID = 26297}),
    ArcanePulse                                = Create({ Type = "Spell", ID = 260364}),
    QuakingPalm                                = Create({ Type = "Spell", ID = 107079}),
    Haymaker                                = Create({ Type = "Spell", ID = 287712}), 
    WarStomp                                = Create({ Type = "Spell", ID = 20549}),
    BullRush                                = Create({ Type = "Spell", ID = 255654}),    
    GiftofNaaru                                = Create({ Type = "Spell", ID = 59544}),
    Shadowmeld                                = Create({ Type = "Spell", ID = 58984}), -- usable in Action Core 
    Stoneform                                = Create({ Type = "Spell", ID = 20594}), 
    WilloftheForsaken                        = Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist                            = Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself                        = Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
    -- CrownControl    
    Pummel                                    = Create({ Type = "Spell", ID = 6552}),
    Shockwave                                = Create({ Type = "Spell", ID = 46968}),
    IntimidatingShout                        = Create({ Type = "Spell", ID = 5246}),
    -- Suppotive    
    RallyingCry                                = Create({ Type = "Spell", ID = 97462}),
    BattleShout                                = Create({ Type = "Spell", ID = 6673}),
    Taunt                                    = Create({ Type = "Spell", ID = 355}),
    -- Self Defensives
    IgnorePain                                = Create({ Type = "Spell", ID = 190456}),
    DemoralizingShout                        = Create({ Type = "Spell", ID = 1160}),
    ShieldBlock                                = Create({ Type = "Spell", ID = 2565}),
    LastStand                                = Create({ Type = "Spell", ID = 12975}),
    ShieldWall                                = Create({ Type = "Spell", ID = 871}),
    BerserkerRage                            = Create({ Type = "Spell", ID = 18499}),
    VictoryRush                                = Create({ Type = "Spell", ID = 34428}),
    -- Burst
    Avatar                                    = Create({ Type = "Spell", ID = 107574}),
    -- Rotation
    ShieldSlam                                = Create({ Type = "Spell", ID = 23922}),
    ThunderClap                                = Create({ Type = "Spell", ID = 6343}),
    Revenge                                    = Create({ Type = "Spell", ID = 6572}),
    Devastate                                = Create({ Type = "Spell", ID = 20243}),
    
    -- Movement    
    -- Utilities
    -- PvP
    -- Buffs
    FreeRevenge                                = Create({ Type = "Spell", ID = 5302, Hidden = true}),
    RecklessForceBuff                        = Create({ Type = "Spell", ID = 302932, Hidden = true}),
    ShieldBlockBuff                            = Create({ Type = "Spell", ID = 132404, Hidden = true}),
    
    -- Debuffs
    BloodoftheEnemyDebuff                    = Create({ Type = "Spell", ID = 297108, Hidden = true}),
    RazorCoralDebuff                        = Create({ Type = "Spell", ID = 303568, Hidden = true}),
    ConcentratedFlameDebuff                    = Create({ Type = "Spell", ID = 295368, Hidden = true}),
    -- Talents    
    DragonRoar                                = Create({ Type = "Spell", ID = 118000, isTalent = true}),    -- Talent 3/3
    UnstoppableForce                        = Create({ Type = "Spell", ID = 275336, isTalent = true}),    -- Talent 4/3
    StormBolt                                = Create({ Type = "Spell", ID = 107570, isTalent = true}),    -- Talent 5/3
    BoomingVoice                            = Create({ Type = "Spell", ID = 202743, isTalent = true}),    -- Talent 6/1
    Ravager                                    = Create({ Type = "Spell", ID = 228920, isTalent = true}),    -- Talent 7/3
    -- PvP Talents
    
    -- Items
    PotionofUnbridledFury                    = Create({ Type = "Potion",  ID = 169299 }), 
    DribblingInkpod                            = Create({ Type = "Trinket", ID = 169319 }),
    PocketsizedComputationDevice            = Create({ Type = "Trinket", ID = 167555 }),
    AshvanesRazorCoral                        = Create({ Type = "Trinket", ID = 169311 }),   
    RemoteGuidanceDevice                    = Create({ Type = "Trinket", ID = 169769 }), 
    WrithingSegmentofDrestagath                = Create({ Type = "Trinket", ID = 173946 }), 
    -- Hidden 
    CrashingChaos                            = Create({ Type = "Spell", ID = 277644, Hidden = true}), -- Simcraft Azerite
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_PROTECTION)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })

local player                                    = "player"
local target                                    = "target"
local Temp                                        = {
    AttackTypes                                    = {"TotalImun", "DamagePhysImun"},    
    AuraForCC                                    = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    AuraForOnlyCCAndStun                        = {"CCTotalImun", "StunImun"},
    AuraForInterrupt                            = {"TotalImun", "DamagePhysImun", "KickImun"},
    AuraForFear                                    = {"TotalImun", "DamagePhysImun", "FearImun"},
    AuraForStun                                    = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    AuraForSlow                                    = {"TotalImun", "DamagePhysImun", "CCTotalImun", "Freedom"},
    BigDeff                                        = {A.ShieldWall.ID},
    BerserkerRageLoC                            = {"FEAR", "INCAPACITATE"},
    IsSlotTrinketBlocked                        = {
        [A.AshvanesRazorCoral.ID]                = true,
    },
}

local function InMelee(unitID)
    -- @return boolean 
    return A.ShieldSlam:IsInRange(unitID)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unitID in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit(target, unitID)) and (not isCheckCombat or Unit(unitID):CombatTime() > 0) and not Unit(unitID):IsExplosives() and not Unit(unitID):IsTotem() and select(6, Unit(unitID):InfoGUID()) ~= 161895 then 
            if InMelee(unitID) then 
                c = c + 1
            elseif range then 
                local r = Unit(unitID):GetRange()
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

local function CanIgnorePain(variation) 
    if Unit(player):HasBuffs(A.IgnorePain.ID, true) > 0 then
        local description     = A.IgnorePain:GetSpellDescription()
        local summary         = description[1]
        local total         = summary * variation
        
        if Unit(player):HasBuffs(A.IgnorePain.ID, true) < (0.5 * total) then
            return true
        else
            return false
        end
    else
        return true
    end
end

local function CanUseTrinkets(isBurstIsON)
    local TrinketUsage = GetToggle(2, "TrinketUsage") 
    
    if TrinketUsage == "BURST" and isBurstIsON then
        return true
    end
    
    if TrinketUsage == "EVERYONE" then
        return true
    end
end

local function isCurrentlyTanking()
    local IsTanking = Unit(player):IsTankingAoE(16) or Unit(player):IsTanking(target, 16)
    
    return IsTanking
end
-----------------------------------------
--                 ROTATION  
-----------------------------------------

-- [3] Single Rotation
A[3] = function(icon)
    local unitID                        = "player"
    local inAoE                            = GetToggle(2, "AoE")
    local combatTime                    = Unit(player):CombatTime()
    local inCombat                        = combatTime > 0
    local refreshTime                    = (GetGCD() + GetCurrentGCD() + GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER)
    local rage                            = Player:Rage()
    local rageDeficit                    = Player:RageDeficit()
    local canCleave                        = false
    local offensiveRage                    = GetToggle(2, "offensiveRage")
    local offensiveShieldBlock            = GetToggle(2, "offensiveShieldBlock")
    
    if A.BattleShout:IsReady(player) and (Unit(player):HasBuffs(A.BattleShout.ID) == 0) then
        return A.BattleShout:Show(icon)
    end
    
    local function EnemyRotation(unitID)                        
        local isTargetInMelee            = InMelee(unitID)
        
        -- BerserkerRage 
        -- Note: Loss of Control, IsReadyP!
        if LoC:IsValid(Temp.BerserkerRageLoC) and GetToggle(2, "UseBerserkerRage-LoC") and A.BerserkerRage:IsReadyP(player) then 
            return A.BerserkerRage:Show(icon)
        end
        -- [[ SELF DEFENSE ]] 
        if inCombat then                
            -- Shield Wall
            if A.ShieldWall:IsReadyByPassCastGCD(player, nil, nil, true) then 
                local SW_HP                    = GetToggle(2, "ShieldWallHP")
                local SW_TTD                = GetToggle(2, "ShieldWallTTD")
                
                if  (    
                    ( SW_HP     >= 0     or SW_TTD                              >= 0                                        ) and 
                    ( SW_HP     <= 0     or Unit(player):HealthPercent()     <= SW_HP                                    ) and 
                    ( SW_TTD     <= 0     or Unit(player):TimeToDie()         <= SW_TTD                                      ) 
                ) or 
                (
                    GetToggle(2, "ShieldWallCatchKillStrike") and 
                    combatTime > 4 and 
                    (
                        ( Unit(player):GetDMG()            >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                        Unit(player):GetRealTimeDMG()    >= Unit(player):Health() or 
                        Unit(player):TimeToDie()        <= GetGCD()
                    )
                )                
                then                
                    return A.ShieldWall:Show(icon)
                end 
            end
            
            -- Last Stand
            if A.LastStand:IsReadyByPassCastGCD(player, nil, nil, true) and Unit(player):HasBuffs(Temp.BigDeff) == 0 then 
                local LS_HP                    = GetToggle(2, "LastStandHP")
                local LS_TTD                = GetToggle(2, "LastStandTTD")
                
                if  (    
                    ( LS_HP     >= 0     or LS_TTD                              >= 0                                        ) and 
                    ( LS_HP     <= 0     or Unit(player):HealthPercent()     <= LS_HP                                    ) and 
                    ( LS_TTD     <= 0     or Unit(player):TimeToDie()         <= LS_TTD                                      ) 
                ) or 
                (
                    GetToggle(2, "LastStandCatchKillStrike") and 
                    combatTime > 4 and 
                    (
                        ( Unit(player):GetDMG()            >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                        Unit(player):GetRealTimeDMG()    >= Unit(player):Health() or 
                        Unit(player):TimeToDie()        <= GetGCD()
                    )
                )                
                then                
                    return A.LastStand:Show(icon)
                end 
            end 
            
            -- Rallying Cry
            if A.RallyingCry:IsReady(player) and Unit(player):HasBuffs(Temp.BigDeff) == 0 then 
                local RC_HP                    = GetToggle(2, "RallyingCryHP")
                local RC_TTD                = GetToggle(2, "RallyingCryTTD")
                
                if  (    
                    ( RC_HP     >= 0     or RC_TTD                              >= 0                                        ) and 
                    ( RC_HP     <= 0     or Unit(player):HealthPercent()     <= RC_HP                                    ) and 
                    ( RC_TTD     <= 0     or Unit(player):TimeToDie()         <= RC_TTD                                      ) 
                ) or 
                (
                    GetToggle(2, "RallyingCryCatchKillStrike") and 
                    combatTime > 4 and 
                    (
                        ( Unit(player):GetDMG()            >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                        Unit(player):GetRealTimeDMG()    >= Unit(player):Health() or 
                        Unit(player):TimeToDie()        <= GetGCD()
                    )
                )                
                then                
                    return A.RallyingCry:Show(icon)
                end 
            end 
            
            local IgnorePainHP            = GetToggle(2, "IgnorePainHP")        
            -- Ignore Pain 
            if A.IgnorePain:IsReady(player, nil, nil, true) and rage >= A.IgnorePain:GetSpellPowerCostCache() and isCurrentlyTanking() and CanIgnorePain(1.3) and
            (
                Unit(player):HealthPercent() <= IgnorePainHP
            ) and 
            (
                rageDeficit < 25 + 25 * (A.BoomingVoice:IsSpellLearned() and 1 or 0) * (A.DemoralizingShout:GetCooldown() == 0 and 1 or 0)
            ) then
                return A.IgnorePain:Show(icon)
            end
            
            local ShieldBlockHP            = GetToggle(2, "ShieldBlockHP")
            local ShieldBlockHits        = GetToggle(2, "ShieldBlockHits")
            local ShieldBlockPhys        = GetToggle(2, "ShieldBlockPhys")            
            local Hits, Phys             = Unit(player):GetRealTimeDMG(2)
            -- Shield Block
            if A.ShieldBlock:IsReadyByPassCastGCD(player, nil, nil, true) and rage >= A.ShieldBlock:GetSpellPowerCostCache() and isCurrentlyTanking() and 
            (
                Unit(player):HealthPercent() <= ShieldBlockHP and
                Hits  >= ShieldBlockHits and 
                Phys * 100 / Unit(player):HealthMax() >= ShieldBlockPhys
            ) and 
            (
                (
                    Unit(player):HasBuffs(A.ShieldBlockBuff.ID) == 0 or 
                    Unit(player):HasBuffs(A.ShieldBlockBuff.ID) <= refreshTime
                ) and 
                Unit(player):HasBuffs(A.LastStand.ID) == 0
            ) then
                return A.ShieldBlock:Show(icon)
            end
            
            local VictoryRushHP    = GetToggle(2, "VictoryRushHP")
            if Unit(player):HealthPercent() <= VictoryRushHP and A.VictoryRush:IsReady(unitID) then
                return A.VictoryRush:Show(icon)
            end
        end
        
        -- [[ INTERRUPTS ]] 
        local useKick, useCC, useRacial = InterruptIsValid(unitID, "TargetMouseover")
        
        if useKick or useCC or useRacial then         
            local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
            
            -- useKick
            if useKick and castLeft > 0 and not notKickAble and A.AbsentImun(nil, unitID, Temp.AuraForInterrupt) and Unit(unitID):CanInterrupt(nil, nil, 15, 67) and A.Pummel:IsReady(unitID) then 
                return A.Pummel:Show(icon)
            end
            
            -- useCC / useRacial
            if not useKick or notKickAble or A.Pummel:GetCooldown() > 0 then
                if useCC and castLeft > GetCurrentGCD() and castLeft < GetGCD() + GetCurrentGCD() + 0.2 and A.StormBolt:IsReady(unitID) and A.StormBolt:AbsentImun(unitID, Temp.AuraForStun) and Unit(unitID):IsControlAble("stun") then 
                    return A.StormBolt:Show(icon)
                end 
                
                if useCC and castLeft > GetCurrentGCD() and castLeft < GetGCD() + GetCurrentGCD() + 0.2 and A.IntimidatingShout:IsReady(unitID) and A.IntimidatingShout:AbsentImun(unitID, Temp.AuraForFear) and Unit(unitID):IsControlAble("fear") then 
                    return A.IntimidatingShout:Show(icon)       
                end 
            end
        end
        
        -- Check if target is explosive or totem for dont use AoE spells 
        if not Unit(unitID):IsExplosives() and not Unit(unitID):IsTotem() then
            canCleave = true
        end
        
        -- [[ BURST ]] 
        if isTargetInMelee and BurstIsON(unitID) and ((Unit(unitID):IsBoss() or Unit(unitID):IsPlayer()) and Unit(unitID):TimeToDie() >= GetToggle(2, "BurstTTDBoss") or not Unit(unitID):IsBoss() and not Unit(unitID):IsPlayer() and Unit(unitID):TimeToDie() >= GetToggle(2, "BurstTTDMobs")) and canCleave then
            -- blood_fury
            if A.BloodFury:AutoRacial(unitID) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unitID) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unitID) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unitID) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unitID) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unitID) then
                return A.BagofTricks:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzeroth(unitID) and A.Avatar:GetCooldown() <= 2 then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzerothP(unitID) then
                return A.RippleinSpace:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unitID) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- Avatar
            if A.Avatar:IsReady(player) and Unit(player):HasBuffs(A.Avatar.ID) == 0 then
                return A.Avatar:Show(icon)
            end
        end
        
        -- concentrated_flame
        if A.ConcentratedFlame:AutoHeartOfAzerothP(unitID) and (Unit(unitID):HasDeBuffs(A.ConcentratedFlameDebuff.ID) == 0 and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetCurrentGCD())then
            return A.ConcentratedFlame:Show(icon)
        end
        
        -- Trinket 1
        if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and isTargetInMelee and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] and CanUseTrinkets(BurstIsON(unitID)) and A.Trinket1:AbsentImun(unitID, "DamageMagicImun") then
            return A.Trinket1:Show(icon)    
        end 
        
        -- Trinket 2  
        if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and isTargetInMelee and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] and CanUseTrinkets(BurstIsON(unitID)) and A.Trinket2:AbsentImun(unitID, "DamageMagicImun") then
            return A.Trinket2:Show(icon)    
        end 
        
        -- [[ AoE ]] 
        if inAoE and GetByRange(3, 10) then
            -- Thunder Clap
            if A.ThunderClap:IsReady(unitID, true) and Unit(unitID):GetRange() <= 10 and canCleave and A.ThunderClap:AbsentImun(unitID, Temp.AttackTypes) then
                return A.ThunderClap:Show(icon)
            end
            
            -- [[ BURST ]]  
            if isTargetInMelee and BurstIsON(unitID) and ((Unit(unitID):IsBoss() or Unit(unitID):IsPlayer()) and Unit(unitID):TimeToDie() >= GetToggle(2, "BurstTTDBoss") or not Unit(unitID):IsBoss() and not Unit(unitID):IsPlayer() and Unit(unitID):TimeToDie() >= GetToggle(2, "BurstTTDMobs")) then
                -- memory_of_lucid_dreams
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unitID) and canCleave and Unit(player):HasBuffs(A.Avatar.ID) == 0 then
                    return A.MemoryofLucidDreams:Show(icon)
                end
                
                -- anima_of_death
                if A.AnimaofDeath:AutoHeartOfAzerothP(unitID) and canCleave and Unit(player):HasBuffs(A.LastStand.ID) > 0 then
                    return A.AnimaofDeath:Show(icon)
                end
                
                -- Dragon Roar
                if A.DragonRoar:IsReady(unitID, true) and A.DragonRoar:AbsentImun(unitID, Temp.AttackTypes) then 
                    return A.DragonRoar:Show(icon)
                end
                
                -- Ravager
                if A.Ravager:IsReady(unitID, true) and A.Ravager:AbsentImun(unitID, Temp.AttackTypes) then 
                    return A.Ravager:Show(icon)
                end
            end
            
            -- Demoralizing Shout
            if A.DemoralizingShout:IsReady(unitID, true) and isTargetInMelee and canCleave and (A.BoomingVoice:IsSpellLearned() and rageDeficit >= 40 or not A.BoomingVoice:IsSpellLearned()) and A.DemoralizingShout:AbsentImun(unitID, Temp.AttackTypes) then
                return A.DemoralizingShout:Show(icon)
            end
            
            -- Revenge
            if A.Revenge:IsReady(unitID, true) and isTargetInMelee and canCleave and (Unit(player):HasBuffs(A.FreeRevenge.ID) > 0 or offensiveRage or rage >= 75 or (not isCurrentlyTanking() and rage >= 50)) and A.Revenge:AbsentImun(unitID, Temp.AttackTypes) then
                return A.Revenge:Show(icon)
            end
            
            -- Shield Block Offensive
            if A.ShieldBlock:IsReady(player) and isTargetInMelee and (A.ShieldSlam:GetCooldown() == 0 and Unit(player):HasBuffs(A.ShieldBlockBuff.ID) == 0 and offensiveShieldBlock) then
                return A.ShieldBlock:Show(icon)
            end
            
            -- Shield Slam
            if A.ShieldSlam:IsReady(unitID) and A.ShieldSlam:AbsentImun(unitID, Temp.AttackTypes) then 
                return A.ShieldSlam:Show(icon)
            end
            
            -- Devastate
            if A.Devastate:IsReady(unitID) and A.Devastate:AbsentImun(unitID, Temp.AttackTypes) then 
                return A.Devastate:Show(icon)
            end
        end
        
        -- [[ SINGLE TARGET ]] 
        if not inAoE or not GetByRange(3, 10) then
            -- Thunder Clap
            if A.ThunderClap:IsReady(unitID, true) and Unit(unitID):GetRange() <= 10 and canCleave and (inAoE and GetByRange(2, 10) and A.UnstoppableForce:IsSpellLearned() and Unit(player):HasBuffs(A.Avatar.ID) > 0) and A.ThunderClap:AbsentImun(unitID, Temp.AttackTypes) then
                return A.ThunderClap:Show(icon)
            end
            
            -- Shield Slam
            if A.ShieldSlam:IsReady(unitID) and Unit(player):HasBuffs(A.ShieldBlockBuff.ID) > 0 and A.ShieldSlam:AbsentImun(unitID, Temp.AttackTypes) then 
                return A.ShieldSlam:Show(icon)
            end
            
            -- Thunder Clap
            if A.ThunderClap:IsReady(unitID, true) and Unit(unitID):GetRange() <= 10 and canCleave and (A.UnstoppableForce:IsSpellLearned() and Unit(player):HasBuffs(A.Avatar.ID) > 0) and A.ThunderClap:AbsentImun(unitID, Temp.AttackTypes) then
                return A.ThunderClap:Show(icon)
            end
            
            -- Demoralizing Shout
            if A.DemoralizingShout:IsReady(unitID, true) and isTargetInMelee and canCleave and (A.BoomingVoice:IsSpellLearned() and rageDeficit >= 40 or not A.BoomingVoice:IsSpellLearned()) and A.DemoralizingShout:AbsentImun(unitID, Temp.AttackTypes) then
                return A.DemoralizingShout:Show(icon)
            end
            
            -- Shield Slam
            if A.ShieldSlam:IsReady(unitID) and A.ShieldSlam:AbsentImun(unitID, Temp.AttackTypes) then 
                return A.ShieldSlam:Show(icon)
            end
            
            -- Thunder Clap
            if A.ThunderClap:IsReady(unitID, true) and Unit(unitID):GetRange() <= 10 and canCleave and A.ThunderClap:AbsentImun(unitID, Temp.AttackTypes) then
                return A.ThunderClap:Show(icon)
            end
            
            -- Revenge
            if A.Revenge:IsReady(unitID, true) and isTargetInMelee and canCleave and (Unit(player):HasBuffs(A.FreeRevenge.ID) > 0 or offensiveRage or rage >= 75 or (not isCurrentlyTanking() and rage >= 50)) and A.Revenge:AbsentImun(unitID, Temp.AttackTypes) then
                return A.Revenge:Show(icon)
            end
            
            -- Devastate
            if A.Devastate:IsReady(unitID) and A.Devastate:AbsentImun(unitID, Temp.AttackTypes) then 
                return A.Devastate:Show(icon)
            end
        end
        
    end
    
    local function EnemyRotationMO(unitID)    
        if GetToggle(2, "MOTaunt") and inCombat and A.Taunt:IsReady(unitID) and not Unit(unitID):IsBoss() and Unit(player):ThreatSituation(unitID) <= 2 then
            return A.Taunt:Show(icon)
        end
    end
    
    if IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
        
        if not Unit(unitID):IsDead() and EnemyRotationMO(unitID) then 
            return true 
        end 
    end 
    
    if IsUnitEnemy(target) then 
        unitID = target
        
        if not Unit(unitID):IsDead() and EnemyRotation(unitID) then 
            return true 
        end 
    end 
    
end 

A[6] = function(icon)    
    local MOExplosive    = GetToggle(2, "MOExplosive")
    local MOTotem        = GetToggle(2, "MOTotem")
    
    if MOExplosive and IsUnitEnemy("mouseover") and Unit("mouseover"):IsExplosives() or MOTotem and IsUnitEnemy("mouseover") and Unit("mouseover"):IsTotem() then 
        return A:Show(icon, ACTION_CONST_LEFT)
    end
end

-- Nil (nothing for profile here, just reset them)
A[1] = nil
A[2] = nil  
A[4] = nil 
A[5] = nil 
A[7] = nil
A[8] = nil 

