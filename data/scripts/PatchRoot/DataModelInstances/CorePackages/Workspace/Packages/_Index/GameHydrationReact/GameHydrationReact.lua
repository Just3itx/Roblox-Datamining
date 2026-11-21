-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DataHydration = require(script.Parent.DataHydration)

return {
    useGameInfo = require(script.useGameInfo),
    useGameInfos = require(script.useGameInfos),
    useGameVotes = require(script.useGameVotes),
    useGameIcon = require(script.useGameIcon),
    useLargeGameIcon = require(script.useLargeGameIcon),
    useGameIcons = require(script.useGameIcons),
    useFetchGameIcons = require(script.useFetchGameIcons),
    subscribeGameInfo = require(script.subscribeGameInfo),
    subscribeGameIcon = require(script.subscribeGameIcon),
    subscribeGameIcons = require(script.subscribeGameIcons),
    GameIconSize = DataHydration.Game.GameIconSize,
    ["jest.config"] = script["jest.config"]
}
