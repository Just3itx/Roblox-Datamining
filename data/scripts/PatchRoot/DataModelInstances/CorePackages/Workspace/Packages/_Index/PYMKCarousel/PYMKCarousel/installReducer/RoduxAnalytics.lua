-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local _OmniTypes = require(PYMKCarousel.Common.OmniTypes)
local transformOmniRecommendationsToActions = require(script.Parent.transformOmniRecommendationsToActions)
local RECOMMENDATION_SESSION_ID_KEY = require(PYMKCarousel.Common.Constants).RECOMMENDATION_SESSION_ID_KEY
local convertActions = dependencies.convertActions
local RoduxAnalytics = dependencies.RoduxAnalytics

local var1 = RoduxAnalytics.installReducer()

local function func1(arg1, _)
    local recommendationRequestId

    if arg1
        and arg1.recommendations
        and #arg1.recommendations > 0
        and arg1.recommendations[1]
        and arg1.recommendations[1].contentMetadata
    then
        local contentMetadata = arg1.recommendations[1].contentMetadata
        if contentMetadata then
            recommendationRequestId = contentMetadata.recommendationRequestId
        else
            recommendationRequestId = nil
        end
    else
        recommendationRequestId = nil
    end

    return RoduxAnalytics.Actions.SessionIdUpdated(
        { sessionKey = RECOMMENDATION_SESSION_ID_KEY, sessionId = recommendationRequestId }
    )
end

local function func2(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        AddOmniRecommendations = function(arg2)
            return transformOmniRecommendationsToActions(arg2.recommendations or {}, arg1, nil, func1)
        end
    }
end

return function(arg1)
    local tbl1 = func2(arg1)
    return convertActions(var1, tbl1, {})
end
