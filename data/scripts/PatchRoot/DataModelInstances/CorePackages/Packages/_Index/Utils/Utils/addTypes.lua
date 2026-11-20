-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}

local GraphQL = require(scriptParentParent.GraphQL)
local GraphQLSchema = GraphQL.GraphQLSchema

local isNamedType = GraphQL.isNamedType
local isDirective = GraphQL.isDirective

local getObjectTypeFromTypeMap = require(script.Parent.getObjectTypeFromTypeMap).getObjectTypeFromTypeMap
local rewireTypes = require(script.Parent.rewire).rewireTypes

local Map = LuauPolyfill.Map

function module.addTypes(arg1, arg2)
    local var1 = arg1:toConfig()

    local map = Map.new()
    for _, value in var1.types do
        map:set(value.name, value)
    end

    local tbl1 = {}

    for _, value in var1.directives do
        local name = value.name
        tbl1[tostring(name)] = value
    end
    for _, value in arg2 do
        if Boolean.toJSBoolean(isNamedType(value)) then
            map:set(value.name, value)
        elseif Boolean.toJSBoolean(isDirective(value)) then
            tbl1[value.name] = value
        end
    end

    local var2 = rewireTypes(map, (Object.values(tbl1)))
    local typeMap = var2.typeMap
    local directives = var2.directives

    return GraphQLSchema.new(
        Object.assign({}, var1, {
            query = getObjectTypeFromTypeMap(typeMap, arg1:getQueryType()),
            mutation = getObjectTypeFromTypeMap(typeMap, arg1:getMutationType()),
            subscription = getObjectTypeFromTypeMap(typeMap, arg1:getSubscriptionType()),
            types = typeMap:values(),
            directives = directives
        })
    )
end

return module
