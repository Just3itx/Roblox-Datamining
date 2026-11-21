-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQlSharedParent = script:FindFirstAncestor("GraphQlShared").Parent
local UrlBuilder = require(GraphQlSharedParent.UrlBuilder).UrlBuilder
local Url = require(GraphQlSharedParent.Http).Url
local HttpService = game:GetService("HttpService")
local DiscoveryUtils = require(GraphQlSharedParent.DiscoveryUtils)

local FFlagEnableContextFeaturesForOmniRecommendations = require(GraphQlSharedParent.SharedFlags).FFlagEnableContextFeaturesForOmniRecommendations
local GetFFlagHomePYMKUseProfileFrameThumbnail = require(GraphQlSharedParent.SharedFlags).GetFFlagHomePYMKUseProfileFrameThumbnail
local AddSystemInfoToArgs = DiscoveryUtils.AddSystemInfoToArgs
local OmniRecommendationsPageType = DiscoveryUtils.OmniRecommendationsPageType

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "/discovery-api/omni-recommendation" })

return function(arg1, arg2, sessionId, pageToken, supportedTreatmentTypes, requestIntent, topicIds, sduiTreatmentTypes, contextFeatures, includePymkSortProfileFrame)
    local input = {
        pageType = OmniRecommendationsPageType.fromAppPage(arg2),
        sessionId = sessionId,
        pageToken = pageToken,
        supportedTreatmentTypes = supportedTreatmentTypes,
        requestIntent = requestIntent,
        topicIds = topicIds,
        sduiTreatmentTypes = sduiTreatmentTypes
    }

    if FFlagEnableContextFeaturesForOmniRecommendations and contextFeatures then
        input.contextFeatures = contextFeatures
    end

    if GetFFlagHomePYMKUseProfileFrameThumbnail() and includePymkSortProfileFrame then
        input.includePymkSortProfileFrame = includePymkSortProfileFrame
    end

    AddSystemInfoToArgs(input)

    return arg1(urlBuilder(), "POST", { postBody = HttpService:JSONEncode(input) })
end
