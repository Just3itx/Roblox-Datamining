-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")

local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)

return {
    [StatusIndicatorVariant.Emphasis] = true,
    [StatusIndicatorVariant.Standard] = true
}
