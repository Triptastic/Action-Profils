# -*- coding: utf-8 -*-
"""
Context of an APL.

@author: skasch
"""

from ..abstract.decoratormanager import Decorable
from ..constants import PET
from ..database import ITEM_INFO


class Context(Decorable):
    """
    Defines the context of an APL, used to print everything outside the Apl
    main function.
    """

    HEADER = (
                '-------------------------------\n'
        '-- Taste TMW Action Rotation --\n'
        '-------------------------------\n'
        'local TMW                                       = TMW\n'
        'local CNDT                                      = TMW.CNDT\n'
        'local Env                                       = CNDT.Env\n'
        'local Action                                    = Action\n'
        'local Listener                                  = Action.Listener\n'
        'local Create                                    = Create\n'
        'local GetToggle                                 = Action.GetToggle\n'
        'local SetToggle                                 = Action.SetToggle\n'
        'local GetGCD                                    = Action.GetGCD\n'
        'local GetCurrentGCD                             = Action.GetCurrentGCD\n'
        'local GetPing                                   = Action.GetPing\n'
        'local ShouldStop                                = Action.ShouldStop\n'
        'local BurstIsON                                 = Action.BurstIsON\n'
        'local AuraIsValid                               = Action.AuraIsValid\n'
        'local InterruptIsValid                          = Action.InterruptIsValid\n'
        'local FrameHasSpell                             = Action.FrameHasSpell\n'
        'local Azerite                                   = LibStub("AzeriteTraits")\n'
        'local Utils                                     = Action.Utils\n'
        'local TeamCache                                 = Action.TeamCache\n'
        'local EnemyTeam                                 = Action.EnemyTeam\n'
        'local FriendlyTeam                              = Action.FriendlyTeam\n'
        'local LoC                                       = Action.LossOfControl\n'
        'local Player                                    = Action.Player\n'
        'local MultiUnits                                = Action.MultiUnits\n'
        'local UnitCooldown                              = Action.UnitCooldown\n'
        'local Unit                                      = Action.Unit\n' 
        'local IsUnitEnemy                               = Action.IsUnitEnemy\n'
        'local IsUnitFriendly                            = Action.IsUnitFriendly\n'
        'local HealingEngine                             = Action.HealingEngine\n'
        'local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()\n'
        'local TeamCacheFriendly                         = TeamCache.Friendly\n'
        'local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs\n'
        'local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit\n'
        'local TR                                        = Action.TasteRotation\n'
        'local Pet                                       = LibStub("PetLibrary")\n'
        'local next, pairs, type, print                  = next, pairs, type, print\n'
        'local math_floor                                = math.floor\n'
        'local math_ceil                                 = math.ceil\n'
        'local tinsert                                   = table.insert\n' 
        'local select, unpack, table                     = select, unpack, table\n' 
        'local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo\n'
        'local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower\n'
        'local _G, setmetatable, select, math            = _G, setmetatable, select, math\n' 
        'local huge                                      = math.huge\n'  
        'local UIParent                                  = _G.UIParent\n' 
        'local CreateFrame                               = _G.CreateFrame\n'
        'local wipe                                      = _G.wipe\n'
        'local IsUsableSpell                             = IsUsableSpell\n'
        'local UnitPowerType                             = UnitPowerType\n')

    CONTENT_HEADER = (
        '--- ============================ CONTENT =========================== ---\n'
        '--- ======================= SPELLS DECLARATION ===================== ---\n')

    NUM_FUNCTION = (
        'local function num(val)\n'
        '    if val then return 1 else return 0 end\n'
        'end\n')

    BOOL_FUNCTION = (
        'local function bool(val)\n'
        '    return val ~= 0\n'
        'end\n')

    def __init__(self):
        self.spells = {}
        self.items = {}
        self.variables = {}
        self.inflight = {}
        self.ranges = []
        self.custom_code = [self.NUM_FUNCTION, self.BOOL_FUNCTION]
        self.player = None

    def add_spell(self, spell):
        """
        Add a spell to the context.
        """
        if (spell.simc, spell.type_) not in self.spells:
            self.spells[(spell.simc, spell.type_)] = spell

    def add_item(self, item):
        """
        Add an item to the context.
        """
        if item.simc not in self.items:
            self.items[item.simc] = item

    def add_variable(self, variable):
        """
        Add an variable to the context.
        """
        if variable.simc not in self.variables:
            self.variables[variable.simc] = variable

    def add_inflight(self, spell):
        """
        Add an inflight registration to the context.
        """
        if spell.simc not in self.inflight:
            self.inflight[spell.simc] = spell

    def add_range(self, range_):
        """
        Add an range to the context.
        """
        if range_ not in self.ranges:
            self.ranges.append(range_)

    def set_player(self, player):
        """
        Set the player for the context.
        """
        self.player = player

    def add_code(self, code):
        """
        Add custom code to the context.
        """
        self.custom_code.append(code)

    def print_spells(self):
        """
        Print the spells object in lua context.
        """
        class_ = self.player.class_.lua_name().upper()
        spec = self.player.spec.lua_name().upper()
        lua_spells = (
            f'Action[ACTION_CONST_{class_}_{spec}] = '
            '{\n'
            '    -- Racial\n'
            '    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),\n'
            '    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),\n'
            '    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),\n'
            '    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),\n'
            '    Berserking                             = Create({ Type = "Spell", ID = 26297    }),\n'
            '    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),\n'
            '    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),\n'
            '    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), \n'
            '    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),\n'
            '    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  \n'  
            '    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),\n'
            '    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core \n'
            '    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), \n'
            '    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   \n' 
            '    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it\n'
            '    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it\n'
            '    -- Generics\n'
            )
        for i, spell in enumerate(self.spells.values()):
            spell_id = str(self.player.spell_property(spell, spell.type_, ''))
            pet_str = ''
            if self.player.spell_property(spell, PET):
                pet_str = f', "{PET}"'
            """
            Add exceptions to Spells lists that we got in native
			"""
            if (not spell.lua_name() == 'BloodoftheEnemy' 
            and not spell.lua_name() == 'GuardianofAzeroth'
            and not spell.lua_name() == 'FocusedAzeriteBeam' 
            and not spell.lua_name() == 'PurifyingBlast'
            and not spell.lua_name() == 'TheUnboundForce'			
            and not spell.lua_name() == 'ConcentratedFlame' 
            and not spell.lua_name() == 'RippleInSpace'
            and not spell.lua_name() == 'WorldveinResonance'				
            and not spell.lua_name() == 'MemoryofLucidDreams'
            and not spell.lua_name() == 'BloodoftheEnemyDebuff'
            and not spell.lua_name() == 'RazorCoralDeBuffDebuff'
            and not spell.lua_name() == 'ConductiveInkDeBuffDebuff'
            and not spell.lua_name() == 'RecklessForceBuff'
            and not spell.lua_name() == 'RecklessForce'
            and not spell.lua_name() == 'RecklessForceCounterBuff'
            and not spell.lua_name() == 'ConcentratedFlameBurn'
            and not spell.lua_name() == 'ConcentratedFlameBurnDebuff'
            and not spell.lua_name() == 'CondensedLifeforce'
            and not spell.lua_name() == 'CyclotronicBlast'
            and not spell.lua_name() == 'Stealth'
            and not spell.lua_name() == 'MemoryofLucidDreamsBuff'			
            and not spell.lua_name() == 'OutofRangeBuff'
            and not spell.lua_name() == 'OutofRange'
            """
			Class Specifics
			"""
            and not spell.lua_name() == 'RakeBleed'
			):
                lua_spells += (f'    {spell.lua_name():38} = '
                'Create('
                '{ Type = "Spell", '
                f'ID = {spell_id}{pet_str}'
                ' })')
                lua_spells += ',\n' if i < len(self.spells) - 1 else '\n'
        lua_spells += (
            '    -- Trinkets\n'
            '    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), \n'
            '    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), \n'  
            '    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), \n'
            '    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), \n'
            '    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), \n'
            '    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), \n'
            '    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), \n'
            '    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), \n'
            '    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), \n'
            '    -- Potions\n'
            '    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), \n' 
            '    BattlePotionOfAgility                  = Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), \n'    
            '    SuperiorBattlePotionOfAgility          = Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), \n' 
            '    PotionTest                             = Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), \n'
            '    -- Trinkets\n'
            '    GenericTrinket1                        = Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),\n'
            '    GenericTrinket2                        = Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),\n'
            '    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),\n'
            '    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), \n'
            '    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),\n'
            '    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),\n'
            '    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),\n'
            '    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),\n'
            '    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),\n'
            '    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),\n'
            '    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),\n'
            '    GalecallersBoon                        = Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),\n'
            '    InvocationOfYulon                      = Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),\n'
            '    LustrousGoldenPlumage                  = Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),\n'
            '    ComputationDevice                      = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),\n'
            '    VigorTrinket                           = Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),\n'
            '    FontOfPower                            = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),\n'
            '    RazorCoral                             = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),\n'
            '    AshvanesRazorCoral                     = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),\n'
            '    -- Misc\n'
            '    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling\n'
            '    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)\n'
            '    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit\n'
            '    CyclotronicBlast                       = Create({ Type = "Spell", ID = 293491, Hidden = true}),\n'
            '    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true}),\n'
            '    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),\n' 
            '    ConductiveInkDebuff                    = Create({ Type = "Spell", ID = 302565, Hidden = true     }),\n'				
            '};\n\n'
			'-- To create essences use next code:\n'
            f'Action:CreateEssencesFor(ACTION_CONST_{class_}_{spec})  '      
			'-- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)\n'
            f'local A = setmetatable(Action[ACTION_CONST_{class_}_{spec}'
            '], { __index = Action })')
        return lua_spells

    def print_items(self):
        """
        Print the items object in lua context.
        """
        class_ = self.player.class_.lua_name()
        spec = self.player.spec.lua_name()
        lua_items = (
            '-- Items\n'
            f'if not Item.{class_} then Item.{class_} = {{}} end\n'
            f'Item.{class_}.{spec} = {{\n')
        for i, item in enumerate(self.items.values()):
            item_id = str(ITEM_INFO.get(item.simc, item.iid))
            lua_items += f'  {item.lua_name():33}= Item({item_id})'
            lua_items += ',\n' if i < len(self.items) - 1 else '\n'
        lua_items += (
            '};\n'
            f'local I = Item.{class_}.{spec};\n')
        string = ''
        return string

    def print_variables(self):
        """
        Print the variables object in lua context.
        """
        lua_variables = ''
        if len(self.variables) > 0:
            lua_variables = ('------------------------------------------\n'
            '---------------- VARIABLES ---------------\n'
            '------------------------------------------\n'			
            )
            for var in self.variables.values():
                lua_variables += f'local {var.lua_name()} = {var.default};\n'
            lua_variables += f'\nA.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()\n'
            for var in self.variables.values():
                lua_variables += f'  {var.lua_name()} = {var.default}\n'
            lua_variables += f'end)\n'
			
        return lua_variables

    def print_inflight(self):
        """
        Print the inflight registrations.
        """
        lua_inflight = ''
        for spell in self.inflight.values():
            lua_inflight += f'A.{spell.lua_name()}:RegisterInFlight()\n'
        return ''

    def print_custom_code(self):
        """
        Print the custom code.
        """
        return '\n'.join(self.custom_code)

    def print_ranges(self):
        """
        Print the custom code.
        """
        lua_ranges = ", ".join(str(r) for r in sorted(self.ranges, reverse=True))
        return ('')

    def print_settings(self):
        """
        Print additional settings.
        """
        class_ = self.player.class_.lua_name()
        spec = self.player.spec.lua_name()
        return ('')

    def print_lua(self):
        """
        Print the context.
        """
        newline = '\n' if self.custom_code else ''
        return (
            f'{self.HEADER}\n'
            f'{self.CONTENT_HEADER}\n'
            f'{self.print_spells()}\n'
            f'{self.print_items()}\n'
            f'{self.print_settings()}\n'
            f'{self.print_variables()}\n'
            f'{self.print_ranges()}\n'
            f'{self.print_inflight()}\n'
            f'{self.print_custom_code()}{newline}')
