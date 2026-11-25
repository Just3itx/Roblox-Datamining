-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _FocusNavHelper = require(script.Common.FocusNavHelper)
local usePlayerListFocusNavigation = require(script.Hooks.usePlayerListFocusNavigation)

local FFlagPlayerListUseFocusNavHook = require(script.Flags.FFlagPlayerListUseFocusNavHook)

local PlayerContextualMenuStore = require(script.Common.PlayerContextualMenuStore)
local PlayerListContextMenuTelemetryAction = require(script.Common.PlayerListContextMenuTelemetryAction)

local tbl1 = {
    ["jest.config"] = script["jest.config"],
    LeaderboardStoreInstanceManager = require(script.Common.LeaderboardStoreInstanceManager),
    LeaderboardStoreContext = require(script.Common.LeaderboardStoreContext),
    PlayerListVisibilityStore = require(script.Common.PlayerListVisibilityStore),
    PlayerRelationshipStore = require(script.Common.PlayerRelationshipStore),
    Flags = {
        FFlagAddNewPlayerListFocusNav = require(script.Flags.FFlagAddNewPlayerListFocusNav),
        FFlagAddNewPlayerListMobileFocusNav = require(script.Flags.FFlagAddNewPlayerListMobileFocusNav),
        FFlagRemoveNewPlayerListOverlay = require(script.Flags.FFlagRemoveNewPlayerListOverlay),
        FFlagEnableMobilePlayerListOnConsole = require(script.Flags.FFlagEnableMobilePlayerListOnConsole),
        FFlagEnableMobilePlayerListOnGamepad = require(script.Flags.FFlagEnableMobilePlayerListOnGamepad),
        FFlagPlayerListUseMobileOnSmallDisplay = require(script.Flags.FFlagPlayerListUseMobileOnSmallDisplay),
        FFlagPlayerListIgnoreDevGamepadBindings = require(script.Flags.FFlagPlayerListIgnoreDevGamepadBindings),
        FFlagPlayerListUseFocusNavHook = FFlagPlayerListUseFocusNavHook,
        FFlagPlayerListDropDownShowPlatformName = require(script.Flags.FFlagPlayerListDropDownShowPlatformName),
        FFlagPlayerListFoundationSubscriptionIcon = require(script.Flags.FFlagPlayerListFoundationSubscriptionIcon),
        FFlagPlayerListFixPlatformLeaderboardSizing = require(script.Flags.FFlagPlayerListFixPlatformLeaderboardSizing),
        FFlagPlayerListReskin = require(script.Flags.FFlagPlayerListReskin),
        FFlagPlayerListTwoTabsOnLegacy = require(script.Flags.FFlagPlayerListTwoTabsOnLegacy),
        FFlagPlayerListLocalizeGameText = require(script.Flags.FFlagPlayerListLocalizeGameText),
        FFlagPlayerListContrastingTeamText = require(script.Flags.FFlagPlayerListContrastingTeamText),
        FFlagEnablePlayerListExposureEvents = require(script.Flags.FFlagEnablePlayerListExposureEvents),
        FStringPlayerListIXPLayer = require(script.Flags.FStringPlayerListIXPLayer)
    }
}
local Hooks = {
    useLeaderboardStore = require(script.Hooks.useLeaderboardStore),
    useLegacyVisibilityMirror = require(script.Hooks.useLegacyVisibilityMirror),
    usePlayerListFocusNavigation = 0,
    usePlatformLeaderboard = 0
}

if not FFlagPlayerListUseFocusNavHook then
    usePlayerListFocusNavigation = nil
end

Hooks.usePlayerListFocusNavigation = usePlayerListFocusNavigation

Hooks.usePlatformLeaderboard = require(script.Hooks.usePlatformLeaderboard)
tbl1.Hooks = Hooks

tbl1.Common = {
    LayoutValuesContext = require(script.Common.LayoutValuesContext),
    CreateLayoutValues = require(script.Common.CreateLayoutValues),
    useLayoutValues = require(script.Common.useLayoutValues),
    isReskinConsoleMobileRoute = require(script.Common.isReskinConsoleMobileRoute),
    useSignalMapState = require(script.Common.useSignalMapState),
    FormatStatString = require(script.Common.FormatStatString),
    Constants = require(script.Common.Constants),
    PlayerListVisibilityStore = require(script.Common.PlayerListVisibilityStore),
    computeStatColumns = require(script.Common.computeStatColumns),
    PlatformLeaderboardStoreContext = require(script.Common.PlatformLeaderboardStoreContext),
    GameTextTranslatorContext = require(script.Common.GameTextTranslatorContext),
    getContrastingContentStyle = require(script.Common.getContrastingContentStyle)
}

tbl1.Container = {
    PlayerListContainer = require(script.Components.Containers.PlayerListContainer),
    PlatformLeaderboardContainer = require(script.Components.Containers.PlatformLeaderboardContainer)
}

tbl1.PlayerContextualMenuStore = PlayerContextualMenuStore
tbl1.PlayerListContextMenuTelemetryAction = PlayerListContextMenuTelemetryAction

tbl1.builderIcon = require(script.Common.builderIcon)
tbl1.resolveDisplayName = require(script.Common.resolveDisplayName)
tbl1.getHeadshotThumbnail = require(script.Common.getHeadshotThumbnail)

tbl1.Presentation = {
    EntryFrameView = require(script.Components.Presentation.EntryFrameView),
    StatEntryView = require(script.Components.Presentation.StatEntryView),
    PlayerListPanel = require(script.Components.Presentation.PlayerListPanel),
    PlayerContextualMenuView = require(script.Components.Presentation.PlayerContextualMenuView),
    LeaderboardScrim = require(script.Components.Presentation.LeaderboardScrim),
    LeaderboardTabs = require(script.Components.Presentation.LeaderboardTabs),
    LeaderboardTabsBody = require(script.Components.Presentation.LeaderboardTabsBody),
    LegacyTwoTabsBody = require(script.Components.Presentation.LegacyTwoTabsBody),
    EmptyAndErrorStates = require(script.Components.Presentation.EmptyAndErrorStates),
    PlatformLeaderboardView = require(script.Components.Presentation.PlatformLeaderboardView),
    PlatformEntryView = require(script.Components.Presentation.PlatformEntryView),
    TabbedLeaderboardBody = require(script.Components.Presentation.TabbedLeaderboardBody)
}
return tbl1
