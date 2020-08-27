# -*- coding: utf-8 -*-
"""
Initialize the actiongenerator package.

@author: skasch
"""

from .classes import deathknight
from .classes import demonhunter
from .classes import druid
from .classes import hunter
from .classes import mage
from .classes import monk
from .classes import paladin
from .classes import priest
from .classes import rogue
from .classes import shaman
from .classes import warlock
from .classes import warrior
from .constants import SPELL, BUFF, OGCDAOGCD, CD, COMMON

CLASSES = [deathknight, demonhunter, druid, hunter, mage, monk, paladin, priest,
           rogue, shaman, warlock, warrior]

CLASS_SPECS = {}
for class_ in CLASSES:
    CLASS_SPECS.update(class_.CLASS_SPECS)

RACES = [
    'blood_elf',
    'draenei',
    'dwarf',
    'gnome',
    'goblin',
    'human',
    'night_elf',
    'orc',
    'pandaren',
    'tauren',
    'troll',
    'undead',
    'worgen',
]

DEFAULT_POTION = {}
for class_ in CLASSES:
    DEFAULT_POTION.update(class_.DEFAULT_POTION)

DEFAULT_RANGE = {}
for class_ in CLASSES:
    DEFAULT_RANGE.update(class_.DEFAULT_RANGE)

SPELL_INFO = {
    COMMON: {
        'arcane_torrent': {SPELL: 50613,
                           OGCDAOGCD: True,
                           CD: True},
        'berserking': {SPELL: 26297,
                       BUFF: 26297,
                       OGCDAOGCD: True,
                       CD: True},
        'blood_fury': {SPELL: 20572,
                       BUFF: 20572,
                       OGCDAOGCD: True,
                       CD: True},
        'lights_judgment': {SPELL: 255647,
                            CD: True},
        'gift_of_the_naaru': {SPELL: 59547},
        'shadowmeld': {SPELL: 58984,
                       BUFF: 58984,
                       CD: True,
                       OGCDAOGCD: True},
        'darkflight': {SPELL: 68992},
        'stoneform': {SPELL: 20594},
        'exhaustion': {BUFF: 57723},
        'fireblood': {SPELL: 265221,
                      OGCDAOGCD: True,
                      CD: True},
        'ancestral_call': {SPELL: 274738,
                           OGCDAOGCD: True,
                           CD: True},
        'reckless_force_counter': {BUFF: 302917},
        'heart_essence': {SPELL: 298554},
        'blood_of_the_enemy': {SPELL: 297108,
                               BUFF: 297108},
        'latent_arcana': {SPELL: 296962,
                          BUFF: 296962},
        'lifeblood': {BUFF: 295078},
        # TODO: Fix; hack to make it work from consumable
        'prolonged_power': {BUFF: 229206},
        'potion_of_prolonged_power': {BUFF: 229206},
        'potion_of_deadly_grace': {BUFF: 188027},
        'potion_of_rising_death': {BUFF: 269853},
        'pool_resource': {SPELL: 9999000010},
    }
}
for class_ in CLASSES:
    SPELL_INFO.update(class_.SPELL_INFO)

ACTION_LIST_INFO = {}
for class_ in CLASSES:
    try:
        ACTION_LIST_INFO.update(class_.ACTION_LIST_INFO)
    except AttributeError:
        pass

ITEM_INFO = {
    'prolonged_power': 142117,
    'old_war': 127844,
    'deadly_grace': 127843,
    'battle_potion_of_intellect': 163222,
    'battle_potion_of_agility': 163223,
    'battle_potion_of_strength': 163224,
    'potion_of_rising_death': 152559,
    """ Shadowlands Alchemy """
    'potion_of_spectral_stamina': 171274,
    'potion_of_spectral_strength': 171275,
    'potion_of_spectral_intellect': 171273,
    'potion_of_spectral_agility': 171270,



}
for class_ in CLASSES:
    ITEM_INFO.update(class_.ITEM_INFO)

CLASS_FUNCTIONS = {}
for class_ in CLASSES:
    CLASS_FUNCTIONS.update(class_.CLASS_FUNCTIONS)

DECORATORS = {}
for class_ in CLASSES:
    try:
        DECORATORS.update(class_.DECORATORS)
    except AttributeError:
        pass

TEMPLATES = {}
for class_ in CLASSES:
    try:
        TEMPLATES.update(class_.TEMPLATES)
    except AttributeError:
        pass
