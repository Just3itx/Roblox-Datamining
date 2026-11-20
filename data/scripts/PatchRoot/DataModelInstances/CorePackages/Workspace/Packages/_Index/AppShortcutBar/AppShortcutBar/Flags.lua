-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local AppUserLayers = require(AppShortcutBarParent.ExperimentLayers).AppUserLayers

return {
    FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled = game:DefineFastFlag("EnableStickyShortcutBarOnAllPlatformsIxpEnabled", false),
    FStringEnableStickyShortcutBarOnAllPlatformsIxpLayer = game:DefineFastString("EnableStickyShortcutBarOnAllPlatformsIxpLayer", AppUserLayers.UnifyShortcutBarExposureLayer),
    FFlagStickyShortcutBarTvRemoteWithGamepad = game:DefineFastFlag("StickyShortcutBarTvRemoteWithGamepad", false),
    FFlagShortcutBarPlatformGamepadIcons = game:DefineFastFlag("ShortcutBarPlatformGamepadIcons", false),
    FFlagUnifyShortcutBarExposureTelemetry = game:DefineFastFlag("UnifyShortcutBarExposureTelemetry", false)
}
