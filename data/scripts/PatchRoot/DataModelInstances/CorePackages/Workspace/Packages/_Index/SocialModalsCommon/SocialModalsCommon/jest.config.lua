-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialModalsCommonParent = script:FindFirstAncestor("SocialModalsCommon").Parent
local JestConfigs = require(SocialModalsCommonParent.Dev.JestConfigs)

return {
    displayName = "SocialModalsCommon",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
