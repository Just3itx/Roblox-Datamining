-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useLocalization = require(BulkPurchaseAppParent.Localization).Hooks.useLocalization

local Foundation = require(BulkPurchaseAppParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local DiscountSummary = require(BulkPurchaseAppParent.IAPExperience).DiscountSummary

local BlackbirdUpsellBanner = require(BulkPurchaseAppParent.RobloxSubscriptionPurchaseApp).Components.BlackbirdUpsellBanner
local OfferExpiryBadge = require(BulkPurchaseAppParent.AvatarExperienceCommon).Components.OfferExpiryBadge
local useDiscountSummaryProps = require(BulkPurchaseApp.Hooks.useDiscountSummaryProps)

local PriceBoxLine = require(script.Parent.PriceBoxLine)
local PriceBoxLineVariantEnum = require(BulkPurchaseApp.Enums.PriceBoxLineVariantEnum)
local FFlagAddTimerToBulkPurchaseBuyButton = require(BulkPurchaseApp.Flags.FFlagAddTimerToBulkPurchaseBuyButton)
local FIntBulkPurchaseEnabledCountdownMS = require(BulkPurchaseApp.Flags.FIntBulkPurchaseEnabledCountdownMS)
local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)
local FFlagAXUpdateBulkPurchaseOfferExpiryBadge = require(BulkPurchaseApp.Flags.FFlagAXUpdateBulkPurchaseOfferExpiryBadge)
local FFlagBulkPurchaseTestPurchaseHint = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseTestPurchaseHint)

local tbl1 = {
    heading = "CoreScripts.BulkPurchasePrompt.RequestPrompt.PriceBox.TotalCost",
    currentBalanceLine = "CoreScripts.BulkPurchasePrompt.RequestPrompt.PriceBox.CurrentBalance",
    projectedBalanceLine = "CoreScripts.BulkPurchasePrompt.RequestPrompt.PriceBox.NewBalance",
    missingRobuxLine = "CoreScripts.BulkPurchasePrompt.RequestPrompt.PriceBox.MissingRobux",
    confirmCTA = "CoreScripts.BulkPurchasePrompt.RequestPrompt.PriceBox.ConfirmCTA",
    buyRobuxCTA = "CoreScripts.BulkPurchasePrompt.RequestPrompt.PriceBox.BuyRobuxCTA",
    testPurchaseDisclaimer = "IAPExperience.PurchasePrompt.Text.TestPurchase"
}

local _Types = require(BulkPurchaseApp.Store.Types)

