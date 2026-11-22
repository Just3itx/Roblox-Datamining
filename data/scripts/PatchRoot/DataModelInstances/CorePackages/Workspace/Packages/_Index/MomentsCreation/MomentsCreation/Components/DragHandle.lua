-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        AnchorPoint = tbl1.anchorPoint,
        tag = "size-300-1000 radius-medium bg-system-contrast",
        Position = tbl1.position,
        stroke = {
            Color = var1.Color.System.Contrast.Color3,
            Transparency = var1.Color.System.Contrast.Transparency,
            Thickness = var1.Stroke.Thicker
        }
    }
    local tbl3 = {
        Line = React.createElement(
            View,
            {
                tag = "position-center-center anchor-center-center size-100-400 radius-circle bg-surface-300",
                ZIndex = 2
            }
        ),
        Box = React.createElement(View, {
            Position = if tbl1.isFlipped then UDim2.new(0, var1.Size.Size_50, 0.5, 0) else UDim2.new(1, -var1.Size.Size_50, 0.5, 0),
            tag = "anchor-center-center size-100-1000 bg-system-contrast",
            stroke = {
                Color = var1.Color.System.Contrast.Color3,
                Transparency = var1.Color.System.Contrast.Transparency,
                Thickness = var1.Stroke.Thicker
            }
        }),
        DragDetector = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
            ref = tbl1.dragDetectorRef,
            ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
        })
    }
    return createElement(var2, tbl2, tbl3)
end
