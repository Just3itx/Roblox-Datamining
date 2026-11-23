-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)

local useSignalState = SignalsReact.useSignalState
local createComputed = Signals.createComputed

local computed = createComputed(function()
    return nil
end)
local computed2 = createComputed(function(): string
    return "NotReady"
end)

local function useGetAdCampaignEligibility(num1: number?, arg1)
    local var1 = if not (num1 == nil) and num1 ~= 0 then arg1 or AdCampaignEligibility.getAdCampaignEligibilityStore(false) else nil
    local andFetchEligibility = if var1 == nil then nil else var1.getAndFetchEligibility(num1)
    local var2 = useSignalState(if andFetchEligibility ~= nil then andFetchEligibility.data else computed)
    local var3 = useSignalState(if andFetchEligibility ~= nil then andFetchEligibility.status else computed2)

    if var3 ~= "Ready" then
        var2 = nil
    end

    return var2, var3
end

return useGetAdCampaignEligibility
