-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local handleBackButtonAction = require(RobloxSubscriptionPurchaseApp.Actions.handleBackButtonAction)
local View = Foundation.View
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local Button = Foundation.Button
local getIconRichText = Foundation.Utility.getIconRichText
local Enums = Foundation.Enums
local IconName = Enums.IconName
local FillBehavior = Enums.FillBehavior
local ButtonVariant = Enums.ButtonVariant
local _types = require(RobloxSubscriptionPurchaseApp.types)
local RobloxSubscriptionPriceRow = require(script.Parent.RobloxSubscriptionPriceRow)
local RobloxSubscriptionFeatureList = require(script.Parent.RobloxSubscriptionFeatureList)
local LegalDisclosure = require(script.Parent.LegalDisclosure)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local performRobloxSubscriptionPurchase = require(RobloxSubscriptionPurchaseApp.Actions.performRobloxSubscriptionPurchase)
local finalizeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.finalizeRobloxSubscriptionUpsellFlow)
local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)
local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local logSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.logSubscriptionPurchaseFlowEvent)

local FFlagEnableSubscriptionPurchaseFlowEventIngest = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableSubscriptionPurchaseFlowEventIngest)
local isRobloxSubscriptionProductFreeTrial = require(RobloxSubscriptionPurchaseApp.Utils.isRobloxSubscriptionProductFreeTrial)
local getFreeTrialOffer = require(RobloxSubscriptionPurchaseApp.Utils.getFreeTrialOffer)
local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local FFlagSupportFreeTrial = require(RobloxSubscriptionPurchaseApp.Flags.FFlagSupportFreeTrial)
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet
local FIntPlusReferralRewardRobux = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FIntPlusReferralRewardRobux
local useReferrerName = require(RobloxSubscriptionPurchaseApp.Hooks.useReferrerName)
local PlusHeroContent = require(script.Parent.PlusHeroContent)
local FoundationCloudAssets = require(RobloxSubscriptionPurchaseAppParent.FoundationCloudAssets)
local pictogramsPlus_robux = FoundationCloudAssets.Assets["pictograms/plus_robux"]
FoundationCloudAssets.preloadAsset("pictograms/plus_robux")
local FFlagRobloxPlusDynamicFreeTrialLength = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusDynamicFreeTrialLength)
local FFlagEnablePlusReferralLegalDisclosure = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnablePlusReferralLegalDisclosure)
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)
local RobloxPlusSheetKind = require(RobloxSubscriptionPurchaseApp.Enums.RobloxPlusSheetKind)
local TTSheetSlots = require(script.Parent.TTSheetSlots)
local GuiService = game:GetService("GuiService")

local tbl1 = {
    [PromptState.SubscriptionPurchaseInProgress] = true,
    [PromptState.SubscriptionStatusPolling] = true
}

