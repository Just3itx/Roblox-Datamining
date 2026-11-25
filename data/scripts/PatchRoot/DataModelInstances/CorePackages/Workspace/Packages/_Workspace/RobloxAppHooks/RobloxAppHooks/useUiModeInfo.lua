-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local React = require(RobloxAppHooksParent.React)

local RobloxAppEnums = require(RobloxAppHooksParent.RobloxAppEnums)
local DeviceType = RobloxAppEnums.DeviceType
local UiMode = RobloxAppEnums.UiMode
local useDeviceType = require(script.Parent.useDeviceType)

local tbl1 = {
    [DeviceType.Desktop] = UiMode.Unknown,
    [DeviceType.Tablet] = UiMode.Unknown,
    [DeviceType.Phone] = UiMode.Unknown,
    [DeviceType.Console] = UiMode.TenFoot,
    [DeviceType.VR] = UiMode.VR
}

local function useUiModeInfo()
    local deviceType = useDeviceType()
    local uiMode = tbl1[deviceType] or UiMode.Unknown

    return (React.useMemo(function()
        return { deviceType = deviceType, uiMode = uiMode }
    end, { deviceType, uiMode }))
end

return useUiModeInfo
