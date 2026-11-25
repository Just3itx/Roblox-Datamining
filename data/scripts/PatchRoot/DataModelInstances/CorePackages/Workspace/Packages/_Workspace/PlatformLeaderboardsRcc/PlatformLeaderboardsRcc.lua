-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local PlatformLeaderboardTypes = require(script.PlatformLeaderboardTypes)

local scriptParent = script.Parent
local FFlagPlatformLeaderboardRccEnabled = require(scriptParent.SharedFlags).FFlagPlatformLeaderboardRccEnabled
local PlatformLeaderboardFetcher = if FFlagPlatformLeaderboardRccEnabled then require(script.PlatformLeaderboardFetcher) else nil
local PlatformLeaderboardConfigService = if FFlagPlatformLeaderboardRccEnabled then require(script.PlatformLeaderboardConfigService) else nil
local PlatformLeaderboardCache = if FFlagPlatformLeaderboardRccEnabled then require(script.PlatformLeaderboardCache) else nil
local PlatformLeaderboardController = if FFlagPlatformLeaderboardRccEnabled then require(script.PlatformLeaderboardController) else nil
return {
    ["jest.config"] = script["jest.config"],
    PlatformLeaderboardTypes = PlatformLeaderboardTypes,
    PlatformLeaderboardFetcher = PlatformLeaderboardFetcher,
    PlatformLeaderboardConfigService = PlatformLeaderboardConfigService,
    PlatformLeaderboardCache = PlatformLeaderboardCache,
    PlatformLeaderboardController = PlatformLeaderboardController
}
