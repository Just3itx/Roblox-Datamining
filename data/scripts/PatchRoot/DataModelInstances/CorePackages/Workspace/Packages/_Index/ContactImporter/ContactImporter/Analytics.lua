-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:19:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local Context = require(ContactImporter.dependencies).SocialLibraries.Context

local ContactImporterAnalyticsContext = require(script.ContactImporterAnalyticsContext)
return {
    setupFireAnalyticsEvents = require(script.setupFireAnalyticsEvents),
    Context = ContactImporterAnalyticsContext,
    connect = Context.getConnect(ContactImporterAnalyticsContext),
    useAnalytics = require(script.useAnalytics),
    EventNames = require(script.Enums.EventNames),
    EntryPoints = require(script.Enums.ContactImporterEntryPoints),
    FieldNames = require(script.FieldNames),
    AnalyticsService = require(script.AnalyticsService)
}
