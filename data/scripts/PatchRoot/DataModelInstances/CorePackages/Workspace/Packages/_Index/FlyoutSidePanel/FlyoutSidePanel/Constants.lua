-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent

local FlyoutSidePanelIXP = require(FlyoutSidePanelParent.SharedExperimentDefinition).FlyoutSidePanelIXP

local FFlagEnableChartsInFlyout = require(FlyoutSidePanelParent.SharedFlags).FFlagEnableChartsInFlyout
local FFlagUserLibrary = require(FlyoutSidePanelParent.SharedFlags).FFlagUserLibrary
local FFlagFlyoutAddAdjustScreen = require(script.Parent.Flags.FFlagFlyoutAddAdjustScreen)

return {
    FLYOUT_SIDE_PANEL_WIDTH = 351,
    FLYOUT_SIDE_PADDING = 42,
    FAVORITES_URI = "roblox://navigation/experience_sort?sortId=Favorites",
    CONTINUE_PLAYING_URI = "roblox://navigation/experience_sort?sortId=Continue",
    SORT_ID_FAVORITES = "100000001",
    SORT_ID_CONTINUE_PLAYING = "100000003",
    ROBLOX_LOGO_ASPECT_RATIO = 47 / 9,
    MAX_SHOWN_STATUS_INDICATOR_COUNT = 99,
    FLYOUT_DEFAULT_POLICY = {
        MyLibrary = {
            if FFlagUserLibrary then "UserLibrary" else nil,
            "Favorites",
            "ContinuePlaying",
            if FFlagEnableChartsInFlyout and FlyoutSidePanelIXP.isChartsInFlyoutEnabled() then "Charts" else nil,
            "Connections",
            "Communities",
            "Inventory",
            "Trades",
            "Messages",
            "Blackbird",
            "Premium",
            "GiftCards",
            "Redeem",
            "Settings",
            if FFlagFlyoutAddAdjustScreen then "AdjustScreen" else nil,
            "HelpAndSafety"
        },
        AdditionalNavigation = {
            "Events",
            "Moments",
            "Learn",
            "CreateGames"
        }
    }
}
