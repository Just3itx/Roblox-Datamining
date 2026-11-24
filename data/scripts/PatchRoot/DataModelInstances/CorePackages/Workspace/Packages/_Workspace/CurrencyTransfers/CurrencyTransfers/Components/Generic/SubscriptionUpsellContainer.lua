-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)

local FFlagCurrencyTransferNoFreeTransfersRemainingUpsell = require(CurrencyTransfers.Flags.FFlagCurrencyTransferNoFreeTransfersRemainingUpsell)

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local initiateTransfer = require(CurrencyTransfers.Actions.Send.initiateTransfer)
local processTransfer = require(CurrencyTransfers.Actions.Send.processTransfer)
local acceptTransfer = require(CurrencyTransfers.Actions.Receive.acceptTransfer)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)

local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)
local getCounterUserId = require(CurrencyTransfers.Utils.getCounterUserId)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local AmpUpsell = require(CurrencyTransfersParent.AmpUpsell)
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local InExpAmpWizardController = AmpUpsell.InExpAmpWizardController

local RobloxSubscriptionPurchaseApp = require(CurrencyTransfersParent.RobloxSubscriptionPurchaseApp)
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext

local function SubscriptionUpsellContainer(tbl1)
    local var1 = useTransferStore()
    local var2 = useLocalization(TransferLocalizationKeys.Presets.SubscriptionUpsellContainer)
    local direction = tbl1.direction
    local triggerOnClose = var1.triggerOnClose
    local selectedAmount = var1.getSelectedAmount(false)
    local transferRetryOrigin = var1.getTransferRetryOrigin(false)
    local surfaceContext = if var1.getTransferOrigination(false) == TransferOrigination.InExperience then SurfaceContext.InGame else SurfaceContext.InApp
    local freeTransfersExhausted = var1.getFreeTransfersExhausted(false)
    local upsellSubscriptionTitle = var2.UpsellSubscriptionTitle or ""
    if FFlagCurrencyTransferNoFreeTransfersRemainingUpsell and freeTransfersExhausted then
        upsellSubscriptionTitle = var2.FreeTransfersExhaustedTitle
    end

    local clientSessionId = var1.getTransferClientSessionId(false)
    local analyticsContext = SharedFlags.FFlagEnableRobuxTransferFlowEventIngest
        and clientSessionId ~= ""
        and {
            clientSessionId = {
                clientSessionIdType = RobloxSubscriptionPurchaseApp.PurchaseClientSessionIdType.CurrencyTransferSessionId,
                clientSessionId = clientSessionId
            }
        }
        or nil

    local tbl2 = {
        purchaseUIOptions = { title = upsellSubscriptionTitle },
        surfaceName = SurfaceName.RobuxTransferUpsell,
        surfaceContext = surfaceContext,
        analyticsContext = analyticsContext
    }

    React.useEffect(function()
        if not tbl1.ampFeatureCheck then
            triggerOnClose()
            return
        end

        logCurrencyTransferCounter(
            var1,
            CurrencyTransferTelemetry.CurrencyTransferSubscriptionUpsellWizardOpenedCounter,
            { recourseSurface = "subscription" }
        )
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var1, RobuxTransferFlowEventName.subscription_upsell_wizard_opened)
        end

        local promptState = var1.getPromptState(false)
        var1.setPreviousPromptState(promptState)
        var1.setPromptState(PromptState.Hidden)

        local counterUserId = getCounterUserId(var1, direction)

        local var5 = counterUserId and {{
            name = "targetUser",
            value = tostring(counterUserId),
            type = "UserId"
        }} or nil

        InExpAmpWizardController.OpenAmpWizardContainerInExp(tbl1.ampFeatureCheck, function(granted, _)
            if granted ~= AccessResponseEnum.Granted then
                logCurrencyTransferCounter(
                    var1,
                    CurrencyTransferTelemetry.CurrencyTransferSubscriptionUpsellWizardResultDeniedCounter,
                    { recourseSurface = "subscription" }
                )
                if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                    logRobuxTransferFlowEvent(var1, RobuxTransferFlowEventName.subscription_upsell_wizard_result_denied)
                end

                triggerOnClose()

                return
            end

            logCurrencyTransferCounter(
                var1,
                CurrencyTransferTelemetry.CurrencyTransferSubscriptionUpsellWizardResultGrantedCounter,
                { recourseSurface = "subscription" }
            )
            if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                logRobuxTransferFlowEvent(var1, RobuxTransferFlowEventName.subscription_upsell_wizard_result_granted)
            end

            local previousPromptState = var1.getPreviousPromptState(false)
            if previousPromptState then
                var1.setPromptState(previousPromptState)
            end

            if transferRetryOrigin == TransferRetryOrigin.AcceptTransfer then
                acceptTransfer(var1)
            elseif transferRetryOrigin == TransferRetryOrigin.InitiateTransfer then
                initiateTransfer(var1)
            elseif transferRetryOrigin == TransferRetryOrigin.ProcessTransfer then
                processTransfer(var1, selectedAmount or 0)
            elseif direction == TransferDirection.Receive then
                acceptTransfer(var1)
            else
                processTransfer(var1, selectedAmount or 0)
            end
        end, tbl2, AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX, var5, AmpWizardTransferConstants.NAMESPACE_NAME)
    end, {})

    return React.createElement(React.Fragment, {})
end

return SubscriptionUpsellContainer
