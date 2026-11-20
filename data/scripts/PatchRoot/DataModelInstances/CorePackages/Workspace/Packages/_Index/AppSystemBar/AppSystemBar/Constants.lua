-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppSystemBarParent = script:FindFirstAncestor("AppSystemBar").Parent
return {
    TOP_BAR_SIZE = 64,
    BOTTOM_BAR_SIZE = if require(AppSystemBarParent.SharedFlags).FFlagShrinkAppNavBar then 52 else 64,
    GAMEPAD_BOTTOM_BAR_SIZE = 72
}
