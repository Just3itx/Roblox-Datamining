-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local InputSize = require(Foundation.Enums.InputSize)

local Constants = require(Foundation.Constants)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useInputChipVariants = require(script.Parent.useInputChipVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    size = InputSize.Medium,
    isDisabled = false,
    testId = "--foundation-input-chip"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InputChip
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useInputChipVariants(var2, var1.size)

    local createElement = React.createElement
    local var4 = View
    local var5 = withCommonProps(var1, {
        tag = var3.container.tag,
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        ref = ref
    })
    local tbl2 = {
        Text = React.createElement(Text, {
            Text = var1.text,
            textStyle = var3.text.contentStyle,
            tag = var3.text.tag,
            padding = var3.text.padding,
            LayoutOrder = 1,
            testId = `{var1.testId}--text`
        }),
        Close = 0
    }
    local createElement2 = React.createElement
    local var6 = View
    local tbl3 = {
        tag = var3.close.tag,
        padding = var3.close.padding,
        LayoutOrder = 2,
        testId = `{var1.testId}--close-container`
    }
    local tbl4 = {
        CloseAffordance = React.createElement(CloseAffordance, {
            onActivated = if var1.isDisabled then nil else var1.onClose,
            size = InputSize.XSmall,
            variant = CloseAffordanceVariant.Utility,
            hasPadding = false,
            Selectable = not var1.isDisabled and nil,
            LayoutOrder = 1,
            testId = `{var1.testId}--close`
        })
    }
    tbl2.Close = createElement2(var6, tbl3, tbl4)
    return createElement(var4, var5, tbl2)
end))
