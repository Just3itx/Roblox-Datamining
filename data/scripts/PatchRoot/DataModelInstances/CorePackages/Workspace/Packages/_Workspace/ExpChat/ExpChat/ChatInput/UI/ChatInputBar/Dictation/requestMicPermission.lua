-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local default = require(ExpChatParent.PermissionsProtocol).PermissionsProtocol.default

local PermissionStatus = {
    Granted = "granted",
    Denied = "denied",
    AlreadyAllowed = "already_allowed"
}

return {
    requestMicPermission = function()
        return default:hasPermissions({ default.Permissions.MICROPHONE_ACCESS }):andThen(function(arg1)
            if arg1.status == default.Status.AUTHORIZED then
                return {
                    status = PermissionStatus.AlreadyAllowed
                }
            end

            return default:requestPermissions({ default.Permissions.MICROPHONE_ACCESS }):andThen(function(arg2)
                return if arg2.status == default.Status.AUTHORIZED then {
                    status = PermissionStatus.Granted
                } else {
                    status = PermissionStatus.Denied
                }
            end)
        end):catch(function(arg1)
            return {
                status = PermissionStatus.Denied,
                error = tostring(arg1)
            }
        end)
    end,
    PermissionStatus = PermissionStatus
}
