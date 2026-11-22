-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")

return {
    NavigateBack = require(NavigationRodux.Thunks.NavigateBack),
    NavigateDown = require(NavigationRodux.Thunks.NavigateDown),
    NavigateSideways = require(NavigationRodux.Thunks.NavigateSideways),
    NavigateToRoute = require(NavigationRodux.Thunks.NavigateToRoute),
    NavigateFromWebView = require(NavigationRodux.Thunks.NavigateFromWebView),
    RNAdapterThunk = require(NavigationRodux.Thunks.RNAdapterThunk),
    SetNavigationLocked = require(NavigationRodux.Thunks.SetNavigationLocked),
    NavigateDownToGroups = require(NavigationRodux.Thunks.NavigateDownToGroups),
    NavigateDownToNotifications = require(NavigationRodux.Thunks.NavigateDownToNotifications),
    NavigateDownToPrivacySettings = require(NavigationRodux.Thunks.NavigateDownToPrivacySettings),
    NavigateDownToNotificationSettings = require(NavigationRodux.Thunks.NavigateDownToNotificationSettings),
    NavigateDownToReportAbuse = require(NavigationRodux.Thunks.NavigateDownToReportAbuse),
    NavigateDownToViewUserProfile = require(NavigationRodux.Thunks.NavigateDownToViewUserProfile)
}
