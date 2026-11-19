-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local JestConfigs = require(CorePackages.Workspace.Packages.JestConfigs)

return {
    displayName = "ProximityPrompts",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = { JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
