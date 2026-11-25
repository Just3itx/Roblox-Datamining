-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Cryo = require(ProfilePlatformParent.Cryo)

local Presence = require(ProfilePlatform.Rodux.Presence)

local tbl1 = {
    "OFFLINE",
    "ONLINE",
    "IN_GAME",
    "IN_STUDIO"
}

local function convertFromOldPresenceModel(arg1)
    local presence = Presence.Models.Presence.new(
        Cryo.Dictionary.join(
            arg1,
            {
                userPresenceType = (table.find(tbl1, arg1.presence) or 1) - 1,
                gameId = arg1.gameInstanceId,
                lastOnline = ""
            }
        )
    )
    return Presence.Actions.ReceivedUserPresence(presence)
end

local var1 = Presence.installReducer()

return function(arg1, arg2)
    if arg2.type == "ReceivedUserPresence" and not arg2.payload then
        arg2 = convertFromOldPresenceModel(arg2)
    end

    return var1(arg1, arg2)
end
