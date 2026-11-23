-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(AppChatParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("AppChatUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()
