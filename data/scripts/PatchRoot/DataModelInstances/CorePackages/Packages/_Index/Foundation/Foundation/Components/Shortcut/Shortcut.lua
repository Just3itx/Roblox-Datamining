-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _InputPlatform = require(Foundation.Enums.InputPlatform)
local InputSize = require(Foundation.Enums.InputSize)
local Placement = require(Foundation.Enums.Placement)
local _ShortcutSeparator = require(Foundation.Enums.ShortcutSeparator)
local ShortcutVariant = require(Foundation.Enums.ShortcutVariant)

local useInputPlatform = require(Foundation.Utility.useInputPlatform)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local KeyCap = require(script.Parent.KeyCap)
local Separator = require(script.Parent.Separator)
local keyDisplay = require(script.Parent.keyDisplay)
local useShortcutVariants = require(script.Parent.useShortcutVariants)

local tbl1 = {
    size = InputSize.XSmall,
    placement = Placement.Start,
    variant = ShortcutVariant.Standard,
    testId = "--foundation-shortcut"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Shortcut
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local platform = useInputPlatform()
    local variantProps = useShortcutVariants(var2, var1.size, var1.variant)

    local tbl2 = ({})

    local num1 = 0
    local num2 = 0

    for layoutOrder, value2 in var1.shortcut do
        if value2.separator ~= nil then
            num2 += 1
            local str1 = `Separator{num2}`
            tbl2[str1] = React.createElement(Separator, {
                separator = value2.separator,
                variantProps = variantProps,
                LayoutOrder = layoutOrder,
                testId = `{var1.testId}--separator-{num2}`
            })
        elseif value2.keyCode ~= nil and not keyDisplay.isNonDisplayable(value2.keyCode) then
            num1 += 1
            local str1 = `Key{num1}`
            tbl2[str1] = React.createElement(KeyCap, {
                keyCode = value2.keyCode,
                platform = platform,
                variantProps = variantProps,
                LayoutOrder = layoutOrder,
                testId = `{var1.testId}--key-{num1}`
            })
        end
    end

    local createElement = React.createElement
    local var5 = View
    local var6 = withCommonProps(var1, {
        tag = variantProps.container.tag,
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, variantProps.container.gap),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        ref = ref
    })
    local tbl3 = {
        Keys = React.createElement(View, {
            tag = variantProps.keys.tag,
            LayoutOrder = if var1.placement == Placement.End then 2 else 1,
            testId = `{var1.testId}--keys`
        }, tbl2),
        Keybinding = 0
    }
    local element

    if var1.keybinding == nil or var1.keybinding == "" then
        element = nil
    else
        element = React.createElement(Text, {
            Text = var1.keybinding,
            tag = variantProps.keybinding.tag,
            LayoutOrder = if var1.placement == Placement.End then 1 else 2,
            testId = `{var1.testId}--keybinding`
        })
    end

    tbl3.Keybinding = element
    return createElement(var5, var6, tbl3)
end))
