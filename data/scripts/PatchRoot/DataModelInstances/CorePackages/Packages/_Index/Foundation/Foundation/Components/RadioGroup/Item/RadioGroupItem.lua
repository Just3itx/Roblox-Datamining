-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)

local Components = Foundation.Components
local InternalInput = require(Components.InternalInput)
local _Types = require(Components.Types)
local View = require(Components.View)

local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local useRadioGroupItemVariants = require(script.Parent.useRadioGroupItemVariants)

local InputSize = require(Foundation.Enums.InputSize)

local InputPlacement = require(Foundation.Enums.InputPlacement)

local useInputGroupDefaults = require(Foundation.Components.InternalInputGroup.useInputGroupDefaults)
local useRadioGroup = require(script.Parent.Parent.useRadioGroup)

local tbl1 = {
    size = InputSize.Medium,
    isDisabled = false,
    placement = InputPlacement.Start
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: RadioGroupItem
    local var1 = useInputGroupDefaults(arg1, tbl1)
    local isDisabled = var1.isDisabled
    local var2 = useRadioGroup()

    local isChecked = var2.value == var1.value
    local text = var1.label or var1.value

    local var4 = useTokens()

    local onActivated = React.useCallback(function()
        var2.onValueChanged(var1.value)
    end, { isDisabled, var1.value, var2.onValueChanged })

    local var6 = useRadioGroupItemVariants(var4, var1.size)

    var1.testId = `{var2.testId}--item-{var1.value}`

    return React.createElement(
        InternalInput,
        withCommonProps(var1, {
            isChecked = isChecked,
            isDisabled = isDisabled,
            onActivated = onActivated,
            label = {
                text = text,
                position = Constants.INPUT_PLACEMENT_TO_LABEL_ALIGNMENT[var1.placement],
                hint = var1.hint
            },
            customVariantProps = var6.input,
            size = var1.size,
            Selectable = var2.Selectable,
            ref = ref
        }),
        {
            Center = if isChecked then React.createElement(View, { tag = var6.checkmark.tag, backgroundStyle = var6.checkmark.style }) else nil
        }
    )
end))
