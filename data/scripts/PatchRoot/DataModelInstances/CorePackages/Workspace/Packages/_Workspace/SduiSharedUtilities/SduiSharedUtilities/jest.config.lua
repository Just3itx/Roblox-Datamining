-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "SduiSharedUtilities",
    testMatch = { "**/*.test" },
    testPathIgnorePatterns = { "SduiPageAnalytics.test", "createSduiApiStore.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
