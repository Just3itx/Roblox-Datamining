-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloPresence = script:FindFirstAncestor("ApolloPresence")
local ApolloPresenceParent = ApolloPresence.Parent

local fragments = require(ApolloPresenceParent.ApolloLocalState).fragments

local Formatters = require(ApolloPresence.Formatters)

local function updateUserPresenceCache(arg1, arg2)
    return (arg1.cache:writeFragment({
        id = arg1.cache:identify({ __typename = "UserPresence", id = arg2.id }),
        fragment = fragments.userPresenceAllFields,
        data = Formatters.formatUserPresence(arg2)
    }))
end
return updateUserPresenceCache
