-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:28Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Components = Foundation.Components
local HintText = require(Components.HintText)
local InputLabel = require(Components.InputLabel)
local _Types = require(Components.Types)
local View = require(Components.View)

local useScaledValue = require(Foundation.Utility.useScaledValue)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Constants = require(Foundation.Constants)

local tbl1 = {
    size = require(Foundation.Enums.InputLabelSize).Small,
    testId = "--foundation-input-field"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InputField
    local var1 = withDefaults(arg1, tbl1)
    local xOffset = useScaledValue(Constants.DEFAULT_INPUT_FIELD_WIDTH_PIXELS)
    local var2 = React.useRef(nil)

    local onActivated = React.useCallback(function()
        if var2.current and not var2.current.getIsFocused() then
            var2.current.focus()
        end
    end, {})

    React.useImperativeHandle(var1.textBoxRef, function()
        if not var2.current then
            return nil
        end

        return {
            focus = var2.current.focus,
            releaseFocus = var2.current.releaseFocus,
            getIsFocused = var2.current.getIsFocused,
            getCursorPosition = var2.current.getCursorPosition,
            getSelectionStart = var2.current.getSelectionStart,
            setCursorPosition = var2.current.setCursorPosition,
            setSelectionStart = var2.current.setSelectionStart
        }
    end, {})

    return React.createElement(
        View,
        withCommonProps(var1, {
            Size = if var1.width then UDim2.new(var1.width, UDim.new(0, 0)) else UDim2.fromOffset(xOffset, 0),
            tag = "col gap-small auto-y",
            ref = ref
        }),
        {
            Label = if #var1.label > 0 then React.createElement(InputLabel, {
                Text = var1.label,
                size = var1.size,
                isRequired = var1.isRequired,
                isDisabled = var1.isDisabled,
                onActivated = onActivated,
                LayoutOrder = 1,
                testId = `{var1.testId}--label`
            }) else nil,
            InputWrapper = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y",
                    LayoutOrder = 2,
                    testId = `{var1.testId}--input-wrapper`
                },
                {
                    Input = var1.input(var2)
                }
            ),
            Hint = if var1.hint then React.createElement(HintText, {
                text = var1.hint,
                hasError = var1.hasError,
                isDisabled = var1.isDisabled,
                LayoutOrder = 3,
                testId = `{var1.testId}--hint`
            }) else nil
        }
    )
end))
