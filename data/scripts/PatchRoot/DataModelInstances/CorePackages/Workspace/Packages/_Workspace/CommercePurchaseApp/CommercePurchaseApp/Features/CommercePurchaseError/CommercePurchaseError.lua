-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local React = require(CommercePurchaseAppParent.React)
local useScreenSize = require(CommercePurchaseAppParent.EconomyCommonCoreScriptHooks).useScreenSize
local useLocalization = require(CommercePurchaseAppParent.Localization).Hooks.useLocalization
local UIBlox = require(CommercePurchaseAppParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ErrorCodeEnum = require(CommercePurchaseApp.Enums.ErrorCodeEnum)
local FFlagAddCommerceErrors = require(CommercePurchaseApp.Flags.FFlagAddCommerceErrors)

local tbl1 = {
    [ErrorCodeEnum.NotPurchasable] = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.NotPurchasable"
}

local tbl2 = {
    [ErrorCodeEnum.NotPurchasable] = {
        title = "CoreScripts.CommercePurchasePrompt.ProductNotAvailable",
        reason = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.NotPurchasable"
    },
    [ErrorCodeEnum.DeviceNotSupported] = {
        title = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.Title.DeviceNotSupported",
        reason = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.Body.DeviceNotSupported"
    },
    [ErrorCodeEnum.AccountNotSupported] = {
        title = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.Title.AccountNotSupported",
        reason = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.Body.AccountNotSupported"
    }
}

local function CommercePurchaseError(tbl3)
    local screenSize = useScreenSize()
    local var2 = useLocalization({
        title = if FFlagAddCommerceErrors then tbl2[tbl3.errorCode].title else "CoreScripts.CommercePurchasePrompt.ErrorPrompt.CantBuy",
        errorReason = if FFlagAddCommerceErrors then tbl2[tbl3.errorCode].reason else tbl1[tbl3.errorCode],
        dismissCTA = "CoreScripts.CommercePurchasePrompt.ErrorPrompt.DismissCTA"
    })

    return React.createElement(InteractiveAlert, {
        title = var2.title,
        titleIcon = Images["icons/status/error_large"],
        bodyText = var2.errorReason,
        buttonStackInfo = {
            buttons = {{
                props = {
                    onActivated = tbl3.onDismiss,
                    text = var2.dismissCTA
                },
                isDefaultChild = true
            }}
        },
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize
    })
end

return CommercePurchaseError
