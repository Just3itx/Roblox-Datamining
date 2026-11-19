-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local getCamMicPermissions = require(CoreGui.RobloxGui.Modules.Settings.getCamMicPermissions)

local MicrophoneDevicePermissionsLogging = require(CoreGui.RobloxGui.Modules.Settings.Resources.MicrophoneDevicePermissionsLogging)

getCamMicPermissions(function(arg1)
    MicrophoneDevicePermissionsLogging:init(arg1.hasMicPermissions)
end, { require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default.Permissions.MICROPHONE_ACCESS }, true)
