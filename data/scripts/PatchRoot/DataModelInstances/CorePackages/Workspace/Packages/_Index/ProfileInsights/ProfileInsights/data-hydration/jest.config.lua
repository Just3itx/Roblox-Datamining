-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent

local JestConfigs = require(scriptParentParentParent.Dev.JestConfigs)

return {
    displayName = "ProfileInsightsDataHydration",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    },
    mockDataModel = true
}
