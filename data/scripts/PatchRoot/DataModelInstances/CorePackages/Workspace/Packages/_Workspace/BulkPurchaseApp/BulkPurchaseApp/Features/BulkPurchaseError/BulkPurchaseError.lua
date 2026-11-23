-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useLocalization = require(BulkPurchaseAppParent.Localization).Hooks.useLocalization
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel

local IAPExperience = require(BulkPurchaseAppParent.IAPExperience)
local formatEconomicRestrictionText = IAPExperience.Utility.formatEconomicRestrictionText
local addEconomicRestrictionKeysToLocalization = IAPExperience.Utility.addEconomicRestrictionKeysToLocalization

local AlertPrompt = require(BulkPurchaseApp.Components.AlertPrompt)
local ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)

local function BulkPurchaseErrorText(tbl1)
    local var1 = useDesignTokens()

    return React.createElement(StyledTextLabel, {
        size = UDim2.fromScale(1, 0),
        automaticSize = Enum.AutomaticSize.Y,
        fontStyle = var1.Typography.BodyLarge,
        colorStyle = var1.Color.Content.Default,
        textXAlignment = Enum.TextXAlignment.Center,
        text = tbl1.text,
        layoutOrder = tbl1.layoutOrder
    })
end

local tbl1 = {
    [ErrorCodeEnum.InsufficientRobux] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonInsufficientRobux",
    [ErrorCodeEnum.QuotaExceeded] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonQuotaExceeded",
    [ErrorCodeEnum.NotForSale] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonNotForSale",
    [ErrorCodeEnum.AlreadyOwned] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonAlreadyOwned",
    [ErrorCodeEnum.PurchaserIsSeller] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonPurchaserIsSeller",
    [ErrorCodeEnum.NotAvailableForPurchaser] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonNotAvailableForPurchaser",
    [ErrorCodeEnum.PriceMismatch] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonPriceMismatch",
    [ErrorCodeEnum.QuantityLimitExceeded] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonQuantityLimitExceeded",
    [ErrorCodeEnum.InsufficientMembership] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonInsufficientMembership",
    [ErrorCodeEnum.Generic] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonGeneric",
    [ErrorCodeEnum.SoldOut] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonSoldOut",
    [ErrorCodeEnum.TwoStepVerificationRequired] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReason2SV",
    [ErrorCodeEnum.PlaceInvalid] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.ErrorReasonNotAvailableInExperience"
}

local tbl2 = {
    [ErrorCodeEnum.InsufficientRobux] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainMoreRobux",
    [ErrorCodeEnum.QuotaExceeded] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainWait",
    [ErrorCodeEnum.NotForSale] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.AlreadyOwned] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.PurchaserIsSeller] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.NotAvailableForPurchaser] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.PriceMismatch] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainNow",
    [ErrorCodeEnum.QuantityLimitExceeded] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.InsufficientMembership] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.Generic] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainLater",
    [ErrorCodeEnum.SoldOut] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainNow",
    [ErrorCodeEnum.TwoStepVerificationRequired] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems",
    [ErrorCodeEnum.PlaceInvalid] = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorPrompt.TryAgainOtherItems"
}

local function BulkPurchaseError(tbl3)
    local var1 = useDesignTokens()

    local tbl4 = {
        title = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorHeading",
        errorReason = tbl1[tbl3.errorCode],
        tryAgain = tbl2[tbl3.errorCode],
        dismissCTA = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.DismissCTA"
    }

    addEconomicRestrictionKeysToLocalization(tbl4)
    local var2 = useLocalization(tbl4)
    if tbl3.errorCode == ErrorCodeEnum.EconomicRestriction and tbl3.errorMetadata then
        var2.errorReason = formatEconomicRestrictionText(var2, tbl3.errorMetadata, true)
    end

    return React.createElement(AlertPrompt, {
        title = var2.title,
        dismissCTA = var2.dismissCTA,
        onDismiss = tbl3.onDismiss,
        middleContent = function()
            return React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, 1),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                },
                {
                    Layout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        Padding = UDim.new(0, var1.Size.Size_400)
                    }),
                    ErrorReason = React.createElement(BulkPurchaseErrorText, { text = var2.errorReason, layoutOrder = 1 }),
                    TryAgain = if var2.tryAgain then React.createElement(BulkPurchaseErrorText, { text = var2.tryAgain, layoutOrder = 2 }) else nil
                }
            )
        end
    })
end

return BulkPurchaseError
