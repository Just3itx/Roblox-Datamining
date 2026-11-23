-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserBlockingRoduxParent = script:FindFirstAncestor("UserBlockingRodux").Parent

local JestConfigs = require(UserBlockingRoduxParent.Dev.JestConfigs)

return {
    displayName = "UserBlockingRodux",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
