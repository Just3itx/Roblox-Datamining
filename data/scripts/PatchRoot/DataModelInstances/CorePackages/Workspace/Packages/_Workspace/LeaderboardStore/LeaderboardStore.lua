-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _LeaderboardStoreTypes = require(script.LeaderboardStoreTypes)

return {
    ["jest.config"] = script["jest.config"],
    SpecialNeutralTeamName = "Neutral",
    createLeaderboardStore = require(script.createLeaderboardStore),
    dev = {
        createMockLeaderboardStore = require(script.dev.createMockLeaderboardStore)
    }
}
