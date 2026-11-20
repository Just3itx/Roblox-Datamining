-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local useTokens = require(Foundation.Providers.Style.useTokens)

local withCommonProps = require(Foundation.Utility.withCommonProps)

local _ControlState = require(Foundation.Enums.ControlState)

local _InputSize = require(Foundation.Enums.InputSize)

local useBaseMenuItemVariants = require(script.Parent.useBaseMenuItemVariants)

return React.memo(React.forwardRef(function(arg1, ref) -- name: BaseMenuTitleItem
    local var1 = useTokens()

    local var2 = useBaseMenuItemVariants(var1, arg1.size, false)
    local offset = if arg1.menuHasCheck == true then (var2.container.paddingLeftWithCheck or 0) + (var2.title.checkColumnWidth or 0) else var2.container.paddingLeftWithoutCheck or 0
    local paddingRight = var2.container.paddingRight or 0

    return React.createElement(
        View,
        withCommonProps(arg1, {
            tag = `row align-y-center {var2.container.tag}`,
            padding = {
                left = UDim.new(0, offset),
                right = UDim.new(0, paddingRight)
            },
            ref = ref
        }),
        React.createElement(Text, { Text = arg1.text, tag = var2.title.tag })
    )
end))
