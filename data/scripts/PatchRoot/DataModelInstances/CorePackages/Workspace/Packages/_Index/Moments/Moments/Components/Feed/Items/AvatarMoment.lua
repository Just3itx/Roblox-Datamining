-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local AvatarMomentContainer = require(script.AvatarMomentContainer)
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local makeRecommendationAttribution = require(Moments.Analytics.makeRecommendationAttribution)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)

return {{
    kind = "avatarMoment",
    getKey = function(arg1)
        local feedItemId = arg1.moment.recommendationMetadata.feedItemId
        return if feedItemId == nil or feedItemId == "" then arg1.moment.momentId else feedItemId
    end,
    getAttribution = function(arg1)
        local moment = arg1.moment
        if FFlagMomentsRecommendationContentType then
            return makeRecommendationAttribution(moment.recommendationMetadata, moment, "Avatar")
        end

        local recommendationMetadata = moment.recommendationMetadata
        local feedItemId = recommendationMetadata.feedItemId
        return if feedItemId == nil or feedItemId == "" then nil else {
            itemId = feedItemId,
            tracingId = recommendationMetadata.tracingId
        }
    end,
    render = function(arg1, index: number)
        return React.createElement(AvatarMomentContainer, { index = index, item = arg1 })
    end
}}
