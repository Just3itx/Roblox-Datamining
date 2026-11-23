-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)

local function getEligibility(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return UniverseActivation.getUniverseActivationStore().getAndFetchEligibility(num1).data()
end

return {
    isSealBroken = function(num1: number): boolean
        local eligibility = getEligibility(num1)

        return not (eligibility == nil) and eligibility.provisionalRatingAllowed ~= true
    end,
    isContentUnrated = function(num1: number): boolean
        local eligibility = getEligibility(num1)

        return not (eligibility == nil) and eligibility.maturityRated ~= true
    end
}
