-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T14:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagLuaAppDesktopMediaGalleryTelemetry = require(script.Parent.FFlagLuaAppDesktopMediaGalleryTelemetry)
local FFlagLuaAppEdpMediaGalleryRedesign = require(script.Parent.FFlagLuaAppEdpMediaGalleryRedesign)

return FFlagLuaAppDesktopMediaGalleryTelemetry
    and FFlagLuaAppEdpMediaGalleryRedesign
    and game:DefineFastFlag("LuaAppEdpMediaGalleryRedesignTelemetry", false)
