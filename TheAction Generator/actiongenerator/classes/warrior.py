# -*- coding: utf-8 -*-
"""
Warrior specific constants and functions.

@author: skasch
"""

from ..constants import COMMON, SPELL, BUFF, DEBUFF, RANGE, CD, GCDAOGCD, READY, OGCDAOGCD

WARRIOR = 'warrior'
ARMS = 'arms'
FURY = 'fury'
PROTECTION = 'protection'

CLASS_SPECS = {
    WARRIOR: {
        ARMS:           71,
        FURY:           72,
        PROTECTION:     73,
    },
}

DEFAULT_POTION = {
    WARRIOR: {
        ARMS: 'potion_of_spectral_strength',
        FURY: 'potion_of_spectral_strength',
        PROTECTION: 'potion_of_spectral_strength',
    }
}

DEFAULT_RANGE = {
    WARRIOR: {
        # TODO: Fix context.py #L155/L159 to accept "Melee" range
        ARMS:   8
    },
}

SPELL_INFO = {
    WARRIOR: {
        COMMON: {
            'stone_heart':                          {BUFF:      225947},
            'charge':                               {SPELL:     100,
                                                     GCDAOGCD:  True},
            'avatar':                               {SPELL:     107574,
                                                     BUFF:      107574,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            'dragon_roar':                          {SPELL:     118000,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            # Azerite
            'crushing_assault':                     {SPELL:     278751,
                                                     BUFF:      278826},
            'test_of_might':                        {SPELL:     275529,
                                                     BUFF:      275540},
            'seismic_wave':                         {SPELL:     277639},                                         
        },
        ARMS: {
            'warbreaker':                           {SPELL:     262161,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            'bladestorm':                           {SPELL:     227847,
                                                     RANGE:     8,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            'ravager':                              {SPELL:     152277,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            'colossus_smash':                       {SPELL:     167105,
                                                     DEBUFF:    208086},
            'in_for_the_kill':                      {SPELL:     248621,
                                                     BUFF:      248622},
            'cleave':                               {SPELL:     845,
                                                     BUFF:      231833,
                                                     READY:     True},
            'whirlwind':                            {SPELL:     1680,
                                                     RANGE:     8,
                                                     READY:     True},
            'shattered_defenses':                   {BUFF:      248625},
            'execute':                              {SPELL:     163201},
            'mortal_strike':                        {SPELL:     12294,
                                                     READY:     True},
            'executioners_precision':               {SPELL:     238147,
                                                     BUFF:      242188},
            'rend':                                 {SPELL:     772,
                                                     DEBUFF:    772,
                                                     READY:     True},
            'focused_rage':                         {SPELL:     207982,
                                                     BUFF:      207982},
            'fervor_of_battle':                     {SPELL:     202316},
            'weighted_blade':                       {BUFF:      253383},
            'overpower':                            {SPELL:     7384,
                                                     BUFF:      7384},
            'dauntless':                            {SPELL:     202297},
            'deadly_calm':                          {SPELL:     262228,
                                                     BUFF:      262228,
                                                     OGCDAOGCD: True},
            'anger_management':                     {SPELL:     152278},
            'slam':                                 {SPELL:     1464,
                                                     READY:     True},
            'skullsplitter':                        {SPELL:     260643},
            'heroic_leap':                          {SPELL:     6544},
            'sudden_death':                         {BUFF:      52437},
            'sweeping_strikes':                     {SPELL:     260708,
                                                     BUFF:      260708},
            'deep_wounds':                          {DEBUFF:    262115},
            'massacre':                             {SPELL:     281001},
            'dreadnaught':                          {SPELL:     262150},
        },
        FURY: {
            'bloodthirst':                          {SPELL:     23881},
            'enrage':                               {SPELL:     184361,
                                                     BUFF:      184362},
            'bladestorm':                           {SPELL:     46924,
                                                     BUFF:      46924,
                                                     RANGE:     8,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            'bladestorm_mh':                        {RANGE:     8},
            'whirlwind':                            {SPELL:     190411,
                                                     RANGE:     8},
            'meat_cleaver':                         {SPELL:     280392,
                                                     BUFF:      280392},
            'rampage':                              {SPELL:     184367,
                                                     READY:     True},
            'frothing_berserker':                   {SPELL:     215571},
            'massacre':                             {SPELL:     206315,
                                                     BUFF:      206316},
            'execute':                              {SPELL:     5308},
            'raging_blow':                          {SPELL:     85288},
            'inner_rage':                           {SPELL:     215573},
            'berserker_rage':                       {SPELL:     18499,
                                                     BUFF:      18499},
            'furious_slash':                        {SPELL:     100130,
                                                     BUFF:      202539},
            'heroic_leap':                          {SPELL:     6544},
            'carnage':                              {SPELL:     202922},
            'reckless_abandon':                     {SPELL:     202751},
            'recklessness':                         {SPELL:     1719,
                                                     BUFF:      1719,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
            'siegebreaker':                         {SPELL:     280772,
                                                     DEBUFF:    280773,
                                                     CD:        True,
                                                     GCDAOGCD:  True},
        },
        PROTECTION: {
            'thunder_clap':                         {SPELL:     6343},
            'demoralizing_shout':                   {SPELL:     1160,
                                                     GCDAOGCD:  True},
            'booming_voice':                        {SPELL:     202743},
            'revenge':                              {SPELL:     6572,
                                                     READY:     True},
            'ravager':                              {SPELL:     228920},
            'shield_block':                         {SPELL:     2565,
                                                     BUFF:      132404,
                                                     READY:     True,
                                                     OGCDAOGCD: True},
            'shield_slam':                          {SPELL:     23922},
            'unstoppable_force':                    {SPELL:     275336},
            'devastate':                            {SPELL:     20243},
            'intercept':                            {SPELL:     198304},
            'ignore_pain':                          {SPELL:     190456,
                                                     READY:     True,
                                                     OGCDAOGCD: True},
            # Azerite
            'brace_for_impact':                     {SPELL:     277636},
            'deafening_crash':                      {SPELL:     272824},
        },
    },
}

ITEM_INFO = {
    'the_great_storms_eye':             151823,
    'archavons_heavy_hand':             137060,
    'kazzalax_fujiedas_fury':           137053,
    'umbral_moonglaives':               147012,
    'weight_of_the_earth':              137077,
    'grongs_primal_rage':               165574,
}

CLASS_FUNCTIONS = {
    WARRIOR: {
        COMMON: [
        ],
        ARMS: [
            'WARRIORArmsPreAplSetup',
        ],
        FURY: [
            'WARRIORFuryPreAplSetup',
        ],
        PROTECTION: [
            'WARRIORProtectionPreAplSetup',
        ],
    },
}

TEMPLATES = {
    WARRIOR+ARMS:     ( '{context}'
                '--- ======= ACTION LISTS =======\n'
                'local function {function_name}()\n'
                '{action_list_names}\n'
                '  UpdateRanges()\n'
                '  Everyone.AoEToggleEnemiesUpdate()\n'
                '  UpdateExecuteID()\n'
                '{action_lists}\n'
                '{precombat_call}\n'
                '  if Everyone.TargetIsValid() then\n'                
                '{main_actions}\n'
                '  end\n'
                'end\n'
                '\n{set_apl}')
}