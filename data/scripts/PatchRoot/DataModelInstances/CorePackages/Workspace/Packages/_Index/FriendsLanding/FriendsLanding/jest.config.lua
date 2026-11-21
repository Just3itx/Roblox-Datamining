-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "FriendsLanding",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        scriptParent.TestHelpers.CollisionMatchersSetup,
        scriptParent.TestHelpers.NetworkImplHandler,
        JestConfigs.setupFiles.RetryTimes
    }
}
