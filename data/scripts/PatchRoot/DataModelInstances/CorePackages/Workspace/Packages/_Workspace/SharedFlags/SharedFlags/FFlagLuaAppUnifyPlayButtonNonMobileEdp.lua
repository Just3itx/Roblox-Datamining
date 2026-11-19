-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:51:22Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagUIBloxEnableActionBarButtonOverride = require(script.Parent.UIBlox).FFlagUIBloxEnableActionBarButtonOverride
local FFlagLuaAppUnifyPlayButtonAllSurfacesIxp = require(script.Parent.FFlagLuaAppUnifyPlayButtonAllSurfacesIxp)

return FFlagUIBloxEnableActionBarButtonOverride
    and (game:DefineFastFlag("LuaAppUnifyPlayButtonNonMobileEdp3", false) or FFlagLuaAppUnifyPlayButtonAllSurfacesIxp)
