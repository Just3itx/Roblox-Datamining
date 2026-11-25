-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)
local useExternalEvent = require(script.Parent.useExternalEvent)
local isGamepadInput = require(script.Parent.Parent.isGamepadInput)

local function useIsGamepad(arg1)
    local var1 = arg1 or UserInputService

    local function wasLastInputGamepad()
        local lastInputType = var1:GetLastInputType()
        return isGamepadInput(lastInputType)
    end

    local var2, var3 = React.useState(wasLastInputGamepad)

    local var4 = React.useCallback(function(arg2)
        local var4 = isGamepadInput(arg2)
        if var4 ~= nil then
            var3(var4)
        end
    end)

    useExternalEvent(var1.LastInputTypeChanged, var4)

    React.useEffect(function()
        var3(wasLastInputGamepad())
    end, {})

    return var2
end

return useIsGamepad
