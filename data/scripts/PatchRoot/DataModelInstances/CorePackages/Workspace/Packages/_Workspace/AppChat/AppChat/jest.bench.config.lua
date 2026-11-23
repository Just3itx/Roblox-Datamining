-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local JestConfigs = require(AppChatParent.Dev.JestConfigs)

return JestConfigs.createBenchmarkConfig("AppChatBenchmarks", {
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        AppChat.setupJest,
        AppChat.setupLogger
    }
})
