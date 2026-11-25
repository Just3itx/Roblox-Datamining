-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UserLib = script:FindFirstAncestor("UserLib")

local User = require(UserLib.Models.User)

return {
    [0] = User.PresenceType.OFFLINE,
    [1] = User.PresenceType.ONLINE,
    [2] = User.PresenceType.IN_GAME,
    [3] = User.PresenceType.IN_STUDIO
}
