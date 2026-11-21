-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local PresenceType = require(FriendsLanding.dependencies).RoduxPresence.Enums.PresenceType

return {
    [PresenceType.Offline] = nil,
    [PresenceType.Online] = "component_assets/circle_16",
    [PresenceType.InGame] = "icons/menu/games_small",
    [PresenceType.InStudio] = "icons/logo/studiologo_small"
}
