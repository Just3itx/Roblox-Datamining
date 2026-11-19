-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")

local Roact = require(CorePackages.Packages.Roact)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local Progress = Foundation.Progress
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

local withStyle = UIBlox.Style.withStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local t = require(CorePackages.Packages.t)
local Images = UIBlox.App.ImageSet.Images
local Constants = require(script.Parent.Parent.Parent.Constants)
local MakeupPreviewUtils = require(script.Parent.Parent.Parent.MakeupPreviewUtils)
local FFlagIECPublishValidationLoadingUI = require(script.Parent.Parent.Parent.Flags.FFlagIECPublishValidationLoadingUI)
local CharacterUtility = require(CorePackages.Packages.Thumbnailing).CharacterUtility
local CameraUtility = require(CorePackages.Packages.Thumbnailing).CameraUtility
local CFrameUtility = require(CorePackages.Packages.Thumbnailing).CFrameUtility
local EmoteUtility = require(CorePackages.Packages.Thumbnailing).EmoteUtility

local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local iconsActionsPreviewExpand = Images["icons/actions/previewExpand"]
local component_assetsDropshadow_25 = Images["component_assets/dropshadow_25"]

local uDim2 = UDim2.new(0.4, 50, 0.15, 10)
local uDim2_2 = UDim2.new(0.5, 0, 1, 0)

local var1 = Roact.PureComponent:extend("ObjectViewport")

local function getReviewingCreationText() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(RobloxTranslator.FormatByKey, RobloxTranslator, "CoreScripts.PublishCommon.ReviewingCreation")
    return if success then result else "Reviewing your creation..."
end

var1.validateProps = t.strictInterface({
    model = t.optional(t.instanceOf("Model")),
    fieldOfView = t.optional(t.number),
    isLoading = t.optional(t.boolean),
    useFullBodyCameraSettings = t.optional(t.boolean),
    openPreviewView = t.optional(t.callback),
    LayoutOrder = t.optional(t.number),
    isHumanoidModel = t.optional(t.boolean),
    isMakeupPreview = t.optional(t.boolean)
})

function var1.createCamera(arg1): Camera
    local camera = Instance.new("Camera")
    camera.CameraType = Enum.CameraType.Scriptable
    camera.Parent = arg1.worldModelRef:getValue()
    camera.HeadLocked = true
    camera.VRTiltAndRollEnabled = true

    return camera
end

function var1.init(arg1)
    arg1.worldModelRef = Roact.createRef()
    local camera, updateCamera = Roact.createBinding(nil)
    arg1.camera = camera
    arg1.updateCamera = updateCamera
    arg1.isMounted = false
end

local function getCameraDistance(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local x = arg2.X
    local y = arg2.Y
    local z = arg2.Z
    local num1 = math.max(x, y, z)
    local num2 = 1 / math.tan(math.rad(arg1) / 2)
    return num1 / 2 * num2 + z / 2
end

function var1.setupViewportForAsset(arg1)
    if not arg1.props.model then
        return
    end

    local modelClone = arg1.props.model:Clone()
    modelClone.Parent = arg1.worldModelRef:getValue()
    local cFrame, size

    if modelClone:IsA("Model") then
        modelClone:MoveTo(Vector3.new(0, 0, 0))
        local var2, var3

        if arg1.props.isMakeupPreview then
            var2, var3 = MakeupPreviewUtils.getHeadPreviewCameraData(modelClone)
        else
            var2 = nil
            var3 = nil
        end
        cFrame = var2 or modelClone:GetModelCFrame()
        size = var3 or modelClone:GetExtentsSize()
    else
        local var2 = modelClone:FindFirstChildWhichIsA("MeshPart", true)
        if not var2 then
            return
        end

        var2.CFrame = CFrame.new(0, 0, 0)
        cFrame = var2.CFrame
        size = var2.Size
    end

    local lookVector = cFrame.lookVector

    local var2 = arg1:createCamera()

    local fieldOfView = if arg1.props.fieldOfView then arg1.props.fieldOfView else 30
    local cameraDistance = getCameraDistance(fieldOfView, size)
    local vector2 = Vector2.new(5, 20)

    local r = math.rad(vector2.X)
    local r2 = math.rad(vector2.Y)

    local worldVector = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), r):VectorToWorldSpace(lookVector)
    local worldVector2 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), r2):VectorToWorldSpace(worldVector)

    local pos = cFrame.Position + worldVector2 * cameraDistance
    var2.CFrame = CFrame.new(pos, cFrame.Position)
    var2.FieldOfView = fieldOfView

    arg1.updateCamera(var2)
end

