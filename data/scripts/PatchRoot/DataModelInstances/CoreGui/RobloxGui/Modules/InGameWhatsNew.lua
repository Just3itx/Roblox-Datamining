-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local WhatsNew = require(CorePackages.Workspace.Packages.WhatsNew)
local createInGameScopeActions = require(script.createInGameScopeActions)

return WhatsNew.createInGameWhatsNewHost({ scopeActions = createInGameScopeActions() })
