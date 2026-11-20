-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local luaUtils = scriptParentParent.luaUtils
local null = require(luaUtils.null)

local language = scriptParentParent.language
local type = scriptParentParent.type

local visitor = require(language.visitor)
local ast = require(language.ast)

local Kind = require(language.kinds).Kind
local isNode = ast.isNode
local getVisitFn = visitor.getVisitFn

local _schema = require(type.schema)

local _directives = require(type.directives)

local definition = require(type.definition)

local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType
local isListType = definition.isListType
local isCompositeType = definition.isCompositeType
local isInputType = definition.isInputType
local isOutputType = definition.isOutputType
local getNullableType = definition.getNullableType
local getNamedType = definition.getNamedType
local introspection = require(type.introspection)
local SchemaMetaFieldDef = introspection.SchemaMetaFieldDef
local TypeMetaFieldDef = introspection.TypeMetaFieldDef
local TypeNameMetaFieldDef = introspection.TypeNameMetaFieldDef

local typeFromAST = require(scriptParentParent.utilities.typeFromAST).typeFromAST

local function unwrapNull(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return if arg1 == null then nil else arg1
end

local TypeInfo = ({})
local tbl2 = { __index = TypeInfo }

local getFieldDef = nil

function TypeInfo.new(_schema2, _getFieldDef: ((...any) -> (...any))?, arg1)
    local self = (setmetatable({}, tbl2))
    self._schema = _schema2
    self._typeStack = {}
    self._parentTypeStack = {}
    self._inputTypeStack = {}
    self._fieldDefStack = {}
    self._defaultValueStack = {}
    self._directive = nil
    self._argument = nil
    self._enumValue = nil
    self._getFieldDef = _getFieldDef or getFieldDef

    if arg1 then
        if isInputType(arg1) then
            table.insert(self._inputTypeStack, arg1)
        end
        if isCompositeType(arg1) then
            table.insert(self._parentTypeStack, arg1)
        end
        if isOutputType(arg1) then
            table.insert(self._typeStack, arg1)
        end
    end

    return self
end

function TypeInfo:getType()
    if #self._typeStack > 0 then
        return unwrapNull(self._typeStack[#self._typeStack])
    end
    return nil
end

function TypeInfo:getParentType()
    if #self._parentTypeStack > 0 then
        return unwrapNull(self._parentTypeStack[#self._parentTypeStack])
    end
    return nil
end

function TypeInfo:getInputType()
    if #self._inputTypeStack > 0 then
        return unwrapNull(self._inputTypeStack[#self._inputTypeStack])
    end
    return nil
end

function TypeInfo:getParentInputType()
    if #self._inputTypeStack > 1 then
        return unwrapNull(self._inputTypeStack[#self._inputTypeStack - 1])
    end
    return nil
end

function TypeInfo:getFieldDef()
    if #self._fieldDefStack > 0 then
        return unwrapNull(self._fieldDefStack[#self._fieldDefStack])
    end
    return nil
end

function TypeInfo:getDefaultValue()
    if #self._defaultValueStack > 0 then
        return unwrapNull(self._defaultValueStack[#self._defaultValueStack])
    end
    return nil
end

function TypeInfo:getDirective()
    return self._directive
end

function TypeInfo:getArgument()
    return self._argument
end

function TypeInfo:getEnumValue()
    return self._enumValue
end

function TypeInfo:enter(arg1)
    local _schema2 = self._schema

    local kind = arg1.kind
    if kind == Kind.SELECTION_SET then
        local namedType = getNamedType(self:getType())
        local _parentTypeStack = self._parentTypeStack

        if not isCompositeType(namedType) then
            namedType = null
        end

        table.insert(_parentTypeStack, namedType)
        return
    end
    if kind == Kind.FIELD then
        local parentType = self:getParentType()

        local type2 = nil
        local var1

        if parentType then
            var1 = self._getFieldDef(_schema2, parentType, arg1)
            if var1 then
                type2 = var1.type
            end
        else
            var1 = nil
        end

        table.insert(self._fieldDefStack, var1 or null)

        local _typeStack = self._typeStack
        if not isOutputType(type2) then
            type2 = null
        end

        table.insert(_typeStack, type2)
        return
    end

    if kind == Kind.DIRECTIVE then
        self._directive = _schema2:getDirective(arg1.name.value)
        return
    end
    if kind == Kind.OPERATION_DEFINITION then
        local var1 = nil
        local operation = arg1.operation
        if operation == "query" then
            var1 = _schema2:getQueryType()
        elseif operation == "mutation" then
            var1 = _schema2:getMutationType()
        elseif operation == "subscription" then
            var1 = _schema2:getSubscriptionType()
        end

        local _typeStack = self._typeStack
        if not isObjectType(var1) then
            var1 = null
        end

        table.insert(_typeStack, var1)
        return
    end

    if kind == Kind.INLINE_FRAGMENT or kind == Kind.FRAGMENT_DEFINITION then
        local typeCondition = arg1.typeCondition
        local var1 = if typeCondition then typeFromAST(_schema2, typeCondition) else getNamedType(self:getType())
        local _typeStack = self._typeStack
        if not isOutputType(var1) then
            var1 = null
        end

        table.insert(_typeStack, var1)
        return
    end

    if kind == Kind.VARIABLE_DEFINITION then
        local var1 = typeFromAST(_schema2, arg1.type)

        local _inputTypeStack = self._inputTypeStack
        if not isInputType(var1) then
            var1 = null
        end

        table.insert(_inputTypeStack, var1)
        return
    end

    if kind == Kind.ARGUMENT then
        local type2 = nil
        local var1 = self:getDirective() or self:getFieldDef()
        local var2

        if var1 then
            var2 = Array.find(var1.args, function(arg2): boolean
                return arg2.name == arg1.name.value
            end)
            if var2 then
                type2 = var2.type
            end
        else
            var2 = nil
        end

        self._argument = var2
        table.insert(self._defaultValueStack, if var2 then var2.defaultValue else null)
        local _inputTypeStack = self._inputTypeStack

        if not isInputType(type2) then
            type2 = null
        end

        table.insert(_inputTypeStack, type2)
        return
    end
    if kind == Kind.LIST then
        local nullableType = getNullableType(self:getInputType())
        if isListType(nullableType) then
            nullableType = nullableType.ofType
        end
        table.insert(self._defaultValueStack, null)
        local _inputTypeStack = self._inputTypeStack

        if not isInputType(nullableType) then
            nullableType = null
        end

        table.insert(_inputTypeStack, nullableType)
        return
    end
    if kind ~= Kind.OBJECT_FIELD then
        if kind == Kind.ENUM then
            local namedType = getNamedType(self:getInputType())

            self._enumValue = if isEnumType(namedType) then namedType:getValue(arg1.value) else nil
        end

        return
    end

    local namedType = getNamedType(self:getInputType())
    local type2 = nil
    local var1

    if isInputObjectType(namedType) then
        var1 = namedType:getFields():get(arg1.name.value)
        if var1 then
            type2 = var1.type
        end
    else
        var1 = nil
    end

    table.insert(self._defaultValueStack, if var1 then var1.defaultValue else null)

    local _inputTypeStack = self._inputTypeStack
    if not isInputType(type2) then
        type2 = null
    end

    table.insert(_inputTypeStack, type2)
end

function TypeInfo:leave(arg1)
    local kind = arg1.kind
    if kind == Kind.SELECTION_SET then
        table.remove(self._parentTypeStack)
    elseif kind == Kind.FIELD then
        table.remove(self._fieldDefStack)
        table.remove(self._typeStack)
    elseif kind == Kind.DIRECTIVE then
        self._directive = nil
    elseif kind == Kind.OPERATION_DEFINITION or kind == Kind.INLINE_FRAGMENT or kind == Kind.FRAGMENT_DEFINITION then
        table.remove(self._typeStack)
    elseif kind == Kind.VARIABLE_DEFINITION then
        table.remove(self._inputTypeStack)
    elseif kind == Kind.ARGUMENT then
        self._argument = nil
        table.remove(self._defaultValueStack)
        table.remove(self._inputTypeStack)
    elseif kind == Kind.LIST or kind == Kind.OBJECT_FIELD then
        table.remove(self._defaultValueStack)
        table.remove(self._inputTypeStack)
    elseif kind == Kind.ENUM then
        self._enumValue = nil
    end
end

getFieldDef = function(arg1, arg2, arg3)
    local value = arg3.name.value

    if value == SchemaMetaFieldDef.name and arg1:getQueryType() == arg2 then
        return SchemaMetaFieldDef
    elseif value == TypeMetaFieldDef.name and arg1:getQueryType() == arg2 then
        return TypeMetaFieldDef
    elseif value == TypeNameMetaFieldDef.name and isCompositeType(arg2) then
        return TypeNameMetaFieldDef
    elseif isObjectType(arg2) or isInterfaceType(arg2) then
        return arg2:getFields():get(value)
    end
    return nil
end

return {
    TypeInfo = TypeInfo,
    visitWithTypeInfo = function(tbl3, arg1)
        return {
            enter = function(_, arg2, ...)
                tbl3:enter(arg2)
                local visitFn = getVisitFn(arg1, arg2.kind, false)

                if not visitFn then
                    return nil
                end

                local var1 = visitFn(arg1, arg2, ...)
                if var1 ~= nil then
                    tbl3:leave(arg2)
                    if isNode(var1) then
                        tbl3:enter(var1)
                    end
                end
                return var1
            end,
            leave = function(_, arg2, ...)
                local visitFn = getVisitFn(arg1, arg2.kind, true)
                local var1 = if visitFn then visitFn(arg1, arg2, ...) else nil
                tbl3:leave(arg2)
                return var1
            end
        }
    end
}
