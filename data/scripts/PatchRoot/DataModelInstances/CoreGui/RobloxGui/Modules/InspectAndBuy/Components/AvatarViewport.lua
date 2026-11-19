-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Cryo = require(CorePackages.Packages.Cryo)
local Colors = require(scriptParentParent.Colors)
local CharacterModelPool = require(scriptParentParent.CharacterModelPool)
local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)
local FFlagEnableNewAvatarViewportProps = require(scriptParentParent.Flags.FFlagEnableNewAvatarViewportProps)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local FFlagEnableInExperienceUIPCVRFix = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableInExperienceUIPCVRFix

local FFlagEnableInspectAndBuyV2RootFlag = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableInspectAndBuyV2RootFlag
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local var1 = Roact.PureComponent:extend("AvatarViewport")

function var1.init(arg1)
    arg1.viewportFrameRef = Roact.createRef()
    arg1.worldModelRef = Roact.createRef()
    arg1.connections = {}
    arg1.xRotation = 0
    arg1.yRotation = 0
    arg1.rotationDeltaX = 0
    arg1.rotationDeltaY = 0
    arg1.mouseOrTouchDown = false
    arg1.delta = 0
    arg1.keys = {}
    arg1.lastPosition = Vector3.new(0, 0, 0)
    arg1.viewportCamera = Instance.new("Camera")
    arg1.viewportCamera.CameraType = Enum.CameraType.Scriptable
    arg1.model = arg1.props.model
    arg1.lastInputTime = 2
    arg1.initialHrpPosition = if arg1.props.model == nil then nil else arg1.props.model.HumanoidRootPart.Position or nil
end

function var1.didMount(arg1)
    if arg1.props.humanoidDescription and arg1.model then
        arg1.viewportCamera.Parent = arg1.viewportFrameRef.current
        arg1.viewportFrameRef.current.CurrentCamera = arg1.viewportCamera
        arg1:setRotation()

        local rigType = arg1.model.Humanoid.RigType
        arg1.characterModelPool = CharacterModelPool.new(arg1.worldModelRef, arg1.initialHrpPosition, rigType)
    end

    arg1.isMounted = true
    arg1:handleSpin()
    arg1:setUpGamepad()
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.visible and arg1.props.humanoidDescription ~= arg2.humanoidDescription and arg1.model then
        if FFlagEnableNewAvatarViewportProps and arg1.props.resetCameraAndAutoRotationOnModelChange then
            arg1.xRotation = 0
            arg1.yRotation = 0
            if not arg1.props.disableAutoRotation then
                arg1.lastInputTime = tick()
            end
        end

        coroutine.wrap(function()
            arg1.characterModelPool:maybeUpdateCharacter(arg1.props.humanoidDescription)
        end)()
    end

    arg1.gamepadRotating = false
    arg1.viewportCamera.Parent = arg1.viewportFrameRef.current
    arg1.viewportFrameRef.current.CurrentCamera = arg1.viewportCamera

    if arg1.props.gamepadEnabled == arg2.gamepadEnabled then
        return
    end

    if arg1.props.gamepadEnabled then
        arg1:setUpGamepad()
        return
    end
    arg1:unbindActions()
end

function var1.setRotation(arg1)
    local model = arg1.model

    if not model then
        return
    end

    local humanoidRootPart = model.HumanoidRootPart

    local var2 = arg1.initialHrpPosition or humanoidRootPart.Position
    local var3

    if FFlagEnableNewAvatarViewportProps and arg1.props.offsetOptions then
        var3 = arg1.props.offsetOptions.defaultCameraOffset
        if arg1.model:FindFirstChildOfClass("Tool") then
            var3 = arg1.props.offsetOptions.toolOffset
        end
    else
        local view = arg1.props.view

        local view2 = arg1.props.views[view]
        var3 = view2.DefaultCameraOffset
        if arg1.model:FindFirstChildOfClass("Tool") then
            var3 = view2.ToolOffset
        end
    end

    local p = (CFrame.new(var2) * CFrame.Angles(0, -arg1.yRotation, 0) * CFrame.Angles(arg1.xRotation, 0, 0) * var3).p

    arg1.viewportCamera.CFrame = CFrame.new(p, var2)

    if FFlagEnableNewAvatarViewportProps and arg1.props.cameraFieldOfView then
        arg1.viewportCamera.FieldOfView = arg1.props.cameraFieldOfView
    end
end

