-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)

local InExpAmpWizardController = require(CurrencyTransfersParent.AmpUpsell).InExpAmpWizardController

local RobloxSubscriptionPurchaseApp = require(CurrencyTransfersParent.RobloxSubscriptionPurchaseApp)
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext

local function InExperienceRobuxTransferSubscriptionUpsell(tbl1)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.SubscriptionUpsellContainer)
    local onClose = tbl1.onClose
    local upsellSubscriptionTitle = var1.UpsellSubscriptionTitle or ""

    React.useEffect(function()
        local tbl2 = {
            purchaseUIOptions = { title = upsellSubscriptionTitle },
            surfaceName = SurfaceName.RobuxTransferUpsell,
            surfaceContext = SurfaceContext.InGame
        }

        InExpAmpWizardController.OpenAmpWizardContainerInExp("CanInitiateRobuxTransfer", function()
            onClose()
        end, tbl2, AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX, nil, AmpWizardTransferConstants.NAMESPACE_NAME)
    end, {})

    return React.createElement(React.Fragment, {})
end

return InExperienceRobuxTransferSubscriptionUpsell
