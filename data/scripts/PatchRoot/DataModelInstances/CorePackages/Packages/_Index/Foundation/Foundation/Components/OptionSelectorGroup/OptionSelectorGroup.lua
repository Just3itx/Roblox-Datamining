-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:30:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Orientation = require(Foundation.Enums.Orientation)

local OptionSelectorGroupSize = require(Foundation.Enums.OptionSelectorGroupSize)

local _FillBehavior = require(Foundation.Enums.FillBehavior)

local InputLabel = require(Foundation.Components.InputLabel)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local OptionSelectorGroupContext = require(script.Parent.OptionSelectorGroupContext)
local useOptionSelectorGroupVariants = require(script.Parent.useOptionSelectorGroupVariants)

local tbl1 = {
    orientation = Orientation.Vertical,
    size = OptionSelectorGroupSize.Medium,
    Selectable = true,
    testId = "--foundation-option-selector-group"
}

local function OptionSelectorGroupInner(tbl2)
    local props = tbl2.props
    local var1 = useTokens()

    local var2 = useOptionSelectorGroupVariants(var1, props.size or OptionSelectorGroupSize.Medium, props.orientation)

    local value = React.useMemo(function()
        return {
            value = tbl2.value,
            onValueChanged = tbl2.onValueChanged,
            orientation = props.orientation,
            Selectable = props.Selectable,
            testId = props.testId,
            size = tbl2.sizeOverride,
            fillBehavior = tbl2.fillBehaviorOverride
        }
    end, {
        tbl2.value,
        tbl2.onValueChanged,
        props.orientation,
        props.Selectable,
        props.testId,
        tbl2.sizeOverride,
        tbl2.fillBehaviorOverride
    })

    return React.createElement(View, withCommonProps(props, { tag = var2.container.tag, ref = tbl2.ref }), {
        Legend = if props.legend == nil then nil else React.createElement(
            InputLabel,
            {
                Text = props.legend,
                size = var2.legend.size,
                LayoutOrder = 1,
                testId = `{props.testId}--legend`
            }
        ),
        List = React.createElement(
            View,
            {
                tag = var2.list.tag,
                LayoutOrder = 2,
                testId = `{props.testId}--list`
            },
            {
                OptionSelectorGroupContext = React.createElement(OptionSelectorGroupContext.Provider, { value = value }, props.children)
            }
        )
    })
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: OptionSelectorGroup
    local props = withDefaults(arg1, tbl1)
    local value, var3 = React.useState(props.value)

    React.useEffect(function()
        if props.value ~= nil then
            var3(props.value)
        end
    end, { props.value })

    local onValueChanged = React.useCallback(function(str1: string)
        var3(str1)
        props.onValueChanged(str1)
    end, { var3, props.onValueChanged })
    return (React.createElement(OptionSelectorGroupInner, {
        props = props,
        sizeOverride = arg1.size,
        fillBehaviorOverride = arg1.fillBehavior,
        value = value,
        onValueChanged = onValueChanged,
        ref = ref
    }))
end))
