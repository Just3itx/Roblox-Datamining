-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Enums = require(ProfilePlatform.Common.Enums)
local _CurrencyTransfers = require(ProfilePlatformParent.CurrencyTransfers)
local FFlagProfilePlatformEnableStore = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableStore
local FFlagAddSocialLinksToCommunityProfile = require(ProfilePlatformParent.SharedFlags).FFlagAddSocialLinksToCommunityProfile

local FFlagEnablePlatformProfileContextualMenuOption = require(ProfilePlatformParent.SharedFlags).FFlagEnablePlatformProfileContextualMenuOption
local FFlagAddIEMProfilePage = require(ProfilePlatformParent.SharedFlags).FFlagAddIEMProfilePage

local FFlagProfilePlatformEnableEditAppearanceMenu = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)

local FFlagProfilePlatformEditBackgroundMenuItem = require(ProfilePlatform.Flags.FFlagProfilePlatformEditBackgroundMenuItem)

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer

local createContext = React.createContext
local tbl1 = {
    profileId = "TEST_ID",
    profilePlatformId = if FFlagEnablePlatformProfileContextualMenuOption then "TEST_PLATFORM_ID" else nil,
    profileType = Enums.ProfileTypes.User,
    navigateTo = 0,
    externalAnalytics = 0,
    sourceInfo = 0
}
local navigateTo = {
    qRCodePage = function() end,
    previousView = function() end,
    itemDetails = function() end,
    itemOrBundleDetails = FFlagProfilePlatformEnableStore and function() end or nil,
    preparePurchaseItem = function() end,
    shopForMoreEmotes = function() end,
    promptR15Upgrade = function() end,
    catalogSearch = FFlagProfilePlatformEnableStore and function() end or nil,
    inspectAvatar = FFlagAddIEMProfilePage and function() end or nil,
    editEmotes = FFlagProfilePlatformEnableEditAppearanceMenu and function() end or nil,
    switchAvatar = FFlagProfilePlatformEnableEditAppearanceMenu and function() end or nil,
    editBackground = if FFlagProfilePlatformEnableEditAppearanceMenu then FFlagProfilePlatformEditBackgroundMenuItem and function() end or nil else nil,
    editAvatar = 0,
    editUsername = 0,
    openLeaveRobloxAlertUIBlox = 0,
    closeLeaveRobloxAlert = 0,
    navigateToTransfer = 0
}

function navigateTo.editAvatar() end

function navigateTo.editUsername() end
navigateTo.openLeaveRobloxAlertUIBlox = FFlagAddSocialLinksToCommunityProfile and function() end or nil
navigateTo.closeLeaveRobloxAlert = FFlagAddSocialLinksToCommunityProfile and function() end or nil
navigateTo.navigateToTransfer = FFlagProfilePlatformEnableCurrencyTransfer and function() end or nil
tbl1.navigateTo = navigateTo

tbl1.externalAnalytics = {
    catalogAnalytics = {}
}
tbl1.sourceInfo = {
    isRecommendation = false,
    source = "TEST_SOURCE",
    contextualInfoType = "TEST_CONTEXTUAL_INFO_TYPE",
    contextualOverride = {},
    friendshipOriginSourceType = "TEST_FRIENDSHIP_ORIGIN_SOURCE_TYPE"
}
return createContext(tbl1)
