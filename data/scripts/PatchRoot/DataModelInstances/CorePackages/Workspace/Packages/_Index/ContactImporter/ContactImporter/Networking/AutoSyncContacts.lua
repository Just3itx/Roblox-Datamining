-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local NetworkingContacts = require(scriptParentParent.dependencies).NetworkingContacts
local contactImporterSync = require(scriptParentParent.Utils.contactImporterSync)
local formatContacts = require(scriptParentParent.Utils.formatContacts)
local UploadContactsSources = require(scriptParentParent.Analytics.Enums.UploadContactsSources)
local PermissionsProtocol = require(scriptParentParentParent.PermissionsProtocol).PermissionsProtocol

local default = PermissionsProtocol.default
local tbl1 = { PermissionsProtocol.Permissions.CONTACTS_ACCESS }

return function(str1: string, arg1, arg2, bool1: boolean?)
    return function(arg3)
        default:hasPermissions(tbl1):andThen(function(arg4)
            if not arg4 or arg4.status ~= PermissionsProtocol.Status.AUTHORIZED then
                return
            end

            local unixTimestampMillis = DateTime.now().UnixTimestampMillis

            local var1 = contactImporterSync:shouldSyncContacts(arg2, str1, unixTimestampMillis)
            if not bool1 and not var1 then
                return
            end

            return arg1:getContacts():andThen(function(arg5)
                local var2 = formatContacts(arg5)
                var2.source = UploadContactsSources.AutoSync
                return arg3:dispatch(NetworkingContacts.UploadContactsByUser.API(var2))
            end):andThen(function()
                return contactImporterSync:updateSyncTimestamp(arg2, str1, unixTimestampMillis)
            end):catch(function() end)
        end):catch(function() end)
    end
end
