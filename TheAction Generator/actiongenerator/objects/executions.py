# -*- coding: utf-8 -*-
"""
Define the objects representing simc executions.

@author: skasch
"""

from .lua import (LuaNamed, LuaTyped, LuaConditions, LuaCastable,
                  LuaExpression, Literal, Method)
from ..constants import (IGNORED_EXECUTIONS, SPELL, BUFF, DEBUFF, USABLE, READY,
                         MELEE, INTERRUPT, CD, GCDAOGCD, OGCDAOGCD, NUM, BOOL,
                         FALSE, TRUE, AUTOCHECK, OPENER, ANYCASTER)
from ..database import (SPELL_INFO, COMMON)
import re

class Item(LuaNamed, LuaCastable):
    """
    The Item class, used to represent an item.
    """

    def __init__(self, action, simc):
        super().__init__(simc)
        # Castable
        LuaCastable.__init__(self)
        self.condition_method = Method('IsReady(unit)', type_=BOOL)
        self.cast_method = Method('return ')
        # Item
        self.action = action
        self.iid = ''
        # Handle case when item is defined as an Item ID
        try:
            int(simc)
            self.unnamed_item = True
            self.iid = simc
            self.simc = f'item{simc}'
        except ValueError:
            self.unnamed_item = False
        self.action.context.add_item(self)

    def print_lua(self):
        """
        Print the lua representation of the item.
        """
        string1 = (f'A.{self.lua_name()}')
        string2 = string1.replace("Debuff","")
        return string2

class Potion(Item):
    """
    The Potion class, to handle the specific case of a potion.
    """

    def __init__(self, action):
        super().__init__(action, action.player.potion())
        # Castable
        self.additional_conditions = [Literal('Potion')]


class RunActionList(LuaNamed, LuaCastable):
    """
    The class to handle a run_action_string action; calls a function containing
    the code for the speficic ActionList called.
    """

    def __init__(self, action, simc):
        super().__init__(simc)
        LuaCastable.__init__(self)
        self.action = action
        self.has_property = self.action.player.action_list_property
        self.cast_template = 'return {}(unit);'

    def cast(self):
        return Literal(self.lua_name() + '()')


class CallActionList(LuaNamed, LuaCastable):
    """
    The class to handle a call_action_string action; calls a function containing
    the code for the speficic ActionList called.
    """

    def __init__(self, action, simc):
        super().__init__(simc)
        LuaCastable.__init__(self)
        self.action = action
        self.has_property = self.action.player.action_list_property
        self.cast_template = ('if {}(unit) then\n'
                              '    return true\n' 
                              'end')

    def cast(self):
        return Literal(self.lua_name() + '()')


class Variable(LuaNamed, LuaTyped, LuaCastable):
    """
    The class to handle a variable action; this creates a new variable as a
    local function to compute a value used afterwards.
    """

    def __init__(self, action, simc):
        super().__init__(simc)
        LuaCastable.__init__(self)
        self.action = action
        self.type_ = NUM
        try:
            self.default = action.properties().get('default', '0')
            action.context.add_variable(self)
        except AttributeError:
            self.default = '0'

    def lua_name(self):
        return f'Var{super().lua_name()}'

    def print_cast(self):
        return f'{self.lua_name()}'

    def print_lua(self):
        """
        Print the lua representation of the variable in expressions.
        """
        return self.print_cast()


class CancelBuff(LuaNamed, LuaCastable):
    """
    The class to handle a variable action; this creates a new variable as a
    local function to compute a value used afterwards.
    """

    def __init__(self, action, simc):
        super().__init__(simc)
        # Castble
        LuaCastable.__init__(self)
        self.cast_method = Method('')
        self.cast_template = 'Player:CancelBuff(A.{}Buff:Info())'
        # Main
        self.action = action
        self.buff = Spell(action, simc, type_=BUFF)

    def print_lua(self):
        """
        Print the lua expression for the buff to cancel.
        """
        """return self.buff.print_lua()"""
        return f'{super().lua_name()}'

