-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialToastParent = script:FindFirstAncestor("SocialToast").Parent
local JestConfigs = require(SocialToastParent.Dev.JestConfigs)

return {
    displayName = "SocialToast",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
