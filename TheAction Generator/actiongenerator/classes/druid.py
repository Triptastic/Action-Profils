# -*- coding: utf-8 -*-
"""
Druid specific constants and functions.

@author: skasch
"""

from ..constants import SPELL, BUFF, DEBUFF, COMMON, RANGE, GCDAOGCD, OGCDAOGCD, CD, OPENER, READY

DRUID = 'druid'
BALANCE = 'balance'
FERAL = 'feral'
GUARDIAN = 'guardian'
RESTORATION = 'restoration'

CLASS_SPECS = {
    DRUID: {
        BALANCE:        102,
        FERAL:          103,
        GUARDIAN:       104,
        RESTORATION:    105,
    },
}

DEFAULT_POTION = {
    DRUID: {
        BALANCE:    'potion_of_spectral_intellect',
        FERAL:      'potion_of_spectral_agility',
        GUARDIAN:   'potion_of_spectral_agility',
    }
}

DEFAULT_RANGE = {
    DRUID: {
        FERAL:  8
    },
}

SPELL_INFO = {
    DRUID: {
        COMMON: {
            'bear_form':                        {SPELL:     5487,
                                                 BUFF:      5487},
            'cat_form':                         {SPELL:     768,
                                                 BUFF:      768,
                                                 GCDAOGCD:  True},
            'travel_form':                      {SPELL:     783},
            'swipe_bear':                       {SPELL:     213771,
                                                 RANGE:     8},
            'swipe_cat':                        {SPELL:     106785,
                                                 RANGE:     8},
            'thrash_bear':                      {SPELL:     77758,
                                                 DEBUFF:    192090,
                                                 RANGE:     8},
            'thrash_cat':                       {SPELL:     106830,
                                                 DEBUFF:    106830,
                                                 RANGE:     8},
            'moonfire_cat':                     {SPELL:     155625,
                                                 DEBUFF:    155625,
                                                 RANGE:     40},
            'ferocious_bite':                   {SPELL:     22568},
            'ferocious_bite_max_energy':        {SPELL:     22568},
            'rake':                             {SPELL:     1822,
                                                 DEBUFF:    155722},
            'rip':                              {SPELL:     1079,
                                                 DEBUFF:    1079},
            'thorns':                           {SPELL:     467,
                                                 DEBUFF:    467,
                                                 RANGE:     30},												 
            'shred':                            {SPELL:     5221},
            'moonfire':                         {SPELL:     8921,
                                                 DEBUFF:    164812,
                                                 RANGE:     40},
            'ironfur':                          {SPELL:     192081,
                                                 BUFF:      192081},
            'regrowth':                         {SPELL:     8936},
            'healing_touch':                    {SPELL:     5185},
            'rejuvenation':                     {SPELL:     774},
            'swiftmend':                        {SPELL:     18562},
            'balance_affinity':                 {SPELL:     197488},
            'restoration_affinity':             {SPELL:     197492},
            'frenzied_regeneration':            {SPELL:     22842},
            'survival_instincts':               {SPELL:     61336},
            'barkskin':                         {SPELL:     22812},
            'skull_bash':                       {SPELL:     106839},
            # Legendaries
            'oneths_intuition':                 {BUFF:      209406},
            'oneths_overconfidence':            {BUFF:      209407},
            'the_emerald_dreamcatcher':         {BUFF:      208190},
            'sephuzs_secret':                   {BUFF:      208052},
            'norgannons_foresight':             {BUFF:      236431},
            'fiery_red_maimers':                {BUFF:      236757},
            # Azerite
            'power_of_the_moon':                {SPELL:     273367},
            'wild_fleshrending':                {SPELL:     279527},
            'iron_jaws':                        {BUFF:      276026},
            'layered_mane':                     {SPELL:     279552},
            'streaking_stars':                  {SPELL:     272871},
            'arcanic_pulsar':                   {SPELL:     287773,
                                                 BUFF:      287790},
            'lively_spirit':                    {SPELL:     279642,
                                                 BUFF:      279646}, # Needs double checked
        },
        BALANCE: {
            'moonkin_form':                     {SPELL:     24858},
            'celestial_alignment':              {SPELL:     194223,
                                                 BUFF:      194223},
            'lunar_strike':                     {SPELL:     194153,
                                                 RANGE:     40},
            'innervate':                        {SPELL:     29166},
            'solar_wrath':                      {SPELL:     190984,
                                                 RANGE:     40,
                                                 OPENER:    True},
            'sunfire':                          {SPELL:     93402,
                                                 DEBUFF:    164815,
                                                 RANGE:     40,
                                                 OPENER:    True},
            'starsurge':                        {SPELL:     78674,
                                                 RANGE:     40},
            'starfall':                         {SPELL:     191034,
                                                 RANGE:     40},
            'solar_empowerment':                {BUFF:      164545},
            'lunar_empowerment':                {BUFF:      164547},
                        
            'solar_beam':                       {SPELL:     78675},
            'entangling_roots':                 {SPELL:     339},

            'natures_balance':                  {SPELL:     202430},
            'warrior_of_elune':                 {SPELL:     202425,
                                                 BUFF:      202425},
            'force_of_nature':                  {SPELL:     205636},
            'tiger_dash':                       {SPELL:     252216},
            'renewal':                          {SPELL:     108238},
            'wild_charge':                      {SPELL:     102401},
            'feral_affinity':                   {SPELL:     202157},
            'guardian_affinity':                {SPELL:     197491},
            'restoration_affinity':             {SPELL:     197492},
            'mighty_bash':                      {SPELL:     5211},
            'mass_entanglement':                {SPELL:     102359},
            'typhoon':                          {SPELL:     132469},
            'soul_of_the_forest':               {SPELL:     114107},
            'starlord':                         {SPELL:     202345,
                                                 BUFF:      279709},
            'incarnation':                      {SPELL:     102560,
                                                 BUFF:      102560},
            'stellar_drift':                    {SPELL:     202354},
            'twin_moons':                       {SPELL:     279620},
            'stellar_flare':                    {SPELL:     202347,
                                                 DEBUFF:    202347},
            'shooting_stars':                   {SPELL:     202342},
            'fury_of_elune':                    {SPELL:     202770},
            'new_moon':                         {SPELL:     274281},
            'half_moon':                        {SPELL:     274282},
            'full_moon':                        {SPELL:     274283},
        },
        FERAL: {
            'moonkin_form':                     {SPELL:     197625},
            'berserk':                          {SPELL:     106951,
                                                 BUFF:      106951,
                                                 OGCDAOGCD: True,
                                                 CD:        True},
            'maim':                             {SPELL:     22570},
            'predatory_swiftness':              {BUFF:      69369},
            'prowl':                            {SPELL:     5215,
                                                 BUFF:      5215,
                                                 OGCDAOGCD: True},
            'swipe':                            {SPELL:     106785,
                                                 RANGE:     8},
            'thrash':                           {SPELL:     106830,
                                                 DEBUFF:    106830,
                                                 RANGE:     8},
            'tigers_fury':                      {SPELL:     5217,
                                                 BUFF:      5217,
                                                 OGCDAOGCD: True},
            'dash':                             {SPELL:     1850},
            'wild_charge':                      {SPELL:     49376,
                                                 OGCDAOGCD: True},
            'bloodtalons':                      {SPELL:     155672,
                                                 BUFF:      145152},
            'brutal_slash':                     {SPELL:     202028,
                                                 RANGE:     8},
            'guardian_affinity':                {SPELL:     217615},
            'jungle_fury':                      {SPELL:     274424},
            'incarnation':                      {SPELL:     102543,
                                                 BUFF:      102543,
                                                 OGCDAOGCD: True,
                                                 CD:        True},
            'jungle_stalker':                   {BUFF:      252071},
            'jagged_wounds':                    {SPELL:     202032},
            'lunar_inspiration':                {SPELL:     155580},
            'sabertooth':                       {SPELL:     202031},
            'savage_roar':                      {SPELL:     52610,
                                                 BUFF:      52610},
            'renewal':                          {SPELL:     108238},
            'clearcasting':                     {BUFF:      135700},
            'apex_predator':                    {BUFF:      252752},
            'feral_frenzy':                     {SPELL:     274837},
            'moment_of_clarity':                {SPELL:     236068},
            'scent_of_blood':                   {SPELL:     285564,
                                                 BUFF:      285646},
            'primal_wrath':                     {SPELL:     285381},
        },
        GUARDIAN:   {
            'moonkin_form':                     {SPELL:     197625},
            'gore':                             {BUFF:      93622},
            'gory_fur':                         {BUFF:      201671},
            'mangle':                           {SPELL:     33917},
            'maul':                             {SPELL:     6807,
                                                 READY:     True},
            'blood_frenzy':                     {SPELL:     203962},
            'brambles':                         {SPELL:     203953},
            'bristling_fur':                    {SPELL:     155835},
            'earthwarden':                      {SPELL:     203974,
                                                 BUFF:      203975},
            'feral_affinity':                   {SPELL:     202155},
            'galactic_guardian':                {SPELL:     203964,
                                                 BUFF:      213708},
            'guardian_of_elune':                {SPELL:     155578,
                                                 BUFF:      213680},
            'incarnation':                      {SPELL:     102558,
                                                 BUFF:      102558},
            'lunar_beam':                       {SPELL:     204066},
            'pulverize':                        {SPELL:     80313,
                                                 BUFF:      158792},
            'soul_of_the_forest':               {SPELL:     158477},
            'rage_of_the_sleeper':              {SPELL:     200851},
            'growl':                            {SPELL:     6795},
            'lunar_strike':                     {SPELL:     197628},
            'solar_wrath':                      {SPELL:     197629},
            'starsurge':                        {SPELL:     197626},
            'sunfire':                          {SPELL:     197630,
                                                 DEBUFF:    164815},
        },
    },
}

