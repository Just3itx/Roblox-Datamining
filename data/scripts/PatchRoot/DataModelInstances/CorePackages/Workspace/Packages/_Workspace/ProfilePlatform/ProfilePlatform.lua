-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ProfileWrapperContext = require(script.Contexts.ProfileWrapperContext)
local Enums = require(script.Common.Enums)
local Types = require(script.Common.Types)
local getProfilePlatform = require(script.Networking.getProfilePlatform)
local refreshProfilePlatformActionInfo = require(script.Networking.refreshProfilePlatformActionInfo)
local SharedFlags = require(script.Parent.SharedFlags)
local FFlagMoveInExperienceModeToEditProfile = SharedFlags.FFlagMoveInExperienceModeToEditProfile
local FFlagAddIEMProfilePage = SharedFlags.FFlagAddIEMProfilePage
local FFlagTCUpdateProfileCTAButton = SharedFlags.FFlagTCUpdateProfileCTAButton
local FFlagEnableRecentActivityInspectAndBuy = SharedFlags.FFlagEnableRecentActivityInspectAndBuy
local FFlagProfilePlatformEnableMoments = require(script.Flags.FFlagProfilePlatformEnableMoments)

local tbl1 = {
    ["jest.config"] = script["jest.config"],
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    installReducer = require(script.Rodux.installReducer),
    EnableCommunityProfilePageIXP = require(script.Flags.EnableCommunityProfilePageIXP),
    EventNames = require(script.Analytics.EventNames),
    LoadingStagesExtension = require(script.Analytics.LoadingStagesExtension),
    initializeProfileAnalytics = require(script.Analytics.initializeProfileAnalytics),
    ProfilePlatformNavigator = require(script.Navigation.ProfilePlatformNavigatorWithProviders),
    ProfileWrapperContext = ProfileWrapperContext,
    ProfileTypes = Enums.ProfileTypes,
    Components = Enums.Components,
    CurrentlyWearing = if FFlagAddIEMProfilePage then require(script.Components.CurrentlyWearing) else nil,
    UserLists = require(script.Components.UserProfileHeader.SocialChipCountsRow.UserLists),
    AvatarHeadshotComponent = if FFlagAddIEMProfilePage then require(script.Components.UserProfileHeader.AvatarHeadshotComponent) else nil,
    SocialChipCountsRow = if FFlagAddIEMProfilePage then require(script.Components.UserProfileHeader.SocialChipCountsRow).SocialChipCountsRowContainer else nil,
    AboutDetailsSheet = require(script.Components.AboutDetailsSheet),
    RecentActivityInspectAndBuy = if FFlagEnableRecentActivityInspectAndBuy then require(script.Components.RecentActivityInspectAndBuy.RecentActivityInspectAndBuyContainer) else nil,
    MomentsFeedPage = if FFlagProfilePlatformEnableMoments then require(script.Components.Moments.MomentsFeedPage) else nil,
    useDynamicSizeMargin = if FFlagAddIEMProfilePage then require(script.Hooks.useDynamicSizeMargin) else nil,
    useProfileJsonComponent = if FFlagAddIEMProfilePage then require(script.Hooks.useProfileJsonComponent) else nil,
    Screens = Enums.Screens,
    Sources = Enums.Sources,
    DisabledReasons = Enums.DisabledReasons,
    ProfileActions = Enums.ProfileActions
}

if not (FFlagMoveInExperienceModeToEditProfile or FFlagAddIEMProfilePage) then
    getProfilePlatform = nil
end

tbl1.getProfilePlatform = getProfilePlatform

if not FFlagTCUpdateProfileCTAButton then
    refreshProfilePlatformActionInfo = nil
end

tbl1.refreshProfilePlatformActionInfo = refreshProfilePlatformActionInfo

if not FFlagMoveInExperienceModeToEditProfile then
    Types = nil
end

tbl1.ProfilePlatformTypes = Types
tbl1.FFlagProfilePlatformEnableEditAppearanceMenu = require(script.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)
tbl1.FFlagProfilePlatformEditBackgroundMenuItem = require(script.Flags.FFlagProfilePlatformEditBackgroundMenuItem)
tbl1.FFlagProfilePlatformEnableMoments = require(script.Flags.FFlagProfilePlatformEnableMoments)
tbl1.FFlagProfilePlatformGracefulVisibility = require(script.Flags.FFlagProfilePlatformGracefulVisibility)
return tbl1
