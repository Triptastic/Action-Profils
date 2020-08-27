# -*- coding: utf-8 -*-
"""
Warlock specific constants and functions.

@author: skasch
"""

import os

from ..constants import COMMON, SPELL, BUFF, DEBUFF, RANGE, READY, GCDAOGCD, CD, USABLE

WARLOCK = 'warlock'
AFFLICTION = 'affliction'
DEMONOLOGY = 'demonology'
DESTRUCTION = 'destruction'

CLASS_SPECS = {
    WARLOCK: {
        AFFLICTION:         265,
        DEMONOLOGY:         266,
        DESTRUCTION:        267,
    },
}

DEFAULT_POTION = {
    WARLOCK: {
        AFFLICTION:     'potion_of_spectral_intellect',
        DEMONOLOGY:     'potion_of_spectral_intellect',
        DESTRUCTION:    'potion_of_spectral_intellect',
    }
}

DEFAULT_RANGE = {
    WARLOCK: {
        AFFLICTION: 40,
    },
}

ACTION_LIST_INFO = {
    WARLOCK: {
        DESTRUCTION: {
            'cds':              {CD:            True},
        },
    },
}

SPELL_INFO = {
    WARLOCK: {
        COMMON: {
        },
        AFFLICTION: {
            'haunt':                            {SPELL:     48181,
                                                 DEBUFF:    48181},
            'sow_the_seeds':                    {SPELL:     196226},
            'agony':                            {SPELL:     980,
                                                 DEBUFF:    980},
            'drain_soul':                       {SPELL:     198590,
                                                 DEBUFF:    198590},
            'corruption':                       {SPELL:     172,
                                                 DEBUFF:    146739,
                                                 RANGE:     40},
            'unstable_affliction':              {SPELL:     30108,
                                                 DEBUFF:    30108,
                                                 READY:     True,
                                                 RANGE:     40},
            'siphon_life':                      {SPELL:     63106,
                                                 DEBUFF:    63106},
            'phantom_singularity':              {SPELL:     205179,
                                                 DEBUFF:    205179,
                                                 GCDAOGCD:  True},
            'seed_of_corruption':               {SPELL:     27243,
                                                 DEBUFF:    27243,
                                                 RANGE:     40},
            'writhe_in_agony':                  {SPELL:     196102},
            'vile_taint':                       {SPELL:     278350,
                                                 DEBUFF:    278350},
            'dark_soul':                        {SPELL:     113860,
                                                 GCDAOGCD:  True,
                                                 CD:        True},
            'dark_soul_misery':                 {SPELL:     113860},
            'deathbolt':                        {SPELL:     264106},
            'summon_darkglare':                 {SPELL:     205180,
                                                 GCDAOGCD:  True,
                                                 CD:        True},
            'shadow_bolt':                      {SPELL:     232670},
            'grimoire_of_sacrifice':            {SPELL:     108503,
                                                 BUFF:      196099,
                                                 GCDAOGCD:  True},
            'summon_pet':                       {SPELL:     691,
                                                 GCDAOGCD:  True},
            
            'unstable_affliction_1':            {DEBUFF:    233490},
            'unstable_affliction_2':            {DEBUFF:    233496},
            'unstable_affliction_3':            {DEBUFF:    233497},
            'unstable_affliction_4':            {DEBUFF:    233498},
            'unstable_affliction_5':            {DEBUFF:    233499},
            'drain_life':                       {SPELL:     234153,
                                                 RANGE:     40,
                                                 CD:        True},
            'creeping_death':                   {SPELL:     264000},
            'nightfall':                        {SPELL:     108558,
                                                 BUFF:      264571},
            'absolute_corruption':              {SPELL:     196103},
            'shadow_embrace':                   {SPELL:     32388,
                                                 DEBUFF:    32390},
            # Azerite
            'cascading_calamity':               {SPELL:     275372,
                                                 BUFF:      275378},
            'sudden_onset':                     {SPELL:     278721},
            'inevitable_demise':                {SPELL:     273521,
                                                 BUFF:      273525},
            'pandemic_invocation':              {SPELL:     289364},
            # Placeholders
            'active_uas':                       {BUFF:      233490}
        },
        DEMONOLOGY: {
            'shadow_bolt':                      {SPELL:     686},
            'summon_pet':                       {SPELL:     30146,
                                                 READY:     True,
                                                 GCDAOGCD:  True},
            'inner_demons':                     {SPELL:     267216},
            'demonbolt':                        {SPELL:     264178},
            'soul_strike':                      {SPELL:     264057},
            'implosion':                        {SPELL:     196277,
                                                 RANGE:     40}, 
            'call_dreadstalkers':               {SPELL:     104316,
                                                 READY:     True},
            'bilescourge_bombers':              {SPELL:     267211,
                                                 READY:     True},
            'hand_of_guldan':                   {SPELL:     105174},
            'demonic_power':                    {BUFF:      265273},
            'summon_demonic_tyrant':            {SPELL:     265187,
                                                 GCDAOGCD:  True},
            'grimoire_felguard':                {SPELL:     111898,
                                                 READY:     True,
                                                 GCDAOGCD:  True},
            'demonic_calling':                  {SPELL:     205145,
                                                 BUFF:      205146},
            'demonic_core':                     {BUFF:      264173},
            'summon_vilefiend':                 {SPELL:     264119,
                                                 READY:     True},
            'nether_portal':                    {SPELL:     267217,
                                                 BUFF:      267218,
                                                 READY:     True},
            'power_siphon':                     {SPELL:     264130},
            'doom':                             {SPELL:     265412,
                                                 DEBUFF:    265412},    
            'demonic_strength':                 {SPELL:     267171,
                                                 READY:     True,
                                                 GCDAOGCD:  True},
            'demonic_consumption':              {SPELL:     267215},
            
            # Azerite Traits
            'explosive_potential':              {SPELL:     275395,
                                                 BUFF:      275398},
            'forbidden_knowledge':              {SPELL:     279666},
            'baleful_invocation':               {SPELL:     287059},
            'shadows_bite':                     {SPELL:     272944,
                                                 BUFF:      272945},
        },
        DESTRUCTION: {
            'shadow_bolt':                      {SPELL:     686},
            'summon_pet':                       {SPELL:     688},
            'grimoire_of_sacrifice':            {SPELL:     108503},
            'soul_fire':                        {SPELL:     6353},
            'incinerate':                       {SPELL:     29722},
            'rain_of_fire':                     {SPELL:     5740,
                                                 DEBUFF:    5740,
                                                 RANGE:     40},
            'cataclysm':                        {SPELL:     152108,
                                                 RANGE:     40},
            'immolate':                         {SPELL:     348,
                                                 DEBUFF:    157736,
                                                 RANGE:     40},    
            'channel_demonfire':                {SPELL:     196447,
                                                 RANGE:     40},
            'chaos_bolt':                       {SPELL:     116858,
                                                 RANGE:     40},   
            'havoc':                            {SPELL:     80240,
                                                 DEBUFF:    80240,
                                                 RANGE:     40},
            'active_havoc':                     {BUFF:      80240},
                                                                #   ??? buff.active_havoc.remains -> Player:BuffRemainsP(S.ActiveHavocBuff)
                                                                # pet.infernal.active&pet.infernal.remains<=10 -> bool(pet.infernal.active) and Target:DebuffRemainsP(S.HavocDebuff) <= 10)
            'grimoire_of_supremacy':            {SPELL:     266086,
                                                 BUFF:      266091},
            'conflagrate':                      {SPELL:     17962},
            'shadowburn':                       {SPELL:     17877,
                                                 DEBUFF:    17877},
            'backdraft':                        {SPELL:     196406,
                                                 BUFF:      117828},
            'summon_infernal':                  {SPELL:     1122,
                                                 RANGE:     30},
            'dark_soul_instability':            {SPELL:     113858,
                                                 BUFF:      113858},
            'flashover':                        {SPELL:     267115},
            'roaring_blaze':                    {SPELL:     205184,
                                                 DEBUFF:    265931},
            'internal_combustion':              {SPELL:     266134},
            'eradication':                      {SPELL:     196412,
                                                 DEBUFF:    196414},
            'fire_and_brimstone':               {SPELL:     196408},
            'inferno':                          {SPELL:     270545},
        },
    },
}

