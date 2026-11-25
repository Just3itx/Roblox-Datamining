-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent
local JestConfigs = require(UserProfilesParent.Dev.JestConfigs)

return {
    displayName = "UserProfiles",
    testMatch = { "**/*.test", "!**/Stores/**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
