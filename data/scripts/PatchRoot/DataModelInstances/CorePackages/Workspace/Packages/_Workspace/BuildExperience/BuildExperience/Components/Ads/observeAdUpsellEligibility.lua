-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)

local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)

local function observeAdUpsellEligibility(num1: number, callback: (...any) -> (...any), arg1)
    local var1 = (arg1 or AdCampaignEligibility.getAdCampaignEligibilityStore(false)).getAndFetchEligibility(num1)

    return Signals.createEffect(function(arg2)
        var1.data(arg2)
        var1.status(arg2)
        callback()
    end)
end

return observeAdUpsellEligibility
