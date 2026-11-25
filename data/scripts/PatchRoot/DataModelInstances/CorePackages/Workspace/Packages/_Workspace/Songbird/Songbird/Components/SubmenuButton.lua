-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local React = require(Songbird.Parent.React)
local Foundation = require(Songbird.Parent.Foundation)
local ReactUtils = require(Songbird.Parent.ReactUtils)

local useCallback = React.useCallback
local createNextOrder = ReactUtils.createNextOrder
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    iconSize = Foundation.Enums.IconSize.Medium
}

local function SubmenuButton(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local nextOrder = createNextOrder()
    local var2 = useTokens()

    local onStateChanged = useCallback(function(pressed)
        if pressed == Foundation.Enums.ControlState.Pressed and var1.onActivated then
            var1.onActivated()
        end
    end, { var1.onActivated })

    return React.createElement(Foundation.View, {
        tag = "size-full-0 auto-y row gap-small padding-small align-y-center radius-medium",
        onStateChanged = onStateChanged,
        LayoutOrder = var1.LayoutOrder
    }, {
        Icon = if var1.icon then React.createElement(
            Foundation.Icon,
            {
                name = var1.icon,
                size = var1.iconSize,
                style = var2.Color.Content.Emphasis,
                LayoutOrder = nextOrder()
            }
        ) else nil,
        Text = React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy content-default text-label-large",
                Text = var1.text,
                LayoutOrder = nextOrder()
            }
        )
    })
end
return SubmenuButton
