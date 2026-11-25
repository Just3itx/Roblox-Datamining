-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local UserInputService = require(RoactUtilsParent.MockableProxyServices).UserInputService

local FFlagLuaSupportMicroGamepadPreferredInput = require(RoactUtilsParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput
local keyCode = if game:GetEngineFeature("EnableMicroGamepadKeycodes") then Enum.KeyCode.ButtonCenter else Enum.KeyCode.Return

return {
    isTvRemoteDevice = function()
        local var1 = FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
        if UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad and not var1 then
            return false
        end

        for _, connectedGamepad in UserInputService:GetConnectedGamepads() do
            if UserInputService:GamepadSupports(connectedGamepad, keyCode) then
                return true
            end
        end
        return false
    end,
    isRealGamepadConnected = function()
        for _, connectedGamepad in UserInputService:GetConnectedGamepads() do
            if not UserInputService:GamepadSupports(connectedGamepad, keyCode) then
                return true
            end
        end
        return false
    end
}
