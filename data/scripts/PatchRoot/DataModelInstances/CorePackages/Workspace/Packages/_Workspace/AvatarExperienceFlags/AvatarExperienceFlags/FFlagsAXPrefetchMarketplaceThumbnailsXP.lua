-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXStrictCheckForPrefetchMarketplace = require(script.Parent.FFlagAXStrictCheckForPrefetchMarketplace)

return {
    UserIsInTreatment = FFlagAXStrictCheckForPrefetchMarketplace and game:DefineFastFlag("AXPrefetchMarketplaceThumbnailsXPV4", false),
    UserIsInExperiment = FFlagAXStrictCheckForPrefetchMarketplace and game:DefineFastFlag("AXPrefetchMarketplaceThumbnailsXPExposureV4", false)
}
