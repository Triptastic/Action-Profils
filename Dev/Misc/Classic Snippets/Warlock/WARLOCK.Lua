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
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local Pet                                     = LibStub("PetLibrary")

local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local GetPing                                = Action.GetPing
local IsUnitEnemy                            = Action.IsUnitEnemy
local IsUnitFriendly                        = Action.IsUnitFriendly
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local DetermineUsableObject                    = Action.DetermineUsableObject
local BossMods_Pulling                        = Action.BossMods_Pulling
local BurstIsON                                = Action.BurstIsON

--[[ We can't use these function same like on a Warrior because of limit of 60 upvalues
local CanUseLivingActionPotion                = Action.CanUseLivingActionPotion
local CanUseRestorativePotion                = Action.CanUseRestorativePotion
local CanUseLimitedInvulnerabilityPotion    = Action.CanUseLimitedInvulnerabilityPotion
local CanUseHealingPotion                    = Action.CanUseHealingPotion
local CanUseSwiftnessPotion                    = Action.CanUseSwiftnessPotion
]]

local TeamCacheFriendly                        = TeamCache.Friendly
local TeamCacheFriendlyUNITs                = TeamCacheFriendly.UNITs
local TeamCacheFriendlyIndexToPLAYERs        = TeamCacheFriendly.IndexToPLAYERs
local ActiveUnitPlates                         = MultiUnits:GetActiveUnitPlates()

local _G, setmetatable, ipairs, pairs, next, select, math    = 
_G, setmetatable, ipairs, pairs, next, select, math
local huge                                     = math.huge      
local wipe                                     = _G.wipe      
local IsOutdoors                            = _G.IsOutdoors
local GetTrackingTexture                    = _G.GetTrackingTexture    
local CombatLogGetCurrentEventInfo            = _G.CombatLogGetCurrentEventInfo
local MAX_BOSS_FRAMES                        = _G.MAX_BOSS_FRAMES 
local ACTION_CONST_STOPCAST                    = _G.ACTION_CONST_STOPCAST
local ACTION_CONST_AUTOATTACK                = _G.ACTION_CONST_AUTOATTACK
local ACTION_CONST_AUTOTARGET                = _G.ACTION_CONST_AUTOTARGET

local UnitGUID                                = _G.UnitGUID
local UnitIsUnit                            = _G.UnitIsUnit
local UnitDebuff                            = _G.UnitDebuff

