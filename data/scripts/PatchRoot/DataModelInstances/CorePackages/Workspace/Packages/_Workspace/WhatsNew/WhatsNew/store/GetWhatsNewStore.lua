-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
local WhatsNewParent = script:FindFirstAncestor("WhatsNew").Parent

local Signals = require(WhatsNewParent.Signals)
local createWhatsNewStore = require(script.createWhatsNewStore)

return Signals.createComputed(createWhatsNewStore)
