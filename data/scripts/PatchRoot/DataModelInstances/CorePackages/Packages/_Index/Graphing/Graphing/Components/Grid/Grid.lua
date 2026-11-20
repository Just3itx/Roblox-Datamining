-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)
local SignalsReact = require(GraphingParent.SignalsReact)

local CanvasContext = require(Graphing.CanvasContext)
local Types = require(Graphing.Types)
local GridLine = require(Graphing.Components.GridLine)
local GridUtil = require(Graphing.Util.GridUtil)
local StyleUtil = require(Graphing.Util.StyleUtil)

function Grid(tbl1)
    local var1 = React.useContext(CanvasContext)

    SignalsReact.useSignalState(var1.viewportRectGetter)

    local zIndex = tbl1.ZIndex or -1

    local var2 = not tbl1.XAxis and {} or GridUtil.getValues(Types.AXIS_X, tbl1.XAxis, var1)
    local var3 = not tbl1.YAxis and {} or GridUtil.getValues(Types.AXIS_Y, tbl1.YAxis, var1)
    local var4 = not tbl1.XAxisMinor and {} or GridUtil.getValues(Types.AXIS_X, tbl1.XAxisMinor, var1, var2)

    local var5 = not tbl1.YAxisMinor and {} or GridUtil.getValues(Types.AXIS_Y, tbl1.YAxisMinor, var1, var3)

    local tbl2 = ({})
    for _, value in var2 do
        local str1 = `X{value}`
        tbl2[str1] = React.createElement(GridLine, {
            Orientation = "Vertical",
            Position = value,
            Tag = tbl1.Tag,
            Color3 = StyleUtil.GRID_COLOR3,
            Thickness = StyleUtil.GRID_THICKNESS,
            Transparency = StyleUtil.GRID_TRANSPARENCY
        })
    end
    for _, value in var4 do
        local str1 = `Xm{value}`
        tbl2[str1] = React.createElement(GridLine, {
            Orientation = "Vertical",
            Position = value,
            Tag = tbl1.Tag,
            Color3 = StyleUtil.GRID_COLOR3_MINOR,
            Thickness = StyleUtil.GRID_THICKNESS_MINOR,
            Transparency = StyleUtil.GRID_TRANSPARENCY_MINOR
        })
    end
    for _, value in var3 do
        local str1 = `Y{value}`
        tbl2[str1] = React.createElement(GridLine, {
            Orientation = "Horizontal",
            Position = value,
            Tag = tbl1.Tag,
            Color3 = StyleUtil.GRID_COLOR3,
            Thickness = StyleUtil.GRID_THICKNESS,
            Transparency = StyleUtil.GRID_TRANSPARENCY
        })
    end
    for _, value in var5 do
        local str1 = `Ym{value}`
        tbl2[str1] = React.createElement(GridLine, {
            Orientation = "Horizontal",
            Position = value,
            Tag = tbl1.Tag,
            Color3 = StyleUtil.GRID_COLOR3_MINOR,
            Thickness = StyleUtil.GRID_THICKNESS_MINOR,
            Transparency = StyleUtil.GRID_TRANSPARENCY_MINOR
        })
    end

    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            ZIndex = zIndex,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        tbl2
    )
end

return Grid
