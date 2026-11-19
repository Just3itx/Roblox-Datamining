-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)

local bool1 = game:DefineFastFlag("DevConsoleFixMultilineContext", false)

local Components = script.Parent.Parent.Parent.Components
local BannerButton = require(Components.BannerButton)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainWindow = Constants.DefaultFontSize.MainWindow
local Log = Constants.Font.Log
local IconHeight = Constants.LogFormatting.IconHeight
local TextFrameHeight = Constants.LogFormatting.TextFrameHeight
local TextFramePadding = Constants.LogFormatting.TextFramePadding
local MaxStringSize = Constants.LogFormatting.MaxStringSize

local function countTextLinesInKeyValuePair(str1: string, str2: string): number -- Luacid: Inlined by compiler; 2 call sites recovered
    local _, var1 = string.gsub(`{str1}: {str2}`, "\n", "")
    return var1 + 1
end

local function countContextLines(tbl1, num1: number)
    local num2 = 0
    for value, value2 in tbl1 do
        if value == "_expanded" then
            continue
        end

        local bool2 = type(value2) == "table" and num1 + 1 < 3

        if bool1 and not bool2 then
            num2 += countTextLinesInKeyValuePair(tostring(value), tostring(value2))
        else
            num2 += 1
        end

        if bool2 and value2._expanded then
            num2 += countContextLines(value2, num1 + 1)
        end
    end

    return num2
end

local var1 = Roact.Component:extend("LogOutput")

function var1.init(arg1, arg2)
    local logData = arg2.initLogOutput and arg2.initLogOutput()

    function arg1.onCanvasChange()
        local current = arg1.ref.current
        if not current then
            return
        end

        local canvasPosition = current.CanvasPosition
        local absoluteSize = current.AbsoluteSize
        if arg1.state.canvasPos == canvasPosition and arg1.state.absSize == absoluteSize then
            return
        end

        local autoScroll = current.CanvasPosition.Y + current.AbsoluteSize.Y == current.CanvasSize.Y.Offset

        arg1:setState({ canvasPos = canvasPosition, absSize = absoluteSize, autoScroll = autoScroll })
    end

    arg1.ref = Roact.createRef()

    arg1.state = {
        logData = logData,
        absSize = Vector2.new(),
        canvasPos = Vector2.new(),
        autoScroll = true,
        wordWrap = true
    }
end

function var1.willUpdate(arg1, _, _)
    arg1._canvasSignal:Disconnect()
    arg1._absSizeSignal:Disconnect()
end

function var1.didUpdate(arg1)
    arg1._canvasSignal = arg1.ref.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasChange)
    arg1._absSizeSignal = arg1.ref.current:GetPropertyChangedSignal("AbsoluteSize"):Connect(arg1.onCanvasChange)

    if not arg1.state.autoScroll then
        return
    end

    local current = arg1.ref.current
    if current then
        current.CanvasPosition = Vector2.new(current.CanvasPosition.X, arg1.ref.current.CanvasSize.Y.Offset + arg1.ref.current.AbsoluteSize.Y)
    end
end

function var1.didMount(arg1)
    arg1.logConnector = arg1.props.targetSignal:Connect(function(logData)
        if arg1.state.autoScroll or logData:getSize() ~= logData:getMaxSize() then
            arg1:setState({ logData = logData })

            return
        end

        local canvasPos = arg1.state.canvasPos
        local canvasPosY = canvasPos.Y
        local var2 = logData:back()

        if var2 then
            local dimsY = var2.Dims.Y
            local var3 = arg1.state.absSize.X - TextFrameHeight

            if arg1.state.wordWrap and var3 > 0 then
                dimsY = math.ceil(var2.Dims.Y * math.ceil(var2.Dims.X / var3))
            end

            canvasPosY = math.max(0, canvasPosY - dimsY - TextFramePadding)
        end

        arg1:setState({ logData = logData, canvasPos = Vector2.new(canvasPos.X, canvasPosY) })
    end)
    arg1._canvasSignal = arg1.ref.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasChange)
    arg1._absSizeSignal = arg1.ref.current:GetPropertyChangedSignal("AbsoluteSize"):Connect(arg1.onCanvasChange)

    if arg1.ref.current.AbsoluteSize.Magnitude > 0 then
        arg1:setState({ absSize = arg1.ref.current.AbsoluteSize })
    end
end

