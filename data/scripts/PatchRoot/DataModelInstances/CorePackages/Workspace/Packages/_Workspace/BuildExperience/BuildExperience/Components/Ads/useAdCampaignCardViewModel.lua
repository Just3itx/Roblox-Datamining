-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local useLocalization = Localization.Hooks.useLocalization
local ButtonVariant = Foundation.Enums.ButtonVariant

local function useAdCampaignCardViewModel(tbl1)
    local bool1 = tbl1.variant == "active"

    local startDate = if tbl1.campaignStartTime == nil then "" else LocalizationStrings.formatCampaignDate(tbl1.campaignStartTime)

    local endDate = if tbl1.campaignEndTime == nil then "" else LocalizationStrings.formatCampaignDate(tbl1.campaignEndTime)

    local var3 = useLocalization({
        titleFree = LocalizationStrings.AD_CAMPAIGN_CARD_TITLE_FREE,
        titleActive = LocalizationStrings.AD_CAMPAIGN_CARD_TITLE_ACTIVE,
        descFree = LocalizationStrings.AD_CAMPAIGN_CARD_DESC_FREE,
        activeDesc = {
            LocalizationStrings.AD_CAMPAIGN_CARD_ACTIVE_DESC,
            startDate = startDate,
            endDate = endDate
        },
        view = LocalizationStrings.AD_CAMPAIGN_CARD_VIEW
    })

    return {
        title = if bool1 then var3.titleActive else var3.titleFree,
        description = if bool1 then var3.activeDesc else var3.descFree,
        actionText = var3.view,
        buttonVariant = if bool1 then ButtonVariant.Standard else ButtonVariant.SoftEmphasis,
        isLoading = tbl1.isPrimaryPending == true,
        onActivated = tbl1.onPrimary
    }
end

return useAdCampaignCardViewModel
