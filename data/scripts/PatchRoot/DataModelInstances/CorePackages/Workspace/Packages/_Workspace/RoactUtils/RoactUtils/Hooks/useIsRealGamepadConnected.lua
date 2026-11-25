-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtils = script:FindFirstAncestor("RoactUtils")
local RoactUtilsParent = RoactUtils.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(RoactUtilsParent.React)
local useExternalEvent = require(script.Parent.useExternalEvent)
local TvRemoteUtils = require(RoactUtils.TvRemoteUtils)

local function useIsRealGamepadConnected()
    local var1, var2 = React.useState(TvRemoteUtils.isRealGamepadConnected)

    local var3 = React.useCallback(function()
        var2(TvRemoteUtils.isRealGamepadConnected())
    end, {})

    useExternalEvent(UserInputService.GamepadConnected, var3)
    useExternalEvent(UserInputService.GamepadDisconnected, var3)

    React.useEffect(function()
        var3()
    end, { var3 })

    return var1
end

return useIsRealGamepadConnected
