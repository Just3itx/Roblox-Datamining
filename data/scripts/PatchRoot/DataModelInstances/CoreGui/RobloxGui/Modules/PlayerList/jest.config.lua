-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local JestConfigs = require(CorePackages.Workspace.Packages.JestConfigs)

_G.__TESTEZ_RUNNING_TEST__ = true

return {
    displayName = "PlayerList",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        script.Parent.TestHelpers.JestSetupDummyInstances,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(10, 10),
        JestConfigs.setupFiles.RetryTimes
    }
}
