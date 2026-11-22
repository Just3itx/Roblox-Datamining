-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local RoduxFriends = dependencies.RoduxFriends
local Players = dependencies.Players
local llama = dependencies.llama

local transformOmniRecommendationsToActions = require(script.Parent.transformOmniRecommendationsToActions)
local _OmniTypes = require(PYMKCarousel.Common.OmniTypes)
local Constants = require(PYMKCarousel.Common.Constants)
local RecommendationContextType = RoduxFriends.Enums.RecommendationContextType
local SocialCommon = dependencies.SocialCommon
local RecommendationSourceEnum = SocialCommon.Enums.RecommendationSourceEnum
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes

local function func1(contextType: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    local rawValue = RecommendationContextType.fromRawValue(contextType)
    return rawValue and rawValue ~= RecommendationContextType.None
end

local function func2(arg1, rank: number, arg2)
    local contextType = if func1(arg1.contextType) then arg1.contextType else arg2.contextType
    local var1 = if arg2.mutualFriendsCount then tonumber(arg2.mutualFriendsCount) or 0 else 0

    if contextType == RecommendationContextType.MutualFriends.rawValue() and var1 == 0 then
        contextType = RecommendationContextType.None.rawValue()
    end

    local thumbnailEntities = contextType == ContextualInfoTypes.Contacts
        and {
            avatarImageUrl = arg1.AvatarThumbnailUrl,
            headshotImageUrl = arg1.HeadshotThumbnailUrl
        }
        or nil

    local tbl1 = {
        id = if contextType == ContextualInfoTypes.Contacts then arg1.ContactId else tostring(arg1.userId),
        contextType = contextType,
        mutualFriendsList = arg1.mutualFriendDisplayName,
        rank = 0,
        mutualFriendsCount = 0,
        hasIncomingFriendRequest = 0,
        thumbnailEntities = 0,
        contactId = 0,
        displayName = 0
    }

    if arg2.rank then
        rank = tonumber(arg2.rank)
    end

    tbl1.rank = rank
    tbl1.mutualFriendsCount = var1
    tbl1.hasIncomingFriendRequest = arg2.hasPendingFriendRequest == Constants.BE_TRUE_VALUE
    tbl1.thumbnailEntities = thumbnailEntities
    tbl1.contactId = arg1.ContactId
    tbl1.displayName = arg1.ContactName
    return tbl1
end

local function func3(arg1, num1: number, arg2)
    local localPlayer = Players.LocalPlayer
    assert(localPlayer, "LocalPlayer must be non-nil")
    local baseUserId = tostring(localPlayer.UserId)

    return RoduxFriends.Actions.RecommendationCreated({ baseUserId = baseUserId, recommendedUser = func2(arg1, num1, arg2) })
end

local function func4(_, arg1)
    local recommendationIds = llama.Dictionary.keys(arg1 or {})

    return RoduxFriends.Actions.RecommendationSourceCreated(
        {
            source = RecommendationSourceEnum.HomepagePYMKCarousel,
            recommendationIds = recommendationIds
        }
    )
end
return function(arg1)
    return {
        AddContentMetadata = function<T>(arg2: T): {T}
            return { arg2 }
        end,
        AddOmniRecommendations = function(arg2)
            return transformOmniRecommendationsToActions(arg2.recommendations or {}, arg1, func3, func4)
        end
    }
end
