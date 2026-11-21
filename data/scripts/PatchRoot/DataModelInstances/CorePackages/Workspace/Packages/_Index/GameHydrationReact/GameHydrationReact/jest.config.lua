-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "GameHydrationReact",
    setupFilesAfterEnv = { JestConfigs.setupFiles.LogHandler, JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler() }
}
