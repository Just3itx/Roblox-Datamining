-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "CoreScriptsProfiler",
    testMatch = { "**/*.test" },
    mockDataModel = true,
    setupFilesAfterEnv = { JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
