-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local React = require(MomentsCreationFlowParent.React)

local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        AnchorPoint = tbl1.anchorPoint,
        tag = "bg-system-contrast radius-medium size-300-1000",
        Position = tbl1.position
    }
    local tbl3 = {
        OutlineStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = var1.Color.System.Contrast.Color3,
            Transparency = var1.Color.System.Contrast.Transparency,
            Thickness = var1.Stroke.Thicker
        }),
        Line = React.createElement(
            View,
            {
                tag = "anchor-center-center bg-surface-300 size-100-400 position-center-center radius-circle",
                ZIndex = 2
            }
        ),
        Box = React.createElement(View, {
            Position = if tbl1.isFlipped then UDim2.new(0, var1.Size.Size_50, 0.5, 0) else UDim2.new(1, -var1.Size.Size_50, 0.5, 0),
            tag = "anchor-center-center bg-system-contrast size-100-1000"
        }, {
            OutlineStroke = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = var1.Color.System.Contrast.Color3,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Transparency = var1.Color.System.Contrast.Transparency,
                Thickness = var1.Stroke.Thicker
            })
        }),
        DragDetector = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
            ref = tbl1.dragDetectorRef,
            ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale
        })
    }
    return createElement(var2, tbl2, tbl3)
end
