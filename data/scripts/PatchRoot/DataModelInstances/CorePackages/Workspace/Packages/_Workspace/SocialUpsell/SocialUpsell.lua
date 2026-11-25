-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Components = require(script.Components)
local _Types = require(script.Types)
local Thunks = require(script.Thunks)
local Enum = require(script.Enum)

return {
    InAppSocialUpsellOverlayWrapper = require(script.Components).InAppSocialUpsellOverlayWrapper,
    UpsellBanner = Components.UpsellBanner,
    UpsellOverlay = Components.UpsellOverlay,
    SocialUpsellEventReceiver = Components.SocialUpsellEventReceiver,
    Analytics = {
        SocialUpsellAnalytics = require(script.Analytics.SocialUpsellAnalytics),
        Enum = require(script.Analytics.Enum)
    },
    Enum = require(script.Enum),
    Utils = {
        createCommonSocialUpsellBannerConfig = require(script.Utils.createCommonSocialUpsellBannerConfig),
        createBannerConfigFromUpsellCardVariation = require(script.Utils.createBannerConfigFromUpsellCardVariation),
        manuallyInvokeAmpUpsell = require(script.Utils.manuallyInvokeAmpUpsell)
    },
    Signals = {
        GetAgeVerifiedChangedSignal = require(script.Signals.GetAgeVerifiedChangedSignal)
    },
    Thunks = Thunks,
    Enums = Enum,
    Hooks = require(script.Hooks),
    Constants = require(script.Constants),
    Overlay = {
        initializeInExpOverlay = require(script.Utils.initializeInExpOverlay),
        getOverlayStore = require(script.Store.getOverlayStore),
        OverlayTypes = require(script.Constants).OVERLAY_TYPES
    },
    ["jest.config"] = script["jest.config"]
}
