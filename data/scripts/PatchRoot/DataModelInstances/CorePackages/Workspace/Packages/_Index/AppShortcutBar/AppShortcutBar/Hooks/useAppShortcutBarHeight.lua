-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent
local useTokens = require(AppShortcutBarParent.Foundation).Hooks.useTokens

local function useAppShortcutBarHeight()
    return useTokens().Size.Size_1200
end

return useAppShortcutBarHeight
