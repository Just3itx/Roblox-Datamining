-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local LocalizationParent = script:FindFirstAncestor("Localization").Parent

local Signals = require(LocalizationParent.Signals)
local createLocalizationServiceStore = require(script.createLocalizationServiceStore)

return Signals.createComputed(createLocalizationServiceStore)
