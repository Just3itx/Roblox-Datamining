-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local Flags = require(Foundation.Utility.Flags)
local HeaderBarContext = require(Foundation.Components.HeaderBar.HeaderBarContext)
local HeaderBarSlot = require(Foundation.Enums.HeaderBarSlot)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local constants = require(Foundation.Components.HeaderBar.constants)
local useViewportBreakpoint = require(Foundation.Providers.Responsive.Hooks.useViewportBreakpoint)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { hasBackground = true, testId = "--foundation-header-bar" }

return React.memo(function(arg1) -- name: HeaderBar
    local var1 = withDefaults(arg1, tbl1)

    local var2 = useViewportBreakpoint()

    if not Flags.FoundationHeaderBarSlotSizing then
        return React.createElement(
            View,
            withCommonProps(var1, {
                tag = {
                    ["row flex-between gap-small padding-medium"] = true,
                    ["bg-surface-0"] = var1.hasBackground,
                    [`size-full-{constants.SIZE_BY_BREAKPOINT[var2]}`] = true
                }
            }),
            React.createElement(HeaderBarContext.Provider, { testId = var1.testId }, var1.children)
        )
    end

    local var3, var4 = React.useState({ leading = 0, trailing = 0 })

    local onSideWidthChanged = React.useCallback(function(arg2, num1: number)
        var4(function(tbl2)
            local leading = if arg2 == HeaderBarSlot.Leading then num1 else tbl2.leading
            local trailing = if arg2 == HeaderBarSlot.Trailing then num1 else tbl2.trailing
            return if leading == tbl2.leading and trailing == tbl2.trailing then tbl2 else {
                leading = leading,
                trailing = trailing
            }
        end)
    end, {})

    return React.createElement(
        View,
        withCommonProps(var1, {
            tag = {
                ["padding-x-medium"] = true,
                ["bg-surface-0"] = var1.hasBackground,
                [`size-full-{constants.SIZE_BY_BREAKPOINT[var2]}`] = true
            }
        }),
        React.createElement(HeaderBarContext.Provider, {
            testId = var1.testId,
            leadingWidth = var3.leading,
            trailingWidth = var3.trailing,
            onSideWidthChanged = onSideWidthChanged
        }, var1.children)
    )
end)
