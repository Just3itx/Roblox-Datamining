-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")

local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)

return {
    [StatusIndicatorVariant.Emphasis] = true,
    [StatusIndicatorVariant.Standard] = true
}
