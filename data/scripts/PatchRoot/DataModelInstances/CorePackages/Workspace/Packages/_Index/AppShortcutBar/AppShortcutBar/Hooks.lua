-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")

return {
    useAppShortcutBarHeight = require(script.useAppShortcutBarHeight),
    useIsStickyShortcutBarEnabled = require(script.useIsStickyShortcutBarEnabled),
    useShortcutBarVisible = require(AppShortcutBar.Stores.GetShortcutBarStatusStore)(false).useShortcutBarVisible
}
