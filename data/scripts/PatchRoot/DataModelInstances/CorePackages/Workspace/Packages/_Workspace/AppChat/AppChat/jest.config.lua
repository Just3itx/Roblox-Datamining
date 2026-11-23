-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local JestConfigs = require(AppChatParent.Dev.JestConfigs)
local setupJest = script.Parent.setupJest
local setupLogger = script.Parent.setupLogger

return {
    displayName = "AppChat",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        setupJest,
        setupLogger,
        JestConfigs.setupFiles.RetryTimes
    }
}
