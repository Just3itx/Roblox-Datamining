-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local NavigationRoduxParent = script:FindFirstAncestor("NavigationRodux").Parent

return {
    TempRnSwitchNavigatorName = "RootSwitchNavigator",
    HomeContainerName = if require(NavigationRoduxParent.SharedFlags).FFlagAppIaHomeSubTab then "HomeContainer" else nil
}
