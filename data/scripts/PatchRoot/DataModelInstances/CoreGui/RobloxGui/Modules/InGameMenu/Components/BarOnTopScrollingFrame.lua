-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)

local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local var1 = Roact.PureComponent:extend("BarOnTopScrollingFrame")

var1.validateProps = t.strictInterface({
    Size = t.UDim2,
    Position = t.optional(t.UDim2),
    CanvasSize = t.UDim2,
    ScrollingEnabled = t.optional(t.boolean),
    [Roact.Children] = t.table,
    onCanvasPositionChanged = t.optional(t.callback),
    scrollingFrameRef = t.optional(t.table)
})

var1.defaultProps = { ScrollingEnabled = true }

function var1.init(arg1)
    arg1.state = {
        CanvasPosition = Vector2.new(0, 0)
    }
end

function var1.render(arg1)
    local createElement = Roact.createElement
    local tbl1 = {
        Size = arg1.props.Size,
        Position = arg1.props.Position,
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl2 = { DisplayScrollingFrame = 0, ContentsScrollingFrame = 0 }
    local createElement2 = Roact.createElement
    local tbl3 = {
        CanvasPosition = arg1.state.CanvasPosition,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 8, 1, 0),
        CanvasSize = arg1.props.CanvasSize - UDim2.new(0, 8, 0, 0),
        ScrollBarThickness = 8,
        BorderSizePixel = 0,
        ZIndex = 2,
        Position = UDim2.new(1, -8, 0, 0),
        ScrollingEnabled = arg1.props.ScrollingEnabled,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false,
        [Roact.Ref] = arg1.props.scrollingFrameRef
    }

    tbl3[Roact.Change.CanvasPosition] = function(arg2)
        arg1:setState({ CanvasPosition = arg2.CanvasPosition })

        if arg1.props.onCanvasPositionChanged then
            arg1.props.onCanvasPositionChanged(arg2)
        end
    end

    tbl2.DisplayScrollingFrame = createElement2("ScrollingFrame", tbl3)

    local createElement3 = Roact.createElement
    local tbl4 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -8, 1, 0),
        CanvasSize = arg1.props.CanvasSize - UDim2.new(0, 8, 0, 0),
        CanvasPosition = arg1.state.CanvasPosition,
        ScrollBarThickness = 0,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        ScrollingEnabled = arg1.props.ScrollingEnabled,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false
    }

    tbl4[Roact.Change.CanvasPosition] = function(arg2)
        arg1:setState({ CanvasPosition = arg2.CanvasPosition })
    end

    tbl2.ContentsScrollingFrame = createElement3("ScrollingFrame", tbl4, { Roact.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 8, 1, 0) }, arg1.props[Roact.Children]) })
    return createElement("Frame", tbl1, tbl2)
end

return var1
