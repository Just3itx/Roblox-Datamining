-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)

local function splitInputType(arg1): (boolean, boolean, boolean, boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
    local bool1 = arg1.UserInputType == Enum.UserInputType.Touch
    local bool2 = arg1.UserInputType == Enum.UserInputType.MouseButton1
    local bool3 = arg1.UserInputType == Enum.UserInputType.MouseButton2
    return bool1, bool2 or bool3, bool2, bool3
end

local var1 = Roact.PureComponent:extend("InteractionFrame")

var1.defaultProps = { Visible = true }

var1.validateProps = t.interface({
    panByPixels = t.callback,
    rotateByPixels = t.callback,
    setAngularVelocityByPixels = t.callback,
    zoomToPoint = t.callback,
    doubleTap = t.optional(t.callback),
    Size = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    Visible = t.optional(t.boolean),
    ZIndex = t.optional(t.number)
})

function var1.disconnectEvents(arg1)
    arg1.inputChangedConnection:Disconnect()
    arg1.inputEndedConnection:Disconnect()
    arg1.renderSteppedConnection:Disconnect()
    arg1.inputChangedConnection = nil
    arg1.inputEndedConnection = nil
    arg1.renderSteppedConnection = nil
end

function var1.getActiveInput(arg1, arg2)
    local bool1, bool2, _, _ = splitInputType(arg2)
    local bool3 = arg2.UserInputType == Enum.UserInputType.MouseMovement or bool2

    if not bool3 and not bool1 then
        return
    end

    local activeTouchInput = nil
    if bool3 then
        return arg1.activeMouseInput
    end

    if bool1 then
        activeTouchInput = arg1.activeTouchInputs[arg2]
    end

    return activeTouchInput
end

function var1.removeActivePointerInput(arg1, arg2, arg3)
    if arg3 then
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        then
            return
        end

        arg1.activeMouseInput = nil
    else
        arg1.activeTouchInputs[arg2] = nil
        arg1.numActiveTouchInputs -= 1
    end
    arg1.numActiveInputs -= 1

    if arg1.numActiveInputs == 0 then
        arg1:disconnectEvents()
    end
end

function var1.handleDoubleTap(arg1, arg2, lastPrimaryPointerInputBeganTime)
    if arg1.lastPrimaryPointerInputBeganPosition then
        local var2 = arg1.lastPrimaryPointerInputBeganPosition - arg2.Position
        local var3 = lastPrimaryPointerInputBeganTime - arg1.lastPrimaryPointerInputBeganTime

        if arg1.props.doubleTap and var2.Magnitude < 30 and var3 < 0.25 then
            arg1.props.doubleTap()
        end
    end

    arg1.lastPrimaryPointerInputBeganPosition = arg2.Position
    arg1.lastPrimaryPointerInputBeganTime = lastPrimaryPointerInputBeganTime
end

function var1.addActivePointerInput(arg1, arg2, arg3, lastTime)
    if arg1:getActiveInput(arg2) then
        return
    end

    local activeMouseInput = {
        lastPosition = arg2.Position,
        lastTime = lastTime
    }

    if arg3 then
        arg1.activeMouseInput = activeMouseInput
    else
        arg1.activeTouchInputs[arg2] = Cryo.Dictionary.join(activeMouseInput, { lastDeltaTime = 0, lastDeltaPosition = Vector3.new(0, 0, 0) })

        arg1.numActiveTouchInputs += 1
    end
    arg1.numActiveInputs += 1

    if arg1.numActiveInputs == 1 then
        arg1.props.setAngularVelocityByPixels(0)
        arg1.inputChangedConnection = UserInputService.InputChanged:Connect(arg1.onInputChanged)
        arg1.inputEndedConnection = UserInputService.InputEnded:Connect(arg1.onInputEnded)
        arg1.renderSteppedConnection = RunService.RenderStepped:Connect(arg1.setInputNotChanged)
    end
end

function var1.init(arg1)
    arg1.inputChangedConnection = nil
    arg1.inputEndedConnection = nil

    arg1.lastPinchDistance = 1
    arg1.lastPanTime = 0
    arg1.lastPrimaryPointerInputBeganTime = 0
    arg1.lastPrimaryPointerInputBeganPosition = nil

    arg1.activeTouchInputs = {}
    arg1.numActiveTouchInputs = 0
    arg1.activeMouseInput = nil

    arg1.numActiveInputs = 0

    function arg1.handleScroll(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseWheel then
            local var2 = -arg2.Position.Z
            arg1.props.zoomToPoint(var2, UserInputService:GetMouseLocation())
        end
    end

    function arg1.setInputNotChanged(_)
        for _, activeTouchInput in arg1.activeTouchInputs do
            activeTouchInput.changedThisFrame = false
        end
    end

    function arg1.onInputChanged(arg2, _)
        local bool1 = arg2.UserInputType == Enum.UserInputType.MouseMovement
        local bool2 = arg2.UserInputType == Enum.UserInputType.Touch
        if not (bool1 or bool2) then
            return
        end

        local activeInput = arg1:getActiveInput(arg2)
        if not activeInput then
            return
        end

        local now = tick()
        local lastDeltaTime = now - activeInput.lastTime
        local lastDeltaPosition = arg2.Position - activeInput.lastPosition
        local var4 = Vector2.new(lastDeltaPosition.X, lastDeltaPosition.Y) * Vector2.new(-1, 1)

        local isMouseButtonPressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        local isMouseButtonPressed2 = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)

        local bool3 = now - arg1.lastPanTime > 0.1
        if (bool1 and isMouseButtonPressed or bool2 and arg1.numActiveTouchInputs == 1) and bool3 then
            arg1.props.rotateByPixels(-var4)
        end

        if bool1 and isMouseButtonPressed2 or bool2 and arg1.numActiveTouchInputs == 2 then
            local var5 = var4 / arg1.numActiveInputs
            arg1.props.panByPixels(var5)
            arg1.lastPanTime = now
        end

        activeInput.lastPosition = arg2.Position
        activeInput.lastTime = now

        if not bool2 then
            return
        end
        if activeInput.changedThisFrame then
            activeInput.lastDeltaPosition = lastDeltaPosition + activeInput.lastDeltaPosition
            activeInput.lastDeltaTime = lastDeltaTime + activeInput.lastDeltaTime
            return
        end
        activeInput.lastDeltaPosition = lastDeltaPosition
        activeInput.lastDeltaTime = lastDeltaTime
        activeInput.changedThisFrame = true
    end

    function arg1.onInputEnded(arg2, _)
        local bool1, bool2, bool3, _ = splitInputType(arg2)

        if not (bool1 or bool2) then
            return
        end

        local activeInput = arg1:getActiveInput(arg2)
        if not activeInput then
            return
        end

        local now = tick()
        local var2 = now - arg1.lastPanTime
        local changedThisFrame = bool1 and activeInput.changedThisFrame
        local bool4 = arg1.numActiveInputs == 1 and var2 > 0.1

        if (changedThisFrame or bool3) and bool4 then
            local lastDeltaPosition, lastDeltaTime

            if bool3 then
                lastDeltaPosition = arg2.Position - activeInput.lastPosition
                lastDeltaTime = now - activeInput.lastTime
            else
                lastDeltaPosition = activeInput.lastDeltaPosition
                lastDeltaTime = activeInput.lastDeltaTime
            end

            arg1.props.setAngularVelocityByPixels(lastDeltaPosition.X / lastDeltaTime)
        end

        arg1:removeActivePointerInput(arg2, bool2)
    end

    function arg1.onInputBegan(arg2, arg3)
        arg1.handleScroll(arg2, arg3)
        local bool1, bool2, bool3, _ = splitInputType(arg3)

        if not (bool1 or bool2) then
            return
        end

        local now = tick()

        if bool1 or bool3 then
            arg1:handleDoubleTap(arg3, now)
        end

        arg1:addActivePointerInput(arg3, bool2, now)
    end

    function arg1.onTouchPinch(_, arg2, _, _, userInputState)
        if arg2[2] == nil then
            return
        end

        if userInputState == Enum.UserInputState.Begin then
            arg1.lastPinchDistance = (arg2[1] - arg2[2]).Magnitude
        else
            local magnitude = (arg2[1] - arg2[2]).Magnitude
            local var2 = magnitude - arg1.lastPinchDistance
            arg1.lastPinchDistance = magnitude
            arg1.props.zoomToPoint(var2 * -0.05, (arg2[1] + arg2[2]) / 2)
        end
    end
end

function var1.willUnmount(arg1)
    if arg1.inputChangedConnection then
        arg1:disconnectEvents()
    end
end

function var1.render(arg1)
    local propsVisible = arg1.props.Visible

    local var2 = arg1.props.Size or UDim2.new(1, 0, 1, 0)
    local propsPosition = arg1.props.Position
    local zIndex = arg1.props.ZIndex

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = var2,
        Position = propsPosition,
        ZIndex = zIndex,
        Visible = propsVisible,
        Active = true,
        [Roact.Event.InputBegan] = arg1.onInputBegan,
        [Roact.Event.InputChanged] = arg1.handleScroll,
        [Roact.Event.TouchPinch] = arg1.onTouchPinch
    }, arg1.props[Roact.Children])
end

return var1
