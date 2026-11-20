-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local jsutils = scriptParentParentParent.jsutils
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local inspect = require(jsutils.inspect).inspect
local invariant = require(jsutils.invariant).invariant
local didYouMean = require(jsutils.didYouMean).didYouMean
local suggestionList = require(jsutils.suggestionList).suggestionList
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local Kind = require(language.kinds).Kind
local isTypeDefinitionNode = require(language.predicates).isTypeDefinitionNode
local definition = require(scriptParentParentParent.type.definition)
local isScalarType = definition.isScalarType
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType

local module = {}

local var1 = nil
local typeToExtKind = nil
local extensionKindToTypeName = nil

function module.PossibleTypeExtensionsRule(arg1)
    local schema = arg1:getSchema()
    local tbl1 = {}

    for _, definition2 in ipairs(arg1:getDocument().definitions) do
        if isTypeDefinitionNode(definition2) then
            tbl1[definition2.name.value] = definition2
        end
    end

    local function checkExtension(arg2)
        local value = arg2.name.value
        local var2 = tbl1[value]
        local type = if schema then schema:getType(value) else nil
        local var3 = nil

        if var2 then
            var3 = var1[var2.kind]
        elseif type then
            var3 = typeToExtKind(type)
        end

        if not var3 then
            local var4 = Object.keys(tbl1)
            if schema then
                var4 = Array.concat(var4, schema:getTypeMap():keys())
            end

            local var5 = suggestionList(value, var4)
            arg1:reportError(
                GraphQLError.new(("Cannot extend type \"%s\" because it is not defined."):format(value) .. didYouMean(var5), arg2.name)
            )
            return
        end

        if var3 == arg2.kind then
            return
        end

        local var4 = extensionKindToTypeName(arg2.kind)
        local var5 = arg1
        local new = GraphQLError.new
        local str1 = ("Cannot extend non-%s type \"%s\"."):format(var4, value)
        if var2 then
            arg2 = { var2, arg2 } or arg2
        end

        var5:reportError(new(str1, arg2))
    end

    local function func1(_, ...)
        return checkExtension(...)
    end
    return {
        ScalarTypeExtension = func1,
        ObjectTypeExtension = func1,
        InterfaceTypeExtension = func1,
        UnionTypeExtension = func1,
        EnumTypeExtension = func1,
        InputObjectTypeExtension = func1
    }
end

var1 = {
    [Kind.SCALAR_TYPE_DEFINITION] = Kind.SCALAR_TYPE_EXTENSION,
    [Kind.OBJECT_TYPE_DEFINITION] = Kind.OBJECT_TYPE_EXTENSION,
    [Kind.INTERFACE_TYPE_DEFINITION] = Kind.INTERFACE_TYPE_EXTENSION,
    [Kind.UNION_TYPE_DEFINITION] = Kind.UNION_TYPE_EXTENSION,
    [Kind.ENUM_TYPE_DEFINITION] = Kind.ENUM_TYPE_EXTENSION,
    [Kind.INPUT_OBJECT_TYPE_DEFINITION] = Kind.INPUT_OBJECT_TYPE_EXTENSION
}

typeToExtKind = function(arg1)
    if isScalarType(arg1) then
        return Kind.SCALAR_TYPE_EXTENSION
    end
    if isObjectType(arg1) then
        return Kind.OBJECT_TYPE_EXTENSION
    end
    if isInterfaceType(arg1) then
        return Kind.INTERFACE_TYPE_EXTENSION
    end
    if isUnionType(arg1) then
        return Kind.UNION_TYPE_EXTENSION
    end
    if isEnumType(arg1) then
        return Kind.ENUM_TYPE_EXTENSION
    end

    if isInputObjectType(arg1) then
        return Kind.INPUT_OBJECT_TYPE_EXTENSION
    end

    invariant(false, "Unexpected type: " .. inspect(arg1))

    return nil
end

extensionKindToTypeName = function(arg1): string
    if arg1 == Kind.SCALAR_TYPE_EXTENSION then
        return "scalar"
    end

    if arg1 == Kind.OBJECT_TYPE_EXTENSION then
        return "object"
    end

    if arg1 == Kind.INTERFACE_TYPE_EXTENSION then
        return "interface"
    end

    if arg1 == Kind.UNION_TYPE_EXTENSION then
        return "union"
    end

    if arg1 == Kind.ENUM_TYPE_EXTENSION then
        return "enum"
    end

    if arg1 == Kind.INPUT_OBJECT_TYPE_EXTENSION then
        return "input object"
    end

    invariant(false, "Unexpected kind: " .. inspect(arg1))

    return ""
end

return module
