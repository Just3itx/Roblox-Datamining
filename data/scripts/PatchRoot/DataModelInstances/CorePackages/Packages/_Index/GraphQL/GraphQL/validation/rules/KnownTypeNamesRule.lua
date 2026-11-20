-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local jsutils = scriptParentParentParent.jsutils

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object

local didYouMean = require(jsutils.didYouMean).didYouMean
local suggestionList = require(jsutils.suggestionList).suggestionList
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local predicates = require(language.predicates)
local isTypeDefinitionNode = predicates.isTypeDefinitionNode
local isTypeSystemDefinitionNode = predicates.isTypeSystemDefinitionNode
local isTypeSystemExtensionNode = predicates.isTypeSystemExtensionNode
local type = scriptParentParentParent.type
local specifiedScalarTypes = require(type.scalars).specifiedScalarTypes
local introspectionTypes = require(type.introspection).introspectionTypes

local module = {}

local var1 = nil
local isStandardTypeName = nil
local isSDLNode = nil

function module.KnownTypeNamesRule(arg1)
    local schema = arg1:getSchema()

    local map = Map.new()
    if schema then
        map = schema:getTypeMap()
    end

    local tbl1 = {}
    for _, definition in ipairs(arg1:getDocument().definitions) do
        if isTypeDefinitionNode(definition) then
            tbl1[definition.name.value] = true
        end
    end

    local var2 = Array.concat(map:keys(), Object.keys(tbl1))

    return {
        NamedType = function(_, arg2, _, arg3, _, arg4)
            local value = arg2.name.value

            if map:get(value) or tbl1[value] then
                return
            end

            local var3 = arg4[3] or arg3
            local var4 = not (var3 == nil) and isSDLNode(var3)

            if var4 and isStandardTypeName(value) then
                return
            end

            local var5 = suggestionList(value, var4 and Array.concat(var1, var2) or var2)

            arg1:reportError(GraphQLError.new(("Unknown type \"%s\"."):format(value) .. didYouMean(var5), arg2))
        end
    }
end

var1 = Array.map(Array.concat(specifiedScalarTypes, introspectionTypes), function(arg1)
    return arg1.name
end)

isStandardTypeName = function(str1: string): boolean
    return Array.indexOf(var1, str1) ~= -1
end

isSDLNode = function(arg1)
    return not Array.isArray(arg1) and (isTypeSystemDefinitionNode(arg1) or isTypeSystemExtensionNode(arg1))
end

return module
