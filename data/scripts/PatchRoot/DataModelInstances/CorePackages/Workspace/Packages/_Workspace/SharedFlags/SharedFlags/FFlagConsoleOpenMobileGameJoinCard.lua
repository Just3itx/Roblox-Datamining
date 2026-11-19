-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnableMobileGameJoinCard = require(script.Parent.FFlagEnableMobileGameJoinCard)
local FFlagMobileGameJoinCardGamepadSupport = require(script.Parent.FFlagMobileGameJoinCardGamepadSupport)

return game:DefineFastFlag("ConsoleOpenMobileGameJoinCard", false)
    and FFlagEnableMobileGameJoinCard
    and FFlagMobileGameJoinCardGamepadSupport
