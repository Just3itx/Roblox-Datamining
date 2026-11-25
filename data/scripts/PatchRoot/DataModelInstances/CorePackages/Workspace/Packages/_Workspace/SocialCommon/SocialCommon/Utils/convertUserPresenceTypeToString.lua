-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local PresenceType = require(SocialCommonParent.LuaSocialLibrariesDeps).RoduxPresence.config({ keyPath = "SocialCommon.Presence" }).Enums.PresenceType

return function(arg1): string
    if arg1 == PresenceType.Online then
        return "Online"
    end

    if arg1 == PresenceType.InStudio then
        return "InStudio"
    end

    if arg1 == PresenceType.InGame then
        return "InGame"
    end

    return "Offline"
end
