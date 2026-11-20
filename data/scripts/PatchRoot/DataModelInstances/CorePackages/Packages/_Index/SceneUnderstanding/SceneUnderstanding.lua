-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    ViewportQueryOptions = require(script.options.ViewportQueryOptions),
    RangeQueryOptions = require(script.options.RangeQueryOptions),
    DataModelTraversalOptions = require(script.options.DataModelTraversalOptions),
    getSourceAssetsInView = require(script.getSourceAssetsInView),
    getSourceAssetsInRange = require(script.getSourceAssetsInRange),
    createLazyInstanceCollector = require(script.traversal.createLazyInstanceCollector),
    isSourceAsset = require(script.isSourceAsset),
    calculatePotentialAudibility = require(script.audio.calculatePotentialAudibility),
    getAudibleVolume = require(script.audio.getAudibleVolume),
    isAudible = require(script.audio.isAudible)
}
