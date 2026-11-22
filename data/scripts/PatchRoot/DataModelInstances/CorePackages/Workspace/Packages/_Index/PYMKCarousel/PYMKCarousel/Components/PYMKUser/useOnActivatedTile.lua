-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = dependencies.React
local Constants = require(scriptParentParentParent.Common.Constants)
local SocialCommon = require(scriptParentParentParentParent.SocialCommon)
local _UserList = require(scriptParentParentParentParent.UserList)
local RecommendationContextType = dependencies.RoduxFriends.Enums.RecommendationContextType
local getRecommendationContextualInfoType = SocialCommon.Utils.getRecommendationContextualInfoType
local Analytics = require(scriptParentParentParent.Analytics)
local getFriendStatus = require(scriptParentParentParent.Analytics.getFriendStatus)
local EventNames = Analytics.EventNames
local _AnalyticsTypes = require(scriptParentParentParent.Analytics.AnalyticsTypes)
local FFlagPymkCarouselExtendProps = require(scriptParentParentParentParent.SharedFlags).FFlagPymkCarouselExtendProps

local function useOnActivatedTile(tbl1)
    local mutualFriendsCount = React.useMemo(function()
        if tbl1.recommendation.mutualFriendsCount then
            return tbl1.recommendation.mutualFriendsCount
        end

        if tbl1.recommendation.mutualFriendsList then
            return #tbl1.recommendation.mutualFriendsList
        end

        return nil
    end, { tbl1.recommendation.mutualFriendsCount, tbl1.recommendation.mutualFriendsList })

    local useCallback = React.useCallback
    local function func1()
        local openProfilePeekView = tbl1.openProfilePeekView
        local userId = tbl1.userId
        local tbl2 = {
            absolutePosition = tbl1.absolutePosition,
            source = if FFlagPymkCarouselExtendProps then if tbl1.analyticsSurface then tbl1.analyticsSurface.source else Constants.HomepagePYMKCarouselSourceName else Constants.HomepagePYMKCarouselSourceName,
            isRecommendation = true,
            mutualFriendsCount = mutualFriendsCount,
            recommendationSessionId = tbl1.recommendationSessionId,
            recommendationRank = tbl1.recommendation.rank,
            recommendationContextType = tbl1.recommendation.contextType and tbl1.recommendation.contextType.rawValue() or nil,
            contextualInfoType = getRecommendationContextualInfoType(tbl1.recommendation),
            contactProps = if tbl1.recommendation.contextType == RecommendationContextType.Contacts then {
                contactId = tbl1.userId,
                avatarImageUrl = if tbl1.recommendation.thumbnailEntities then tbl1.recommendation.thumbnailEntities.avatarImageUrl else nil,
                contactName = tbl1.recommendation.entityDisplayName
            } else nil,
            profileType = if tbl1.recommendation.contextType == RecommendationContextType.Contacts then "FromContacts" else nil
        }
        openProfilePeekView(userId, tbl2)
    end

    local openProfilePeekView = tbl1.openProfilePeekView
    local userId = tbl1.userId
    local absolutePosition = tbl1.absolutePosition

    local recommendationSessionId = tbl1.recommendationSessionId
    local recommendation = tbl1.recommendation
    local analyticsSurface = if FFlagPymkCarouselExtendProps then tbl1.analyticsSurface else nil
    local var2 = useCallback(func1, {
        openProfilePeekView,
        userId,
        absolutePosition,
        mutualFriendsCount,
        recommendationSessionId,
        recommendation,
        analyticsSurface
    })

    return (React.useCallback(function()
        var2()
        tbl1.fireAnalyticsEvent(EventNames.UserPressed, {
            recommendationId = tbl1.userId,
            friendStatus = getFriendStatus(tbl1.friendshipStatus, tbl1.recommendation.hasIncomingFriendRequest),
            recommendationContextType = tbl1.recommendation.contextType,
            recommendationRank = tbl1.recommendation.rank,
            absolutePosition = tbl1.absolutePosition,
            positionInRow = tbl1.absolutePosition,
            contactId = if tbl1.recommendation.contextType == RecommendationContextType.Contacts then tbl1.userId else nil,
            presence = tbl1.userPresenceType,
            interactionUuid = HttpService:GenerateGUID(false)
        })
    end, {
        var2,
        tbl1.fireAnalyticsEvent,
        tbl1.userId,
        tbl1.friendshipStatus,
        tbl1.absolutePosition,
        tbl1.userPresenceType,
        tbl1.recommendation.hasIncomingFriendRequest,
        tbl1.recommendation.contextType,
        tbl1.recommendation.rank
    }))
end
return useOnActivatedTile
