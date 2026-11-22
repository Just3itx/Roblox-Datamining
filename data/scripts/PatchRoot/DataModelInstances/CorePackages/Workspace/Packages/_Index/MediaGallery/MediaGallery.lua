-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _MediaGalleryTypes = require(script.MediaGalleryTypes)

return {
    MediaGalleryCarousel = require(script.MediaGalleryCarousel),
    MediaGalleryImageItem = require(script.MediaGalleryImageItem),
    MediaGalleryPageIndicators = require(script.MediaGalleryPageIndicators),
    MediaGalleryVideoItem = require(script.MediaGalleryVideoItem),
    MediaGalleryConstants = require(script.MediaGalleryConstants),
    isValidIdentifier = require(script.isValidIdentifier),
    isYouTubeVideo = require(script.isYouTubeVideo),
    openYouTubeVideoWithAgeCheck = require(script.openYouTubeVideoWithAgeCheck),
    useFilteredMediaItems = require(script.Hooks.useFilteredMediaItems),
    useMediaGalleryVideoAnalytics = require(script.Hooks.useMediaGalleryVideoAnalytics),
    ["jest.config"] = script["jest.config"]
}