function var1.setupViewport(arg1)
    local modelClone = arg1.props.model:Clone()
    assert(modelClone.PrimaryPart, "The Model should have a PrimaryPart for setting up Camera")
    modelClone.Parent = arg1.worldModelRef:getValue()
    modelClone:MoveTo(Vector3.new(0, 0, 0))

    local useFullBodyCameraSettings = arg1.props.useFullBodyCameraSettings

    if useFullBodyCameraSettings then
        EmoteUtility.SetPlayerCharacterPoseWithMoodFallback(modelClone)

        RunService.PostSimulation:Wait()
        if not arg1.isMounted then
            return
        end
    end
    local var2 = arg1:createCamera()
    local primaryPartCFrame

    if useFullBodyCameraSettings then
        local targetCFrame = CFrameUtility.CalculateTargetCFrame(modelClone.Head.CFrame)
        primaryPartCFrame = targetCFrame - targetCFrame.Position + modelClone.PrimaryPart.CFrame.Position
    else
        primaryPartCFrame = modelClone.PrimaryPart.CFrame
    end

    local minExtent, maxExtent = CharacterUtility.CalculateModelExtents(modelClone, primaryPartCFrame)
    local tbl1 = {
        optFieldOfView = if arg1.props.fieldOfView then arg1.props.fieldOfView else 30,
        targetCFrame = primaryPartCFrame,
        minExtent = minExtent,
        maxExtent = maxExtent,
        extentScale = 1
    }

    if useFullBodyCameraSettings then
        tbl1.optCameraXRot = CameraUtility.XRotForFullBody
        tbl1.optCameraDistanceScale = CameraUtility.DistanceScaleForFullBody
        tbl1.extentScale = CameraUtility.DefaultBodyMarginScale
    else
        tbl1.optCameraYRot = 25
    end
    CameraUtility.SetupCamera(var2, tbl1)
    arg1.updateCamera(var2)
end

function var1.didMount(arg1)
    arg1.isMounted = true
    task.spawn(function()
        if arg1.props.isLoading then
            return
        end

        if arg1.props.isHumanoidModel then
            arg1:setupViewport()
            return
        end
        arg1:setupViewportForAsset()
    end)
end

function var1.didUpdate(arg1, arg2)
    if not arg2.isLoading or arg1.props.isLoading then
        return
    end

    task.spawn(function()
        if arg1.props.isHumanoidModel then
            arg1:setupViewport()
            return
        end
        arg1:setupViewportForAsset()
    end)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        if arg1.props.isLoading then
            if not FFlagIECPublishValidationLoadingUI then
                return (Roact.createElement(Skeleton, {
                    Size = UDim2.new(1, Constants.PromptSidePadding * 2, 0, 240),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    LayoutOrder = arg1.props.LayoutOrder
                }))
            end

            local createElement = Roact.createElement
            local tbl1 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 240),
                LayoutOrder = arg1.props.LayoutOrder
            }
            local createElement2 = Roact.createElement
            local var2 = View

            local tbl2 = {
                ProgressCircle = Roact.createElement(Progress, { shape = ProgressShape.Circle, size = ProgressSize.Large }),
                Status = 0
            }
            local createElement3 = Roact.createElement
            local var3 = View

            local createElement4 = Roact.createElement
            local var4 = FoundationText
            local reviewingCreationText = getReviewingCreationText()
            local tbl3 = {
                Text = 0,
                tag = "shrink size-0-full auto-x padding-x-medium text-label-medium text-truncate-end content-action-utility"
            }
            local tbl4 = { Text = 0 }
            local tbl5 = {
                tag = "row align-x-center align-y-center size-0-800 auto-x radius-circle clip bg-action-utility",
                testId = "reviewing-creation-status"
            }
            local tbl6 = { tag = "col align-x-center align-y-center gap-medium size-full" }
            local tbl7 = { Content = 0 }
            local str1 = "CanvasGroup"
            tbl3.Text = reviewingCreationText
            tbl4.Text = createElement4(var4, tbl3)
            tbl2.Status = createElement3(var3, tbl5, tbl4)
            tbl7.Content = createElement2(var2, tbl6, tbl2)
            return (createElement(str1, tbl1, tbl7))
        end

        local createElement = Roact.createElement
        local tbl1 = {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0,
            Size = UDim2.new(1, Constants.PromptSidePadding * 2, 0, 240),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            LayoutOrder = arg1.props.LayoutOrder
        }
        local tbl2 = { ViewportFrame = 0, ExpandPreviewButton = 0, Gradient = 0, DropShadow = 0 }
        local createElement2 = Roact.createElement
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            LightColor = Constants.ViewportLightColor,
            Ambient = Constants.ViewportLightAmbient,
            LightDirection = Constants.ViewportLightDirection,
            CurrentCamera = arg1.camera
        }
        local tbl4 = {
            WorldModel = Roact.createElement("WorldModel", { [Roact.Ref] = arg1.worldModelRef })
        }
        tbl2.ViewportFrame = createElement2("ViewportFrame", tbl3, tbl4)

        tbl2.ExpandPreviewButton = arg1.props.openPreviewView
            and Roact.createElement(IconButton, {
                position = UDim2.new(1, -Constants.PromptSidePadding, 1, 0),
                anchorPoint = Vector2.new(1, 1),
                icon = iconsActionsPreviewExpand,
                iconSize = IconSize.Medium,
                onActivated = arg1.props.openPreviewView
            })
        tbl2.Gradient = Roact.createElement("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new(
                { ColorSequenceKeypoint.new(0, theme.BackgroundMuted.Color), ColorSequenceKeypoint.new(1, theme.BackgroundMuted.Color) }
            ),
            Transparency = NumberSequence.new(
                { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.7, 0.75), NumberSequenceKeypoint.new(1, 1) }
            )
        })

        tbl2.DropShadow = Roact.createElement(ImageSetLabel, {
            Position = uDim2_2,
            AnchorPoint = Vector2.new(0.5, 1),
            Image = component_assetsDropshadow_25,
            BackgroundTransparency = 1,
            ImageTransparency = 0.5,
            Size = uDim2,
            ZIndex = 0
        })
        return createElement("Frame", tbl1, tbl2)
    end)
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return var1
