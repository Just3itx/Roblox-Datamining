-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "SwitchServer-MockDataModel",
    testMatch = { "**/createSwitchServerStore.test" },
    mockDataModel = true,
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
