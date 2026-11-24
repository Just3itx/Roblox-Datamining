-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "InExperienceShop-MockDataModel",
    testMatch = {
        "**/Mocks/**/*.test",
        "**/Mocks/*.test",
        "**/Api/**/*.test",
        "**/Api/*.test",
        "**/Stores/**/*.test",
        "**/Stores/*.test",
        "**/Internal/whenJoinSettles.test",
        "**/Hooks/useCloseOnCoreMenu.test",
        "**/initShopGlobalIcon.test",
        "**/submitFreeTrialMenuBadge.test",
        "**/submitFreeTrialTooltips.test",
        "**/submitFreeTrialTopBarChip.test"
    },
    mockDataModel = true,
    setupFilesAfterEnv = { JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
