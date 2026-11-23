-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagParseHeadShapeFromAPIResponse = require(script.Parent.FFlagParseHeadShapeFromAPIResponse)
local FFlagHeadRefinementFacialAnimationToggle = require(script.Parent.FFlagHeadRefinementFacialAnimationToggle)

return game:DefineFastFlag("AXKeepHeadShapeInInventoryOutfitMeta", false)
    and FFlagParseHeadShapeFromAPIResponse
    and FFlagHeadRefinementFacialAnimationToggle
