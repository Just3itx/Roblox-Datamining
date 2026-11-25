-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local FoundationText = Foundation.Text
local Image = Foundation.Image
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue

return React.memo(function(tbl1) -- name: SduiContentRatingLabel
    local x = useScaledValue(tbl1.width or 450)
    local var1 = useTokens()

    return React.createElement(View, {
        tag = "padding-medium gap-large radius-medium row align-y-center stroke-default size-full-0 auto-y",
        onActivated = tbl1.onActivated,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        LayoutOrder = tbl1.layoutOrder
    }, {
        SizeConstraint = React.createElement(
            "UISizeConstraint",
            {
                MaxSize = Vector2.new(x, math.huge),
                MinSize = Vector2.new(0, var1.Size.Size_1700)
            }
        ),
        RatingImage = if tbl1.image then React.createElement(
            Image,
            {
                Image = tbl1.image,
                tag = "size-1700-1700",
                ScaleType = Enum.ScaleType.Fit,
                LayoutOrder = 1
            }
        ) else nil,
        RatingText = React.createElement(FoundationText, {
            Text = tbl1.displayText or "",
            tag = "fill auto-y text-wrap text-align-x-left",
            LayoutOrder = 2,
            fontStyle = tbl1.fontStyle
        })
    })
end)
