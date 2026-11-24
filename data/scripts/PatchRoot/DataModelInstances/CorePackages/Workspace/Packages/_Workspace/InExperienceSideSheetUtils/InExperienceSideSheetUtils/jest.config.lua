-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "InExperienceSideSheetUtils",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.createPromiseRejectionHandler() }
}
