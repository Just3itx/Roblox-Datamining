-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Map = LuauPolyfill.Map

local jsutils = scriptParentParent.jsutils
local _ObjMap = require(jsutils.ObjMap)

local language = scriptParentParent.language
local Kind = require(language.kinds).Kind
local visit = require(language.visitor).visit

local _ast = require(language.ast)

local _GraphQLError = require(scriptParentParent.error.GraphQLError)

local TypeInfo = require(scriptParentParent.utilities.TypeInfo)
local TypeInfo2 = TypeInfo.TypeInfo
local visitWithTypeInfo = TypeInfo.visitWithTypeInfo

local _schema = require(scriptParentParent.type.schema)

local _directives = require(scriptParentParent.type.directives)

local _definition = require(scriptParentParent.type.definition)

local ASTValidationContext = ({})
local tbl2 = { __index = ASTValidationContext }

function ASTValidationContext.new(_ast2, _onError: (...any) -> (...any))
    return (setmetatable(
        {
            _ast = _ast2,
            _fragments = nil,
            _fragmentSpreads = {},
            _recursivelyReferencedFragments = {},
            _onError = _onError
        },
        tbl2
    ))
end

function ASTValidationContext:reportError(arg1)
    self._onError(arg1)
end

function ASTValidationContext:getDocument()
    return self._ast
end

function ASTValidationContext:getFragment(str1: string)
    local _fragments

    if self._fragments then
        _fragments = self._fragments
    else
        _fragments = {}
        for _, definition in ipairs(self:getDocument().definitions) do
            if definition.kind == Kind.FRAGMENT_DEFINITION then
                _fragments[definition.name.value] = definition
            end
        end
        self._fragments = _fragments
    end
    return _fragments[str1]
end

function ASTValidationContext:getFragmentSpreads(arg1)
    local _fragmentSpread = self._fragmentSpreads[arg1] or {}
    if not self._fragmentSpreads[arg1] then
        local tbl3 = { arg1 }

        while #tbl3 ~= 0 do
            local var1 = table.remove(tbl3)
            for _, selection in ipairs(var1.selections) do
                if selection.kind == Kind.FRAGMENT_SPREAD then
                    table.insert(_fragmentSpread, selection)
                elseif selection.selectionSet then
                    table.insert(tbl3, selection.selectionSet)
                end
            end
        end

        self._fragmentSpreads[arg1] = _fragmentSpread
    end
    return _fragmentSpread
end

function ASTValidationContext:getRecursivelyReferencedFragments(arg1)
    local _recursivelyReferencedFragment = self._recursivelyReferencedFragments[arg1] or {}
    if not self._recursivelyReferencedFragments[arg1] then
        local tbl3 = { arg1.selectionSet }
        local tbl4 = ({})

        while #tbl3 ~= 0 do
            local var1 = table.remove(tbl3)
            for _, value in ipairs(self:getFragmentSpreads(var1)) do
                local value2 = value.name.value
                if tbl4[value2] == true then
                    continue
                end

                tbl4[value2] = true
                local fragment = self:getFragment(value2)
                if fragment then
                    table.insert(_recursivelyReferencedFragment, fragment)
                    table.insert(tbl3, fragment.selectionSet)
                end
            end
        end

        self._recursivelyReferencedFragments[arg1] = _recursivelyReferencedFragment
    end
    return _recursivelyReferencedFragment
end

local SDLValidationContext = (setmetatable({}, { __index = ASTValidationContext }))

local tbl3 = { __index = SDLValidationContext }

function SDLValidationContext.new(arg1, _schema2, func1: (...any) -> (...any))
    local var2 = ASTValidationContext.new(arg1, func1)
    var2._schema = _schema2
    return (setmetatable(var2, tbl3))
end

function SDLValidationContext:getSchema()
    return self._schema
end

local ValidationContext = (setmetatable({}, { __index = ASTValidationContext }))
local tbl4 = { __index = ValidationContext }

function ValidationContext.new(_schema2, arg1, _typeInfo, func1: (...any) -> (...any))
    local var3 = ASTValidationContext.new(arg1, func1)
    var3._schema = _schema2
    var3._typeInfo = _typeInfo
    var3._variableUsages = Map.new()

    var3._recursiveVariableUsages = Map.new()
    return (setmetatable(var3, tbl4))
end

function ValidationContext:getSchema()
    return self._schema
end

function ValidationContext:getVariableUsages(arg1)
    local var3 = self._variableUsages[arg1]
    if not var3 then
        local tbl5 = {}
        local typeInfo2 = TypeInfo2.new(self._schema)
        visit(arg1, visitWithTypeInfo(typeInfo2, {
            VariableDefinition = function(): boolean
                return false
            end,
            Variable = function(_, node)
                table.insert(tbl5, { node = node, type = typeInfo2:getInputType(), defaultValue = typeInfo2:getDefaultValue() })
            end
        }))

        self._variableUsages[arg1] = tbl5
        var3 = tbl5
    end

    return var3
end

function ValidationContext:getRecursiveVariableUsages(arg1)
    local var3 = self._recursiveVariableUsages[arg1]
    if not var3 then
        var3 = self:getVariableUsages(arg1)
        for _, value in ipairs(self:getRecursivelyReferencedFragments(arg1)) do
            var3 = Array.concat(var3, self:getVariableUsages(value))
        end
        self._recursiveVariableUsages[arg1] = var3
    end
    return var3
end

function ValidationContext:getType()
    return self._typeInfo:getType()
end

function ValidationContext:getParentType()
    return self._typeInfo:getParentType()
end

function ValidationContext:getInputType()
    return self._typeInfo:getInputType()
end

function ValidationContext:getParentInputType()
    return self._typeInfo:getParentInputType()
end

function ValidationContext:getFieldDef()
    return self._typeInfo:getFieldDef()
end

function ValidationContext:getDirective()
    return self._typeInfo:getDirective()
end

function ValidationContext:getArgument()
    return self._typeInfo:getArgument()
end

function ValidationContext:getEnumValue()
    return self._typeInfo:getEnumValue()
end

return {
    ASTValidationContext = ASTValidationContext,
    SDLValidationContext = SDLValidationContext,
    ValidationContext = ValidationContext
}
