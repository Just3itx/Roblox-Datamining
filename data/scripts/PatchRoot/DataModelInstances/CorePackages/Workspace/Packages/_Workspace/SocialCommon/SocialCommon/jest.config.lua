-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local JestConfigs = require(SocialCommonParent.Dev.JestConfigs)

return {
    displayName = "SocialCommon",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        script.Parent.TestHelpers.collisionMatcherSetup,
        JestConfigs.setupFiles.RetryTimes
    }
}
