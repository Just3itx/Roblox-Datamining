-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    DRAWER_VELOCITY_THRESHOLD = game:DefineFastInt("DrawerSwipeVelocityThreshold", 400),
    DRAWER_SWIPE_THRESHOLD_PERCENT = game:DefineFastInt("DrawerSwipeThresholdPercent", 30) / 100,
    SWIPE_OPEN_EDGE_THRESHOLD = 20,
    SCRIM_TRANSPARENCY = 0.35,
    DRAWER_ANIM_SETTINGS = {
        duration = 0.3,
        easingStyle = {
            0.2,
            0,
            0,
            1
        },
        startingValue = nil
    }
}
