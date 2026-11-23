-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXBackgroundGeneration = require(script.Parent.FFlagAXBackgroundGeneration)

local FFlagAXBackgroundsHidePlusUpsellsWhenGuacDisabled = require(script.Parent.FFlagAXBackgroundsHidePlusUpsellsWhenGuacDisabled)

return game:DefineFastFlag("AXBackgroundsHideCreateTileWithoutAiEntitlement", false)
    and FFlagAXBackgroundGeneration
    and FFlagAXBackgroundsHidePlusUpsellsWhenGuacDisabled
