-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent
local JestConfigs = require(ApolloLocalStateParent.Dev.JestConfigs)

return {
    displayName = "ApolloLocalState",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
