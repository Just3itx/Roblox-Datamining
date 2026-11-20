-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui").RobloxGui.Modules.Settings.Pages.ShareGame

local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable
local Constants = require(ShareGame.Constants)

local SetDeviceLayout = require(ShareGame.Actions.SetDeviceLayout)
local SetDeviceOrientation = require(CorePackages.Workspace.Packages.DeviceOrientationRodux).Actions.SetDeviceOrientation
local SetIsSmallTouchScreen = require(ShareGame.Actions.SetIsSmallTouchScreen)

return function(arg1, arg2)
    arg1 = arg1
        or {
            DeviceLayout = Constants.DeviceLayout.DESKTOP,
            DeviceOrientation = Constants.DeviceOrientation.INVALID,
            IsSmallTouchScreen = false
        }

    if arg2.type == SetDeviceOrientation.name then
        return (Immutable.Set(arg1, "DeviceOrientation", arg2.deviceOrientation))
    end

    if arg2.type == SetDeviceLayout.name then
        return (Immutable.Set(arg1, "DeviceLayout", arg2.deviceLayout))
    end

    if arg2.type == SetIsSmallTouchScreen.name then
        arg1 = Immutable.Set(arg1, "IsSmallTouchScreen", arg2.isSmallTouchScreen)
    end

    return arg1
end
