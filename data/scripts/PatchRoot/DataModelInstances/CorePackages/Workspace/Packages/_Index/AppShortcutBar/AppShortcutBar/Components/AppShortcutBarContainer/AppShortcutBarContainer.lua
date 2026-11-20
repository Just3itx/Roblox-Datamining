-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent
local React = require(AppShortcutBarParent.React)
local Cryo = require(AppShortcutBarParent.Cryo)
local AppShortcutBar2 = require(AppShortcutBar.Components.AppShortcutBar)
local AppStickyShortcutBar = require(AppShortcutBar.Components.AppStickyShortcutBar)

local useAppShortcutBarProps = require(script.Parent.useAppShortcutBarProps)
local useAppPolicy = require(AppShortcutBarParent.UniversalAppPolicy).useAppPolicy

local FFlagEnableStickyShortcutBarOnAllPlatforms = require(AppShortcutBarParent.SharedFlags).FFlagEnableStickyShortcutBarOnAllPlatforms

function AppShortcutBarContainer(tbl1)
    local var1 = useAppShortcutBarProps()

    if not (useAppPolicy(function(arg1)
        return arg1.getStickyShortcutBarEnabled()
    end) or FFlagEnableStickyShortcutBarOnAllPlatforms) then
        return React.createElement(AppShortcutBar2, var1)
    end

    local createElement = React.createElement
    local var2 = AppStickyShortcutBar
    if FFlagEnableStickyShortcutBarOnAllPlatforms then
        var1 = Cryo.Dictionary.join(var1, { isLeftNavVisible = tbl1.isLeftNavVisible, currentPage = tbl1.currentPage })
    end

    return createElement(var2, var1)
end

return AppShortcutBarContainer
