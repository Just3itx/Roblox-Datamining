-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Skeleton = require(CorePackages.Packages.Foundation).Skeleton

local Promise = require(CorePackages.Packages.Promise)
local EmptyState = UIBlox.App.Indicator.EmptyState

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local cFrame = CFrame.fromEulerAnglesXYZ(math.rad(20), math.rad(15), math.rad(40))

local num1 = game:DefineFastInt("AXClusterCompositionTimeoutMs", 3000)

local var1 = Roact.PureComponent:extend("HumanoidViewport")

var1.validateProps = t.strictInterface({
    humanoidDescription = t.optional(t.instanceOf("HumanoidDescription")),
    loadingFailed = t.boolean,
    retryLoadDescription = t.callback,
    rigType = t.optional(t.enum(Enum.HumanoidRigType))
})

function var1.init(arg1)
    arg1:setState({ loading = true, loadingFailed = false })

    arg1.cameraRef = Roact.createRef()
    arg1.worldModelRef = Roact.createRef()

    local cameraCFrameBinding, updateCameraCFrameBinding = Roact.createBinding(CFrame.new())
    arg1.cameraCFrameBinding = cameraCFrameBinding
    arg1.updateCameraCFrameBinding = updateCameraCFrameBinding
    local cameraFocusBinding, updateCameraFocusBinding = Roact.createBinding(CFrame.new())
    arg1.cameraFocusBinding = cameraFocusBinding
    arg1.updateCameraFocusBinding = updateCameraFocusBinding

    arg1.humanoidModel = nil

    arg1.mounted = false

    function arg1.onRetryLoading()
        arg1:setState({ loading = true, loadingFailed = false })

        if arg1.props.humanoidDescription then
            arg1:loadHumanoidModel()
            return
        end
        arg1.props.retryLoadDescription()
    end
end

