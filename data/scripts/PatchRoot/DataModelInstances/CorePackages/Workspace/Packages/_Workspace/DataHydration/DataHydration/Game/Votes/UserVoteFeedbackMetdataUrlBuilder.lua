-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Url = require(DataHydrationParent.Http).Url
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local GetFStringEdpPlayerFeedbackServiceRoute = require(DataHydrationParent.SharedFlags).GetFStringEdpPlayerFeedbackServiceRoute

return {
    USER_VOTE_FEEDBACK_METADATA_URL = UrlBuilder.new({ base = Url.APIS_URL, path = "{serviceRoute}/v1/channels/{channel}/assets" })(
        {
            serviceRoute = GetFStringEdpPlayerFeedbackServiceRoute(),
            channel = "experience-discovery-page"
        }
    ),
    buildUserVoteFeedbackMetadataUrl = function(rootPlaceId: string)
        return UrlBuilder.new({ base = Url.APIS_URL, path = "{serviceRoute}/v1/channels/{channel}/assets/{rootPlaceId}" })({
            serviceRoute = GetFStringEdpPlayerFeedbackServiceRoute(),
            channel = "experience-discovery-page",
            rootPlaceId = rootPlaceId
        })
    end
}
