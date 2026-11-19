-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Breakpoint = require(Foundation.Enums.Breakpoint)
local HeaderBarContext = require(Foundation.Components.HeaderBar.HeaderBarContext)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useViewportBreakpoint = require(Foundation.Providers.Responsive.Hooks.useViewportBreakpoint)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    [Breakpoint.XSmall] = "size-full-1400",
    [Breakpoint.Small] = "size-full-1400",
    [Breakpoint.Medium] = "size-full-1600",
    [Breakpoint.Large] = "size-full-1600",
    [Breakpoint.XLarge] = "size-full-1800",
    [Breakpoint.XXLarge] = "size-full-1800"
}

local tbl2 = { hasBackground = true, testId = "--foundation-header-bar" }

return React.memo(function(arg1) -- name: HeaderBar
    local var1 = withDefaults(arg1, tbl2)

    local var2 = useViewportBreakpoint()

    return React.createElement(
        View,
        withCommonProps(var1, {
            tag = {
                ["row flex-between gap-small padding-medium"] = true,
                ["bg-surface-0"] = var1.hasBackground,
                [tbl1[var2]] = true
            }
        }),
        React.createElement(HeaderBarContext.Provider, { testId = var1.testId }, var1.children)
    )
end)
