-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:49:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)
local LogoutAllLoggedInUsersRequest = require(AuthCommon.Http.Requests.LogoutAllLoggedInUsersRequest)
local GetLoggedInUsersMetadataRequest = require(AuthCommon.Http.Requests.GetLoggedInUsersMetadataRequest)
local FFlagEnableLuaAccountSwitch = require(AuthCommonParent.SharedFlags).FFlagEnableLuaAccountSwitch
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local recordSignOut = require(AuthCommon.Utils.recordSignOut)

local function recordSignOutOnLogoutAll(arg1, arg2)
    local var1, var2 = GetLoggedInUsersMetadataRequest(arg1, arg2):await()
    if not var1 or not var2 or not var2.responseBody or not var2.responseBody.logged_in_users_metadata then
        return
    end

    for _, value in ipairs(var2.responseBody.logged_in_users_metadata) do
        pcall(function()
            recordSignOut(value, true)
        end)
    end
end

return function(arg1, _: boolean)
    if not FFlagEnableLuaAccountSwitch then
        return Promise.resolve()
    end

    local accountBlob = AppStorageUtilities.getAccountBlob()

    pcall(recordSignOutOnLogoutAll, arg1, accountBlob)

    AppStorageUtilities.setAccountBlob("")
    AppStorageUtilities.flush()
    return LogoutAllLoggedInUsersRequest(arg1, accountBlob):andThen(function(arg2)
        return Promise.resolve(arg2.responseBody)
    end):catch(function(arg2)
        if arg2.data then
            return Promise.reject(arg2.data.errorCode)
        elseif not arg2.StatusCode then
            return Promise.reject()
        end
        return Promise.reject({ arg2.StatusCode })
    end)
end
