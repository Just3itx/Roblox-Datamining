-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local Signals = require(AvatarExperienceCatalogParent.Signals)

local createAXMarketplaceWidgetStore = require(script.createAXMarketplaceWidgetStore)

return Signals.createComputed(createAXMarketplaceWidgetStore)
