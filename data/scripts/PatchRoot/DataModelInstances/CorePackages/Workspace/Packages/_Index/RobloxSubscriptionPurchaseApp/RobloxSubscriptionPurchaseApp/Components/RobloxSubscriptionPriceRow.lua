-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local View = Foundation.View
local FoundationText = Foundation.Text

local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization
local getPeriodTypeDisplayLabel = require(RobloxSubscriptionPurchaseApp.Utils.getPeriodTypeDisplayLabel)
local getFreeTrialOffer = require(RobloxSubscriptionPurchaseApp.Utils.getFreeTrialOffer)
local isSupportedTrialPeriodType = require(RobloxSubscriptionPurchaseApp.Utils.isSupportedTrialPeriodType)
local FFlagRobloxPlusDynamicFreeTrialLength = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusDynamicFreeTrialLength)

local function RobloxSubscriptionPriceRow(tbl1)
    local var1 = RobloxSubscriptionStore.get()

    local var2 = SignalsReact.useSignalState(var1.getRobloxSubscriptionProduct)

    local localizedPriceDisplayString = var2 and var2.LocalizedPriceDisplayString
    local periodType = var2 and var2.PeriodType
    local bool1 = tbl1.isFreeTrial == true
    local periodTypeDisplayLabel = getPeriodTypeDisplayLabel(periodType or "", false)
    local freeTrialOffer = if FFlagRobloxPlusDynamicFreeTrialLength and bool1 then getFreeTrialOffer(var2) else nil

    if freeTrialOffer == nil or not isSupportedTrialPeriodType(freeTrialOffer.PeriodType) then
        freeTrialOffer = nil
    end

    local trialDuration = if freeTrialOffer then freeTrialOffer.Duration else 1

    local tbl2 = { periodType = periodTypeDisplayLabel }
    if freeTrialOffer then
        tbl2.trialPeriodLabel = getPeriodTypeDisplayLabel(freeTrialOffer.PeriodType, trialDuration > 1)
    end
    local var4 = useLocalization(tbl2)

    local var5 = useLocalization({
        price = {
            "Feature.RobloxSubscription.Label.BlackbirdPriceTag",
            price = localizedPriceDisplayString or "",
            periodType = var4.periodType
        },
        freeTrialPrice = {
            "Feature.RobloxSubscription.Label.RobloxPlusPriceRowV2",
            boldStart = "<b>",
            boldEnd = "</b>",
            price = localizedPriceDisplayString or "",
            periodType = var4.periodType
        },
        freeTrialPriceV3 = freeTrialOffer
            and {
                "Feature.RobloxSubscription.Label.RobloxPlusPriceRowV3",
                boldStart = "<b>",
                boldEnd = "</b>",
                price = localizedPriceDisplayString or "",
                periodType = var4.periodType,
                trialDuration = trialDuration,
                trialPeriodLabel = var4.trialPeriodLabel
            }
            or nil
    })

    if not (localizedPriceDisplayString and periodType) then
        return nil
    end

    local var6 = if freeTrialOffer then var5.freeTrialPriceV3 else var5.freeTrialPrice

    if not bool1 then
        var6 = var5.price
    end
    return React.createElement(
        View,
        {
            tag = "row auto-y size-full-0 align-y-center align-x-left gap-small",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Price = React.createElement(FoundationText, {
                Text = var6,
                tag = "size-full-0 auto-y text-title-medium content-emphasis text-align-x-left",
                RichText = if bool1 then true else nil
            })
        }
    )
end
return RobloxSubscriptionPriceRow
