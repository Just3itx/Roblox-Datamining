-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local MediaGalleryParent = script:FindFirstAncestor("MediaGallery").Parent
local _Otter = require(MediaGalleryParent.Otter)

return {
    ITEM_ASPECT_RATIO = 16 / 9,
    SPRING_CONFIG = { frequency = 3, dampingRatio = 1, restingVelocityLimit = 0.05 },
    SLIDING_WINDOW_SIZE = 3,
    AUTO_ADVANCE_DURATION_SECONDS = 5,
    LARGE_GALLERY_BREAKPOINT = 500,
    VIDEO_DWELL_TIME_HUNDREDTHS_SEC = 0,
    VIDEO_VISIBLE_PERCENT = 50,
    VIDEO_PLAYBACK_VISIBLE_PERCENT = 80,
    VISIBILITY_SCAN_DEBOUNCE_SEC = 0.5,
    MAX_VISIBLE_INDICATORS = 5
}
