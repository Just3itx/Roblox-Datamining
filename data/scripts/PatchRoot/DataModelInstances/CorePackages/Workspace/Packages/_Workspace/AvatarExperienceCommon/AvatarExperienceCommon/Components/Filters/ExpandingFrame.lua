-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local AnimatedFrame = require(AvatarExperienceCommonParent.UIBlox).Utility.SpringAnimatedItem.AnimatedFrame
local Dash = require(AvatarExperienceCommonParent.Dash)

local springOptions = { dampingRatio = 1, frequency = 3.5 }

local function ExpandingFrame(tbl2)
    local createElement = React.createElement
    local var1 = AnimatedFrame
    local tbl3 = {
        regularProps = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = tbl2.LayoutOrder,
            ClipsDescendants = true,
            ref = tbl2.frameRef,
            NextSelectionUp = tbl2.NextSelectionUp,
            NextSelectionDown = tbl2.NextSelectionDown,
            NextSelectionLeft = tbl2.NextSelectionLeft,
            NextSelectionRight = tbl2.NextSelectionRight,
            [React.Change.AbsoluteSize] = tbl2.onAbsoluteSizeChanged
        },
        animatedValues = {
            yOffset = if tbl2.isExpanded then tbl2.Size.Y.Offset else 0,
            yScale = if tbl2.isExpanded then tbl2.Size.Y.Scale else 0
        },
        mapValuesToProps = 0,
        springOptions = 0
    }

    function tbl3.mapValuesToProps(arg1)
        return {
            Size = UDim2.new(tbl2.Size.X.Scale, tbl2.Size.X.Offset, arg1.yScale, arg1.yOffset)
        }
    end

    tbl3.springOptions = springOptions
    return createElement(var1, tbl3, tbl2.children)
end

return React.forwardRef(function(arg1, frameRef)
    return React.createElement(ExpandingFrame, Dash.join(arg1, { frameRef = frameRef }))
end)
