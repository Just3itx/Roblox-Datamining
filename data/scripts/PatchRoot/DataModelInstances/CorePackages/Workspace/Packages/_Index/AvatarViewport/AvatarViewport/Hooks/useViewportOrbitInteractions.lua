-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local CameraMath = require(AvatarViewport.CameraMath)
local GetFIntAvatarViewportDegreesPerPixel = require(AvatarViewport.Flags.GetFIntAvatarViewportDegreesPerPixel)
local _Types = require(AvatarViewport.Types)
local ViewportInputTypes = require(AvatarViewport.ViewportInputTypes)
local ViewportUserInputSubscriptions = require(AvatarViewport.ViewportUserInputSubscriptions)

local function useViewportOrbitInteractions(tbl1)
    local var1 = tbl1.enabled == nil or tbl1.enabled
    local var2 = tbl1.degreesPerPixel or GetFIntAvatarViewportDegreesPerPixel()
    local var3 = tbl1.pinchDeltaToZoomDelta or CameraMath.PINCH_DELTA_TO_ZOOM_DELTA

    local var4 = CameraMath.clampYRotDeg(tbl1.initialYRotDeg or 0)
    local yRotDeg, var6 = React.useState(var4)
    local yRotDegRef = React.useRef(var4)

    local var8 = React.useRef(false)
    local var9 = React.useRef(false)
    local var10 = React.useRef(nil)
    local var11 = React.useRef(0)

    local var12 = React.useRef({})

    local var13 = React.useRef(nil)
    local var14 = React.useRef(1)

    local distanceScaleRef = React.useRef(tbl1.distanceScale)
    local var16 = React.useRef(tbl1.onYRotDegChanged)
    local var17 = React.useRef(tbl1.onDistanceScaleChanged)
    local var18 = React.useRef(tbl1.onCameraUpdateRequested)
    var16.current = tbl1.onYRotDegChanged
    var17.current = tbl1.onDistanceScaleChanged
    var18.current = tbl1.onCameraUpdateRequested

    React.useEffect(function()
        distanceScaleRef.current = CameraMath.clampDistanceScale(tbl1.distanceScale)
    end, { tbl1.distanceScale })

    local var19 = React.useCallback(function(current: number, tbl2)
        yRotDegRef.current = current
        if tbl2 and tbl2.syncReactState then
            var6(current)
        end
        if tbl2 and tbl2.notifyParent == true and var16.current then
            var16.current(current)
        end
        if var18.current then
            var18.current()
        end
    end, {})

    local var20 = React.useRef(var4)
    local var21 = React.useRef(nil)

    local var22 = React.useCallback(function()
        local current = yRotDegRef.current
        if current == var20.current then
            return
        end
        var20.current = current
        var6(current)
        if var16.current then
            var16.current(current)
        end
    end, {})
    var21.current = var22

    local resetYaw = React.useCallback(function(num1: number?)
        local current = CameraMath.clampYRotDeg(num1 or tbl1.initialYRotDeg or 0)
        var20.current = current
        var19(current, { syncReactState = true })
    end, { var19, tbl1.initialYRotDeg })

    local applyZoomGesture = React.useCallback(function(num1: number)
        local current = CameraMath.adjustDistanceScaleByZoomGesture(distanceScaleRef.current, num1)
        if current == distanceScaleRef.current then
            return
        end
        distanceScaleRef.current = current
        if var17.current then
            var17.current(current)
        end
        if var18.current then
            var18.current()
        end
    end, {})

    local var25 = React.useCallback(function(arg1)
        if var11.current > 1 or not (var8.current and var1) then
            return
        end

        local current = var10.current
        if not current then
            var10.current = arg1.Position
            return
        end

        local var25 = arg1.Position.X - current.X
        var10.current = arg1.Position

        local var26 = CameraMath.clampYRotDeg(yRotDegRef.current - var25 * var2)

        var19(var26, { syncReactState = false, notifyParent = false })
    end, { var1, var2, var19 })

    local applyYawDelta = React.useCallback(function(num1: number)
        if not var1 then
            return
        end
        local var26 = CameraMath.clampYRotDeg(yRotDegRef.current + num1)
        var19(var26, { syncReactState = false, notifyParent = false })
    end, { var1, var19 })

    React.useEffect(function()
        if var8.current then
            return
        end
        resetYaw(var4)
    end, { var4, resetYaw })

    React.useEffect(function()
        local var27 = ViewportUserInputSubscriptions.connectInputChanged(function(current)
            if var9.current then
                if ViewportInputTypes.isMouseMovement(current) then
                    var25(current)
                end
                return
            end

            if var8.current and var11.current == 1 and ViewportInputTypes.isTouch(current) and current == var13.current then
                var25(current)
            end
        end)

        local var28 = ViewportUserInputSubscriptions.connectInputEnded(function(arg1)
            if ViewportInputTypes.isPrimaryPointerEnded(arg1) then
                if not var9.current then
                    return
                end
                var9.current = false
                var8.current = false
                var10.current = nil
                if var21.current then
                    var21.current()
                end
                return
            end

            if not ViewportInputTypes.isTouch(arg1) then
                return
            end

            if not var12.current[arg1] then
                return
            end
            var12.current[arg1] = nil
            local var28 = var11
            var28.current = math.max(0, var11.current - 1)
            if var11.current == 0 then
                var8.current = false
                var13.current = nil
                var10.current = nil
                if var21.current then
                    var21.current()
                end
            elseif var11.current > 1 then
                var8.current = false
                var13.current = nil
                var10.current = nil
            end
        end)

        return function()
            var27:Disconnect()
            var28:Disconnect()
            var9.current = false
            var8.current = false
            var10.current = nil
            var11.current = 0
            table.clear(var12.current)
            var13.current = nil
        end
    end, { var25 })

    local onTouchPinch = React.useCallback(function(_, tbl2, _: number, _vector2: Vector2, userInputState)
        if not var1 or #tbl2 < 2 then
            return
        end

        if userInputState == Enum.UserInputState.Begin then
            var14.current = (tbl2[1] - tbl2[2]).Magnitude
            var8.current = false
            var13.current = nil
            var10.current = nil
        else
            local magnitude = (tbl2[1] - tbl2[2]).Magnitude
            local var27 = magnitude - var14.current
            var14.current = magnitude
            applyZoomGesture(var27 * var3)
        end
    end, { var1, applyZoomGesture, var3 })

    return {
        yRotDeg = yRotDeg,
        yRotDegRef = yRotDegRef,
        distanceScaleRef = distanceScaleRef,
        resetYaw = resetYaw,
        commitYaw = var22,
        applyYawDelta = applyYawDelta,
        applyZoomGesture = applyZoomGesture,
        inputHandlers = {
            onInputBegan = React.useCallback(function(_, current)
                if not var1 then
                    return
                end

                if ViewportInputTypes.isPrimaryPointerBegan(current) then
                    var9.current = true
                    var8.current = true
                    var10.current = current.Position
                    return
                end

                if not ViewportInputTypes.isTouch(current) or var12.current[current] then
                    return
                end

                var12.current[current] = true
                local var28 = var11
                var28.current += 1
                if var11.current > 1 then
                    var8.current = false
                    var13.current = nil
                    var10.current = nil
                    return
                end

                var8.current = true
                var13.current = current
                var10.current = current.Position
            end, { var1 }),
            onInputChanged = React.useCallback(function(_, arg1)
                if ViewportInputTypes.isMouseWheel(arg1) then
                    applyZoomGesture(arg1.Position.Z)
                elseif not (var9.current or var8.current and var11.current >= 1 and ViewportInputTypes.isTouch(arg1)) then
                    var25(arg1)
                end
            end, { var25, applyZoomGesture }),
            onInputEnded = React.useCallback(function(_, arg1)
                if not ViewportInputTypes.isPrimaryPointerEnded(arg1) then
                    return
                end

                var9.current = false
                var8.current = false
                var10.current = nil
                if var21.current then
                    var21.current()
                end
            end, {}),
            onTouchPinch = onTouchPinch
        }
    }
end

return useViewportOrbitInteractions
