-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui").RobloxGui
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local setMouseVisibility = require(script.Parent.Parent.Util.setMouseVisibility)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local FrameHeight = Constants.TopBarFormatting.FrameHeight
local WindowPadding = Constants.Padding.WindowPadding
local MinSize = Constants.MainWindowInit.MinSize

local Components = scriptParentParent.Components
local DevConsoleTopBar = require(Components.DevConsoleTopBar)

local Actions = script.Parent.Parent.Actions
local ChangeDevConsoleSize = require(Actions.ChangeDevConsoleSize)
local SetDevConsoleVisibility = require(Actions.SetDevConsoleVisibility)
local SetDevConsoleMinimized = require(Actions.SetDevConsoleMinimized)

local var1 = Roact.PureComponent:extend("DevConsoleWindow")

function var1.onMinimizeClicked(arg1)
    arg1.props.dispatchSetDevConsoleMinimized(true)
end

function var1.onMaximizeClicked(arg1)
    arg1.props.dispatchSetDevConsoleMinimized(false)
end

function var1.onCloseClicked(arg1)
    arg1.props.onCloseCallback(false)
    arg1.props.dispatchSetDevConsolVisibility(false)
end

function var1.init(arg1)
    function arg1:setDevConsoleSize(arg2, arg3)
        local xOffset = arg3.X - arg2.X
        local yOffset = arg3.Y - arg2.Y

        if xOffset < MinSize.X then
            xOffset = MinSize.X or xOffset
        end

        if yOffset < MinSize.Y then
            yOffset = MinSize.Y or yOffset
        end
        self.props.dispatchChangeDevConsoleSize(UDim2.new(0, xOffset, 0, yOffset))
    end

    function arg1.resizeInputBegan(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        local connection = nil
        local connection2 = nil

        local function onInputEnded(input: InputObject)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
                connection2:Disconnect()
            end
        end

        connection = UserInputService.InputChanged:Connect(function(input: InputObject) -- name: onInputChanged
            local absolutePosition = arg1.ref.current.AbsolutePosition
            local inputPosition = input.Position
            arg1:setDevConsoleSize(absolutePosition, inputPosition)
        end)

        connection2 = UserInputService.InputEnded:Connect(onInputEnded)
    end

    function arg1.doGamepadMenuButton(arg2)
        if arg1.props.isVisible and (arg2.KeyCode == Enum.KeyCode.ButtonStart or arg2.KeyCode == Enum.KeyCode.Escape) then
            arg1.props.dispatchSetDevConsolVisibility(false)
        end
    end

    arg1.ref = Roact.createRef()

    arg1.state = { resizing = false }
end

function var1.didMount(arg1)
    delay(0, function()
        if arg1.ref.current then
            local absolutePosition = arg1.ref.current.AbsolutePosition
            local absolutePosition2 = arg1.ref.current.ResizeButton.AbsolutePosition
            arg1:setDevConsoleSize(absolutePosition, absolutePosition2)
        end
    end)
    setMouseVisibility(arg1.props.isVisible)

    arg1.gamepadMenuListener = UserInputService.InputBegan:Connect(arg1.doGamepadMenuButton)
end

function var1.willUnmount(arg1)
    if GuiService.SelectedCoreObject == arg1.ref.current then
        GuiService.SelectedCoreObject = nil
    end

    arg1.gamepadMenuListener:Disconnect()
end

function var1.didUpdate(arg1, arg2, _)
    setMouseVisibility(arg1.props.isVisible)

    if arg1.props.isMinimized and GuiService.SelectedCoreObject == arg1.ref.current then
        GuiService.SelectedCoreObject = nil
        return
    end

    if arg1.props.isVisible == arg2.isVisible and arg1.props.currTabIndex == arg2.currTabIndex then
        return
    end

    local userInputType = UserInputService:GetLastInputType()
    if Enum.UserInputType.Gamepad1 == userInputType and arg1.props.isVisible then
        GuiService.SelectedCoreObject = arg1.ref.current
        return
    end
    GuiService.SelectedCoreObject = nil
end

function var1.render(arg1)
    local isVisible = arg1.props.isVisible
    local formFactor = arg1.props.formFactor
    local isDeveloperView = arg1.props.isDeveloperView
    local currTabIndex = arg1.props.currTabIndex
    local tabList = arg1.props.tabList

    local isMinimized = arg1.props.isMinimized
    local position = arg1.props.position
    local size = arg1.props.size

    local _resizing = arg1.state.resizing

    local uDim2 = UDim2.new()

    local tbl1 = ({})
    local var2, num1

    if formFactor == Constants.FormFactor.Large then
        var2 = size
        num1 = 16
    else
        local absoluteSize = RobloxGui.AbsoluteSize
        var2 = UDim2.new(0, absoluteSize.X, 0, absoluteSize.Y)
        position = UDim2.new(0, 0, 0, 0)

        uDim2 = UDim2.new(0, 16, 0, 0)
        size = var2 + UDim2.new(0, -32, 0, 0)
        num1 = 0
    end

    tbl1.UIListLayout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, WindowPadding)
    })

    if isMinimized then
        tbl1.TopBar = Roact.createElement(DevConsoleTopBar, {
            LayoutOrder = 1,
            formFactor = formFactor,
            isMinimized = true,
            onMinimizeClicked = function()
                arg1:onMinimizeClicked()
            end,
            onMaximizeClicked = function()
                arg1:onMaximizeClicked()
            end,
            onCloseClicked = function()
                arg1:onCloseClicked()
            end
        })

        return Roact.createElement("Frame", {
            Position = UDim2.new(1, -500, 1, -2 * FrameHeight),
            Size = UDim2.new(0, 500, 0, 2 * FrameHeight),
            BackgroundColor3 = Color3.new(0, 0, 0),
            Transparency = Constants.MainWindowInit.Transparency,
            Active = true,
            AutoLocalize = false,
            Visible = isVisible,
            Selectable = true,
            BorderColor3 = Constants.Color.BaseGray,
            [Roact.Ref] = arg1.ref
        }, tbl1)
    end

    tbl1.TopBar = Roact.createElement(DevConsoleTopBar, {
        LayoutOrder = 1,
        formFactor = formFactor,
        isMinimized = false,
        onMinimizeClicked = function()
            arg1:onMinimizeClicked()
        end,
        onMaximizeClicked = function()
            arg1:onMaximizeClicked()
        end,
        onCloseClicked = function()
            arg1:onCloseClicked()
        end
    })

    local yOffset = FrameHeight + 2 * WindowPadding
    local var3 = size - UDim2.new(0, 0, 0, yOffset)

    if arg1.ref.current and isVisible and tabList then
        local var4 = tabList[currTabIndex]
        if var4 then
            tbl1.MainView = Roact.createElement(
                var4.tab,
                {
                    size = var3,
                    formFactor = formFactor,
                    isDeveloperView = isDeveloperView,
                    tabList = tabList
                }
            )
        end
    end
    local createElement = Roact.createElement
    local tbl2 = {
        Position = position,
        Size = var2,
        Visible = isVisible,
        BackgroundColor3 = Color3.new(0, 0, 0),
        Transparency = Constants.MainWindowInit.Transparency,
        BorderColor3 = Constants.Color.BaseGray,
        BorderSizePixel = num1,
        Active = true,
        AutoLocalize = false,
        Selectable = false,
        [Roact.Ref] = arg1.ref
    }
    local tbl3 = {
        DevConsoleUI = Roact.createElement("Frame", { Size = size, Position = uDim2, BackgroundTransparency = 1 }, tbl1),
        ResizeButton = Roact.createElement("ImageButton", {
            Position = UDim2.new(1, 0, 1, 0),
            Size = UDim2.new(0, num1, 0, num1),
            BackgroundColor3 = Color3.new(0, 0, 0),
            Modal = true,
            [Roact.Event.InputBegan] = arg1.resizeInputBegan
        })
    }
    return createElement("Frame", tbl2, tbl3)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        isVisible = arg1.DisplayOptions.isVisible,
        isMinimized = arg1.DisplayOptions.isMinimized,
        position = arg1.DisplayOptions.position,
        size = arg1.DisplayOptions.size,
        isDeveloperView = arg1.MainView.isDeveloperView,
        currTabIndex = arg1.MainView.currTabIndex,
        tabList = arg1.MainView.tabList
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchChangeDevConsoleSize = function(arg1)
            callback(ChangeDevConsoleSize(arg1))
        end,
        dispatchSetDevConsolVisibility = function(arg1)
            callback(SetDevConsoleVisibility(arg1))
        end,
        dispatchSetDevConsoleMinimized = function(arg1)
            callback(SetDevConsoleMinimized(arg1))
        end
    }
end)(var1)
