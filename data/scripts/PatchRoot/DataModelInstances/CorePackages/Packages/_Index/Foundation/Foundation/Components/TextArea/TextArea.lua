-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:30Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Components = Foundation.Components
local InputField = require(Components.InputField)
local InternalTextInput = require(Components.InternalTextInput)
local _Types = require(Foundation.Components.Types)

local getInputTextSize = require(Foundation.Utility.getInputTextSize)
local useTextInputVariants = require(Components.TextInput.useTextInputVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputSize = require(Foundation.Enums.InputSize)

local _InputVariant = require(Foundation.Enums.InputVariant)

local _ControlState = require(Foundation.Enums.ControlState)

local tbl1 = {
    size = InputSize.Medium,
    numLines = 3,
    testId = "--foundation-text-area"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: TextArea
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useTextInputVariants(var2, var1.size, var1.variant)

    local createElement = React.createElement
    local var4 = InputField
    local var5 = withCommonProps
    local tbl2 = {
        width = if var1.width then var1.width else nil,
        label = var1.label,
        size = getInputTextSize(var1.size),
        hint = var1.hint,
        hasError = var1.hasError,
        isDisabled = var1.isDisabled,
        isRequired = var1.isRequired,
        input = 0,
        textBoxRef = 0,
        ref = 0
    }
    function tbl2.input(ref2)
        return React.createElement(InternalTextInput, {
            inputRef = var1.inputRef,
            size = var1.size,
            variant = var1.variant,
            numLines = var1.numLines,
            focusBehavior = var1.focusBehavior,
            onFocus = var1.onFocusGained,
            onFocusLost = var1.onFocusLost,
            onChanged = var1.onChanged,
            text = var1.text,
            hasError = var1.hasError,
            isDisabled = var1.isDisabled,
            hasClearButton = var1.hasClearButton,
            placeholder = var1.placeholder,
            horizontalPadding = {
                left = var3.container.horizontalPadding,
                right = var3.container.horizontalPadding - UDim.new(0, var2.Size.Size_150)
            },
            LayoutOrder = 2,
            ref = ref2,
            testId = `{var1.testId}--input`
        })
    end
    tbl2.textBoxRef = var1.textBoxRef
    tbl2.ref = ref
    return createElement(var4, var5(var1, tbl2))
end))
