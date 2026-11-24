-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "CoreScriptsErrorBoundary",
    setupFilesAfterEnv = { JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
