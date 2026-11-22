-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformCommonParent = script:FindFirstAncestor("ProfilePlatformCommon").Parent

local JestConfigs = require(ProfilePlatformCommonParent.Dev.JestConfigs)

return {
    displayName = "ProfilePlatformCommon",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
