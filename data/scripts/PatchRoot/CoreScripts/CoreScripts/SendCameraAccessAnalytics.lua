-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _VideoCaptureService = game:GetService("VideoCaptureService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreGui = game:GetService("CoreGui")

local Cryo = require(CorePackages.Packages.Cryo)
local getCamMicPermissions = require(CoreGui.RobloxGui.Modules.Settings.getCamMicPermissions)
local default = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default
local var1 = require(CoreGui.RobloxGui.Modules.Settings.cameraDevicesHelper).GetDevices()
local hasEligibleCamera = not Cryo.isEmpty(var1)
if not hasEligibleCamera then
    RbxAnalyticsService:SendEventDeferred(
        "client",
        "avatarChat",
        "CameraDevicePermissionResponse",
        { hasAccessToCamera = false, hasEligibleCamera = hasEligibleCamera }
    )

    return
end

getCamMicPermissions(function(arg1)
    local hasCameraPermissions = arg1.hasCameraPermissions
    RbxAnalyticsService:SendEventDeferred(
        "client",
        "avatarChat",
        "CameraDevicePermissionResponse",
        { hasAccessToCamera = hasCameraPermissions, hasEligibleCamera = hasEligibleCamera }
    )
end, { default.Permissions.CAMERA_ACCESS }, true)
