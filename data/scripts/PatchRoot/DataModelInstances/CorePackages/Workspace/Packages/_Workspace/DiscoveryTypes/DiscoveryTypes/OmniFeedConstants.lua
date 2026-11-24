-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DiscoveryTypesParent = script:FindFirstAncestor("DiscoveryTypes").Parent

local FFlagLuaAppHeaderButtonText = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppHeaderButtonText
local FFlagLuaAppRfySignalApportioningIxp = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppRfySignalApportioningIxp
local FFlagLuaAppEnableReportExperience = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppEnableReportExperience

local FFlagLuaAppUsePrevalidatedVideoGamePlayability = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppUsePrevalidatedVideoGamePlayability
local FFlagLuaAppRfyRevealRows = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppRfyRevealRows
local FFlagLuaAppSortHeaderAnchorTag = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppSortHeaderAnchorTag
local FFlagLuaAppContinueSortInstantPlay = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppSupportHomeBackToTop = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppSupportHomeBackToTop

local _RoduxTypes = require(script.Parent.RoduxTypes)

return {
    EventContext = "HomeOmniFeed",
    OmniSortRetrievalStatus = { Exception = "Exception", Success = "Success" },
    GlobalLayoutDataKeys = {
        JYFRefresh = "JYFRefresh",
        ShowBackToTop = if FFlagLuaAppSupportHomeBackToTop then "showBackToTop" else nil
    },
    TopicLayoutDataKeys = {
        PYMKFindFriendsEnabled = "PYMKFindFriendsEnabled",
        PYMKSeeAllEnabled = "PYMKSeeAllEnabled",
        JYFFindFriendsEnabled = "JYFFindFriendsEnabled",
        ComponentType = "componentType",
        PlayerCountStyle = "playerCountStyle",
        IsSponsoredFooterAllowed = "isSponsoredFooterAllowed",
        LinkPath = "linkPath",
        SubtitleLinkPath = "subtitleLinkPath",
        HideSeeAll = "hideSeeAll",
        InfoText = "infoText",
        EndTimestamp = "endTimestamp",
        CountdownString = "countdownString",
        PlayButtonStyle = "playButtonStyle",
        BackgroundImageAssetId = "backgroundImageAssetId",
        HeaderButtonText = if FFlagLuaAppHeaderButtonText then "headerButtonText" else nil,
        HideTileMetadata = "hideTileMetadata",
        HideTileTitle = "hideTileTitle",
        ContainedTile = "containedTile",
        HasPrevalidatedVideoGamePlayability = if FFlagLuaAppUsePrevalidatedVideoGamePlayability then "hasPrevalidatedVideoGamePlayability" else nil,
        EnableExplicitFeedback = "enableExplicitFeedback",
        EnableSignalApportioning = if FFlagLuaAppRfySignalApportioningIxp then "enableSignalApportioning" else nil,
        SponsoredUserCohort = "sponsoredUserCohort",
        EnableSponsoredFeedback = "enableSponsoredFeedback",
        EnableCollectionGrid = "enableCollectionGrid",
        SortHeaderAnchorTag = if FFlagLuaAppSortHeaderAnchorTag then "sortHeaderAnchorTag" else nil,
        InitialFeedVisibleRows = if FFlagLuaAppRfyRevealRows then "initialFeedVisibleRows" else nil,
        VisibleRowsPerReveal = if FFlagLuaAppRfyRevealRows then "visibleRowsPerReveal" else nil,
        EnableReportAd = "enableReportAd",
        EnableReportExperience = if FFlagLuaAppEnableReportExperience then "enableReportExperience" else nil,
        IsSponsoredRatingFooterAllowed = "isSponsoredRatingFooterAllowed",
        AmpUpsellFeatureName = "ampUpsellFeatureName",
        AmpUpsellNamespace = "ampUpsellNamespace",
        EnableInstantPlay = if FFlagLuaAppContinueSortInstantPlay then "enableInstantPlay" else nil,
        InstantPlayTreatment = if FFlagLuaAppContinueSortInstantPlay then "instantPlayTreatment" else nil
    },
    ComponentTypeDataKeys = {
        EventTile = "EventTile",
        GridTile = "GridTile",
        AppGameTileNoMetadata = "AppGameTileNoMetadata"
    },
    ItemLayoutDataKeys = { Footer = "Footer" },
    OmniRecommendationsRequestIntent = {
        ManualRefresh = "manualRefresh",
        AutoRefresh = "autoRefresh",
        FriendPresenceChange = "friendPresenceChange",
        LogIn = "logIn",
        LoadMore = "loadMore",
        GameExit = "gameExit",
        AmpUpsellFeatureGranted = "ampUpsellFeatureGranted",
        OptionSelector = "optionSelector"
    },
    ContentGroupType = { Game = "Game", Text = "Text", User = "User" },
    OmniFeedPageSection = { Header = "Header" }
}
