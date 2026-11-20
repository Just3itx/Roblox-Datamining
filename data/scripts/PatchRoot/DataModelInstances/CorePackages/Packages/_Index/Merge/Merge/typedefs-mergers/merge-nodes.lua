-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local Map = LuauPolyfill.Map

local module = {}

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local Kind = require(scriptParentParentParent.GraphQL).Kind

local mergeType = require(script.Parent.type).mergeType
local mergeEnum = require(script.Parent.enum).mergeEnum
local mergeScalar = require(script.Parent.scalar).mergeScalar
local mergeUnion = require(script.Parent.union).mergeUnion
local mergeInputType = require(script.Parent["input-type"]).mergeInputType
local mergeInterface = require(script.Parent.interface).mergeInterface
local mergeDirective = require(script.Parent.directives).mergeDirective
local mergeSchemaDefs = require(script.Parent["schema-def"]).mergeSchemaDefs
local collectComment = require(scriptParentParentParent.Utils).collectComment

module.schemaDefSymbol = "SCHEMA_DEF_SYMBOL"

local function isNamedDefinitionNode(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return Array.indexOf(Object.keys(arg1), "name") ~= -1
end
module.isNamedDefinitionNode = isNamedDefinitionNode
function module.mergeGraphQLNodes(arg1, arg2)
    local map = Map.new()

    for _, value in arg1 do
        if Boolean.toJSBoolean(not not isNamedDefinitionNode(value)) then
            local value2 = if typeof(value.name) == "table" then value.name.value else nil

            if arg2 and Boolean.toJSBoolean(arg2.commentDescriptions) then
                collectComment(value)
            end
            if value2 ~= nil then
                if arg2 and typeof(arg2.exclusions) == "table" and Array.includes(arg2.exclusions, value2 .. ".*")
                    or arg2 and typeof(arg2.exclusions) == "table" and Array.includes(arg2.exclusions, value2)
                then
                    map:delete(value2)
                else
                    local kind = value.kind
                    if kind == Kind.OBJECT_TYPE_DEFINITION or kind == Kind.OBJECT_TYPE_EXTENSION then
                        map:set(value2, mergeType(value, map:get(value2), arg2))
                    elseif kind == Kind.ENUM_TYPE_DEFINITION or kind == Kind.ENUM_TYPE_EXTENSION then
                        map:set(value2, mergeEnum(value, map:get(value2), arg2))
                    elseif kind == Kind.UNION_TYPE_DEFINITION or kind == Kind.UNION_TYPE_EXTENSION then
                        map:set(value2, mergeUnion(value, map:get(value2), arg2))
                    elseif kind == Kind.SCALAR_TYPE_DEFINITION or kind == Kind.SCALAR_TYPE_EXTENSION then
                        map:set(value2, mergeScalar(value, map:get(value2), arg2))
                    elseif kind == Kind.INPUT_OBJECT_TYPE_DEFINITION or kind == Kind.INPUT_OBJECT_TYPE_EXTENSION then
                        map:set(value2, mergeInputType(value, map:get(value2), arg2))
                    elseif kind == Kind.INTERFACE_TYPE_DEFINITION or kind == Kind.INTERFACE_TYPE_EXTENSION then
                        map:set(value2, mergeInterface(value, map:get(value2), arg2))
                    elseif kind == Kind.DIRECTIVE_DEFINITION then
                        map:set(value2, mergeDirective(value, (map:get(value2))))
                    end
                end
            end
        elseif value.kind == Kind.SCHEMA_DEFINITION or value.kind == Kind.SCHEMA_EXTENSION then
            map:set("SCHEMA_DEF_SYMBOL", mergeSchemaDefs(value, map:get("SCHEMA_DEF_SYMBOL"), arg2))
        end
    end

    return map
end

return module
