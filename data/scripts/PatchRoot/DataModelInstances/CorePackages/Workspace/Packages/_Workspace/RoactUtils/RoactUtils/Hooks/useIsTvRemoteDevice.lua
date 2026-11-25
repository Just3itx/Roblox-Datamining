-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local UserInputService = game:GetService("UserInputService")

local React = require(RoactUtilsParent.React)

local FFlagLuaSupportMicroGamepadPreferredInput = require(RoactUtilsParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput
local keyCode = if game:GetEngineFeature("EnableMicroGamepadKeycodes") then Enum.KeyCode.ButtonCenter else Enum.KeyCode.Return

local function useIsTvRemoteDevice()
    local var1 = React.useCallback(function()
        local var1 = FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
        if UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad and not var1 then
            return false
        end

        for _, userInputType in ipairs(UserInputService:GetConnectedGamepads()) do
            if UserInputService:GamepadSupports(userInputType, keyCode) then
                return true
            end
        end
        return false
    end, {})

    local var2, var3 = React.useState(function()
        return var1()
    end)

    React.useEffect(function()
        local connection = UserInputService.GamepadConnected:Connect(function()
            var3(var1())
        end)

        local connection2 = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
            var3(var1())
        end)

        var3(var1())

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var1 })

    return var2
end

return useIsTvRemoteDevice
