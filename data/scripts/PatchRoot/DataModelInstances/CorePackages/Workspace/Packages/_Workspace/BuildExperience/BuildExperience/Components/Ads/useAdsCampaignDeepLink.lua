-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local FFlagBuildAdsNotificationRouting = require(BuildExperienceParent.SharedFlags).FFlagBuildAdsNotificationRouting
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local GetAdsCampaignDeepLinkStore = require(BuildExperience.Stores.GetAdsCampaignDeepLinkStore)
local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local function useAdsCampaignDeepLink(tbl1)
    local var1 = tbl1.requestStore or GetAdsCampaignDeepLinkStore(false)
    local var2 = tbl1.eligibilityStore or AdCampaignEligibility.getAdCampaignEligibilityStore(false)
    local var3 = tbl1.sendEvent or sendBuildExperienceEvent
    local var4 = React.useMemo(function()
        return var1.createChat()
    end, { var1 })
    local scopeRevision = SignalsReact.useSignalState(var4.getScopeRevision)
    local var6 = React.useRef(tbl1.onOpen)
    var6.current = tbl1.onOpen

    React.useEffect(function()
        if FFlagBuildAdsNotificationRouting then
            var4.updateScope(tbl1.universeId, tbl1.sessionId, tbl1.isPageVisible, tbl1.canPresent)
            return
        end
        var4.updateScope(tbl1.universeId, tbl1.sessionId, tbl1.isPageVisible)
    end, {
        var4,
        tbl1.universeId,
        tbl1.sessionId,
        tbl1.isPageVisible,
        tbl1.canPresent
    })
    React.useEffect(function()
        return var4.connect(var2, var3, function(arg1)
            return var6.current(arg1)
        end)
    end, { var4, var2, var3 })

    return React.useMemo(function()
        return {
            scopeRevision = scopeRevision,
            clearPresentedRequest = var4.clearPresentedRequest,
            getPresentedRequestId = var4.getPresentedRequestId,
            startCreate = var4.startCreate,
            finishCreate = var4.finishCreate
        }
    end, { var4, scopeRevision })
end

return useAdsCampaignDeepLink
