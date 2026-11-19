-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local AppCommonLibParent = script:FindFirstAncestor("AppCommonLib").Parent

local IsVRAppBuild = require(script.Parent.IsVRAppBuild)
local isTenFootInterface = require(script.Parent.isTenFootInterface)

local RobloxAppEnums = require(AppCommonLibParent.RobloxAppEnums)
local DeviceOrientationMode = RobloxAppEnums.DeviceOrientationMode
local DeviceType = RobloxAppEnums.DeviceType

local function getDeviceType(arg1)
    if IsVRAppBuild() then
        return DeviceType.VR
    end

    if isTenFootInterface() then
        return DeviceType.Console
    end

    local none = Enum.Platform.None
    pcall(function()
        none = UserInputService:GetPlatform()
    end)

    local windows = Enum.Platform.Windows

    if none ~= windows then
        local osx = Enum.Platform.OSX

        if none ~= osx then
            local uwp = Enum.Platform.UWP

            if none ~= uwp then
                local ios = Enum.Platform.IOS
                local bool1 = false

                if none ~= ios then
                    local android = Enum.Platform.Android
                    bool1 = none ~= android
                end
                if not bool1 then
                    if arg1 == DeviceOrientationMode.Landscape then
                        return DeviceType.Tablet
                    end

                    if arg1 == DeviceOrientationMode.Portrait then
                        return DeviceType.Phone
                    end
                end

                return DeviceType.Unknown
            end
        end
    end

    return DeviceType.Desktop
end

return getDeviceType
