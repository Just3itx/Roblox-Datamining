-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent
local JestConfigs = require(ShareSheetParent.Dev.JestConfigs)

return {
    displayName = "ShareSheet",
    testMatch = { "**/*.test" },
    testPathIgnorePatterns = { "/telemetry/" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
