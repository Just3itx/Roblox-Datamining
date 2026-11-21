-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local PresenceType = dependencies.RoduxPresence.Enums.PresenceType
local llama = dependencies.llama
local t = dependencies.t
local filterToPresence = require(FriendsLanding.Friends.filterToPresence)
local filterStates = require(FriendsLanding.Friends.filterStates)
local getCorrectUserPresence = require(FriendsLanding.Friends.getCorrectUserPresence)

return function(arg1, inactive)
    assert(t.table(arg1), "friends should be a table")
    assert(t.string(inactive), "filter should be a string")

    return llama.List.filter(arg1, function(arg2)
        if inactive == filterStates.Inactive then
            return arg2.isInactiveFriend
        end
        local var1 = filterToPresence(inactive)
        local var2 = getCorrectUserPresence(arg2) or PresenceType.Offline
        return llama.List.includes(var1, var2)
    end)
end
