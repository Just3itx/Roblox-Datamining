-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _Types = require(script.Common.Types)

return {
    AccountSettingsUpsell = require(script.Components.Upsells.AccountSettingsUpsell),
    VPCUpsellContainer = require(script.Components.Upsells.ParentalRequest.VPCUpsellContainer),
    VPCPrologue = require(script.Components.Prologues.VPCPrologue),
    WizardContainer = require(script.Components.WizardContainer),
    FAEUpsellContainer = require(script.Components.Upsells.FacialAgeEstimation.FAEUpsellContainer),
    OpenAmpWizardContainer = require(script.Common.OpenAmpWizardContainer),
    AmpWizardLaunchReceiver = require(script.Components.AmpWizardLaunchReceiver),
    AmpEnums = require(script.Common.Enums),
    AmpApiProvider = require(script.Common.AmpApiProvider),
    IDVUpsellContainer = require(script.Components.Upsells.IdentityVerification.IDVUpsellContainer),
    GetFFlagEnableAmpEmailUpsellSupport = require(script.Flags.GetFFlagEnableAmpEmailUpsellSupport),
    GetFFlagEnableAmpIDVUpsellSupport = require(script.Flags.GetFFlagEnableAmpIDVUpsellSupport),
    GetFFlagEnableAmpSubscriptionUpsell = require(script.Flags.GetFFlagEnableAmpSubscriptionUpsell),
    InExpAmpWizardController = require(script.Components.InExpAmpWizardController),
    GetFFlagEnableAmpVPCPrologue = require(script.Flags.GetFFlagEnableAmpVPCPrologue),
    GetFFlagEnableReusableVPCPrologue = require(script.Flags.GetFFlagEnableReusableVPCPrologue),
    GetFFlagEnableAmpWizardVPCNavigationFix = require(script.Flags.GetFFlagEnableAmpWizardVPCNavigationFix),
    AmpWizardUserMismatchModal = require(script.Components.AmpWizardUserMismatchModal),
    ["jest.config"] = script["jest.config"]
}
