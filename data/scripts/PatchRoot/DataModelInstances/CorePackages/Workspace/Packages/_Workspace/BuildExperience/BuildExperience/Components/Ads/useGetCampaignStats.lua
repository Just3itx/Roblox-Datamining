-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local CampaignStats = require(BuildExperienceParent.DataHydration.CampaignStats)

local useSignalState = SignalsReact.useSignalState
local createComputed = Signals.createComputed

local tbl1 = { plays = false, adClicks = false, adViews = false, playtimeSeconds = false }

local computed = createComputed(function()
    return nil
end)
local computed2 = createComputed(function(): string
    return "NotReady"
end)

local function hasFailedMetric(arg1)
    if arg1 == nil then
        return false
    end
    local failedMetrics = arg1.failedMetrics
    return failedMetrics.plays or failedMetrics.adClicks or failedMetrics.adViews or failedMetrics.playtimeSeconds
end

local function useGetCampaignStats(universeId: number?, arg1)
    local store = arg1 or CampaignStats.getCampaignStatsStore(false)
    local bool1 = not (universeId == nil) and universeId ~= 0
    local var2 = React.useRef(nil)
    local var3 = nil
    if bool1 then
        local current = var2.current
        if current == nil or current.store ~= store or current.universeId ~= universeId then
            var3 = hasFailedMetric
            var2.current = { store = store, universeId = universeId }
        end
    else
        var2.current = nil
    end

    local andFetchCampaignStats = if bool1 then store.getAndFetchCampaignStats(universeId, var3) else nil
    local var4 = useSignalState(if andFetchCampaignStats ~= nil then andFetchCampaignStats.data else computed)
    local var5 = useSignalState(if andFetchCampaignStats ~= nil then andFetchCampaignStats.status else computed2)
    local byCampaign = if var4 == nil then nil else var4.byCampaign

    if var4 ~= nil then
        return byCampaign, var5, var4.failedMetrics
    end

    return byCampaign, var5, tbl1
end

return useGetCampaignStats
