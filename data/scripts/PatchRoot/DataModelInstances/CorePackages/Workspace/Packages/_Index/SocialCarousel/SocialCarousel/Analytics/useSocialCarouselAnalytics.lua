-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local SharedFlags = require(SocialCarouselParent.SharedFlags)
local SocialLuaAnalytics = require(SocialCarouselParent.SocialLuaAnalytics)
local UIBlox = require(SocialCarouselParent.UIBlox)

local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local initializeSocialCarouselAnalytics = require(SocialCarousel.Analytics.initializeSocialCarouselAnalytics)
local EventNames = require(SocialCarousel.Analytics.EventNames)
local getFriendStatusFromTileType = require(SocialCarousel.Analytics.getFriendStatusFromTileType)
local _Types = require(SocialCarousel.Common.Types)

local RetrievalStatus = UIBlox.App.Loading.Enum.RetrievalStatus
local FFlagSocialCarouselEnableUserSeenEvents = require(SocialCarousel.Flags).FFlagSocialCarouselEnableUserSeenEvents

local FFlagSocialCarouselLogNewFriendRequestsBadge = require(SocialCarousel.Flags.FFlagSocialCarouselLogNewFriendRequestsBadge)
local FFlagSocialCarouselShareQREnabled = SharedFlags.FFlagSocialCarouselShareQREnabled
local FFlagLuaAppUserSeenCollectionUnifiedFields = SharedFlags.FFlagLuaAppUserSeenCollectionUnifiedFields
local FFlagSocialCarouselInGamePlayIcon = SharedFlags.FFlagSocialCarouselInGamePlayIcon

local repeatValue = SocialLuaAnalytics.Analytics.Formatters.repeatValue

