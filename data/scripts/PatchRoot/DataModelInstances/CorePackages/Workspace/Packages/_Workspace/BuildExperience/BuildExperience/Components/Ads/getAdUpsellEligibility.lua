-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)

local adCampaignEligibilityUtils = require(script.Parent.adCampaignEligibilityUtils)

local tbl1 = { isEligible = false, freePromotionsRemaining = 0, isResolved = true }

local tbl2 = { isEligible = false, freePromotionsRemaining = 0, isResolved = false }

local function getAdUpsellEligibility(num1: number?, arg1)
    if num1 == nil or num1 == 0 then
        return tbl1
    end

    local var1 = (arg1 or AdCampaignEligibility.getAdCampaignEligibilityStore(false)).getAndFetchEligibility(num1)
    if var1.status(false) ~= "Ready" then
        return tbl2
    end

    local var2 = var1.data(false)
    return if adCampaignEligibilityUtils.isEligibleForFreePromotion(var2) then {
        isEligible = true,
        freePromotionsRemaining = adCampaignEligibilityUtils.freeCreditsRemaining(var2),
        isResolved = true
    } else tbl1
end

return getAdUpsellEligibility
