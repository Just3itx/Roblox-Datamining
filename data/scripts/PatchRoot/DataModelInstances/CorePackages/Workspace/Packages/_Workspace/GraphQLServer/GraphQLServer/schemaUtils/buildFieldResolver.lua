-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local GraphQL = require(GraphQLServerParent.GraphQL)
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local function getFieldResolver(arg1, arg2)
    if arg1
        and arg1.parentType
        and arg1.fieldName
        and type(arg1.parentType.name) == "string"
        and type(arg2[arg1.parentType.name]) == "table"
        and type(arg2[arg1.parentType.name][arg1.fieldName]) == "function"
    then
        return arg2[arg1.parentType.name][arg1.fieldName]
    end

    return GraphQL.defaultFieldResolver
end

local function buildFieldResolver(arg1)
    return function(arg2, arg3, arg4, arg5)
        return getFieldResolver(arg5, arg1)(arg2, arg3, arg4, arg5)
    end
end

return buildFieldResolver
