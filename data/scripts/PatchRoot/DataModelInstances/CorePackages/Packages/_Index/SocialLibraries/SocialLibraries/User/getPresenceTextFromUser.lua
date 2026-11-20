-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local UserModel = require(SocialLibraries.dependencies).UserModel

return function(arg1): string
    local presence = arg1.presence
    local lastLocation = arg1.lastLocation

    if presence == UserModel.PresenceType.OFFLINE then
        return "Common.Presence.Label.Offline"
    elseif presence == UserModel.PresenceType.ONLINE then
        return "Common.Presence.Label.Online"
    elseif presence == UserModel.PresenceType.IN_GAME or presence == UserModel.PresenceType.IN_STUDIO then
        if lastLocation then
            return tostring(lastLocation)
        end
        return "Common.Presence.Label.Online"
    else
        return ""
    end
end