Action[Action.PlayerClass]                     = {
    -- Racials 
    Perception                                = Create({ Type = "Spell", ID = 20600,     FixedTexture = ACTION_CONST_HUMAN                                                                                                         }), 
    BloodFury                                 = Create({ Type = "Spell", ID = 20572                                                                                                                                              }), 
    WilloftheForsaken                          = Create({ Type = "Spell", ID = 7744                                                                                                                                            }), 
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589                                                                                                                                            }), 
    -- Core API
    AntiFakeCC                                = Create({ Type = "SpellSingleColor",     ID = 5782,     useMaxRank = true,     Color = "GREEN", Desc = "[1] AntiFake CC",             QueueForbidden = true                                 }), -- Fear
    AntiFakeInterruptSpellLock                = Create({ Type = "Spell",                 ID = 19244, useMaxRank = true,                      Desc = "[2] Interrupt",             QueueForbidden = true                                 }), -- SpellLock    
    AntiFakeInterruptSeduction                = Create({ Type = "Spell",                 ID = 6358,                                           Desc = "[2] Interrupt",             QueueForbidden = true                                 }), -- Seduction
    AntiFakeInterruptWarstomp                = Create({ Type = "Spell",                 ID = 19482, useMaxRank = true,                      Desc = "[2] Interrupt",             QueueForbidden = true                                 }), -- Warstomp
    CastBarsInterruptSpellLock                = Create({ Type = "Spell",                  ID = 19244, useMaxRank = true,                     Desc = "[CastBars] Interrupt",     QueueForbidden = true                                  }), -- SpellLock
    CastBarsInterruptSeduction                = Create({ Type = "Spell",                 ID = 6358,                                           Desc = "[CastBars] Interrupt",     QueueForbidden = true                                 }), -- Seduction
    CastBarsInterruptWarstomp                = Create({ Type = "Spell",                 ID = 19482, useMaxRank = true,                      Desc = "[CastBars] Interrupt",     QueueForbidden = true                                 }), -- Warstomp
    -- Class spells
    Corruption                                = Create({ Type = "Spell", ID = 172,     useMaxRank = true                                                                                                                         }),
    CurseofAgony                            = Create({ Type = "Spell", ID = 980,     useMaxRank = true                                                                                                                         }),
    CurseofDoom                                = Create({ Type = "Spell", ID = 603                                                                                                                                                }),
    CurseofRecklessness                        = Create({ Type = "Spell", ID = 704,     useMaxRank = true                                                                                                                         }),
    CurseofShadow                            = Create({ Type = "Spell", ID = 17862,     useMaxRank = true                                                                                                                         }),
    CurseoftheElements                        = Create({ Type = "Spell", ID = 1490,     useMaxRank = true                                                                                                                         }),
    CurseofTongues                            = Create({ Type = "Spell", ID = 1714,     useMaxRank = true                                                                                                                         }),
    CurseofWeakness                            = Create({ Type = "Spell", ID = 702,     useMaxRank = true                                                                                                                         }),
    CurseofExhaustion                        = Create({ Type = "Spell", ID = 18223,     isTalent = true                                                                                                                         }),
    DarkPact                                = Create({ Type = "Spell", ID = 18220,     useMaxRank = true,    isTalent = true                                                                                                     }),
    SiphonLife                                = Create({ Type = "Spell", ID = 18265,     useMaxRank = true,    isTalent = true                                                                                                     }),    
    DrainLife                                = Create({ Type = "Spell", ID = 689,     useMaxRank = true                                                                                                                        }),
    DrainMana                                = Create({ Type = "Spell", ID = 5138,     useMaxRank = true                                                                                                                        }),
    DrainSoul                                = Create({ Type = "Spell", ID = 1120,     useMaxRank = true,     Desc = "Max Rank"                                                                                                    }),
    DrainSoul1                                = Create({ Type = "Spell", ID = 1120,     useMinRank = true,     Desc = "Min Rank"                                                                                                    }),
    Shadowburn                                = Create({ Type = "Spell", ID = 17877,     useMaxRank = true,    isTalent = true                                                                                                     }),
    Hellfire                                = Create({ Type = "Spell", ID = 1949,     useMaxRank = true                                                                                                                        }),
    Immolate                                = Create({ Type = "Spell", ID = 348,     useMaxRank = true                                                                                                                        }),    
    Conflagrate                                = Create({ Type = "Spell", ID = 17962,     useMaxRank = true,    isTalent = true                                                                                                     }),    
    RainofFire                                = Create({ Type = "Spell", ID = 5740,     useMaxRank = true                                                                                                                        }),    
    SearingPain                                = Create({ Type = "Spell", ID = 5676,     useMaxRank = true                                                                                                                        }),    
    ShadowBolt                                = Create({ Type = "Spell", ID = 686,     useMaxRank = true                                                                                                                        }),    
    SoulFire                                = Create({ Type = "Spell", ID = 6353,     useMaxRank = true                                                                                                                        }),    
    -- Burst 
    AmplifyCurse                            = Create({ Type = "Spell", ID = 18288,     isTalent = true                                                                                                                         }),
    DeathCoil                                = Create({ Type = "Spell", ID = 6789,     useMaxRank = true                                                                                                                        }),
    -- Burst (outdoors)
    Inferno                                    = Create({ Type = "Spell", ID = 1122                                                                                                                                            }),
    -- Defense
    DemonArmor                                = Create({ Type = "Spell", ID = 706,     useMaxRank = true                                                                                                                        }),    
    DemonSkin                                = Create({ Type = "Spell", ID = 687,     useMaxRank = true                                                                                                                        }),    
    ShadowWard                                = Create({ Type = "Spell", ID = 6229,     useMaxRank = true                                                                                                                        }),
    -- Pets 
    HealthFunnel                            = Create({ Type = "Spell", ID = 755,     useMaxRank = true                                                                                                                        }),
    SoulLink                                = Create({ Type = "Spell", ID = 19028,     isTalent = true                                                                                                                            }),
    DemonicSacrifice                        = Create({ Type = "Spell", ID = 18788,     isTalent = true                                                                                                                         }),
    FelDomination                            = Create({ Type = "Spell", ID = 18708,     isTalent = true                                                                                                                         }),
    SummonFelhunter                            = Create({ Type = "Spell", ID = 691                                                                                                                                                }), 
    SummonImp                                = Create({ Type = "Spell", ID = 688                                                                                                                                                }), 
    SummonSuccubus                            = Create({ Type = "Spell", ID = 712                                                                                                                                                }), 
    SummonVoidwalker                        = Create({ Type = "Spell", ID = 697                                                                                                                                                }), 
    DevourMagic                                = Create({ Type = "Spell", ID = 19505,     useMaxRank = true                                                                                                                         }),
    FireShield                                = Create({ Type = "Spell", ID = 2947,     useMaxRank = true                                                                                                                         }),
    PhaseShift                                = Create({ Type = "Spell", ID = 4511,     useMaxRank = true                                                                                                                         }),    
    Sacrifice                                = Create({ Type = "Spell", ID = 7812,     useMaxRank = true                                                                                                                         }),
    Seduction                                = Create({ Type = "Spell", ID = 6358                                                                                                                                             }),
    SpellLock                                = Create({ Type = "Spell", ID = 19244,     useMaxRank = true                                                                                                                         }),
    DispelMagic                                = Create({ Type = "Spell", ID = 15090,     useMaxRank = true                                                                                                                         }), -- Doomguard Commander
    Warstomp                                = Create({ Type = "Spell", ID = 11876,     useMaxRank = true                                                                                                                         }), -- Doomguard Commander
    ConsumeShadows                            = Create({ Type = "Spell", ID = 17767,     Texture = 4511, Desc = "Used texture of the Phase Shift", useMaxRank = true                                                             }),
    -- CrownControl
    Banish                                    = Create({ Type = "Spell", ID = 710,     useMaxRank = true                                                                                                                         }),
    Fear                                    = Create({ Type = "Spell", ID = 5782,     useMaxRank = true                                                                                                                         }),
    HowlofTerror                            = Create({ Type = "Spell", ID = 5484,     useMaxRank = true                                                                                                                         }),
    EnslaveDemon                            = Create({ Type = "Spell", ID = 1098,     useMaxRank = true                                                                                                                         }),
    -- Misc    
    LifeTap                                    = Create({ Type = "Spell", ID = 1454,     useMaxRank = true                                                                                                                        }),
    RitualofDoom                            = Create({ Type = "Spell", ID = 18540,     Desc = "No APL"                                                                                                                            }), 
    SenseDemons                                = Create({ Type = "Spell", ID = 5500                                                                                                                                            }), 
    UnendingBreath                            = Create({ Type = "Spell", ID = 5697                                                                                                                                            }),
    DetectLesserInvisibility                = Create({ Type = "Spell", ID = 132                                                                                                                                                }),
    DetectInvisibility                        = Create({ Type = "Spell", ID = 2970                                                                                                                                            }),
    DetectGreaterInvisibility                = Create({ Type = "Spell", ID = 11743                                                                                                                                            }),
    CreateFirestoneLesser                    = Create({ Type = "Spell", ID = 6366                                                                                                                                            }),
    CreateFirestone                            = Create({ Type = "Spell", ID = 17951                                                                                                                                            }),
    CreateFirestoneGreater                    = Create({ Type = "Spell", ID = 17952                                                                                                                                            }),
    CreateFirestoneMajor                    = Create({ Type = "Spell", ID = 17953                                                                                                                                            }),
    CreateHealthstoneMinor                    = Create({ Type = "Spell", ID = 6201                                                                                                                                            }),
    CreateHealthstoneLesser                    = Create({ Type = "Spell", ID = 6202                                                                                                                                            }),
    CreateHealthstone                        = Create({ Type = "Spell", ID = 5699                                                                                                                                            }),
    CreateHealthstoneGreater                = Create({ Type = "Spell", ID = 11729                                                                                                                                            }),
    CreateHealthstoneMajor                    = Create({ Type = "Spell", ID = 11730                                                                                                                                            }),
    CreateSoulstoneMinor                    = Create({ Type = "Spell", ID = 693                                                                                                                                                }),
    CreateSoulstoneLesser                    = Create({ Type = "Spell", ID = 20752                                                                                                                                            }),
    CreateSoulstone                            = Create({ Type = "Spell", ID = 20755                                                                                                                                            }),
    CreateSoulstoneGreater                    = Create({ Type = "Spell", ID = 20756                                                                                                                                            }),
    CreateSoulstoneMajor                    = Create({ Type = "Spell", ID = 20757                                                                                                                                            }),
    CreateSpellstone                        = Create({ Type = "Spell", ID = 2362                                                                                                                                            }),
    CreateSpellstoneGreater                    = Create({ Type = "Spell", ID = 17727                                                                                                                                            }),
    CreateSpellstoneMajor                    = Create({ Type = "Spell", ID = 17728                                                                                                                                            }),
    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444                                                                                                                                            }),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua
    MajorFirestone                            = Create({ Type = "Item",  ID = 13701,     Hidden = true                                                                                                                            }),
    GreaterFirestone                        = Create({ Type = "Item",  ID = 13700,     Hidden = true                                                                                                                            }),
    Firestone                                = Create({ Type = "Item",  ID = 13699,     Hidden = true                                                                                                                            }),
    LesserFirestone                            = Create({ Type = "Item",  ID = 1254,     Hidden = true                                                                                                                            }),
    MajorSoulstone                            = Create({ Type = "Item",  ID = 16896,     Hidden = true                                                                                                                            }),
    GreaterSoulstone                        = Create({ Type = "Item",  ID = 16895,     Hidden = true                                                                                                                            }),
    Soulstone                                = Create({ Type = "Item",  ID = 16893,     Hidden = true                                                                                                                            }),
    LesserSoulstone                            = Create({ Type = "Item",  ID = 16892,     Hidden = true                                                                                                                            }),
    MinorSoulstone                            = Create({ Type = "Item",  ID = 5232,     Hidden = true                                                                                                                            }),
    MajorSpellstone                            = Create({ Type = "Item",  ID = 13603,     Hidden = true                                                                                                                            }),
    GreaterSpellstone                        = Create({ Type = "Item",  ID = 13602,     Hidden = true                                                                                                                            }),
    Spellstone                                = Create({ Type = "Item",  ID = 5522,     Hidden = true                                                                                                                            }),
    SoulShard                                = Create({ Type = "Item",  ID = 6265,     Hidden = true                                                                                                                            }),
    InfernalStone                            = Create({ Type = "Item",  ID = 5565,     Hidden = true                                                                                                                            }),
    -- Hidden Pet Spells 
    Firebolt                                = Create({ Type = "Spell", ID = 3110,     useMaxRank = true,    Hidden = true                                                                                                        }),
    Torment                                    = Create({ Type = "Spell", ID = 3716,     useMaxRank = true,    Hidden = true                                                                                                        }),
    LashofPain                                = Create({ Type = "Spell", ID = 7814,     useMaxRank = true,    Hidden = true                                                                                                        }),
    -- Hidden DemonicSacrifice Buffs     
    BurningWish                                = Create({ Type = "Spell", ID = 18789,    Hidden = true                                                                                                                            }), -- Imp
    FelStamina                                = Create({ Type = "Spell", ID = 18790,    Hidden = true                                                                                                                            }), -- Voidwalker
    TouchofShadow                            = Create({ Type = "Spell", ID = 18791,    Hidden = true                                                                                                                            }), -- Succubus
    FelEnergy                                = Create({ Type = "Spell", ID = 18792,    Hidden = true                                                                                                                            }), -- Felhunter
    -- Hidden Auras 
    BloodPact                                = Create({ Type = "Spell", ID = 11767,    Hidden = true                                                                                                                            }),
    ShadowTrance                            = Create({ Type = "Spell", ID = 17941,    Hidden = true                                                                                                                            }),
    Shadowform                                = Create({ Type = "Spell", ID = 15473,    Hidden = true                                                                                                                            }), -- To check what Priest has Shadow spec
    PowerInfusion                            = Create({ Type = "Spell", ID = 10060,    Hidden = true                                                                                                                            }),
    -- Hidden DeBuffs
    SpellVulnerability                        = Create({ Type = "Spell", ID = 23605,    Hidden = true                                                                                                                            }),
    ShadowWeavingDeBuff                        = Create({ Type = "Spell", ID = 15258,    Hidden = true                                                                                                                            }),
    ShadowVulnerability                        = Create({ Type = "Spell", ID = 17794,    Hidden = true                                                                                                                            }),
    -- Hidden Talents
    MasterSummoner                            = Create({ Type = "Spell", ID = 18709,    isTalent = true, useMaxRank = true,    Hidden = true                                                                                        }),
    Bane                                    = Create({ Type = "Spell", ID = 17788,    isTalent = true, useMaxRank = true,    Hidden = true                                                                                        }),
    ImprovedLifeTap                            = Create({ Type = "Spell", ID = 18182,    isTalent = true, useMaxRank = true,    Hidden = true                                                                                        }), 
    ImprovedCorruption                        = Create({ Type = "Spell", ID = 17810,    isTalent = true, useMaxRank = true,    Hidden = true                                                                                        }), -- x5 rank instant cast Corruption
    Nightfall                                = Create({ Type = "Spell", ID = 18095,    isTalent = true, useMaxRank = true,    Hidden = true                                                                                        }), -- talent which will proc buff name ShadowTrance (instant cast ShadowBolt)
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })
Player:AddBag("SOUL_SHARD",     { itemID = A.SoulShard.ID                                                                                                                                                                        })
-- All items going from highest (1) to lowest rank 
Player:AddBag("FIRESTONE_1",     { itemID = A.MajorFirestone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("FIRESTONE_2",     { itemID = A.GreaterFirestone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("FIRESTONE_3",     { itemID = A.Firestone.ID,             itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("FIRESTONE_4",     { itemID = A.LesserFirestone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SPELLSTONE_1",     { itemID = A.MajorSpellstone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SPELLSTONE_2",     { itemID = A.GreaterSpellstone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SPELLSTONE_3",     { itemID = A.Spellstone.ID,         itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SOULSTONE_1",     { itemID = A.MajorSoulstone.ID                                                                                                                                                                    })
Player:AddBag("SOULSTONE_2",     { itemID = A.GreaterSoulstone.ID                                                                                                                                                                })
Player:AddBag("SOULSTONE_3",     { itemID = A.Soulstone.ID                                                                                                                                                                        })
Player:AddBag("SOULSTONE_4",     { itemID = A.LesserSoulstone.ID                                                                                                                                                                })
Player:AddBag("SOULSTONE_5",     { itemID = A.MinorSoulstone.ID                                                                                                                                                                    })
Player:AddInv("WL_OFF_HAND",     ACTION_CONST_INVSLOT_OFFHAND, {                                                                                                                                                                 })
Pet:Add("WARLOCK",                 { (A.Torment:Info()), (A.LashofPain:Info()), (A.SpellLock:Info()), (A.DispelMagic:Info()), (A.DevourMagic:Info()), (A.FireShield:Info()), (A.Seduction:Info())                                })
Pet:InitializeTrackerFor("WARLOCK")

local function GetGUID(unitID)
    return (unitID and TeamCacheFriendlyUNITs[unitID]) or UnitGUID(unitID)
end 

-------------------------------------------
-- [[ CONDITIONS ]] 
-------------------------------------------
local player                                 = "player"
local pet                                     = "pet"
local isFearMode                            = false
local Temp                                     = {
    AttackTypes                             = {    "TotalImun", "DamageMagicImun"                                                                                },    
    AttackTypesPhys                            = {    "TotalImun", "DamagePhysImun"                                                                                },
    AuraForFreedom                            = { "TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "Freedom"                                            },
    AuraForWarStomp                            = {    "TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"                                                    },    
    AuraForCC                                = {    "TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun"                                                    },    
    AuraForInterrupt                        = {    "TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "KickImun"                                        },
    AuraForFear                                = {    "TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "FearImun"                                        },
    BuffsArmorSkin                            = { A.DemonArmor.ID, A.DemonSkin.ID                                                                             },
    BuffsDemonicSacrifice                    = { A.BurningWish.ID, A.FelStamina.ID, A.TouchofShadow.ID, A.FelEnergy.ID                                         },
    BuffsDetectInvisible                    = { A.Perception.ID, A.DetectGreaterInvisibility.ID, A.DetectInvisibility.ID, A.DetectLesserInvisibility.ID     },
    BagFirestone                            = {    "FIRESTONE_1", "FIRESTONE_2", "FIRESTONE_3", "FIRESTONE_4"                                                    },
    BagSpellstone                            = {    "SPELLSTONE_1", "SPELLSTONE_2", "SPELLSTONE_3"                                                                },
    BagSoulstone                            = {    "SOULSTONE_1", "SOULSTONE_2", "SOULSTONE_3", "SOULSTONE_4", "SOULSTONE_5"                                    },
    CastToItem                                = {
        [A.CreateFirestoneLesser:Info()]    = A.LesserFirestone,
        [A.CreateFirestone:Info()]            = A.Firestone,
        [A.CreateFirestoneGreater:Info()]    = A.GreaterFirestone,
        [A.CreateFirestoneMajor:Info()]        = A.MajorFirestone,
        [A.CreateHealthstoneMinor:Info()]    = "HealthStone",
        [A.CreateHealthstoneLesser:Info()]    = "HealthStone",
        [A.CreateHealthstone:Info()]        = "HealthStone",
        [A.CreateHealthstoneGreater:Info()]    = "HealthStone",
        [A.CreateHealthstoneMajor:Info()]    = "HealthStone",
        [A.CreateSoulstoneMinor:Info()]        = A.MinorSoulstone,
        [A.CreateSoulstoneLesser:Info()]    = A.LesserSoulstone,
        [A.CreateSoulstone:Info()]            = A.Soulstone,
        [A.CreateSoulstoneGreater:Info()]    = A.GreaterSoulstone,
        [A.CreateSoulstoneMajor:Info()]        = A.MajorSoulstone,
        [A.CreateSpellstone:Info()]            = A.Spellstone,
        [A.CreateSpellstoneGreater:Info()]    = A.GreaterSpellstone,
        [A.CreateSpellstoneMajor:Info()]    = A.MajorSpellstone,
    },
    CastHealthStoneToItems                    = {
        [A.CreateHealthstoneMinor:Info()]    = { A.HSMinor3, A.HSMinor2, A.HSMinor1                                                                            },
        [A.CreateHealthstoneLesser:Info()]    = { A.HSLesser3, A.HSLesser2, A.HSLesser1                                                                         },
        [A.CreateHealthstone:Info()]        = { A.HS3, A.HS2, A.HS1                                                                                         },
        [A.CreateHealthstoneGreater:Info()]    = { A.HSGreater3, A.HSGreater2, A.HSGreater1                                                                     },
        [A.CreateHealthstoneMajor:Info()]    = { A.HSMajor3, A.HSMajor2, A.HSMajor1                                                                            },
    },
    CastHealthStoneToAllHisRankItems        = {
        [A.CreateHealthstoneMinor:Info()]    = { 
            A.HSMajor3, A.HSMajor2, A.HSMajor1,
            A.HSGreater3, A.HSGreater2, A.HSGreater1,     
            A.HS3, A.HS2, A.HS1,
            A.HSLesser3, A.HSLesser2, A.HSLesser1,
            A.HSMinor3, A.HSMinor2, A.HSMinor1,
        },
        [A.CreateHealthstoneLesser:Info()]    = { 
            A.HSMajor3, A.HSMajor2, A.HSMajor1,
            A.HSGreater3, A.HSGreater2, A.HSGreater1,     
            A.HS3, A.HS2, A.HS1,
            A.HSLesser3, A.HSLesser2, A.HSLesser1,
        },
        [A.CreateHealthstone:Info()]        = {
            A.HSMajor3, A.HSMajor2, A.HSMajor1,
            A.HSGreater3, A.HSGreater2, A.HSGreater1,     
            A.HS3, A.HS2, A.HS1,
        },
        [A.CreateHealthstoneGreater:Info()]    = { 
            A.HSMajor3, A.HSMajor2, A.HSMajor1,
            A.HSGreater3, A.HSGreater2, A.HSGreater1,                                                                     
        },
        [A.CreateHealthstoneMajor:Info()]    = { 
            A.HSMajor3, A.HSMajor2, A.HSMajor1,
        },
    },
    IsCastIsSummon                            = {
        [A.SummonImp:Info()]                = 416,
        [A.SummonVoidwalker:Info()]            = 1860,
        [A.SummonSuccubus:Info()]            = 1863,
        [A.SummonFelhunter:Info()]            = 417,
    },
    IsNotStopCastAble                        = {
        [A.SummonImp:Info()]                = true,
        [A.SummonVoidwalker:Info()]            = true,
        [A.SummonSuccubus:Info()]            = true,
        [A.SummonFelhunter:Info()]            = true,
        [A.DrainSoul:Info()]                = true,
        [A.Banish:Info()]                    = true,
        [A.Fear:Info()]                        = true,
        [A.HowlofTerror:Info()]                = true,
    },
    IsRequiredSoulShard                        = {        
        [A.SummonVoidwalker:Info()]            = true,
        [A.SummonSuccubus:Info()]            = true,
        [A.SummonFelhunter:Info()]            = true,
    },
    IsClassValidForFelhunter                = {
        ["ROGUE"]                            = true, 
        ["PRIEST"]                            = true,
        ["MAGE"]                            = true,
        ["WARLOCK"]                            = true,
        ["DRUID"]                            = true,
    },
    IsClassValidForInvisible                = {
        ["ROGUE"]                            = true,
        ["DRUID"]                            = true,
        ["MAGE"]                            = true,
    },
    IsDebuffIsIncreaseDamage                = {
        -- Spell Vulnerability,  Shadow Weaving,  Shadow Vulnerability,  Curse of Shadow
        [A.SpellVulnerability:Info()]        = true,
        [A.ShadowWeavingDeBuff:Info()]        = true,
        [A.ShadowVulnerability:Info()]        = true,
        [A.CurseofShadow:Info()]            = true,
    },
    GetObjByItem                            = {
        [A.Soulstone.ID]                    = A.Soulstone,
        [A.GreaterSpellstone.ID]            = A.GreaterSpellstone,
        [A.MajorSpellstone.ID]                = A.MajorSpellstone,
    },
    GetLifeTapManaGainByRank                = {
        [1]                                    = 20,
        [2]                                    = 65,
        [3]                                    = 130,
        [4]                                    = 210,
        [5]                                    = 300,
        [6]                                    = 420,
    },
    GetDarkPactManaConsumeByRank            = {
        [1]                                    = 150,
        [2]                                    = 200,
        [3]                                    = 250,
    },
    GetEnslaveDemonLevelByRank                = {
        [1]                                    = 32,
        [2]                                    = 47,
        [3]                                    = 62,
    },
    GetPetID                                = {
        Imp                                 = 416,
        Voidwalker                            = 1860,
        Succubus                            = 1863,
        Felhunter                            = 417,
        Doomguard                            = 12396, -- Doomguard Commander
    },
    GetPetMeleeSpells                        = { (A.Torment:Info()), (A.LashofPain:Info())                                                                     },
    LastTimeChangedTarget                    = 0,
    DoTs                                    = {
        OnEvent                                = {
            ["UNIT_DIED"]                     = "Kill",
            ["UNIT_DESTROYED"]                = "Kill",
            ["UNIT_DISSIPATES"]                = "Kill",
            ["PARTY_KILL"]                     = "Kill",
            ["SPELL_INSTAKILL"]             = "Kill",
            ["SPELL_AURA_REMOVED"]             = "Remove",
            ["SPELL_AURA_REFRESH"]            = "Add",
            ["SPELL_AURA_APPLIED_DOSE"]        = "Add",
            ["SPELL_AURA_APPLIED"]            = "Add",
        },
        Category                            = {
            [A.Corruption:Info()]             = "DoTs",
            [A.SiphonLife:Info()]             = "DoTs",
            [A.Immolate:Info()]             = "DoTs",
            [A.Banish:Info()]                 = "DoTs",
            [A.Fear:Info()]                 = "DoTs",
            [A.CurseofAgony:Info()]         = "Curse",            
            [A.CurseofRecklessness:Info()]     = "Curse",
            [A.CurseofShadow:Info()]         = "Curse",
            [A.CurseoftheElements:Info()]     = "Curse",
            [A.CurseofTongues:Info()]         = "Curse",
            [A.CurseofWeakness:Info()]         = "Curse",
            [A.CurseofExhaustion:Info()]     = "Curse",
        },
        Data                                = {
            -- Format {} is (key-val) [GUID] = spellName 
            [A.Corruption:Info()]             = {},
            [A.SiphonLife:Info()]            = {},
            [A.Immolate:Info()]                = {},
            [A.Fear:Info()]                    = {},
            [A.Banish:Info()]                = {},
            Curse                             = {},     
        },
        Counter                                = {
            [A.Corruption:Info()]             = 0,
            [A.SiphonLife:Info()]            = 0,
            [A.Immolate:Info()]                = 0,
            [A.Fear:Info()]                    = 0,
            [A.Banish:Info()]                = 0,
        },
        WipeAll                                = function(self)
            for k, v in pairs(self.Data) do 
                wipe(v)
                if self.Counter[k] then 
                    self.Counter[k] = 0 
                end                 
            end
        end,
        CheckAndWipeByUnitID                = function(self, unitID)
            -- Additional remove if CLEU was out of 50 yards to trigger any remove event for already applied DoTs
            local GUID = UnitGUID(unitID)
            if GUID then 
                for k, v in pairs(self.Data) do 
                    if v[GUID] and Unit(unitID):HasDeBuffs(v[GUID], true) == 0 then 
                        self.Data[k][GUID]     = nil
                        if self.Counter[k] then 
                            self.Counter[k] = self.Counter[k] - 1 
                        end 
                    end 
                end 
            end     
        end,
        WipeByUnitGUID                        = function(self, GUID, spellName, skipCC)
            for k, v in pairs(self.Data) do 
                if v[GUID] and (not spellName or v[GUID] == spellName) and (not skipCC or (k ~= A.Banish:Info() and k ~= A.Fear:Info())) then                     
                    self.Data[k][GUID]         = nil
                    if self.Counter[k] then 
                        self.Counter[k]     = self.Counter[k] - 1 
                    end 
                end 
            end             
        end,
    },    
}

local TempDoTs                                = Temp.DoTs
local TempDoTsOnEvent                        = TempDoTs.OnEvent
local TempDoTsCategory                        = TempDoTs.Category
local TempDoTsData                            = TempDoTs.Data
local TempDoTsCounter                        = TempDoTs.Counter

-- Toggles - set table pointers 
local FireShieldDesination, DemonicSacrificePet, PvEDoTsBossOrPlayer, PvPDoTsBossOrPlayer, DoTsOthers, DeathCoilMode
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED_PRE", function()
        FireShieldDesination    = GetToggle(2, "FireShieldDesination")
        -- Table toggles of FireShield
        -- [1] @raid1 / @party1
        -- [2] @raid2 / @party2 
        -- [3] @raid3 / @party3
        -- [4] @primary (@target, @targettarget, @mouseover)
        -- [5] @player 
        DemonicSacrificePet     = GetToggle(2, "DemonicSacrificePet")
        -- Table toggles of DemonicSacrifice
        -- [1] "Imp"
        -- [2] "Voidwalker"
        -- [3] "Succubus"
        -- [4] "Felhunter"
        -- [5] "Doomguard"
        -- [6] "Others"
        PvEDoTsBossOrPlayer        = GetToggle(2, "PvEDoTsBossOrPlayer")
        PvPDoTsBossOrPlayer        = GetToggle(2, "PvPDoTsBossOrPlayer")
        DoTsOthers                = GetToggle(2, "DoTsOthers")
        -- Table toggles of DoTs:
        -- [1] Corruption
        -- [2] SiphonLife
        -- [3] Immolate
        DeathCoilMode            = GetToggle(2, "DeathCoilMode")
        -- Table toggles of DeathCoil:
        -- [1] Defense
        -- [2] Interrupt
        -- [3] FearMode 
        -- [4] BurstMode 
end)

TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
        TimerSet("DISABLE_PET_ERRORS", 60, function() Pet:DisableErrors(true)  end)
end)

-- Init before any code will be processed 
TeamCacheFriendly.hasPriest         = nil 
TeamCacheFriendly.countSPriest         = 0
TeamCacheFriendly.countWarlock         = 0
TeamCacheFriendly.countMage         = 0
TeamCacheFriendly.countMelee         = 0
TMW:RegisterCallback("TMW_ACTION_GROUP_UPDATE", function()
        TeamCacheFriendly.hasPriest     = nil 
        TeamCacheFriendly.countSPriest     = 0
        TeamCacheFriendly.countWarlock     = 0
        TeamCacheFriendly.countMage     = 0
        TeamCacheFriendly.countMelee     = 0
        if TeamCacheFriendly.Type then 
            local member, class
            for i = 1, TeamCacheFriendly.MaxSize do 
                member                                         = TeamCacheFriendlyIndexToPLAYERs[i]
                if member then 
                    class                                     = Unit(member):Class()
                    if class == "PRIEST" then 
                        TeamCacheFriendly.hasPriest         = true
                        if Unit(member):HasBuffs(A.Shadowform.ID) > 0 then 
                            TeamCacheFriendly.countSPriest     = TeamCacheFriendly.countSPriest + 1
                        end 
                    elseif class == "WARLOCK" then 
                        TeamCacheFriendly.countWarlock         = TeamCacheFriendly.countWarlock + 1
                    elseif class == "MAGE" then 
                        TeamCacheFriendly.countMage         = TeamCacheFriendly.countMage + 1
                    elseif Unit(member):IsMelee() then 
                        TeamCacheFriendly.countMelee         = TeamCacheFriendly.countMelee + 1
                    end 
                end 
            end 
        end 
end)

-- Tracks Invisible in PvP (3 sec cooldown is enough)
Temp.InvisAuras    = {1784, 1856, 5215, 20580}
-- Rogue: Stealth
UnitCooldown:Register(1784, 3, false, true)
-- Rogue: Vanish 
UnitCooldown:Register(1856, 3, false, true)
-- Druid: Prowl 
UnitCooldown:Register(5215, 3, false, true)
-- NightElf: Shadowmeld
UnitCooldown:Register(20580, 3, false, true)

Listener:Add("ACTION_EVENT_WARLOCK_INVISIBLE", "PLAYER_REGEN_ENABLED", function()         
        if A.Zone ~= "pvp" then 
            Temp.hasInvisibleUnits, Temp.invisibleUnitID = nil, nil 
        end 
end) 

-- Tracks Time since target change 
Listener:Add("ACTION_EVENT_WARLOCK_TARGET_CHANGED", "PLAYER_TARGET_CHANGED", function()
        Temp.LastTimeChangedTarget = TMW.time
end)

-- Tracks DoTs and Curse
TMW:RegisterCallback("TMW_ACTION_ENTERING",    function(event, subevent)
        if subevent ~= "UPDATE_INSTANCE_INFO" then 
            TempDoTs:WipeAll()
        end 
end)
TMW:RegisterCallback("TMW_ACTION_COMBAT_TRACKER_GUID_WIPE", function(event, GUID)
        TempDoTs:WipeByUnitGUID(GUID, nil, true)
end)
Listener:Add("ACTION_EVENT_WARLOCK_DOTS", "COMBAT_LOG_EVENT_UNFILTERED", function(...)
        local _, EVENT, _, SourceGUID, _, _, _, DestGUID, _, DestFlags, _, _, spellName = CombatLogGetCurrentEventInfo()    
        
        if TempDoTsOnEvent[EVENT] == "Kill" then 
            TempDoTs:WipeByUnitGUID(DestGUID)
        elseif TempDoTsOnEvent[EVENT] == "Remove" then 
            if spellName and SourceGUID == GetGUID(player) and TempDoTsCategory[spellName] then -- and IsEnemy(DestFlags) commented because can be out of charm friendly
                TempDoTs:WipeByUnitGUID(DestGUID, spellName)
            end 
        elseif TempDoTsOnEvent[EVENT] == "Add" then     
            if SourceGUID == GetGUID(player) and TempDoTsCategory[spellName] and IsEnemy(DestFlags) then 
                if TempDoTsCategory[spellName] == "DoTs" then 
                    TempDoTsData[spellName][DestGUID]         = spellName
                    TempDoTsCounter[spellName]    = TempDoTsCounter[spellName] + 1
                elseif TempDoTsCategory[spellName] == "Curse" then 
                    TempDoTsData.Curse[DestGUID]             = spellName
                end 
            end 
        end 
end)
Listener:Add("ACTION_EVENT_WARLOCK_DOTS", "PLAYER_TARGET_CHANGED", function()         TempDoTs:CheckAndWipeByUnitID("target")         end)
Listener:Add("ACTION_EVENT_WARLOCK_DOTS", "UPDATE_MOUSEOVER_UNIT", function()         TempDoTs:CheckAndWipeByUnitID("mouseover")        end)
Listener:Add("ACTION_EVENT_WARLOCK_DOTS", "NAME_PLATE_UNIT_ADDED", function(...)     TempDoTs:CheckAndWipeByUnitID(...)                end)
Listener:Add("ACTION_EVENT_WARLOCK_DOTS", "UNIT_TARGET",           function(...) 
        local unitID = ... 
        if unitID ~= player and unitID ~= pet then 
            TempDoTs:CheckAndWipeByUnitID(unitID .. "target")
        end 
end)

function Temp.IsInvisAffected()
    -- @return boolean
    for i = 1, #Temp.InvisAuras do 
        if UnitCooldown:GetCooldown("enemy", Temp.InvisAuras[i]) > 0 then 
            return true 
        end 
    end 
end 

function Temp.IsSchoolShadowUP()
    -- @return boolean 
    return LoC:Get("SILENCE") == 0 and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

function Temp.IsSchoolFireUP()
    -- @return boolean 
    return LoC:Get("SILENCE") == 0 and LoC:Get("SCHOOL_INTERRUPT", "FIRE") == 0
end 

function Temp.IsBossFight()
    -- @return boolean 
    if Unit("target"):IsBoss() then 
        return true 
    else 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() then 
                return true 
            end 
        end 
        
        if TeamCacheFriendly.Type and not A.IsInPvP and A.IsInInstance then 
            local member
            for i = 1, TeamCacheFriendly.MaxSize do 
                member = TeamCacheFriendlyIndexToPLAYERs[i]
                if member and Unit(member .. "target"):IsBoss() then 
                    return true 
                end
            end
        end 
    end 
end
Temp.IsBossFight = A.MakeFunctionCachedStatic(Temp.IsBossFight)

function Temp.IsPetInMelee(unitID)
    -- @return boolean 
    return Pet:IsInRange(Temp.GetPetMeleeSpells[1], unitID) or Pet:IsInRange(Temp.GetPetMeleeSpells[2], unitID)
end

function Temp.DetermineUsablePet(soulShards, ...)
    -- @return object or nil 
    for i = 1, select("#", ...) do 
        local object = select(i, ...)        
        
        if object:IsReady(player) then 
            if Pet:IsActive(Temp.IsCastIsSummon[object:Info()]) then 
                return 
            end 
            
            if (soulShards > 0 or not Temp.IsRequiredSoulShard[object:Info()]) then         
                return object
            end 
        end 
    end 
end 

function Temp.GetAutoSummonPet(soulShards, petName)
    -- @return object or nil 
    if A.IsInPvP then 
        -- Imp 
        if A.SummonImp:IsReady(player) and A.Zone == "pvp" and not TeamCacheFriendly.hasPriest and A:GetTimeSinceJoinInstance() >= 60 then 
            if petName == "Imp" then 
                return 
            end 
            
            if Unit(player):HasBuffs(A.BloodPact.ID) == 0 then 
                return A.SummonImp
            end 
        end 
        
        -- Felhunter
        if soulShards > 0 and A.SummonFelhunter:IsReady(player) and (TeamCacheFriendly.Type or (A.IsInDuel and Temp.IsClassValidForFelhunter[Unit("target"):IsEnemy() and Unit("target"):Class() or ""])) then 
            if petName == "Felhunter" then 
                return 
            end 
            
            return A.SummonFelhunter
        end 
    else
        -- Imp 
        if A.SummonImp:IsReady(player) and TeamCacheFriendly.Type and A.IsInInstance and not TeamCacheFriendly.hasPriest then 
            if petName == "Imp" then 
                return 
            end 
            
            if Unit(player):HasBuffs(A.BloodPact.ID) == 0 then 
                return A.SummonImp
            end 
        end 
        
        -- Succubus
        if soulShards > 0 and A.SummonSuccubus:IsReady(player) and (A.PlayerLevel < 60 or TeamCacheFriendly.Type) then 
            if petName == "Succubus" then 
                return 
            end 
            
            return A.SummonSuccubus
        end                 
    end 
    
    return Temp.DetermineUsablePet(soulShards, A.SummonVoidwalker, A.SummonSuccubus, A.SummonFelhunter, A.SummonImp) 
end 

function Temp.GetActivePet()
    -- @return boolean, string or nil, nil 
    if Pet:IsActive(Temp.GetPetID.Imp) then 
        return true, "Imp"
    elseif Pet:IsActive(Temp.GetPetID.Voidwalker) then 
        return true, "Voidwalker"
    elseif Pet:IsActive(Temp.GetPetID.Succubus) then 
        return true, "Succubus"
    elseif Pet:IsActive(Temp.GetPetID.Felhunter) then 
        return true, "Felhunter"
    elseif Pet:IsActive(Temp.GetPetID.Doomguard) then 
        return true, "Doomguard"
    end 
    
    return Pet:IsActive()
end 

local function GetSoulShards()
    -- @return number 
    return Player:GetBag("SOUL_SHARD") and Player:GetBag("SOUL_SHARD").count or A.SoulShard:GetCount() or 0
end 

local function GetHealthstonesByCastName(castName, checkHighRanks)
    -- @return number
    local count     
    if checkHighRanks then 
        for _, v in ipairs(Temp.CastHealthStoneToAllHisRankItems[castName]) do 
            count = v:GetCount()
            if count > 0 then 
                return count
            end 
        end 
    else         
        for _, v in ipairs(Temp.CastHealthStoneToItems[castName]) do             
            count = v:GetCount()
            if count > 0 then 
                return count
            end 
        end 
    end
    
    return 0
end 

local function GetFirestoneInBag()
    -- @return itemID or nil 
    for i = 1, #Temp.BagFirestone do 
        if Player:GetBag(Temp.BagFirestone[i]) then 
            return Player:GetBag(Temp.BagFirestone[i]).itemID 
        end 
    end 
end 

local function GetSpellstoneInBag()
    -- @return itemID or nil 
    for i = 1, #Temp.BagSpellstone do 
        if Player:GetBag(Temp.BagSpellstone[i]) then 
            return Player:GetBag(Temp.BagSpellstone[i]).itemID 
        end 
    end 
end 

local function GetSoulstoneInBag()
    -- @return itemID or nil 
    for i = 1, #Temp.BagSoulstone do 
        if Player:GetBag(Temp.BagSoulstone[i]) then 
            return Player:GetBag(Temp.BagSoulstone[i]).itemID 
        end 
    end 
end 

local max_search = 5
local function GetEnemies()
    -- @return number 
    local enemies = 1
    local compare = 0
    
    -- #1 method is if petID 
    compare = Pet:GetMultiUnitsBySpell(Temp.GetPetMeleeSpells, max_search)    
    if compare > enemies then 
        enemies = compare
    end 
    
    -- #2 method is CLEU + by range in combat 
    compare = MultiUnits:GetActiveEnemies()
    if compare > enemies then 
        enemies = compare
    end 
    
    return enemies
end 

local function GetActiveDoTsCounter(spellName)
    -- @return number 
    return TempDoTsCounter[spellName] or 0
end 

local function GetActiveCurse()
    -- @return GUID, spellName or nil, nil 
    return next(TempDoTsData.Curse)
end 

local function CanUseCurse(target, targetTTD, targetIsPlayer, obj, isP)
    -- @return boolean 
    if (not isP and obj:IsReady(target)) or (isP and obj:IsReadyP(target)) then 
        if obj == A.CurseofAgony then 
            return targetTTD >= 10 and Unit(target):HasDeBuffs(obj.ID) == 0 and obj:AbsentImun(target, Temp.AuraForCC)
        elseif obj == A.CurseofDoom then 
            return targetTTD >= 60 and not targetIsPlayer and Unit(target):HasDeBuffs(obj.ID) == 0 and obj:AbsentImun(target, Temp.AuraForCC)
        elseif obj == A.CurseofExhaustion then 
            return targetTTD >= 6 and targetIsPlayer and Unit(target):GetCurrentSpeed() >= 100 and Unit(target):HasDeBuffs(obj.ID) == 0 and obj:AbsentImun(target, Temp.AuraForFreedom)
        else 
            if targetTTD >= 10 then 
                if Unit(target):HasDeBuffs(obj.ID) == 0 then 
                    return obj:AbsentImun(target, Temp.AuraForCC)
                else 
                    local myDur = Unit(target):HasDeBuffs(obj.ID, true)
                    return myDur > 0 and myDur <= 4 and obj:AbsentImun(target, Temp.AuraForCC)
                end 
            end 
        end 
    end 
end 

local function DetermineUsableCurse(target, targetTTD, targetIsPlayer, curseName, ...)
    -- @return object or nil 
    local obj
    for i = 1, select("#", ...) do 
        obj = select(i, ...)
        if (not curseName or curseName == obj:Info()) and CanUseCurse(target, targetTTD, targetIsPlayer, obj) then 
            return obj 
        end 
    end 
end 

local function CanTargetNearest(inCombat, enemies, useAutoTarget)
    -- @return boolean 
    -- Note: Only [3] APL
    return inCombat and enemies > 1 and useAutoTarget
end 

local function CanCastFireShield(unitID, isP)
    -- @return boolean 
    -- Note: Only [3] APL
    return (UnitIsUnit(unitID, player) or (Unit(unitID):IsPlayer() and Unit(unitID):InGroup())) and ((not isP and A.FireShield:IsReady(unitID, true)) or (isP and A.FireShield:IsReadyP(unitID, true))) and Pet:IsInRange((A.FireShield:Info()), unitID) and Unit(unitID):HasBuffs(A.FireShield.ID) == 0 and Unit(pet):InCC() == 0
end

local function CanDispel(unitID, petName, isFriendly)
    -- @return boolean 
    -- Note: Only [3] APL
    if (petName == "Felhunter" and A.DevourMagic:IsReady(unitID, true) and Pet:IsInRange((A.DevourMagic:Info()), unitID)) or (petName == "Doomguard" and A.DispelMagic:IsReady(unitID, true) and Pet:IsInRange((A.DispelMagic:Info()), unitID)) then 
        if isFriendly then 
            if (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) and Unit(pet):InCC() == 0 then 
                return true
            end 
        else 
            if (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) and Unit(pet):InCC() == 0 then 
                return true
            end 
        end 
    end 
end 

local function CanInterrupt(unitID, petName)
    -- @return boolean 
    -- Note: Only [3] APL
    if GetToggle(2, A.IsInPvP and "UseInterruptByPetPvP" or "UseInterruptByPetPvE") then 
        local useKick, useCC = InterruptIsValid(unitID, "TargetMouseover")
        if useKick or useCC then 
            local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
            if petName == "Felhunter" and useKick and not notKickAble and castLeft > 0 and castLeft <= GetGCD() + GetCurrentGCD() + GetPing() and Pet:IsInRange((A.SpellLock:Info()), unitID) and A.SpellLock:IsReady(unitID, true) and A.SpellLock:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(pet):InCC() == 0 then 
                return true    
            end 
            
            if petName == "Succubus" and useCC and Unit(unitID):IsHumanoid() and castLeft > A.Seduction:GetSpellCastTimeCache() + GetPing() and castLeft <= A.Seduction:GetSpellCastTimeCache() + GetPing() + GetGCD() and Pet:IsInRange((A.Seduction:Info()), unitID) and A.Seduction:IsReady(unitID, true) and A.Seduction:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("fear", 0) and Unit(pet):InCC() == 0 then 
                return true        
            end 
            
            if petName == "Doomguard" and useCC and castLeft <= GetPing() + GetGCD() and Temp.IsPetInMelee(unitID) and A.Warstomp:IsReady(unitID, true) and A.Warstomp:AbsentImun(unitID, Temp.AuraForWarStomp) and Unit(unitID):IsControlAble("stun", 0) and Unit(pet):InCC() == 0 then 
                return true             
            end
        end 
    end 
end 

local function CanFear(unitID) 
    -- @return boolean 
    -- Note: Only [3] APL
    if GetActiveDoTsCounter(A.Fear:Info()) == 0 and not A.Fear:IsSpellLastGCD() and not A.Fear:IsSpellInFlight() and A.Fear:IsReadyByPassCastGCD(unitID) and A.Fear:AbsentImun(unitID, Temp.AuraForFear) and not Unit(unitID):IsTotem() and Unit(unitID):IsControlAble("fear", 0) and Unit(unitID):InCC() == 0 then 
        return true 
    end 
end 

local function UnitHasFireImun(unitID)
    -- @return boolean 
    return select(6, Unit(unitID):InfoGUID()) == 14020
end
--[[ Note
A:IsReady(unitID, skipRange, skipLua, skipShouldStop, skipUsable)
A:IsReadyP(unitID, skipRange, skipLua, skipShouldStop, skipUsable)
A:IsReadyM(unitID, skipRange, skipUsable)
A:IsReadyByPassCastGCD(unitID, skipRange, skipLua, skipUsable)
A:IsReadyByPassCastGCDP(unitID, skipRange, skipLua, skipUsable)
A:IsReadyToUse(unitID, skipShouldStop, skipUsable)
]]

-- [Globals]
local ChatNotification = {
    enUS = "Fear Mode: ",
    ruRU = "Режим Страха: ",
}
function Action.ToggleFearMode(state)
    -- Note: For button use in UI 
    if state ~= nil then 
        isFearMode = state
    else
        isFearMode = not isFearMode
    end  
    Print(ChatNotification[GetCL()] .. toStr[isFearMode])
end

-- [MSG System]
function Action.WarlockMSG_CanInterrupt(unitID)
    -- @return boolean 
    if Unit(unitID):IsEnemy() and GetToggle(2, A.IsInPvP and "UseInterruptByPetPvP" or "UseInterruptByPetPvE") then 
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > 0 then 
            if Pet:IsActive(Temp.GetPetID.Felhunter) and not notKickAble and Pet:IsInRange((A.SpellLock:Info()), unitID) and A.SpellLock:IsReadyM(unitID, true) and A.SpellLock:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(pet):InCC() == 0 then 
                return true    
            end 
            
            if Pet:IsActive(Temp.GetPetID.Succubus) and Unit(unitID):IsHumanoid() and castLeft > A.Seduction:GetSpellCastTimeCache() + GetPing() and Pet:IsInRange((A.Seduction:Info()), unitID) and A.Seduction:IsReadyM(unitID, true) and A.Seduction:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("fear", 0) and Unit(pet):InCC() == 0 then 
                return true        
            end 
            
            if Pet:IsActive(Temp.GetPetID.Doomguard) and Temp.IsPetInMelee(unitID) and A.Warstomp:IsReadyM(unitID, true) and A.Warstomp:AbsentImun(unitID, Temp.AuraForWarStomp) and Unit(unitID):IsControlAble("stun", 0) and Unit(pet):InCC() == 0 then 
                return true             
            end        
        end 
    end 
end 

function Action.WarlockMSG_CanDispel(unitID)
    -- @return boolean 
    local petIsActive, petName = Temp.GetActivePet()
    if petIsActive and petName then 
        return CanDispel(unitID, petName, not Unit(unitID):IsEnemy())
    end 
end

function Action.WarlockMSG_CanStun(unitID)
    -- @return boolean 
    if Unit(unitID):IsEnemy() and Pet:IsActive(Temp.GetPetID.Doomguard) and Temp.IsPetInMelee(unitID) and A.Warstomp:IsReadyM(unitID, true) and A.Warstomp:AbsentImun(unitID, Temp.AuraForWarStomp) and Unit(unitID):IsControlAble("stun", 0) and Unit(pet):InCC() == 0 then 
        return true             
    end        
end 

function Action.WarlockMSG_CanFear(unitID)
    -- @return boolean 
    if Unit(unitID):IsEnemy() and Temp.IsSchoolShadowUP() and Player:IsStaying() and GetActiveDoTsCounter(A.Fear:Info()) == 0 and not A.Fear:IsSpellLastCastOrGCD() and A.Fear:IsReadyM(unitID) and A.Fear:AbsentImun(unitID, Temp.AuraForFear) and not Unit(unitID):IsTotem() and Unit(unitID):IsControlAble("fear", 0) and Unit(unitID):InCC() == 0 then 
        return true 
    end
end 

-- [Cast Bars]
function Action.Pet_CastBars(unitID, list)
    if A.IsInitialized and A.Zone == "pvp" and Pet:IsActive() and InterruptIsValid(unitID, list) and (not Unit(unitID):InLOS() or UnitIsUnit("pettarget", unitID)) then  -- not UnitIsUnit(unitID, "target") 
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > 0 then 
            if Pet:IsActive(Temp.GetPetID.Felhunter) and not notKickAble and Pet:IsInRange((A.CastBarsInterruptSpellLock:Info()), unitID) and A.CastBarsInterruptSpellLock:IsReadyByPassCastGCD(unitID, true) and A.CastBarsInterruptSpellLock:AbsentImun(unitID, Temp.AuraForInterrupt) then 
                return Unit(pet):InCC() == 0         
            end 
            
            if Pet:IsActive(Temp.GetPetID.Succubus) and castLeft > A.CastBarsInterruptSeduction:GetSpellCastTimeCache() + GetPing() and Pet:IsInRange((A.CastBarsInterruptSeduction:Info()), unitID) and A.CastBarsInterruptSeduction:IsReadyByPassCastGCD(unitID, true) and A.CastBarsInterruptSeduction:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("fear", 0) then 
                return Unit(pet):InCC() == 0          
            end 
            
            if Pet:IsActive(Temp.GetPetID.Doomguard) and Temp.IsPetInMelee(unitID) and A.CastBarsInterruptWarstomp:IsReadyByPassCastGCD(unitID, true) and A.CastBarsInterruptWarstomp:AbsentImun(unitID, Temp.AuraForWarStomp) and Unit(unitID):IsControlAble("stun", 0) then 
                return Unit(pet):InCC() == 0          
            end 
        end 
    end 
end
-- Placed in Env. for faster performance 
Env.Pet_CastBars = Action.Pet_CastBars

-- [1] CC AntiFake Rotation
A[1] = function(icon)    
    if Player:IsStaying() and Temp.IsSchoolShadowUP() then 
        local unitID
        if IsUnitEnemy("mouseover") then 
            unitID = "mouseover"
        elseif IsUnitEnemy("target") then 
            unitID = "target"
        end 
        
        if unitID and A.AntiFakeCC:IsReadyByPassCastGCD(unitID) and Unit(unitID):IsControlAble("fear", 0) and A.AntiFakeCC:AbsentImun(unitID, Temp.AuraForFear) and not A.AntiFakeCC:IsSpellLastCastOrGCD() and not A.AntiFakeCC:IsSpellInFlight() then 
            return A.AntiFakeCC:Show(icon)
        end 
    end 
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)    
    if Pet:IsActive() then 
        local unitID
        if IsUnitEnemy("mouseover") then 
            unitID = "mouseover"
        elseif IsUnitEnemy("target") then 
            unitID = "target"
        end 
        
        if unitID then         
            local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
            if castLeft > 0 then                 
                if Pet:IsActive(Temp.GetPetID.Felhunter) and Pet:IsInRange((A.AntiFakeInterruptSpellLock:Info()), unitID) and A.AntiFakeInterruptSpellLock:IsReadyByPassCastGCD(unitID, true) and A.AntiFakeInterruptSpellLock:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(pet):InCC() == 0 then 
                    return A.AntiFakeInterruptSpellLock:Show(icon)         
                end 
                
                if Pet:IsActive(Temp.GetPetID.Succubus) and Unit(unitID):IsHumanoid() and castLeft > A.AntiFakeInterruptSeduction:GetSpellCastTimeCache() + GetPing() and Pet:IsInRange((A.AntiFakeInterruptSeduction:Info()), unitID) and A.AntiFakeInterruptSeduction:IsReadyByPassCastGCD(unitID, true) and A.AntiFakeInterruptSeduction:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("fear", 0) and Unit(pet):InCC() == 0 then 
                    return A.AntiFakeInterruptSeduction:Show(icon)             
                end 
                
                if Pet:IsActive(Temp.GetPetID.Doomguard) and Temp.IsPetInMelee(unitID) and A.AntiFakeInterruptWarstomp:IsReadyByPassCastGCD(unitID, true) and A.AntiFakeInterruptWarstomp:AbsentImun(unitID, Temp.AuraForWarStomp) and Unit(unitID):IsControlAble("stun", 0) and Unit(pet):InCC() == 0 then 
                    return A.AntiFakeInterruptWarstomp:Show(icon)              
                end
            end 
        end 
    end 
end

-- [3] Rotation 
A[3] = function(icon)        
    -- Pet 
    local petIsActive, petName                        = Temp.GetActivePet()
    local petHP                                        = petIsActive and Unit(pet):HealthPercent() or 0
    -- Player         
    local handStoneToUse                            = GetToggle(2, "HandStoneToUse")
    local potionToUse                                = GetToggle(2, "PotionToUse") -- "MajorManaPotion" default
    local castLeftSecs, castLeftPerc, _, castName    = Unit(player):IsCastingRemains()
    local isImportantCast                            = castName and Temp.IsNotStopCastAble[castName]
    local combatTime                                = Unit(player):CombatTime()
    local inCombat                                     = combatTime > 0
    local isSchoolShadowUP                            = Temp.IsSchoolShadowUP()
    local isSchoolFireUP                            = Temp.IsSchoolFireUP()
    local soulShards                                = GetSoulShards()
    local offHand                                    = Player:GetInv("WL_OFF_HAND") and Player:GetInv("WL_OFF_HAND").itemID
    local useAutoTarget                                = GetToggle(1, "AutoTarget")
    local useStopCast                                 = GetToggle(1, "StopCast")    
    local useAoE                                    = GetToggle(2, "AoE")
    -- Other 
    local enemies                                    = GetEnemies()
    local mouseover, mouseoverInRange30, target, targetTTD, targetInRange30, targetHealthPercent, targetDeBuffsLimited, targetIsTotem, targetIsBoss, targetIsPlayer, targetIsBossOrPlayer
    -- Curse 
    local curseBossOrPlayer                            = GetToggle(2, A.IsInPvP and "CurseBossOrPlayerPvP" or "CurseBossOrPlayerPvE")
    local curseOthers                                = GetToggle(2, A.IsInPvP and "CurseOthersPvP" or "CurseOthersPvE")
    
    if IsUnitEnemy("target") then
        target                                        = "target"  
        targetTTD                                    = Unit(target):TimeToDie()        
        targetInRange30                                = A.ShadowBolt:IsSpellInRange(target)
        targetHealthPercent                            = Unit(target):HealthPercent()    
        targetDeBuffsLimited                        = Unit(target):IsDeBuffsLimited()
        targetIsTotem                                = Unit(target):IsTotem()
        targetIsBoss                                = Unit(target):IsBoss()
        targetIsPlayer                                = Unit(target):IsPlayer()
        targetIsBossOrPlayer                        = targetIsBoss or targetIsPlayer
    else 
        targetHealthPercent                            = 0
    end 
    
    if IsUnitEnemy("mouseover") then 
        mouseover                    = "mouseover" 
        mouseoverInRange30            = A.ShadowBolt:IsSpellInRange(mouseover)
    end 
    
    -- [[ STOP CAST ]]
    if castName and useStopCast then 
        -- This supposed to prevent probably bug with double casting 
        if Temp.IsCastIsSummon[castName] and Pet:IsActive(Temp.IsCastIsSummon[castName]) then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        if Temp.CastToItem[castName] then 
            if Temp.CastToItem[castName] == "HealthStone" then 
                if GetHealthstonesByCastName(castName) > 0 then 
                    return A:Show(icon, ACTION_CONST_STOPCAST)
                end 
            else 
                if Temp.CastToItem[castName]:GetCount() > 0 or Temp.CastToItem[castName]:GetEquipped() then 
                    return A:Show(icon, ACTION_CONST_STOPCAST)
                end 
            end 
        end 
        
        -- Other conditions
        if A.HealthFunnel:Info() == castName and (not petIsActive or petHP >= GetToggle(2, "HealthFunnelStopCastHP")) then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        if A.Banish:Info() == castName and GetActiveDoTsCounter(A.Banish:Info()) ~= 0 and A.Banish:IsSpellLastGCD() then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        if A.Hellfire:Info() == castName and (Unit(player):IsExecuted() or (A.IsInPvP and EnemyTeam():IsBreakAble(10))) then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        if A.RainofFire:Info() == castName and A.IsInPvP and EnemyTeam():IsBreakAble(40) then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end
    end 
    
    -- [[ RETURN ]]
    if not offHand and handStoneToUse ~= "OFF" and Player:IsSwapLocked() then 
        return 
    end         
    
    -- Equip Firestone
    if handStoneToUse == "Firestone" and not offHand and not Player:IsSwapLocked() and GetFirestoneInBag() then 
        return A.Firestone:Show(icon)
    end
    
    -- Equip Spellstone
    if handStoneToUse == "Spellstone" and not offHand and not Player:IsSwapLocked() and GetSpellstoneInBag() then 
        return A.Spellstone:Show(icon)
    end    
    
    -- Pet AutoAttack
    if inCombat and not mouseover and target and petIsActive and not Pet:IsAttacking(target) and GetToggle(1, "AutoAttack") and TMW.time - Temp.LastTimeChangedTarget > GetGCD() * 2.5 + GetCurrentGCD() + GetPing() and (petName ~= "Imp" or select(2, A.Firebolt:GetSpellAutocast())) and (petName ~= "Succubus" or not Unit(pet):IsCasting()) and A.AbsentImun(nil, target, petName ~= "Imp" and Temp.AttackTypesPhys or Temp.AttackTypes) then 
        return A:Show(icon, ACTION_CONST_AUTOATTACK)
    end 
    
    -- Racials (Loss Of Control)
    if GetToggle(2, "UseRacialOnLoC") then         
        -- WilloftheForsaken
        if A.WilloftheForsaken:AutoRacial() then 
            return A.WilloftheForsaken:Show(icon)
        end 
        
        -- EscapeArtist
        if A.EscapeArtist:AutoRacial() and not mouseoverInRange30 and not targetInRange30 then 
            return A.EscapeArtist:Show(icon)
        end 
    end 
    
    -- LivingActionPotion
    if potionToUse == "LivingActionPotion" and Action.CanUseLivingActionPotion(icon, mouseoverInRange30 or targetInRange30) then 
        return true
    end 
    
    -- RestorativePotion
    if potionToUse == "RestorativePotion" and inCombat and Action.CanUseRestorativePotion(icon) then 
        return true 
    end         
    
    -- Spellstone 
    if handStoneToUse == "Spellstone" and inCombat and offHand and Temp.GetObjByItem[offHand] and Temp.GetObjByItem[offHand]:IsReady(player) then 
        if GetToggle(2, "SpellstoneUseDispel") and (AuraIsValid(player, "UseDispel", "Magic") or AuraIsValid(player, "UsePurge", "PurgeFriendly")) then 
            return Temp.GetObjByItem[offHand]:Show(icon)
        end 
        
        if GetToggle(2, "SpellstoneUseDefense") and Unit(player):GetRealTimeDMG() > 0 and Unit(player):TimeToDieMagicX(25) < GetGCD() * 2 then 
            return Temp.GetObjByItem[offHand]:Show(icon)
        end 
    end 
    
    -- [[ SELF DEFENSE ]]
    if inCombat then 
        -- LimitedInvulnerabilityPotion
        if potionToUse == "LimitedInvulnerabilityPotion" and combatTime > 2 and Unit(player):HasBuffs("DeffBuffs") and Action.CanUseLimitedInvulnerabilityPotion(icon) then 
            return true  
        end 
        
        -- HealingPotion 
        if potionToUse == "HealingPotion" and combatTime > 2 and Action.CanUseHealingPotion(icon) then 
            return true 
        end 
        
        -- Sacrifice
        if petName == "Voidwalker" and A.Sacrifice:IsReadyByPassCastGCD(player) then 
            local SacrificeTTD, SacrificeOperator, SacrificeHP = GetToggle(2, "SacrificeTTD"), GetToggle(2, "SacrificeOperator"), GetToggle(2, "SacrificeHP")
            if (SacrificeTTD >= 0 or SacrificeHP >= 0) and Unit(player):GetRealTimeDMG() > 0 then 
                if SacrificeOperator == "AND" then 
                    if (SacrificeTTD < 0 or Unit(player):TimeToDie() <= SacrificeTTD) and (SacrificeHP < 0 or Unit(player):HealthPercent() <= SacrificeHP) then 
                        return A.Sacrifice:Show(icon)
                    end 
                else
                    if (SacrificeTTD >= 0 and Unit(player):TimeToDie() <= SacrificeTTD) or (SacrificeHP >= 0 and Unit(player):HealthPercent() <= SacrificeHP) then 
                        return A.Sacrifice:Show(icon)
                    end 
                end 
            end 
        end 
        
        -- DeathCoil
        if isSchoolShadowUP and target and DeathCoilMode[1] and A.DeathCoil:IsReady(target) and Unit(player):IsExecuted() and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) then 
            return A.DeathCoil:Show(icon)
        end 
        
        -- ShadowWard
        if isSchoolShadowUP and A.ShadowWard:IsReady(player) then 
            local incShadowDMG = Unit(player):GetSchoolDMG(5)
            -- Shared use 
            if GetToggle(2, "ShadowWardPerSecHP") >= 0 and incShadowDMG * 100 / Unit(player):HealthMax() >= GetToggle(2, "ShadowWardPerSecHP") then -- Shadow DMG inc per sec in percentage scale of the health
                return A.ShadowWard:Show(icon)
            end 
            
            -- PvP use 
            if GetToggle(2, "ShadowWardPvP") and A.IsInPvP and ((A.IsInDuel and (mouseover or target) and (Unit(mouseover or target):Class() == "PRIEST" or Unit(mouseover or target):Class() == "WARLOCK")) or (incShadowDMG > 0 and EnemyTeam("DAMAGER"):FocusingUnitIDByClasses(player, 1, nil, "PRIEST", "WARLOCK"))) then 
                return A.ShadowWard:Show(icon)
            end                         
        end         
        
        -- Trinkets  
        if Unit(player):IsExecuted() then 
            if A.Trinket1:IsReady(target) and A.Trinket1:IsItemTank() then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(target) and A.Trinket2:IsItemTank() then 
                return A.Trinket2:Show(icon)
            end 
        end         
        
        -- DrainLife
        -- Note: Super emergency
        if target and isSchoolShadowUP and Player:IsStaying() and A.DrainLife:IsReady(target) and Unit(player):IsExecuted() and Unit(player):HealthPercent() < 35 and A.DrainLife:AbsentImun(target, Temp.AttackTypes) then 
            return A.DrainLife:Show(icon)
        end             
        
        -- HowlofTerror
        if isSchoolShadowUP and A.IsInPvP and Player:IsStaying() and A.HowlofTerror:IsReady(player, true) then 
            -- Enemy healer
            if A.Zone == "pvp" then 
                local enemyHealerInRange, _, enemyHealerUnitID = EnemyTeam("HEALER"):PlayersInRange(1)
                if enemyHealerInRange and not UnitIsUnit(enemyHealerUnitID, "target") and ((Unit(enemyHealerUnitID):GetRange() > 0 and Unit(enemyHealerUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(enemyHealerUnitID) and Unit(pet):GetRange() <= 10)) and A.HowlofTerror:AbsentImun(enemyHealerUnitID, Temp.AuraForFear) and Unit(enemyHealerUnitID):IsControlAble("fear") then 
                    return A.HowlofTerror:Show(icon)
                end 
            end 
            
            -- Enemy players 
            local namePlateUnitID
            local damagersOnPlayer = 0
            for namePlateUnitID in pairs(ActiveUnitPlates) do                 
                if Unit(namePlateUnitID):IsPlayer() and ((Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(namePlateUnitID) and Unit(pet):GetRange() <= 10)) and A.HowlofTerror:AbsentImun(namePlateUnitID, Temp.AuraForFear) and Unit(namePlateUnitID):IsControlAble("fear") then 
                    if UnitIsUnit(namePlateUnitID .. "target", player) and Unit(namePlateUnitID):IsDamager() then 
                        damagersOnPlayer = damagersOnPlayer + 1
                    end 
                    
                    -- Multi-fear all damager who sits on player                    
                    if damagersOnPlayer >= 3 then 
                        return A.HowlofTerror:Show(icon)
                    end 
                    
                    -- Fear nearest not selected in target:
                    -- 1. With any burst buffs
                    -- 2. With any casting spell 
                    -- 3. If it's enemy healer 
                    -- 4. If in unit's own target on execute phase any unit 
                    if not UnitIsUnit(namePlateUnitID, "target") and (Unit(namePlateUnitID .. "target"):IsExecuted() or Unit(namePlateUnitID):IsCastingRemains() > 0 or Unit(namePlateUnitID):HasBuffs("DamageBuffs") > 2 or Unit(namePlateUnitID):IsHealer()) and (not Unit(namePlateUnitID):IsFocused() or Unit(namePlateUnitID):GetRealTimeDMG() == 0) then 
                        return A.HowlofTerror:Show(icon)
                    end 
                end 
            end 
        end         
    end 
    
    -- Detect Invisibility    
    if A.IsInPvP and GetToggle(2, "TryToFindInvisible") then 
        if A.Zone == "pvp" then 
            if not inCombat then 
                if not Temp.hasInvisibleUnits then 
                    Temp.hasInvisibleUnits, Temp.invisibleUnitID = EnemyTeam():HasInvisibleUnits()
                end 
                
                -- Racial spell
                -- Note: Try to catch by entering combat through someone around while we're not entered 
                if Temp.hasInvisibleUnits and A.Perception:IsRacialReady(player) and not Unit(Temp.invisibleUnitID):IsVisible() and (MultiUnits:GetByRangeInCombat(nil, 1) >= 1 or FriendlyTeam():PlayersInCombat(25, 5)) then 
                    return A.Perception:Show(icon)
                end 
                
                -- Class spell
                if isSchoolShadowUP and (Temp.hasInvisibleUnits or A:GetTimeSinceJoinInstance() < 60) and Unit(player):HasBuffs(Temp.BuffsDetectInvisible, true) == 0 then 
                    local DetectInvisible = DetermineUsableObject(player, true, nil, nil, nil, A.DetectGreaterInvisibility, A.DetectInvisibility, A.DetectLesserInvisibility)
                    if DetectInvisible then 
                        return DetectInvisible:Show(icon)
                    end
                end                 
            elseif Temp.IsInvisAffected() then 
                -- Try to catch by used spells of stealth
                if A.Perception:IsRacialReady(player) then 
                    return A.Perception:Show(icon)
                elseif isSchoolShadowUP and Unit(player):HasBuffs(Temp.BuffsDetectInvisible, true) == 0 then 
                    local DetectInvisible = DetermineUsableObject(player, true, nil, nil, nil, A.DetectGreaterInvisibility, A.DetectInvisibility, A.DetectLesserInvisibility)
                    if DetectInvisible then 
                        return DetectInvisible:Show(icon)
                    end
                end          
            end 
        elseif inCombat and (A.Zone == "none" or A:GetTimeDuel() > 2) and Temp.IsInvisAffected() then 
            -- Try to catch wpvp and duel 
            if A.Perception:IsRacialReady(player) then 
                return A.Perception:Show(icon)
            elseif isSchoolShadowUP and Unit(player):HasBuffs(Temp.BuffsDetectInvisible, true) == 0 then 
                local DetectInvisible = DetermineUsableObject(player, true, nil, nil, nil, A.DetectGreaterInvisibility, A.DetectInvisibility, A.DetectLesserInvisibility)
                if DetectInvisible then 
                    return DetectInvisible:Show(icon)
                end
            end 
        elseif isSchoolShadowUP and A.IsInDuel and (mouseover or target) and (Temp.IsClassValidForInvisible[Unit(mouseover or target):Class()] or Unit(mouseover or target):Race() == "NightElf") then 
            local DetectInvisible = DetermineUsableObject(player, true, nil, nil, nil, A.DetectGreaterInvisibility, A.DetectInvisibility, A.DetectLesserInvisibility)
            if DetectInvisible then 
                return DetectInvisible:Show(icon)
            end 
        end 
    end 
    
    -- Pet: Imp
    if petName == "Imp" then 
        -- FireShield
        if not mouseover and IsUnitFriendly("mouseover") then 
            if FireShieldDesination[4] and CanCastFireShield("mouseover") then 
                return A.FireShield:Show(icon)
            end 
        elseif not target and IsUnitFriendly("target") then 
            if FireShieldDesination[4] and CanCastFireShield("target") then 
                return A.FireShield:Show(icon)
            end 
        elseif IsUnitFriendly("targettarget") then 
            if FireShieldDesination[4] and CanCastFireShield("targettarget") then 
                return A.FireShield:Show(icon)
            end 
        elseif FireShieldDesination[5] and (not Unit("mouseover"):IsExists() or Unit("mouseover"):IsEnemy()) and (not Unit("target"):IsExists() or Unit("target"):IsEnemy()) and (not Unit("targettarget"):IsExists() or Unit("targettarget"):IsEnemy()) and CanCastFireShield("player") then 
            return A.FireShield:Show(icon)
        end 
        
        -- PhaseShift
        if not A.PhaseShift:IsBlockedBySpellBook() and not A.PhaseShift:IsBlocked() then 
            if Unit(pet):HasBuffs(A.PhaseShift.ID) == 0 then 
                -- Apply
                if A.PhaseShift:IsReadyByPassCastGCD(pet, true) and petHP > 1 then 
                    local PhaseShiftTTD, PhaseShiftOperator, PhaseShiftHP = GetToggle(2, "PhaseShiftTTD"), GetToggle(2, "PhaseShiftOperator"), GetToggle(2, "PhaseShiftHP")
                    if (PhaseShiftTTD >= 0 or PhaseShiftHP >= 0) and Unit(pet):GetRealTimeDMG() > 0 then 
                        if PhaseShiftOperator == "AND" then 
                            if (PhaseShiftTTD < 0 or Unit(pet):TimeToDie() <= PhaseShiftTTD) and (PhaseShiftHP < 0 or petHP <= PhaseShiftHP) then 
                                return A.PhaseShift:Show(icon)
                            end 
                        else
                            if (PhaseShiftTTD >= 0 and Unit(pet):TimeToDie() <= PhaseShiftTTD) or (PhaseShiftHP >= 0 and petHP <= PhaseShiftHP) then 
                                return A.PhaseShift:Show(icon)
                            end 
                        end 
                    end 
                end 
            else 
                -- Remove 
                if petHP >= GetToggle(2, "PhaseShiftCancelAtHP") or Unit(pet):GetDMG() == 0 then 
                    return A.PhaseShift:Show(icon)
                end 
            end 
        end 
    end 
    
    -- Pet: Succubus / Felhunter / Doomguard
    if petName == "Succubus" or petName == "Felhunter" or petName == "Doomguard" then     
        -- CC PvP
        if A.IsInPvP then 
            if petName == "Succubus" and (mouseover or target) and (LoC:Get("STUN") > A.Seduction:GetSpellCastTimeCache() or LoC:Get("INCAPACITATE") > A.Seduction:GetSpellCastTimeCache()) and Unit(mouseover or target):IsHumanoid() and Pet:IsInRange((A.Seduction:Info()), mouseover or target) and A.Seduction:IsReady(mouseover or target, true) and A.Seduction:AbsentImun(mouseover or target, Temp.AuraForCC) and Unit(mouseover or target):IsControlAble("fear") and Unit(pet):InCC() == 0 then 
                return A.Seduction:Show(icon)
            end 
            
            if petName == "Doomguard" and ((LoC:Get("STUN") > 0 and LoC:Get("STUN") < 2) or (LoC:Get("INCAPACITATE") > 0 and LoC:Get("INCAPACITATE") < 2)) and A.Warstomp:IsReady(player) and Unit(pet):InCC() == 0 then 
                for nameplateUnitID in pairs(ActiveUnitPlates) do 
                    if UnitIsUnit(nameplateUnitID .. "target", player) and Temp.IsPetInMelee(nameplateUnitID) and A.Warstomp:AbsentImun(nameplateUnitID, Temp.AuraForWarStomp) and Unit(nameplateUnitID):IsControlAble("stun", 99) then 
                        return A.Warstomp:Show(icon)
                    end 
                end 
            end 
        end 
        
        -- Interrupts 
        if mouseover then
            if CanInterrupt(mouseover, petName) then 
                return (petName == "Succubus" and A.Seduction:Show(icon)) or (petName == "Felhunter" and A.SpellLock:Show(icon)) or (petName == "Doomguard" and A.Warstomp:Show(icon))
            end
        elseif target then
            if CanInterrupt(target, petName) then 
                return (petName == "Succubus" and A.Seduction:Show(icon)) or (petName == "Felhunter" and A.SpellLock:Show(icon)) or (petName == "Doomguard" and A.Warstomp:Show(icon))
            end
        end
        
        -- DevourMagic / DispelMagic
        if mouseover or IsUnitFriendly("mouseover") then 
            if CanDispel("mouseover", petName, Unit("mouseover"):InGroup()) then 
                return petName == "Felhunter" and A.DevourMagic:Show(icon) or A.DispelMagic:Show(icon)
            end 
        elseif target or IsUnitFriendly("target") then 
            if CanDispel("target", petName, Unit("target"):InGroup()) then 
                return petName == "Felhunter" and A.DevourMagic:Show(icon) or A.DispelMagic:Show(icon)
            end 
        elseif not Unit("target"):IsExists() and not Unit("mouseover"):IsExists() then 
            if CanDispel(player, petName, true) then 
                return petName == "Felhunter" and A.DevourMagic:Show(icon) or A.DispelMagic:Show(icon)
            end     
        end 
    end         
    
    -- EnslaveDemon
    if isSchoolShadowUP and inCombat and target and Player:IsStaying() and A.EnslaveDemon:IsReady(target) and not A.EnslaveDemon:IsSpellLastCastOrGCD() and not A.EnslaveDemon:IsSpellInFlight() and Unit(target):IsDemon() and select(6, Unit(target):InfoGUID()) == Temp.GetPetID.Doomguard and (not petIsActive or Unit(pet):HasDeBuffs(A.EnslaveDemon.ID, true) == 0) and Unit(target):GetLevel() <= Temp.GetEnslaveDemonLevelByRank[A.EnslaveDemon:GetSpellRank()] then 
        return A.EnslaveDemon:Show(icon)
    end 
    
    -- DemonicSacrifice
    if isSchoolShadowUP and petIsActive and A.DemonicSacrifice:IsReadyByPassCastGCD(player) then 
        if petName == "Imp" and DemonicSacrificePet[1] then 
            return A.DemonicSacrifice:Show(icon)
        end 
        
        if petName == "Voidwalker" and DemonicSacrificePet[2] then 
            return A.DemonicSacrifice:Show(icon)
        end 
        
        if petName == "Succubus" and DemonicSacrificePet[3] then 
            return A.DemonicSacrifice:Show(icon)
        end 
        
        if petName == "Felhunter" and DemonicSacrificePet[4] then 
            return A.DemonicSacrifice:Show(icon)
        end 
        
        if petName == "Doomguard" and DemonicSacrificePet[5] then 
            return A.DemonicSacrifice:Show(icon)
        end 
        
        if petName ~= "Imp" and petName ~= "Voidwalker" and petName ~= "Succubus" and petName ~= "Felhunter" and petName ~= "Doomguard" and DemonicSacrificePet[6] then 
            return A.DemonicSacrifice:Show(icon)
        end 
    end 
    
    -- Summon Pet 
    if isSchoolShadowUP and ((not mouseover and not target) or Player:IsStayingTime() > 0.7) and not Temp.IsCastIsSummon[castName or ""] and not Temp.IsCastIsSummon[A.LastPlayerCastName or ""] and petName ~= "Doomguard" and (not A.DemonicSacrifice:IsSpellLearned() or Unit(player):HasBuffs(Temp.BuffsDemonicSacrifice) == 0) and (not inCombat or (not Unit(player):IsFocused() and (A.FelDomination:IsReady(player) or (A.FelDomination:IsSpellLearned() and Unit(player):HasBuffs(A.FelDomination.ID, true) > 0) or A.MasterSummoner:GetTalentRank() >= 2))) and (not petIsActive or Unit(pet):HasDeBuffs(A.EnslaveDemon.ID, true) == 0) then 
        local SummonKeyName = GetToggle(2, A.IsInPvP and "SummonPvP" or "SummonPvE")
        if SummonKeyName == "AUTO" then 
            local SummonObject = Temp.GetAutoSummonPet(soulShards, petName)
            if SummonObject and not SummonObject:IsSpellLastGCD() and not SummonObject:IsSpellInFlight() then 
                if inCombat and A.FelDomination:IsReadyByPassCastGCD(player) then 
                    return A.FelDomination:Show(icon)
                end 
                return SummonObject:Show(icon)
            end 
        elseif SummonKeyName ~= "OFF" and A[SummonKeyName]:IsReady(player) and not A[SummonKeyName]:IsSpellLastGCD() and not A[SummonKeyName]:IsSpellInFlight() and not Pet:IsActive(Temp.IsCastIsSummon[A[SummonKeyName]:Info()]) and (soulShards > 0 or not Temp.IsRequiredSoulShard[A[SummonKeyName]:Info()]) then 
            if inCombat and A.FelDomination:IsReadyByPassCastGCD(player) then 
                return A.FelDomination:Show(icon)
            end 
            return A[SummonKeyName]:Show(icon)
        end 
    end 
    
    -- Create stones 
    if not inCombat and soulShards > 0 and Player:IsStaying() and (not castName or not Temp.CastToItem[castName]) then 
        -- CreateHealthstone
        if isSchoolShadowUP then 
            local HealthStoneObj = DetermineUsableObject(player, true, nil, nil, nil, A.CreateHealthstoneMajor, A.CreateHealthstoneGreater, A.CreateHealthstone, A.CreateHealthstoneLesser, A.CreateHealthstoneMinor)
            if HealthStoneObj and GetHealthstonesByCastName((HealthStoneObj:Info()), true) == 0 and not HealthStoneObj:IsSpellInFlight() then 
                return HealthStoneObj:Show(icon)
            end 
        end
        
        -- CreateSoulstone
        if isSchoolShadowUP and not GetSoulstoneInBag() then 
            local SoulStoneObj = DetermineUsableObject(player, true, nil, nil, nil, A.CreateSoulstoneMajor, A.CreateSoulstoneGreater, A.CreateSoulstone, A.CreateSoulstoneLesser, A.CreateSoulstoneMinor)
            if SoulStoneObj and Temp.CastToItem[SoulStoneObj:Info()]:GetCount() == 0 and not SoulStoneObj:IsSpellInFlight() then 
                return SoulStoneObj:Show(icon)
            end 
        end
        
        -- CreateFirestone
        if isSchoolFireUP and handStoneToUse == "Firestone" then 
            local FireStoneObj = DetermineUsableObject(player, true, nil, nil, nil, A.CreateFirestoneMajor, A.CreateFirestoneGreater, A.CreateFirestone, A.CreateFirestoneLesser)
            if FireStoneObj and Temp.CastToItem[FireStoneObj:Info()]:GetCount() == 0 and not FireStoneObj:IsSpellInFlight() then 
                return FireStoneObj:Show(icon)
            end 
        end 
        
        -- CreateSpellstone
        if isSchoolShadowUP and handStoneToUse == "Spellstone" then 
            local SpellStoneObj = DetermineUsableObject(player, true, nil, nil, nil, A.CreateSpellstoneMajor, A.CreateSpellstoneGreater, A.CreateSpellstone)
            if SpellStoneObj and Temp.CastToItem[SpellStoneObj:Info()]:GetCount() == 0 and not SpellStoneObj:IsSpellInFlight() then 
                return SpellStoneObj:Show(icon)
            end 
        end                 
    end 
    
    -- DeathCoil
    -- Note: Interrupt
    if target and isSchoolShadowUP and DeathCoilMode[2] and A.DeathCoil:IsReady(target) then         
        local castLeftSecs = Unit(target):IsCastingRemains()
        if castLeftSecs > 1 and castLeftSecs <= GetGCD() * 2.5 then 
            local useKick, useCC, useRacial = InterruptIsValid(target, "TargetMouseover")
            if (useKick or useCC or useRacial) and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) and Unit(target):IsControlAble("fear", 0) then 
                return A.DeathCoil:Show(icon)
            end 
        end 
    end 
    
    -- Banish
    if isSchoolShadowUP and (mouseover or target) and Player:IsStaying() and A.Banish:IsReady(mouseover or target) and GetActiveDoTsCounter(A.Banish:Info()) == 0 and not A.Banish:IsSpellLastGCD() and not A.Banish:IsSpellInFlight() and (not castName or castName ~= A.Banish:Info()) and not Unit(mouseover or target):IsPlayer() and (Unit(mouseover or target):IsElemental() or Unit(mouseover or target):IsDemon()) and Unit(mouseover or target):HasDeBuffs(A.Banish.ID) == 0 and Unit(mouseover or target):IsControlAble("incapacitate") then 
        -- PvE
        if A.IsInInstance and TeamCacheFriendly.Type and (Unit(mouseover or target):CombatTime() == 0 or (not Unit(mouseover or target):IsFocused() and Unit(mouseover or target):GetRealTimeDMG() == 0 and Unit(mouseover or target):CombatTime() > 3)) then 
            return A.Banish:Show(icon)
        end 
        
        -- PvP 
        if (A.IsInPvP or A.Zone == "none") and not Unit(mouseover or target):IsFocused() and Unit(mouseover or target):IsPet() then 
            return A.Banish:Show(icon)
        end 
    end  
    
    -- FearMode
    if isFearMode and isSchoolShadowUP then 
        if Player:IsStaying() then 
            -- HowlofTerror
            if A.HowlofTerror:IsReadyByPassCastGCD(player, true) then 
                local destinations = 0
                for namePlateUnitID in pairs(ActiveUnitPlates) do                 
                    if ((Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(namePlateUnitID) and Unit(pet):GetRange() <= 10)) and A.HowlofTerror:AbsentImun(namePlateUnitID, Temp.AuraForFear) and Unit(namePlateUnitID):IsControlAble("fear", 0) then 
                        destinations = destinations + 1
                    end 
                    
                    if destinations >= 2 then 
                        return A.HowlofTerror:Show(icon)
                    end 
                end                     
            end 
            
            -- Fear 
            if not castName or (castName ~= A.Fear:Info() and castName ~= A.HowlofTerror:Info()) then 
                if (mouseover or target) and CanFear(mouseover or target) then 
                    return A.Fear:Show(icon)
                elseif useAutoTarget and GetActiveDoTsCounter(A.Fear:Info()) == 0 then  
                    for namePlateUnitID in pairs(ActiveUnitPlates) do 
                        if not UnitIsUnit(namePlateUnitID, "target") and not UnitIsUnit(namePlateUnitID, "mouseover") and CanFear(namePlateUnitID) then 
                            return A:Show(icon, ACTION_CONST_AUTOTARGET)
                        end 
                    end 
                end 
            end
        end 
        
        -- DeathCoil
        if target and not targetIsTotem and DeathCoilMode[3] and A.DeathCoil:IsReady(target) and (not A.Fear:IsSpellLastCastOrGCD() or GetActiveDoTsCounter(A.Fear:Info()) ~= 0) and not A.HowlofTerror:IsSpellLastCastOrGCD() and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) and Unit(target):IsControlAble("fear", 0) and Unit(target):InCC() == 0 then 
            return A.DeathCoil:Show(icon)
        end 
    end 
    
    -- Fear 
    -- Note: Friendly players affected by Mind Control 
    if (mouseover or target) and isSchoolShadowUP and GetToggle(2, "FearOnMC") and Player:IsStaying() and Unit(mouseover or target):IsCharmed() and Unit(mouseover or target):IsPlayer() and Unit(mouseover or target):InGroup() and CanFear(mouseover or target) then
        -- StopCast
        if useStopCast and not isImportantCast and castLeftSecs > 1 and castName ~= A.Fear:Info() then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        -- Waiting
        if castName and (castName == A.Fear:Info() or castName == A.HowlofTerror:Info()) then 
            return 
        end 
        
        return A.Fear:Show(icon)
    end 
    
    -- [[ PRE PULL ]]
    if not inCombat and target then 
        local Pull = BossMods_Pulling()
        if Pull > 0 then 
            -- SoulFire
            if isSchoolFireUP and soulShards > 0 and (targetIsBossOrPlayer or not targetIsTotem) and Player:IsStaying() and A.SoulFire:IsReady(target) and Pull <= 6 - (A.Bane:GetTalentRank() * 0.4) + GetPing() and A.SoulFire:AbsentImun(target, Temp.AttackTypes) and not UnitHasFireImun(target) then 
                return A.SoulFire:Show(icon)
            end
            
            -- Immolate
            if isSchoolFireUP and (targetIsBossOrPlayer or not targetIsTotem) and not A.Conflagrate:IsBlockedByAny() and Player:IsStaying() and A.Immolate:IsReady(target) and not A.Immolate:IsSpellInFlight() and Pull <= 2 - (A.Bane:GetTalentRank() * 0.1) + GetPing() and (not castName or castName ~= A.Immolate:Info()) and not A.Immolate:IsSpellLastGCD() and A.Immolate:AbsentImun(target, Temp.AuraForCC) and not UnitHasFireImun(target) and Unit(target):HasDeBuffs(A.Immolate.ID, true) == 0 then 
                return A.Immolate:Show(icon)
            end 
            
            -- Corruption
            -- Note: Only if cast able 
            if isSchoolShadowUP and A.ImprovedCorruption:GetTalentRank() < 5 and A.Corruption:IsReady(target) and Player:IsStaying() and not A.Corruption:IsSpellLastCastOrGCD() and not A.Corruption:IsSpellInFlight() and Pull <= 2 - (A.ImprovedCorruption:GetTalentRank() * 0.4) + GetPing() and A.Corruption:AbsentImun(target, Temp.AttackTypes) and Unit(target):HasDeBuffs(A.Corruption.ID, true) == 0 then 
                return A.Corruption:Show(icon)
            end             
            
            -- ShadowBolt
            if isSchoolShadowUP and A.ImprovedCorruption:GetTalentRank() >= 5 and A.ShadowBolt:IsReady(target) and ((Player:IsStaying() and not A.ShadowBolt:IsSpellLastCastOrGCD() and not A.ShadowBolt:IsSpellInFlight()) or (A.Nightfall:IsSpellLearned() and Unit(player):HasBuffs(A.ShadowTrance.ID, true) > 0)) and Pull <= ((A.Nightfall:IsSpellLearned() and Unit(player):HasBuffs(A.ShadowTrance.ID, true) > 0 and 1.5) or A.ShadowBolt:GetSpellCastTime()) and A.ShadowBolt:AbsentImun(target, Temp.AttackTypes) then 
                return A.ShadowBolt:Show(icon)
            end 
            
            -- Waiting 
            if not A.ShadowBolt:IsBlockedByAny() and not A.Immolate:IsBlockedByAny() and not A.Conflagrate:IsBlockedByAny() and not A.Corruption:IsBlockedByAny() and not A.SoulFire:IsBlockedByAny() then 
                return 
            end 
        end 
    end 
    
    -- Shadowburn
    -- Note: Kill during next 5 sec 
    if target and isSchoolShadowUP and soulShards > 0 and targetTTD <= 5 and targetHealthPercent > 0 and targetHealthPercent < 25 and A.Shadowburn:IsReadyByPassCastGCD(target) and (not A.IsInPvP or not Unit(target):IsPet()) and not targetIsTotem and A.Shadowburn:AbsentImun(target, Temp.AttackTypes) then 
        -- StopCast
        if useStopCast and not isImportantCast and castLeftSecs > targetTTD + GetPing() + (TMW.UPD_INTV or 0) + 1 then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        return A.Shadowburn:Show(icon)
    end 
    
    -- DrainSoul1
    if target and isSchoolShadowUP and targetTTD <= GetToggle(2, "DrainSoulTTD") and (GetToggle(2, "DrainSoulShards") < 0 or soulShards <= GetToggle(2, "DrainSoulShards")) and targetHealthPercent > 0 and targetHealthPercent < 25 and Player:IsStaying() and A.DrainSoul1:IsReadyByPassCastGCD(target) and (not A.IsInPvP or not Unit(target):IsPet()) and not targetIsTotem and A.DrainSoul1:AbsentImun(target, Temp.AttackTypes) then 
        -- StopCast
        if useStopCast and not isImportantCast and castLeftSecs > targetTTD + GetPing() + (TMW.UPD_INTV or 0) + 1 then 
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        -- Waiting
        if castName and castName == A.DrainSoul1:Info() then 
            return 
        end 
        
        return A.DrainSoul1:Show(icon)
    end 
    
    -- ShadowBolt 
    -- Note: Proc 
    if target and isSchoolShadowUP and A.Nightfall:IsSpellLearned() and Unit(player):HasBuffs(A.ShadowTrance.ID, true) > 0 and A.ShadowBolt:IsReady(target) and A.ShadowBolt:AbsentImun(target, Temp.AttackTypes) then 
        return A.ShadowBolt:Show(icon)
    end 
    
    -- Conflagrate
    -- Note: Consume debuff if it will expire in less than next few GCDs or it's a boss/player either if will die in less than expires
    if target and isSchoolFireUP and A.Conflagrate:IsReady(target) and Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0 and (targetIsBossOrPlayer or targetTTD <= GetGCD() * 2 + A.ShadowBolt:GetSpellCastTimeCache() or targetTTD <= Unit(target):HasDeBuffs(A.Immolate.ID, true) or Unit(target):HasDeBuffs(A.Immolate.ID, true) <= GetGCD() * 2 + GetCurrentGCD() + GetPing()) and A.Conflagrate:AbsentImun(target, Temp.AttackTypes) then 
        return A.Conflagrate:Show(icon)
    end 
    
    -- SearingPain
    if target and isSchoolFireUP and targetTTD <= 3 and targetTTD <= A.ShadowBolt:GetSpellCastTime() and Player:IsStaying() and A.SearingPain:IsReady(target) and A.SearingPain:AbsentImun(target, Temp.AttackTypes) and not UnitHasFireImun(target) then 
        return A.SearingPain:Show(icon)
    end 
    
    -- Pet: Voidwalker 
    -- ConsumeShadows
    if not inCombat and petName == "Voidwalker" and A.ConsumeShadows:IsReady(pet, true) and petHP > 1 and petHP <= GetToggle(2, "ConsumeShadowsHP") and Unit(pet):HasBuffs(A.ConsumeShadows.ID) == 0 then 
        return A.ConsumeShadows:Show(icon)
    end 
    
    -- HealthFunnel
    if isSchoolShadowUP and Player:IsStaying() and petIsActive and A.HealthFunnel:IsReady(pet) and petHP <= GetToggle(2, "HealthFunnelHP") and Unit(pet):TimeToDie() > GetGCD() * 2 and not Unit(player):IsFocused() then 
        return A.HealthFunnel:Show(icon)
    end 
    
    -- DemonArmor / DemonSkin
    if isSchoolShadowUP and Unit(player):HasBuffs(Temp.BuffsArmorSkin, true) <= GetGCD() then 
        local ArmorSkin = DetermineUsableObject(player, true, nil, nil, nil, A.DemonArmor, A.DemonSkin)
        if ArmorSkin and ArmorSkin:GetSpellTimeSinceLastCast() > 5 then 
            return ArmorSkin:Show(icon)
        end 
    end 
    
    -- [[ MAIN CURSE ]]
    if isSchoolShadowUP and target then 
        local curseGUID, curseName = GetActiveCurse()
        
        if not curseName or curseGUID == UnitGUID(target) then 
            if targetIsBossOrPlayer then 
                if curseBossOrPlayer ~= "OFF" then 
                    if curseBossOrPlayer == "AUTO" then 
                        if A.IsInPvP or combatTime > 5 then 
                            -- CurseofShadow
                            -- Note: PvE If solo Warlock or Shadow Damagers > than rest buff benefit members
                            if (not curseName or curseName == A.CurseofShadow:Info()) and not A.IsInPvP and (TeamCacheFriendly.countWarlock <= 1 or TeamCacheFriendly.countWarlock + TeamCacheFriendly.countSPriest > TeamCacheFriendly.countMelee + TeamCacheFriendly.countMage) and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseofShadow) then 
                                return A.CurseofShadow:Show(icon) 
                            end 
                            
                            -- CurseoftheElements
                            -- Note: PvE If Mages > than rest buff benefit members
                            if (not curseName or curseName == A.CurseoftheElements:Info()) and not A.IsInPvP and TeamCacheFriendly.countMage > TeamCacheFriendly.countMelee + TeamCacheFriendly.countWarlock + TeamCacheFriendly.countSPriest and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseoftheElements) then 
                                return A.CurseoftheElements:Show(icon) 
                            end 
                            
                            -- CurseofRecklessness
                            -- Note: PvE If melee units > than rest buff benefit members (and also good tank.. we don't know it)
                            if (not curseName or curseName == A.CurseofRecklessness:Info()) and not A.IsInPvP and TeamCacheFriendly.countMelee > TeamCacheFriendly.countMage + TeamCacheFriendly.countWarlock + TeamCacheFriendly.countSPriest and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseofRecklessness) then 
                                return A.CurseofRecklessness:Show(icon) 
                            end 
                            
                            -- CurseofDoom
                            -- Note: PvE Boss only 
                            if not curseName and not A.IsInPvP and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseofDoom) then 
                                return A.CurseofDoom:Show(icon) 
                            end 
                            
                            -- CurseofTongues
                            -- Note: PvP Player only if healer 
                            if (not curseName or curseName == A.CurseofTongues:Info()) and A.IsInPvP and targetIsPlayer and Unit(target):IsHealer() and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseofTongues) then 
                                return A.CurseofTongues:Show(icon) 
                            end 
                            
                            -- CurseofExhaustion
                            -- Note: PvP Player only if not slowed
                            if (not curseName or curseName == A.CurseofExhaustion:Info()) and A.IsInPvP and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseofExhaustion) then 
                                if A.AmplifyCurse:IsReady(player) and Unit(player):HasBuffs(A.AmplifyCurse.ID, true) == 0 then 
                                    return A.AmplifyCurse:Show(icon)
                                end 
                                return A.CurseofExhaustion:Show(icon) 
                            end 
                            
                            -- CurseofAgony                    
                            if (not curseName or curseName == A.CurseofAgony:Info()) and CanUseCurse(target, targetTTD, targetIsPlayer, A.CurseofAgony) then 
                                if A.AmplifyCurse:IsReady(player) and Unit(player):HasBuffs(A.AmplifyCurse.ID, true) == 0 then 
                                    return A.AmplifyCurse:Show(icon)
                                end 
                                return A.CurseofAgony:Show(icon) 
                            end         
                            
                            -- Any first available curse from remain free debuff
                            if not curseName then 
                                local CurseObj = DetermineUsableCurse(target, targetTTD, targetIsPlayer, curseName, A.CurseofWeakness, A.CurseofShadow, A.CurseoftheElements, A.CurseofRecklessness, A.CurseofTongues, A.CurseofExhaustion, A.CurseofDoom)
                                if CurseObj then 
                                    if (CurseObj == A.CurseofAgony or CurseObj == A.CurseofWeakness or CurseObj == A.CurseofExhaustion) and A.AmplifyCurse:IsReady(player) and Unit(player):HasBuffs(A.AmplifyCurse.ID, true) == 0 then 
                                        return A.AmplifyCurse:Show(icon)
                                    end 
                                    return CurseObj:Show(icon)
                                end 
                            end 
                        end 
                    elseif CanUseCurse(target, targetTTD, targetIsPlayer, A[curseBossOrPlayer], true) then -- Note: IsReadyP here
                        if (curseBossOrPlayer == "CurseofAgony" or curseBossOrPlayer == "CurseofWeakness" or curseBossOrPlayer == "CurseofExhaustion") and A.AmplifyCurse:IsReady(player) and Unit(player):HasBuffs(A.AmplifyCurse.ID, true) == 0 then 
                            return A.AmplifyCurse:Show(icon)
                        end 
                        return A[curseBossOrPlayer]:Show(icon)
                    end 
                end 
            elseif A.Zone ~= "pvp" and not A.IsInDuel and ((A.IsInPvP and not EnemyTeam():PlayersInRange(1, 40)) or (not A.IsInPvP and not Temp.IsBossFight())) and (not targetIsTotem or Unit(target):IsDummy()) then 
                if curseOthers ~= "OFF" then 
                    if curseOthers == "AUTO" then 
                        -- Note: No combat time waiting
                        -- Any first available curse 
                        local CurseObj = DetermineUsableCurse(target, targetTTD, targetIsPlayer, curseName, A.CurseofAgony, A.CurseofShadow, A.CurseoftheElements, A.CurseofRecklessness, A.CurseofWeakness, A.CurseofDoom, A.CurseofExhaustion, A.CurseofTongues)
                        if CurseObj then 
                            if A.Zone == "none" and (CurseObj == A.CurseofAgony or CurseObj == A.CurseofWeakness or CurseObj == A.CurseofExhaustion) and A.AmplifyCurse:IsReady(player) and Unit(player):HasBuffs(A.AmplifyCurse.ID, true) == 0 then 
                                return A.AmplifyCurse:Show(icon)
                            end 
                            return CurseObj:Show(icon)
                        end 
                    elseif CanUseCurse(target, targetTTD, targetIsPlayer, A[curseOthers], true) then -- Note: IsReadyP here
                        if A.Zone == "none" and (curseOthers == "CurseofAgony" or curseOthers == "CurseofWeakness" or curseOthers == "CurseofExhaustion") and A.AmplifyCurse:IsReady(player) and Unit(player):HasBuffs(A.AmplifyCurse.ID, true) == 0 then 
                            return A.AmplifyCurse:Show(icon)
                        end 
                        return A[curseOthers]:Show(icon)
                    end 
                end 
            end 
        end 
    end 
    
    -- [[ AOE ROTATION ]]
    if useAoE and isSchoolFireUP and Player:IsStaying() then 
        -- Hellfire
        if A.Hellfire:IsReady(player) and not Unit(player):IsFocused() and not Unit(player):IsExecuted() and (not A.IsInPvP or not EnemyTeam():IsBreakAble(10)) then 
            local nameplateRange
            local nameplateCount = 0
            for nameplateUnitID in pairs(ActiveUnitPlates) do 
                nameplateRange = Unit(nameplateUnitID):GetRange()
                if ((nameplateRange > 0 and nameplateRange <= 10) or (Temp.IsPetInMelee(nameplateUnitID) and Unit(pet):GetRange() <= 10)) and A.Hellfire:AbsentImun(nameplateUnitID, Temp.AttackTypes) then 
                    nameplateCount = nameplateCount + 1
                    if nameplateCount >= 3 then 
                        return A.Hellfire:Show(icon)
                    end 
                end 
            end 
        end 
        
        -- RainofFire
        if (mouseover or target) and enemies >= 3 and A.RainofFire:IsReady(mouseover or target) and A.RainofFire:AbsentImun(mouseover or target, Temp.AttackTypes) and (not A.IsInPvP or not EnemyTeam():IsBreakAble(40)) then 
            return A.RainofFire:Show(icon)
        end 
    end 
    
    -- [[ FIRE ROTATION (INTERRUPTED) ]]
    if not isSchoolShadowUP and isSchoolFireUP and target and not UnitHasFireImun(target) then 
        -- Immolate
        if not targetDeBuffsLimited and (targetIsBossOrPlayer or not targetIsTotem) and Player:IsStaying() and A.Immolate:IsReady(target) and (not castName or castName ~= A.Immolate:Info()) and not A.Immolate:IsSpellLastGCD() and not A.Immolate:IsSpellInFlight() and A.Immolate:AbsentImun(target, Temp.AuraForCC) and Unit(target):HasDeBuffs(A.Immolate.ID, true) == 0 then 
            return A.Immolate:Show(icon)
        end 
        
        -- SearingPain
        if Player:IsStaying() and A.SearingPain:IsReady(target) and A.SearingPain:AbsentImun(target, Temp.AttackTypes) and (A.IsInPvP or A.Zone == "none" or select(2, Unit(player):ThreatSituation()) <= 95) then 
            return A.SearingPain:Show(icon)
        end 
    end 
    
    -- [[ DOTS ROTATION ]]
    -- AutoTarget
    if target and useAoE and CanTargetNearest(inCombat, enemies, useAutoTarget) and not targetIsBoss then 
        if enemies <= 3 then 
            if A.IsInPvP then 
                if (PvPDoTsBossOrPlayer[1] or PvPDoTsBossOrPlayer[2] or PvPDoTsBossOrPlayer[3]) and (not PvPDoTsBossOrPlayer[1] or Unit(target):HasDeBuffs(A.Corruption.ID, true) > 0) and (not PvPDoTsBossOrPlayer[2] or Unit(target):HasDeBuffs(A.SiphonLife.ID, true) > 0) and (not PvPDoTsBossOrPlayer[3] or Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0) then 
                    if (PvPDoTsBossOrPlayer[1] and not A.Corruption:IsBlockedByAny() and GetActiveDoTsCounter(A.Corruption:Info()) < 2) or (PvPDoTsBossOrPlayer[2] and not A.SiphonLife:IsBlockedByAny() and GetActiveDoTsCounter(A.SiphonLife:Info()) < 2) or (PvPDoTsBossOrPlayer[3] and not A.Immolate:IsBlockedByAny() and GetActiveDoTsCounter(A.Immolate:Info()) < 2) then 
                        -- Conflagrate
                        if isSchoolFireUP and A.Conflagrate:IsReady(target) and Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0 and A.Conflagrate:AbsentImun(target, Temp.AttackTypes) then 
                            return A.Conflagrate:Show(icon)
                        end 
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end 
                end
            else 
                if (DoTsOthers[1] or DoTsOthers[2] or DoTsOthers[3]) and (not DoTsOthers[1] or Unit(target):HasDeBuffs(A.Corruption.ID, true) > 0) and (not DoTsOthers[2] or Unit(target):HasDeBuffs(A.SiphonLife.ID, true) > 0) and (not DoTsOthers[3] or Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0) then 
                    if (DoTsOthers[1] and not A.Corruption:IsBlockedByAny() and GetActiveDoTsCounter(A.Corruption:Info()) < 3) or (DoTsOthers[2] and not A.SiphonLife:IsBlockedByAny() and GetActiveDoTsCounter(A.SiphonLife:Info()) < 3) or (DoTsOthers[3] and not A.Immolate:IsBlockedByAny() and GetActiveDoTsCounter(A.Immolate:Info()) < 3) then 
                        -- Conflagrate
                        if isSchoolFireUP and A.Conflagrate:IsReady(target) and Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0 and A.Conflagrate:AbsentImun(target, Temp.AttackTypes) then 
                            return A.Conflagrate:Show(icon)
                        end 
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end 
                end
            end 
        elseif enemies <= 4 and Player:IsMovingTime() > 0.4 then 
            if A.IsInPvP then 
                if (PvPDoTsBossOrPlayer[1] or PvPDoTsBossOrPlayer[2] or PvPDoTsBossOrPlayer[3]) and (not PvPDoTsBossOrPlayer[1] or Unit(target):HasDeBuffs(A.Corruption.ID, true) > 0) and (not PvPDoTsBossOrPlayer[2] or Unit(target):HasDeBuffs(A.SiphonLife.ID, true) > 0) and (not PvPDoTsBossOrPlayer[3] or Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0) then 
                    if (PvPDoTsBossOrPlayer[1] and not A.Corruption:IsBlockedByAny() and GetActiveDoTsCounter(A.Corruption:Info()) < 4) or (PvPDoTsBossOrPlayer[2] and not A.SiphonLife:IsBlockedByAny() and GetActiveDoTsCounter(A.SiphonLife:Info()) < 4) or (PvPDoTsBossOrPlayer[3] and not A.Immolate:IsBlockedByAny() and GetActiveDoTsCounter(A.Immolate:Info()) < 4) then 
                        -- Conflagrate
                        --if isSchoolFireUP and A.Conflagrate:IsReady(target) and Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0 and A.Conflagrate:AbsentImun(target, Temp.AttackTypes) then 
                        --return A.Conflagrate:Show(icon)
                        --end 
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end 
                end
            else 
                if (DoTsOthers[1] or DoTsOthers[2] or DoTsOthers[3]) and (not DoTsOthers[1] or Unit(target):HasDeBuffs(A.Corruption.ID, true) > 0) and (not DoTsOthers[2] or Unit(target):HasDeBuffs(A.SiphonLife.ID, true) > 0) and (not DoTsOthers[3] or Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0) then 
                    if (DoTsOthers[1] and not A.Corruption:IsBlockedByAny() and GetActiveDoTsCounter(A.Corruption:Info()) < 4) or (DoTsOthers[2] and not A.SiphonLife:IsBlockedByAny() and GetActiveDoTsCounter(A.SiphonLife:Info()) < 4) or (DoTsOthers[3] and not A.Immolate:IsBlockedByAny() and GetActiveDoTsCounter(A.Immolate:Info()) < 4) then 
                        -- Conflagrate
                        --if isSchoolFireUP and A.Conflagrate:IsReady(target) and Unit(target):HasDeBuffs(A.Immolate.ID, true) > 0 and A.Conflagrate:AbsentImun(target, Temp.AttackTypes) then 
                        --return A.Conflagrate:Show(icon)
                        --end 
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end 
                end
            end 
        end 
    end 
    
    -- Corruption
    -- Note: Doesn't check debuffs limit since user specified to force use it in toggle
    if target and targetTTD >= 5 and isSchoolShadowUP and ( (targetIsBossOrPlayer and ((A.IsInPvP and PvPDoTsBossOrPlayer[1]) or (not A.IsInPvP and PvEDoTsBossOrPlayer[1]))) or (not targetIsBossOrPlayer and not targetIsTotem and DoTsOthers[1]) ) and A.Corruption:IsReady(target) and (A.ImprovedCorruption:GetTalentRank() >= 5 or (Player:IsStaying() and targetTTD >= 8 and (not castName or castName ~= A.Corruption:Info()) and not A.Corruption:IsSpellInFlight())) and A.Corruption:AbsentImun(target, Temp.AttackTypes) and Unit(target):HasDeBuffs(A.Corruption.ID, true) <= A.ShadowBolt:GetSpellCastTime() then 
        return A.Corruption:Show(icon)
    end 
    
    -- SiphonLife
    -- Note: Doesn't check debuffs limit since user specified to force use it in toggle
    if target and targetTTD >= 8 and isSchoolShadowUP and ( (targetIsBossOrPlayer and ((A.IsInPvP and PvPDoTsBossOrPlayer[2]) or (not A.IsInPvP and PvEDoTsBossOrPlayer[2]))) or (not targetIsBossOrPlayer and not targetIsTotem and DoTsOthers[2]) ) and A.SiphonLife:IsReady(target) and (not castName or castName ~= A.SiphonLife:Info()) and not A.SiphonLife:IsSpellInFlight() and A.SiphonLife:AbsentImun(target, Temp.AttackTypes) and Unit(target):HasDeBuffs(A.SiphonLife.ID, true) <= A.ShadowBolt:GetSpellCastTime() then 
        return A.SiphonLife:Show(icon)
    end 
    
    -- Immolate
    -- Note: Doesn't check debuffs limit since user specified to force use it in toggle
    if target and targetTTD >= 8 and isSchoolFireUP and ( (targetIsBossOrPlayer and ((A.IsInPvP and PvPDoTsBossOrPlayer[3]) or (not A.IsInPvP and PvEDoTsBossOrPlayer[3]))) or (not targetIsBossOrPlayer and not targetIsTotem and DoTsOthers[3]) ) and A.Immolate:IsReady(target) and (not castName or castName ~= A.Immolate:Info()) and not A.Immolate:IsSpellInFlight() and Player:IsStaying() and A.Immolate:AbsentImun(target, Temp.AttackTypes) and Unit(target):HasDeBuffs(A.Immolate.ID, true) <= A.ShadowBolt:GetSpellCastTime() then 
        return A.Immolate:Show(icon)
    end     
    
    -- [[ ADDITIONAL DEFENSE ]]
    -- DrainLife
    if inCombat and target and isSchoolShadowUP and Player:IsStaying() and A.DrainLife:IsReady(target) and Unit(player):HealthPercent() <= GetToggle(2, "DrainLifeHP") and A.DrainLife:AbsentImun(target, Temp.AttackTypes) then 
        return A.DrainLife:Show(icon)
    end     
    
    -- [[ MANA ROTATION ]]
    -- Mana Potion 
    if potionToUse == "MajorManaPotion" and inCombat and A.MajorManaPotion:IsReady(player) and Unit(player):PowerPercent() <= GetToggle(2, "ManaPotion") then 
        return A.MajorManaPotion:Show(icon)
    end         
    
    -- Mana Rune
    if inCombat and Action.CanUseManaRune(icon) then 
        return true 
    end 
    
    -- DarkPact
    if isSchoolShadowUP and petIsActive and A.DarkPact:IsReady(pet) and Unit(pet):Power() >= Temp.GetDarkPactManaConsumeByRank[A.DarkPact:GetTalentRank() or 1] and Unit(player):PowerPercent() <= GetToggle(2, "DarkPactPlayerPWR") and Unit(pet):PowerPercent() >= GetToggle(2, "DarkPactPetPWR") then 
        return A.DarkPact:Show(icon)
    end         
    
    -- LifeTap
    if isSchoolShadowUP and A.LifeTap:IsReady(player) and Unit(player):PowerPercent() <= GetToggle(2, "LifeTapPWR") and Unit(player):HealthPercent() >= GetToggle(2, "LifeTapHP") then 
        return A.LifeTap:Show(icon)
    end     
    
    -- DrainMana
    if target and not targetIsTotem and isSchoolShadowUP and Player:IsStaying() and A.DrainMana:IsReady(target) and Unit(target):PowerType() == "MANA" and Unit(player):PowerPercent() <= GetToggle(2, "DrainManaPWR") then 
        return A.DrainMana:Show(icon)
    end 
    
    -- [[ BURST ROTATION ]]
    if target and targetInRange30 and BurstIsON(target)    and A.AbsentImun(nil, target, Temp.AttackTypes) then 
        -- Inferno
        if targetTTD > 8 and isSchoolShadowUP and IsOutdoors() and A.InfernalStone:GetCount() > 0 then 
            if A.Inferno:IsReady(target) then 
                if Player:IsStaying() then 
                    return A.Inferno:Show(icon)
                end 
            elseif not A.Inferno:IsBlockedByAny() and Unit(player):PowerPercent() < 100 and Unit(player):PowerPercent() > 70 then 
                -- Mana Potion 
                if potionToUse == "MajorManaPotion" and A.MajorManaPotion:IsReady(player) then 
                    return A.MajorManaPotion:Show(icon)
                end     
                
                -- Mana Rune 
                if Unit(player):Health() > 1100 then 
                    local Rune = DetermineUsableObject(player, true, nil, true, nil, A.DarkRune, A.DemonicRune)
                    if Rune then 
                        return Rune:Show(icon)
                    end 
                end 
                
                -- DarkPact
                if isSchoolShadowUP and petIsActive and A.DarkPact:IsReady(pet) and Temp.GetDarkPactManaConsumeByRank[A.DarkPact:GetTalentRank() or 1] >= Temp.GetLifeTapManaGainByRank[A.LifeTap:GetSpellRank()] * (1 + (A.ImprovedLifeTap:GetTalentRank() * 0.1)) and Unit(pet):Power() >= Temp.GetDarkPactManaConsumeByRank[A.DarkPact:GetTalentRank() or 1] then 
                    return A.DarkPact:Show(icon)
                end 
                
                -- LifeTap
                if isSchoolShadowUP and A.LifeTap:IsReady(player) and Unit(player):HealthPercent() >= GetToggle(2, "LifeTapHP") then 
                    return A.LifeTap:Show(icon)
                end     
                
                -- DrainMana
                if not targetIsTotem and isSchoolShadowUP and Player:IsStaying() and A.DrainMana:IsReady(target) and Unit(target):PowerType() == "MANA" then 
                    return A.DrainMana:Show(icon)
                end 
            end 
        end 
        
        -- SoulFire
        if (not isSchoolShadowUP or targetTTD > 8) and isSchoolFireUP and Player:IsStaying() and A.SoulFire:IsReady(target) and not UnitHasFireImun(target) then 
            return A.SoulFire:Show(icon)
        end 
        
        -- BloodFury
        if targetTTD > 5 and (isSchoolFireUP or isSchoolShadowUP) and Player:IsAttacking() and (Player:GetSwing(1) > 0 or Unit(target):GetRange() <= 5) and A.BloodFury:AutoRacial(target) then 
            return A.BloodFury:Show(icon)
        end                
        
        -- Trinkets  
        if (isSchoolFireUP or isSchoolShadowUP) and A.Trinket1:IsReady(target) and A.Trinket1:IsItemDamager() then 
            return A.Trinket1:Show(icon)
        end 
        
        if (isSchoolFireUP or isSchoolShadowUP) and A.Trinket2:IsReady(target) and A.Trinket2:IsItemDamager() then 
            return A.Trinket2:Show(icon)
        end     
        
        -- DeathCoil
        if target and isSchoolShadowUP and DeathCoilMode[4] and A.DeathCoil:IsReady(target) then         
            return A.DeathCoil:Show(icon)
        end             
    end 
    
    -- Shadowburn
    -- Note: Shadowburn should be used when there are 2 or more % damage increasing debuffs (ie:  Spell Vulnerability,  Shadow Weaving,  Shadow Vulnerability,  Curse of Shadow, or  Power Infusion buff). The more, the better
    if target and targetIsBossOrPlayer and isSchoolShadowUP and soulShards > 0 and A.Shadowburn:IsReady(target) and A.Shadowburn:AbsentImun(target, Temp.AttackTypes) then         
        if Unit(player):HasBuffs(A.PowerInfusion.ID) > 0 then 
            return A.Shadowburn:Show(icon)
        end 
        
        local debuffName
        local ShadowburnMods = 0
        for i = 1, huge do 
            debuffName = UnitDebuff(target, i)
            if not debuffName then 
                break 
            else
                if Temp.IsDebuffIsIncreaseDamage[debuffName] then 
                    ShadowburnMods = ShadowburnMods + 1
                    if ShadowburnMods >= 2 then 
                        return A.Shadowburn:Show(icon)
                    end 
                end 
            end 
        end 
    end 
    
    -- DrainMana
    if target and targetTTD >= 12 and isSchoolShadowUP and Player:IsStaying() and A.DrainMana:IsReady(target) and Unit(target):PowerType() == "MANA" and Unit(target):PowerPercent() > 5 then 
        if targetIsPlayer and A.DrainMana:AbsentImun(target, Temp.AttackTypes) then 
            return A.DrainMana:Show(icon)
        elseif targetIsBoss and A.DrainMana:AbsentImun(target, Temp.AttackTypes) then 
            local npcID = select(6, Unit(target):InfoGUID())
            -- 13020 Vaelastrasz the Corrupt
            -- 15340 Moam
            if npcID == 13020 or npcID == 15340 then 
                return A.DrainMana:Show(icon)
            end 
        end 
    end  
    
    -- ShadowBolt
    -- Note: Timing TTD
    if target and isSchoolShadowUP and (Player:IsStaying() or (A.Nightfall:IsSpellLearned() and Unit(player):HasBuffs(A.ShadowTrance.ID, true) > 0)) and targetTTD > A.ShadowBolt:GetSpellCastTimeCache() and A.ShadowBolt:IsReady(target) and A.ShadowBolt:AbsentImun(target, Temp.AttackTypes) then 
        return A.ShadowBolt:Show(icon)
    end 
    
    -- DrainSoul
    if target and isSchoolShadowUP and Player:IsStaying() and targetTTD <= A.ShadowBolt:GetSpellCastTimeCache() and A.DrainSoul:IsReady(target) and A.DrainSoul:AbsentImun(target, Temp.AttackTypes) then 
        return A.DrainSoul:Show(icon)
    end 
    
    -- ShadowBolt
    -- Note: Filler
    if target and isSchoolShadowUP and (Player:IsStaying() or (A.Nightfall:IsSpellLearned() and Unit(player):HasBuffs(A.ShadowTrance.ID, true) > 0)) and A.ShadowBolt:IsReady(target) and A.ShadowBolt:AbsentImun(target, Temp.AttackTypes) then 
        return A.ShadowBolt:Show(icon)
    end 
    
    -- [[ MISC ]]    
    -- SwiftnessPotion
    if target and potionToUse == "SwiftnessPotion" and inCombat and not targetInRange30 and Action.CanUseSwiftnessPotion(icon, target) then 
        return true
    end 
    
    -- AutoTarget 
    -- Note: In combat - nearest if out of range or imun
    if ((not mouseover and not target) or (target and ((not targetInRange30 and Unit(target):GetRange() >= 40) or not A.AbsentImun(nil, target, Temp.AttackTypes)))) and CanTargetNearest(inCombat, enemies, useAutoTarget) then 
        return A:Show(icon, ACTION_CONST_AUTOTARGET)
    end
    
    -- [[ NOTHING TO DO ]]    
    -- SoulLink
    if isSchoolShadowUP and petIsActive and A.SoulLink:IsReady(player) and Unit(player):HasBuffs(A.SoulLink.ID, true) == 0 then 
        return A.SoulLink:Show(icon)
    end 
    
    -- UnendingBreath
    if isSchoolShadowUP and Player:IsSwimming() and (not inCombat or not Unit(player):IsFocused()) and A.UnendingBreath:IsReady(player) and Unit(player):HasBuffs(A.UnendingBreath.ID, true) == 0 then 
        return A.UnendingBreath:Show(icon)
    end 
    
    -- SenseDemons
    if isSchoolShadowUP and not inCombat and A.SenseDemons:IsReady(player) and A.SenseDemons:GetSpellIcon() ~= GetTrackingTexture() then  
        return A.SenseDemons:Show(icon) 
    end 
    
    -- LifeTap
    -- Note: Toggle at full HP
    if isSchoolShadowUP and GetToggle(2, "LifeTapAtFullHP") and A.LifeTap:IsReady(player) and Unit(player):HealthPercent() >= 98 and Unit(player):PowerDeficit() >= Temp.GetLifeTapManaGainByRank[A.LifeTap:GetSpellRank()] * (1 + (A.ImprovedLifeTap:GetTalentRank() * 0.1)) then 
        return A.LifeTap:Show(icon)
    end        
end 

-- Passive Rotation 
local function RotationPassiveFriendly(icon, unitID)
    -- [[ All below disable able only through UI ]]    
    if Unit(unitID):IsExists() and not UnitIsUnit("target", unitID) and not UnitIsUnit("mouseover", unitID) and not Unit(unitID):InLOS() then          
        local index                 = icon.ID - 5
        if FireShieldDesination[index] then 
            local petIsActive, petName    = Temp.GetActivePet()
            if petIsActive and petName == "Imp" and CanCastFireShield(unitID) then 
                return A.FireShield:Show(icon)
            end 
        end 
    end 
end 

A[6] = function(icon)
    if TeamCacheFriendly.Type and RotationPassiveFriendly(icon, TeamCacheFriendly.Type .. "1") then 
        return true 
    end 
end 

A[7] = function(icon)
    if TeamCacheFriendly.Type and RotationPassiveFriendly(icon, TeamCacheFriendly.Type .. "2") then 
        return true 
    end
end 

A[8] = function(icon)
    if TeamCacheFriendly.Type and RotationPassiveFriendly(icon, TeamCacheFriendly.Type .. "3") then 
        return true 
    end
end 

-- Nil (nothing for profile here, just wipe to nil)
A[4] = nil 
A[5] = nil 