local function useBlackbirdSheetSlots()
    local var1 = RobloxSubscriptionStore.get()
    local onCtaOverride = var1.getOnCtaOverride()

    local purchaseUiOptions = SignalsReact.useSignalState(var1.getPurchaseUIOptions)
    local var3 = SignalsReact.useSignalState(var1.getPromptState)
    local var4 = if FFlagEnablePlusReferralLandingSheet then SignalsReact.useSignalState(var1.getReferrerId) else nil
    local username = if FFlagEnablePlusReferralLandingSheet then useReferrerName(var4) else nil
    local var6 = useLocalization({
        title = "Feature.RobloxSubscription.Title.GetBlackbird",
        buttonText = "Feature.RobloxSubscription.Action.Subscribe",
        getFreeTrialText = "Feature.RobloxSubscription.Action.TryItForFree",
        referralTitle = if FFlagEnablePlusReferralLandingSheet then "Feature.RobloxSubscription.Heading.ReferralRecipientJoin" else nil,
        referralInvite = FFlagEnablePlusReferralLandingSheet
            and {
                "Feature.RobloxSubscription.Description.ReferralRecipientInvite",
                username = username or "",
                amount = tostring(FIntPlusReferralRewardRobux)
            }
            or nil
    })

    local var7 = SignalsReact.useSignalState(var1.getRobloxSubscriptionProduct)
    local var8 = isRobloxSubscriptionProductFreeTrial(var7)
    local freeTrialOffer = if FFlagRobloxPlusDynamicFreeTrialLength then getFreeTrialOffer(var7) else nil
    local referralInvite = if FFlagEnablePlusReferralLandingSheet and username and username ~= "" then var6.referralInvite else nil
    local var9 = if purchaseUiOptions.description then purchaseUiOptions.description elseif FFlagEnablePlusReferralLandingSheet then referralInvite or nil else nil
    local var10 = if var8 then var6.getFreeTrialText else var6.buttonText
    local var11 = purchaseUiOptions.showLegalDisclosure == nil or purchaseUiOptions.showLegalDisclosure
    local noPurchaseMethodRequired = not (purchaseUiOptions.noPurchaseMethodRequired == nil) and purchaseUiOptions.noPurchaseMethodRequired

    local var12 = React.useCallback(function(arg1)
        if not arg1 then
            return
        end

        if FFlagEnableSubscriptionPurchaseFlowEventIngest then
            logSubscriptionPurchaseFlowEvent("SubscriptionUpsellModalShown")
        end
        logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellModalShownCounter)
    end, {})

    local function onSubscribe()
        if FFlagEnableSubscriptionPurchaseFlowEventIngest then
            logSubscriptionPurchaseFlowEvent("SubscriptionUpsellSubscribeClicked")
        end
        logRobloxSubscriptionUpsellCounter(
            RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellModalBuyButtonClickedCounter
        )

        if not onCtaOverride then
            performRobloxSubscriptionPurchase()
            return
        end

        var1.setPromptState(PromptState.SubscriptionPurchaseRequested)
        onCtaOverride(function()
            var1.setDidTryPurchasing(true)
            finalizeRobloxSubscriptionUpsellFlow(true)
        end, function()
            completeRobloxSubscriptionUpsellFlow()
        end)
    end

    local isLoading = tbl1[var3] == true
    local var13 = FFlagEnablePlusReferralLandingSheet and referralInvite ~= nil
    local bool2 = if FFlagEnablePlusReferralLandingSheet then GuiService.ViewportDisplaySize ~= Enum.DisplaySize.Small else false
    local var14 = if FFlagTTOnboardingSheet then TTSheetSlots(
        {
            purchaseUIOptions = purchaseUiOptions,
            isLoading = isLoading,
            onActivated = onSubscribe,
            onButtonMounted = var12
        }
    ) else nil

    if var14 and purchaseUiOptions.sheetKind == RobloxPlusSheetKind.TT then
        return var14
    end

    local tbl2 = { Header = 0, Content = 0, Actions = 0 }
    local createElement = React.createElement
    local header = Sheet.Header
    local tbl3 = { hasCloseAffordance = true }

    local tbl4 = { View = 0 }
    local element

    if var13 then
        element = nil
    else
        element = React.createElement(View, { LayoutOrder = 1, tag = "row gap-small auto-xy" }, {
            BackButton = if purchaseUiOptions.showBackButton then React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = `{getIconRichText(IconName.ChevronLargeLeft)}`,
                tag = "gap-small auto-xy text-heading-small text-align-x-center content-emphasis",
                RichText = true,
                onActivated = handleBackButtonAction
            }) else nil,
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = `{getIconRichText(IconName.RobloxPlus)} {purchaseUiOptions.title or var6.title}`,
                tag = "auto-xy text-heading-small text-align-x-center content-emphasis",
                RichText = true
            })
        })
    end

    tbl4.View = element
    tbl2.Header = createElement(header, tbl3, tbl4)

    local createElement2 = React.createElement
    local content = Sheet.Content
    local tbl5 = { LayoutOrder = 2 }

    local tbl6 = {
        ContentContainer = React.createElement(View, {
            tag = if var13 and not bool2 then "col gap-xsmall size-full-0 auto-y padding-bottom-large" elseif var13 and bool2 then "col gap-xsmall size-full-0" elseif var9 == nil then "col" else "col size-full-0 auto-y",
            Size = if var13 and bool2 then UDim2.new(1, 0, 0, 300) elseif var13 or var9 ~= nil then nil else UDim2.new(1, 0, 0, 140)
        }, {
            HeroContent = if var13 then React.createElement(PlusHeroContent, {
                layoutOrder = 1,
                pictogram = pictogramsPlus_robux,
                title = `{var6.referralTitle} {getIconRichText(IconName.Robux)} {tostring(FIntPlusReferralRewardRobux)}`,
                titleRichText = true,
                subtitle = referralInvite
            }) else nil,
            PriceRow = if var13 then React.createElement(
                RobloxSubscriptionPriceRow,
                {
                    layoutOrder = if FFlagEnablePlusReferralLandingSheet then 4 else 1,
                    isFreeTrial = var8
                }
            ) elseif var9 ~= nil then React.createElement(FoundationText, {
                LayoutOrder = if FFlagEnablePlusReferralLandingSheet then 4 else 1,
                Text = var9,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
            }) else React.createElement(
                RobloxSubscriptionPriceRow,
                {
                    layoutOrder = if FFlagEnablePlusReferralLandingSheet then 4 else 1,
                    isFreeTrial = var8
                }
            ),
            FeatureList = React.createElement(RobloxSubscriptionFeatureList, {
                layoutOrder = if FFlagEnablePlusReferralLandingSheet then 5 else 2,
                noPurchaseMethodRequired = noPurchaseMethodRequired,
                compact = var13 and bool2
            })
        })
    }
    tbl2.Content = createElement2(content, tbl5, tbl6)

    local createElement3 = React.createElement
    local actions = Sheet.Actions
    local tbl7 = { LayoutOrder = 3 }

    local tbl8 = { ActionsContainer = 0 }
    local createElement4 = React.createElement
    local var15 = View
    local tbl9 = { LayoutOrder = 1, tag = "row wrap align-x-center gap-medium size-full-0 auto-xy" }

    local tbl10 = {
        SubscribeButton = React.createElement(Button, {
            LayoutOrder = 1,
            ref = var12,
            text = if purchaseUiOptions.ctaText then purchaseUiOptions.ctaText else var10,
            onActivated = onSubscribe,
            fillBehavior = FillBehavior.Fill,
            variant = ButtonVariant.Emphasis,
            isLoading = isLoading
        }),
        LegalDisclosure = 0
    }
    local var16

    if var11 then
        local createElement5 = React.createElement
        local var17 = LegalDisclosure
        local tbl11 = {
            layoutOrder = 2,
            ctaText = 0,
            isFreeTrial = 0,
            isReferral = 0,
            shortenFreeTrialTerms = 0,
            trialDuration = 0,
            trialPeriodType = 0,
            billingPeriodType = 0
        }
        if purchaseUiOptions.ctaText then
            var10 = purchaseUiOptions.ctaText
        end

        tbl11.ctaText = var10
        if not FFlagSupportFreeTrial then
            var8 = nil
        end

        tbl11.isFreeTrial = var8
        if not FFlagEnablePlusReferralLegalDisclosure then
            var13 = nil
        end

        tbl11.isReferral = var13
        tbl11.shortenFreeTrialTerms = noPurchaseMethodRequired
        tbl11.trialDuration = if freeTrialOffer then freeTrialOffer.Duration else nil
        tbl11.trialPeriodType = if freeTrialOffer then freeTrialOffer.PeriodType else nil
        tbl11.billingPeriodType = if freeTrialOffer and var7 then var7.PeriodType else nil
        var16 = createElement5(var17, tbl11)
    else
        var16 = nil
    end

    tbl10.LegalDisclosure = var16
    tbl8.ActionsContainer = createElement4(var15, tbl9, tbl10)
    tbl2.Actions = createElement3(actions, tbl7, tbl8)
    return tbl2
end

return useBlackbirdSheetSlots
