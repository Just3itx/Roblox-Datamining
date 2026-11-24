-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local Object = require(GraphQLServerParent.LuauPolyfill).Object

local function buildRootValue(arg1)
    local query = arg1.Query or {}
    local mutation = arg1.Mutation or {}
    return (Object.assign({}, query, mutation))
end

return buildRootValue