local function rotateLookVector(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local y = arg1.Y
    local unit = if math.abs(y) > 0.95 then Vector3.new(0, 0, -1) else Vector3.new(arg1.X, 0, arg1.Z).unit
    return (CFrame.new(Vector3.new(0, 0, 0), unit) * cFrame).lookVector
end

local function getCameraOffset(arg1, arg2) -- Luacid: unused: defined but never referenced
    local x = arg2.X
    local y = arg2.Y
    local z = arg2.Z

    local num2 = math.max(x, y)

    local num3 = 1 / math.tan(math.rad(arg1) / 2)
    return num2 / 2 * num3 + z / 2
end

local function zoomExtents(model, lookVector, cFrame2: CFrame) -- Luacid: Inlined by compiler; 1 call site recovered
    local p = model:GetModelCFrame().p
    local extentsSize = model:GetExtentsSize()
    local extentsSizeX = extentsSize.X
    local extentsSizeY = extentsSize.Y
    local extentsSizeZ = extentsSize.Z

    local var2 = (math.max(extentsSizeX, extentsSizeY) / 2 * 1.4281480067421146 + extentsSizeZ / 2) * 1
    return cFrame2 - cFrame2.p + p + lookVector * var2
end

function var1.positionCamera(arg1)
    local humanoidModel = arg1.humanoidModel
    local modelCFrame = humanoidModel:GetModelCFrame()
    local lookVector = modelCFrame.lookVector
    local humanoidRootPart = humanoidModel:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        lookVector = humanoidRootPart.CFrame.lookVector
    end

    local lookVector2 = rotateLookVector(lookVector)
    local var2 = zoomExtents(humanoidModel, lookVector2, CFrame.new(modelCFrame.p + lookVector2 * 5, modelCFrame.p))

    arg1.updateCameraCFrameBinding(var2)
    arg1.updateCameraFocusBinding(modelCFrame)
end

function var1.loadIdleAnimation(_, arg1)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if humanoid.HumanoidDescription.IdleAnimation == 0 then
        return
    end

    local animate = arg1:FindFirstChild("Animate")
    if not animate then
        return
    end

    local idle = animate:FindFirstChild("idle")
    if not idle then
        return
    end

    local animation = idle:FindFirstChildOfClass("Animation")
    if not animation then
        return
    end

    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack.Looped = true
    animationTrack:Play()
end

function var1.loadHumanoidModel(arg1)
    local humanoidDescription = arg1.props.humanoidDescription
    local rigType = arg1.props.rigType

    coroutine.wrap(function()
        local var2 = nil
        pcall(function()
            var2 = Players:CreateHumanoidModelFromDescriptionAsync(humanoidDescription, rigType)
        end)

        if not arg1.mounted then
            return
        end

        if arg1.props.humanoidDescription ~= humanoidDescription then
            return
        end

        if arg1.props.rigType ~= rigType then
            return
        end

        if var2 == nil then
            arg1:setState({ loadingFailed = true })
            return
        end

        arg1.humanoidModel = var2
        if arg1.worldModelRef:getValue() then
            arg1.humanoidModel.Parent = arg1.worldModelRef:getValue()
        end

        if #humanoidDescription:GetAccessories(false) > 0 then
            Promise.race({ Promise.fromEvent(var2.Humanoid.ClusterCompositionFinished), Promise.delay(num1 * 0.001) }):await()
        end

        if not arg1.mounted then
            return
        end

        arg1:positionCamera()
        arg1:loadIdleAnimation(var2)

        arg1:setState({ loading = false, loadingFailed = false })
    end)()
end

function var1.render(arg1)
    local loadingFailed = arg1.props.loadingFailed or arg1.state.loadingFailed
    local loading = not loadingFailed and arg1.state.loading
    local bool1 = not (loadingFailed or arg1.state.loading)

    local createElement = Roact.createElement
    local tbl1 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }
    local tbl2 = {
        AspectRatioConstraint = Roact.createElement(
            "UIAspectRatioConstraint",
            {
                AspectRatio = 1,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        ),
        ShimmerFrame = loading
            and Roact.createElement(
                Skeleton,
                {
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            ),
        LoadingFailed = loadingFailed
            and Roact.createElement(EmptyState, {
                text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.ItemsListLoadingFailed"),
                size = UDim2.fromScale(1, 1),
                onActivated = arg1.onRetryLoading
            }),
        ViewportFrame = 0
    }

    local createElement2 = Roact.createElement
    local tbl3 = {
        Visible = bool1,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        LightColor = Color3.fromRGB(240, 240, 240),
        Ambient = Color3.fromRGB(240, 240, 240),
        CurrentCamera = arg1.cameraRef
    }
    local tbl4 = {
        Camera = Roact.createElement("Camera", {
            CameraType = Enum.CameraType.Scriptable,
            FieldOfView = 70,
            CFrame = arg1.cameraCFrameBinding,
            Focus = arg1.cameraFocusBinding,
            [Roact.Ref] = arg1.cameraRef
        }),
        WorldModel = Roact.createElement("WorldModel", { [Roact.Ref] = arg1.worldModelRef })
    }
    tbl2.ViewportFrame = createElement2("ViewportFrame", tbl3, tbl4)
    return createElement("Frame", tbl1, tbl2)
end

function var1.didMount(arg1)
    arg1.mounted = true

    if arg1.props.humanoidDescription then
        arg1:loadHumanoidModel()
    end
end

function var1.didUpdate(arg1, arg2)
    if arg1.worldModelRef:getValue() and arg1.humanoidModel then
        arg1.humanoidModel.Parent = arg1.worldModelRef:getValue()
    end

    local bool1 = arg1.props.humanoidDescription ~= arg2.humanoidDescription
    local bool2 = arg1.props.rigType ~= arg2.rigType

    if arg1.props.rigType == nil or arg1.props.humanoidDescription == nil or not bool1 and not bool2 then
        return
    end

    arg1:setState({ loading = true })

    if arg1.props.humanoidDescription ~= nil then
        arg1:loadHumanoidModel()
    end
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return var1