ITEM_INFO = {
    'dread_gladiators_badge':   161902,
    'balefire_branch':          159630,
    'azurethos_singed_plumage': 161377,
    'tidestorm_codex':          165576,
}

CLASS_FUNCTIONS = {
    DRUID: {
        COMMON: [
        ],
        BALANCE: [
            'DRUIDBalancePreAplSetup',
        ],
        FERAL: [
            'DRUIDFeralPreAplSetup',
        ],
        GUARDIAN: [
            'DRUIDGuardianPreAplSetup',
        ],
    },
}


def balance_astral_power_value(fun):
    """
    Replaces the astral_power expression with a call to FutureAstralPower.
    """
    from ..objects.expressions import Method

    def value(self):
        """
        Return the arguments for the expression astral_power.
        """
        if self.condition.parent_action.player.spec.simc == BALANCE:
            self.object_ = None
            self.method = Method('FutureAstralPower')
        else:
            fun(self)

    return value


def guardian_swipe_thrash_value(fun):
    """
    Replaces the expression of a spell by a call to Swipe/Thrash specific
    functions for form check for guardian.
    """

    def print_lua(self):
        """
        Print the lua expression for the spell.
        """
        if (self.action.player.spec.simc == GUARDIAN
                and self.simc in ['swipe', 'thrash']):
            return f'{self.lua_name()}()'
        return fun(self)

    return print_lua

