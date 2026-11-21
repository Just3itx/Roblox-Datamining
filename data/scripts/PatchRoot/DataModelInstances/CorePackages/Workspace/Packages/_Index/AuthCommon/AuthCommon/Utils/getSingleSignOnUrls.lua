-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

local getAppFeaturePolicies = require(AuthCommonParent.UniversalAppPolicy).getAppFeaturePolicies

local function getSingleSignOnUrls(arg1)
    local var1 = arg1 or getAppFeaturePolicies()

    local urlAuthRoutes = var1.getUrlAuthRoutes()
    local singleSignOnUrls = {}

    local linkedAuthEndpointsEnabled = var1.getLinkedAuthEndpointsEnabled()

    if urlAuthRoutes.account then
        singleSignOnUrls.account = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.account)
    end

    if linkedAuthEndpointsEnabled and urlAuthRoutes.linkedLogin then
        singleSignOnUrls.connect = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.linkedLogin)
    elseif urlAuthRoutes.connect then
        singleSignOnUrls.connect = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.connect)
    end

    if urlAuthRoutes.disconnect then
        singleSignOnUrls.disconnect = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.disconnect)
    end

    if linkedAuthEndpointsEnabled and urlAuthRoutes.externalLogin then
        singleSignOnUrls.login = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.externalLogin)
    elseif urlAuthRoutes.login then
        singleSignOnUrls.login = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.login)
    end

    if linkedAuthEndpointsEnabled and urlAuthRoutes.linkedSignup then
        singleSignOnUrls.signup = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.linkedSignup)
    elseif urlAuthRoutes.signup then
        singleSignOnUrls.signup = UrlBuilder.fromString("auth" .. ":" .. urlAuthRoutes.signup)
    end

    if linkedAuthEndpointsEnabled then
        singleSignOnUrls.linkingPlatform = var1.getLinkingPlatform()
    end

    return singleSignOnUrls
end

return getSingleSignOnUrls
