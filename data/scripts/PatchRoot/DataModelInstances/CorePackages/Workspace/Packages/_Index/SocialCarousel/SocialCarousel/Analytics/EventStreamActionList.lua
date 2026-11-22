-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local SocialLuaAnalytics = require(SocialCarouselParent.SocialLuaAnalytics)
local SharedFlags = require(SocialCarouselParent.SharedFlags)
local formatRecommendationContextType = SocialLuaAnalytics.Analytics.Formatters.formatRecommendationContextType
local Enums = SocialLuaAnalytics.Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes

local EventNames = require(script.Parent.EventNames)
local Constants = require(SocialCarousel.Common.Constants)
local FIntSocialCarouselShowRecsLimit = require(SocialCarousel.Flags).FIntSocialCarouselShowRecsLimit
local FFlagSocialCarouselShareQREnabled = SharedFlags.FFlagSocialCarouselShareQREnabled
local FFlagLuaAppUserSeenCollectionUnifiedFields = SharedFlags.FFlagLuaAppUserSeenCollectionUnifiedFields

local FFlagSocialCarouselLogNewFriendRequestsBadge = require(SocialCarousel.Flags.FFlagSocialCarouselLogNewFriendRequestsBadge)
local FFlagSocialCarouselInGamePlayIcon = SharedFlags.FFlagSocialCarouselInGamePlayIcon

local function func1<T>(arg1: T): T
    return arg1
end

local tbl1 = {
    [EventNames.UserPressed] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = Constants.ANALYTICS.BTN_VALUES.OPEN_PEOPLE_LIST,
            contentType = Constants.ANALYTICS.CONTENT_TYPE,
            actionType = Constants.ANALYTICS.ACTION_TYPES.OPEN_PROFILE
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            positionInRow = func1,
            recommendationContextType = formatRecommendationContextType,
            friendId = func1,
            friendStatus = func1,
            isRecommendation = func1,
            recommendationRank = func1,
            universeId = func1,
            presence = func1,
            source = func1,
            interactionUuid = func1,
            tileClickTarget = if FFlagSocialCarouselInGamePlayIcon then func1 else nil
        }
    },
    [EventNames.UserSeen] = {
        context = Contexts.HomePage,
        eventType = EventTypes.UserSeen,
        formatRulesForAdditionalInfo = {
            userId = func1,
            presence = func1,
            absolutePosition = func1,
            recommendationRank = func1,
            friendStatus = func1,
            recommendationContextType = formatRecommendationContextType,
            isRecommendation = func1,
            source = func1,
            universeId = func1
        }
    },
    [EventNames.ViewAddFriends] = {
        context = Contexts.AddFriends,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = Constants.ANALYTICS.BTN_VALUES.ADD_FRIENDS,
            absolutePosition = func1,
            positionInRow = func1,
            contentType = Constants.ANALYTICS.CONTENT_TYPE,
            actionType = Constants.ANALYTICS.ACTION_TYPES.OPEN_ADD_FRIENDS
        },
        formatRulesForAdditionalInfo = {
            friendCount = func1,
            recommendationLimit = FIntSocialCarouselShowRecsLimit,
            recommendationCount = func1,
            requestCount = func1,
            source = func1,
            interactionUuid = func1
        }
    },
    [EventNames.AddFriendsTileSeen] = FFlagSocialCarouselLogNewFriendRequestsBadge
        and {
            context = Contexts.HomePage,
            eventType = EventTypes.AddFriendsTileSeen,
            formatRulesForAdditionalInfo = {
                newRequestCount = func1,
                previousCount = func1,
                trigger = func1,
                badgeEnabled = func1,
                badgeShown = func1,
                badgeCapped = func1,
                absolutePosition = func1,
                source = func1
            }
        }
        or nil,
    [EventNames.ViewAllFriends] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = Constants.ANALYTICS.BTN_VALUES.VIEW_ALL_FRIENDS
        },
        formatRulesForAdditionalInfo = {
            friendCount = func1,
            recommendationLimit = FIntSocialCarouselShowRecsLimit,
            recommendationCount = func1,
            source = func1
        }
    },
    [EventNames.FriendsCarouselUILoadingTime] = {
        context = Contexts.HomePage,
        eventType = EventTypes.LoadingTime,
        formatRulesForAdditionalInfo = {
            status = func1,
            fetch = func1,
            loadingTime = func1,
            loadingThreshold = func1,
            nextPage = func1,
            source = func1
        },
        additionalInfo = {}
    },
    [EventNames.StartSquadPressed] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = Constants.ANALYTICS.BTN_VALUES.START_SQUAD
        },
        formatRulesForAdditionalInfo = { absolutePosition = func1, source = func1 }
    },
    [EventNames.ShareQRPressed] = FFlagSocialCarouselShareQREnabled
        and {
            context = Contexts.HomePage,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = Constants.ANALYTICS.BTN_VALUES.SHARE_QR
            },
            formatRulesForAdditionalInfo = { absolutePosition = func1, source = func1 }
        }
        or nil
}

local TilesSeenCollection = EventNames.TilesSeenCollection
local tbl2 = {
    context = Contexts.HomePage,
    eventType = EventTypes.UserSeenCollection,
    formatRulesForAdditionalInfo = 0
}
local formatRulesForAdditionalInfo = {
    userId = func1,
    absolutePosition = func1,
    presence = func1,
    recommendationRank = func1,
    friendStatus = func1,
    recommendationContextType = func1,
    isRecommendation = func1,
    universeId = func1,
    tileCount = func1,
    source = func1,
    sessionEventCount = func1,
    contentType = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    interactionUuid = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    collectionId = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    collectionPosition = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    positionsInRow = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    rowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    feedRowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
    totalNumberOfItems = 0
}

if not FFlagLuaAppUserSeenCollectionUnifiedFields then
    func1 = nil
end

formatRulesForAdditionalInfo.totalNumberOfItems = func1
tbl2.formatRulesForAdditionalInfo = formatRulesForAdditionalInfo
tbl1[TilesSeenCollection] = tbl2

return tbl1
