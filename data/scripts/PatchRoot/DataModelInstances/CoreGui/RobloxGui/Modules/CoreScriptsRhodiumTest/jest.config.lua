-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local JestConfigs = require(CorePackages.Workspace.Packages.JestConfigs)

_G.__TESTEZ_RUNNING_TEST__ = true

return {
    displayName = "CoreScriptsRhodiumTest",
    testMatch = { "**/*.test" },
    testPathIgnorePatterns = { "TestHelpers" },
    setupFilesAfterEnv = {
        script.Parent.TestHelpers.JestSetupDummyInstances,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes,
        script.Parent.TestHelpers["JestResetInputDevice.test"]
    }
}
