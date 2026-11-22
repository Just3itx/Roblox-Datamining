-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "Moments-MockDataModel",
    testMatch = { "**/Analytics/**/*.test", "**/Upload/postLifecycleSubscription.test" },
    mockDataModel = true,
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
