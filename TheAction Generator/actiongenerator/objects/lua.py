# -*- coding: utf-8 -*-
"""
Define the objects representing lua specific items.

@author: skasch
"""

from inspect import getargspec
import re
from ..abstract.decoratormanager import Decorable
from ..constants import WORD_REPLACEMENTS, TRUE, FALSE, BOOL, NUM, CD, INTERRUPT


class LuaNamed(Decorable):
    """
    An abstract class for elements whose named in lua can be parsed from its
    name in simc.
    """

    def __init__(self, simc):
        self.simc = simc

    def lua_name(self):
        """
        Return the HeroRotation name of the spell.
        """
        lua_words = [w.title() for w in self.simc.split('_')]
        lua_words = [WORD_REPLACEMENTS.get(w, w) for w in lua_words]
        lua_string = ''.join(lua_words)
        # Recapitalize first letter if lowered

        lua_string = re.sub('([a-zA-Z])', lambda x: x.groups()[0].upper(), lua_string, 1)

        return lua_string

class LuaTyped(Decorable):
    """
    An abstract class for elements who have a lua type.
    """

    def __init__(self, type_=None):
        if type_ is None:
            self.type_ = NUM
        else:
            self.type_ = type_

    def lua_type(self):
        """
        Return the lua type of the object.
        """
        return self.type_


class LuaConditions(Decorable):
    """
    The class to handle a lua condition list.
    """

    def __init__(self, *condition_list):
        self.condition_list = list(cond for cond in condition_list if cond)

    def add_condition(self, condition):
        if condition:
            self.condition_list.append(condition)
    
    def custom_conditions(self, execution, has_property):
        """
        Adds custom condition tests for situational conditions, such as
        interrupts or CDs. This is the generic method for any execution.
        """
        if has_property(execution, CD):
            self.add_condition(LuaExpression(None, Method('A.BurstIsON(unit)')))
        if has_property(execution, INTERRUPT):
            self.add_condition(Literal('Action.GetToggle.InterruptEnabled'))
        
    
    def print_lua(self):
        return ' and '.join(condition.print_lua()
                            for condition in self.condition_list)


class LuaCastable(Decorable):
    """
    The class for castable elements: items and spells.
    """

    cid = 0 

    def __init__(self, cast_method=None, cast_args=None, cast_template=None):
        self.cid = LuaCastable.cid
        LuaCastable.cid += 1
        self.condition_method = None
        self.condition_args = []
        self.additional_conditions = []
        self.has_property = lambda execution, tag: False
        self.cast_method = cast_method or Method('return ')
        self.cast_args = [self] if cast_args is None else cast_args
        self.cast_template = cast_template or '{}:Show(icon)'

    def main_condition(self):
        """
        Return the LuaExpression of the default condition.
        """
        if self.condition_method is None:
            return None
        return LuaExpression(self, self.condition_method, self.condition_args)

    def conditions(self):
        conditions = LuaConditions(self.main_condition(),
                                   *self.additional_conditions)
        conditions.custom_conditions(self, self.has_property)
        return conditions

    def cast(self):
        """
        Return the LuaExpression to cast the action.
        """
        return LuaExpression(None, self.cast_method, self.cast_args)

    def return_string(self):
        """
        Return the return string of the cast.
        """
        try:
            return_string = [self.simc]
        except AttributeError:
            return_string = []
        return " ".join(return_string + [str(self.cid)])

    def print_cast(self):
        """
        Print the lua code of what to do when casting the action.
        """
        string1 = self.cast().print_lua()
        string2 = string1.replace('(', '')
        string2 = string2.replace(')', '')
        return self.cast_template.format(string2,
                                         self.return_string())


class LuaTemplated(LuaTyped):
    """
    Abstract class representing a generic lua expression in the form:
    object:method(args)
    """

    def __init__(self, **kwargs):
        self.lua_keys = []
        self.template = ''
        self.attributes = kwargs
        try:
            super().__init__(self.type_)
        except AssertionError:
            super().__init__()

    def print_lua(self):
        """
        Print the lua code for the composite object.
        """
        return self.template.format(**self.attributes)


class LuaComparison(LuaTyped):
    """"
    Abstract class representing a generic lua comparison of the form:
    exp1 <comp> exp2.
    """

    def __init__(self, exp1, exp2, symbol):
        self.exp1 = exp1
        self.exp2 = exp2
        self.symbol = symbol
        super().__init__(type_=BOOL)

    def print_lua(self):
        """
        Print the lua code for the comparison.
        """
        return (f'({self.exp1.print_lua()} {self.symbol} '
                f'{self.exp2.print_lua()})')


