-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")

local useIsStickyShortcutBarEnabled = require(AppShortcutBar.Hooks.useIsStickyShortcutBarEnabled)
local useStickyShortcutBarExposureLogging = require(AppShortcutBar.Hooks.useStickyShortcutBarExposureLogging)

local function StickyShortcutBarExposureLogger(tbl1)
    local var1 = useIsStickyShortcutBarEnabled(tbl1.currentPage)
    useStickyShortcutBarExposureLogging(var1)

    return nil
end

return StickyShortcutBarExposureLogger