return function()
    local var1 = useSocialCarouselContext()

    local var2 = React.useMemo(function()
        local sortAnalyticsData = var1.sortAnalyticsData

        return initializeSocialCarouselAnalytics({
            infoForAllEvents = {
                sortIndex = if sortAnalyticsData then sortAnalyticsData.sortIndex or nil else nil,
                sortId = if sortAnalyticsData then sortAnalyticsData.sortId or nil else nil,
                appPage = if sortAnalyticsData then sortAnalyticsData.appPage or nil else nil,
                rowNumber = 1,
                feedRowNumber = sortAnalyticsData and sortAnalyticsData.startRow or nil
            }
        })
    end, { var1.sortAnalyticsData })

    local source = var1.source or ""

    local userPressed = React.useCallback(function(arg1, arg2)
        var2.fireAnalyticsEvent(EventNames.UserPressed, {
            presence = if arg1.presence then arg1.presence.userPresenceType else "Offline",
            absolutePosition = arg2.absolutePosition,
            positionInRow = arg2.absolutePosition,
            friendId = arg1.id,
            friendStatus = getFriendStatusFromTileType(arg1.tileType),
            recommendationContextType = arg1.contextType,
            recommendationRank = arg1.rank,
            isRecommendation = not not arg1.contextType,
            universeId = if arg1.presence then arg1.presence.universeId else nil,
            source = source,
            interactionUuid = HttpService:GenerateGUID(false),
            tileClickTarget = if FFlagSocialCarouselInGamePlayIcon then arg2.tileClickTarget else nil
        })
    end, { source, var2 })

    local var4 = if FFlagSocialCarouselEnableUserSeenEvents then React.useCallback(function(arg1, arg2)
        var2.fireAnalyticsEvent(EventNames.UserSeen, {
            userId = arg1.id,
            presence = if arg1.presence then arg1.presence.userPresenceType else "Offline",
            absolutePosition = arg2.absolutePosition,
            friendStatus = getFriendStatusFromTileType(arg1.tileType),
            recommendationContextType = arg1.contextType,
            recommendationRank = if arg1.contextType then arg1.rank else nil,
            isRecommendation = not not arg1.contextType,
            source = source,
            universeId = if arg1.presence then arg1.presence.universeId else nil
        })
    end, { source }) else nil

    local tilesSeenCollection = React.useCallback(function(tbl1)
        local sortAnalyticsData = if FFlagLuaAppUserSeenCollectionUnifiedFields then var1.sortAnalyticsData else nil
        local startRow = if FFlagLuaAppUserSeenCollectionUnifiedFields and sortAnalyticsData then sortAnalyticsData.startRow else nil
        var2.fireAnalyticsEvent(EventNames.TilesSeenCollection, {
            userId = tbl1.userIds,
            absolutePosition = tbl1.absolutePositions,
            presence = tbl1.presences,
            recommendationRank = tbl1.recommendationRanks,
            friendStatus = tbl1.friendStatuses,
            recommendationContextType = tbl1.recommendationContextTypes,
            isRecommendation = tbl1.isRecommendations,
            universeId = tbl1.universeIds,
            tileCount = tbl1.tileCount,
            source = source,
            sessionEventCount = tbl1.sessionEventCount,
            contentType = if FFlagLuaAppUserSeenCollectionUnifiedFields then tbl1.contentType else nil,
            interactionUuid = if FFlagLuaAppUserSeenCollectionUnifiedFields then HttpService:GenerateGUID(false) else nil,
            collectionId = if FFlagLuaAppUserSeenCollectionUnifiedFields and sortAnalyticsData then sortAnalyticsData.sortId else nil,
            collectionPosition = if FFlagLuaAppUserSeenCollectionUnifiedFields and sortAnalyticsData then sortAnalyticsData.sortIndex else nil,
            positionsInRow = if FFlagLuaAppUserSeenCollectionUnifiedFields then tbl1.absolutePositions else nil,
            rowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields then repeatValue(1, tbl1.tileCount) else nil,
            feedRowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields and startRow then repeatValue(startRow, tbl1.tileCount) else nil,
            totalNumberOfItems = FFlagLuaAppUserSeenCollectionUnifiedFields and #var1.tiles or nil
        })
    end, {
        source,
        var2,
        var1.sortAnalyticsData,
        var1.tiles
    })

    local startSquadPressed = React.useCallback(function(absolutePosition: number)
        var2.fireAnalyticsEvent(EventNames.StartSquadPressed, { absolutePosition = absolutePosition, source = source })
    end, { source, var2 })

    local var7 = if FFlagSocialCarouselShareQREnabled then React.useCallback(function(absolutePosition: number)
        var2.fireAnalyticsEvent(EventNames.ShareQRPressed, { absolutePosition = absolutePosition, source = source })
    end, { source, var2 }) else nil

    local addFriendsPressed = React.useCallback(function(num1: number)
        var2.fireAnalyticsEvent(EventNames.ViewAddFriends, {
            friendCount = var1.friendCount,
            absolutePosition = num1,
            positionInRow = num1,
            recommendationCount = var1.recommendationCount,
            requestCount = var1.friendRequestCount,
            source = source,
            interactionUuid = HttpService:GenerateGUID(false)
        })
    end, {
        var1.friendCount,
        var1.recommendationCount,
        var1.friendRequestCount,
        source,
        var2
    })

    local var9 = if FFlagSocialCarouselLogNewFriendRequestsBadge then React.useCallback(function(tbl1)
        var2.fireAnalyticsEvent(EventNames.AddFriendsTileSeen, {
            newRequestCount = tbl1.newRequestCount,
            previousCount = tbl1.previousCount,
            trigger = tbl1.trigger,
            badgeEnabled = tbl1.badgeEnabled,
            badgeShown = tbl1.badgeShown,
            badgeCapped = tbl1.badgeCapped,
            absolutePosition = tbl1.absolutePosition,
            source = source
        })
    end, { source, var2 }) else nil

    local friendsHeaderPressed = React.useCallback(function()
        var2.fireAnalyticsEvent(
            EventNames.ViewAllFriends,
            {
                friendCount = var1.friendCount,
                recommendationCount = var1.recommendationCount,
                source = source
            }
        )
    end, {
        var1.friendCount,
        var1.recommendationCount,
        source,
        var2
    })

    local reportLoadingEvent = React.useCallback(function(fetch: string, num1: number)
        local loadingTime = num1 and typeof(num1) == "number" and not (num1 < 0) and num1 or 0

        var2.fireAnalyticsEvent(
            EventNames.FriendsCarouselUILoadingTime,
            {
                loadingTime = loadingTime,
                fetch = fetch,
                status = RetrievalStatus.Done.rawValue(),
                source = source
            }
        )
    end, { source, var2 })

    local tbl1 = {
        userPressed = userPressed,
        userSeen = 0,
        tilesSeenCollection = 0,
        addFriendsPressed = 0,
        addFriendsTileSeen = 0,
        friendsHeaderPressed = 0,
        reportLoadingEvent = 0,
        startSquadPressed = 0,
        shareQRPressed = 0
    }

    if not FFlagSocialCarouselEnableUserSeenEvents then
        var4 = nil
    end

    tbl1.userSeen = var4
    tbl1.tilesSeenCollection = tilesSeenCollection
    tbl1.addFriendsPressed = addFriendsPressed
    if not FFlagSocialCarouselLogNewFriendRequestsBadge then
        var9 = nil
    end

    tbl1.addFriendsTileSeen = var9
    tbl1.friendsHeaderPressed = friendsHeaderPressed
    tbl1.reportLoadingEvent = reportLoadingEvent
    tbl1.startSquadPressed = startSquadPressed
    if not FFlagSocialCarouselShareQREnabled then
        var7 = nil
    end

    tbl1.shareQRPressed = var7
    return tbl1
end
