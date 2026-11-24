-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)
local setupJest = script.Parent.setupJest

return {
    displayName = "ExpChat",
    testMatch = { "**/*.test" },
    testPathIgnorePatterns = { "GetChatModerationStore", "GetUserChatSettingsStore", "useDictationAudioPipeline.test" },
    mockDataModel = false,
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.ErrorLogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes,
        setupJest
    }
}