ITEM_INFO = {
}


CLASS_FUNCTIONS = {
    WARLOCK: {
        COMMON: [
        ],
        AFFLICTION: [
            'WARLOCKAfflictionPreAplSetup',
        ],
        DEMONOLOGY: [
            'WARLOCKDemonologyPreAplSetup',
        ],
        DESTRUCTION: [
            'WARLOCKDestructionPreAplSetup',
        ],
    },
}


def warlock_soul_shard_value(fun):
    """
    Replaces the soul_shard expression with a call to FutureShard.
    """
    from ..objects.lua import Method

    def value(self):
        """
        Return the arguments for the expression soul_shard.
        """
        if self.condition.parent_action.player.class_.simc == WARLOCK:
            # self.object_ = None
            self.method = Method('SoulShardsP')
        else:
            fun(self)

    return value

def warlock_precombat_skip(fun):

    def print_lua(self):
        lua_string = ''
        if self.show_comments:
            lua_string += f'-- call precombat'
        exec_cast = self.execution().object_().print_cast()
        lua_string += (
            '\n'
            f'if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then\n'
            f'  {exec_cast}\n'
            f'end')
        return lua_string

    return print_lua

def affliction_active_uas_stack(fun):
    """
    Replaces the buff.active_uas.stack expression with a call to ActiveUAs.
    """
    from ..objects.lua import Method

    def stack(self):
        """
        Return the arguments for the expression buff.active_uas.stack.
        """
        if (self.condition.parent_action.player.spec.simc == AFFLICTION
                and self.condition.condition_list[1] == 'active_uas'):
            self.object_ = None
            self.method = Method('ActiveUAs(unit)')
            self.args = []
        else:
            fun(self)

    return stack

DECORATORS = {
    WARLOCK: [
        {
            'class_name': 'SoulShard',
            'method': 'value',
            'decorator': warlock_soul_shard_value,
        },
        {
            'class_name': 'PrecombatAction',
            'method': 'print_lua',
            'decorator': warlock_precombat_skip,
        },
        {
            'class_name': 'Buff',
            'method': 'stack',
            'decorator': affliction_active_uas_stack,
        },
    ],
}

TEMPLATES = {
    WARLOCK+AFFLICTION:     ( '{context}'
                '      local CanMultidot = HandleMultidots()\n'
	            '      local unit = "player"\n'
                '      local time_to_shard = TimeToShard()\n'
	            '      local PredictSpells = A.GetToggle(2, "PredictSpells")\n'
	            '      DetermineEssenceRanks()\n'
                '      {action_lists}\n'
                '      {precombat_call}\n'
                '      if Unit(unit):IsExists() then\n'
                '         {main_actions}\n'
                '      end\n'
                '\n{set_apl}')
}