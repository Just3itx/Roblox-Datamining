-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local adCampaignEligibilityUtils = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils)
local adCampaignScheduleUtils = require(BuildExperience.Components.Ads.adCampaignScheduleUtils)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local GetAdUpsellEventStore = require(BuildExperience.Stores.GetAdUpsellEventStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local useCreateAdCampaign = require(BuildExperience.Components.Ads.useCreateAdCampaign)
local useGetAdCampaignEligibility = require(BuildExperience.Components.Ads.useGetAdCampaignEligibility)
local useGetAdCampaigns = require(BuildExperience.Components.Ads.useGetAdCampaigns)
local adUpsellPublishUtils = require(script.Parent.adUpsellPublishUtils)
local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildAdUpsellPinned = require(BuildExperience.Flags.FFlagBuildAdUpsellPinned)
local FFlagBuildAdsNotificationRouting = require(BuildExperienceParent.SharedFlags).FFlagBuildAdsNotificationRouting
local useAdsCampaignDeepLink = require(BuildExperience.Components.Ads.useAdsCampaignDeepLink)

local engineFeature = game:GetEngineFeature("BuildAppStorageKey")
local BuildAppStorage = if engineFeature then require(BuildExperience.Storage.BuildAppStorage) else nil

local function useAdUpsellChatViewModel(tbl1)
    local adUpsellEventStore = GetAdUpsellEventStore(false)
    local var1 = SignalsReact.useSignalState(adUpsellEventStore.getRevision)
    local var2 = React.useRef(nil)

    local current, var4 = useGetAdCampaignEligibility(tbl1.universeId, tbl1.eligibilityStore)
    local var5 = adCampaignEligibilityUtils.freeCreditsRemaining(current)

    local var6 = adCampaignEligibilityUtils.isEligibleForFreePromotion(current)
        and adCampaignEligibilityUtils.hasFreeCredit(current)
        and adCampaignEligibilityUtils.hasUsableOffer(current)
    local var7 = useCreateAdCampaign(tbl1.universeId, tbl1.sessionId)
    local isCreatePending = var7.isCreatePending
    local isAdCampaignSheetOpen, var9 = React.useState(false)

    local var10, var11 = React.useState(nil)
    local isAdCampaignCreatedToastVisible, var13 = React.useState(false)

    local var14 = React.useRef(nil)

    local var15, var16 = React.useState(false)
    local var17 = React.useRef(nil)
    local var18 = if FFlagEnablePaidAds then React.useRef(nil) else nil
    local var19, var20 = useGetAdCampaigns()

    local var21 = React.useMemo(function()
        if tbl1.nowMs == nil then
            return DateTime.now().UnixTimestampMillis
        end

        return tbl1.nowMs
    end, { tbl1.nowMs or 0, var19 or false })

    local var22 = var20 == "Ready" and adCampaignScheduleUtils.hasActiveCampaign(var19, tbl1.universeId, var21)

    local var23 = React.useCallback(function(arg1)
        var13(false)
        if not FFlagEnablePaidAds then
            var7.clearCreateError()
        end

        var11(function(arg2)
            if FFlagEnablePaidAds and var7.hasCreateError and arg2 ~= nil then
                return arg2
            end
            return adCampaignEligibilityUtils.campaignSheetTerms(arg1, DateTime.now().UnixTimestampMillis)
        end)

        var9(true)
    end, { var7.clearCreateError, var7.hasCreateError })

    local var24 = nil
    if FFlagBuildAdUpsell then
        local var25 = useAdsCampaignDeepLink
        local tbl2 = {
            universeId = tbl1.universeId,
            sessionId = tbl1.sessionId,
            isPageVisible = tbl1.isPageVisible,
            eligibilityStore = tbl1.eligibilityStore,
            canPresent = if FFlagBuildAdsNotificationRouting then not (isCreatePending or var15) else nil,
            onOpen = 0
        }

        function tbl2.onOpen(arg1): boolean
            if isAdCampaignSheetOpen or isCreatePending or var15 then
                return false
            end
            var23(arg1)
            return true
        end

        var24 = var25(tbl2)
    end

    local var25 = React.useMemo(function()
        return adUpsellPublishUtils.getLastMessageKey(tbl1.messages)
    end, { tbl1.messages })
    React.useEffect(function()
        var9(false)
        var11(nil)

        var13(false)

        var17.current = nil
        if FFlagEnablePaidAds then
            var18.current = nil
        end
        var16(false)
    end, { if var24 ~= nil then var24.scopeRevision else tbl1.universeId or 0, if var24 ~= nil then "" else tbl1.sessionId or "" })

    React.useEffect(function()
        if FFlagEnablePaidAds then
            local bool1 = var4 == "Ready" and current ~= nil and current ~= var18.current

            if var15 and (bool1 or var4 == "Failed") then
                var17.current = nil
                var18.current = nil
                var16(false)
            end
            return
        end

        if var15 and var4 == "Ready" and current ~= nil and var5 ~= var17.current then
            var17.current = nil
            var16(false)
        end
    end, {
        var15,
        var4,
        current,
        var5
    })

    React.useEffect(function()
        if tbl1.isPageVisible then
            return
        end

        var13(false)
        if not isCreatePending then
            var9(false)
        end
    end, { tbl1.isPageVisible, isCreatePending })

    local var26 = React.useRef(false)
    React.useEffect(function()
        local current = var26.current
        var26.current = isCreatePending
        if not current or isCreatePending then
            return
        end

        local current2 = var14.current
        var14.current = nil
        local bool1 = if var24 ~= nil then var24.finishCreate() else not (current2 == nil or current2.universeId ~= tbl1.universeId) and current2.sessionId == tbl1.sessionId

        if var7.hasCreateError or not bool1 then
            return
        end

        if tbl1.universeId ~= nil then
            adUpsellEventStore.dismissPermanently(tbl1.universeId)
        end
        var16(if FFlagEnablePaidAds then var18.current ~= nil else var17.current ~= nil)

        if tbl1.isPageVisible then
            var9(false)
            var13(true)
        end
    end, {
        adUpsellEventStore,
        isCreatePending,
        tbl1.isPageVisible,
        var7.hasCreateError,
        var24,
        tbl1.universeId ~= nil,
        tbl1.universeId or 0,
        tbl1.sessionId ~= nil,
        tbl1.sessionId or ""
    })

    local var27 = React.useMemo(function()
        if engineFeature and tbl1.universeId ~= nil then
            return (BuildAppStorage.getAdUpsellState(tbl1.universeId, tbl1.sessionId))
        end

        return nil
    end, {
        var1,
        tbl1.universeId ~= nil,
        tbl1.universeId or 0,
        tbl1.sessionId ~= nil,
        tbl1.sessionId or ""
    })

    local var28 = var27 == nil or not var27.isAvailable or var27.dismissedPermanently
    local var29 = tbl1.isPublic and var6 and not var28 and not (var22 or var15)

    local useEffect = React.useEffect
    local function func1()
        if var27 ~= nil and not var27.isAvailable then
            adUpsellEventStore.retryStorageRead()
        end
    end

    local bool1 = var27 ~= nil
    local isAvailable = not (var27 == nil) and (var27.isAvailable or false)
    useEffect(func1, { adUpsellEventStore, bool1, isAvailable })

    React.useEffect(function()
        if tbl1.universeId == nil
            or tbl1.sessionId == nil
            or not FFlagBuildAdUpsellPinned and var25 == nil
            or var27 == nil
            or var27.pendingMilestoneCount == 0
        then
            return
        end
        adUpsellEventStore.attachPendingMilestones(
            tbl1.universeId,
            tbl1.sessionId,
            if FFlagBuildAdUpsellPinned then nil else var25
        )
    end, {
        adUpsellEventStore,
        tbl1.universeId,
        tbl1.sessionId,
        var25,
        if var27 == nil then 0 else var27.pendingMilestoneCount or 0
    })

    local adUpsellCards = {}
    local var30 = nil
    local var31 = React.useMemo(function()
        return adUpsellPublishUtils.getMessageIndexByKey(tbl1.messages)
    end, { tbl1.messages })
    React.useEffect(function()
        if FFlagBuildAdUpsellPinned then
            return
        end

        local var3 = if tbl1.universeId == nil or tbl1.sessionId == nil then nil else `{tbl1.universeId}:{tbl1.sessionId}`

        if not tbl1.isHistoryExhausted then
            var2.current = nil
        end
        if not tbl1.isHistoryExhausted or var3 == nil or var2.current == var3 then
            return
        end
        local tbl3 = ({})
        for value in var31 do
            tbl3[value] = true
        end
        if adUpsellEventStore.pruneAnchors(tbl1.universeId, tbl1.sessionId, tbl3) then
            var2.current = var3
        end
    end, {
        adUpsellEventStore,
        tbl1.isHistoryExhausted,
        tbl1.universeId,
        tbl1.sessionId,
        var31,
        var1
    })

    if var27 ~= nil and var27.isAvailable and var29 then
        for _, anchor in var27.anchors do
            if FFlagBuildAdUpsellPinned then
                table.insert(adUpsellCards, { id = anchor.id, order = anchor.order, isImpressed = anchor.impressed })

                local transientCongratsMessageKey = adUpsellEventStore.getTransientCongratsMessageKey(anchor.id)
                if transientCongratsMessageKey ~= nil then
                    var30 = var31[transientCongratsMessageKey]
                end
            else
                local afterMessageKey = anchor.afterMessageKey
                if afterMessageKey ~= nil then
                    local anchorIndex = var31[afterMessageKey]
                    if anchorIndex ~= nil then
                        table.insert(
                            adUpsellCards,
                            {
                                id = anchor.id,
                                order = anchor.order,
                                anchorIndex = anchorIndex,
                                isImpressed = anchor.impressed
                            }
                        )
                    end
                end
            end
        end
    end
    local onAdUpsellImpression = React.useCallback(function(str1: string)
        if tbl1.universeId == nil or tbl1.sessionId == nil then
            return
        end
        if adUpsellEventStore.markAnchorImpressed(tbl1.universeId, tbl1.sessionId, str1) then
            sendBuildExperienceEvent("AD_UPSELL_IMPRESSION", { universeId = tbl1.universeId, conversationId = tbl1.sessionId })
        end
    end, { adUpsellEventStore, tbl1.universeId or 0, tbl1.sessionId or "" })

    local onAdUpsellCreate = React.useCallback(function()
        if not tbl1.isPageVisible then
            return
        end
        if FFlagBuildAdUpsell and not var7.hasCreateError then
            var24.clearPresentedRequest()
        end
        sendBuildExperienceEvent("AD_UPSELL_CREATE_CLICK", { universeId = tbl1.universeId, conversationId = tbl1.sessionId })

        var23(current)
    end, {
        tbl1.isPageVisible,
        tbl1.universeId or 0,
        tbl1.sessionId or "",
        current,
        var23,
        var7.hasCreateError,
        var24
    })

    local onAdCampaignSheetClose = React.useCallback(function()
        var9(false)
        if FFlagBuildAdUpsell then
            var24.clearPresentedRequest()
        end
        if FFlagEnablePaidAds then
            var7.clearCreateError()
        end
    end, { var7.clearCreateError, var24 })

    local onAdCampaignSheetCreate = React.useCallback(function(arg1)
        local requestId = if FFlagBuildAdUpsell then var24.getPresentedRequestId() else nil
        local tbl3 = {
            universeId = tbl1.universeId,
            conversationId = tbl1.sessionId
        }

        if requestId ~= nil then
            sendBuildExperienceEvent("AD_CAMPAIGN_DEEP_LINK_CONFIRM_CLICK", tbl3, { requestId = requestId })
        else
            sendBuildExperienceEvent("AD_UPSELL_CREATE_CONFIRM_CLICK", tbl3)
        end
        if var24 ~= nil then
            var24.startCreate()
        else
            var14.current = {
                universeId = tbl1.universeId,
                sessionId = tbl1.sessionId
            }
        end

        var17.current = var5
        if FFlagEnablePaidAds then
            var18.current = current
        end
        local createCampaign = var7.createCampaign

        if not FFlagEnablePaidAds then
            arg1 = nil
        end

        createCampaign(arg1)
    end, {
        tbl1.universeId or 0,
        tbl1.sessionId or "",
        var5,
        current,
        var7.createCampaign,
        var24
    })

    local onAdCampaignCreatedToastDismiss = React.useCallback(function()
        var13(false)
    end, {})

    local onAdUpsellDismiss = React.useCallback(function()
        if tbl1.universeId == nil then
            return
        end
        adUpsellEventStore.dismissPermanently(tbl1.universeId)
        sendBuildExperienceEvent("AD_UPSELL_DISMISS_CLICK", { universeId = tbl1.universeId, conversationId = tbl1.sessionId })
    end, { adUpsellEventStore, tbl1.universeId or 0, tbl1.sessionId or "" })

    local adCampaignRunEndTimeMs = if var10 == nil or var10.durationDays == nil then nil else adCampaignScheduleUtils.campaignEndMs(var10.runStartMs, var10.durationDays)
    return {
        adUpsellCards = adUpsellCards,
        adUpsellCongratsAnchorIndex = var30,
        adUpsellFreePromotionsRemaining = var5,
        isAdUpsellCreatePending = isCreatePending,
        isAdCampaignSheetOpen = isAdCampaignSheetOpen,
        hasAdCampaignCreateError = var7.hasCreateError,
        adCampaignCreateErrorKind = var7.createErrorKind,
        adCampaignDurationDays = if var10 == nil then nil else var10.durationDays,
        adCampaignEstimatedPriceRobux = if var10 == nil then nil else var10.estimatedPriceRobux,
        adCampaignOffers = if var10 == nil then nil else var10.campaignOffers,
        adCampaignRunStartTimeMs = if var10 == nil then nil else var10.runStartMs,
        adCampaignRunEndTimeMs = adCampaignRunEndTimeMs,
        isAdCampaignCreatedToastVisible = isAdCampaignCreatedToastVisible,
        onAdCampaignCreatedToastDismiss = onAdCampaignCreatedToastDismiss,
        onAdUpsellCreate = onAdUpsellCreate,
        onAdUpsellDismiss = onAdUpsellDismiss,
        onAdUpsellImpression = onAdUpsellImpression,
        onAdCampaignSheetClose = onAdCampaignSheetClose,
        onAdCampaignSheetCreate = onAdCampaignSheetCreate
    }
end

return useAdUpsellChatViewModel
