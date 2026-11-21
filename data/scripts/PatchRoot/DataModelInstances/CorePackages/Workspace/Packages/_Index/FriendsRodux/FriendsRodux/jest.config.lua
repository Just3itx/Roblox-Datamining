-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent

local JestConfigs = require(FriendsRoduxParent.Dev.JestConfigs)

return {
    displayName = "FriendsRodux",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
