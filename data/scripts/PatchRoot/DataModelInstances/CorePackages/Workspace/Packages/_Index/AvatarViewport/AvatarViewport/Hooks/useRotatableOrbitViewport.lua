-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local Constants = require(AvatarViewport.Constants)
local _Types = require(AvatarViewport.Types)
local useAvatarViewportScene = require(AvatarViewport.Hooks.useAvatarViewportScene)
local useViewportModelLoader = require(AvatarViewport.Hooks.useViewportModelLoader)
local useViewportOrbitInteractions = require(AvatarViewport.Hooks.useViewportOrbitInteractions)
local useViewportGamepadOrbit = require(AvatarViewport.Hooks.useViewportGamepadOrbit)
local useOrbitHeadCamera = require(AvatarViewport.Hooks.useOrbitHeadCamera)

local function useRotatableOrbitViewport(tbl1)
    local var1 = React.useRef(function(_) end)

    local refs = useAvatarViewportScene()

    local var3 = useViewportOrbitInteractions({
        initialYRotDeg = tbl1.committedYRotDeg or tbl1.initialYRotDeg,
        distanceScale = tbl1.distanceScale,
        onYRotDegChanged = tbl1.onYRotDegChanged,
        onDistanceScaleChanged = tbl1.onDistanceScaleChanged,
        onCameraUpdateRequested = function()
            var1.current()
        end
    })

    useViewportGamepadOrbit({
        applyYawDelta = var3.applyYawDelta,
        applyZoomGesture = var3.applyZoomGesture,
        onOrbitEnded = var3.commitYaw,
        actionName = tbl1.gamepadActionName
    })

    local var4 = useViewportModelLoader({
        modelSource = tbl1.modelSource,
        worldModelRef = refs.worldModel,
        onModelReady = function(arg1)
            var3.resetYaw(tbl1.committedYRotDeg or tbl1.initialYRotDeg)
            if tbl1.onModelReady then
                tbl1.onModelReady(arg1)
            end
        end
    })

    local config = React.useMemo(function()
        return {
            baseDistance = tbl1.baseDistance or Constants.DefaultOrbitBaseDistance,
            fieldOfViewDeg = tbl1.fieldOfViewDeg or Constants.DefaultOrbitFieldOfViewDeg,
            fieldOfViewForDistanceScaleDeg = tbl1.fieldOfViewForDistanceScaleDeg,
            focusPartName = tbl1.focusPartName or Constants.DefaultFocusPartName,
            layout = tbl1.layout
        }
    end, {
        tbl1.baseDistance,
        tbl1.fieldOfViewDeg,
        tbl1.fieldOfViewForDistanceScaleDeg,
        tbl1.focusPartName,
        tbl1.layout,
        tbl1.layout.viewportHeight,
        tbl1.layout.cutoutTopOffset,
        tbl1.layout.cutoutDiameter
    })

    local var6 = useOrbitHeadCamera({
        cameraRef = refs.camera,
        model = var4.model,
        yRotDeg = var3.yRotDeg,
        yRotDegRef = var3.yRotDegRef,
        distanceScale = tbl1.distanceScale,
        distanceScaleRef = var3.distanceScaleRef,
        config = config,
        frameCloseupPreviewCamera = tbl1.frameCloseupPreviewCamera
    })
    var1.current = var6.frameCamera

    React.useEffect(function()
        if tbl1.committedYRotDeg ~= nil then
            var3.resetYaw(tbl1.committedYRotDeg)
        end
    end, { tbl1.committedYRotDeg, var3.resetYaw })

    return {
        refs = refs,
        inputHandlers = var3.inputHandlers,
        modelLoader = {
            isLoading = var4.isLoading,
            isReady = var4.isReady,
            model = var4.model
        },
        frameCamera = var6.frameCamera,
        resetYaw = var3.resetYaw
    }
end

return useRotatableOrbitViewport
