-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Components = Foundation.Components
local Icon = require(Components.Icon)
local IconButton = require(Components.IconButton)
local InputField = require(Components.InputField)
local InternalTextInput = require(Components.InternalTextInput)
local _Types = require(Foundation.Components.Types)
local View = require(Components.View)

local useTextInputVariants = require(Foundation.Components.TextInput.useTextInputVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputSize = require(Foundation.Enums.InputSize)

local _InputVariant = require(Foundation.Enums.InputVariant)

local getInputTextSize = require(Foundation.Utility.getInputTextSize)

local _ControlState = require(Foundation.Enums.ControlState)

local tbl1 = {
    size = InputSize.Large,
    testId = "--foundation-text-input"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: TextInput
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useTextInputVariants(var2, var1.size, var1.variant)

    return React.createElement(
        InputField,
        withCommonProps(var1, {
            width = var1.width,
            ref = ref,
            label = var1.label,
            size = getInputTextSize(var1.size),
            isRequired = var1.isRequired,
            isDisabled = var1.isDisabled,
            hasError = var1.hasError,
            hint = var1.hint,
            textBoxRef = var1.textBoxRef,
            input = function(ref2)
                local createElement = React.createElement
                local var4 = InternalTextInput
                local tbl2 = {
                    ref = ref2,
                    inputRef = var1.inputRef,
                    hasError = var1.hasError,
                    isDisabled = var1.isDisabled,
                    hasClearButton = var1.hasClearButton,
                    text = var1.text,
                    textInputType = var1.textInputType,
                    focusBehavior = var1.focusBehavior,
                    size = var1.size,
                    variant = var1.variant,
                    Selectable = var1.Selectable,
                    NextSelectionUp = var1.NextSelectionUp,
                    NextSelectionDown = var1.NextSelectionDown,
                    NextSelectionLeft = var1.NextSelectionLeft,
                    NextSelectionRight = var1.NextSelectionRight,
                    horizontalPadding = {
                        left = var3.container.horizontalPadding,
                        right = var3.container.horizontalPadding
                    },
                    onChanged = var1.onChanged,
                    onFocus = var1.onFocusGained,
                    onFocusLost = var1.onFocusLost,
                    onReturnPressed = var1.onReturnPressed,
                    placeholder = var1.placeholder,
                    leadingElement = if var1.leadingIcon then React.createElement(
                        View,
                        { tag = "row align-y-center size-0-full auto-x" },
                        React.createElement(Icon, { name = var1.leadingIcon, style = var3.icon.style, size = var3.icon.size })
                    ) else nil,
                    trailingElement = 0,
                    testId = 0
                }
                local var5

                if var1.iconTrailing then
                    local createElement2 = React.createElement
                    local var6 = View
                    local tbl3 = { tag = "row align-y-center size-0-full auto-x" }
                    local iconTrailing = var1.iconTrailing
                    local element

                    if type(iconTrailing) == "table" and var1.iconTrailing.onActivated then
                        element = React.createElement(IconButton, {
                            onActivated = var1.iconTrailing.onActivated,
                            isDisabled = var1.isDisabled,
                            size = var3.icon.size,
                            icon = var1.iconTrailing.name,
                            testId = `{var1.testId}--trailing-icon-button`
                        })
                    else
                        element = React.createElement(Icon, {
                            name = if type(var1.iconTrailing) == "table" then var1.iconTrailing.name else var1.iconTrailing,
                            style = var3.icon.style,
                            size = var3.icon.size
                        })
                    end

                    var5 = createElement2(var6, tbl3, element)
                else
                    var5 = nil
                end

                tbl2.trailingElement = var5

                tbl2.testId = `{var1.testId}--internal-text-input`
                return createElement(var4, tbl2)
            end
        })
    )
end))
