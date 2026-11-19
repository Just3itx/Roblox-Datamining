-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local JestConfigs = require(CorePackages.Workspace.Packages.JestConfigs)

return {
    displayName = "AvatarContextMenu",
    testMatch = { "**/*.test" },
    testPathIgnorePatterns = { "ContextMenuItems.test" },
    setupFilesAfterEnv = { JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler(10, 10), JestConfigs.setupFiles.RetryTimes }
}
