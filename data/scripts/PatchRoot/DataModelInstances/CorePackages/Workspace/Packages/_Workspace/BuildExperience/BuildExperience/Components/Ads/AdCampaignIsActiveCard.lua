-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function AdCampaignIsActiveCard(tbl1)
    local variant = tbl1.variant or "active"
    local bool1 = not (tbl1.campaignStartDate == nil or tbl1.campaignStartDate == "" or tbl1.campaignEndDate == nil)
        and tbl1.campaignEndDate ~= ""
    local title = if variant == "complete" then LocalizationStrings.AD_CAMPAIGN_CARD_TITLE_COMPLETE else LocalizationStrings.AD_CAMPAIGN_CARD_TITLE_ACTIVE
    local var2 = if variant == "complete" then LocalizationStrings.AD_CAMPAIGN_CARD_DESC_COMPLETE else LocalizationStrings.AD_CAMPAIGN_CARD_ACTIVE_DESC
    local var3 = useLocalization({
        title = title,
        description = {
            var2,
            startDate = tbl1.campaignStartDate or "",
            endDate = tbl1.campaignEndDate or ""
        },
        view = LocalizationStrings.AD_CAMPAIGN_CARD_VIEW
    })

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-default radius-large bg-surface-0",
        testId = "AdCampaignIsActiveCard"
    }

    local tbl3 = {
        Content = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-xxsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var3.title,
                tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
            }),
            Description = if variant == "complete" or bool1 then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var3.description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis",
                testId = "AdCampaignIsActiveCard.Schedule"
            }) else nil
        }),
        Action = React.createElement(Button, {
            LayoutOrder = 2,
            text = var3.view,
            size = InputSize.Small,
            variant = ButtonVariant.Standard,
            width = UDim.new(1, 0),
            isDisabled = tbl1.isDisabled == true,
            onActivated = tbl1.onActivated,
            testId = "AdCampaignIsActiveCard.Action"
        })
    }
    return createElement(var4, tbl2, tbl3)
end

return AdCampaignIsActiveCard
