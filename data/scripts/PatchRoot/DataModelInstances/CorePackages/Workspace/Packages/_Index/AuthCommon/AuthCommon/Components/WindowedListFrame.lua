-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Roact = require(AuthCommonParent.Roact)
local ArgCheck = require(AuthCommonParent.ArgCheck)

local Graphite = require(AuthCommonParent.Style).Colors.Graphite

local var1 = Roact.PureComponent:extend("WindowedListFrame")

function var1.init(arg1)
    arg1.state = { windowStart = 1, windowSize = 5, topPadding = 0 }

    function arg1.updateWindow(arg2)
        local var2 = arg1.props.ButtonSizeY + 1

        local absoluteSizeY = arg2.AbsoluteSize.Y
        local canvasPositionY = arg2.CanvasPosition.Y

        if not (absoluteSizeY > 0) then
            return
        end

        local windowStart = math.max(1, math.floor(canvasPositionY / var2) + 1)
        local windowSize = math.floor(absoluteSizeY / var2) + 2

        if windowStart == arg1.state.windowStart and windowSize == arg1.state.windowSize then
            return
        end

        arg1:setState({ windowStart = windowStart, windowSize = windowSize, topPadding = var2 * (windowStart - 1) })
    end
end

var1.defaultProps = {
    List = {},
    ButtonSizeY = 20,
    ScrollingFrameOffset = 0,
    ListButtonProps = {}
}

function var1.render(arg1)
    local listButton = arg1.props.ListButton
    local listButtonProps = arg1.props.ListButtonProps
    local list = arg1.props.List

    local listLen = #list
    local tbl1 = { Roact.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical
            }
        ) }

    ArgCheck.isInTypes(listButton, { "function", "table" }, "ListButton prop in WindowedListFrame")
    if listButton then
        local windowStart = arg1.state.windowStart
        local windowSize = arg1.state.windowSize

        local listLen2 = #list
        local var2 = windowStart + windowSize

        for i = windowStart, math.min(listLen2, var2) do
            local var3 = list[i]
            local layoutOrder = i + i
            tbl1[layoutOrder] = Roact.createElement(listButton, {
                Size = UDim2.new(1, 0, 0, arg1.props.ButtonSizeY),
                LayoutOrder = layoutOrder,
                Data = var3,
                ListButtonProps = listButtonProps
            })
            local num1 = layoutOrder + 1
            tbl1[num1] = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Graphite,
                    LayoutOrder = num1,
                    BorderSizePixel = 0
                }
            )
        end
    end

    return Roact.createElement("ScrollingFrame", {
        Position = UDim2.new(0, 0, 0, arg1.props.ScrollingFrameOffset),
        Size = UDim2.new(1, 8, 1, -arg1.props.ScrollingFrameOffset),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Graphite,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, listLen * (arg1.props.ButtonSizeY + 1)),
        [Roact.Change.CanvasPosition] = arg1.updateWindow,
        [Roact.Change.AbsoluteSize] = arg1.updateWindow
    }, {
        ListHolder = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, -8, 0, 1),
                Position = UDim2.new(0, 0, 0, arg1.state.topPadding),
                BackgroundTransparency = 1
            },
            tbl1
        )
    })
end

return var1
