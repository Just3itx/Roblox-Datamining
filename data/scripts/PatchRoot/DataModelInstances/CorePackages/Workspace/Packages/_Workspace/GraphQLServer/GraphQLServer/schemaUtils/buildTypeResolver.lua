-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local _GraphQL = require(GraphQLServerParent.GraphQL)
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local function buildTypeResolver(arg1)
    return function(arg2, arg3, arg4, arg5)
        local var1 = arg1[arg5.name]
        if type(var1) == "table" and type(var1.__resolveType) == "function" then
            return var1.__resolveType(arg2, arg3, arg4, arg5)
        end
        return arg5.name
    end
end

return buildTypeResolver
