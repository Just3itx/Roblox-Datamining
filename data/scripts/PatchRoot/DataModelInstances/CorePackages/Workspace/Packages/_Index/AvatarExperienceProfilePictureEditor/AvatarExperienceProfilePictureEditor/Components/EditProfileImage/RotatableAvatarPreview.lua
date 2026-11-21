-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local AvatarViewport = require(AvatarExperienceProfilePictureEditorParent.AvatarViewport)
local applyCloseupPreviewPose = require(AvatarExperienceProfilePictureEditor.Shared.applyCloseupPreviewPose)
local frameCloseupPreviewCamera = require(AvatarExperienceProfilePictureEditor.Shared.frameCloseupPreviewCamera)
local PreviewCutoutOverlay = require(script.Parent.PreviewCutoutOverlay)
local ProfilePictureCameraControlBar = require(script.Parent.ProfilePictureCameraControlBar)
local useRotatableAvatarPreviewViewModel = require(script.Parent.useRotatableAvatarPreviewViewModel)
local FFlagEditProfileImageCameraControlBar = require(AvatarExperienceProfilePictureEditor.Flags.FFlagEditProfileImageCameraControlBar)
local FFlagEditProfileImageRigTypeOverride = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagEditProfileImageRigTypeOverride
local View = Foundation.View
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local CameraMath = AvatarViewport.CameraMath
local useRotatableOrbitViewport = AvatarViewport.useRotatableOrbitViewport
local AvatarViewportScene = AvatarViewport.AvatarViewportScene
local ViewportInteractionOverlay = AvatarViewport.ViewportInteractionOverlay

local function stopAnimatorTracks(arg1: Animator?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return
    end
    for _, playingAnimationTrack in arg1:GetPlayingAnimationTracks() do
        playingAnimationTrack:Stop(0)
    end
end

local function RotatableAvatarPreview(tbl1)
    local var1 = useTokens()
    local cutoutSize = tbl1.cutoutSize
    local width = tbl1.width
    local height = tbl1.height
    local cutoutTopOffset = tbl1.cutoutTopOffset
    local distanceScale = CameraMath.clampDistanceScale(tbl1.distanceScale)
    local var3 = if FFlagEditProfileImageCameraControlBar then useRotatableAvatarPreviewViewModel({
        isDisabled = tbl1.isCameraControlBarDisabled,
        distanceScale = distanceScale,
        committedYRotDeg = tbl1.committedYRotDeg,
        onDistanceScaleChanged = tbl1.onDistanceScaleChanged,
        onYRotDegChanged = tbl1.onYRotDegChanged
    }) else nil

    local layout = React.useMemo(function()
        return {
            viewportHeight = height,
            cutoutTopOffset = cutoutTopOffset,
            cutoutDiameter = cutoutSize
        }
    end, { height, cutoutTopOffset, cutoutSize })

    local var2 = React.useMemo(function()
        return function(arg1)
            return frameCloseupPreviewCamera({
                character = arg1.character,
                yRotDeg = arg1.yRotDeg,
                distanceScale = arg1.distanceScale,
                layout = layout,
                fieldOfViewDeg = arg1.config.fieldOfViewDeg,
                fieldOfViewForDistanceScaleDeg = arg1.config.fieldOfViewForDistanceScaleDeg
            })
        end
    end, { layout })

    local var6 = React.useRef(0)

    local modelSource = React.useMemo(function()
        if FFlagEditProfileImageRigTypeOverride and tbl1.rigTypeOverride then
            return AvatarViewport.ModelSources.fromUserIdWithRigType(tbl1.userId, tbl1.rigTypeOverride)
        end
        return AvatarViewport.ModelSources.fromUserId(tbl1.userId)
    end, { tbl1.userId, if FFlagEditProfileImageRigTypeOverride then tbl1.rigTypeOverride or false else nil })

    local var8 = useRotatableOrbitViewport({
        modelSource = modelSource,
        distanceScale = distanceScale,
        fieldOfViewDeg = tbl1.fieldOfViewDeg,
        fieldOfViewForDistanceScaleDeg = tbl1.fieldOfViewForDistanceScaleDeg,
        committedYRotDeg = tbl1.committedYRotDeg,
        onYRotDegChanged = tbl1.onYRotDegChanged,
        onDistanceScaleChanged = tbl1.onDistanceScaleChanged,
        gamepadActionName = "EditProfileRotatableAvatarPreviewOrbit",
        layout = layout,
        frameCloseupPreviewCamera = var2
    })

    React.useEffect(function()
        if not var8.modelLoader.isReady or not var8.modelLoader.model then
            return
        end

        local var9 = var6
        var9.current += 1
        local current = var6.current
        local model = var8.modelLoader.model
        local emoteAssetId = tbl1.emoteAssetId

        task.spawn(function()
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            local var10 = if humanoid then humanoid:FindFirstChildOfClass("Animator") else nil
            stopAnimatorTracks(var10)
            applyCloseupPreviewPose(model, emoteAssetId)
            if var6.current ~= current then
                return
            end
            var8.frameCamera({ tween = true })
        end)

        return function()
            local var10 = var6
            var10.current += 1
        end
    end, {
        tbl1.emoteAssetId,
        var8.modelLoader.isReady,
        var8.modelLoader.model,
        var8.frameCamera
    })

    local surface300 = var1.Color.Surface.Surface_300
    local color3 = surface300.Color3
    local surface300Transparency = surface300.Transparency or 0
    local xOffset = math.max(0, math.floor((width - cutoutSize) / 2 + 0.5))

    return React.createElement(View, {
        Size = if tbl1.fillContainer then UDim2.fromScale(1, 1) else UDim2.fromOffset(width, height),
        backgroundStyle = surface300
    }, {
        Viewport = React.createElement(AvatarViewportScene, {
            size = UDim2.fromScale(1, 1),
            backgroundColor3 = color3,
            backgroundTransparency = surface300Transparency,
            refs = var8.refs
        }),
        CutoutOverlay = React.createElement(PreviewCutoutOverlay, {
            width = width,
            height = height,
            cutoutSize = cutoutSize,
            cutoutTopOffset = cutoutTopOffset,
            frameImage = tbl1.frameImage
        }),
        LoadingSpinner = if var8.modelLoader.isLoading then React.createElement(
            View,
            { tag = "align-x-center align-y-center size-full", ZIndex = 5 },
            {
                Spinner = React.createElement(Loading, { size = IconSize.Large })
            }
        ) else nil,
        CameraControlBar = if var3 and var3.showCameraControlBar then React.createElement(ProfilePictureCameraControlBar, {
            topOffset = cutoutTopOffset,
            zIndex = 6,
            onZoomIn = var3.onZoomIn,
            onZoomOut = var3.onZoomOut,
            onRotateLeft = var3.onRotateLeft,
            onRotateRight = var3.onRotateRight
        }) else nil,
        InteractionOverlay = React.createElement(ViewportInteractionOverlay, {
            name = "InteractionOverlay",
            size = UDim2.fromOffset(cutoutSize, cutoutSize),
            position = UDim2.fromOffset(xOffset, cutoutTopOffset),
            zIndex = 5,
            inputHandlers = var8.inputHandlers
        })
    })
end

return RotatableAvatarPreview
