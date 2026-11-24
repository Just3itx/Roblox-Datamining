-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "ExpChat-MockDataModel",
    testMatch = { "**/GetChatModerationStore/**/*.test", "**/GetUserChatSettingsStore/**/*.test", "**/useDictationAudioPipeline.test" },
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler() },
    mockDataModel = true
}
