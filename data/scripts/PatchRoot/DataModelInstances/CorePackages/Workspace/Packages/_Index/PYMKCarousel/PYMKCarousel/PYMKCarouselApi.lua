-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent

local _DirectRecommendationTypes = require(scriptParent.Common.DirectRecommendationTypes)

return {
    installReducer = require(script.Parent.installReducer),
    PYMKCollectionCarousel = require(script.Parent.Components.PYMKCollectionCarousel),
    PYMKCarouselEntryPoint = require(script.Parent.Components.PYMKCarouselEntryPoint),
    RoduxKey = require(script.Parent.Common.Constants).RODUX_KEY,
    PYMKCarouselModel = {
        fromJsonData = require(script.Parent.installReducer.fromOmniJsonData)
    },
    ["jest.config"] = script.Parent["jest.config"]
}
