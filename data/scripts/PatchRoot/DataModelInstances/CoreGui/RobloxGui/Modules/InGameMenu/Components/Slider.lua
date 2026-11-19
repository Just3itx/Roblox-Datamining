-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t
local Otter = InGameMenuDependencies.Otter

local FocusHandler = require(script.Parent.Connection.FocusHandler)

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParent = script.Parent.Parent

local divideTransparency = require(scriptParentParent.Utility.divideTransparency)

local AssetImage = require(script.Parent.AssetImage)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local tbl1 = { frequency = 5 }

local function isGamepad(userInputType: Enum.UserInputType): boolean
    return userInputType == Enum.UserInputType.Gamepad1
        or userInputType == Enum.UserInputType.Gamepad2
        or userInputType == Enum.UserInputType.Gamepad3
        or userInputType == Enum.UserInputType.Gamepad4
        or userInputType == Enum.UserInputType.Gamepad5
        or userInputType == Enum.UserInputType.Gamepad6
        or userInputType == Enum.UserInputType.Gamepad7
        or userInputType == Enum.UserInputType.Gamepad8
end

local tbl2 = ({})
local function getInputObjects()
    local userInputType = UserInputService:GetLastInputType()

    if not isGamepad(userInputType) then
        return nil
    end

    if tbl2[userInputType] == nil then
        local gamepadState = UserInputService:GetGamepadState(userInputType)
        local tbl3 = {}

        for _, inputObject in ipairs(gamepadState) do
            tbl3[inputObject.KeyCode] = inputObject
        end

        tbl2[userInputType] = tbl3
    end

    return tbl2[userInputType]
end

local var3 = Roact.PureComponent:extend("Slider")
var3.validateProps = t.intersection(
    t.strictInterface({
        min = t.number,
        max = t.number,
        stepInterval = t.numberPositive,
        value = t.number,
        valueChanged = t.callback,
        disabled = t.optional(t.boolean),
        width = t.optional(t.UDim),
        AnchorPoint = t.optional(t.Vector2),
        LayoutOrder = t.optional(t.integer),
        Position = t.optional(t.UDim2),
        canCaptureFocus = t.optional(t.boolean),
        isMenuOpen = t.optional(t.boolean),
        onSelectionLost = t.optional(t.callback),
        onSelectionGained = t.optional(t.callback),
        NextSelectionRight = t.optional(t.table),
        sliderDotRef = t.optional(t.union(t.callback, t.table))
    }),
    function(arg1)
        if arg1.min > arg1.max then
            return false, "min must be less than or equal to max"
        elseif arg1.value > arg1.max or arg1.value < arg1.min then
            return false, "value must be within min and max"
        end

        return true
    end
)

var3.defaultProps = {
    width = UDim.new(1, 0),
    disabled = false
}

function var3.init(arg1)
    arg1.state = { dragging = false, hovering = false, entryMode = false }

    arg1.totalMoveTime = 0
    arg1.isFirstMove = true
    arg1.unhandledTime = 0

    arg1.rootButtonRef = Roact.createRef()
    arg1.hoverRef = Roact.createRef()

    arg1.hoverMotor = Otter.createSingleMotor(0)
    arg1.hoverMotor:onStep(function(num1: number?)
        local current = arg1.hoverRef.current
        if current ~= nil then
            current.Size = UDim2.new(0, num1, 0, num1)
        end
    end)

    function arg1.onInputBegan(_, arg2)
        if arg1.props.disabled then
            return
        end

        local userInputType = arg2.UserInputType

        if userInputType ~= Enum.UserInputType.MouseButton1 and userInputType ~= Enum.UserInputType.Touch then
            return
        end

        local x = arg2.Position.X
        arg1:processDrag(x)
        arg1:startListeningForDrag()
    end
end

