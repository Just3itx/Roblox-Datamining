-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloPresenceParent = script:FindFirstAncestor("ApolloPresence").Parent

local fragments = require(ApolloPresenceParent.ApolloLocalState).fragments

local function getUserPresenceByUserId(arg1, arg2)
    return (arg1.cache:readFragment({
        id = arg1.cache:identify({ __typename = "UserPresence", id = arg2.userId }),
        fragment = fragments.userPresenceAllFields
    }))
end
return getUserPresenceByUserId
