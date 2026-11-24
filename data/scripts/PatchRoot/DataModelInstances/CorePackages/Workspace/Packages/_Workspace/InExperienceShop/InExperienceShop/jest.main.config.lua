-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "InExperienceShop",
    testMatch = { "**/*.test" },
    testPathIgnorePatterns = {
        "/Mocks/",
        "/Api/",
        "/Stores/",
        "whenJoinSettles",
        "initShopGlobalIcon",
        "useCloseOnCoreMenu",
        "submitFreeTrialMenuBadge",
        "submitFreeTrialTooltips",
        "submitFreeTrialTopBarChip"
    },
    setupFilesAfterEnv = {
        JestConfigs.setupFiles.ErrorLogHandler,
        JestConfigs.setupFiles.UIBloxInitializer,
        JestConfigs.setupFiles.createPromiseRejectionHandler(),
        JestConfigs.setupFiles.RetryTimes
    }
}
