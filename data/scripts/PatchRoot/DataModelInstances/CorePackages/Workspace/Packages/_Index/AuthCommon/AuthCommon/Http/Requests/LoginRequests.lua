-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)
local Url = require(AuthCommonParent.Http).Url
local getSingleSignOnUrls = require(AuthCommon.Utils.getSingleSignOnUrls)
local ConsoleAuthRequestWrapper = require(AuthCommonParent.Http).Utils.ConsoleAuthRequestWrapper
local HttpService = game:GetService("HttpService")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)

local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)

local GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin

local GetFFlagEnableLoginAccountSelector = require(AuthCommonParent.SharedFlags).GetFFlagEnableLoginAccountSelector
local FFlagEnableLuaAccountSwitch = require(AuthCommonParent.SharedFlags).FFlagEnableLuaAccountSwitch
local FFlagClearAccountBlobForPioneerLogin = require(AuthCommon.Flags.FFlagClearAccountBlobForPioneerLogin)
local isPioneerLaunch = require(AuthCommonParent.PioneerUtils).isPioneerLaunch

local module = {}

function getLoginUrl(): string
    return string.format("%sv2/login", Url.AUTH_URL)
end

local function getAccountBlobForLogin() -- Luacid: unused: defined but never referenced
    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    return FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
end

function module.logByPasskey(arg1, input, password)
    local httpService = HttpService
    local input2 = {
        ctype = "Passkey",
        cvalue = HttpService:JSONEncode(input),
        password = password,
        accountBlob = 0
    }

    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    input2.accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    local postBody = httpService:JSONEncode(input2)

    return arg1(getLoginUrl(), "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.logByUsername(arg1, cvalue, password, arg2, arg3)
    local httpService = HttpService
    local input = {
        ctype = "Username",
        cvalue = cvalue,
        password = password,
        captchaToken = if arg2 then arg2.captchaToken or nil else nil,
        captchaProvider = if arg2 then arg2.captchaProvider or nil else nil,
        captchaId = arg2 and arg2.captchaId or nil,
        securityQuestionSessionId = if GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 then arg3.sessionId or nil else nil,
        securityQuestionRedemptionToken = GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 and arg3.redemptionToken or nil,
        accountBlob = 0
    }

    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    input.accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    local postBody = httpService:JSONEncode(input)

    return arg1(getLoginUrl(), "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.logByEmail(arg1, cvalue, password, arg2, arg3, arg4)
    local httpService = HttpService
    local input = {
        ctype = "Email",
        cvalue = cvalue,
        password = password,
        captchaToken = if arg2 then arg2.captchaToken or nil else nil,
        captchaProvider = if arg2 then arg2.captchaProvider or nil else nil,
        captchaId = arg2 and arg2.captchaId or nil,
        securityQuestionSessionId = if GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 then arg3.sessionId or nil else nil,
        securityQuestionRedemptionToken = GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 and arg3.redemptionToken or nil,
        userId = GetFFlagEnableLoginAccountSelector() and arg4 or nil,
        accountBlob = 0
    }

    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    input.accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    local postBody = httpService:JSONEncode(input)

    return arg1(getLoginUrl(), "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.logByPhone(arg1, cvalue, password, arg2, arg3, arg4)
    local httpService = HttpService
    local input = {
        ctype = "PhoneNumber",
        cvalue = cvalue,
        password = password,
        captchaToken = if arg2 then arg2.captchaToken or nil else nil,
        captchaProvider = if arg2 then arg2.captchaProvider or nil else nil,
        captchaId = arg2 and arg2.captchaId or nil,
        securityQuestionSessionId = if GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 then arg3.sessionId or nil else nil,
        securityQuestionRedemptionToken = GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 and arg3.redemptionToken or nil,
        userId = GetFFlagEnableLoginAccountSelector() and arg4 or nil,
        accountBlob = 0
    }

    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    input.accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    local postBody = httpService:JSONEncode(input)

    return arg1(getLoginUrl(), "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.loginWithCode(arg1, cvalue, password, arg2, arg3)
    local httpService = HttpService
    local input = {
        ctype = "AuthToken",
        cvalue = cvalue,
        password = password,
        captchaToken = if arg2 then arg2.captchaToken or nil else nil,
        captchaProvider = if arg2 then arg2.captchaProvider or nil else nil,
        captchaId = arg2 and arg2.captchaId or nil,
        securityQuestionSessionId = if GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 then arg3.sessionId or nil else nil,
        securityQuestionRedemptionToken = GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg3 and arg3.redemptionToken or nil,
        accountBlob = 0
    }

    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    input.accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    local postBody = httpService:JSONEncode(input)

    return arg1(getLoginUrl(), "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.logByOtp(arg1, cvalue, password, arg2, arg3)
    local httpService = HttpService
    local input = {
        ctype = "EmailOtpSessionToken",
        cvalue = cvalue,
        password = password,
        securityQuestionSessionId = if GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg2 then arg2.sessionId or nil else nil,
        securityQuestionRedemptionToken = GetFFlagLuaAppUsingSecurityQuestionsForLuaLogin() and arg2 and arg2.redemptionToken or nil,
        userId = GetFFlagEnableLoginAccountSelector() and arg3 or nil,
        accountBlob = 0
    }

    if FFlagClearAccountBlobForPioneerLogin and isPioneerLaunch() then
        AppStorageUtilities.setAccountBlob("")
        AppStorageUtilities.flush()
    end
    input.accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    local postBody = httpService:JSONEncode(input)

    return arg1(getLoginUrl(), "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.singleSignOnLogin(arg1)
    local singleSignOnUrls = getSingleSignOnUrls()
    local login = singleSignOnUrls.login
    if not login then
        return Promise.reject({ errorCode = LoginErrorCodes.ServiceUnavailable })
    end

    local var1 = login()
    local postBody = if singleSignOnUrls.linkingPlatform then HttpService:JSONEncode({ identityProvider = singleSignOnUrls.linkingPlatform }) else "{}"

    return ConsoleAuthRequestWrapper(arg1, var1, "POST", { postBody = postBody, maxRetryCount = 0 }, true)
end

function module.singleSignOnConnectWithCode(arg1, cvalue, password)
    local singleSignOnUrls = getSingleSignOnUrls()
    local connect = singleSignOnUrls.connect
    local postBody = HttpService:JSONEncode({
        ctype = "AuthToken",
        cvalue = cvalue,
        password = password,
        accountLinkParameters = singleSignOnUrls.linkingPlatform and {
            LinkingPlatform = singleSignOnUrls.linkingPlatform
        } or nil
    })

    if not connect then
        return Promise.reject({ errorCode = LoginErrorCodes.ServiceUnavailable })
    end

    local var1 = connect()
    return ConsoleAuthRequestWrapper(arg1, var1, "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.singleSignOnConnectWithCredential(arg1, cvalue, password, ctype)
    local singleSignOnUrls = getSingleSignOnUrls()
    local connect = singleSignOnUrls.connect
    local postBody = HttpService:JSONEncode({
        ctype = ctype,
        cvalue = cvalue,
        password = password,
        accountLinkParameters = singleSignOnUrls.linkingPlatform and {
            LinkingPlatform = singleSignOnUrls.linkingPlatform
        } or nil
    })

    if not connect then
        return Promise.reject({ errorCode = LoginErrorCodes.ServiceUnavailable })
    end

    local var1 = connect()
    return ConsoleAuthRequestWrapper(arg1, var1, "POST", { postBody = postBody, maxRetryCount = 0 })
end

return module
