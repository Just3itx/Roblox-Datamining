-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local Songbird = script:FindFirstAncestor("Songbird")

local JestConfigs = require(Songbird.Parent.Dev.JestConfigs)

return {
    displayName = Songbird.Name,
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.ErrorLogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
