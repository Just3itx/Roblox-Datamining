-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local ImpressionsTagUtility = require(scriptParentParentParentParent.Impressions).ImpressionsTagUtility

local RoduxFriends = dependencies.RoduxFriends
local useSelector = dependencies.Hooks.useSelector
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local usePrimaryCta = require(scriptParentParentParent.Components.PYMKUser.usePrimaryCta)
local useContextualInfo = require(scriptParentParentParent.Components.PYMKUser.useContextualInfo)
local useUserPresence = require(scriptParentParentParent.Components.PYMKUser.useUserPresence)
local useOnActivatedTile = require(scriptParentParentParent.Components.PYMKUser.useOnActivatedTile)
local _DirectRecommendationTypes = require(scriptParentParentParent.Common.DirectRecommendationTypes)
local _AnalyticsTypes = require(scriptParentParentParent.Analytics.AnalyticsTypes)

local FFlagPymkCarouselPresenceStoreMigration = require(scriptParentParentParent.Flags.FFlagPymkCarouselPresenceStoreMigration)
local FFlagLuaAppEnableSduiHomePage = require(scriptParentParentParentParent.SharedFlags).FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = require(scriptParentParentParentParent.SharedFlags).FFlagPymkCarouselExtendProps

local _UserList = require(scriptParentParentParentParent.UserList)

return function(tbl1)
    local str1 = tostring(tbl1.entity.id)

    local ref = React.useRef(nil)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, tbl1.impressionsTag, tbl1.absolutePosition)
        return function()
            ImpressionsTagUtility.RemoveTag(ref, tbl1.impressionsTag, tbl1.absolutePosition)
        end
    end, { tbl1.impressionsTag, tbl1.absolutePosition })

    local var2 = if FFlagLuaAppEnableSduiHomePage then nil else useSelector(function(arg1): string
        return tostring(arg1.LocalUserId)
    end)

    local hasIncomingFriendRequest, recommendation

    if FFlagLuaAppEnableSduiHomePage then
        if tbl1.recommendation then
            hasIncomingFriendRequest = tbl1.recommendation.hasIncomingFriendRequest
        else
            hasIncomingFriendRequest = nil
        end
        recommendation = tbl1.recommendation or {}
    elseif FFlagPymkCarouselExtendProps then
        hasIncomingFriendRequest = useSelector(function(arg1)
            return getDeepValue(arg1, string.format("PYMKCarousel.Friends.recommendations.hasIncomingFriendRequest.%s", str1))
        end)

        recommendation = useSelector(function(arg1)
            return RoduxFriends.Selectors.selectRecommendationsForUserId(arg1)(var2)[str1] or {}
        end)

        if tbl1.recommendation then
            hasIncomingFriendRequest = tbl1.recommendation.hasIncomingFriendRequest
            recommendation = tbl1.recommendation
        end
    else
        hasIncomingFriendRequest = useSelector(function(arg1)
            return getDeepValue(arg1, string.format("PYMKCarousel.Friends.recommendations.hasIncomingFriendRequest.%s", str1))
        end)

        recommendation = useSelector(function(arg1)
            return RoduxFriends.Selectors.selectRecommendationsForUserId(arg1)(var2)[str1] or {}
        end)
    end

    local friendshipStatus = useSelector(function(arg1)
        return RoduxFriends.Selectors.selectFriendshipStatusesByUserIds(arg1)({ userId = str1 })[str1] or nil
    end)

    local primaryCta = usePrimaryCta({
        entityId = str1,
        showToast = tbl1.showToast,
        fireAnalyticsEvent = tbl1.fireAnalyticsEvent,
        absolutePosition = tbl1.absolutePosition,
        entityType = tbl1.entity.type,
        recommendation = if FFlagPymkCarouselExtendProps or FFlagLuaAppEnableSduiHomePage then tbl1.recommendation else nil
    })

    local contextualInfo = useContextualInfo({ recommendation = recommendation, hasIncomingFriendRequest = hasIncomingFriendRequest })

    local loadingState = {
        subtitle = false,
        contextualInfo = recommendation.contextType == nil
    }
    local var6 = useUserPresence({
        userId = str1,
        entityType = if FFlagPymkCarouselPresenceStoreMigration then tbl1.entity.type else nil,
        forceFetchUserPresence = if FFlagPymkCarouselPresenceStoreMigration then tbl1.forceFetchUserPresence else nil
    })
    local onRowActivated = useOnActivatedTile({
        userId = str1,
        openProfilePeekView = tbl1.openProfilePeekView,
        absolutePosition = tbl1.absolutePosition,
        recommendation = recommendation,
        recommendationSessionId = tbl1.recommendationSessionId,
        fireAnalyticsEvent = tbl1.fireAnalyticsEvent,
        friendshipStatus = friendshipStatus,
        userPresenceType = var6,
        analyticsSurface = if FFlagPymkCarouselExtendProps then tbl1.analyticsSurface else nil
    })
    local row = tbl1.createRow({
        primaryCta = primaryCta,
        secondaryCta = nil,
        contextualInfo = contextualInfo,
        loadingState = loadingState,
        presence = var6,
        trailingContent = nil,
        onRowActivated = onRowActivated
    })

    if row then
        return React.cloneElement(row, { ref = ref })
    end
    return nil
end
