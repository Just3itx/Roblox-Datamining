-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local HttpService = game:GetService("HttpService")

local Promise = require(AuthSignupParent.Promise)

local _Http = require(AuthSignupParent.Http)
local Url = require(AuthSignupParent.Http).Url

local AuthCommon = require(AuthSignupParent.AuthCommon)
local getSingleSignOnUrls = AuthCommon.Utils.getSingleSignOnUrls
local AppStorageUtilities = AuthCommon.Utils.AppStorageUtilities

local ConsoleAuthRequestWrapper = require(AuthSignupParent.Http).Utils.ConsoleAuthRequestWrapper

local SharedFlags = require(AuthSignupParent.SharedFlags)
local FFlagEnableLuaAccountSwitch = SharedFlags.FFlagEnableLuaAccountSwitch
local FFlagEnableKoreaKISACompliance = SharedFlags.FFlagEnableKoreaKISACompliance
local GetFFlagEnableAuditForSinglePageSignUp = SharedFlags.GetFFlagEnableAuditForSinglePageSignUp
local GetFFlagEnableAuditForSso = SharedFlags.GetFFlagEnableAuditForSso

local SignUpV2ErrorCodes = require(AuthSignup.Enums.SignUpV2ErrorCodes)

local t = require(AuthSignupParent.t)

local module = {}

function module.signUp(arg1, username: string, password: string, birthdate: string, bundleId, arg2)
    assert(type(username) == "string", "invalid username has been passed into SignUpRequests.signUp")
    assert(type(password) == "string", "invalid password has been passed into SignUpRequests.signUp")
    assert(type(birthdate) == "string", "invalid birthdate has been passed into SignUpRequests.signUp")
    assert(tonumber(bundleId) and type(bundleId) == "string", "invalid bundleId has been passed into SignUpRequests.signUp")

    local str1 = string.format("%sv3/signup", Url.AUTH_URL)

    local httpService = HttpService
    local input = {
        username = username,
        password = password,
        birthdate = birthdate,
        bundleId = bundleId,
        captchaId = if arg2 then arg2.captchaId or nil else nil,
        captchaToken = if arg2 then arg2.captchaToken or nil else nil,
        captchaProvider = arg2 and arg2.captchaProvider or nil,
        accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    }
    return arg1(str1, "POST", { postBody = httpService:JSONEncode(input), maxRetryCount = 0 })
end

local var1 = t.interface({
    username = t.string,
    password = t.string,
    gender = t.string,
    birthday = t.string,
    displayName = t.optional(t.string),
    locale = t.optional(t.string),
    email = t.optional(t.string)
})

local var2 = t.interface({ username = t.string, isExpressSignup = t.literal(true) })

local var3 = t.union(var1, var2)

function module.signUpV2(arg1, arg2, arg3)
    assert(var3(arg2))
    local captchaId = if arg3 then arg3.captchaId or nil else nil
    local captchaToken = if arg3 then arg3.captchaToken or nil else nil
    local captchaProvider = arg3 and arg3.captchaProvider or nil

    local str1 = string.format("%sv2/signup", Url.AUTH_URL)

    local httpService = HttpService
    local input = {
        username = arg2.username,
        password = arg2.password,
        gender = arg2.gender,
        birthday = arg2.birthday,
        locale = arg2.locale,
        email = arg2.email,
        otpSession = if FFlagEnableKoreaKISACompliance then arg2.otpSession else nil,
        agreementIds = arg2.agreementIds,
        displayName = arg2.displayName,
        isTosAgreementBoxChecked = true,
        captchaId = captchaId,
        captchaToken = captchaToken,
        captchaProvider = captchaProvider,
        accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil,
        passkeySessionId = arg2.passkeySessionId,
        passkeyRegistrationResponse = arg2.passkeyRegistrationResponse,
        isExpressSignup = arg2.isExpressSignup,
        auditSystemContent = GetFFlagEnableAuditForSinglePageSignUp()
            and arg2.capturedAuditContent
            and next(arg2.capturedAuditContent) ~= nil
            and {
                capturedAuditContent = arg2.capturedAuditContent,
                additionalAuditContent = arg2.additionalAuditContent
            }
            or nil
    }
    return arg1(str1, "POST", { postBody = httpService:JSONEncode(input), maxRetryCount = 0 })
end

local var4 = t.interface(
    {
        username = t.string,
        password = t.string,
        gender = t.string,
        birthday = t.string,
        verifiedSignupVoucher = t.string
    }
)
function module.verifiedSignup(arg1, arg2, arg3)
    assert(var4(arg2))
    local captchaId = if arg3 then arg3.captchaId or nil else nil
    local captchaToken = if arg3 then arg3.captchaToken or nil else nil
    local captchaProvider = arg3 and arg3.captchaProvider or nil

    return arg1(string.format("%sv1/verified-signup", Url.AUTH_URL), "POST", {
        postBody = HttpService:JSONEncode({
            username = arg2.username,
            password = arg2.password,
            gender = arg2.gender,
            birthday = arg2.birthday,
            voucher = arg2.verifiedSignupVoucher,
            agreementIds = arg2.agreementIds,
            isTosAgreementBoxChecked = true,
            captchaId = captchaId,
            captchaToken = captchaToken,
            captchaProvider = captchaProvider,
            accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
        }),
        maxRetryCount = 0
    })
end

function module.singleSignOnSignup(arg1, arg2)
    local singleSignOnUrls = getSingleSignOnUrls()
    local signup = singleSignOnUrls.signup
    local input = {
        username = arg2.username,
        password = arg2.password,
        gender = arg2.gender,
        birthday = arg2.birthday,
        locale = arg2.locale,
        email = arg2.email,
        agreementIds = arg2.agreementIds,
        isTosAgreementBoxChecked = true,
        isExpressSignup = arg2.isExpressSignup,
        accountLinkParameters = singleSignOnUrls.linkingPlatform and {
            LinkingPlatform = singleSignOnUrls.linkingPlatform
        } or nil,
        auditSystemContent = GetFFlagEnableAuditForSso()
            and arg2.capturedAuditContent
            and next(arg2.capturedAuditContent) ~= nil
            and {
                capturedAuditContent = arg2.capturedAuditContent,
                additionalAuditContent = arg2.additionalAuditContent
            }
            or nil
    }

    local postBody = HttpService:JSONEncode(input)

    if not signup then
        return Promise.reject(SignUpV2ErrorCodes.TokenValidationFailed)
    end

    local var5 = signup()
    return ConsoleAuthRequestWrapper(arg1, var5, "POST", { postBody = postBody, maxRetryCount = 0 })
end

function module.expressLinkedSignup(arg1, locale, agreementIds)
    local singleSignOnUrls = getSingleSignOnUrls()
    local signup = singleSignOnUrls.signup
    local linkingPlatform = singleSignOnUrls.linkingPlatform
    if not signup or linkingPlatform == nil or type(locale) ~= "string" then
        return Promise.reject(SignUpV2ErrorCodes.TokenValidationFailed)
    end

    local postBody = HttpService:JSONEncode({
        signupType = "Express",
        locale = locale,
        agreementIds = agreementIds,
        accountLinkParameters = { LinkingPlatform = linkingPlatform }
    })

    return ConsoleAuthRequestWrapper(arg1, signup(), "POST", { postBody = postBody, maxRetryCount = 0 }, true)
end

return module
