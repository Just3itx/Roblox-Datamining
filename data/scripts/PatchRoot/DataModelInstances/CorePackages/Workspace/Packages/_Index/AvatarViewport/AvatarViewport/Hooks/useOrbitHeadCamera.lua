-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local computeOrbitHeadCFrame = require(AvatarViewport.Camera.computeOrbitHeadCFrame)
local Constants = require(AvatarViewport.Constants)
local _Types = require(AvatarViewport.Types)

local function useOrbitHeadCamera(tbl1)
    local var1 = React.useRef(nil)

    local var2 = React.useRef(tbl1.config)
    var2.current = tbl1.config
    local var3 = React.useRef(tbl1.frameCloseupPreviewCamera)
    var3.current = tbl1.frameCloseupPreviewCamera

    local var4 = React.useRef(tbl1.yRotDeg)
    local var5 = React.useRef(tbl1.distanceScale)
    local var6 = tbl1.yRotDegRef or var4
    local var7 = tbl1.distanceScaleRef or var5

    if not tbl1.yRotDegRef then
        var4.current = tbl1.yRotDeg
    end
    if not tbl1.distanceScaleRef then
        var5.current = tbl1.distanceScale
    end

    local var8 = React.useCallback(function()
        local current = var1.current
        if current then
            current:Cancel()
            var1.current = nil
        end
    end, {})

    local frameCamera = React.useCallback(function(tbl2)
        local current = tbl1.cameraRef.current
        local model = tbl1.model
        if not (current and model) then
            return
        end

        local current2 = var2.current

        local current3 = var3.current
        local var9

        if current3 then
            var9 = current3({ character = model, yRotDeg = var6.current, distanceScale = var7.current, config = current2 })
        else
            var9 = computeOrbitHeadCFrame({
                character = model,
                yRotDeg = var6.current,
                distanceScale = var7.current,
                baseDistance = current2.baseDistance,
                fieldOfViewDeg = current2.fieldOfViewDeg,
                fieldOfViewForDistanceScaleDeg = current2.fieldOfViewForDistanceScaleDeg,
                focusPartName = current2.focusPartName,
                layout = current2.layout
            })
        end
        if not var9 then
            return
        end

        current.FieldOfView = current2.fieldOfViewDeg

        if not (tbl2 and tbl2.tween) then
            var8()
            current.CFrame = var9

            return
        end

        var8()
        local tween = TweenService:Create(current, Constants.EmoteCameraTweenInfo, { CFrame = var9 })

        var1.current = tween
        tween.Completed:Connect(function()
            if var1.current == tween then
                var1.current = nil
            end
        end)
        tween:Play()
    end, { tbl1.model, var8, tbl1.cameraRef })

    React.useEffect(function()
        frameCamera()
    end, {
        tbl1.yRotDeg,
        tbl1.distanceScale,
        tbl1.model,
        tbl1.config.fieldOfViewDeg,
        tbl1.config.fieldOfViewForDistanceScaleDeg,
        tbl1.config.layout.viewportHeight,
        tbl1.config.layout.cutoutTopOffset,
        tbl1.config.layout.cutoutDiameter,
        frameCamera
    })

    React.useEffect(function()
        return function()
            var8()
        end
    end, { var8 })

    return { frameCamera = frameCamera }
end

return useOrbitHeadCamera
