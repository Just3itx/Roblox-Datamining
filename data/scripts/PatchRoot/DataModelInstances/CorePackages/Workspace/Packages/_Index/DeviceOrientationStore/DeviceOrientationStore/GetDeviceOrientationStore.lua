-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DeviceOrientationStoreParent = script:FindFirstAncestor("DeviceOrientationStore").Parent

local Signals = require(DeviceOrientationStoreParent.Signals)
local DeviceOrientationMode = require(DeviceOrientationStoreParent.RobloxAppEnums).DeviceOrientationMode
local IsVRAppBuild = require(DeviceOrientationStoreParent.AppCommonLib).IsVRAppBuild

return Signals.createComputed(function()
    local getDeviceOrientation, setDeviceOrientation = Signals.createSignal(nil)

    local getIsPortrait = Signals.createComputed(function(arg1): boolean
        return getDeviceOrientation(arg1) == DeviceOrientationMode.Portrait
    end)

    return {
        getDeviceOrientation = getDeviceOrientation,
        getIsPortrait = getIsPortrait,
        getIsAvatarScenePortrait = Signals.createComputed(function(arg1)
            return IsVRAppBuild() or getIsPortrait(arg1)
        end),
        setDeviceOrientation = setDeviceOrientation,
        reset = function()
            setDeviceOrientation(nil)
        end
    }
end)
