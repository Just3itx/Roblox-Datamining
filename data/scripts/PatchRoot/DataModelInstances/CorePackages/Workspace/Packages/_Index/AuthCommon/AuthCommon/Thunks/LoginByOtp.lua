-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:49:52Z
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
local GetMultipleUsersPerCredentialErrorData = require(AuthCommon.Utils.GetMultipleUsersPerCredentialErrorData)
local GetLoginByCredentialSsoErrorMessage = require(AuthCommon.Utils.GetLoginByCredentialSsoErrorMessage)
local LoginByOtpSSOErrorsTelemetry = require(AuthCommon.Utils.LoginByOtpSSOErrorsTelemetry)

local GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin
local GetFFlagEnableLoginAccountSelector = require(AuthCommonParent.SharedFlags).GetFFlagEnableLoginAccountSelector
local GetFFlagEnableGenericTwoFAMessage = require(AuthCommonParent.SharedFlags).GetFFlagEnableGenericTwoFAMessage
local FFlagEnableLastLoginMethodTracking = require(AuthCommonParent.SharedFlags).FFlagEnableLastLoginMethodTracking
local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)
local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies
local FFlagEnableEmailOtpSsoConnect = require(AuthCommon.Flags.FFlagEnableEmailOtpSsoConnect)

local bool1 = game:DefineFastFlag("EnableIllegalChildAccountLinkingErrorMessageOnLoginByOtp", false)

local function loginRequest(arg1, arg2, arg3, arg4, arg5) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagEnableEmailOtpSsoConnect and getAppFeaturePolicies().getUseSingleSignOn() then
        return LoginRequests.singleSignOnConnectWithCredential(arg1, arg2, arg3, "EmailOtpSessionToken")
    end

    return LoginRequests.logByOtp(arg1, arg2, arg3, arg4, arg5)
end

local function loginByOtp(arg1, arg2, arg3, securityQuestionsCallback, arg4, arg5)
    return function()
        local var1 = FFlagEnableEmailOtpSsoConnect and getAppFeaturePolicies().getUseSingleSignOn()
        return loginRequest(arg1, arg2, arg3, arg4, arg5):andThen(function(arg6)
            assert(arg6, "no login attempt result")
            assert(#arg6 == 1, "no result or more than one result")
            local jsonData = LoginResult.fromJsonData(arg6[1])
            assert(jsonData, "result invalid")
            if var1 then
                local appFeaturePolicies = getAppFeaturePolicies()
                if not (appFeaturePolicies.getLinkedAuthEndpointsEnabled() and appFeaturePolicies.getWebViewSupport())
                    and LoginResult.hasTwoStepData(jsonData)
                then
                    return Promise.reject({
                        errorCode = LoginErrorCodes.ServiceUnavailable,
                        errorKey = if GetFFlagEnableGenericTwoFAMessage() then "Authentication.Login.Response.Require2FAGeneric" else "Authentication.Login.Response.Require2FA"
                    })
                end
            end

            if FFlagEnableLastLoginMethodTracking then
                AppStorageUtilities.setLastSuccessfulSignInMethod(LoginMethods.EmailOtp)
            end
            return jsonData
        end, function(arg6)
            local var2 = HttpService:JSONDecode(arg6.Body)
            local var3 = nil
            local code = var2.errors[1].code
            local var4 = nil
            local userFacingMessage = var2 and var2.errors and var2.errors[1] and var2.errors[1].userFacingMessage

            if var1 then
                warn("Login ErrorCode:", code)
                local errorKey = GetLoginByCredentialSsoErrorMessage.getMessage(
                    code,
                    "Authentication.Login.Response.IncorrectOtpCode",
                    "Authentication.Login.Response.UnknownErrorLoginWithDifferentMethod"
                )
                local msgShown = if type(errorKey) == "table" then errorKey[1] else errorKey
                LoggingProtocol.default:logRobloxTelemetryEvent(
                    LoginByOtpSSOErrorsTelemetry,
                    nil,
                    { ssoErrorCode = code, msgShown = msgShown }
                )
                return Promise.reject({
                    errorKey = errorKey,
                    errorCode = GetLoginByCredentialSsoErrorMessage.getUiErrorCode(code),
                    securityQuestionsCallback = securityQuestionsCallback,
                    userFacingMessage = userFacingMessage
                })
            end

            if code == LoginErrorCodes.IncorrectCValueOrPassword then
                var3 = "Authentication.Login.Response.IncorrectOtpCode"
            elseif GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and code == LoginErrorCodes.SecurityQuestions then
                var3 = "Authentication.Login.Response.SomethingWentWrong"
                if var2.errors[1].fieldData then
                    local var5 = HttpService:JSONDecode(var2.errors[1].fieldData)
                    if var5.sessionId and var5.userId then
                        var4 = var5
                        var3 = nil
                    end
                end
            else
                if GetFFlagEnableLoginAccountSelector() and code == LoginErrorCodes.MultipleUsersPerCredential then
                    local usersData = GetMultipleUsersPerCredentialErrorData(var2)
                    return Promise.reject({ errorKey = var3, errorCode = code, usersData = usersData })
                end
                if code == LoginErrorCodes.ServiceUnavailable then
                    var3 = "Authentication.Login.Response.ServiceUnavailable"
                elseif bool1 and code == LoginErrorCodes.IllegalChildAccountLinking then
                    var3 = "Authentication.Login.LinkIllegalChildAccountLinking"
                elseif code ~= LoginErrorCodes.AccountLocked then
                    var3 = "Authentication.Login.Response.UnknownErrorLoginWithDifferentMethod"
                end
            end

            return Promise.reject({
                errorKey = var3,
                errorCode = code,
                securityQuestionsData = var4,
                securityQuestionsCallback = securityQuestionsCallback,
                userFacingMessage = userFacingMessage
            })
        end)
    end
end

return loginByOtp
