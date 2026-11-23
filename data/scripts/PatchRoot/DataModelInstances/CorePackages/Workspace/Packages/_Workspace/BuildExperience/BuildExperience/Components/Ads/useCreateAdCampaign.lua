-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local HttpService = game:GetService("HttpService")

local HttpClient = require(BuildExperienceParent.HttpClient)
local React = require(BuildExperienceParent.React)

local _AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)
local _AdCampaigns = require(BuildExperienceParent.DataHydration.AdCampaigns)
local _CampaignStats = require(BuildExperienceParent.DataHydration.CampaignStats)
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local FFlagBuildAgentAdCampaignToolCallStatusFallback = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignToolCallStatusFallback)
local useRefreshAdsData = require(script.Parent.useRefreshAdsData)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)

local asPromise = HttpClient.asPromise
local classifyAdCampaignFailure = CreatorAgentChat.classifyAdCampaignFailure

local function useCreateAdCampaign(universeId: number?, conversationId: string?, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.sendEvent or sendBuildExperienceEvent

    local isCreatePending, var3 = React.useState(false)
    local hasCreateError, var5 = React.useState(false)
    local var6 = React.useRef(nil)
    local var7, var8, var9, var10

    if FFlagEnablePaidAds then
        var7, var8 = React.useState(nil)

        var9 = React.useRef(nil)

        var10 = React.useRef(false)
    else
        var8 = nil
        var9 = nil
        var10 = nil
        var7 = nil
    end

    local var11 = React.useRef(false)
    local var12 = React.useRef(true)

    React.useEffect(function()
        var12.current = true
        return function()
            var12.current = false
        end
    end, {})

    local clearCreateError = React.useCallback(function()
        var5(false)
        if FFlagEnablePaidAds then
            var8(nil)
        end
    end, {})

    React.useEffect(function()
        var6.current = nil
        if FFlagEnablePaidAds then
            var9.current = nil
            var10.current = false
        end
        clearCreateError()
    end, { universeId, clearCreateError })

    local refresh = useRefreshAdsData(universeId, {
        includeEligibility = true,
        adCampaignsStore = tbl2.adCampaignsStore,
        campaignStatsStore = tbl2.campaignStatsStore,
        adCampaignEligibilityStore = tbl2.adCampaignEligibilityStore
    })

    local tbl3 = {
        createCampaign = React.useCallback(function(arg1, callback: ((...any) -> (...any))?, toolCallId: string?, tbl3)
            if universeId == nil or universeId == 0 or var11.current or FFlagEnablePaidAds and arg1 == nil then
                return
            end

            if FFlagBuildAgentAdCampaignCard and tbl3 ~= nil then
                var6.current = tbl3.idempotencyKey
                var9.current = arg1
            end

            local current = if FFlagEnablePaidAds then var9.current else nil
            local bool1 = not (current == nil) and (current.paymentType ~= arg1.paymentType or current.campaignOption ~= arg1.campaignOption)
            local current2 = FFlagEnablePaidAds and var10.current
            if bool1 and not current2 then
                var6.current = nil
            end
            if var6.current == nil then
                local generateIdempotencyKey = tbl2.generateIdempotencyKey
                local var15 = var6
                var15.current = if generateIdempotencyKey ~= nil then generateIdempotencyKey() else HttpService:GenerateGUID(false)
            end

            if FFlagEnablePaidAds then
                var9.current = arg1
            end

            var11.current = true
            var3(true)
            var5(false)

            local tbl4 = {
                universeId = universeId,
                idempotencyKey = var6.current
            }
            if FFlagEnablePaidAds and arg1 ~= nil then
                tbl4.selectedOption = arg1
            end
            if FFlagBuildAgentAdCampaignToolCallStatusFallback and toolCallId ~= nil and toolCallId ~= "" then
                tbl4.toolCallId = toolCallId
            end
            local var15 = tbl2.createCampaignAsync or function(arg2)
                return asPromise(CreatorAgentChat.getCreatorAgentChatStore(false).adCampaignCreate(arg2))
            end

            local idempotencyKey = tbl4.idempotencyKey
            local var16 = if FFlagBuildAgentAdCampaignCard and tbl4.selectedOption ~= nil then table.clone(tbl4.selectedOption) else nil

            var15(tbl4):andThen(function(arg2)
                var1(
                    "AD_CAMPAIGN_CREATE_SUCCESS",
                    { universeId = universeId, conversationId = conversationId },
                    {
                        campaignId = arg2.campaignId
                    }
                )
                var6.current = nil
                if FFlagEnablePaidAds then
                    var9.current = nil
                    var10.current = false
                end
                refresh()
                var11.current = false
                if var12.current then
                    var3(false)
                end
                if FFlagBuildAgentAdCampaignCard and callback ~= nil then
                    pcall(callback, arg2.campaignId, idempotencyKey, var16)
                end
            end):catch(function(arg2)
                var1(
                    "AD_CAMPAIGN_CREATE_FAILURE",
                    { universeId = universeId, conversationId = conversationId },
                    {
                        error = tostring(arg2)
                    }
                )

                var11.current = false
                local kind = if FFlagEnablePaidAds then classifyAdCampaignFailure(arg2).kind else nil

                if FFlagEnablePaidAds and kind == "unknown" then
                    var10.current = true
                end
                if var12.current then
                    var5(true)
                    if FFlagEnablePaidAds then
                        var8(kind)
                    end
                    var3(false)
                end
                if FFlagBuildAgentAdCampaignCard and tbl3 ~= nil then
                    pcall(tbl3.onFailed, kind)
                end
            end)
        end, {
            universeId,
            conversationId,
            refresh,
            var1,
            tbl2.createCampaignAsync,
            tbl2.generateIdempotencyKey
        }),
        clearCreateError = clearCreateError,
        refresh = refresh,
        isCreatePending = isCreatePending,
        hasCreateError = hasCreateError,
        createErrorKind = 0
    }

    if not FFlagEnablePaidAds then
        var7 = nil
    end

    tbl3.createErrorKind = var7
    return tbl3
end

return useCreateAdCampaign
