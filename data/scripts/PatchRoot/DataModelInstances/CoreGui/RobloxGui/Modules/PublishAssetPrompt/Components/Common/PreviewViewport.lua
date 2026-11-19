-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnimationClipProvider = game:GetService("AnimationClipProvider")
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Skeleton = require(CorePackages.Packages.Foundation).Skeleton

local EmptyState = UIBlox.App.Indicator.EmptyState
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ShortcutBar = UIBlox.App.Navigation.ShortcutBar
local InputType = UIBlox.Core.Enums.InputType
local getInputGroup = require(CorePackages.Workspace.Packages.InputType).getInputGroup
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection
local InputTypeConstants = require(CorePackages.Workspace.Packages.InputType).InputTypeConstants
local GamepadUtils = require(CorePackages.Workspace.Packages.InputUi).Gamepad.GamepadUtils

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local InteractionFrame = require(script.Parent.InteractionFrame)
local Constants = require(script.Parent.Parent.Parent.Constants)
local MakeupPreviewUtils = require(script.Parent.Parent.Parent.MakeupPreviewUtils)

local Images = UIBlox.App.ImageSet.Images
local iconsActionsPreviewShrink = Images["icons/actions/previewShrink"]
local iconsActionsReset = Images["icons/actions/reset"]

local var1 = Roact.PureComponent:extend("PreviewViewport")

var1.validateProps = t.strictInterface({
    asset = t.union(t.instanceOf("Model"), t.instanceIsA("AnimationClip")),
    closePreviewView = t.callback,
    isMakeupPreview = t.optional(t.boolean)
})

