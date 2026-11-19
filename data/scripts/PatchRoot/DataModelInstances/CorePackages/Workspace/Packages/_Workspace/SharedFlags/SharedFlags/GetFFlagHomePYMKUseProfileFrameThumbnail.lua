-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:40:37Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local GetFFlagProfileFrameThumbnailEnabled = require(script.Parent.GetFFlagProfileFrameThumbnailEnabled)

game:DefineFastFlag("HomePYMKUseProfileFrameThumbnail", false)

return function()
    return game:GetFastFlag("HomePYMKUseProfileFrameThumbnail") and GetFFlagProfileFrameThumbnailEnabled()
end
