-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    AddGames = require(script.AddGames),
    GameInfosReducer = require(script.GameInfosReducer),
    parseAndAddGameInfos = require(script.parseAndAddGameInfos),
    syncGameInfosToStore = require(script.syncGameInfosToStore),
    toLegacyGameInfoModel = require(script.toLegacyGameInfoModel),
    ["jest.config"] = script["jest.config"]
}
