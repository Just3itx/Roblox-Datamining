-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:49:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local HttpService = game:GetService("HttpService")
local Promise = require(AuthCommonParent.Promise)
local LoginRequests = require(AuthCommon.Http.Requests.LoginRequests)
local LoginResult = require(AuthCommon.Models.LoginResult)
local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)
local LoginMethods = require(AuthCommon.Enums.LoginMethods)
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)

local FFlagEnableLastLoginMethodTracking = require(AuthCommonParent.SharedFlags).FFlagEnableLastLoginMethodTracking
local FFlagEnableRecordLogin = require(AuthCommonParent.SharedFlags).FFlagEnableRecordLogin

local Logger = require(AuthCommonParent.Loggers).Logger
local recordLogin = require(AuthCommon.Utils.recordLogin)

local function loginByPasskey(arg1, arg2, arg3)
    return function(_)
        return LoginRequests.logByPasskey(arg1, arg2, arg3):andThen(function(arg4)
            assert(arg4, "no login attempt result")
            assert(#arg4 == 1, "no result or more than one result")
            local jsonData = LoginResult.fromJsonData(arg4[1])
            assert(jsonData, "result invalid")
            if FFlagEnableLastLoginMethodTracking then
                AppStorageUtilities.setLastSuccessfulSignInMethod(LoginMethods.Passkey)
            end
            if FFlagEnableRecordLogin then
                pcall(function()
                    recordLogin(jsonData, LoginMethods.Passkey, jsonData.user.name)
                end)
            end
            return jsonData
        end, function(arg4)
            Logger:error("Error logging in by passkey. Error: {}", arg4.Body)
            local var1 = HttpService:JSONDecode(arg4.Body)
            local code = var1.errors[1].code

            local userFacingMessage = var1 and var1.errors and var1.errors[1] and var1.errors[1].userFacingMessage

            local errorKey = if code == LoginErrorCodes.IncorrectCValueOrPassword then "Authentication.Login.Response.InvalidPasskeyCredential" else "Authentication.Login.Response.SomethingWentWrong"

            return Promise.reject({ errorCode = code, errorKey = errorKey, userFacingMessage = userFacingMessage })
        end)
    end
end

return loginByPasskey