function var3.renderFocusHandler(arg1)
    return Roact.createElement(FocusHandler, {
        isFocused = arg1.state.entryMode and arg1.props.canCaptureFocus,
        didFocus = function()
            GuiService.CoreGuiNavigationEnabled = false

            arg1.joystickListener = RunService.Heartbeat:Connect(function(deltaTime: number)
                arg1:onMoveStep(deltaTime, (getInputObjects()))
            end)

            local value = arg1.props.value

            ContextActionService:BindCoreAction("LeaveEntryMode", function(_, userInputState)
                if userInputState ~= Enum.UserInputState.End then
                    return Enum.ContextActionResult.Pass
                end

                arg1:setState({ entryMode = false })
                arg1.props.valueChanged(value)
                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonB)
        end,
        didBlur = function()
            arg1.joystickListener:Disconnect()
            GuiService.CoreGuiNavigationEnabled = true
            ContextActionService:UnbindCoreAction("LeaveEntryMode")
            arg1:setState({ entryMode = false })
        end
    })
        or nil
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local min = arg1.props.min
    local var4 = arg1.props.max - min
    local xScale = (arg1.props.value - min) / var4
    local xScale2 = math.abs(xScale)
    local xScale3 = xScale / 2

    local canCaptureFocus = arg1.state.entryMode and arg1.props.canCaptureFocus

    return withFoundationOrUIBloxStyle(function(arg3)
        return {
            Theme = {
                UIMuted = {
                    Color = arg3.Color.Shift.Shift_100.Color3,
                    Transparency = arg3.Color.Shift.Shift_100.Transparency
                },
                ContextualPrimaryDefault = {
                    Color = arg3.Color.ActionEmphasis.Background.Color3,
                    Transparency = arg3.Color.ActionEmphasis.Background.Transparency
                }
            }
        }
    end, function(arg3)
        local createElement = Roact.createElement
        local var5 = ImageSetButton
        local tbl3 = {
            AnchorPoint = arg1.props.AnchorPoint,
            BackgroundTransparency = 1,
            Image = "",
            LayoutOrder = arg1.props.LayoutOrder,
            Position = arg1.props.Position,
            Size = UDim2.new(arg1.props.width.Scale, arg1.props.width.Offset, 0, 36),
            [Roact.Ref] = arg1.rootButtonRef,
            [Roact.Event.InputBegan] = arg1.onInputBegan,
            Selectable = false
        }
        local tbl4 = {
            FocusHandler = arg1:renderFocusHandler(),
            Gutter = Roact.createElement(AssetImage.Label, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                imageKey = "SliderCircle",
                ImageColor3 = arg3.Theme.UIMuted.Color,
                ImageTransparency = arg3.Theme.UIMuted.Transparency,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(1, 0, 0, 4)
            }, {
                FilledGutter = Roact.createElement(AssetImage.Label, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    imageKey = "SliderCircle",
                    ImageColor3 = arg3.Theme.ContextualPrimaryDefault.Color,
                    ImageTransparency = divideTransparency(arg3.Theme.ContextualPrimaryDefault.Transparency, if arg1.props.disabled then 2 else 1),
                    Position = UDim2.new(xScale3, 0, 0.5, 0),
                    Size = UDim2.new(xScale2, 0, 1, 0)
                })
            }),
            DotTrack = 0
        }

        local createElement2 = Roact.createElement
        local tbl5 = {
            Size = UDim2.new(1, -12, 1, 0),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            ZIndex = 4,
            Selectable = false
        }

        local tbl6 = { Dot = 0, HoverOverlay = 0 }
        local createElement3 = Roact.createElement
        local button = AssetImage.Button
        local tbl7 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            imageKey = "SliderButton",
            Position = UDim2.new(xScale, 0, 0.5, 0),
            Size = UDim2.new(0, 42, 0, 42),
            ImageTransparency = if arg1.props.disabled then 0.5 else 0,
            ZIndex = 2,
            SelectionImageObject = arg2(canCaptureFocus and var2.SelectedKnob or var2.UnselectedKnob)
        }
        tbl7[Roact.Event.Activated] = function(_, arg4)
            if arg4.KeyCode == Enum.KeyCode.ButtonA then
                arg1:setState({ entryMode = not arg1.state.entryMode })
            end
        end

        tbl7[Roact.Event.InputBegan] = function(arg4, arg5)
            if arg1.props.disabled then
                return
            end

            if arg5.UserInputType == Enum.UserInputType.MouseMovement then
                arg1:setState({ hovering = true })
            else
                arg1.onInputBegan(arg4, arg5)
            end
        end
        tbl7[Roact.Event.InputEnded] = function(_, arg4)
            if arg1.props.disabled then
                return
            end

            if arg4.UserInputType == Enum.UserInputType.MouseMovement then
                arg1:setState({ hovering = false })
            end
        end

        tbl7[Roact.Ref] = arg1.props.sliderDotRef
        tbl7[Roact.Event.SelectionLost] = arg1.props.onSelectionLost
        tbl7[Roact.Event.SelectionGained] = arg1.props.onSelectionGained
        tbl7.NextSelectionRight = arg1.props.NextSelectionRight
        tbl6.Dot = createElement3(button, tbl7)

        tbl6.HoverOverlay = Roact.createElement(AssetImage.Label, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            imageKey = "SliderHover",
            Position = UDim2.new(xScale, 0, 0.5, 0),
            Size = UDim2.new(0, 0, 0, 0),
            [Roact.Ref] = arg1.hoverRef
        })
        tbl4.DotTrack = createElement2("Frame", tbl5, tbl6)
        return createElement(var5, tbl3, tbl4)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var3.didMount(arg1)
    local current = arg1.rootButtonRef.current

    local connection = nil
    connection = current.AncestryChanged:Connect(function()
        if not current:IsDescendantOf(game) then
            return
        end

        connection:Disconnect()

        arg1.canUseUserInputService = current:FindFirstAncestorWhichIsA("PluginGui") == nil
    end)

    arg1.hoverMotor:start()
