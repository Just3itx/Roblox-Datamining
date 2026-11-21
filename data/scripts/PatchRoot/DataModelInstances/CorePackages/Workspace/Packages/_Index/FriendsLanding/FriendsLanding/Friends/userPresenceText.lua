-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local PresenceType = require(FriendsLanding.dependencies).RoduxPresence.Enums.PresenceType

return {
    [PresenceType.Offline] = "Common.Presence.Label.Offline",
    [PresenceType.Online] = "Common.Presence.Label.Online",
    [PresenceType.InGame] = "Common.Presence.Label.Online",
    [PresenceType.InStudio] = "Common.Presence.Label.Online"
}
