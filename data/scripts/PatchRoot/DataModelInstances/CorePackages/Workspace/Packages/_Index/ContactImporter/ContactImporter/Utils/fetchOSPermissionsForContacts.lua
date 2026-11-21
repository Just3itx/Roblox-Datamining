-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local updateOptedInUsers = dependencies.SocialModalsCommon.Utils.updateOptedInUsers
local PermissionsProtocol = dependencies.PermissionsProtocol
local AppStorageService = dependencies.AppStorageService

return function(arg1, callback: ((...any) -> (...any))?)
    arg1:hasPermissions({ PermissionsProtocol.Permissions.CONTACTS_ACCESS }):andThen(function(arg2)
        local var1 = arg2 and arg2.status == PermissionsProtocol.Status.AUTHORIZED

        if not var1 then
            updateOptedInUsers:clearLocalStorage(AppStorageService)
        end
        if callback then
            callback(var1)
        end
    end):catch(function(_)
        if callback then
            callback(false)
        end
    end)
end
