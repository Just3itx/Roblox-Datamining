-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local HttpService = game:GetService("HttpService")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local FFlagEnablePlusReferralTelemetry = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnablePlusReferralTelemetry)
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local FFlagEnablePlusReferralEntrypointTelemetry = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralEntrypointTelemetry
local isRobloxSubscriptionProductFreeTrial = require(RobloxSubscriptionPurchaseApp.Utils.isRobloxSubscriptionProductFreeTrial)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local RobloxPlusSheetKind = require(RobloxSubscriptionPurchaseApp.Enums.RobloxPlusSheetKind)
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)
local FFlagPlusMembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusMembershipConfigChangeCheck

local function buildSubscriptionPurchaseFlowPayload(eventName: string)
    local var1 = RobloxSubscriptionStore.get()
    local entryContext = var1.getEntryContext()
    local robloxSubscriptionProduct = var1.getRobloxSubscriptionProduct()
    local paymentSessionId = var1.getPaymentSessionId()
    local purchaseUiOptions = if FFlagTTOnboardingSheet then var1.getPurchaseUIOptions() else nil
    local id, type

    if robloxSubscriptionProduct and robloxSubscriptionProduct.ProductKey then
        id = robloxSubscriptionProduct.ProductKey.Id or ""
        type = robloxSubscriptionProduct.ProductKey.Type or ""
    else
        id = ""
        type = ""
    end

    local localizedPriceDisplayString = robloxSubscriptionProduct and robloxSubscriptionProduct.LocalizedPriceDisplayString or ""

    local universeId = (entryContext.metadata or {}).universeId
    if universeId == nil then
        local gameId = game.GameId
        if gameId > 0 then
            universeId = gameId
        end
    end

    local surfaceName = entryContext.surfaceName
    local context = entryContext.context
    local clientSessionId = entryContext.clientSessionId
    local clientSessionIdType = if clientSessionId then clientSessionId.clientSessionIdType else nil
    local var2 = if clientSessionId then clientSessionId.clientSessionId else ""
    local tbl1 = {
        event_name = eventName,
        client_session_id_type = if clientSessionIdType == nil then "" else clientSessionIdType,
        client_session_id = var2,
        purchase_flow_uuid = var2,
        product_id = id,
        product_type = type,
        surface_name = if surfaceName == nil then "" else tostring(surfaceName),
        surface_context = if context == nil then "" else tostring(context),
        trial_status = isRobloxSubscriptionProductFreeTrial(robloxSubscriptionProduct),
        display_price = localizedPriceDisplayString,
        ingest_timestamp_milliseconds = DateTime.now().UnixTimestampMillis
    }

    if paymentSessionId ~= "" then
        tbl1.payment_session_id = paymentSessionId
    end

    if universeId ~= nil then
        tbl1.universe_id = universeId
    end

    if FFlagEnablePlusReferralTelemetry then
        local referrerId = var1.getReferrerId()
        if referrerId and referrerId > 0 then
            tbl1.referrer_id = tostring(referrerId)
        end
    end
    if FFlagEnablePlusReferralEntrypointTelemetry and entryContext.entrypoint then
        tbl1.entrypoint = entryContext.entrypoint
    end

    if FFlagTTOnboardingSheet and purchaseUiOptions and purchaseUiOptions.sheetKind == RobloxPlusSheetKind.TT then
        tbl1.event_metadata = HttpService:JSONEncode({ sheet_kind = purchaseUiOptions.sheetKind })
    end

    if FFlagPlusMembershipConfigChangeCheck and var1.getPurchaseFlowOptions().includeUpgrades == true then
        local input = not tbl1.event_metadata and {} or HttpService:JSONDecode(tbl1.event_metadata)

        input.include_upgrades = true
        tbl1.event_metadata = HttpService:JSONEncode(input)
    end

    return tbl1
end

return buildSubscriptionPurchaseFlowPayload
