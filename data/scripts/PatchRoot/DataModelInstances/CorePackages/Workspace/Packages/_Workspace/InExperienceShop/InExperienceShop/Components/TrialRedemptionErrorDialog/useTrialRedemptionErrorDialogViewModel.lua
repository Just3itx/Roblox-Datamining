-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local SignalsReact = require(InExperienceShopParent.SignalsReact)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local initiateShopItemPurchase = require(InExperienceShop.initiateShopItemPurchase)
local getTrialRedemptionErrorKeys = require(script.Parent.getTrialRedemptionErrorKeys)
local _Types = require(InExperienceShop.Types)

local tbl1 = { FreeTrialAlreadyRedeemed = true, GamePassTrialNotEnabled = true }

local function useTrialRedemptionErrorDialogViewModel()
    local var1 = SignalsReact.useSignalState(getInExperienceShopStore)
    local var2 = SignalsReact.useSignalState(var1.getTrialRedemptionError)
    local errorCode = if var2 == nil then nil else var2.errorCode
    local trialRedemptionErrorKeys = getTrialRedemptionErrorKeys(errorCode)
    local var3 = useLocalization({
        title = trialRedemptionErrorKeys.title,
        body = trialRedemptionErrorKeys.body,
        okText = "CommonUI.Controls.Action.OK",
        buyText = "Feature.Catalog.Action.Buy"
    })

    if var2 == nil then
        return nil
    end

    local dismissTrialRedemptionError = var1.dismissTrialRedemptionError
    if errorCode == nil or not tbl1[errorCode] then
        return {
            title = var3.title,
            body = var3.body,
            actionText = var3.okText,
            onAction = dismissTrialRedemptionError,
            onClose = dismissTrialRedemptionError
        }
    end

    local gamePassId = var2.gamePassId
    local purchaseContext = var2.purchaseContext or {}
    return {
        title = var3.title,
        body = var3.body,
        actionText = var3.buyText,
        onAction = function()
            dismissTrialRedemptionError()
            initiateShopItemPurchase(gamePassId, "GamePass", purchaseContext.shopPageType, purchaseContext.categoryLocation)
        end,
        onClose = dismissTrialRedemptionError
    }
end

return useTrialRedemptionErrorDialogViewModel
