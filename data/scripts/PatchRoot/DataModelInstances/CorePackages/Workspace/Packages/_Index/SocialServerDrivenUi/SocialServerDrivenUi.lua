-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    SduiSocialRegister = require(script.System.SduiSocialRegister),
    OpenProfileQRCodePageBridge = require(script.System.OpenProfileQRCodePageBridge),
    PymkNavigationBridge = require(script.System.PymkNavigationBridge),
    SocialSduiComponentWrapper = require(script.Components.SocialSduiComponentWrapper.SocialSduiComponentWrapper),
    registerSocialActions = require(script.Actions.registerSocialActions),
    registerSocialActionTelemetryHandlers = require(script.Actions.TelemetryHandlers.registerSocialActionTelemetryHandlers),
    registerSocialComponents = require(script.System.registerSocialComponents),
    registerSocialImpressions = require(script.Impressions.registerSocialImpressions),
    FFlagSduiCreateSocialTelemetryRegistries = require(script.Flags.FFlagSduiCreateSocialTelemetryRegistries),
    ["jest.config"] = script["jest.config"]
}
