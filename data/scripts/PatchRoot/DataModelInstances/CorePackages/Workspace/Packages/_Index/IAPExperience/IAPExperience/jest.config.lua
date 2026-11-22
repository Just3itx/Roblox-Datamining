-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local JestConfigs = require(scriptParentParent.Dev.JestConfigs)

return {
    displayName = "IAPExperience",
    testMatch = {
        "**/*.test",
        "!**/EconomicRestriction/**",
        "!**/Generic/DiscountRow.test",
        "!**/Generic/DiscountSummary.test",
        "!**/Generic/PriceLineItem.test",
        "!**/Generic/PriceSummary.test",
        "!**/Generic/PriceSummaryV2.test",
        "!**/Generic/UnifiedProductDetails.test"
    },
    setupFilesAfterEnv = { JestConfigs.setupFiles.UIBloxInitializer, JestConfigs.setupFiles.createPromiseRejectionHandler(), JestConfigs.setupFiles.RetryTimes }
}
