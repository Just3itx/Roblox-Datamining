-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local EventNames = require(script.Parent.EventNames)
local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)

local Enums = SocialLuaAnalytics.Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes
local BtnValues = require(script.Parent.BtnValues)
local Constants = require(scriptParentParent.Common.Constants)

local formatFriendStatus = require(script.Parent.formatFriendStatus)
local getUniverseIdFromUser = require(script.Parent.getUniverseIdFromUser)
local formatRecommendationContextType = SocialLuaAnalytics.Analytics.Formatters.formatRecommendationContextType
local formatPresence = SocialLuaAnalytics.Analytics.Formatters.formatPresence

local getFIntShowFriendRecommendationsLimit = require(scriptParentParent.Flags.getFIntShowFriendRecommendationsLimit)

local function func1<T>(arg1: T): T
    return arg1
end

return {
    [EventNames.CarouselLoadedWithUsers] = {
        context = Contexts.HomePage,
        eventType = EventTypes.FriendsCarouselLoaded,
        additionalInfo = {
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            friendCount = func1,
            recommendationCount = func1,
            recommendationLimit = getFIntShowFriendRecommendationsLimit,
            refreshCount = func1,
            experimentLayerStatus = func1,
            fetchedRecommendations = func1,
            recommendationSessionId = func1
        }
    },
    [EventNames.UserSeen] = {
        context = Contexts.HomePage,
        eventType = EventTypes.UserSeen,
        additionalInfo = {
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            recommendationContextType = formatRecommendationContextType,
            friendStatus = formatFriendStatus,
            isRecommendation = func1,
            presence = formatPresence,
            recommendationRank = func1,
            userId = func1,
            universeId = getUniverseIdFromUser
        }
    },
    [EventNames.UserPressed] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.OpenPeopleList,
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            recommendationContextType = formatRecommendationContextType,
            friendId = func1,
            friendStatus = formatFriendStatus,
            isRecommendation = func1,
            recommendationRank = func1,
            universeId = getUniverseIdFromUser,
            presence = formatPresence
        }
    },
    [EventNames.RequestFriendship] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.RequestFriendship,
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            recommendationContextType = formatRecommendationContextType,
            recommendationRank = func1,
            requestedId = func1
        }
    },
    [EventNames.RevokeFriendRequest] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.RevokeFriendRequest,
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            recommendationContextType = formatRecommendationContextType,
            recommendationRank = func1,
            requestedId = func1
        }
    },
    [EventNames.ViewAllFriends] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.FriendsLanding,
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            friendCount = func1,
            recommendationLimit = getFIntShowFriendRecommendationsLimit,
            recommendationCount = func1
        }
    },
    [EventNames.ViewAddFriends] = {
        context = Contexts.AddFriends,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.AddFriendsButton,
            absolutePosition = 1,
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            friendCount = func1,
            recommendationLimit = getFIntShowFriendRecommendationsLimit,
            recommendationCount = func1,
            requestCount = func1,
            showContactImporterModal = func1
        }
    },
    [EventNames.CarouselLoadingTime] = {
        context = Contexts.HomePage,
        eventType = EventTypes.CarouselLoadingTime,
        additionalInfo = {
            source = Constants.HomepageFriendsCarouselSourceName
        },
        formatRulesForAdditionalInfo = {
            carouselFetchingStatus = func1,
            friendsFetchingStatus = func1,
            recommendationFetchingStatus = func1,
            loadingTime = func1,
            reachedThreshold = func1,
            loadingThreshold = func1,
            experimentLayerStatus = func1,
            isLegacyCarousel = func1
        }
    },
    [EventNames.ContactImporterOnAddFriends] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ContactImporterOnAddFriends,
        additionalInfo = { isLegacyAddFriends = false }
    },
    [EventNames.PaginatedFriendsCarouselLoadingTime] = {
        context = Contexts.HomePage,
        eventType = EventTypes.LoadingTime,
        formatRulesForAdditionalInfo = {
            status = func1,
            loadingTime = func1,
            loadingThreshold = func1,
            nextPage = func1,
            fetch = func1
        },
        additionalInfo = {
            source = Constants.HomepageFriendsCarouselSourceName
        }
    },
    [EventNames.FriendsEndpointLoadingTime] = {
        context = Contexts.HomePage,
        eventType = EventTypes.LoadingTime,
        formatRulesForAdditionalInfo = {
            status = func1,
            loadingTime = func1,
            loadingThreshold = func1,
            nextPage = func1,
            fetch = func1
        },
        additionalInfo = {
            source = Constants.HomepageFriendsCarouselSourceName
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
            nextPage = func1
        },
        additionalInfo = {
            source = Constants.HomepageFriendsCarouselSourceName
        }
    }
}
