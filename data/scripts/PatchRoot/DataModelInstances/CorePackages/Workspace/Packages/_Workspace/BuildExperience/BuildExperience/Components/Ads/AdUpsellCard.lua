-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local FFlagBuildAgentAdCampaignRefreshEligibility = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignRefreshEligibility)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local ChatCardPriority = require(BuildExperience.Components.Chat.ChatCardEmphasis.ChatCardPriority)
local useChatCardEmphasis = require(BuildExperience.Components.Chat.ChatCardEmphasis.useChatCardEmphasis)

local Button = Foundation.Button
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function AdUpsellCard(tbl1)
    local var1 = Foundation.Hooks.useTokens()

    local var2 = useLocalization({
        title = LocalizationStrings.AD_UPSELL_CARD_TITLE,
        description = LocalizationStrings.AD_UPSELL_CARD_DESC,
        freeTitle = if FFlagBuildAgentAdCampaignCard then LocalizationStrings.AD_UPSELL_FREE_TITLE else nil,
        freeTitlePlural = FFlagBuildAgentAdCampaignCard
            and {
                LocalizationStrings.AD_UPSELL_FREE_TITLE_PLURAL,
                promotionCount = tbl1.freePromotionsRemaining
            }
            or nil,
        freeDescription = if FFlagBuildAgentAdCampaignCard then LocalizationStrings.AD_UPSELL_FREE_DESC else nil,
        noFreeTitle = if FFlagBuildAgentAdCampaignCard then LocalizationStrings.AD_UPSELL_NO_FREE_TITLE else nil,
        noFreeDescription = if FFlagBuildAgentAdCampaignCard then LocalizationStrings.AD_UPSELL_NO_FREE_DESC else nil,
        create = LocalizationStrings.AD_UPSELL_CARD_CREATE,
        dontShowAgain = LocalizationStrings.AD_UPSELL_CARD_DONT_SHOW_AGAIN,
        eligibilityError = if FFlagBuildAgentAdCampaignRefreshEligibility then if tbl1.eligibilityError == "unavailable" then LocalizationStrings.AD_CAMPAIGN_SHEET_FORBIDDEN_ERROR else LocalizationStrings.AD_CAMPAIGN_SHEET_INTERNAL_ERROR else nil
    })

    local title = var2.title
    local description = var2.description
    if FFlagBuildAgentAdCampaignCard then
        if tbl1.fundingType == "paid" then
            title = var2.noFreeTitle
            description = var2.noFreeDescription
        elseif tbl1.freePromotionsRemaining == 1 then
            title = var2.freeTitle
            description = var2.freeDescription
        elseif tbl1.freePromotionsRemaining > 0 then
            title = var2.freeTitlePlural
            description = var2.freeDescription
        else
            title = var2.noFreeTitle
            description = var2.noFreeDescription
        end
    end
    local create = var2.create
    local dontShowAgain = var2.dontShowAgain
    local var3 = if FFlagBuildExperienceChatCardEmphasis then useChatCardEmphasis(ChatCardPriority.AdUpsell, tbl1.emphasisOrder) else nil
    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.containerRef,
        tag = "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-default radius-large",
        testId = "AdUpsellCard"
    }

    local tbl3 = {
        Content = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-xxsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(View, {
                LayoutOrder = 1,
                tag = "row align-y-center gap-small size-full-0 auto-y"
            }, {
                Icon = React.createElement(
                    Icon,
                    {
                        LayoutOrder = 1,
                        name = IconName.Megaphone,
                        style = var1.Color.Content.Emphasis,
                        testId = "AdUpsellCard.Icon"
                    }
                ),
                Label = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 2,
                        Text = title,
                        tag = "fill auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
                    }
                )
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
            }),
            EligibilityError = if FFlagBuildAgentAdCampaignRefreshEligibility and tbl1.eligibilityError ~= nil then React.createElement(
                FoundationText,
                {
                    LayoutOrder = 3,
                    Text = var2.eligibilityError,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-alert",
                    testId = "AdUpsellCard.EligibilityError"
                }
            ) else nil
        }),
        Actions = 0
    }

    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = { LayoutOrder = 2, tag = "row gap-small size-full-0 auto-y" }

    local tbl5 = {
        Create = React.createElement(Button, {
            LayoutOrder = 1,
            text = create,
            size = InputSize.Small,
            variant = if var3 == true then ButtonVariant.Emphasis else ButtonVariant.SoftEmphasis,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            isLoading = tbl1.isCreatePending == true,
            isDisabled = (FFlagBuildAgentAdCampaignCard or FFlagBuildCheckGamePermissions) and tbl1.isCreateDisabled == true,
            onActivated = tbl1.onCreate,
            testId = "AdUpsellCard.Create"
        }),
        DontShowAgain = if FFlagBuildAgentAdCampaignCard and tbl1.onDismiss == nil then nil else React.createElement(Button, {
            LayoutOrder = 2,
            text = dontShowAgain,
            size = InputSize.Small,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            onActivated = tbl1.onDismiss,
            testId = "AdUpsellCard.DontShowAgain"
        })
    }
    tbl3.Actions = createElement2(var5, tbl4, tbl5)
    return createElement(var4, tbl2, tbl3)
end

return AdUpsellCard
