-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent

local SharedFlags = require(FocusNavigationUtilsParent.SharedFlags)
return {
    ModerationOverlay = "ModerationOverlay",
    CentralOverlay = "CentralOverlay",
    NavBar = "NavBar",
    RouterView = "RouterView",
    SubRouterView = "SubRouterView",
    SearchBar = "SearchBar",
    ContextualMenu = "ContextualMenu",
    PopUp = "PopUp",
    PeekView = "PeekView",
    Auxiliary = "Auxiliary",
    HeaderView = if SharedFlags.FFlagAppIaHomeSubTab then "HeaderView" else nil,
    Drawer = if SharedFlags.FFlagEnableDrawerFocusNav then "Drawer" else nil
}
