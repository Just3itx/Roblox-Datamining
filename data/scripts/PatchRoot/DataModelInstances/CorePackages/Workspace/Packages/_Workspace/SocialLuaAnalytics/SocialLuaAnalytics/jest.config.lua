-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent
local JestConfigs = require(SocialLuaAnalyticsParent.Dev.JestConfigs)

return {
    displayName = "SocialLuaAnalytics",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
