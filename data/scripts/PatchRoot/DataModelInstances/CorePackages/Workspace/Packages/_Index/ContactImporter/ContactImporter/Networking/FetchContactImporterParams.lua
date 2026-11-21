-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local NetworkingUserSettings = dependencies.NetworkingUserSettings
local NetworkingAccountInformation = dependencies.NetworkingAccountInformation
local PermissionsProtocol = dependencies.PermissionsProtocol
local Promise = dependencies.Promise
local llama = dependencies.llama
local contactImporterModalInfo = require(scriptParentParent.Utils.contactImporterModalInfo)
local updateOptedInUsers = dependencies.SocialModalsCommon.Utils.updateOptedInUsers
local contactImporterOSPermissions = require(scriptParentParent.Utils.contactImporterOSPermissions)
local Constants = require(scriptParentParent.Common.Constants)
local SetContactImporterDisplayLogic = require(scriptParentParent.Actions.SetContactImporterDisplayLogic)

local function func1(_) end

return function(str1: string, arg1, arg2)
    return function(arg3)
        local tbl1 = {
            arg3:dispatch(NetworkingUserSettings.GetUserSettings.API({})):andThen(function(arg4)
                return Promise.resolve({ phoneNumberDiscoverability = arg4.responseBody.phoneNumberDiscoverability }, func1)
            end),
            arg3:dispatch(NetworkingAccountInformation.GetPhoneInformation.API()):andThen(function(arg4)
                return Promise.resolve({ isPhoneVerified = arg4.responseBody.isVerified }, func1)
            end),
            arg1:hasPermissions({ PermissionsProtocol.Permissions.CONTACTS_ACCESS }):andThen(function(arg4)
                local hasOsPermissions = arg4 and arg4.status == PermissionsProtocol.Status.AUTHORIZED
                if not hasOsPermissions then
                    updateOptedInUsers:clearLocalStorage(arg2)
                end
                return Promise.resolve({ hasOSPermissions = hasOsPermissions })
            end, func1)
        }

        Promise.all(tbl1):andThen(function(arg4)
            local tbl2 = {}
            for _, value in arg4 do
                tbl2 = llama.Dictionary.join(tbl2, value)
            end

            local var1 = contactImporterModalInfo:isUserOptedInLocalStorage(arg2, str1)

            local var2 = contactImporterModalInfo:shouldUserSeeModalPotentiallyAgain(arg2, str1)
            tbl2[Constants.SHOULD_SHOW_CONTACT_IMPORTER_UPSELL_AGAIN] = var2

            tbl2[Constants.IS_USER_OPTED_IN_LOCAL_STORAGE] = var1
            arg3:dispatch(SetContactImporterDisplayLogic(tbl2))

            local lastOsPermissionSettings = contactImporterOSPermissions:getLastOSPermissionSettings(arg2)
            local hasOsPermissions = tbl2.hasOSPermissions
            if lastOsPermissionSettings == hasOsPermissions then
            end

            contactImporterOSPermissions:updateOSPermissionSettings(arg2, hasOsPermissions)
        end):catch(function() end)
    end
end
