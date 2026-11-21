-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(FlyoutSidePanelParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("FlyoutAlternateEntryPointUseProfileFrameThumbnail", false)
    and GetFFlagProfileFrameThumbnailEnabled()
