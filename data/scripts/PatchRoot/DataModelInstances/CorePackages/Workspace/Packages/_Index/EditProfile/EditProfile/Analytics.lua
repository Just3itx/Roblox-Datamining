-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local EditProfileAnalyticsContext = require(script.EditProfileAnalyticsContext)
local Context = require(EditProfileParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Context

return {
    AnalyticsService = require(script.AnalyticsService),
    Context = EditProfileAnalyticsContext,
    connect = Context.getConnect(EditProfileAnalyticsContext),
    EventNames = require(script.Enums.EventNames),
    setupFireAnalyticsEvents = require(script.setupFireAnalyticsEvents),
    useAnalytics = require(script.useAnalytics),
    AnalyticsServiceV2 = require(script.AnalyticsServiceV2)
}