function var1.willUnmount(arg1)
    arg1.logConnector:Disconnect()
    arg1.logConnector = nil
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size

    local logData = arg1.state.logData
    local absSize = arg1.state.absSize
    local canvasPos = arg1.state.canvasPos
    local wordWrap = arg1.state.wordWrap

    local tbl1 = ({})

    local num1 = 1
    local yOffset = 0

    if arg1.ref.current and logData then
        local var2 = absSize.X - TextFrameHeight

        local function createOnButtonPress(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
            return function()
                tbl2.Expanded = not tbl2.Expanded
                arg1:setState({})
            end
        end

        local function addContextEntries(tbl2, tbl3, color3: Color3, num2: number, tbl4)
            if num2 >= 3 then
                return
            end
            local tbl5 = {}
            for value in tbl3 do
                if value ~= "_expanded" then
                    table.insert(tbl5, value)
                end
            end
            table.sort(tbl5, function(arg2, arg3): boolean
                return tostring(arg2) < tostring(arg3)
            end)

            local num3 = num2 * 20 + 20

            for _, value in tbl5 do
                local var3 = tbl3[value]
                tbl4.i += 1
                local i = tbl4.i
                local str1 = `Ctx_{num2}_{tostring(value)}`

                if type(var3) == "table" and num2 + 1 < 3 then
                    local createElement = Roact.createElement
                    local var4 = BannerButton
                    local tbl6 = {
                        size = UDim2.new(1, 0, 0, MainWindow),
                        isExpanded = var3._expanded,
                        isExpandable = true,
                        layoutOrder = i,
                        hideLines = true,
                        onButtonPress = 0
                    }
                    function tbl6.onButtonPress()
                        var3._expanded = not var3._expanded
                        arg1:setState({})
                    end
                    local tbl7 = {
                        Label = Roact.createElement("TextLabel", {
                            Text = `{tostring(value)}: \{...}`,
                            TextSize = MainWindow,
                            Font = Log,
                            TextColor3 = color3,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, -(num3 + 20), 1, 0),
                            Position = UDim2.fromOffset(num3 + 20, 0),
                            TextXAlignment = Enum.TextXAlignment.Left
                        })
                    }
                    tbl2[str1] = createElement(var4, tbl6, tbl7)

                    if var3._expanded then
                        addContextEntries(tbl2, var3, color3, num2 + 1, tbl4)
                    end
                elseif bool1 then
                    local var4 = countTextLinesInKeyValuePair(tostring(value), tostring(var3))
                    local createElement = Roact.createElement
                    local tbl6 = {
                        Text = `{tostring(value)}: {tostring(var3)}`,
                        TextSize = MainWindow,
                        Font = Log,
                        TextColor3 = color3,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, var4 * MainWindow + (var4 - 1) * TextFramePadding),
                        LayoutOrder = i,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }
                    local tbl7 = {
                        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, num3 + 20) })
                    }
                    tbl2[str1] = createElement("TextLabel", tbl6, tbl7)
                else
                    local createElement = Roact.createElement
                    local tbl6 = {
                        Text = `{tostring(value)}: {tostring(var3)}`,
                        TextSize = MainWindow,
                        Font = Log,
                        TextColor3 = color3,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, MainWindow),
                        LayoutOrder = i,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }
                    local tbl7 = {
                        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, num3 + 20) })
                    }
                    tbl2[str1] = createElement("TextLabel", tbl6, tbl7)
                end
            end
        end

        local var3 = logData:iterator()
        local var4 = var3:next()
        local num2 = 0
        local yOffset2 = -1

        while var4 do
            local message = var4.Message
            local charCount = var4.CharCount

            local dimsY = var4.Dims.Y
            if wordWrap and var2 > 0 then
                dimsY = math.ceil(var4.Dims.Y * math.ceil(var4.Dims.X / var2))
            end

            local yOffset3

            if var4.Context then
                yOffset3 = MainWindow + TextFramePadding
                if var4.Expanded then
                    yOffset3 += countContextLines(var4.Context, 0) * (MainWindow + TextFramePadding)
                end
            else
                yOffset3 = 0
            end

            local yOffset4 = dimsY + yOffset3

            num1 += 1

            if yOffset + yOffset4 >= canvasPos.Y then
                if num2 < absSize.Y then
                    local constantsColorText = Constants.Color.Text
                    local str1 = ""

                    if var4.Type == Enum.MessageType.MessageOutput.Value then
                        constantsColorText = Constants.Color.Text
                    elseif var4.Type == Enum.MessageType.MessageInfo.Value then
                        constantsColorText = Constants.Color.HighlightBlue
                        str1 = Constants.Image.Info
                    elseif var4.Type == Enum.MessageType.MessageWarning.Value then
                        constantsColorText = Constants.Color.WarningYellow
                        str1 = Constants.Image.Warning
                    elseif var4.Type == Enum.MessageType.MessageError.Value then
                        constantsColorText = Constants.Color.ErrorRed
                        str1 = Constants.Image.Error
                    end

                    local tbl2 = ({})
                    if var4.Context then
                        tbl2.Layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, TextFramePadding) })

                        local createElement = Roact.createElement
                        local var5 = BannerButton
                        local tbl3 = {
                            size = UDim2.new(1, 0, 0, MainWindow),
                            isExpanded = var4.Expanded,
                            isExpandable = true,
                            layoutOrder = 0,
                            hideLines = true,
                            onButtonPress = createOnButtonPress(var4)
                        }
                        local tbl4 = {
                            Label = Roact.createElement("TextLabel", {
                                Text = "Context: {...}",
                                TextSize = MainWindow,
                                Font = Log,
                                TextColor3 = constantsColorText,
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, -20, 1, 0),
                                Position = UDim2.fromOffset(20, 0),
                                TextXAlignment = Enum.TextXAlignment.Left
                            })
                        }
                        tbl2.Header = createElement(var5, tbl3, tbl4)

                        if var4.Expanded then
                            addContextEntries(tbl2, var4.Context, constantsColorText, 0, { i = 0 })
                        end
                    end

                    local createElement = Roact.createElement
                    local str2 = "Frame"
                    local tbl3 = {
                        Size = UDim2.new(1, 0, 0, yOffset4),
                        BackgroundTransparency = 1,
                        LayoutOrder = num1
                    }
                    local tbl4 = {
                        image = Roact.createElement("ImageLabel", {
                            Image = str1,
                            Size = UDim2.new(0, IconHeight, 0, IconHeight),
                            Position = UDim2.new(0, IconHeight / 4, 0, (MainWindow - IconHeight) / 2),
                            BackgroundTransparency = 1
                        }),
                        msg = Roact.createElement("TextLabel", {
                            Text = message,
                            TextColor3 = constantsColorText,
                            TextSize = MainWindow,
                            Font = Log,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = wordWrap,
                            Size = UDim2.new(1, 0, 0, dimsY),
                            Position = UDim2.new(0, TextFrameHeight, 0, 0),
                            BackgroundTransparency = 1
                        }),
                        context = var4.Context
                            and Roact.createElement("Frame", {
                                Size = UDim2.new(1, -TextFrameHeight, 0, yOffset3),
                                Position = UDim2.new(0, TextFrameHeight, 0, dimsY + TextFramePadding),
                                BackgroundTransparency = 1
                            }, tbl2)
                    }
                    tbl1[num1] = createElement(str2, tbl3, tbl4)
                end

                if yOffset2 < 0 then
                    yOffset2 = yOffset
                else
                    num2 = num2 + yOffset4 + TextFramePadding
                end
            end

            yOffset = yOffset + yOffset4 + TextFramePadding

            if charCount < MaxStringSize then
                var4 = var3:next()
            else
                local string2 = string.format(
                    " -- Could not display entire %d character message because message exceeds max displayable length of %d",
                    charCount,
                    MaxStringSize
                )
                var4 = {
                    Message = string2,
                    CharCount = #string2,
                    Type = var4.Type,
                    Dims = TextService:GetTextSize(string2, MainWindow, Log, Vector2.new())
                }
            end
        end
        tbl1.UIListLayout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, TextFramePadding)
        })

        tbl1.WindowingPadding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset2), BackgroundTransparency = 1, LayoutOrder = 1 })
    end

    return Roact.createElement("ScrollingFrame", {
        Size = size,
        BackgroundTransparency = 1,
        VerticalScrollBarInset = 1,
        ScrollBarThickness = 6,
        CanvasSize = UDim2.new(0, 0, 0, yOffset),
        CanvasPosition = canvasPos,
        LayoutOrder = layoutOrder,
        [Roact.Ref] = arg1.ref
    }, tbl1)
end

return var1
