-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GameProductInfo = require(script.GameProductInfo)

return {
    FetchGamesProductInfo = require(script.FetchGamesProductInfo),
    GameProductInfo = GameProductInfo,
    GamesProductInfoReducer = require(script.GamesProductInfoReducer),
    useGameProductInfoSelector = require(script.useGameProductInfoSelector),
    ["jest.config"] = script["jest.config"]
}
