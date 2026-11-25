-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent

local useSelector = require(RobloxAppHooksParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(RobloxAppHooksParent.SignalsReact).useSignalState

local _RobloxAppEnums = require(RobloxAppHooksParent.RobloxAppEnums)
local getDeviceType = require(RobloxAppHooksParent.AppCommonLib).getDeviceType

local FFlagUseSignalsForDeviceOrientation = require(RobloxAppHooksParent.SharedFlags).FFlagUseSignalsForDeviceOrientation
local GetDeviceOrientationStore = if FFlagUseSignalsForDeviceOrientation then require(RobloxAppHooksParent.DeviceOrientationStore).GetDeviceOrientationStore else nil

local function useDeviceType()
    local var1 = if FFlagUseSignalsForDeviceOrientation then useSignalState(GetDeviceOrientationStore(false).getDeviceOrientation) else useSelector(function(arg1)
        return arg1.DeviceOrientation
    end)

    return getDeviceType(var1)
end

return useDeviceType
