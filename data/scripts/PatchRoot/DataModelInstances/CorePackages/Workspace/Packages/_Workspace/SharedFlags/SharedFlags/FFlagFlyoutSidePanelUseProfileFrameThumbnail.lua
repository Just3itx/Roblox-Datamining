-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T14:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local GetFFlagProfileFrameThumbnailEnabled = require(script.Parent.GetFFlagProfileFrameThumbnailEnabled)

return game:DefineFastFlag("FlyoutSidePanelUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()