end

function var3.didUpdate(arg1)
    if arg1.props.disabled then
        arg1:stopListeningForDrag()
    end

    local num1 = if arg1.props.disabled or not (arg1.state.dragging or arg1.state.hovering) then 0 else 42

    arg1.hoverMotor:setGoal(Otter.spring(num1, tbl1))
end

function var3.willUnmount(arg1)
    arg1.hoverMotor:stop()
    arg1:disconnectDragEvents()
end

function var3.startListeningForDrag(arg1)
    local current = arg1.rootButtonRef.current
    if current == nil or arg1.state.dragging then
        return
    end

    if arg1.canUseUserInputService then
        arg1.moveConnection = UserInputService.InputChanged:Connect(function(input: InputObject)
            if not arg1.state.dragging then
                return
            end

            local userInputType = input.UserInputType

            if (userInputType == Enum.UserInputType.MouseMovement or userInputType == Enum.UserInputType.Touch)
                and input.UserInputState == Enum.UserInputState.Change
            then
                arg1:processDrag(input.Position.X)
            end
        end)
        arg1.releaseConnection = UserInputService.InputEnded:Connect(function(input: InputObject)
            local userInputType = input.UserInputType
            if userInputType ~= Enum.UserInputType.MouseButton1 and userInputType ~= Enum.UserInputType.Touch then
                return
            end

            arg1:stopListeningForDrag()
            arg1:processDrag(input.Position.X)
        end)

        arg1.focusLostConnection = UserInputService.WindowFocusReleased:Connect(function()
            arg1:stopListeningForDrag()
        end)
    else
        local pluginGui = current:FindFirstAncestorWhichIsA("PluginGui")

        local sliderPluginGuiInputCapturer = Instance.new("ImageButton")
        sliderPluginGuiInputCapturer.BackgroundTransparency = 1
        sliderPluginGuiInputCapturer.Image = ""
        sliderPluginGuiInputCapturer.Name = "SliderPluginGuiInputCapturer"
        sliderPluginGuiInputCapturer.Size = UDim2.new(1, 0, 1, 0)
        sliderPluginGuiInputCapturer.ZIndex = 100000
        arg1.moveConnection = sliderPluginGuiInputCapturer.MouseMoved:Connect(function(x: number)
            arg1:processDrag(x)
        end)

        arg1.releaseConnection = sliderPluginGuiInputCapturer.MouseButton1Up:Connect(function(x: number)
            arg1:stopListeningForDrag()
            arg1:processDrag(x)
        end)

        arg1.focusLostConnection = sliderPluginGuiInputCapturer.MouseLeave:Connect(function(x: number)
            arg1:stopListeningForDrag()
            arg1:processDrag(x)
        end)

        sliderPluginGuiInputCapturer.Parent = pluginGui
        arg1.inputCapturerButton = sliderPluginGuiInputCapturer
    end

    arg1:setState({ dragging = true })
