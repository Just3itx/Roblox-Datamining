-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local WhatsNewParent = script:FindFirstAncestor("WhatsNew").Parent

local JestConfigs = require(WhatsNewParent.Dev.JestConfigs)

return {
    displayName = "WhatsNew-MockDataModel",
    testMatch = {
        "**/storage/**/*.test",
        "**/telemetry/**/*.test",
        "**/createWhatsNewStore.test",
        "**/createInGameWhatsNewHost.test"
    },
    mockDataModel = true,
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
