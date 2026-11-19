-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:31:13Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagLuaAppEdpMediaGalleryRedesign = require(script.Parent.FFlagLuaAppEdpMediaGalleryRedesign)
local FFlagLuaAppEdpMediaGalleryVideoPreviewIxp = require(script.Parent.FFlagLuaAppEdpMediaGalleryVideoPreviewIxp)

return FFlagLuaAppEdpMediaGalleryRedesign
    and (game:DefineFastFlag("LuaAppEdpMediaGalleryVideoPreview5", false) or FFlagLuaAppEdpMediaGalleryVideoPreviewIxp)
