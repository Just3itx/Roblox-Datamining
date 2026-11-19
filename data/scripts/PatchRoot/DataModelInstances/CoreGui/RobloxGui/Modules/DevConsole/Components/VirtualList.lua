-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)

local var1 = Roact.Component:extend("VirtualList")

function var1.init(arg1)
    arg1.scrollingRef = Roact.createRef()
    arg1.state = { canvasPosY = 0, absSizeY = 0 }

    function arg1.onScrollPropertyChanged()
        local current = arg1.scrollingRef.current
        if not current then
            return
        end
        local canvasPositionY = current.CanvasPosition.Y
        local absoluteSizeY = current.AbsoluteSize.Y
        if canvasPositionY ~= arg1.state.canvasPosY or absoluteSizeY ~= arg1.state.absSizeY then
            arg1:setState({ canvasPosY = canvasPositionY, absSizeY = absoluteSizeY })
        end
    end
end

function var1.connectScrollListenersIfNeeded(arg1)
    local current = arg1.scrollingRef.current
    if current == arg1.connectedFrame then
        return
    end
    arg1:disconnectScrollListeners()
    if not current then
        return
    end
    arg1.connectedFrame = current
    arg1.canvasPosConnector = current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onScrollPropertyChanged)
    arg1.absSizeConnector = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(arg1.onScrollPropertyChanged)
    arg1.onScrollPropertyChanged()
end

function var1.disconnectScrollListeners(arg1)
    if arg1.canvasPosConnector then
        arg1.canvasPosConnector:Disconnect()
        arg1.canvasPosConnector = nil
    end
    if arg1.absSizeConnector then
        arg1.absSizeConnector:Disconnect()
        arg1.absSizeConnector = nil
    end
    arg1.connectedFrame = nil
end

function var1.didMount(arg1)
    arg1:connectScrollListenersIfNeeded()
end

function var1.willUnmount(arg1)
    arg1:disconnectScrollListeners()
end

function var1.didUpdate(arg1, arg2)
    arg1:connectScrollListenersIfNeeded()

    local current = arg1.scrollingRef.current
    if not current then
        return
    end

    local absoluteSizeY = current.AbsoluteSize.Y
    local canvasPositionY = current.CanvasPosition.Y
    if absoluteSizeY ~= arg1.state.absSizeY or canvasPositionY ~= arg1.state.canvasPosY then
        arg1:setState({ absSizeY = absoluteSizeY, canvasPosY = canvasPositionY })
    end

    local num1 = #(arg2.items or {})
    local num2 = #(arg1.props.items or {})
    if num1 == num2 then
        return
    end

    local y = math.min(canvasPositionY, math.max(0, num2 * arg1.props.rowHeight - absoluteSizeY))

    if y ~= current.CanvasPosition.Y then
        current.CanvasPosition = Vector2.new(current.CanvasPosition.X, y)
    end
    if y ~= arg1.state.canvasPosY then
        arg1:setState({ canvasPosY = y })
    end
end

function var1.render(arg1)
    local var2 = arg1.props.items or {}
    local rowHeight = arg1.props.rowHeight
    local renderItem = arg1.props.renderItem
    local num1 = #var2

    if num1 == 0 then
        return Roact.createElement("TextLabel", {
            Size = arg1.props.size or UDim2.new(1, 0, 1, 0),
            Position = arg1.props.position,
            LayoutOrder = arg1.props.layoutOrder,
            Text = arg1.props.emptyText or "",
            TextColor3 = Constants.Color.Text,
            TextTransparency = 0.5,
            BackgroundTransparency = 1
        })
    end

    local canvasPosY = arg1.state.canvasPosY
    local absSizeY = arg1.state.absSizeY

    local num2 = math.floor(canvasPosY / rowHeight) - 4 + 1
    local num3 = num2 + (math.ceil(absSizeY / rowHeight) + 8) - 1

    local tbl1 = ({})

    for i = math.clamp(num2, 1, num1), math.clamp(num3, 1, num1) do
        local str1 = "row" .. i
        tbl1[str1] = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, rowHeight),
            Position = UDim2.new(0, 0, 0, (i - 1) * rowHeight),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, {
            Item = renderItem(var2[i], i)
        })
    end

    return Roact.createElement("ScrollingFrame", {
        Size = arg1.props.size or UDim2.new(1, 0, 1, 0),
        Position = arg1.props.position,
        LayoutOrder = arg1.props.layoutOrder,
        CanvasSize = UDim2.new(0, 0, 0, num1 * rowHeight),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
        [Roact.Ref] = arg1.scrollingRef
    }, tbl1)
end

return var1
