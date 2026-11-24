-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local createGameInfoStore = require(script.GameInfo.createGameInfoStore)
local createFavoritesStore = require(script.Favorites.createFavoritesStore)
local createFollowingsStore = require(script.Followings.createFollowingsStore)
local createVotesStore = require(script.Votes.createVotesStore)
local createUserVoteFeedbackMetadataStore = require(script.Votes.createUserVoteFeedbackMetadataStore)
local createPlayabilityStore = require(script.Playability.createPlayabilityStore)
local createAgeRecommendationStore = require(script.AgeRecommendations.createAgeRecommendationStore)
local createGameMediaStore = require(script.GameMedia.createGameMediaStore)
local createGameIconStore = require(script.GameIcon.createGameIconStore)
local GameIconSize = require(script.GameIcon.GameIconSize)

local getFavoritesStore = require(script.Favorites.getFavoritesStore)
local getGameInfoStore = require(script.GameInfo.getGameInfoStore)
local getGameIconStore = require(script.GameIcon.getGameIconStore)
local getFollowingsStore = require(script.Followings.getFollowingsStore)
local getVotesStore = require(script.Votes.getVotesStore)
local getUserVoteFeedbackMetadataStore = require(script.Votes.getUserVoteFeedbackMetadataStore)

local getAgeRecommendationStore = require(script.AgeRecommendations.getAgeRecommendationStore)
local getPlayabilityStore = require(script.Playability.getPlayabilityStore)
local getGameMediaStore = require(script.GameMedia.getGameMediaStore)
local getConnectionsPlayedStore = require(script.ConnectionsPlayed.getConnectionsPlayedStore)
local createConnectionsPlayedStore = require(script.ConnectionsPlayed.createConnectionsPlayedStore)

local GamePass = require(script.GamePass)
local createGamePassStore = GamePass.createGamePassStore
local getGamePassStore = GamePass.getGamePassStore

local GameDeveloperProduct = require(script.GameDeveloperProduct)
local createGameDeveloperProductStore = GameDeveloperProduct.createGameDeveloperProductStore
local getGameDeveloperProductStore = GameDeveloperProduct.getGameDeveloperProductStore

local GameSubscription = require(script.GameSubscription)
local createGameSubscriptionStore = GameSubscription.createGameSubscriptionStore
local getGameSubscriptionStore = GameSubscription.getGameSubscriptionStore

local _FollowingsStoreTypes = require(script.Followings.FollowingsStoreTypes)
local _VotesStoreTypes = require(script.Votes.VotesStoreTypes)
local VotesUtils = require(script.Votes.VotesUtils)
local _FavoritesStoreTypes = require(script.Favorites.FavoritesStoreTypes)
local _AgeRecommendationStoreTypes = require(script.AgeRecommendations.AgeRecommendationStoreTypes)
local AgeRecommendationUtils = require(script.AgeRecommendations.AgeRecommendationUtils)
local _GameInfoStoreTypes = require(script.GameInfo.GameInfoStoreTypes)
local _GameIconStoreTypes = require(script.GameIcon.GameIconStoreTypes)
local _PlayabilityStoreTypes = require(script.Playability.PlayabilityStoreTypes)
local _GameMediaStoreTypes = require(script.GameMedia.GameMediaStoreTypes)
local _UserVoteFeedbackMetadataStoreTypes = require(script.Votes.UserVoteFeedbackMetadataStoreTypes)
local _GamePassStoreTypes = require(script.GamePass.GamePassStoreTypes)
local _GameDeveloperProductStoreTypes = require(script.GameDeveloperProduct.GameDeveloperProductStoreTypes)
local _GameSubscriptionStoreTypes = require(script.GameSubscription.GameSubscriptionStoreTypes)

local FFlagLuaAppDataHydrationConnectionsPlayedStore = require(DataHydrationParent.SharedFlags).FFlagLuaAppDataHydrationConnectionsPlayedStore

local tbl1 = {
    createGamePassStore = createGamePassStore,
    getGamePassStore = getGamePassStore,
    createGameDeveloperProductStore = createGameDeveloperProductStore,
    getGameDeveloperProductStore = getGameDeveloperProductStore,
    createGameSubscriptionStore = createGameSubscriptionStore,
    getGameSubscriptionStore = getGameSubscriptionStore,
    createFavoritesStore = createFavoritesStore,
    createAgeRecommendationStore = createAgeRecommendationStore,
    createFollowingsStore = createFollowingsStore,
    createGameInfoStore = createGameInfoStore,
    createPlayabilityStore = createPlayabilityStore,
    createVotesStore = createVotesStore,
    createUserVoteFeedbackMetadataStore = createUserVoteFeedbackMetadataStore,
    createConnectionsPlayedStore = 0,
    getFavoritesStore = 0,
    getAgeRecommendationStore = 0,
    getFollowingsStore = 0,
    getGameInfoStore = 0,
    getPlayabilityStore = 0,
    getVotesStore = 0,
    getUserVoteFeedbackMetadataStore = 0,
    VotesUtils = 0,
    AgeRecommendationUtils = 0,
    getConnectionsPlayedStore = 0,
    createGameMediaStore = 0,
    getGameMediaStore = 0,
    createGameIconStore = 0,
    getGameIconStore = 0,
    GameIconSize = 0
}

if not FFlagLuaAppDataHydrationConnectionsPlayedStore then
    createConnectionsPlayedStore = nil
end

tbl1.createConnectionsPlayedStore = createConnectionsPlayedStore

tbl1.getFavoritesStore = getFavoritesStore
tbl1.getAgeRecommendationStore = getAgeRecommendationStore
tbl1.getFollowingsStore = getFollowingsStore
tbl1.getGameInfoStore = getGameInfoStore
tbl1.getPlayabilityStore = getPlayabilityStore
tbl1.getVotesStore = getVotesStore
tbl1.getUserVoteFeedbackMetadataStore = getUserVoteFeedbackMetadataStore
tbl1.VotesUtils = VotesUtils
tbl1.AgeRecommendationUtils = AgeRecommendationUtils
if not FFlagLuaAppDataHydrationConnectionsPlayedStore then
    getConnectionsPlayedStore = nil
end

tbl1.getConnectionsPlayedStore = getConnectionsPlayedStore

tbl1.createGameMediaStore = createGameMediaStore
tbl1.getGameMediaStore = getGameMediaStore
tbl1.createGameIconStore = createGameIconStore
tbl1.getGameIconStore = getGameIconStore
tbl1.GameIconSize = GameIconSize
return tbl1
