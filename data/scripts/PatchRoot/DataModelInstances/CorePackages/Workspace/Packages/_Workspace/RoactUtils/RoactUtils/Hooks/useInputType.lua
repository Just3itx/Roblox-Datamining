-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)
local useExternalEvent = require(script.Parent.useExternalEvent)
local getInputGroup = require(RoactUtilsParent.InputType).getInputGroup

local function useInputType(arg1)
    local var1 = arg1 or UserInputService

    local function getLastInputType()
        local lastInputType = var1:GetLastInputType()
        return getInputGroup(lastInputType)
    end

    local var2, var3 = React.useState(getLastInputType)

    local var4 = React.useCallback(function(arg2)
        local inputGroup = getInputGroup(arg2)
        if inputGroup ~= nil then
            var3(inputGroup)
        end
    end)

    useExternalEvent(var1.LastInputTypeChanged, var4)

    React.useEffect(function()
        var3(getLastInputType())
    end, {})

    return var2
end

return useInputType
