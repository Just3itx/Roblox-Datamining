-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local ChipSize = require(Foundation.Enums.ChipSize)
local Divider = require(Foundation.Components.Divider)
local Icon = require(Foundation.Components.Icon)
local Orientation = require(Foundation.Enums.Orientation)
local RatingValue = require(Foundation.Enums.RatingValue)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useRatingVariants = require(script.Parent.useRatingVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Icon2 = BuilderIcons.Icon
local IconVariant = BuilderIcons.IconVariant

local tbl1 = {
    size = ChipSize.Medium,
    value = RatingValue.None,
    Selectable = true,
    testId = "--foundation-rating"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Rating
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useRatingVariants(var2, var1.size)

    local var4 = React.useRef(nil)
    local var5 = React.useRef(nil)

    local cursor = React.useMemo(function()
        local borderWidth = math.floor(var2.Stroke.Thicker)
        return {
            radius = UDim.new(0, var2.Radius.Circle),
            offset = borderWidth * 2,
            borderWidth = borderWidth
        }
    end, { var2 })

    local bool1 = var1.value == RatingValue.ThumbUp
    local bool2 = var1.value == RatingValue.ThumbDown

    local createElement = React.createElement
    local var7 = View
    local var8 = withCommonProps(var1, { tag = var3.container.tag, backgroundStyle = var3.container.backgroundStyle, ref = ref })

    local tbl2 = { ThumbUp = 0, Divider = 0, ThumbDown = 0 }
    local createElement2 = React.createElement
    local var9 = View
    local tbl3 = {
        tag = var3.thumbUpSegment.tag,
        ref = var4,
        LayoutOrder = 1,
        onActivated = var1.onThumbUp,
        cursor = cursor,
        selection = {
            Selectable = var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var1.NextSelectionLeft,
            NextSelectionRight = var5
        },
        testId = `{var1.testId}--thumb-up`
    }
    local tbl4 = { Icon = 0, Text = 0 }
    local createElement3 = React.createElement
    local var10 = View
    local tbl5 = {
        tag = var3.thumbUpIcon.tag,
        LayoutOrder = 1
    }
    local tbl6 = {
        Icon = React.createElement(Icon, {
            name = Icon2.ThumbUp,
            variant = if bool1 then IconVariant.Filled else IconVariant.Regular,
            size = var3.iconSize,
            style = var3.text.contentStyle,
            testId = `{var1.testId}--thumb-up-icon`
        })
    }
    tbl4.Icon = createElement3(var10, tbl5, tbl6)

    tbl4.Text = React.createElement(Text, {
        Text = var1.text,
        textStyle = var3.text.contentStyle,
        tag = var3.text.tag,
        LayoutOrder = 2,
        testId = `{var1.testId}--text`
    })
    tbl2.ThumbUp = createElement2(var9, tbl3, tbl4)

    tbl2.Divider = React.createElement(
        View,
        {
            tag = var3.dividerContainer.tag,
            LayoutOrder = 2,
            testId = `{var1.testId}--divider`
        },
        {
            Line = React.createElement(Divider, { orientation = Orientation.Vertical })
        }
    )
    local createElement4 = React.createElement
    local var11 = View
    local tbl7 = {
        tag = var3.thumbDownSegment.tag,
        ref = var5,
        LayoutOrder = 3,
        onActivated = var1.onThumbDown,
        cursor = cursor,
        selection = {
            Selectable = var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var4,
            NextSelectionRight = var1.NextSelectionRight
        },
        testId = `{var1.testId}--thumb-down`
    }
    local tbl8 = { Icon = 0 }
    local createElement5 = React.createElement
    local var12 = View
    local tbl9 = {
        tag = var3.thumbDownIcon.tag,
        LayoutOrder = 1
    }
    local tbl10 = {
        Icon = React.createElement(Icon, {
            name = Icon2.ThumbDown,
            variant = if bool2 then IconVariant.Filled else IconVariant.Regular,
            size = var3.iconSize,
            style = var3.text.contentStyle,
            testId = `{var1.testId}--thumb-down-icon`
        })
    }
    tbl8.Icon = createElement5(var12, tbl9, tbl10)
    tbl2.ThumbDown = createElement4(var11, tbl7, tbl8)
    return createElement(var7, var8, tbl2)
end))
