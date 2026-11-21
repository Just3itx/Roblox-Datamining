-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)

local useDesignTokens = require(AvatarExperienceUIKitParent.Style).useDesignTokens
local RoactGamepad = require(AvatarExperienceUIKitParent.RoactGamepad)

return (React.forwardRef(function(tbl1, ref)
    local horizontalMargin = tbl1.horizontalMargin or 0
    local var1 = useDesignTokens()

    local createElement = React.createElement
    local frame = RoactGamepad.Focusable.Frame
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ref = ref,
        NextSelectionUp = tbl1.NextSelectionUp,
        NextSelectionDown = tbl1.NextSelectionDown,
        NextSelectionRight = tbl1.NextSelectionRight,
        NextSelectionLeft = tbl1.NextSelectionLeft,
        onFocusGained = tbl1.onFocusGained
    }
    local tbl3 = { GradientBackground = 0, WidgetListItemPadding = 0, Widget = 0 }
    local element

    if tbl1.hasBackground then
        element = React.createElement("Frame", {
            Size = UDim2.new(1, horizontalMargin * 2, 1, 0),
            Position = UDim2.new(0, -horizontalMargin, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1, 1, 1),
            ZIndex = -1
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, var1.Color.Surface.Surface_200.Color3), ColorSequenceKeypoint.new(1, var1.Color.Surface.Surface_0.Color3) })
            })
        })
    else
        element = nil
    end

    tbl3.GradientBackground = element

    tbl3.WidgetListItemPadding = if tbl1.padding then React.createElement("UIPadding", {
        PaddingBottom = tbl1.padding.bottom,
        PaddingTop = tbl1.padding.top,
        PaddingRight = tbl1.padding.right,
        PaddingLeft = tbl1.padding.left
    }) else nil

    tbl3.Widget = React.createElement(React.Fragment, nil, tbl1.children)
    return createElement(frame, tbl2, tbl3)
end))
