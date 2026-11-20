-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Modules = game:GetService("CoreGui").RobloxGui.Modules
local getCamMicPermissions = require(Modules.Settings.getCamMicPermissions)

local CorePackages = game:GetService("CorePackages")
local default = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default

return function(callback, str1: string?, bool1: boolean?)
    local var1 = nil

    if str1 then
        var1 = str1 == "camera" and { default.Permissions.CAMERA_ACCESS }
            or str1 == "microphone" and { default.Permissions.MICROPHONE_ACCESS }
            or var1
    end

    getCamMicPermissions(function(arg1)
        callback(arg1.hasCameraPermissions, arg1.hasMicPermissions)
    end, var1, bool1, "ExperienceChat.getPermissions")
end
