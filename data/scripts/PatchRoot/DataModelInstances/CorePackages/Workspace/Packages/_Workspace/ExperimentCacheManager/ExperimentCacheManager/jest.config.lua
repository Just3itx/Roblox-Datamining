-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
_G.__TESTEZ_RUNNING_TEST__ = true

local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "ExperimentCacheManager",
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
