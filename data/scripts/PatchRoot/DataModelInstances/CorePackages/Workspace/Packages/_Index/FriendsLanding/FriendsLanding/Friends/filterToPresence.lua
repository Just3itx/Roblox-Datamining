-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local PresenceType = require(FriendsLanding.dependencies).RoduxPresence.Enums.PresenceType
local filterStates = require(FriendsLanding.Friends.filterStates)

return function(arg1)
    if arg1 == filterStates.InExperience then
        return { PresenceType.InGame, PresenceType.InStudio }
    end

    if arg1 == filterStates.Offline then
        return { PresenceType.Offline }
    end

    if arg1 == filterStates.Online then
        return { PresenceType.Online, PresenceType.InStudio, PresenceType.InGame }
    end

    return {
        PresenceType.Online,
        PresenceType.InStudio,
        PresenceType.InGame,
        PresenceType.Offline
    }
end
