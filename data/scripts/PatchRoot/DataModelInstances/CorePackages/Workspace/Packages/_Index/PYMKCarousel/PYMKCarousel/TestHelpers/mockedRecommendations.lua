-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local Dash = dependencies.Dash
local RoduxFriends = dependencies.RoduxFriends
local RoduxUsers = dependencies.RoduxUsers
local SocialCommon = dependencies.SocialCommon

local Recommendation = RoduxFriends.Models.Recommendation
local RecommendationContextType = RoduxFriends.Enums.RecommendationContextType
local User = RoduxUsers.Models.User
local RecommendationSourceEnum = SocialCommon.Enums.RecommendationSourceEnum
local RECOMMENDATION_SESSION_ID_KEY = require(PYMKCarousel.Common.Constants).RECOMMENDATION_SESSION_ID_KEY

local PresenceType = require(PYMKCarousel.installReducer.RoduxPresence).Enums.PresenceType

local HomepagePYMKCarousel = RecommendationSourceEnum.HomepagePYMKCarousel

local recommendationIds = {
    longName = "1_longName",
    noContext = "2_noContext",
    mutualContextPlural = "3_mutualContextPlural",
    mutualContextSingle = "4_mutualContextSingle",
    mutualContextNone = "5_mutualContextNone",
    frequentContext = "6_frequentContext",
    pendingFriendRequest = "7_pendingFriendRequest",
    incomingFriendRequest = "8_incomingFriendRequest",
    contact = "9_contact"
}

local recommendationIdsList = Dash.map(Dash.values(recommendationIds), function(id)
    return { id = id }
end)

return {
    recommendationIds = recommendationIds,
    state = {
        ScreenSize = Vector2.new(1920, 1080),
        TopBar = { topBarHeight = 10 },
        GlobalGuiInset = { bottom = 10 },
        LocalUserId = "123456",
        PYMKCarousel = {
            NetworkStatus = {},
            Users = {
                byUserId = {
                    [recommendationIds.longName] = User.mock({ displayName = "Very Long Display Name" }),
                    [recommendationIds.noContext] = User.mock(),
                    [recommendationIds.mutualContextPlural] = User.mock(),
                    [recommendationIds.mutualContextSingle] = User.mock(),
                    [recommendationIds.mutualContextNone] = User.mock(),
                    [recommendationIds.frequentContext] = User.mock(),
                    [recommendationIds.pendingFriendRequest] = User.mock(),
                    [recommendationIds.incomingFriendRequest] = User.mock(),
                    [recommendationIds.contact] = User.mock()
                }
            },
            Friends = {
                recommendations = {
                    bySource = {
                        [HomepagePYMKCarousel] = {
                            [recommendationIds.longName] = true,
                            [recommendationIds.noContext] = true,
                            [recommendationIds.mutualContextPlural] = true,
                            [recommendationIds.mutualContextSingle] = true,
                            [recommendationIds.mutualContextNone] = true,
                            [recommendationIds.frequentContext] = true,
                            [recommendationIds.pendingFriendRequest] = true,
                            [recommendationIds.incomingFriendRequest] = true,
                            [recommendationIds.contact] = true
                        }
                    },
                    byUserId = {
                        ["123456"] = {
                            [recommendationIds.longName] = Recommendation.mock({ id = recommendationIds.longName, rank = 5 }),
                            [recommendationIds.noContext] = Recommendation.mock({ id = recommendationIds.noContext, contextType = RecommendationContextType.None, rank = 6 }),
                            [recommendationIds.mutualContextPlural] = Recommendation.mock({
                                id = recommendationIds.mutualContextPlural,
                                contextType = RecommendationContextType.MutualFriends,
                                mutualFriendsList = { "111", "222", "333" },
                                rank = 10
                            }),
                            [recommendationIds.mutualContextSingle] = Recommendation.mock({
                                id = recommendationIds.mutualContextSingle,
                                contextType = RecommendationContextType.MutualFriends,
                                mutualFriendsList = { "111" },
                                rank = 12
                            }),
                            [recommendationIds.mutualContextNone] = Recommendation.mock({
                                id = recommendationIds.mutualContextNone,
                                contextType = RecommendationContextType.MutualFriends,
                                mutualFriendsList = {},
                                rank = 1
                            }),
                            [recommendationIds.frequentContext] = Recommendation.mock({
                                id = recommendationIds.frequentContext,
                                contextType = RecommendationContextType.Frequents,
                                mutualFriendsList = {},
                                rank = 0
                            }),
                            [recommendationIds.pendingFriendRequest] = Recommendation.mock({ id = recommendationIds.pendingFriendRequest, rank = 70 }),
                            [recommendationIds.incomingFriendRequest] = Recommendation.mock({ id = recommendationIds.incomingFriendRequest, rank = 71 }),
                            [recommendationIds.contact] = Recommendation.new({
                                id = recommendationIds.contact,
                                rank = 80,
                                contextType = RecommendationContextType.Contacts,
                                entityId = "contact_entity_1",
                                entityDisplayName = "Contact Display Name",
                                thumbnailEntities = {
                                    avatarImageUrl = "https://example.com/contact-avatar.png",
                                    headshotImageUrl = ""
                                }
                            })
                        }
                    },
                    hasIncomingFriendRequest = {
                        [recommendationIds.incomingFriendRequest] = true
                    }
                },
                friendshipStatus = {
                    [recommendationIds.pendingFriendRequest] = Enum.FriendStatus.FriendRequestSent
                }
            },
            Analytics = {
                bySessionKey = {
                    [RECOMMENDATION_SESSION_ID_KEY] = "mockedRecommendationSessionId"
                }
            },
            Presence = {
                byUserId = {
                    [recommendationIds.noContext] = {
                        userPresenceType = PresenceType.Online
                    }
                }
            }
        }
    },
    recommendationIdsList = recommendationIdsList
}
