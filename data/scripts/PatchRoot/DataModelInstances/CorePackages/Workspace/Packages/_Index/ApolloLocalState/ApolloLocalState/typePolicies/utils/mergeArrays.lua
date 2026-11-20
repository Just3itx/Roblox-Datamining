-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent
local Array = require(ApolloLocalStateParent.LuauPolyfill).Array

local function mergeArrays(_, arg1, arg2)
    arg1 = arg1 or {}
    arg2 = arg2 or {}
    if #arg2 == 0 then
        return arg1
    elseif #arg1 == 0 then
        return arg2
    end

    return Array.concat(table.clone(arg1), arg2)
end

return mergeArrays
