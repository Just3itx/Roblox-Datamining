-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)
local FFlagAXBackgroundsOutfitPersistence = require(script.Parent.FFlagAXBackgroundsOutfitPersistence)

local bool1 = game:DefineFastFlag("AXBackgroundsOutfitHighlight", false)

return FFlagAXBackgroundsRoot and FFlagAXBackgroundsOutfitPersistence and bool1
