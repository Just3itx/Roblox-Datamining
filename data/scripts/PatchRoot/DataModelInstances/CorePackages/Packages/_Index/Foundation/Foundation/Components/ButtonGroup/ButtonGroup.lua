-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Button = require(Foundation.Components.Button)
local _ButtonVariant = require(Foundation.Enums.ButtonVariant)
local FillBehavior = require(Foundation.Enums.FillBehavior)
local InputSize = require(Foundation.Enums.InputSize)
local Orientation = require(Foundation.Enums.Orientation)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local devAssert = require(Foundation.Utility.devAssert)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    maxButtonCount = 3,
    orientation = Orientation.Horizontal,
    size = InputSize.Medium,
    testId = "--foundation-button-group"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: ButtonGroup
    local var1 = withDefaults(arg1, tbl1)

    devAssert(
        #var1.buttons <= var1.maxButtonCount,
        `ButtonGroup: a maximum of {var1.maxButtonCount} buttons is supported, got {#var1.buttons}.`
    )

    local bool1 = var1.orientation == Orientation.Vertical
    local bool2 = bool1 or var1.fillBehavior == FillBehavior.Fill
    local fill = if bool1 or not bool2 then nil else FillBehavior.Fill
    local tbl2 = ({})

    for layoutOrder, button in var1.buttons do
        local str1 = `{layoutOrder}-{button.text}`
        tbl2[str1] = React.createElement(Button, {
            text = button.text,
            onActivated = button.onActivated,
            variant = button.variant,
            isDisabled = button.isDisabled,
            isLoading = button.isLoading,
            icon = button.icon,
            inputDelay = button.inputDelay,
            ref = button.ref,
            size = var1.size,
            fillBehavior = fill,
            LayoutOrder = layoutOrder,
            testId = button.testId or `{var1.testId}--button-{layoutOrder}`
        })
    end

    return React.createElement(
        View,
        withCommonProps(var1, {
            tag = {
                ["gap-small"] = true,
                ["col flex-x-fill"] = bool1,
                row = not bool1 and bool2,
                ["row wrap"] = not (bool1 or bool2),
                ["size-full-0 auto-y"] = bool2,
                ["auto-xy"] = not bool2
            },
            ref = ref
        }),
        tbl2
    )
end))