class LuaExpression(LuaTemplated):
    """
    Abstract class representing a generic lua expression in the form:
    object:method(args)
    """

    def __init__(self, object_, method, args=[], type_=None):
        if type_ is not None:
            self.type_ = type_
        else:
            try:
                self.type_ = method.type_
            except AttributeError:
                self.type_ = None
        lua_object = object_.print_lua() if object_ else ''
        link = ':' if object_ else ''
        lua_args = ', '.join(arg.print_lua() for arg in args)
        LuaTemplated.__init__(self,
                              object_=lua_object,
                              link=link,
                              method=method.print_lua(),
                              args=lua_args)
        if not args:
            self.template = '{object_}{link}{method}'
        else:
            self.template = '{object_}{link}{method}({args})'

class LuaArray(LuaTemplated):
    """
    Abstract class representing a lua array call of the form: object:array[idx]
    """

    def __init__(self, object_, method, index, type_=None):
        if type_ is not None:
            self.type_ = type_
        else:
            try:
                self.type_ = method.type_
            except AttributeError:
                self.type_ = None
        lua_object = object_.print_lua() if object_ else ''
        link = ':' if object_ else ''
        LuaTemplated.__init__(self,
                              object_=lua_object,
                              link=link,
                              method=method.print_lua(),
                              index=str(index))
        self.template = '{object_}{link}{method}' #({index}, 5, 10)'


class LuaRange(LuaArray):
    """
    Abstract class representing a lua call for a range check:
    Cache.EnemiesCount[idx]
    """

    def __init__(self, condition, range_, type_=None):
        condition.parent_action.context.add_range(range_)
        LuaArray.__init__(self,
                          object_=None,
                          method=Method(f'MultiUnits:GetByRangeInCombat({range_}, 5, 10)'),
                          index=range_,
                          type_=type_)

class Method(Decorable):
    """
    Represent a lua method.
    """

    def __init__(self, name, type_=None):
        self.name = name
        self.type_ = type_

    def print_lua(self):
        """
        Print the method.
        """
        return self.name


class Literal(LuaTemplated, LuaNamed):
    """
    Represent a literal expression (a value) as a string.
    """

    def __init__(self, simc=None, convert=False, quoted=False, type_=None):
        if simc is not None:
            LuaNamed.__init__(self, simc)
        self.convert = convert
        self.quoted = quoted
        if type_ is not None:
            self.type_ = type_
        else:
            self.type_ = BOOL if self.simc in (TRUE, FALSE) else NUM
        LuaTemplated.__init__(self, value=self.get_value())
        if self.quoted:
            self.template = '"{value}"'
        else:
            self.template = '{value}'

    def get_value(self):
        """
        Return the lua value for the literal.
        """
        if self.convert:
            return self.lua_name()
        return str(self.simc)


class BuildExpression(Decorable):
    """
    Build an expression from a call.
    """

    def __init__(self, call, model=LuaExpression):
        self.model = model
        self.content = None
        call = 'ready' if call == 'up' else call
        if call:
            getattr(self, call)()
        self.apply_model()

    def apply_model(self):
        """
        Call the right builder depending on the model.
        """
        # getargspec returns the trace of the model. For example, for LuaRange:
        # arg_spec.args = ['self', 'condition', 'range_', 'type_']
        # arg_spec.defaults = (None,)
        # As defaults are for the last args, we know type_=None by default.
        try:
            arg_spec = getargspec(self.model)
            arg_names = arg_spec.args[1:-len(arg_spec.defaults)]
            kwarg_names = arg_spec.args[-len(arg_spec.defaults):]
            self.try_builder(self.model, arg_names, kwarg_names)
        except AttributeError:
            raise AttributeError(f'The model {self.model.__name__} '
                                 'is invalid.')

    def try_builder(self, model, arg_names, kwarg_names):
        """
        Try to build the model. model is a class defining a print_lua method,
        initialized with the attributes of self named after arg_names and
        kwarg_names. A typical example would be a LuaExpression method built
        with self.object_, self.method and self.args.
        """
        try:
            args = [getattr(self, arg_name) for arg_name in arg_names]
            kwargs = {kwarg_name: getattr(self, kwarg_name)
                      for kwarg_name in kwarg_names
                      if hasattr(self, kwarg_name)}
            self.content = model(*args, **kwargs)
        except AttributeError:
            missing_attr = [arg_name for arg_name in arg_names
                            if not hasattr(self, arg_name)]
            error_msg = (f'The {model.__name__} model did not have the '
                         f'following attributes: {", ".join(missing_attr)}')
            raise AttributeError(error_msg)

    @classmethod
    def build(cls, *args, **kwargs):
        """
        Build the expression and return its content.
        """
        obj = cls(*args, **kwargs)
        return obj.content
