-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = game:GetService("CoreGui").RobloxGui
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Constants = require(script.Parent.Parent.Constants)
local FrameHeight = Constants.TopBarFormatting.FrameHeight
local var1 = 0.5 * FrameHeight
local yOffset = (FrameHeight - var1) / 2

local UserInputService = game:GetService("UserInputService")

local vector2 = TextService:GetTextSize("Developer Console", Constants.DefaultFontSize.TopBar, Constants.Font.TopBar, Vector2.new(0, 0))

local LiveUpdateElement = require(script.Parent.Parent.Components.LiveUpdateElement)
local SetDevConsolePosition = require(script.Parent.Parent.Actions.SetDevConsolePosition)

local var2 = Roact.Component:extend("DevConsoleTopBar")

function var2.init(arg1)
    arg1.inputChangedConnection = nil

    arg1.inputChangedDisconnectRetries = 0

    function arg1.inputBegan(_, arg2)
        if arg1.props.isMinimized then
            return
        end

        if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        local absolutePosition = arg1.ref.current.AbsolutePosition
        local vec3 = Vector3.new(absolutePosition.X, absolutePosition.Y, 0)

        if arg1.inputChangedConnection then
            arg1.inputChangedConnection:Disconnect()
            arg1.inputChangedConnection = nil
        end
        arg1.inputChangedConnection = UserInputService.InputChanged:Connect(function(input: InputObject)
            arg1.inputChanged(nil, input)
        end)

        arg1:setState({ startPos = vec3, startOffset = arg2.Position, moving = true })

        arg1.inputChangedDisconnectRetries = 1
    end

    function arg1.inputChanged(_, arg2)
        if arg1.state.moving then
            if arg2.UserInputType == Enum.UserInputType.MouseMovement then
                local var3 = arg1.state.startPos - arg1.state.startOffset + arg2.Position
                local uDim2 = UDim2.new(0, var3.X, 0, var3.Y)
                arg1.props.dispatchSetDevConsolePosition(uDim2)
            end

            return
        end
        if not arg1.inputChangedConnection then
            return
        end

        if arg1.inputChangedDisconnectRetries > 0 then
            arg1.inputChangedDisconnectRetries -= 1
            return
        end
        arg1.inputChangedConnection:Disconnect()
        arg1.inputChangedConnection = nil
    end

    function arg1.inputEnded(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 or arg2.UserInputState ~= Enum.UserInputState.End then
            return
        end

        if arg1.inputChangedConnection then
            arg1.inputChangedConnection:Disconnect()
            arg1.inputChangedConnection = nil
        end

        arg1:setState({ moving = false })
    end

    arg1.ref = Roact.createRef()
end

function var2.render(arg1)
    local isMinimized = arg1.props.isMinimized
    local formFactor = arg1.props.formFactor

    local onMinimizeClicked = arg1.props.onMinimizeClicked
    local onMaximizeClicked = arg1.props.onMaximizeClicked
    local onCloseClicked = arg1.props.onCloseClicked

    local _moving = arg1.state.moving

    local tbl1 = ({})

    tbl1.WindowTitle = Roact.createElement("TextLabel", {
        Text = "Developer Console",
        TextSize = Constants.DefaultFontSize.TopBar,
        TextColor3 = Color3.new(1, 1, 1),
        Font = Constants.Font.TopBar,
        Size = UDim2.new(0, vector2.X, 0, FrameHeight),
        Position = UDim2.new(0, 4, 0, 0),
        BackgroundColor3 = Constants.Color.BaseGray,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local xOffset = vector2.X + 8
    local uDim2 = UDim2.new(0, xOffset, 0, 0)
    local uDim2_2 = UDim2.new(1, -2 * xOffset, 0, FrameHeight)

    if isMinimized then
        uDim2 = UDim2.new(0, 0, 1, 0)
        uDim2_2 = UDim2.new(1, 0, 1, 0)
    elseif arg1.ref.current then
        uDim2_2 = UDim2.new(0, arg1.ref.current.AbsoluteSize.X - 2 * vector2.X, 0, FrameHeight)
    end

    local topBarLiveUpdate = arg1.props.topBarLiveUpdate

    tbl1.LiveStatsModule = Roact.createElement(LiveUpdateElement, { topBarLiveUpdate = topBarLiveUpdate, size = uDim2_2, position = uDim2 })

    if formFactor == Constants.FormFactor.Large then
        if not isMinimized then
            tbl1.MinButton = Roact.createElement("ImageButton", {
                Size = UDim2.new(0, var1, 0, var1),
                Position = UDim2.new(1, -2 * FrameHeight + yOffset, 0, yOffset),
                BorderColor3 = Color3.new(1, 0, 0),
                BackgroundColor3 = Constants.Color.BaseGray,
                BackgroundTransparency = 1,
                Image = Constants.Image.Minimize,
                [Roact.Event.Activated] = onMinimizeClicked
            })
        else
            tbl1.MaxButton = Roact.createElement("ImageButton", {
                Size = UDim2.new(0, var1, 0, var1),
                Position = UDim2.new(1, -2 * FrameHeight + yOffset, 0, yOffset),
                BorderColor3 = Color3.new(0, 0, 1),
                BackgroundColor3 = Constants.Color.BaseGray,
                BackgroundTransparency = 1,
                Image = Constants.Image.Maximize,
                [Roact.Event.Activated] = onMaximizeClicked
            })
        end
    end
    tbl1.CloseButton = Roact.createElement("ImageButton", {
        Size = UDim2.new(0, var1, 0, var1),
        Position = UDim2.new(1, -FrameHeight + yOffset, 0, yOffset),
        BorderColor3 = Color3.new(0, 1, 0),
        BackgroundColor3 = Constants.Color.BaseGray,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Image = Constants.Image.Close,
        [Roact.Event.Activated] = onCloseClicked
    })

    return Roact.createElement("ImageButton", {
        Size = UDim2.new(1, 0, 0, FrameHeight),
        BackgroundColor3 = Constants.Color.Black,
        BackgroundTransparency = 0.5,
        AutoButtonColor = false,
        LayoutOrder = 1,
        [Roact.Ref] = arg1.ref,
        [Roact.Event.InputBegan] = arg1.inputBegan,
        [Roact.Event.InputEnded] = arg1.inputEnded
    }, tbl1)
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetDevConsolePosition = function(arg1)
            callback(SetDevConsolePosition(arg1))
        end
    }
end)(var2)
