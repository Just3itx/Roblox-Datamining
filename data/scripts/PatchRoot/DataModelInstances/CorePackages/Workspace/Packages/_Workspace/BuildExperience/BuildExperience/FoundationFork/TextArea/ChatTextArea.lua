-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Components = Foundation.Components
local InputField = require(Components.InputField)
local _Types = require(Foundation.Components.Types)

local ChatInternalTextInput = require(script.Parent.ChatInternalTextInput)
local useTextInputVariants = require(Components.TextInput.useTextInputVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    size = require(Foundation.Enums.InputSize).Large,
    maxLines = 5,
    testId = "--build-experience-chat-text-area"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: ChatTextArea
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useTextInputVariants(var2, var1.size, var1.variant)

    local createElement = React.createElement
    local var4 = InputField
    local var5 = withCommonProps
    local tbl2 = {
        width = if var1.width then var1.width else nil,
        label = var1.label,
        hint = var1.hint,
        hasError = var1.hasError,
        isDisabled = var1.leadingElement == nil and var1.trailingElement == nil and var1.isDisabled,
        isRequired = var1.isRequired,
        input = 0,
        textBoxRef = 0,
        ref = 0
    }
    function tbl2.input(ref2)
        return React.createElement(ChatInternalTextInput, {
            size = var1.size,
            variant = var1.variant,
            maxLines = var1.maxLines,
            alwaysMultiLine = true,
            manualFocusRelease = true,
            trailingAlignBottom = var1.trailingElement ~= nil,
            composerDebug = var1.composerDebug,
            focusBehavior = var1.focusBehavior,
            onFocus = var1.onFocusGained,
            onFocusLost = var1.onFocusLost,
            onReturnPressed = var1.onReturnPressed,
            onChanged = var1.onChanged,
            text = var1.text,
            hasError = var1.hasError,
            isDisabled = var1.isDisabled,
            hasClearButton = var1.hasClearButton,
            placeholder = var1.placeholder,
            horizontalPadding = {
                left = if var1.leadingElement then UDim.new(0, var2.Padding.XSmall) else UDim.new(0, var2.Padding.Large),
                right = if var1.trailingElement then UDim.new(0, var2.Padding.XSmall) else var3.container.horizontalPadding
            },
            textPaddingOnParent = true,
            leadingElement = var1.leadingElement,
            trailingElement = var1.trailingElement,
            LayoutOrder = 2,
            ref = ref2,
            testId = `{var1.testId}--input`
        })
    end
    tbl2.textBoxRef = var1.textBoxRef
    tbl2.ref = ref
    return createElement(var4, var5(var1, tbl2))
end))
