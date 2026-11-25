-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnableMobilePlayerListOnConsole = require(script.Parent.FFlagEnableMobilePlayerListOnConsole)

return game:DefineFastFlag("PlayerListDropDownShowPlatformName", false) and FFlagEnableMobilePlayerListOnConsole
