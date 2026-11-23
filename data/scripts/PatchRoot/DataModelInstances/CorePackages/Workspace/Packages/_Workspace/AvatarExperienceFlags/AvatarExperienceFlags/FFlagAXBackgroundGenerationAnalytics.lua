-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXBackgroundGeneration = require(script.Parent.FFlagAXBackgroundGeneration)
local FFlagAXItemDetailsIxpExposure = require(script.Parent.FFlagAXItemDetailsIxpExposure)
local FFlagAXSkipTapDetection = require(script.Parent.FFlagAXSkipTapDetection)

return game:DefineFastFlag("AXBackgroundGenerationAnalytics", false)
    and FFlagAXBackgroundGeneration
    and FFlagAXItemDetailsIxpExposure
    and FFlagAXSkipTapDetection
