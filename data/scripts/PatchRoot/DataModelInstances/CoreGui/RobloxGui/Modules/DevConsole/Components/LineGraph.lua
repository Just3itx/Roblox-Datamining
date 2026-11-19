-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local LineGraphHoverDisplay = require(script.Parent.LineGraphHoverDisplay)

local Constants = require(script.Parent.Parent.Constants)
local ConstantsColorText = Constants.Color.Text
local HighlightBlue = Constants.Color.HighlightBlue
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local PointWidth = Constants.Graph.PointWidth
local PointOffset = Constants.Graph.PointOffset
local Padding = Constants.Graph.Padding
local Scale = Constants.Graph.Scale
local InnerPaddingY = Constants.Graph.InnerPaddingY
local InnerScaleY = Constants.Graph.InnerScaleY
local TextPadding = Constants.Graph.TextPadding

local var1 = Roact.Component:extend("LineGraph")

function var1.init(arg1)
    function arg1.onGraphInputChanged(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseMovement and not arg1.state.holdPos then
            arg1:setState({ inputPosition = arg2.Position })
        end
    end

    function arg1.onGraphInputEnded(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseMovement then
            if not arg1.state.holdPos then
                arg1:setState({ inputPosition = false })
            end
        elseif arg2.UserInputType == Enum.UserInputType.MouseButton1 then
            arg1:setState({ holdPos = not arg1.state.holdPos })
        end
    end

    arg1.graphRef = Roact.createRef()
    arg1.state = {
        selectedTimeStamps = {}
    }
end

function var1.didUpdate(arg1)
    if arg1.state.absGraphSize ~= arg1.graphRef.current.AbsoluteSize then
        arg1:setState(
            {
                absGraphSize = arg1.graphRef.current.AbsoluteSize,
                absGraphPos = arg1.graphRef.current.AbsolutePosition
            }
        )
    end
end

function var1.didMount(arg1)
    arg1:setState(
        {
            absGraphSize = arg1.graphRef.current.AbsoluteSize,
            absGraphPos = arg1.graphRef.current.AbsolutePosition
        }
    )
end

function var1.render(arg1)
    local size = arg1.props.size
    local pos = arg1.props.pos

    local graphData = arg1.props.graphData

    local getX = arg1.props.getX
    local getY = arg1.props.getY

    local stringFormatX = arg1.props.stringFormatX
    local stringFormatY = arg1.props.stringFormatY

    local axisLabelX = arg1.props.axisLabelX
    local axisLabelY = arg1.props.axisLabelY

    local layoutOrder = arg1.props.layoutOrder

    local inputPosition = arg1.state.inputPosition
    local absGraphSize = arg1.state.absGraphSize
    local absGraphPos = arg1.state.absGraphPos

    local x = getX(graphData:back())
    local x2 = getX(graphData:front())
    local maxY = arg1.props.maxY
    local minY = arg1.props.minY

    local var2 = nil

    local tbl1 = ({})
    if absGraphSize then
        local var3 = graphData:iterator()
        local var4 = var3:next()
        local tbl2 = {}

        while var4 do
            local y = getY(var4)
            local x3 = getX(var4)

            local var5 = x - x2
            local var6 = var5 > 0 and (x3 - x2) / var5 or 0

            local var7 = maxY - minY
            table.insert(tbl2, { X = var6, Y = var7 > 0 and (y - minY) / var7 or 1, data = var4 })

            var4 = var3:next()
        end

        for i = 2, #tbl2 do
            local xOffset = tbl2[i].X * absGraphSize.X
            local var5 = tbl2[i].Y * absGraphSize.Y * InnerScaleY
            local var6 = tbl2[i - 1].X * absGraphSize.X
            local var7 = tbl2[i - 1].Y * absGraphSize.Y * InnerScaleY

            if xOffset == var6 then
                continue
            end

            local var8 = (xOffset + var6) / 2
            local var9 = (var5 + var7) / 2

            local var10 = xOffset - var6
            local var11 = var5 - var7

            local xOffset2 = math.sqrt(var10 * var10 + var11 * var11)
            local num1 = math.deg(math.atan2(var11, var10))

            table.insert(
                tbl1,
                Roact.createElement("Frame", {
                    Size = UDim2.new(0, xOffset2, 0, LineWidth),
                    Position = UDim2.new(0, var8 - xOffset2 / 2, 1 - InnerPaddingY, -var9),
                    BackgroundColor3 = HighlightBlue,
                    BorderSizePixel = 0,
                    Rotation = -num1
                })
            )

            table.insert(
                tbl1,
                Roact.createElement("Frame", {
                    Size = UDim2.new(0, PointWidth, 0, PointWidth),
                    Position = UDim2.new(0, xOffset, 1 - InnerPaddingY, -var5 - PointOffset),
                    BackgroundColor3 = HighlightBlue,
                    BorderSizePixel = 0
                })
            )

            if not inputPosition then
                continue
            end

            local hoverLineX = inputPosition.X - absGraphPos.X
            if not (hoverLineX < xOffset and var6 < hoverLineX) then
                continue
            end

            local x3 = getX(tbl2[i].data)
            local x4 = getX(tbl2[i - 1].data)
            local y = getY(tbl2[i].data)
            local y2 = getY(tbl2[i - 1].data)

            local var13 = (hoverLineX - var6) / var10
            var2 = var7 + var11 * var13

            local hoverValX = (x3 - x4) * var13 + x4
            local hoverValY = (y - y2) * var13 + y2

            tbl1.HoverDetails = Roact.createElement(LineGraphHoverDisplay, {
                hoverLineX = hoverLineX,
                hoverLineY = var2,
                hoverValX = hoverValX,
                hoverValY = hoverValY,
                stringFormatX = stringFormatX,
                stringFormatY = stringFormatY
            })
        end

        if #tbl2 > 0 then
            local var5 = tbl2[#tbl2].Y * absGraphSize.Y * InnerScaleY
            local y = getY(tbl2[#tbl2].data)
            local bool1 = var2 and math.abs(var5 - var2) < 10
            local bool2 = not (var2 and math.abs(var2) < 10 or math.abs(var5) < 10)

            if not bool1 then
                tbl1.LatestEntryLine = Roact.createElement("Frame", {
                    Size = UDim2.new(1, TextPadding, 0, LineWidth),
                    Position = UDim2.new(0, -TextPadding, 1 - InnerPaddingY, -var5),
                    BackgroundColor3 = LineColor,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0
                })

                local createElement = Roact.createElement
                local str1 = "TextLabel"
                local tbl3 = {
                    Text = 0,
                    TextColor3 = 0,
                    TextXAlignment = 0,
                    Position = 0,
                    BackgroundTransparency = 1
                }

                if stringFormatY then
                    y = stringFormatY(y) or y
                end

                tbl3.Text = y
                tbl3.TextColor3 = ConstantsColorText
                tbl3.TextXAlignment = Enum.TextXAlignment.Right

                tbl3.Position = UDim2.new(0, -TextPadding - 2, 1 - InnerPaddingY, -var5)
                tbl1.LatestEntryText = createElement(str1, tbl3)
            end

            if bool2 then
                local createElement = Roact.createElement
                local str1 = "TextLabel"
                local tbl3 = {
                    Text = 0,
                    TextColor3 = 0,
                    TextXAlignment = 0,
                    Position = 0,
                    BackgroundTransparency = 1
                }

                if stringFormatY then
                    minY = stringFormatY(minY) or minY
                end

                tbl3.Text = minY
                tbl3.TextColor3 = ConstantsColorText
                tbl3.TextXAlignment = Enum.TextXAlignment.Right

                tbl3.Position = UDim2.new(0, -TextPadding - 2, 1 - InnerPaddingY, 0)
                tbl1.AxisTextY0 = createElement(str1, tbl3)
            end

            tbl1.AxisX = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, LineWidth),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })

            tbl1.AxisY = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(0, LineWidth, 1, 0),
                    BackgroundColor3 = LineColor,
                    BorderSizePixel = 0
                }
            )
        end
    end

    local yOffset = 2 * TextPadding + 2

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = size,
        Position = pos,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    local tbl3 = {
        name = Roact.createElement("TextLabel", {
            Text = axisLabelY,
            TextColor3 = ConstantsColorText,
            TextXAlignment = Enum.TextXAlignment.Left,
            Position = UDim2.new(Padding, 0, Padding, -TextPadding),
            BackgroundTransparency = 1
        }),
        minX = 0,
        maxX = 0,
        axisLabelX = 0,
        graph = 0
    }

    local createElement2 = Roact.createElement
    local str2 = "TextLabel"
    local tbl4 = {
        Text = 0,
        TextColor3 = 0,
        TextXAlignment = 0,
        Position = 0,
        BackgroundTransparency = 1
    }

    if stringFormatX then
        x2 = stringFormatX(x2) or x2
    end

    tbl4.Text = x2
    tbl4.TextColor3 = ConstantsColorText
    tbl4.TextXAlignment = Enum.TextXAlignment.Center

    tbl4.Position = UDim2.new(Padding, 0, Padding + Scale, yOffset)
    tbl3.minX = createElement2(str2, tbl4)

    local createElement3 = Roact.createElement
    local str3 = "TextLabel"
    local tbl5 = {
        Text = 0,
        TextColor3 = 0,
        TextXAlignment = 0,
        Position = 0,
        BackgroundTransparency = 1
    }

    if stringFormatX then
        x = stringFormatX(x) or x
    end

    tbl5.Text = x
    tbl5.TextColor3 = ConstantsColorText
    tbl5.TextXAlignment = Enum.TextXAlignment.Center

    tbl5.Position = UDim2.new(Padding + Scale, 0, Padding + Scale, yOffset)
    tbl3.maxX = createElement3(str3, tbl5)

    tbl3.axisLabelX = Roact.createElement("TextLabel", {
        Text = axisLabelX,
        TextColor3 = ConstantsColorText,
        TextXAlignment = Enum.TextXAlignment.Center,
        Position = UDim2.new(0.5, 0, Padding + Scale, yOffset),
        BackgroundTransparency = 1
    })

    tbl3.graph = Roact.createElement("Frame", {
        Position = UDim2.new(Padding, 0, Padding, 0),
        Size = UDim2.new(Scale, 0, Scale, 0),
        BackgroundTransparency = 1,
        [Roact.Ref] = arg1.graphRef,
        [Roact.Event.InputChanged] = arg1.onGraphInputChanged,
        [Roact.Event.InputEnded] = arg1.onGraphInputEnded
    }, tbl1)
    return createElement(str1, tbl2, tbl3)
end

return var1
