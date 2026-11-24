-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "ExperienceLoadingScript",
    setupFilesAfterEnv = {
        scriptParent.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
