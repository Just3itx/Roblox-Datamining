-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXBackgroundsCustomizeHydration = require(script.Parent.FFlagAXBackgroundsCustomizeHydration)
local FFlagAXCatalogBackgroundsSupport = require(script.Parent.FFlagAXCatalogBackgroundsSupport)
local FFlagAXBackgroundsEndTryOnOnSelect = require(script.Parent.FFlagAXBackgroundsEndTryOnOnSelect)
local FFlagAXSlotsScrollAwayOnlyWithSlots = require(script.Parent.FFlagAXSlotsScrollAwayOnlyWithSlots)

local bool1 = game:DefineFastFlag("AXBackgroundsYouMayAlsoLike", false)

return FFlagAXBackgroundsCustomizeHydration
    and FFlagAXCatalogBackgroundsSupport
    and FFlagAXBackgroundsEndTryOnOnSelect
    and FFlagAXSlotsScrollAwayOnlyWithSlots
    and bool1
