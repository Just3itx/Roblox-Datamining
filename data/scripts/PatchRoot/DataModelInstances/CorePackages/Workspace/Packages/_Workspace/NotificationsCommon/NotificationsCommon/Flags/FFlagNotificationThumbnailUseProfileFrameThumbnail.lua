-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local GetFFlagProfileFrameThumbnailEnabled = require(scriptParentParentParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("NotificationThumbnailUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()
