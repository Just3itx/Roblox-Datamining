-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)

local withStyle = require(CorePackages.Packages.UIBlox).Style.withStyle
local CameraUtility = require(CorePackages.Packages.Thumbnailing).CameraUtility
local MannequinUtility = require(CorePackages.Packages.Thumbnailing).MannequinUtility
local Constants = require(script.Parent.Parent.Parent.Parent.Constants)
local MakeupPreviewUtils = require(script.Parent.Parent.Parent.Parent.MakeupPreviewUtils)

local GetFFlagSingleUploadMakeupSupport = require(script.Parent.Parent.Parent.Parent.Flags.GetFFlagSingleUploadMakeupSupport)

local var1 = Roact.PureComponent:extend("AvatarPartViewport")

var1.validateProps = t.strictInterface({
    LayoutOrder = t.optional(t.number),
    asset = t.union(t.table, t.instanceOf("MeshPart"), t.instanceOf("Accessory"), t.instanceIsA("Decal")),
    assetType = t.optional(t.EnumItem),
    viewportSize = t.optional(t.Vector2)
})

function var1.init(arg1)
    arg1.camera = nil
    arg1.modelRef = Roact.createRef()
    local camera, updateCamera = Roact.createBinding(nil)
    arg1.camera = camera
    arg1.updateCamera = updateCamera
end

function var1.createViewportCamera(arg1): Camera
    local camera = Instance.new("Camera")
    camera.Parent = arg1.modelRef:getValue()
    camera.CameraType = Enum.CameraType.Scriptable
    camera.HeadLocked = true
    camera.VRTiltAndRollEnabled = true

    return camera
end

function var1.addBodyPartMannequinToViewport(arg1)
    local var2, var3, var4 = MannequinUtility.CreateBodyPartMannequin(arg1.props.asset, false)

    local var5, var6 = MannequinUtility.SetupBodyPartMannequin(var2, var3, var4, arg1.props.asset)
    var4.Parent = arg1.modelRef:getValue()
    local var7 = arg1:createViewportCamera()
    CameraUtility.SetupBodyPartCamera(var4, var5, var6, var7)
    arg1.updateCamera(var7)
end

function var1.addHeadModelToViewport(arg1)
    local headModel = MannequinUtility.CreateHeadModel(arg1.props.asset)
    headModel.Parent = arg1.modelRef:getValue()
    local var2 = arg1:createViewportCamera()
    CameraUtility.SetupHeadCamera(headModel, var2)
    arg1.updateCamera(var2)
end

function var1.addAccessoryToViewport(arg1)
    local asset = arg1.props.asset
    local model = Instance.new("Model")
    asset.Parent = model
    model.Parent = arg1.modelRef:getValue()
    local var2 = arg1:createViewportCamera()
    CameraUtility.SetupAccessoryCamera(model, var2)
    arg1.updateCamera(var2)
end

function var1.addMakeupDecalToViewport(arg1)
    local makeupThumbnailPreview = MakeupPreviewUtils.createMakeupThumbnailPreview(arg1.props.asset, arg1.props.assetType)
    if not makeupThumbnailPreview then
        return
    end

    makeupThumbnailPreview.Parent = arg1.modelRef:getValue()
    local var2 = arg1:createViewportCamera()
    if MakeupPreviewUtils.setupMakeupThumbnailCamera(makeupThumbnailPreview, var2, arg1.props.assetType) then
        arg1.updateCamera(var2)
    end
end

function var1.didMount(arg1)
    local asset = arg1.props.asset
    if typeof(asset) ~= "Instance" then
        arg1:addBodyPartMannequinToViewport()

        return
    end

    if asset:IsA("MeshPart") then
        arg1:addHeadModelToViewport()
    elseif GetFFlagSingleUploadMakeupSupport()
        and (asset:IsA("Decal") or arg1.props.assetType and MakeupPreviewUtils.isMakeupAssetType(arg1.props.assetType))
    then
        arg1:addMakeupDecalToViewport()
    else
        arg1:addAccessoryToViewport()
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local var2 = if arg1.props.viewportSize then arg1.props.viewportSize else Constants.ItemCardWidthLandscape
        local createElement = Roact.createElement
        local tbl1 = {
            LayoutOrder = arg1.props.LayoutOrder,
            BackgroundColor3 = theme.PlaceHolder.Color,
            BackgroundTransparency = theme.PlaceHolder.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(var2, var2),
            ZIndex = 0
        }
        local tbl2 = {
            UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 10) }),
            AspectRatioConstraint = Roact.createElement(
                "UIAspectRatioConstraint",
                {
                    AspectRatio = 1,
                    AspectType = Enum.AspectType.FitWithinMaxSize,
                    DominantAxis = Enum.DominantAxis.Width
                }
            ),
            ViewportFrame = 0
        }
        local createElement2 = Roact.createElement
        local tbl3 = {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ImageTransparency = 0,
            BackgroundTransparency = 1,
            LightColor = Constants.ViewportLightColor,
            Ambient = Constants.ViewportLightAmbient,
            LightDirection = Constants.ViewportLightDirection,
            CurrentCamera = arg1.camera
        }
        local tbl4 = {
            UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 10) }),
            WorldModel = Roact.createElement("WorldModel", { [Roact.Ref] = arg1.modelRef })
        }
        tbl2.ViewportFrame = createElement2("ViewportFrame", tbl3, tbl4)
        return createElement("Frame", tbl1, tbl2)
    end)
end

return var1
