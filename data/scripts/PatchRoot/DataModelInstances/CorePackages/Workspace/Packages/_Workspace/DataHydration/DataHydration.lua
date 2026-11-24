-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DataHydrationTypes = require(script.DataHydrationTypes)
local Badges = require(script.Badges)
local Game = require(script.Game)
local TrustedConnections = require(script.TrustedConnections)
local Profile = require(script.Profile)
local Presence = require(script.Presence)
local Friends = require(script.Friends)
local Creator = require(script.Creator)
local SocialLink = require(script.SocialLink)
local ExperienceEvents = require(script.ExperienceEvents)
local MediaAsset = require(script.MediaAsset)
local MarketplaceCatalogCategory = require(script.MarketplaceCatalogCategory)
local MarketplaceCatalogSort = require(script.MarketplaceCatalogSort)
local MarketplaceAsset = require(script.MarketplaceAsset)
local MarketplaceBundle = require(script.MarketplaceBundle)
local MarketplaceLook = require(script.MarketplaceLook)
local MarketplaceItemFavorite = require(script.MarketplaceItemFavorite)
local CollectibleItem = require(script.CollectibleItem)
local Song = require(script.Song)
local UserSettings = require(script.UserSettings)

local DataHydrationUtils = require(script.DataHydrationUtils)

local SharedFlags = require(script.Parent.SharedFlags)
local FFlagSduiNotificationBadgeHydration = SharedFlags.FFlagSduiNotificationBadgeHydration
local FFlagSduiLeaderboardComponent = SharedFlags.FFlagSduiLeaderboardComponent
local FFlagSduiBuyRobuxHydration = SharedFlags.FFlagSduiBuyRobuxHydration

local UserProfile = require(script.UserProfile)
local Community = require(script.Community)
local CommunityUserMembership = require(script.CommunityUserMembership)
local NotificationBadge = require(script.NotificationBadge)
local LeaderboardStats = require(script.LeaderboardStats)
local BuyRobux = require(script.BuyRobux)

local tbl1 = {
    ["jest.config"] = script["jest.config"],
    createDataResolver = require(script.createDataResolver),
    createDataCache = require(script.createDataCache),
    createMutationLayer = require(script.createMutationLayer),
    DataHydrationTypes = DataHydrationTypes,
    DataHydrationUtils = DataHydrationUtils,
    DataStatus = DataHydrationTypes.DataStatus,
    Badges = Badges,
    Game = Game,
    Creator = Creator,
    MediaAsset = MediaAsset,
    MarketplaceCatalogCategory = MarketplaceCatalogCategory,
    MarketplaceCatalogSort = MarketplaceCatalogSort,
    SocialLink = SocialLink,
    ExperienceEvents = ExperienceEvents,
    TrustedConnections = TrustedConnections,
    Profile = Profile,
    Presence = Presence,
    Friends = Friends,
    MarketplaceAsset = MarketplaceAsset,
    MarketplaceBundle = MarketplaceBundle,
    MarketplaceLook = MarketplaceLook,
    MarketplaceItemFavorite = MarketplaceItemFavorite,
    CollectibleItem = CollectibleItem,
    Song = Song,
    UserSettings = UserSettings,
    UserProfile = UserProfile,
    Community = Community,
    CommunityUserMembership = CommunityUserMembership
}

if not FFlagSduiNotificationBadgeHydration then
    NotificationBadge = nil
end

tbl1.NotificationBadge = NotificationBadge
if not FFlagSduiLeaderboardComponent then
    LeaderboardStats = nil
end

tbl1.LeaderboardStats = LeaderboardStats
if not FFlagSduiBuyRobuxHydration then
    BuyRobux = nil
end

tbl1.BuyRobux = BuyRobux
return tbl1
