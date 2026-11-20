-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent

local React = require(AppShortcutBarParent.React)
local Hooks = require(AppShortcutBar.Hooks)
local useAppPolicy = require(AppShortcutBarParent.UniversalAppPolicy).useAppPolicy

local function AppShortcutBarStatusListener(tbl1)
    local var1 = Hooks.useAppShortcutBarHeight()

    local var2 = useAppPolicy(function(arg1)
        return arg1.getStickyShortcutBarEnabled()
    end)

    local var3 = Hooks.useShortcutBarVisible()

    local var4 = var2 and var3
    React.useEffect(function()
        if tbl1.onHeightChanged then
            tbl1.onHeightChanged(if var4 then var1 else 0)
        end
    end, { var4, var1, tbl1.onHeightChanged })

    return nil
end

return AppShortcutBarStatusListener
