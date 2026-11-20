-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local _Types = require(Graphing.Types)
local Positioner = require(Graphing.Components.Positioner)
local StyleUtil = require(Graphing.Util.StyleUtil)

function Point(tbl1)
    local var1 = tbl1.Size or StyleUtil.POINT_HANDLE_SIZE
    local var2 = tbl1.OutlineThickness or StyleUtil.POINT_HANDLE_OUTLINE_THICKNESS
    local imageColor3 = tbl1.Color3 or StyleUtil.POINT_HANDLE_COLOR3
    local var4 = tbl1.OutlineColor3 or StyleUtil.POINT_HANDLE_OUTLINE_COLOR3

    local createElement = React.createElement
    local var5 = Positioner
    local tbl2 = {
        Position = tbl1.Position,
        ZIndex = tbl1.ZIndex,
        ref = tbl1.positionerRef
    }
    local tbl3 = { Outer = 0, Inner = 0 }
    local createElement2 = React.createElement
    local str1 = "ImageButton"
    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(var1 + 2 * var2, var1 + 2 * var2),
        Image = tbl1.Image or StyleUtil.POINT_HANDLE_IMAGE
    }

    if var2 == 0 then
        var4 = imageColor3
    end

    tbl4.ImageColor3 = var4
    tbl4.ImageTransparency = tbl1.Transparency
    tbl4.BackgroundTransparency = 1
    tbl4.ZIndex = 1
    tbl4[React.Tag] = tbl1.Tag
    tbl3.Outer = createElement2(str1, tbl4, tbl1.children)
    local element

    if var2 > 0 then
        element = React.createElement("ImageButton", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(var1, var1),
            Interactable = false,
            Selectable = false,
            Image = tbl1.Image or StyleUtil.POINT_HANDLE_IMAGE,
            ImageColor3 = imageColor3,
            ImageTransparency = tbl1.Transparency,
            BackgroundTransparency = 1,
            ZIndex = 2,
            [React.Tag] = tbl1.Tag
        })
    else
        element = false
    end

    tbl3.Inner = element
    return createElement(var5, tbl2, tbl3)
end

return Point
