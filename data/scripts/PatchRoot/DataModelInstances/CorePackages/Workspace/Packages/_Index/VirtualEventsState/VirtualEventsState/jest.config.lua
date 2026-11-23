-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local JestConfigs = require(VirtualEventsState.Parent.Dev.JestConfigs)

return {
    displayName = "VirtualEventsState",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
