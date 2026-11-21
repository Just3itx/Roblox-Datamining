-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:49:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local HttpService = game:GetService("HttpService")

local Promise = require(AuthCommonParent.Promise)
local LoginRequests = require(AuthCommon.Http.Requests.LoginRequests)
local AppPage = require(AuthCommonParent.RobloxAppEnums).AppPage
local NavigateDown = require(AuthCommonParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AuthCommonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AuthCommonParent.RobloxAppNavigation).NavigationCommands else nil
local LoginResult = require(AuthCommon.Models.LoginResult)
local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)
local LoginMethods = require(AuthCommon.Enums.LoginMethods)
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local GetMultipleUsersPerCredentialErrorData = require(AuthCommon.Utils.GetMultipleUsersPerCredentialErrorData)

local GetDxBlob = require(AuthCommon.Utils.GetDxBlob)
local GetCaptchaDataJson = require(AuthCommon.Utils.GetCaptchaDataJson)
local GetLoginByCredentialSsoErrorMessage = require(AuthCommon.Utils.GetLoginByCredentialSsoErrorMessage)
local LoginByEmailSSOErrorsTelemetry = require(AuthCommon.Utils.LoginByEmailSSOErrorsTelemetry)

local GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin
local GetFFlagEnableLoginAccountSelector = require(AuthCommonParent.SharedFlags).GetFFlagEnableLoginAccountSelector
local GetFFlagEnableGenericTwoFAMessage = require(AuthCommonParent.SharedFlags).GetFFlagEnableGenericTwoFAMessage
local FFlagEnableLastLoginMethodTracking = require(AuthCommonParent.SharedFlags).FFlagEnableLastLoginMethodTracking
local recordLogin = require(AuthCommon.Utils.recordLogin)
local FFlagEnableRecordLogin = require(AuthCommonParent.SharedFlags).FFlagEnableRecordLogin
local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)
local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies

local bool1 = game:DefineFastFlag("EnableIllegalChildAccountLinkingErrorMessageOnLoginByEmail", false)
local FFlagEnableEmailSsoConnect = require(AuthCommon.Flags.FFlagEnableEmailSsoConnect)

local function loginRequest(arg1, cvalue, arg2, arg3, arg4, arg5)
    if FFlagEnableEmailSsoConnect and getAppFeaturePolicies().getUseSingleSignOn() then
        return LoginRequests.singleSignOnConnectWithCredential(arg1, cvalue, arg2, "Email")
    end
    return LoginRequests.logByEmail(arg1, cvalue, arg2, arg3, arg4, arg5)
end

local function loginByEmail(arg1, cvalue, arg2, captchaCallback, arg3, securityQuestionsCallback, arg4, arg5)
    return function(arg6)
        local var1 = FFlagEnableEmailSsoConnect and getAppFeaturePolicies().getUseSingleSignOn()
        return loginRequest(arg1, cvalue, arg2, arg3, arg4, arg5):andThen(function(arg7)
            assert(arg7, "no login attempt result")
            assert(#arg7 == 1, "no result or more than one result")
            local jsonData = LoginResult.fromJsonData(arg7[1])
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
                AppStorageUtilities.setLastSuccessfulSignInMethod(LoginMethods.Email)
            end
            if FFlagEnableRecordLogin then
                pcall(function()
                    recordLogin(jsonData, LoginMethods.Email, cvalue)
                end)
            end
            return jsonData
        end, function(arg7)
            local var2 = HttpService:JSONDecode(arg7.Body)
            local var3 = nil
            local code = var2.errors[1].code
            local var4 = nil
            local userFacingMessage = var2 and var2.errors and var2.errors[1] and var2.errors[1].userFacingMessage

            if var1 then
                warn("Login ErrorCode:", code)
                local errorKey = GetLoginByCredentialSsoErrorMessage.getMessage(
                    code,
                    "Authentication.Login.Response.IncorrectEmailOrPassword",
                    "Authentication.Login.Response.UnverifiedEmailLoginWithUsername"
                )
                local msgShown = if type(errorKey) == "table" then errorKey[1] else errorKey
                LoggingProtocol.default:logRobloxTelemetryEvent(
                    LoginByEmailSSOErrorsTelemetry,
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
                var3 = "Authentication.Login.Response.IncorrectEmailOrPassword"
            elseif code == LoginErrorCodes.Captcha then
                GetDxBlob(var2)

                local captchaId, dxBlob = GetCaptchaDataJson(var2)

                local tbl1 = {
                    name = AppPage.CaptchaNative,
                    detail = "",
                    extraProps = {
                        captchaCallback = captchaCallback,
                        captchaType = "login",
                        cvalueType = "email",
                        captchaId = captchaId,
                        cvalue = cvalue,
                        dxBlob = dxBlob,
                        backNavigationDisabledWhileLoading = true
                    }
                }

                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                else
                    arg6:dispatch(NavigateDown(tbl1))
                end
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
                if code == LoginErrorCodes.MoreThanOneUsername then
                    var3 = "Authentication.Login.Response.MoreThanOneUsername"
                elseif code == LoginErrorCodes.ServiceUnavailable then
                    var3 = "Authentication.Login.Response.ServiceUnavailable"
                elseif code == LoginErrorCodes.AccountNotVerified then
                    var3 = "Authentication.Login.Response.UnverifiedEmailLoginWithUsername"
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

return loginByEmail
