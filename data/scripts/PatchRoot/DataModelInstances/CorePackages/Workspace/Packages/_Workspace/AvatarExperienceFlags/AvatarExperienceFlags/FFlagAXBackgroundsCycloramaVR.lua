-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)
local FFlagAXBackgroundCycloramaRendering = require(script.Parent.FFlagAXBackgroundCycloramaRendering)

return game:DefineFastFlag("AXBackgroundsCycloramaVR", false)
    and FFlagAXBackgroundsRoot
    and FFlagAXBackgroundCycloramaRendering
