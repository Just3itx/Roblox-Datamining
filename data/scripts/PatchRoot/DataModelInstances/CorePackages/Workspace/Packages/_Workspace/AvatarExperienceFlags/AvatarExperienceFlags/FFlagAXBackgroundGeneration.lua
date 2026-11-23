-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)
local FFlagAXBackgroundsCustomizeHydration = require(script.Parent.FFlagAXBackgroundsCustomizeHydration)

local FFlagAXBackgroundGenerationResultActionButtons = require(script.Parent.FFlagAXBackgroundGenerationResultActionButtons)

local bool1 = game:DefineFastFlag("AXBackgroundGenerationV2", false)

local bool2 = game:DefineFastFlag("AXBackgroundGenerationBuildGate", false)
return (bool1 or bool2 or FFlagAXBackgroundGenerationResultActionButtons)
    and FFlagAXBackgroundsRoot
    and FFlagAXBackgroundsCustomizeHydration
