-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloPresence = script:FindFirstAncestor("ApolloPresence")
local ApolloPresenceParent = ApolloPresence.Parent

local fragments = require(ApolloPresenceParent.ApolloLocalState).fragments

local Cryo = require(ApolloPresenceParent.Cryo)

local Formatters = require(ApolloPresence.Formatters)

local function createUserPresenceCache(arg1, arg2)
    return (arg1.cache:writeFragment({
        data = Cryo.Dictionary.join({ __typename = "UserPresence" }, Formatters.formatUserPresence(arg2)),
        fragment = fragments.userPresenceAllFields
    }))
end
return createUserPresenceCache
