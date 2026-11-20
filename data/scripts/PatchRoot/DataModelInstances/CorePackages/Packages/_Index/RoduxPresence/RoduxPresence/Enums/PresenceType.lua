-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local RoduxPresenceParent = script:FindFirstAncestor("RoduxPresence").Parent
return require(RoduxPresenceParent.enumerate)(
    script.Name,
    { Offline = 0, Online = 1, InGame = 2, InStudio = 3, Invisible = 4 }
)
