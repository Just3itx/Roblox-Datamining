-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local scriptParentParentParent = scriptParentParent.Parent
local EventNames = require(script.Parent.EventNames)
local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)
local SharedFlags = require(scriptParentParentParent.SharedFlags)

local Enums = SocialLuaAnalytics.Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes
local BtnValues = require(script.Parent.BtnValues)
local Constants = require(scriptParentParent.Common.Constants)

local formatRecommendationContextType = SocialLuaAnalytics.Analytics.Formatters.formatRecommendationContextType

local getFFlagPYMKAddFriendsEntry = dependencies.getFFlagPYMKAddFriendsEntry
local FFlagLuaAppPYMKSendUserSeenCollection = SharedFlags.FFlagLuaAppPYMKSendUserSeenCollection
local FFlagLuaAppUserSeenCollectionUnifiedFields = SharedFlags.FFlagLuaAppUserSeenCollectionUnifiedFields
local FFlagPymkCarouselExtendProps = SharedFlags.FFlagPymkCarouselExtendProps

local function func1<T>(arg1: T): T
    return arg1
end

local function presence(arg1)
    if arg1 then
        return tostring(arg1)
    end

    return nil
end

local tbl1 = {
    [EventNames.CarouselLoadedWithUsers] = {
        context = Contexts.HomePage,
        eventType = EventTypes.FriendsCarouselLoaded,
        additionalInfo = {
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            recommendationCount = func1,
            recommendationLimit = nil,
            refreshCount = func1
        }
    },
    [EventNames.PYMKCarouselLoadingTime] = {
        context = Contexts.HomePage,
        eventType = EventTypes.LoadingTime,
        additionalInfo = {
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName
        },
        formatRulesForAdditionalInfo = { loadingTime = func1 }
    },
    [EventNames.UserSeen] = {
        context = Contexts.HomePage,
        eventType = EventTypes.UserSeen,
        additionalInfo = {
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName,
            isRecommendation = true
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            recommendationContextType = formatRecommendationContextType,
            friendStatus = func1,
            recommendationRank = func1,
            userId = func1,
            contactId = func1,
            presence = presence
        }
    },
    [EventNames.UserPressed] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName,
            isRecommendation = true,
            btn = BtnValues.OpenPeopleList,
            contentType = "User",
            actionType = "OpenProfile"
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            positionInRow = func1,
            recommendationContextType = formatRecommendationContextType,
            recommendationId = func1,
            friendStatus = func1,
            recommendationRank = func1,
            contactId = func1,
            presence = presence,
            interactionUuid = func1
        }
    },
    [EventNames.RequestFriendship] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.RequestFriendship,
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName,
            contentType = "User",
            actionType = "RequestFriendship"
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            positionInRow = func1,
            recommendationContextType = formatRecommendationContextType,
            recommendationRank = func1,
            requestedId = func1,
            contactId = func1,
            presence = presence,
            interactionUuid = func1
        }
    },
    [EventNames.AcceptFriendship] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.AcceptFriendship,
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            recommendationContextType = formatRecommendationContextType,
            recommendationRank = func1,
            requestedId = func1,
            presence = presence
        }
    },
    [EventNames.PYMKUserPresenceLoad] = {
        context = Contexts.HomePage,
        eventType = EventTypes.LoadingTime,
        additionalInfo = { source = "HomepagePYMKUserPresence" },
        formatRulesForAdditionalInfo = { loadingTime = func1 }
    }
}
local UserSeenCollection = EventNames.UserSeenCollection
local tbl2

if FFlagLuaAppPYMKSendUserSeenCollection then
    tbl2 = {
        context = Contexts.HomePage,
        eventType = EventTypes.UserSeenCollection,
        additionalInfo = {
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            userId = func1,
            absolutePosition = func1,
            presence = func1,
            recommendationRank = func1,
            friendStatus = func1,
            recommendationContextType = func1,
            isRecommendation = func1,
            universeId = func1,
            tileCount = func1,
            sessionEventCount = func1,
            contentType = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            interactionUuid = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            collectionId = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            collectionPosition = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            positionsInRow = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            rowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            feedRowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil,
            totalNumberOfItems = if FFlagLuaAppUserSeenCollectionUnifiedFields then func1 else nil
        }
    }
else
    tbl2 = nil
end

tbl1[UserSeenCollection] = tbl2

if getFFlagPYMKAddFriendsEntry() then
    local tbl3 = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            source = if FFlagPymkCarouselExtendProps then nil else Constants.HomepagePYMKCarouselSourceName
        },
        formatRulesForAdditionalInfo = { btn = func1 }
    }

    tbl1[EventNames.CarouselGenericTileClicked] = tbl3
end

return tbl1
