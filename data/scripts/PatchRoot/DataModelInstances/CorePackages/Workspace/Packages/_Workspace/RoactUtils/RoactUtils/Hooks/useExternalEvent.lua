-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local GetFFlagMigrateRoactUtilsToReactUtils = require(RoactUtilsParent.SharedFlags).GetFFlagMigrateRoactUtilsToReactUtils
local ReactUtils = require(RoactUtilsParent.ReactUtils)

if GetFFlagMigrateRoactUtilsToReactUtils() then
    return ReactUtils.useEventConnection
end

local React = require(RoactUtilsParent.React)

local function useExternalEvent<T>(rbxScriptSignal: T, func1: (...any) -> (...any))
    React.useEffect(function()
        if rbxScriptSignal == nil then
            return nil
        end

        local connection = rbxScriptSignal:Connect(func1)
        return function()
            connection:Disconnect()
        end
    end, { rbxScriptSignal, func1 })
end

return useExternalEvent
