-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local script2 = script
local FFlagAmpV2WizardSharedLauncher = require(script2.FFlagAmpV2WizardSharedLauncher)

return {
    useAmpUpsell = require(script2.useAmpUpsell),
    useAmpUpsellLauncher = require(script2.useAmpUpsellLauncher),
    launchAmpUpsell = if FFlagAmpV2WizardSharedLauncher then require(script2.launchAmpUpsell) else nil,
    FFlagAmpV2WizardSharedLauncher = FFlagAmpV2WizardSharedLauncher,
    FFlagAmpWizardV2VpcHandoff = require(script2.FFlagAmpWizardV2VpcHandoff),
    FFlagAmpV2WizardTerminalOutcome = require(script2.FFlagAmpV2WizardTerminalOutcome),
    getOdpCheckpointDeepLinkRoute = require(script2.getOdpCheckpointDeepLinkRoute),
    openOdpFlowHandoff = require(script2.openOdpFlowHandoff),
    getAmpV2WizardRoutes = require(script2.getAmpV2WizardRoutes),
    getParentModeChromeThemeStore = require(script2.getParentModeChromeThemeStore),
    Types = require(script2.Types),
    ["jest.config"] = script["jest.config"]
}
