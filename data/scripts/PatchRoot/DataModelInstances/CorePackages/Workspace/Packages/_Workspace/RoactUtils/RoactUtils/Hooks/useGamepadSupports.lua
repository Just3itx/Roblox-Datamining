-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)
local useExternalEvent = require(script.Parent.useExternalEvent)
local doesGamepadSupportKeyCodes = require(script.Parent.doesGamepadSupportKeyCodes)

local function useGamepadSupports<T>(tbl1, arg1: T)
    local var1 = React.useCallback(function()
        return doesGamepadSupportKeyCodes(tbl1, UserInputService:GetLastInputType())
    end, { tbl1, arg1 })

    local var2, var3 = React.useState(var1)

    local var4 = React.useCallback(function()
        var3(var1())
    end, { var1 })

    useExternalEvent(UserInputService.GamepadConnected, var4)
    useExternalEvent(UserInputService.GamepadDisconnected, var4)

    React.useEffect(function()
        var4()
    end, { var4 })

    return var2
end

return useGamepadSupports
