-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local SetAliasAnalyticsContext = require(script.SetAliasAnalyticsContext)
local Context = require(scriptParent.dependencies).SocialLibraries.Context

return {
    AnalyticsService = require(script.AnalyticsService),
    Context = SetAliasAnalyticsContext,
    connect = Context.getConnect(SetAliasAnalyticsContext),
    EventNames = require(script.Enums.EventNames),
    EntryPoints = require(script.Enums.EntryPoints),
    setupFireAnalyticsEvents = require(script.setupFireAnalyticsEvents),
    useAnalytics = require(script.useAnalytics)
}
