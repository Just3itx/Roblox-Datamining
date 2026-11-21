-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local Constants = require(AvatarViewport.Constants)
local ViewportGamepadInput = require(AvatarViewport.ViewportGamepadInput)

local function useViewportGamepadOrbit(tbl1)
    local var1 = tbl1.enabled == nil or tbl1.enabled
    local actionName = tbl1.actionName or Constants.GamepadOrbitActionName
    local var2 = tbl1.thumbstickDeadzone or ViewportGamepadInput.defaultDeadzone
    local var3 = tbl1.yawSpeedDegPerSecond or ViewportGamepadInput.getDefaultYawSpeedDegPerSecond()
    local var4 = tbl1.zoomGestureSpeedPerSecond or ViewportGamepadInput.getDefaultZoomGestureSpeedPerSecond()
    local var5 = tbl1.zoomAxisThreshold or ViewportGamepadInput.defaultZoomAxisThreshold
    local inputTypes = tbl1.thumbstickKeyCode or Enum.KeyCode.Thumbstick2

    local var6 = React.useRef(false)
    local var7 = React.useRef(false)
    local var8 = React.useRef(tbl1.applyYawDelta)
    local var9 = React.useRef(tbl1.applyZoomGesture)
    local var10 = React.useRef(tbl1.onOrbitEnded)
    var8.current = tbl1.applyYawDelta
    var9.current = tbl1.applyZoomGesture
    var10.current = tbl1.onOrbitEnded

    React.useEffect(function()
        if not var1 or not UserInputService.GamepadEnabled then
            return
        end

        local zero = Vector2.zero

        ContextActionService:UnbindCoreAction(actionName)
        ContextActionService:BindCoreAction(actionName, function(_: string, userInputState, arg1)
            if userInputState == Enum.UserInputState.Change then
                zero = Vector2.new(arg1.Position.X, arg1.Position.Y)
                var6.current = ViewportGamepadInput.isRotating(zero, var2)
                if var6.current or math.abs(zero.Y) > var5 then
                    var7.current = true
                end

                return Enum.ContextActionResult.Sink
            end

            if userInputState == Enum.UserInputState.End or userInputState == Enum.UserInputState.Cancel then
                zero = Vector2.zero
                var6.current = false

                if var7.current and var10.current then
                    var10.current()
                end
                var7.current = false
            end
            return Enum.ContextActionResult.Sink
        end, false, inputTypes)

        local connection = RunService.RenderStepped:Connect(function(deltaTime: number)
            local var11 = ViewportGamepadInput.computeYawDeltaDegrees(zero, deltaTime, var3, var2)

            if var11 ~= 0 and var8.current then
                var8.current(var11)
            end

            local var12 = ViewportGamepadInput.computeZoomGestureDelta(zero, deltaTime, var4, var2, var5)

            if var12 ~= 0 and var9.current then
                var9.current(var12)
            end
        end)

        return function()
            ContextActionService:UnbindCoreAction(actionName)
            connection:Disconnect()
            zero = Vector2.zero
            var6.current = false
            var7.current = false
        end
    end, {
        var1,
        actionName,
        var2,
        var3,
        var4,
        var5,
        inputTypes
    })
end

return useViewportGamepadOrbit
