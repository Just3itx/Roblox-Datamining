-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:19:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)
local Roact = dependencies.Roact
local Dash = dependencies.Dash

return Roact.createContext({ fireAnalyticsEvent = Dash.noop })
