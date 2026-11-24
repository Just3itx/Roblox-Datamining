-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local JestConfigs = require(GraphQLServerParent.Dev.JestConfigs)

return {
    displayName = "GraphQlServer",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