function var1.render(arg1)
    local size = arg1.props.size
    local position = arg1.props.position
    local visible = arg1.props.visible
    local backgroundTransparency = arg1.props.backgroundTransparency
    local setScrollingEnabled = arg1.props.setScrollingEnabled

    local createElement = Roact.createElement
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = position,
        Size = size,
        BackgroundTransparency = backgroundTransparency,
        BackgroundColor3 = Colors.Graphite,
        BorderSizePixel = 0,
        Active = true,
        Visible = visible,
        [Roact.Ref] = arg1.viewportFrameRef
    }

    tbl1[Roact.Event.InputBegan] = function(_, arg2)
        if arg2.UserInputState ~= Enum.UserInputState.Begin then
            return
        end

        arg1.mouseOrTouchDown = true
        arg1.lastPosition = arg2.Position

        if not FFlagEnableNewAvatarViewportProps or setScrollingEnabled then
            setScrollingEnabled(false)
        end
        local connection = UserInputService.InputChanged:connect(function(input: InputObject, _: boolean)
            if (input.UserInputType ~= Enum.UserInputType.MouseMovement or not arg1.mouseOrTouchDown)
                and input.UserInputType ~= Enum.UserInputType.Touch
            then
                return
            end
            local var2 = input.Position - arg1.lastPosition
            arg1.lastPosition = input.Position
            arg1.yRotation += var2.x * 0.0065
            arg1.xRotation += var2.y * 0.0065
            arg1.lastInputTime = tick()
        end)

        local connection2 = UserInputService.InputEnded:connect(function(input: InputObject, _: boolean)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            if arg1.mouseOrTouchDown then
                arg1.mouseOrTouchDown = false
                arg1.lastInputTime = tick()
                arg1:removeConnections()
            end

            if not FFlagEnableNewAvatarViewportProps or setScrollingEnabled then
                setScrollingEnabled(true)
            end
        end)

        table.insert(arg1.connections, connection)
        table.insert(arg1.connections, connection2)
    end

    local tbl2 = {
        WorldModel = Roact.createElement("WorldModel", { [Roact.Ref] = arg1.worldModelRef })
    }
    return createElement("ViewportFrame", tbl1, tbl2)
end

function var1.handleSpin(arg1)
    local bool1 = false
    spawn(function()
        while arg1.isMounted do
            if not (tick() - arg1.lastInputTime > 2) or arg1.mouseOrTouchDown or arg1.gamepadRotating then
                bool1 = false
            elseif not (FFlagEnableNewAvatarViewportProps and arg1.props.disableAutoRotation) then
                bool1 = true
            end

            local function returnToDefaultPosition(arg2, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
                arg2 %= math.pi * 2
                if arg2 > math.pi then
                    arg2 += num1
                    if arg2 > math.pi * 2 then
                        return 0
                    end
                else
                    arg2 -= num1
                    if arg2 < 0 then
                        return 0
                    end
                end
                return arg2
            end

            if bool1 then
                arg1.xRotation = returnToDefaultPosition(arg1.xRotation, math.rad(2))
                arg1.yRotation += 0.012217304763960306
            elseif arg1.gamepadRotating then
                arg1.yRotation += arg1.delta * arg1.rotationDeltaY
                arg1.xRotation += arg1.delta * arg1.rotationDeltaX
            end

            arg1:setRotation()
            arg1.delta = RunService.RenderStepped:wait()
        end
    end)
end

function var1.setUpGamepad(arg1)
    if isInExperienceUIVREnabled and FFlagEnableInExperienceUIPCVRFix and isSpatial() and FFlagEnableInspectAndBuyV2RootFlag then
        return
    end

    if not UserInputService.GamepadEnabled then
        return
    end

    local vector2 = Vector2.new(0, 0)

    ContextActionService:UnbindCoreAction("RotateModel")
    ContextActionService:BindCoreAction("RotateModel", function(_, userInputState, arg2): Enum.ContextActionResult
        if userInputState == Enum.UserInputState.Change then
            vector2 = arg2.Position or vector2
            vector2 = Vector2.new(vector2.X, vector2.Y)
            if math.abs(vector2.X) > 0.2 or math.abs(vector2.Y) > 0.2 then
                arg1.lastInputTime = tick()
                arg1.gamepadRotating = true
                arg1.rotationDeltaY = 3 * vector2.X
                arg1.rotationDeltaX = 3 * vector2.Y
            else
                arg1.gamepadRotating = false
            end
        end

        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.Thumbstick2, Enum.KeyCode.ButtonA)
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("RotateModel")
end

function var1.removeConnections(arg1)
    for _, connection in pairs(arg1.connections) do
        connection:disconnect()
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false

    if arg1.characterModelPool then
        arg1.characterModelPool:onDestroy()
    end
    arg1:unbindActions()
    arg1:removeConnections()
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        view = arg1.view,
        tryingOnInfo = arg1.tryingOnInfo,
        gamepadEnabled = arg1.gamepadEnabled
    }
end)(function(arg1) -- name: AvatarViewportWrapper
    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(views)
            local var2 = Cryo.Dictionary.join(arg1, { views = views })
            return Roact.createElement(var1, var2)
        end
    })
end)
