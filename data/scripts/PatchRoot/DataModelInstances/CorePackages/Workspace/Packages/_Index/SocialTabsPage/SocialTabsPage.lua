-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Constants = require(script.Common.Constants)

return {
    ["jest.config"] = script["jest.config"],
    RoduxKey = Constants.RODUX_KEY,
    installReducer = require(script.Rodux.installReducer),
    SocialTabsPage = require(script.Components.SocialTabsPage),
    SocialTabsPageNavigator = require(script.Navigation.SocialTabsPageNavigator),
    SocialTabsContext = require(script.Contexts.SocialTabsContext),
    useSocialTabsContext = require(script.Contexts.useSocialTabsContext)
}
