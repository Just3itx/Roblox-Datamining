-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local ControlState = require(Foundation.Enums.ControlState)

local InputSize = require(Foundation.Enums.InputSize)

local LinkVariant = require(Foundation.Enums.LinkVariant)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local TextOverflow = require(Foundation.Enums.TextOverflow)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local escapeRichText = require(Foundation.Utility.escapeRichText)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useLinkVariants = require(script.Parent.useLinkVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)

local tbl1 = {
    [ControlState.Hover] = true,
    [ControlState.Pressed] = true,
    [ControlState.Selected] = true,
    [ControlState.SelectedPressed] = true
}

local tbl2 = {
    variant = LinkVariant.Standard,
    size = InputSize.Medium,
    hasUnderline = false,
    textOverflow = TextOverflow.None,
    testId = "--foundation-link"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Link
    local var1 = withDefaults(arg1, tbl2)
    local var2 = useTokens()
    local var3 = useLinkVariants(var2, var1.size, var1.variant, var1.textOverflow)

    local style = var3.content.style

    local var4, var5 = React.useState(false)
    local onStateChanged = React.useCallback(function(arg2)
        var5(tbl1[arg2] == true)
    end, {})

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, var2.Radius.XSmall),
            offset = var2.Size.Size_50,
            borderWidth = var2.Stroke.Standard
        }
    end, { var2 })

    local richText = var1.hasUnderline or var4

    local createElement = React.createElement
    local var9 = View
    local var10 = withCommonProps(var1, {
        tag = var3.container.tag,
        cursor = cursor,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        onActivated = var1.onActivated,
        onStateChanged = onStateChanged,
        selection = {
            Selectable = var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var1.NextSelectionLeft,
            NextSelectionRight = var1.NextSelectionRight
        },
        ref = ref
    })
    local tbl3 = {
        Text = React.createElement(Text, {
            Text = if richText then `<u>{escapeRichText(var1.text)}</u>` else var1.text,
            RichText = richText,
            tag = var3.text.tag,
            textStyle = {
                Color3 = style.Color3,
                Transparency = style.Transparency
            },
            LayoutOrder = 1,
            testId = `{var1.testId}--text`
        })
    }
    return createElement(var9, var10, tbl3)
end))
