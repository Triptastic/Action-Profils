# -*- coding: utf-8 -*-
"""
Initialize the actiongenerator package.

@author: skasch
"""

# String constants
# ================
A = 'Action'
SPELL = 'spell'
ITEM = 'item'
BUFF = 'buff'
DEBUFF = 'deBuff'
POTION = 'potion'

VARIABLE = 'variable'
USE_ITEM = 'use_item'
CANCEL_BUFF = 'cancel_buff'
RUN_ACTION_LIST = 'run_action_list'
CALL_ACTION_LIST = 'call_action_list'

BLOODLUST = 'bloodlust'
MOVEMENT = 'movement'
DISTANCE = 'distance'
COOLDOWN = 'cooldown'
ESSENCE = 'essence'
COVENANT = 'covenant'
SOULBIND = 'soulbind'
CONDUIT = 'conduit'
RUNEFORGE = 'runeforge'

BOOL = 'bool'
NUM = 'num'
TRUE = 'true'
FALSE = 'false'

GCDAOGCD = 'GCDasOffGCD'
OGCDAOGCD = 'OffGCDasOffGCD'
USABLE = 'usable'
READY = 'ready'
INTERRUPT = 'interrupt'
MELEE = 'melee'
CD = 'cd'
PET = 'pet'
COMMON = 'common'
RANGE = 'range'
OPENER = 'opener'
AUTOCHECK = 'autocheck'
ANYCASTER = 'anycaster'

MAX_INT = 'IncomingAddsIn'

# Miscellaneous
# =============

# Named action lists to ignore in simc
IGNORED_ACTION_LISTS = [
]

# Named executions which should be ignored by actiongenerator
IGNORED_EXECUTIONS = [
    'auto_attack',
    'auto_shot',
    'food',
    'flask',
    'augmentation',
    'snapshot_stats',
    'use_items',
    'wait',
    # Monk Brewmaster
    'greater_gift_of_the_ox',
    'gift_of_the_ox',
    # Druid Feral
    'dash',
    # Mage
    'time_warp',
    'counterspell',
    # Shaman
    'bloodlust',
    'earth_elemental',
]

# Strings to recognize as items
ITEM_ACTIONS = [
]

# Mostly, words to lowercase when converting to lua names to match
# HeroRotation naming convention
WORD_REPLACEMENTS = {
    'And': 'and',
    'Blooddrinker': 'BloodDrinker',
    'Of': 'of',
    'The': 'the',
    'Deathknight': 'DeathKnight',
    'Demonhunter': 'DemonHunter',
    'Apl': 'APL',
	'Debuff': 'DeBuff',
	'DeBuffDebuff': 'DeBuff',
	'Player': 'Unit("player")',
	'Target': 'Unit(unit)',
	'MemoryofLucidDreamsBuff': 'MemoryofLucidDreams',
}

# Expressions operators
# =====================

# simc > lua map for unary operators
UNARY_OPERATORS = {
    '-': '-',
    '!': 'not',
    'abs': 'math.abs',
    'floor': 'math.floor',
    'ceil': 'math.ceil',
}

# simc > lua map for binary operators
BINARY_OPERATORS = {
    '&': 'and',
    '|': 'or',
    '+': '+',
    '-': '-',
    '*': '*',
    '%': '/',
    '=': '==',
    '!=': '~=',
    '<': '<',
    '<=': '<=',
    '>': '>',
    '>=': '>=',
    # TODO Handle the in/not_in cases
}

LOGIC_OPERATORS = ['&', '|', '!']
COMPARISON_OPERATORS = ['!=', '<=', '>=', '=', '<', '>']
ADDITION_OPERATORS = ['+', '-']
MULTIPLIACTION_OPERATORS = ['*', '%']
FUNCTION_OPERATORS = ['abs', 'floor', 'ceil']

TYPE_CONVERSION = {
    NUM: {
        NUM: '{}',
        BOOL: '{}',
    },
    BOOL: {
        NUM: 'num({})',
        BOOL: '{}',
    },
}
