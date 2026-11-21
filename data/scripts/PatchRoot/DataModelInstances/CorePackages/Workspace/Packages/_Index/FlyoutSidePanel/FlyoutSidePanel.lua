-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local createLazyComponent = require(scriptParent.RoactUtils).Components.createLazyComponent
local SharedFlags = require(scriptParent.SharedFlags)
local FFlagEnableHomeRobloxLogo = SharedFlags.FFlagEnableHomeRobloxLogo
local FFlagEnableFlyoutOnNavRail = SharedFlags.FFlagEnableFlyoutOnNavRail
local FFlagEnableFlyoutNavRailBumperNavigation = SharedFlags.FFlagEnableFlyoutNavRailBumperNavigation
local FFlagFlyoutUseOpenHook = SharedFlags.FFlagFlyoutUseOpenHook
local FFlagSendLogOutClickTelemetry = SharedFlags.FFlagSendLogOutClickTelemetry
local FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled = SharedFlags.FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled

return {
    Components = {
        FlyoutSidePanelComponent = createLazyComponent(function()
            return require(script.Components.FlyoutSidePanelComponent)
        end),
        FlyoutProfileCard = createLazyComponent(function()
            return require(script.Components.FlyoutProfileCard)
        end),
        FlyoutLeftHeader = require(script.Components.FlyoutLeftHeader),
        FlyoutStatusListener = if FFlagEnableHomeRobloxLogo then nil else require(script.Components.FlyoutStatusListener),
        FlyoutHamburgerButton = if FFlagEnableFlyoutOnNavRail then require(script.Components.FlyoutHamburgerButton) else nil
    },
    Utils = {
        shouldShowLeftHeader = require(script.Utils.shouldShowLeftHeader),
        sendMoreLegacyAndFlyoutItemClickEvent = if FFlagSendLogOutClickTelemetry then require(script.Analytics.FlyoutAnalytics).sendMoreLegacyAndFlyoutItemClickEvent else nil,
        logCTAChangeMorePageFlyoutButtonTextExposure = if FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled then require(script.Utils.logCTAChangeMorePageFlyoutButtonTextExposure) else nil
    },
    Hooks = {
        useOpenFlyoutSidePanel = if FFlagEnableFlyoutNavRailBumperNavigation or FFlagFlyoutUseOpenHook then require(script.Hooks.useOpenFlyoutSidePanel) else nil
    },
    FlyoutScrollAwayControl = require(script.FlyoutScrollAwayControl),
    ["jest.config"] = script["jest.config"]
}