local function PriceBox(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = useDiscountSummaryProps(
        tbl2.discountInformation,
        tbl2.totalCost,
        if FFlagAXAddOffersToBulkPurchase and tbl2.offerData then tbl2.offerData.savingsSummary else nil
    )
    local var3

    if FFlagAXAddOffersToBulkPurchase then
        local var4 = useTokens()
        var3 = React.useMemo(function()
            local result = ({})
            local offersAvailable = if tbl2.offerData then tbl2.offerData.offersAvailable else nil
            local toggleOfferSelected = tbl2.toggleOfferSelected
            if offersAvailable and toggleOfferSelected then
                for value, value2 in offersAvailable do
                    local var5 = "Offer_" .. value
                    local createElement = React.createElement
                    local str1 = "TextButton"
                    local tbl3 = {
                        Text = "",
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Selectable = false,
                        LayoutOrder = 0
                    }

                    tbl3[React.Event.Activated] = function()
                        toggleOfferSelected(value)
                    end

                    local tbl4 = { Content = 0 }
                    local createElement2 = React.createElement
                    local view = Foundation.View
                    local tbl5 = {
                        tag = "row gap-medium auto-xy align-y-center",
                        Position = UDim2.fromOffset(var4.Stroke.Standard, 0)
                    }
                    local tbl6 = { Checkbox = 0, Label = 0, ExpiryBadge = 0 }
                    local createElement3 = React.createElement
                    local checkbox = Foundation.Checkbox
                    local tbl7 = {
                        label = if FFlagAXUpdateBulkPurchaseOfferExpiryBadge then value2.localizedDescription else "",
                        isChecked = value2.selected,
                        onActivated = 0,
                        size = 0,
                        LayoutOrder = 1
                    }

                    function tbl7.onActivated()
                        toggleOfferSelected(value)
                    end
                    tbl7.size = Foundation.Enums.InputSize.Small
                    tbl6.Checkbox = createElement3(checkbox, tbl7)
                    local element = if FFlagAXUpdateBulkPurchaseOfferExpiryBadge then nil else React.createElement(Foundation.Text, {
                        Text = "<b>" .. value2.localizedDescription .. "</b>",
                        RichText = true,
                        tag = "text-body-small content-default auto-xy",
                        LayoutOrder = 2
                    })
                    tbl6.Label = element
                    local element2 = if FFlagAXUpdateBulkPurchaseOfferExpiryBadge and value2.expirationTimeUtc then React.createElement(OfferExpiryBadge, { layoutOrder = 2, expirationTimeInUTC = value2.expirationTimeUtc }) else nil
                    tbl6.ExpiryBadge = element2
                    tbl4.Content = createElement2(view, tbl5, tbl6)
                    result[var5] = createElement(str1, tbl3, tbl4)
                end
            end

            return result
        end, { tbl2.offerData, tbl2.toggleOfferSelected })
    else
        var3 = nil
    end

    local createElement = React.createElement
    local var4 = View
    local tbl3 = {
        tag = "col align-x-center gap-xxlarge size-full-0 auto-y padding-xxlarge radius-medium bg-surface-100"
    }
    local tbl4 = {
        LineItems = 0,
        PriceBoxConfirmButton = 0,
        BlackbirdUpsellBanner = 0,
        TestPurchaseDisclaimer = 0
    }
    local createElement2 = React.createElement
    local var5 = View
    local tbl5 = { LayoutOrder = 1, tag = "col gap-large size-full-0 auto-y" }

    local tbl6 = { BalanceLines = 0, OfferCheckboxes = 0, DiscountSummary = 0, PriceBoxHeader = 0 }
    local createElement3 = React.createElement
    local var6 = View
    local tbl7 = { LayoutOrder = 1, tag = "col gap-xsmall size-full-0 auto-y" }

    local tbl8 = {
        PriceBoxCurrentBalance = React.createElement(PriceBoxLine, { text = var1.currentBalanceLine, amount = tbl2.currentBalance, LayoutOrder = 1 }),
        PriceBoxProjectedBalance = React.createElement(PriceBoxLine, {
            text = if tbl2.missingRobux then var1.missingRobuxLine else var1.projectedBalanceLine,
            amount = math.abs(tbl2.totalCost - tbl2.currentBalance),
            variant = if tbl2.missingRobux then PriceBoxLineVariantEnum.Danger else nil,
            LayoutOrder = 2
        })
    }
    tbl6.BalanceLines = createElement3(var6, tbl7, tbl8)

    tbl6.OfferCheckboxes = if FFlagAXAddOffersToBulkPurchase and next(var3) ~= nil then React.createElement(
        Foundation.View,
        { tag = "col gap-medium size-full-0 auto-y padding-top-medium", LayoutOrder = 2 },
        var3
    ) else nil

    tbl6.DiscountSummary = if var2 then React.createElement(
        View,
        {
            LayoutOrder = if FFlagAXAddOffersToBulkPurchase then 3 else 2,
            tag = "size-full-0 auto-y"
        },
        {
            Content = React.createElement(DiscountSummary, var2)
        }
    ) else nil

    tbl6.PriceBoxHeader = React.createElement(PriceBoxLine, {
        text = var1.heading,
        amount = tbl2.totalCost,
        originalPrice = if tbl2.discountInformation then tbl2.discountInformation.originalPrice else nil,
        variant = PriceBoxLineVariantEnum.Highlight,
        LayoutOrder = if FFlagAXAddOffersToBulkPurchase then 4 else 3
    })
    tbl4.LineItems = createElement2(var5, tbl5, tbl6)

    tbl4.PriceBoxConfirmButton = React.createElement(Foundation.Button, {
        text = if tbl2.missingRobux then var1.buyRobuxCTA else var1.confirmCTA,
        onActivated = tbl2.onAccept or function() end,
        variant = Foundation.Enums.ButtonVariant.Emphasis,
        size = Foundation.Enums.InputSize.Medium,
        width = UDim.new(1, 0),
        ref = tbl2.buttonRef,
        isDisabled = tbl2.isDisabled,
        LayoutOrder = 2,
        inputDelay = if FFlagAddTimerToBulkPurchaseBuyButton then math.max(0, FIntBulkPurchaseEnabledCountdownMS) / 1000 else nil
    })

    tbl4.BlackbirdUpsellBanner = if FFlagAXAddPlusUpsellToBulkPurchase
        and tbl2.shouldShowBlackbirdUpsellBanner
        and tbl2.blackbirdUpsellBannerProductInfo
        and tbl2.onBlackbirdUpsellActivated then React.createElement(
        BlackbirdUpsellBanner,
        {
            productInfo = tbl2.blackbirdUpsellBannerProductInfo,
            onActivated = tbl2.onBlackbirdUpsellActivated,
            LayoutOrder = 3
        }
    ) else nil

    tbl4.TestPurchaseDisclaimer = if FFlagBulkPurchaseTestPurchaseHint and tbl2.isTestPurchase then React.createElement(
        Foundation.Text,
        {
            LayoutOrder = 4,
            Text = var1.testPurchaseDisclaimer,
            tag = "wrap size-full-0 auto-y text-caption-small text-wrap text-align-x-center"
        }
    ) else nil
    return createElement(var4, tbl3, tbl4)
end

return PriceBox
