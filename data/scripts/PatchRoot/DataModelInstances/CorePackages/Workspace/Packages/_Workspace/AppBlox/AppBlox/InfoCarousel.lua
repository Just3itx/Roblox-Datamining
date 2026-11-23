-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local React = require(AppBloxParent.React)
local useDesignTokens = require(AppBloxParent.Style).useDesignTokens
local InfoCarouselCell = require(script.Parent.InfoCarouselCell)

return function(tbl1)
    local var1 = useDesignTokens()
    local offset = tbl1.padding or var1.Size.Size_600

    local var2, var3 = React.useBinding(0)

    local function func1(arg1)
        var3(arg1.AbsoluteSize.Y)
    end

    local tbl2 = ({})
    for value, value2 in tbl1.data do
        local var4 = "Cell" .. value
        tbl2[var4] = React.createElement(InfoCarouselCell, {
            LayoutOrder = value * 2,
            headerText = value2.headerText,
            bodyText = value2.bodyText,
            icon = value2.icon,
            iconSize = tbl1.iconSize,
            onActivated = value2.onActivated,
            padding = tbl1.cellPadding
        })
        if not (value < #tbl1.data) then
            continue
        end

        local var5 = "Divider" .. value

        tbl2[var5] = React.createElement("Frame", {
            LayoutOrder = value * 2 + 1,
            Size = var2:map(function(num1: number): UDim2
                return UDim2.fromOffset(1, num1 / 2)
            end),
            BorderColor3 = var1.Color.Stroke.Emphasis.Color3,
            BackgroundTransparency = var1.Color.Stroke.Emphasis.Transparency,
            BorderSizePixel = 0
        })
    end

    return React.createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ScrollBarThickness = 0,
        ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
        [React.Change.AbsoluteSize] = func1
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, offset)
        }),
        Cells = React.createElement(React.Fragment, {}, tbl2)
    })
end
