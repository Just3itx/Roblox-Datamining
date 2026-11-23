-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local AdCampaigns = require(BuildExperienceParent.DataHydration.AdCampaigns)
local CampaignStats = require(BuildExperienceParent.DataHydration.CampaignStats)
local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)

local useSignalState = SignalsReact.useSignalState

local computed = Signals.createComputed(function(): string
    return "NotReady"
end)
local computed2 = Signals.createComputed(function()
    return nil
end)

local function useRefreshAdsData(current: number?, tbl1)
    local tbl2 = tbl1 or {}
    local bool1 = tbl2.includeEligibility == true
    local bool2 = not (current == nil) and current ~= 0
    local adCampaignsStore = tbl2.adCampaignsStore or AdCampaigns.getAdCampaignsStore(false)
    local campaignStatsStore = tbl2.campaignStatsStore or CampaignStats.getCampaignStatsStore(false)

    local var1 = React.useRef(false)
    local var2 = React.useRef(nil)
    local adCampaignEligibilityStore = if bool1 then tbl2.adCampaignEligibilityStore or AdCampaignEligibility.getAdCampaignEligibilityStore(false) else nil
    local adCampaigns = adCampaignsStore.getAdCampaigns()
    local campaignStats = if bool2 then campaignStatsStore.getCampaignStats(current) else nil
    local var3 = useSignalState(adCampaigns.status)
    local var4 = useSignalState(adCampaigns.data)

    local var5 = useSignalState(if campaignStats ~= nil then campaignStats.status else computed)

    local var6 = useSignalState(if campaignStats ~= nil then campaignStats.data else computed2)
    local var7 = React.useCallback(function()
        var1.current = adCampaignsStore.isAdCampaignsRequestInQueueOrInFlight()
        adCampaignsStore.fetchAdCampaigns()

        if bool2 and campaignStats ~= nil then
            local var7 = var2
            var7.current = if campaignStatsStore.isCampaignStatsRequestInQueueOrInFlight(current) then current else nil

            campaignStatsStore.fetchCampaignStats(current)
        else
            var2.current = nil
        end

        if adCampaignEligibilityStore ~= nil and bool2 then
            adCampaignEligibilityStore.fetchEligibility(current)
        end
    end, {
        current,
        bool2,
        adCampaignsStore,
        campaignStatsStore,
        adCampaignEligibilityStore,
        adCampaigns,
        campaignStats
    })

    React.useEffect(function()
        if var1.current and not adCampaignsStore.isAdCampaignsRequestInQueueOrInFlight() then
            var1.current = false
            adCampaignsStore.fetchAdCampaigns()
        end
    end, { var4, var3, adCampaignsStore })

    React.useEffect(function()
        if current ~= nil and var2.current == current and not campaignStatsStore.isCampaignStatsRequestInQueueOrInFlight(current) then
            var2.current = nil
            campaignStatsStore.fetchCampaignStats(current)
        end
    end, {
        current,
        var6,
        var5,
        campaignStatsStore
    })
    return var7
end

return useRefreshAdsData
