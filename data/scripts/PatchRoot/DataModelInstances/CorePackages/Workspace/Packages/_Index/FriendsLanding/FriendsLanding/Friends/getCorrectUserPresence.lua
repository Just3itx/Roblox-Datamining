-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local PresenceType = require(FriendsLanding.dependencies).RoduxPresence.Enums.PresenceType
local isUserInGame = require(script.Parent.isUserInGame)

return function(arg1)
    if not arg1 then
        return nil
    end
    assert(arg1, "")

    local userPresenceType = arg1.userPresenceType

    if userPresenceType == PresenceType.InGame then
        return isUserInGame(arg1) and PresenceType.InGame or PresenceType.Online
    end

    return userPresenceType
end
