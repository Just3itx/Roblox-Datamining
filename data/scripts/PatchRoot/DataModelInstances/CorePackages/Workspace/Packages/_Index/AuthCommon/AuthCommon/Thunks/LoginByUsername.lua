-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:49:57Z
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
local LoginByUsernameSSOErrorsTelemetry = require(AuthCommon.Utils.LoginByUsernameSSOErrorsTelemetry)
local GetLoginByUsernameErrorMessage = require(AuthCommon.Utils.GetLoginByUsernameErrorMessage)
local LoginMethods = require(AuthCommon.Enums.LoginMethods)
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local recordLogin = require(AuthCommon.Utils.recordLogin)

local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)
local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies

local GetDxBlob = require(AuthCommon.Utils.GetDxBlob)
local GetCaptchaDataJson = require(AuthCommon.Utils.GetCaptchaDataJson)

local GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin
local GetFFlagEnableGenericTwoFAMessage = require(AuthCommonParent.SharedFlags).GetFFlagEnableGenericTwoFAMessage
local FFlagEnableLastLoginMethodTracking = require(AuthCommonParent.SharedFlags).FFlagEnableLastLoginMethodTracking
local bool1 = game:DefineFastFlag("EnablePasskeyOnlyUserErrorMessage", false)
local FFlagEnableRecordLogin = require(AuthCommonParent.SharedFlags).FFlagEnableRecordLogin

local bool2 = game:DefineFastFlag("EnableIllegalChildAccountLinkingErrorMessageOnLoginByUsername", false)
local bool3 = game:DefineFastFlag("EnableLoginNetworkingErrorToast", false)
local SetNetworkingErrorToast = require(AuthCommonParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast

local function loginRequest(arg1, cvalue, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 1 call site recovered
    if getAppFeaturePolicies().getUseSingleSignOn() then
        return LoginRequests.singleSignOnConnectWithCredential(arg1, cvalue, arg2, "Username")
    end
    return LoginRequests.logByUsername(arg1, cvalue, arg2, arg3, arg4)
end

local function loginByUsername(arg1, cvalue, arg2, captchaCallback, arg3, securityQuestionsCallback, arg4)
    return function(arg5)
        local var1 = getAppFeaturePolicies().getUseSingleSignOn()
        return loginRequest(arg1, cvalue, arg2, arg3, arg4):andThen(function(arg6)
            assert(arg6, "no login attempt result")
            assert(#arg6 == 1, "no result or more than one result")
            local jsonData = LoginResult.fromJsonData(arg6[1])
            assert(jsonData, "result invalid")
            local appFeaturePolicies = getAppFeaturePolicies()

            if (var1 and not appFeaturePolicies.getLinkedAuthEndpointsEnabled() or not appFeaturePolicies.getWebViewSupport())
                and jsonData
                and LoginResult.hasTwoStepData(jsonData)
            then
                return Promise.reject({
                    errorCode = LoginErrorCodes.ServiceUnavailable,
                    errorKey = if GetFFlagEnableGenericTwoFAMessage() then "Authentication.Login.Response.Require2FAGeneric" else "Authentication.Login.Response.Require2FA"
                })
            end

            if FFlagEnableLastLoginMethodTracking then
                AppStorageUtilities.setLastSuccessfulSignInMethod(LoginMethods.Username)
            end

            if FFlagEnableRecordLogin then
                pcall(function()
                    recordLogin(jsonData, LoginMethods.Username, cvalue)
                end)
            end

            return jsonData
        end, function(arg6)
            if bool3 and arg6.Body == nil and arg6.HttpError ~= nil and arg6.HttpError ~= Enum.HttpError.OK then
                arg5:dispatch(SetNetworkingErrorToast(arg6))
                return Promise.reject({ errorKey = nil, errorCode = nil })
            end

            local var2 = HttpService:JSONDecode(arg6.Body)
            local loginByUsernameErrorMessage = nil
            local code = var2.errors[1].code
            local var3 = nil
            local userFacingMessage = var2 and var2.errors and var2.errors[1] and var2.errors[1].userFacingMessage

            if code == LoginErrorCodes.IncorrectCValueOrPassword then
                loginByUsernameErrorMessage = "Authentication.Login.Response.IncorrectUsernamePassword"
            elseif code == LoginErrorCodes.Captcha then
                GetDxBlob(var2)

                local captchaId, dxBlob = GetCaptchaDataJson(var2)

                local tbl1 = {
                    name = AppPage.CaptchaNative,
                    detail = "",
                    extraProps = {
                        captchaCallback = captchaCallback,
                        captchaType = "login",
                        captchaId = captchaId,
                        cvalueType = "username",
                        cvalue = cvalue,
                        dxBlob = dxBlob,
                        backNavigationDisabledWhileLoading = true
                    }
                }

                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                else
                    arg5:dispatch(NavigateDown(tbl1))
                end
            elseif GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and code == LoginErrorCodes.SecurityQuestions then
                loginByUsernameErrorMessage = "Authentication.Login.Response.SomethingWentWrong"
                if var2.errors[1].fieldData then
                    local var4 = HttpService:JSONDecode(var2.errors[1].fieldData)
                    if var4.sessionId and var4.userId then
                        var3 = var4
                        loginByUsernameErrorMessage = nil
                    end
                end
            elseif code == LoginErrorCodes.ServiceUnavailable then
                loginByUsernameErrorMessage = "Authentication.Login.Response.ServiceUnavailable"
            elseif bool2 and code == LoginErrorCodes.IllegalChildAccountLinking then
                loginByUsernameErrorMessage = "Authentication.Login.LinkIllegalChildAccountLinking"
            elseif bool1 and code == LoginErrorCodes.PasskeyOnlyUser then
                loginByUsernameErrorMessage = "Authentication.Login.Error.PasskeyOnlyAccount"
            elseif code ~= LoginErrorCodes.AccountLocked then
                loginByUsernameErrorMessage = "Authentication.Login.Response.SomethingWentWrong"
            end

            if var1 then
                warn("Login ErrorCode:", code)
                loginByUsernameErrorMessage = GetLoginByUsernameErrorMessage(code)
                local msgShown = if loginByUsernameErrorMessage[1] then loginByUsernameErrorMessage[1] else loginByUsernameErrorMessage
                LoggingProtocol.default:logRobloxTelemetryEvent(
                    LoginByUsernameSSOErrorsTelemetry,
                    nil,
                    { ssoErrorCode = code, msgShown = msgShown }
                )
            end

            return Promise.reject({
                errorKey = loginByUsernameErrorMessage,
                errorCode = code,
                securityQuestionsData = var3,
                securityQuestionsCallback = securityQuestionsCallback,
                userFacingMessage = userFacingMessage
            })
        end)
    end
end

return loginByUsername
