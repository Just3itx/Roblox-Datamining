-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "PioneerUtils",
    mockDataModel = true,
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.RetryTimes }
}
