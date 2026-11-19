-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
return {
    displayName = "CoreScripts",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = { require(CorePackages.Workspace.Packages.JestConfigs).setupFiles.RetryTimes }
}
