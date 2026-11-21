-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameLaunchParent = script:FindFirstAncestor("GameLaunch").Parent
local RetrievalStatus = require(GameLaunchParent.Http).Enum.RetrievalStatus
local PlayabilityStatusEnum = require(GameLaunchParent.DiscoveryTypes).PlayabilityStatusEnum

local FFlagLuaAppBlockedUnplayableError = require(GameLaunchParent.SharedFlags).FFlagLuaAppBlockedUnplayableError

local tbl1 = {}

local tbl2 = {
    [RetrievalStatus.Failed] = "Feature.GamePage.QuickLaunch.LaunchError.RequestFailed",
    [PlayabilityStatusEnum.GuestProhibited] = "Feature.GamePage.QuickLaunch.LaunchError.GuestProhibited",
    [PlayabilityStatusEnum.GameUnapproved] = "Feature.ExperienceDetails.UnplayableError.GameUnapproved",
    [PlayabilityStatusEnum.UniverseRootPlaceIsPrivate] = "Feature.ExperienceDetails.UnplayableError.UniverseRootPlaceIsPrivate",
    [PlayabilityStatusEnum.InsufficientPermissionFriendsOnly] = "Feature.ExperienceDetails.UnplayableError.InsufficientPermissionFriendsOnly",
    [PlayabilityStatusEnum.InsufficientPermissionGroupOnly] = "Feature.ExperienceDetails.UnplayableError.InsufficientPermissionGroupOnly",
    [PlayabilityStatusEnum.DeviceRestricted] = "Feature.ExperienceDetails.UnplayableError.DeviceRestrictedDefault",
    [PlayabilityStatusEnum.UnderReview] = "Feature.ExperienceDetails.UnplayableError.UnderReview",
    [PlayabilityStatusEnum.PurchaseRequired] = "Feature.GamePage.QuickLaunch.LaunchError.PurchaseRequired",
    [PlayabilityStatusEnum.AccountRestricted] = "Feature.ExperienceDetails.UnplayableError.AccountRestricted",
    [PlayabilityStatusEnum.TemporarilyUnavailable] = "Feature.ExperienceDetails.UnplayableError.TemporarilyUnavailable",
    [PlayabilityStatusEnum.ComplianceBlocked] = "Feature.ExperienceDetails.UnplayableError.ComplianceBlocked",
    [PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls] = "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityAgeRecommendationParentalControls",
    [PlayabilityStatusEnum.ContextualPlayabilityRegionalAvailability] = "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityRegionalAvailability",
    [PlayabilityStatusEnum.ContextualPlayabilityRegionalCompliance] = "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityRegionalCompliance",
    [PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser] = "Feature.GamePage.QuickLaunch.LaunchError.ContextualPlayabilityUnverifiedSeventeenPlusUser",
    [PlayabilityStatusEnum.PlaceHasNoPublishedVersion] = "Feature.ExperienceDetails.UnplayableError.PlaceHasNoPublishedVersion",
    [PlayabilityStatusEnum.IncorrectConfiguration] = "Feature.ExperienceDetails.UnplayableError.IncorrectConfiguration",
    [PlayabilityStatusEnum.ContextualPlayabilityAgeGated] = "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityAgeGated",
    [PlayabilityStatusEnum.ContextualPlayabilityUnrated] = "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityUnrated",
    [PlayabilityStatusEnum.ContextualPlayabilityAgeGatedByDescriptor] = "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityAgeGatedByDescriptor",
    [PlayabilityStatusEnum.FiatPurchaseDeviceRestricted] = "Feature.ExperienceDetails.UnplayableError.FiatPurchaseDeviceRestricted",
    [PlayabilityStatusEnum.ContextualPlayabilityExperienceBlockedParentalControls] = if FFlagLuaAppBlockedUnplayableError then "Feature.ExperienceDetails.UnplayableError.ContextualPlayabilityExperienceBlockedParentalControls" else nil,
    Default = "Feature.ExperienceDetails.UnplayableError.UnplayableOther"
}

setmetatable(tbl1, {
    __newindex = function(_, _, _) end,
    __index = function(_, arg1)
        assert(arg1 ~= nil, "LaunchErrorLocalizationKeys needs a key")
        return tbl2[arg1] or tbl2.Default
    end
})

return tbl1
