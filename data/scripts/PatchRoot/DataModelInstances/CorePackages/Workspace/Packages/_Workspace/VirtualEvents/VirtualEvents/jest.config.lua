-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local JestConfigs = require(VirtualEvents.Parent.Dev.JestConfigs)

return {
    displayName = "VirtualEvents",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
