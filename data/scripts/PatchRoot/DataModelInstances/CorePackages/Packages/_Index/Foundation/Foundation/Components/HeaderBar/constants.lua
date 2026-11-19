-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:50Z
-- Luau bytecode version: 9 | Luau type version: 3
local Foundation = script:FindFirstAncestor("Foundation")
local Constants = require(Foundation.Constants)

return {
    LEADING_ACTIONS_LAYOUT_ORDER = Constants.MIN_LAYOUT_ORDER,
    LEADING_LAYOUT_ORDER = 1,
    CONTENT_LAYOUT_ORDER = 2,
    TRAILING_LAYOUT_ORDER = 3,
    TRAILING_ACTIONS_LAYOUT_ORDER = Constants.MAX_LAYOUT_ORDER - 1
}
