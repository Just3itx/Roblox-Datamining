-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local HttpService = game:GetService("HttpService")
local Url = require(AuthCommonParent.Http).Url
local ConsoleAuthRequestWrapper = require(AuthCommonParent.Http).Utils.ConsoleAuthRequestWrapper

local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies

local FFlagEnableLuaAccountSwitch = require(AuthCommonParent.SharedFlags).FFlagEnableLuaAccountSwitch

local module = {}

function module.configuration(arg1, num1: number)
    return arg1(string.format("%sv1/users/%d/configuration", Url.TWOSTEPVERIFICATION_URL, num1), "GET")
end

function module.resend(arg1, username, ticket)
    return arg1(
        string.format("%sv1/twostepverification/resend", Url.AUTH_URL),
        "POST",
        {
            postBody = HttpService:JSONEncode({ username = username, ticket = ticket, actionType = "Login" }),
            maxRetryCount = 0
        }
    )
end

function module.verify(arg1, username, ticket, code, rememberDevice)
    return arg1(string.format("%sv1/twostepverification/verify", Url.AUTH_URL), "POST", {
        postBody = HttpService:JSONEncode(
            {
                username = username,
                ticket = ticket,
                code = code,
                rememberDevice = rememberDevice,
                actionType = "Login"
            }
        ),
        maxRetryCount = 0
    })
end

function module.login(arg1, arg2, challengeId, verificationToken, rememberDevice)
    local str1 = string.format("%sv3/users/%s/two-step-verification/login", Url.AUTH_URL, arg2)
    local appFeaturePolicies = getAppFeaturePolicies()
    local postBody = HttpService:JSONEncode({
        challengeId = challengeId,
        verificationToken = verificationToken,
        rememberDevice = rememberDevice,
        accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil,
        accountLinkParameters = appFeaturePolicies.getLinkingPlatform() and {
            LinkingPlatform = appFeaturePolicies.getLinkingPlatform()
        } or nil
    })

    if appFeaturePolicies.getUseSingleSignOn() and appFeaturePolicies.getLinkedAuthEndpointsEnabled() then
        return ConsoleAuthRequestWrapper(arg1, str1, "POST", { postBody = postBody, maxRetryCount = 0 })
    end

    return arg1(str1, "POST", { postBody = postBody, maxRetryCount = 0 })
end

return module
