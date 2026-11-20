-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local _Types = require(Graphing.Types)
local InputDetector = require(Graphing.Components.InputDetector)
local StyleUtil = require(Graphing.Util.StyleUtil)

function ScrollbarButton(tbl1)
    return React.createElement("ImageButton", {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Rotation = tbl1.Rotation,
        Size = tbl1.Size,
        Image = tbl1.Image,
        BackgroundColor3 = tbl1.Color3 or StyleUtil.SCROLLBAR_BUTTON_COLOR3,
        ZIndex = tbl1.ZIndex
    }, {
        MouseDetector = React.createElement(InputDetector, {
            AnchorPoint = tbl1.AnchorPoint,
            OnClick = function()
                if tbl1.OnClick then
                    tbl1.OnClick()
                end
            end,
            OnDragMoved = function(arg1)
                if tbl1.OnMoved then
                    tbl1.OnMoved(arg1)
                end
            end
        })
    })
end

return ScrollbarButton
