-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local Object = require(GraphQLServerParent.LuauPolyfill).Object

local function addMockResolvers(arg1, arg2)
    local var1 = Object.assign({}, arg1, arg2)
    local query = Object.assign({}, arg1.Query or {}, arg2.Query or {})
    local mutation = Object.assign({}, arg1.Mutation or {}, arg2.Mutation or {})

    Object.assign(var1, { Query = query, Mutation = mutation })

    return var1
end

return addMockResolvers
