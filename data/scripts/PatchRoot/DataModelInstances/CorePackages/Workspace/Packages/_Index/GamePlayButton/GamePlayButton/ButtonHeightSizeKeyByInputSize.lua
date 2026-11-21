-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local InputSize = require(GamePlayButtonParent.Foundation).Enums.InputSize

return {
    [InputSize.XSmall] = "Size_600",
    [InputSize.Small] = "Size_800",
    [InputSize.Medium] = "Size_1000",
    [InputSize.Large] = "Size_1200"
}
