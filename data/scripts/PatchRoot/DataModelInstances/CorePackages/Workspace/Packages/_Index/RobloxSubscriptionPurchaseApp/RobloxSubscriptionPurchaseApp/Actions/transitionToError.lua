-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local HttpService = game:GetService("HttpService")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local logSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.logSubscriptionPurchaseFlowEvent)

local FFlagEnableSubscriptionPurchaseFlowEventIngest = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableSubscriptionPurchaseFlowEventIngest)
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)
local FFlagPlusMembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusMembershipConfigChangeCheck
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local _ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local RobloxPlusSheetKind = require(RobloxSubscriptionPurchaseApp.Enums.RobloxPlusSheetKind)
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)
local RobloxSubscriptionLogger = require(RobloxSubscriptionPurchaseApp.Utils.RobloxSubscriptionLogger)

function transitionToError(arg1, originalContext: string)
    local var1 = RobloxSubscriptionStore.get()
    var1.setErrorReason(arg1)
    var1.setPromptState(PromptState.Error)
    local purchaseUiOptions = if FFlagTTOnboardingSheet then var1.getPurchaseUIOptions() else nil
    RobloxSubscriptionLogger.debug({
        message = "Transitioning to error state",
        errorReason = tostring(arg1),
        originalContext = originalContext or "Unknown"
    })

    logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionPurchaseErrorShownCounter)

    if not FFlagEnableSubscriptionPurchaseFlowEventIngest then
        return
    end

    local var2 = logSubscriptionPurchaseFlowEvent
    local str1 = "SubscriptionPurchaseErrorShown"
    local tbl1 = { event_metadata = 0 }
    local httpService = HttpService
    local input = {
        error_reason = tostring(arg1),
        original_context = originalContext or "",
        sheet_kind = if FFlagTTOnboardingSheet and purchaseUiOptions and purchaseUiOptions.sheetKind == RobloxPlusSheetKind.TT then RobloxPlusSheetKind.TT else nil,
        include_upgrades = if FFlagPlusMembershipConfigChangeCheck and var1.getPurchaseFlowOptions().includeUpgrades == true then true else nil
    }
    tbl1.event_metadata = httpService:JSONEncode(input)
    var2(str1, tbl1)
end

return transitionToError
