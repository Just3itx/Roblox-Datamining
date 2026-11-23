-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "UserSearch",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        script.Parent.TestHelpers.collisionMatcherSetup,
        JestConfigs.setupFiles.RetryTimes
    }
}
