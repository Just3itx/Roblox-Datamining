-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local script2 = script
local RobloxSubscriptionFlowCompleteReason = require(script2.Enums.RobloxSubscriptionFlowCompleteReason)
local SurfaceName = require(script2.Enums.SurfaceName)
local SurfaceContext = require(script2.Enums.SurfaceContext)
local PurchaseClientSessionIdType = require(script2.Enums.PurchaseClientSessionIdType)
local SubscriptionGrantType = require(script2.Enums.SubscriptionGrantType)
local RobloxPlusSheetKind = require(script2.Enums.RobloxPlusSheetKind)
local script2Parent = script2.Parent

local FFlagEnablePlusReferralEntrypointTelemetry = require(script2Parent.SharedFlags).FFlagEnablePlusReferralEntrypointTelemetry
local Entrypoint = if FFlagEnablePlusReferralEntrypointTelemetry then require(script2.Enums.Entrypoint) else nil
local FFlagTTOnboardingSheet = require(script2.Flags.FFlagTTOnboardingSheet)
local BlackbirdUpsellBanner = require(script2.Components.BlackbirdUpsellBanner)
local RobloxPlusUpsellBanner = require(script2.Components.RobloxPlusUpsellBanner)
local getRobloxSubscriptionProducts = require(script2.Network.getRobloxSubscriptionProducts)
local _types = require(script2.types)
local RobloxSubscriptionSignals = require(script2.Store.RobloxSubscriptionSignals)

local module = {
    initiateRobloxSubscriptionPurchase = require(script.Flows.initiateRobloxSubscriptionPurchase)
}

function module.resetRobloxSubscriptionPurchaseConfiguration()
    require(script.Flows.resetRobloxSubscriptionPurchaseConfiguration)()
end
module.openTTSheet = if FFlagTTOnboardingSheet then require(script.Flows.openTTSheet) else nil
module.startRobloxSubscriptionPurchaseFromUpsell = require(script.Flows.startRobloxSubscriptionPurchaseFromUpsell)
module.SurfaceContext = SurfaceContext
module.SurfaceName = SurfaceName
if not FFlagEnablePlusReferralEntrypointTelemetry then
    Entrypoint = nil
end

module.Entrypoint = Entrypoint
module.PurchaseClientSessionIdType = PurchaseClientSessionIdType
module.RobloxSubscriptionFlowCompleteReason = RobloxSubscriptionFlowCompleteReason
module.SubscriptionGrantType = SubscriptionGrantType
module.RobloxPlusSheetKind = RobloxPlusSheetKind

module.Flags = {
    FFlagTTOnboardingSheet = require(script2.Flags.FFlagTTOnboardingSheet),
    FFlagSubscriptionSheetCampaignLocalizations = require(script2Parent.SharedFlags).FFlagSubscriptionSheetCampaignLocalizations
}

module.Components = {
    BlackbirdUpsellBanner = BlackbirdUpsellBanner,
    RobloxPlusUpsellBanner = RobloxPlusUpsellBanner
}

module.Network = {
    getRobloxSubscriptionProducts = getRobloxSubscriptionProducts,
    claimTrial = require(script2.Network.claimTrial)
}

module.RobloxSubscriptionSignals = RobloxSubscriptionSignals
module.CampaignLocalizations = require(script2.Store.CampaignLocalizations)
module.Utils = {
    getSubscriptionPurchaseCloseCallback = require(script2.Utils.getSubscriptionPurchaseCloseCallback)
}

module["jest.config"] = script["jest.config"]
return module