class Spell(LuaNamed, LuaCastable):
    """
    Represents a spell; it can be either a spell, a buff or a debuff.
    """

    TYPE_SUFFIX = {
        SPELL: '',
        BUFF: 'Buff',
        DEBUFF: 'Debuff',
    }

    def __init__(self, action, simc, type_=SPELL):
        super().__init__(simc)
        self.type_ = type_
        # Castable
        LuaCastable.__init__(self)
        self.action = action
        self.has_property = self.action.player.spell_property
        self.custom_init()
        # Main
        self.ignored = simc in IGNORED_EXECUTIONS
        if not self.ignored:
            self.action.context.add_spell(self)

    def custom_init(self):
        """
		Azerite Methods exception
        """
        if (f'{super().lua_name()}' == 'MemoryofLucidDreams'
            or f'{super().lua_name()}' == 'RippleInSpace'		
            or f'{super().lua_name()}' == 'BloodoftheEnemy'		
            or f'{super().lua_name()}' == 'FocusedAzeriteBeam'		
            or f'{super().lua_name()}' == 'PurifyingBlast'		
            or f'{super().lua_name()}' == 'TheUnboundForce'		
            or f'{super().lua_name()}' == 'GuardianofAzeroth'
            or f'{super().lua_name()}' == 'WorldveinResonance'		
            or f'{super().lua_name()}' == 'ConcentratedFlame'						
        ):
            self.condition_method = Method('AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth', type_=BOOL)
            """
            Racials Methods exception
            """
        elif (f'{super().lua_name()}' == 'ArcaneTorrent'
            or f'{super().lua_name()}' == 'BloodFury'		
            or f'{super().lua_name()}' == 'Fireblood'		
            or f'{super().lua_name()}' == 'AncestralCall'		
            or f'{super().lua_name()}' == 'Berserking'		
            or f'{super().lua_name()}' == 'ArcanePulse'		
            or f'{super().lua_name()}' == 'QuakingPalm'
            or f'{super().lua_name()}' == 'Haymaker'		
            or f'{super().lua_name()}' == 'BullRush'
            or f'{super().lua_name()}' == 'WarStomp'		
            or f'{super().lua_name()}' == 'GiftofNaaru'
            or f'{super().lua_name()}' == 'Shadowmeld'		
            or f'{super().lua_name()}' == 'Stoneform'				
        ):
            self.condition_method = Method('AutoRacial(unit) and Racial', type_=BOOL)
        elif self.action.player.spell_property(self, USABLE):
            self.condition_method = Method('IsReady(unit)', type_=BOOL)
        elif self.action.player.spell_property(self, READY):
            self.condition_method = Method('IsReady(unit)', type_=BOOL)
        else:
            self.condition_method = Method('IsReady(unit)', type_=BOOL)

        if (self.type_ is SPELL
            and (self.action.player.spell_property(self, AUTOCHECK)
                 or self.action.action_list.name.simc == 'precombat')):
            if self.action.player.spell_property(self, BUFF):
                self.add_auto_check(BUFF)
            elif self.action.player.spell_property(self, DEBUFF):
                self.add_auto_check(DEBUFF)
            if self.action.player.spell_property(self, OPENER):
                self.additional_conditions.append(
                    Literal('inCombat and Unit(unit):IsExists() and unit ~= "mouseover"')
                )

    def add_auto_check(self, type_, method=None):
        if not method:
            method = f'Has{type_.title()}sDown'
        aura_action = Spell(self.action, self.simc, type_=type_)
        if self.action.player.spell_property(self, ANYCASTER):
            self.additional_conditions.append(
                LuaExpression(self.action.player,
                            Method(method, type_=BOOL),
                            [aura_action, Literal(TRUE)])
            )
        else:
            self.additional_conditions.append(
                LuaExpression(self.action.player,
                            Method(method, type_=BOOL),
                            [aura_action])
            )

    def lua_name(self):
        return f'{super().lua_name()}{self.TYPE_SUFFIX[self.type_]}'

    def print_cast(self):
        """
        Print the lua code of what to do when casting the action.
        """
        if self.ignored:
            return ''
        return super().print_cast()

    def print_lua(self):
        """
        Print the lua expression for the spell.
        """
        fullstring = (f'A.{self.lua_name()}')
        substring = "Buff"
        substring2 = "Debuff"
        substring3 = "DeBuffDebuff"		
        if re.search(substring, fullstring):			
            string1 = f'A.{self.lua_name()}.ID, true'
        elif re.search(substring2, fullstring):			
            string1 = f'A.{self.lua_name()}.ID, true'
        else:
            string1 = f'A.{self.lua_name()}'
        if re.search(substring3, string1):
            string2 = string1.replace("DeBuffDebuff","Debuff")
        else:
            string2 = string1
  
        return string2