end

function var3.processDrag(arg1, arg2)
    local current = arg1.rootButtonRef.current
    if current == nil then
        return
    end

    local min = arg1.props.min
    local max = arg1.props.max
    local stepInterval = arg1.props.stepInterval

    local absoluteSizeX = current.AbsoluteSize.X
    local var4 = math.floor(
        (math.clamp(arg2 - current.AbsolutePosition.X, 0, absoluteSizeX) / absoluteSizeX * (max - min) + min) / stepInterval + 0.5
    ) * stepInterval

    if var4 ~= arg1.props.value then
        arg1.props.valueChanged(var4)
    end
end

function var3.disconnectDragEvents(arg1)
    if arg1.moveConnection ~= nil then
        arg1.moveConnection:Disconnect()
        arg1.moveConnection = nil
    end

    if arg1.releaseConnection ~= nil then
        arg1.releaseConnection:Disconnect()
        arg1.releaseConnection = nil
    end

    if arg1.focusLostConnection ~= nil then
        arg1.focusLostConnection:Disconnect()
        arg1.focusLostConnection = nil
    end

    if arg1.inputCapturerButton ~= nil then
        arg1.inputCapturerButton:Destroy()
        arg1.inputCapturerButton = nil
    end
end

function var3.stopListeningForDrag(arg1)
    if not arg1.state.dragging then
        return
    end

    arg1:disconnectDragEvents()

    arg1:setState({ dragging = false })
end

function var3.processGamepadInput(arg1, arg2, arg3)
    local var4 = arg1.props.stepInterval * arg2
    local num1 = math.max(math.min(arg1.props.value + var4 * arg3, arg1.props.max), arg1.props.min)

    if num1 ~= arg1.props.value then
        arg1.props.valueChanged(num1)
    end
end

function var3.onMoveStep(arg1, arg2, arg3)
    local position = arg3[Enum.KeyCode.Thumbstick1].Position
    local bool1 = position.Magnitude > 0.2
    local num1 = 0

    arg1.totalMoveTime += arg2
    local var4, num2, num3

    if bool1 then
        var4 = if position.x > 0 then 1 else -1
        num2 = 0.2
        num3 = 12
    else
        var4 = (if arg3[Enum.KeyCode.DPadLeft].UserInputState == Enum.UserInputState.Begin then -1 else 0) + (if arg3[Enum.KeyCode.DPadRight].UserInputState == Enum.UserInputState.Begin then 1 else 0)
        num2 = 0.5
        num3 = 8
    end

    if var4 == 0 then
        arg1.totalMoveTime = 0
        arg1.isFirstMove = true
    elseif arg1.isFirstMove then
        arg1.isFirstMove = false
        arg1.totalMoveTime = 0
        arg1.unhandledTime = 0
        num1 = 1
    elseif num2 < arg1.totalMoveTime then
        local var5 = arg2 - math.max(num2 - arg1.totalMoveTime - arg2, 0) + arg1.unhandledTime
        num1 = math.floor(num3 * var5)

        arg1.unhandledTime = var5 - num1 / num3
    else
        arg1.unhandledTime = 0
        num1 = 0
    end

    if num1 > 0 then
        arg1:processGamepadInput(var4, num1)
    end
end

function var3.getDerivedStateFromProps(arg1): {entryMode: boolean}?
    return if arg1.isMenuOpen then nil else { entryMode = false }
end

return var3
