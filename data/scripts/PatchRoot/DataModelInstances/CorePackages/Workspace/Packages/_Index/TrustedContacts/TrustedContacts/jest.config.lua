-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent
local JestConfigs = require(TrustedContactsParent.Dev.JestConfigs)

return {
    displayName = "TrustedContacts",
    testMatch = { "**/*.test" },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.LogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
