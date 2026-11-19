-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetFFlagProfileFrameThumbnailEnabled = require(script.Parent.GetFFlagProfileFrameThumbnailEnabled)

game:DefineFastFlag("HomePYMKUseProfileFrameThumbnail", false)

return function()
    return game:GetFastFlag("HomePYMKUseProfileFrameThumbnail") and GetFFlagProfileFrameThumbnailEnabled()
end
