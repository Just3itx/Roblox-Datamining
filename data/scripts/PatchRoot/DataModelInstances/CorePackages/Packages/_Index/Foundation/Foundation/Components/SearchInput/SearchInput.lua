-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Components = Foundation.Components
local Icon = require(Components.Icon)
local InternalTextInput = require(Components.InternalTextInput)
local _Types = require(Components.Types)
local View = require(Components.View)

local Constants = require(Foundation.Constants)
local Translator = require(Foundation.Utility.Localization.Translator)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTextInputVariants = require(Foundation.Components.TextInput.useTextInputVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputSize = require(Foundation.Enums.InputSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local Radius = require(Foundation.Enums.Radius)

local SearchInputShape = require(Foundation.Enums.SearchInputShape)

local tbl1 = {
    [SearchInputShape.Pill] = Radius.Circle,
    [SearchInputShape.Box] = Radius.None
}

local tbl2 = {
    size = InputSize.Medium,
    variant = InputVariant.Standard,
    shape = SearchInputShape.Pill,
    hasClearButton = true,
    testId = "--foundation-search-input"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: SearchInput
    local var1 = withDefaults(arg1, tbl2)
    local var2 = useTokens()
    local var3 = useTextInputVariants(var2, var1.size, var1.variant)
    local offset = useScaledValue(Constants.DEFAULT_INPUT_FIELD_WIDTH_PIXELS)

    local var4 = React.useMemo(function(): UDim2
        return UDim2.fromOffset(0, (var3.container.minHeight - var2.Stroke.Standard) / 2)
    end, { var3.container.minHeight, var2.Stroke.Standard })

    local createElement = React.createElement
    local var5 = View
    local var6 = withCommonProps(var1, {
        Size = if var1.width then UDim2.new(var1.width, UDim.new(0, 0)) else UDim2.new(UDim.new(0, offset), UDim.new(0, 0)),
        tag = "auto-y"
    })

    local tbl3 = {
        Input = React.createElement(InternalTextInput, {
            ref = ref,
            hasError = var1.hasError,
            isDisabled = var1.isDisabled,
            hasClearButton = var1.hasClearButton,
            text = var1.text,
            size = var1.size,
            radius = tbl1[var1.shape],
            variant = var1.variant,
            horizontalPadding = {
                left = var3.container.horizontalPadding,
                right = var3.container.horizontalPadding
            },
            onChanged = var1.onChanged,
            onFocus = var1.onFocusGained,
            onFocusLost = var1.onFocusLost,
            placeholder = if var1.placeholder then var1.placeholder else Translator:FormatByKey("CommonUI.Controls.Action.Search"),
            leadingElement = React.createElement(View, {
                Position = var4,
                tag = "anchor-center-left auto-xy"
            }, {
                Icon = React.createElement(
                    Icon,
                    {
                        name = BuilderIcons.Icon.MagnifyingGlass,
                        size = var1.size,
                        testId = `{var1.testId}--search-icon`
                    }
                )
            }),
            testId = `{var1.testId}--input`
        })
    }
    return createElement(var5, var6, tbl3)
end))
