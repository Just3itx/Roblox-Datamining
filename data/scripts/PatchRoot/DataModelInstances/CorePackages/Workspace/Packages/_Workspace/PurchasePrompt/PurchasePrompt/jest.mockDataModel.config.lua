-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "PurchasePrompt-MockDataModel",
    testMatch = {
        "**/launchRobuxPackagePurchase.test",
        "**/NativePurchaseFinishedConnector.test",
        "**/NativePurchaseFinishedConnectorFlagOff.test",
        "**/Network.getPlayerOwns.test",
        "**/ProductPurchaseContainerGameplayPaused.test"
    },
    mockDataModel = true,
    setupFilesAfterEnv = { JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes },
    coveragePathIgnorePatterns = { "Localization/Locales/.*%.lua$" }
}
