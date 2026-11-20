-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)

local Components = Foundation.Components
local InternalInput = require(Components.InternalInput)
local Text = require(Components.Text)
local _Types = require(Components.Types)
local useUncontrolledState = require(Components.InternalInput.useUncontrolledState)

local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local useCheckboxVariants = require(script.Parent.useCheckboxVariants)

local InputSize = require(Foundation.Enums.InputSize)

local InputPlacement = require(Foundation.Enums.InputPlacement)

local useInputGroupDefaults = require(Components.InternalInputGroup.useInputGroupDefaults)

local tbl1 = {
    size = InputSize.Medium,
    placement = InputPlacement.Start,
    Selectable = true,
    testId = "--foundation-checkbox"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Checkbox
    local var1 = useInputGroupDefaults(arg1, tbl1)

    local var2 = useTokens()
    local var3 = useCheckboxVariants(var2, var1.size)

    local isChecked, onActivated = useUncontrolledState(var1.isChecked, var1.onActivated)
    local isIndeterminate = var1.isIndeterminate or false

    local createElement = React.createElement
    local var6 = InternalInput
    local var7 = withCommonProps(var1, {
        isChecked = isChecked,
        isIndeterminate = isIndeterminate,
        isDisabled = var1.isDisabled,
        onActivated = onActivated,
        label = {
            text = var1.label,
            position = Constants.INPUT_PLACEMENT_TO_LABEL_ALIGNMENT[var1.placement],
            hint = var1.hint
        },
        customVariantProps = var3.input,
        size = var1.size,
        Selectable = var1.Selectable,
        NextSelectionUp = var1.NextSelectionUp,
        NextSelectionDown = var1.NextSelectionDown,
        NextSelectionLeft = var1.NextSelectionLeft,
        NextSelectionRight = var1.NextSelectionRight,
        ref = ref
    })
    local tbl2 = { Checkmark = 0 }
    local element

    if isChecked or isIndeterminate then
        element = React.createElement(Text, {
            Text = if isIndeterminate then BuilderIcons.Icon.Minus else BuilderIcons.Icon.Check,
            fontStyle = {
                Font = BuilderIcons.Font[BuilderIcons.IconVariant.Filled]
            },
            TextScaled = true,
            tag = var3.checkmark.tag,
            testId = `{var1.testId}--checkmark`
        })
    else
        element = nil
    end

    tbl2.Checkmark = element
    return createElement(var6, var7, tbl2)
end))
