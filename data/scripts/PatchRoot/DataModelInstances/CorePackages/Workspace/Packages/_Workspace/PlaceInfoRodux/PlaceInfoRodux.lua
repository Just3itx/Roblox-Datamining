-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local Flags = {
    FFlagUsePlaceInfoController = game:DefineFastFlag("UsePlaceInfoController2", false),
    FFlagUseUniverseVotesController = game:DefineFastFlag("UseUniverseVotesController", false)
}

return {
    Actions = require(script.Actions),
    Flags = Flags,
    Models = require(script.Models),
    PlaceInfoController = if Flags.FFlagUsePlaceInfoController then require(script.PlaceInfoController) else nil,
    UniverseVotesController = if Flags.FFlagUseUniverseVotesController then require(script.UniverseVotesController) else nil,
    Reducers = require(script.Reducers),
    Thunks = require(script.Thunks)
}
