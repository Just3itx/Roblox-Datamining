-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local adCampaignEligibilityUtils = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils)
local adUpsellVisibilityUtils = require(BuildExperience.Components.Ads.AdUpsellMilestone.adUpsellVisibilityUtils)
local GetAgentAdCampaignStore = require(BuildExperience.Stores.GetAgentAdCampaignStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildAgentAdCampaignToolCallStatusFallback = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignToolCallStatusFallback)
local useAgentAdCampaignToolCallStatusFallback = require(script.Parent.useAgentAdCampaignToolCallStatusFallback)
local FFlagBuildAgentAdCampaignRefreshEligibility = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignRefreshEligibility)

local function useAgentAdCampaignTurnCards(tbl1, num1: number?)
    local var1 = React.useRef({})
    local var2 = React.useMemo(function()
        local states = {}
        local missing = {}
        for _, segment in tbl1.segments do
            if segment.kind ~= "agent_ad_campaign_card" then
                continue
            end

            local cardState = if tbl1.getCardState == nil then nil else tbl1.getCardState(segment.toolCallId)

            if cardState ~= nil then
                states[segment.toolCallId] = cardState
            end

            local bool1 = if FFlagBuildAgentAdCampaignRefreshEligibility then cardState == nil or cardState.campaignId == nil else cardState == nil

            if bool1 and segment.shouldCheckCampaignStatus then
                table.insert(missing, segment.toolCallId)
            end
        end

        return { states = states, missing = missing }
    end, { tbl1.segments, tbl1.getCardState })
    local states = var2.states
    local missing = var2.missing
    local var3 = nil
    if FFlagBuildAgentAdCampaignToolCallStatusFallback then
        table.sort(missing)

        var3 = useAgentAdCampaignToolCallStatusFallback(missing, num1)
    end
    local var4 = React.useMemo(function()
        local result = ({})
        for _, segment in tbl1.segments do
            if segment.kind ~= "agent_ad_campaign_card" then
                continue
            end

            local toolCallId = segment.toolCallId
            local var4 = states[toolCallId]

            if not var4 then
                if var3 ~= nil then
                    var4 = var3.cardStates[toolCallId]
                else
                    var4 = nil
                end
            end

            if FFlagBuildAgentAdCampaignRefreshEligibility and var4 ~= nil and var4.campaignId == nil and var3 ~= nil then
                var4 = var3.cardStates[toolCallId] or var4
            end

            local isPending = not (var3 == nil) and var3.pendingToolCallIds[toolCallId] == true
            local defaultOffer = if segment.offers == nil then nil else adCampaignEligibilityUtils.getDefaultOffer(segment.offers)
            local fundingType = if defaultOffer == nil then "paid" else defaultOffer.fundingType
            local isCreateDisabled = tbl1.onOfferSelected == nil
                or tbl1.isPageVisible == false
                or isPending
                or not (tbl1.isCreateDisabled == nil) and tbl1.isCreateDisabled(toolCallId)
            var1.current[toolCallId] = var1.current[toolCallId] or React.createRef()
            local tbl2 = {
                state = var4,
                isPending = isPending,
                fundingType = fundingType,
                isCreateDisabled = isCreateDisabled,
                cardRef = var1.current[toolCallId],
                onCreate = 0
            }

            function tbl2.onCreate()
                local bool2 = if FFlagBuildAgentAdCampaignRefreshEligibility then not (var4 == nil) and var4.campaignId ~= nil else var4 ~= nil

                if isCreateDisabled or bool2 or segment.offers == nil or tbl1.onOfferSelected == nil then
                    return
                end
                sendBuildExperienceEvent(
                    "AD_UPSELL_CREATE_CLICK",
                    {
                        universeId = tbl1.universeId,
                        conversationId = tbl1.sessionId
                    },
                    { context = "agent_card", toolCallId = toolCallId, fundingType = fundingType }
                )

                tbl1.onOfferSelected(toolCallId, segment.offers)
            end

            result[toolCallId] = tbl2
        end

        return result
    end, {
        tbl1.segments,
        tbl1.onOfferSelected,
        tbl1.isPageVisible,
        tbl1.isCreateDisabled,
        tbl1.universeId,
        tbl1.sessionId,
        states,
        var3
    })

    React.useEffect(function()
        local current = if tbl1.scrollingFrameRef == nil then nil else tbl1.scrollingFrameRef.current

        if tbl1.isPageVisible ~= true or tbl1.sessionId == nil or current == nil then
            return
        end

        local tbl2 = {}
        local agentAdCampaignStore = GetAgentAdCampaignStore(false)
        for _, segment in tbl1.segments do
            if segment.kind ~= "agent_ad_campaign_card" or segment.offers == nil then
                continue
            end

            local var5 = var4[segment.toolCallId]
            local current2 = var5.cardRef.current
            if var5.state ~= nil or var5.isPending or current2 == nil then
                continue
            end

            local function reportIfVisible()
                if not current2:IsDescendantOf(current)
                    or not adUpsellVisibilityUtils.isCardVisibleInScrollViewport(current, current2)
                    or not agentAdCampaignStore.markImpressed(tbl1.sessionId, segment.toolCallId)
                then
                    return
                end
                sendBuildExperienceEvent(
                    "AD_UPSELL_IMPRESSION",
                    {
                        universeId = tbl1.universeId,
                        conversationId = tbl1.sessionId
                    },
                    {
                        context = "agent_card",
                        toolCallId = segment.toolCallId,
                        fundingType = var5.fundingType
                    }
                )
            end

            for _, value in { "CanvasPosition", "AbsolutePosition", "AbsoluteWindowSize" } do
                local var6 = current:GetPropertyChangedSignal(value)
                table.insert(tbl2, var6:Connect(reportIfVisible))
            end
            for _, value in { "AbsolutePosition", "AbsoluteSize" } do
                local var6 = current2:GetPropertyChangedSignal(value)
                table.insert(tbl2, var6:Connect(reportIfVisible))
            end
            reportIfVisible()
        end
        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {
        tbl1.scrollingFrameRef,
        tbl1.isPageVisible,
        tbl1.sessionId,
        tbl1.universeId,
        tbl1.segments,
        var4
    })
    return var4
end

return useAgentAdCampaignTurnCards
