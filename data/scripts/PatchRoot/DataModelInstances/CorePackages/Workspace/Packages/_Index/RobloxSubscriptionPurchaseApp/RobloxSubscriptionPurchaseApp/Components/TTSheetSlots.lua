-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local FoundationCloudAssets = require(RobloxSubscriptionPurchaseAppParent.FoundationCloudAssets)
local View = Foundation.View
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local IconName = Foundation.Enums.IconName
local FillBehavior = Foundation.Enums.FillBehavior
local ButtonVariant = Foundation.Enums.ButtonVariant
local _types = require(RobloxSubscriptionPurchaseApp.types)
local FeatureRow = require(script.Parent.FeatureRow)
local PlusHeroContent = require(script.Parent.PlusHeroContent)
local LegalDisclosure = require(script.Parent.LegalDisclosure)
local usePlaceholderLocalization = require(RobloxSubscriptionPurchaseApp.Hooks.usePlaceholderLocalization)
local CampaignLocalizations = require(RobloxSubscriptionPurchaseApp.Store.CampaignLocalizations)
if require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet) then
    FoundationCloudAssets.preloadAsset("pictograms/gift")
    FoundationCloudAssets.preloadAsset("pictograms/plus")
end

local tbl1 = {
    title = "Feature.RobloxSubscription.Heading.TTGrant",
    description = "Feature.RobloxSubscription.Description.TTGrant",
    ctaText = "Feature.RobloxSubscription.Action.TTClaim",
    benefitCustomize = "Feature.RobloxSubscription.Label.TTBenefitCustomize",
    benefitDiscount = "Feature.RobloxSubscription.Label.TTBenefitDiscount",
    benefitPrivateServer = "Feature.RobloxSubscription.Label.TTBenefitPrivateServer",
    benefitRobux = "Feature.RobloxSubscription.Label.TTBenefitRobux"
}

local tbl2 = {
    {
        iconName = IconName.PaintBrush,
        stringName = "benefitCustomize"
    },
    {
        iconName = IconName.Tag,
        stringName = "benefitDiscount"
    },
    {
        iconName = IconName.Controller,
        stringName = "benefitPrivateServer"
    },
    {
        iconName = IconName.Robux,
        stringName = "benefitRobux"
    }
}

local function useTTSheetSlots(tbl3)
    local var1 = usePlaceholderLocalization(tbl1)
    local featureRobloxSubscriptionDisclosureTtClaimTerms = SignalsReact.useSignalState(CampaignLocalizations.getCampaignLocalizations)["Feature.RobloxSubscription.Disclosure.TTClaimTerms"]
    local purchaseUiOptions = tbl3.purchaseUIOptions

    local ctaText = purchaseUiOptions.ctaText or var1.ctaText

    local tbl4 = ({})
    for layoutOrder, value2 in tbl2 do
        local str1 = `Benefit{layoutOrder}`
        tbl4[str1] = React.createElement(
            FeatureRow,
            {
                layoutOrder = layoutOrder,
                iconName = value2.iconName,
                text = var1[value2.stringName]
            }
        )
    end
    local tbl5 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }),
        Content = React.createElement(Sheet.Content, nil, {
            Body = React.createElement(View, { tag = "col gap-large size-full-0 auto-y" }, {
                Hero = React.createElement(PlusHeroContent, {
                    layoutOrder = 1,
                    pictogram = FoundationCloudAssets.Assets["pictograms/gift"],
                    accentPictogram = FoundationCloudAssets.Assets["pictograms/plus"],
                    title = purchaseUiOptions.title or var1.title,
                    subtitle = purchaseUiOptions.description or var1.description
                }),
                Benefits = React.createElement(View, { LayoutOrder = 2, tag = "col align-x-left gap-small size-full-0 auto-y" }, tbl4)
            })
        }),
        Actions = 0
    }

    local createElement = React.createElement
    local actions = Sheet.Actions
    local var2 = nil
    local tbl6 = {
        ActionsContainer = React.createElement(
            View,
            { LayoutOrder = 1, tag = "row wrap align-x-center gap-medium size-full-0 auto-xy" },
            {
                Claim = React.createElement(Button, {
                    LayoutOrder = 1,
                    ref = tbl3.onButtonMounted,
                    text = ctaText,
                    onActivated = tbl3.onActivated,
                    isLoading = tbl3.isLoading,
                    fillBehavior = FillBehavior.Fill,
                    variant = ButtonVariant.Emphasis,
                    testId = "BlackbirdSheet--tt-claim"
                }),
                LegalDisclosure = if featureRobloxSubscriptionDisclosureTtClaimTerms and featureRobloxSubscriptionDisclosureTtClaimTerms ~= "" then React.createElement(
                    LegalDisclosure,
                    {
                        layoutOrder = 2,
                        ctaText = ctaText,
                        textTemplate = featureRobloxSubscriptionDisclosureTtClaimTerms
                    }
                ) else nil
            }
        )
    }
    tbl5.Actions = createElement(actions, var2, tbl6)
    return tbl5
end

return useTTSheetSlots
