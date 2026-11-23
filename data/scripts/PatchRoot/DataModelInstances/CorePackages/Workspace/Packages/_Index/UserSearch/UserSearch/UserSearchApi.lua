-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ["jest.config"] = script.Parent["jest.config"],
    UserSearchTile = require(script.Parent.Components.UserSearchTile),
    UserSearchScreen = require(script.Parent.Components.UserSearchScreen),
    UserSearchHydrationLayer = require(script.Parent.Components.UserSearchHydrationLayer),
    ProfileInsightsContextFetchWrapper = require(script.Parent.Components.ProfileInsightsContextFetchWrapper),
    Analytics = require(script.Parent.Analytics),
    installReducer = require(script.Parent.Rodux.installReducer),
    RoduxKey = require(script.Parent.Common.Constants).RODUX_KEY
}