def guardian_print_swipe_thrash(fun):
    """
    Modify the function to add a spell to take into account the fact that swipe
    and thrash are two different spells for guardian.
    """
    import copy

    def add_spell(self, spell):
        """
        Add a spell to the context.
        """
        if (self.player.spec.simc == GUARDIAN
                and spell.simc in ['swipe', 'thrash']):
            spell_cat = copy.copy(spell)
            spell_cat.simc += '_cat'
            spell_bear = copy.copy(spell)
            spell_bear.simc += '_bear'
            fun(self, spell_cat)
            fun(self, spell_bear)
        else:
            fun(self, spell)

    return add_spell

def feral_max_energy_print_lua(fun):

    from ..objects.executions import Spell

    def print_lua(self):
        """
        Print the lua expression for the spell.
        """
        if (self.action.player.spec.simc == FERAL and self.action.properties().get('max_energy') and self.simc in 'ferocious_bite'):
            spell_fbmax = Spell(self.action, 'ferocious_bite_max_energy')
            return f'{spell_fbmax.print_lua()}'
        return fun(self)

    return print_lua

def feral_max_energy_custom_init(fun):

    from ..objects.lua import Method, LuaExpression
    from ..constants import BOOL

    def custom_init(self):
        fun(self)
        if (self.action.player.spec.simc == FERAL and self.action.properties().get('max_energy') and self.simc in 'ferocious_bite' and not self.action.action_list.pool_for_next > 0):
            self.additional_conditions.append(LuaExpression(
                        self,
                        Method('IsUsableP', type_=BOOL),
                        []))

    return custom_init
    
DECORATORS = {
    DRUID: [
        {
            'class_name': 'AstralPower',
            'method': 'value',
            'decorator': balance_astral_power_value,
        },
        {
            'class_name': 'Spell',
            'method': 'print_lua',
            'decorator': guardian_swipe_thrash_value,
        },
        {
            'class_name': 'Context',
            'method': 'add_spell',
            'decorator': guardian_print_swipe_thrash,
        },
        {
            'class_name': 'Spell',
            'method': 'print_lua',
            'decorator': feral_max_energy_print_lua,
        },
        {
            'class_name': 'Spell',
            'method': 'custom_init',
            'decorator': feral_max_energy_custom_init,
        },
    ],
}
