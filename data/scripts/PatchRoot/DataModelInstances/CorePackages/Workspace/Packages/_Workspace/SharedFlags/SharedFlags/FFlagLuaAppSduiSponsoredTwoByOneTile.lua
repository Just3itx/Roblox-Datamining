-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:50:56Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagLuaAppSduiGameTileFeedback = require(script.Parent.FFlagLuaAppSduiGameTileFeedback)
local FFlagMigrateGameInfoToStore = require(script.Parent.FFlagMigrateGameInfoToStore)

return game:DefineFastFlag("LuaAppSduiSponsoredTwoByOneTile2", false)
    and FFlagLuaAppSduiGameTileFeedback
    and FFlagMigrateGameInfoToStore
