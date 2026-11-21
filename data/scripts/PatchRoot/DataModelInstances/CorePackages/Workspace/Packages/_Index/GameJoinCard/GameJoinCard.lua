-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsConstants = require(script.Analytics.AnalyticsConstants)
local MobileGameJoinCard = require(script.Components.MobileGameJoinCard.MobileGameJoinCard)
local FFlagSocialCarouselBuildPresence = require(script.Parent.SharedFlags).FFlagSocialCarouselBuildPresence

local module = {
    Analytics = {
        AnalyticsConstants = AnalyticsConstants,
        Constants = AnalyticsConstants,
        useGameJoinCardAnalytics = require(script.Analytics.useGameJoinCardAnalytics),
        useAgeCheckUpsellAnalytics = require(script.Analytics.useAgeCheckUpsellAnalytics)
    },
    BuildJoinCardPopover = if FFlagSocialCarouselBuildPresence then require(script.Components.BuildJoinCard.BuildJoinCardPopoverContainer) else nil,
    BuildJoinCardSheet = if FFlagSocialCarouselBuildPresence then require(script.Components.BuildJoinCard.BuildJoinCardSheetContainer) else nil,
    DesktopGameJoinCard = require(script.Components.DesktopGameJoinCard.DesktopGameJoinCard),
    DesktopGameJoinCardContainer = require(script.Components.DesktopGameJoinCard.DesktopGameJoinCardContainer),
    GamepadJoinFocusBehavior = require(script.Components.DesktopGameJoinCard.GamepadJoinFocusBehavior)
}
function module.getInExperienceGameJoinCard()
    return require(script.Components.InExperienceGameJoinCard.InExperienceGameJoinCard)
end
module.useGameJoinCardNavigation = require(script.Components.DesktopGameJoinCard.useGameJoinCardNavigation)
module.useJoinUserActions = require(script.Hooks.useJoinUserActions)
module.usePrefetchInGameFriendsMedia = require(script.Hooks.usePrefetchInGameFriendsMedia)
module.MobileGameJoinCard = require(script.Components.MobileGameJoinCard)
module.MobileGameJoinCardView = MobileGameJoinCard
module.Telemetry = {
    GameJoinCardTelemetry = require(script.Telemetry.GameJoinCardTelemetry),
    GameJoinCardTTI = require(script.Telemetry.GameJoinCardTTI)
}
module["jest.config"] = script["jest.config"]
return module
