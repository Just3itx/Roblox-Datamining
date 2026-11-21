-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local Roact = dependencies.Roact
local Dash = dependencies.Dash

return Roact.createContext({ fireAnalyticsEvent = Dash.noop })