local function isGamepadInput(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return getInputGroup(arg1) == InputTypeConstants.Gamepad
end

function var1.init(arg1)
    arg1:setState({
        loadingState = "loading",
        isGamepad = not not isGamepadInput((UserInputService:GetLastInputType())),
        cameraMoved = false
    })

    arg1.ref = Roact.createRef()
    arg1.zoomFactor = 0.8
    arg1.cameraDegreesAngle = Vector2.new(0, 0)
    arg1.cameraPanInPixels = Vector2.new(0, 0)

    arg1.cameraRef = Roact.createRef()
    arg1.worldModelRef = Roact.createRef()

    local cameraCFrameBinding, updateCameraCFrameBinding = Roact.createBinding(CFrame.new())
    arg1.cameraCFrameBinding = cameraCFrameBinding
    arg1.updateCameraCFrameBinding = updateCameraCFrameBinding
    local cameraFocusBinding, updateCameraFocusBinding = Roact.createBinding(CFrame.new())
    arg1.cameraFocusBinding = cameraFocusBinding
    arg1.updateCameraFocusBinding = updateCameraFocusBinding

    function arg1.panByPixels(arg2)
        arg1.cameraPanInPixels += arg2
        arg1:clampOffsets()
        arg1:updateCameraPosition()
        if not arg1.state.cameraMoved then
            arg1:setState({ cameraMoved = true })
        end
    end

    function arg1.rotateByPixels(arg2)
        arg1.cameraDegreesAngle = Vector2.new(arg1.cameraDegreesAngle.X - arg2.Y, arg1.cameraDegreesAngle.Y - arg2.X)

        arg1:clampOffsets()
        arg1:updateCameraPosition()
        if not arg1.state.cameraMoved then
            arg1:setState({ cameraMoved = true })
        end
    end

    function arg1.storeInput(_, inputState, inputObject): Enum.ContextActionResult
        arg1.inputState = inputState
        arg1.inputObject = inputObject

        return Enum.ContextActionResult.Sink
    end

    function arg1.rotateByRadians(arg2)
        if not arg1.model:FindFirstChild("HumanoidRootPart") then
            return
        end

        local var6 = -arg2 * 180 / math.pi
        arg1.cameraDegreesAngle = Vector2.new(arg1.cameraDegreesAngle.X % 360, (arg1.cameraDegreesAngle.Y + var6) % 360)

        arg1:updateCameraPosition()
        if not arg1.state.cameraMoved then
            arg1:setState({ cameraMoved = true })
        end
    end

    function arg1.setAngularVelocityByPixels(_) end

    function arg1.zoomToPoint(num1: number, vector2: Vector2?)
        local num2 = 0.9 ^ num1
        local zoomFactor = arg1.zoomFactor * num2

        if zoomFactor ~= math.clamp(zoomFactor, 0.3, 10) then
            return
        end
        arg1.zoomFactor = zoomFactor

        if vector2 then
            local var7 = (vector2 - (arg1.absolutePosition + arg1.absoluteSize / 2)) * Vector2.new(1, -1) * -1

            arg1.cameraPanInPixels = var7 - (var7 - arg1.cameraPanInPixels) * num2
        end

        arg1:clampOffsets()
        arg1:updateCameraPosition()
        if not arg1.state.cameraMoved then
            arg1:setState({ cameraMoved = true })
        end
    end

    function arg1.onRetryLoading()
        arg1:processAsset()
    end

    function arg1.onResetButtonPressed()
        arg1:resetCameraPosition()
    end
end

function var1.setLoadingState(arg1, loadingState)
    arg1:setState({ loadingState = loadingState })
end

function var1.clampOffsets(arg1)
    arg1.zoomFactor = math.clamp(arg1.zoomFactor, 0.3, 10)

    local var2 = if arg1.props.asset and arg1.props.asset:IsA("AnimationClip") then arg1:angleToMakeBasePlateParallel() else -80

    arg1.cameraDegreesAngle = Vector2.new(math.clamp(arg1.cameraDegreesAngle.X, var2, 80), arg1.cameraDegreesAngle.Y)

    local num1 = math.max(arg1.zoomFactor * arg1.modelExtentsSize.X / 2 / arg1:pointsToPixelsFactor(), arg1.absoluteSize.X / 2)

    local num2 = math.max(arg1.zoomFactor * arg1.modelExtentsSize.Y / 2 / arg1:pointsToPixelsFactor(), arg1.absoluteSize.Y / 2)
    arg1.cameraPanInPixels = Vector2.new(math.clamp(arg1.cameraPanInPixels.X, -num1, num1), math.clamp(arg1.cameraPanInPixels.Y, -num2, num2))
end

function var1.angleToMakeBasePlateParallel(arg1): number
    local var2 = arg1.cameraDistance / arg1.zoomFactor

    local var3 = arg1:pointsToPixelsFactor() / arg1.zoomFactor * arg1.cameraPanInPixels.Y

    return -math.deg(math.asin(math.clamp((arg1.modelExtentsSize.Y / 2 + var3) / var2, -0.99, 0.99)))
end

function var1.processAsset(arg1)
    local asset = arg1.props.asset
    if not asset then
        return
    end

    if not asset:IsA("AnimationClip") then
        if asset:IsA("Model") or asset:IsA("Accessory") then
            if asset:IsA("Accessory") then
                local model = Instance.new("Model")
                asset:Clone().Parent = model
                arg1.model = model
            else
                arg1.model = asset:Clone()
            end
            arg1.model.Parent = nil
            arg1:addModelToViewportIfNeeded()

            arg1:setLoadingState("successfullyLoaded")
        end

        return
    end

    arg1:setLoadingState("loading")
    task.spawn(function()
        local success, result = pcall(function(): HumanoidDescription
            return (Players:GetHumanoidDescriptionFromOutfitIdAsync(1342485078))
        end)

        local model = if success then Players:CreateHumanoidModelFromDescriptionAsync(result, Enum.HumanoidRigType.R15) else nil

        if not arg1.isMounted or asset ~= arg1.props.asset then
            return
        end

        if not model then
            arg1:setLoadingState("failedToLoad")
            return
        end

        arg1.model = model
        arg1:addModelToViewportIfNeeded()

        local contentId = AnimationClipProvider:RegisterActiveAnimationClip(asset)
        arg1.animation = Instance.new("Animation")
        arg1.animation.AnimationId = contentId

        local humanoid = arg1.model:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid:LoadAnimation(arg1.animation):Play()
        end

        arg1:setLoadingState("successfullyLoaded")
    end)
end

function var1.addModelToViewportIfNeeded(arg1)
    if arg1.model ~= nil and arg1.model.Parent ~= nil then
        return
    end

    if not arg1.worldModelRef:getValue() or arg1.model == nil then
        return
    end

    arg1.model.Parent = arg1.worldModelRef:getValue()
    arg1:resetCameraPosition()

    if not arg1.props.asset or not arg1.props.asset:IsA("AnimationClip") then
        return
    end
    arg1.baseplate = Instance.new("Part")
    arg1.baseplate.Size = Vector3.new(8, 0.5, 8)
    arg1.baseplate.Transparency = 0.6
    arg1.baseplate.Parent = arg1.worldModelRef:getValue()
    local var2 = arg1.modelCFrame.Position + Vector3.new(0, -arg1.modelExtentsSize.Y / 2, 0)
    arg1.baseplate.Position = var2 + Vector3.new(0, -0.25, 0)
end

local function getCameraDistance(arg1, arg2) -- Luacid: unused: defined but never referenced
    local x = arg2.X
    local y = arg2.Y
    local z = arg2.Z

    local num1 = math.max(x, y)

    local num2 = 1 / math.tan(math.rad(arg1) / 2)
    return num1 / 2 * num2 + z / 2
end

local function rotateVectorAround(vec3: Vector3, r: number, vec3_2: Vector3): Vector3 -- Luacid: Inlined by compiler; 2 call sites recovered
    return CFrame.fromAxisAngle(vec3_2, r):VectorToWorldSpace(vec3)
end

function var1.resetCameraPosition(arg1)
    if not arg1.model then
        return
    end

    local var2, var3

    if arg1.props.isMakeupPreview then
        var2, var3 = MakeupPreviewUtils.getHeadPreviewCameraData(arg1.model)
    else
        var2 = nil
        var3 = nil
    end
    arg1.modelCFrame = var2 or arg1.model:GetModelCFrame()
    arg1.initialLookVector = arg1.modelCFrame.lookVector

    local humanoidRootPart = arg1.model:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        arg1.initialLookVector = humanoidRootPart.CFrame.lookVector
    end

    arg1.modelExtentsSize = var3 or arg1.model:GetExtentsSize()
    local modelExtentsSize = arg1.modelExtentsSize
    local modelExtentsSizeX = modelExtentsSize.X
    local modelExtentsSizeY = modelExtentsSize.Y
    local modelExtentsSizeZ = modelExtentsSize.Z

    arg1.cameraDistance = math.max(modelExtentsSizeX, modelExtentsSizeY) / 2 * 3.7320508075688776 + modelExtentsSizeZ / 2

    if arg1.props.asset and arg1.props.asset:IsA("AnimationClip") then
        arg1.cameraDegreesAngle = Vector2.new(0, 0)
        arg1.zoomFactor = 0.75
    else
        arg1.cameraDegreesAngle = Vector2.new(5, 20)
        arg1.zoomFactor = 0.8
    end

    arg1.cameraPanInPixels = Vector2.new(0, 0)

    arg1:updateCameraPosition()

    if arg1.state.cameraMoved then
        arg1:setState({ cameraMoved = false })
    end
end

function var1.pointsToPixelsFactor(arg1)
    if arg1.absoluteSize == nil
        or arg1.modelExtentsSize == nil
        or arg1.absoluteSize.Y == 0
        or arg1.modelExtentsSize.Y == 0
        or arg1.modelExtentsSize.X == 0
    then
        return 1
    end

    return math.max(arg1.modelExtentsSize.X, arg1.modelExtentsSize.Y) / arg1.absoluteSize.Y
end

function var1.updateCameraPosition(arg1)
    if arg1.absoluteSize == nil or arg1.cameraDistance == nil then
        return
    end

    local var2 = arg1.cameraDistance / arg1.zoomFactor

    local initialLookVector = arg1.initialLookVector
    local r = math.rad(arg1.cameraDegreesAngle.X)
    local num1 = math.rad(arg1.cameraDegreesAngle.Y)
    local worldVector = rotateVectorAround(rotateVectorAround(initialLookVector, r, Vector3.new(1, 0, 0)), num1, Vector3.new(0, 1, 0))

    local cFrame = CFrame.new(arg1.modelCFrame.p + worldVector * var2, arg1.modelCFrame.p)

    local var3 = arg1:pointsToPixelsFactor() / arg1.zoomFactor

    local var4 = cFrame + cFrame.UpVector * var3 * arg1.cameraPanInPixels.Y + cFrame.RightVector * var3 * arg1.cameraPanInPixels.X

    arg1.updateCameraCFrameBinding(var4)
    arg1.updateCameraFocusBinding(arg1.modelCFrame)
end

local tbl1 = {
    resetViewButtonText = RobloxTranslator:FormatByKey("CoreScripts.AssetPreviewView.Action.ResetView"),
    loadingFailedText = RobloxTranslator:FormatByKey("CoreScripts.AssetPreviewView.Label.LoadingFailed")
}

function var1.render(arg1)
    local loadingState = arg1.state.loadingState
    local items = {
        {
            icon = {
                [InputType.MouseAndKeyboard] = Images["icons/controls/mouse/scroll"],
                [InputType.Gamepad] = Images["icons/controls/keys/xboxRSVertical"]
            },
            text = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.Zoom")
        },
        {
            icon = {
                [InputType.MouseAndKeyboard] = Images["icons/controls/mouse/clickLeft"],
                [InputType.Gamepad] = Images["icons/controls/keys/xboxRSHorizontal"]
            },
            text = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.Rotate")
        },
        {
            icon = {
                [InputType.MouseAndKeyboard] = Images["icons/controls/mouse/clickRight"]
            },
            text = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.Pan")
        },
        {
            icon = {
                [InputType.Gamepad] = Images["icons/controls/keys/xboxY"]
            },
            text = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.ResetView")
        },
        {
            icon = {
                [InputType.Gamepad] = Images["icons/controls/keys/xboxB"]
            },
            text = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.Close")
        }
    }

    local var2 = arg1.state.cameraMoved and not arg1.state.isGamepad

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        [Roact.Ref] = arg1.ref
    }

    tbl3[Roact.Change.AbsoluteSize] = function(arg2)
        arg1.absoluteSize = arg2.AbsoluteSize
        arg1:updateCameraPosition()
    end
    tbl3[Roact.Change.AbsolutePosition] = function(arg2)
        local vector2 = GuiService:GetGuiInset()
        arg1.absolutePosition = arg2.absolutePosition + vector2
    end
    local tbl4 = {
        LastInputTypeConnection = Roact.createElement(ExternalEventConnection, {
            event = UserInputService.LastInputTypeChanged,
            callback = function(arg2)
                arg1:setState({ isGamepad = not not isGamepadInput(arg2) })
            end
        }) or nil,
        ButtonFrame = Roact.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromScale(0, 0),
                BackgroundTransparency = 1
            },
            {
                UIPadding = Roact.createElement(
                    "UIPadding",
                    {
                        PaddingBottom = UDim.new(0, 24),
                        PaddingLeft = UDim.new(0, 24),
                        PaddingRight = UDim.new(0, 24)
                    }
                ),
                ResetViewButton = if var2 then Roact.createElement(Button, {
                    buttonType = ButtonType.Secondary,
                    size = UDim2.fromOffset(36, 36),
                    position = UDim2.fromScale(0, 1),
                    anchorPoint = Vector2.new(0, 1),
                    icon = iconsActionsReset,
                    onActivated = arg1.onResetButtonPressed
                }) else nil,
                ShrinkPreviewButton = Roact.createElement(Button, {
                    buttonType = ButtonType.PrimarySystem,
                    size = UDim2.fromOffset(36, 36),
                    icon = iconsActionsPreviewShrink,
                    position = UDim2.fromScale(1, 1),
                    anchorPoint = Vector2.new(1, 1),
                    onActivated = arg1.props.closePreviewView
                })
            }
        ),
        TooltipHint = if arg1.props.asset:IsA("Model") then Roact.createElement(
            ShortcutBar,
            {
                position = UDim2.fromScale(0.5, 0.9),
                anchorPoint = Vector2.new(0.5, 1),
                transitionDelaySeconds = 2,
                items = items
            }
        ) else nil,
        ShimmerFrame = loadingState == "loading"
            and Roact.createElement(
                Skeleton,
                {
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            ),
        LoadingFailed = loadingState == "failedToLoad"
            and Roact.createElement(
                EmptyState,
                {
                    text = tbl1.loadingFailedText,
                    size = UDim2.fromScale(1, 1),
                    onActivated = arg1.onRetryLoading
                }
            ),
        InteractionFrame = 0
    }

    local createElement2 = Roact.createElement
    local var3 = InteractionFrame
    local tbl5 = {
        ZIndex = -1,
        Size = UDim2.fromScale(1, 1),
        Visible = loadingState == "successfullyLoaded",
        panByPixels = arg1.panByPixels,
        rotateByPixels = arg1.rotateByPixels,
        setAngularVelocityByPixels = arg1.setAngularVelocityByPixels,
        zoomToPoint = arg1.zoomToPoint
    }
    local tbl6 = { ViewportFrame = 0 }
    local createElement3 = Roact.createElement
    local tbl7 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        LightColor = Constants.ViewportLightColor,
        Ambient = Constants.ViewportLightAmbient,
        LightDirection = Constants.ViewportLightDirection,
        CurrentCamera = arg1.cameraRef
    }
    local tbl8 = {
        Camera = Roact.createElement("Camera", {
            CameraType = Enum.CameraType.Scriptable,
            FieldOfView = 30,
            HeadLocked = true,
            VRTiltAndRollEnabled = true,
            CFrame = arg1.cameraCFrameBinding,
            Focus = arg1.cameraFocusBinding,
            [Roact.Ref] = arg1.cameraRef
        }),
        WorldModel = Roact.createElement("WorldModel", { [Roact.Ref] = arg1.worldModelRef })
    }
    tbl6.ViewportFrame = createElement3("ViewportFrame", tbl7, tbl8)
    tbl4.InteractionFrame = createElement2(var3, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end

function var1.setUpGamepad(arg1)
    ContextActionService:UnbindCoreAction("PreviewViewportClose")
    ContextActionService:UnbindCoreAction("PreviewViewportReset")
    ContextActionService:UnbindCoreAction("PreviewViewportRotateAndZoom")

    ContextActionService:BindCoreAction("PreviewViewportClose", arg1.props.closePreviewView, false, Enum.KeyCode.ButtonB)

    ContextActionService:BindCoreAction("PreviewViewportReset", function()
        arg1:resetCameraPosition()
    end, false, Enum.KeyCode.ButtonY)
    ContextActionService:BindCoreAction("PreviewViewportRotateAndZoom", arg1.storeInput, false, Enum.KeyCode.Thumbstick2)

    arg1.gamePadConnection = RunService.RenderStepped:Connect(function(deltaTime: number)
        if arg1.inputState == Enum.UserInputState.Change and arg1.inputObject then
            GamepadUtils.rotateAndZoom(
                arg1.inputObject,
                deltaTime,
                arg1.setAngularVelocityByPixels,
                arg1.rotateByRadians,
                arg1.zoomToPoint
            )
        end
    end)
end

function var1.didMount(arg1)
    local vector2 = GuiService:GetGuiInset()
    arg1.isMounted = true
    arg1.absolutePosition = arg1.ref.current.AbsolutePosition + vector2
    arg1:processAsset()
    arg1:setUpGamepad()
end

function var1.cleanupGamepad(arg1)
    ContextActionService:UnbindCoreAction("PreviewViewportClose")
    ContextActionService:UnbindCoreAction("PreviewViewportReset")
    ContextActionService:UnbindCoreAction("PreviewViewportRotateAndZoom")
    if arg1.gamePadConnection then
        arg1.gamePadConnection:Disconnect()
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    arg1:cleanupGamepad()
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.asset == arg2.asset then
        return
    end
    if arg1.model ~= nil then
        arg1.model.Parent = nil
        arg1.model = nil
    end

    if arg1.baseplate ~= nil then
        arg1.baseplate.Parent = nil
        arg1.baseplate:Destroy()
    end

    arg1:processAsset()
end

return var1
