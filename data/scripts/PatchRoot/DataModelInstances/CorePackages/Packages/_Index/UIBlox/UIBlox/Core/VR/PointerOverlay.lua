-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local React = require(scriptParentParentParentParent.React)
local Roact = require(scriptParentParentParentParent.Roact)

local EventConnection = require(scriptParentParentParentParent.ReactUtils).EventConnection

local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
local _Constants = require(scriptParent.Constants)

local tbl1 = {
    VRService = game:GetService("VRService"),
    UpdateEvent = RunService.Heartbeat
}

local function setLaserPointerModeBasedOnUserCFrame(arg1, vrService)
    if vrService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and vrService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        arg1.current:setMode(arg1.current.Mode.DualPointer)
    elseif not (vrService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or vrService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)) then
        arg1.current:setMode(arg1.current.Mode.Disabled)
    else
        arg1.current:setMode(arg1.current.Mode.Pointer)
    end
end

local function PointerOverlay(tbl2)
    local var1 = Object.assign({}, tbl1, tbl2)

    local laserPointer = var1.LaserPointer
    local vrControllerModel = var1.VRControllerModel
    local VRService = var1.VRService

    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)

    local success, result = pcall(function()
        return VRService:GetPropertyChangedSignal("VRSessionState")
    end)

    local callback = React.useCallback(function()
        if not var2.current then
            var2.current = laserPointer.new()
            setLaserPointerModeBasedOnUserCFrame(var2, VRService)
            var2.current:setEnableAmbidexterousPointer(true)
            var3.current = vrControllerModel.new(Enum.UserCFrame.LeftHand)
            var4.current = vrControllerModel.new(Enum.UserCFrame.RightHand)
        end

        var3.current:setEnabled(VRService.VREnabled)
        var4.current:setEnabled(VRService.VREnabled)
        if VRService.VREnabled then
            ContextActionService:BindActivate(
                Enum.UserInputType.Gamepad1,
                Enum.KeyCode.ButtonA,
                Enum.KeyCode.ButtonX,
                Enum.KeyCode.ButtonR2,
                Enum.KeyCode.ButtonL2
            )
        end
    end, {
        var3,
        var4,
        var2,
        laserPointer,
        vrControllerModel
    })

    local var6 = React.useCallback(function()
        if var3.current then
            var3.current:setEnabled(false)
        end
        if var4.current then
            var4.current:setEnabled(false)
        end
        if var2.current then
            var2.current:disableComponent()
        end
        ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA)
        ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
    end, {
        var3,
        var4,
        var2,
        laserPointer,
        vrControllerModel
    })
    local var5 = React.useCallback(function()
        local bool1 = VRService.VRSessionState ~= Enum.VRSessionState.Idle and VRService.VRSessionState ~= Enum.VRSessionState.Visible

        if var2.current then
            if bool1 then
                setLaserPointerModeBasedOnUserCFrame(var2, VRService)
            else
                var2.current:setMode(var2.current.Mode.Disabled)
            end
        end
        if var3.current then
            var3.current:setEnabled(bool1)
        end
        if var4.current then
            var4.current:setEnabled(bool1)
        end
    end, {
        var3,
        var4,
        var2,
        laserPointer,
        vrControllerModel
    })
    local var7 = React.useCallback(function()
        setLaserPointerModeBasedOnUserCFrame(var2, VRService)
    end, { var2 })

    React.useEffect(function()
        if VRService.VREnabled then
            callback()
        end
        return var6
    end, {})

    return React.createElement(Roact.Portal, {
        target = workspace
    }, {
        UserCFrameChangedConnection = React.createElement(EventConnection, {
            event = var1.UpdateEvent,
            callback = function()
                if var2.current then
                    var2.current:update()
                end
                if var3.current then
                    var3.current:update()
                end
                if var4.current then
                    var4.current:update()
                end
            end
        }),
        VREnabledConnection = React.createElement(EventConnection, { event = VRService:GetPropertyChangedSignal("VREnabled"), callback = callback }),
        VRUserCFrameEnabledConnection = React.createElement(EventConnection, { event = VRService.UserCFrameEnabled, callback = var7 }),
        VRSessionStateConnection = if success then React.createElement(EventConnection, { event = result, callback = var5 }) else nil
    })
end

return PointerOverlay
