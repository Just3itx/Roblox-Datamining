-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local UserInputService = game:GetService("UserInputService")

local default = require(scriptParentParentParent.PermissionsProtocol).PermissionsProtocol.default

local SaveCaptureToExternalStorage = require(scriptParentParent.Thunks.SaveCaptureToExternalStorage)
local SaveCapturesToExternalStorage = require(scriptParentParent.Thunks.SaveCapturesToExternalStorage)

local _Types = require(scriptParentParent.Types)

return function(arg1, callback: ((...any) -> (...any))?, callback2)
    default:hasPermissions({ default.Permissions.WRITE_MEDIA_STORAGE }):andThen(function(arg2)
        local bool1 = arg2.status == default.Status.AUTHORIZED or UserInputService:GetPlatform() == Enum.Platform.OSX
        if UserInputService:GetPlatform() == Enum.Platform.Android and not bool1 then
            if not callback then
                return
            end
            assert(callback ~= nil, "openPermissionModal is not nil")
            callback()
            return
        end

        if bool1 then
            if #arg1 > 0 then
                callback2(SaveCapturesToExternalStorage(arg1))
            else
                callback2(SaveCaptureToExternalStorage(arg1))
            end

            return
        end

        default:requestPermissions({ default.Permissions.WRITE_MEDIA_STORAGE }):andThen(function(arg3)
            if arg3.status ~= default.Status.AUTHORIZED and arg3.status ~= default.Status.UNSUPPORTED then
                return
            end

            if #arg1 > 0 then
                callback2(SaveCapturesToExternalStorage(arg1))
                return
            end
            callback2(SaveCaptureToExternalStorage(arg1))
        end):catch(function() end)
    end):catch(function()
        if UserInputService:GetPlatform() == Enum.Platform.Android and callback then
            assert(callback ~= nil, "openPermissionModal is not nil")
            callback()
        end
    end)
    return nil
end
