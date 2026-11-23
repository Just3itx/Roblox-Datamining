-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Players = game:GetService("Players")
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local useCreateAdCampaign = require(BuildExperience.Components.Ads.useCreateAdCampaign)
local GetAdUpsellEventStore = require(BuildExperience.Stores.GetAdUpsellEventStore)
local GetAgentAdCampaignStore = require(BuildExperience.Stores.GetAgentAdCampaignStore)
local _createAgentAdCampaignStore = require(BuildExperience.Stores.GetAgentAdCampaignStore.createAgentAdCampaignStore)
local AdCampaignToolCallStatus = require(BuildExperienceParent.DataHydration.AdCampaignToolCallStatus)
local AdCampaigns = require(BuildExperienceParent.DataHydration.AdCampaigns)
local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local _createAdCampaignCardStorage = require(BuildExperience.Storage.createAdCampaignCardStorage)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local adCampaignScheduleUtils = require(BuildExperience.Components.Ads.adCampaignScheduleUtils)
local adCampaignEligibilityUtils = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils)

local FFlagBuildAgentAdCampaignRefreshEligibility = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignRefreshEligibility)

local FFlagBuildAgentAdCampaignToolCallStatusFallback = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignToolCallStatusFallback)

local function persistenceFor(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return {
        get = arg1.getAdCampaignCard,
        save = arg1.recordAdCampaignAttempt
    }
end

local function hasFailedBackendAttempt(num1: number, toolCallId: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = AdCampaignToolCallStatus.getAdCampaignToolCallStatusStore(false).getToolCallStatus(num1, toolCallId).data(false)
    return not (var1 == nil) and var1.status == "failed"
end

local function useAgentAdCampaignChatViewModel(tbl1, num1: number?)
    local adUpsellEventStore = GetAdUpsellEventStore(false)
    local var1 = SignalsReact.useSignalState(adUpsellEventStore.getAdCampaignRevision)
    local agentAdCampaignStore = GetAgentAdCampaignStore(false)
    local var2 = SignalsReact.useSignalState(agentAdCampaignStore.getAttempts)
    local adCampaignsStore = AdCampaigns.getAdCampaignsStore(false)
    local var3 = SignalsReact.useSignalState(adCampaignsStore.getAdCampaigns().data)
    local localPlayer = Players.LocalPlayer
    if not num1 then
        if localPlayer == nil or not (localPlayer.UserId > 0) then
            num1 = nil
        else
            num1 = localPlayer.UserId
        end
    end

    local var4, var5 = React.useState(nil)
    local var6 = React.useRef(nil)
    local var7 = if var4 == nil then nil else var2[var4.toolCallId]
    local var8 = useCreateAdCampaign(tbl1.universeId, tbl1.sessionId)
    local var9, var10 = React.useState(false)
    local var11, var12 = React.useState(DateTime.now().UnixTimestampMillis)
    local var13 = React.useRef(true)
    local current = {
        universeId = tbl1.universeId,
        sessionId = tbl1.sessionId,
        isPageVisible = tbl1.isPageVisible,
        userId = num1
    }
    local var14 = React.useRef(current)
    var14.current = current
    local var15 = React.useRef(tbl1.isPageVisible)
    local var16 = if FFlagBuildAgentAdCampaignRefreshEligibility then React.useRef(nil) else nil
    local var17 = if FFlagBuildAgentAdCampaignRefreshEligibility then React.useRef(nil) else nil
    local var18 = nil
    local var19 = nil
    if FFlagBuildAgentAdCampaignRefreshEligibility then
        var18, var19 = React.useState(nil)

        React.useEffect(function()
            var19(nil)
            return function()
                local current = var16.current
                var16.current = nil
                if current ~= nil and current.timer ~= nil then
                    task.cancel(current.timer)
                end
            end
        end, {
            tbl1.universeId,
            tbl1.sessionId,
            tbl1.isPageVisible,
            num1,
            var16,
            var19
        })
    end

    React.useEffect(function()
        var13.current = true
        return function()
            var13.current = false
        end
    end, {})
    React.useEffect(function()
        var6.current = nil
        var5(nil)
    end, { tbl1.universeId, tbl1.sessionId, num1 })
    React.useEffect(function()
        if tbl1.isPageVisible then
            adUpsellEventStore.retryAdCampaignCardWrites()
        end
    end, { tbl1.isPageVisible, adUpsellEventStore })

    local var20 = React.useMemo(function()
        local result = {}
        if tbl1.sessionId ~= nil then
            for _, record in adUpsellEventStore.listAdCampaignCards(tbl1.sessionId).records do
                if (record.userId == nil or record.userId == num1) and record.universeId == tbl1.universeId then
                    result[record.toolCallId] = record
                end
            end
        end
        return result
    end, {
        tbl1.sessionId,
        tbl1.universeId,
        adUpsellEventStore,
        var1,
        num1
    })

    local var21 = React.useMemo(function()
        local result = ({})
        for value, value2 in var20 do
            if value2.campaignId ~= nil then
                result[value] = value2
            end
        end
        return result
    end, { var20 })
    React.useEffect(function()
        if tbl1.isPageVisible and next(var21) ~= nil then
            adCampaignsStore.getAndFetchAdCampaigns()
        end
    end, { var21, tbl1.isPageVisible, adCampaignsStore })
    local var22 = React.useMemo(function()
        local tbl3 = {}
        for _, value in var3 or {} do
            if value.targetUniverseId == tostring(tbl1.universeId) then
                tbl3[value.id] = value
            end
        end
        local result = ({})
        for value, value2 in var21 do
            local var22 = tbl3[value2.campaignId]
            if var22 ~= nil then
                local startMs = adCampaignScheduleUtils.toStartMs(var22.schedule.startTime)
                if startMs > 0 and var22.schedule.durationInDays > 0 then
                    local tbl4 = {
                        startMs = startMs,
                        durationDays = var22.schedule.durationInDays
                    }
                    result[value] = tbl4
                end
            elseif (value2.userId == nil or value2.idempotencyKey ~= value) and value2.durationDays ~= nil then
                local tbl4 = {
                    startMs = value2.createdAtMs,
                    durationDays = value2.durationDays
                }
                result[value] = tbl4
            end
        end

        return result
    end, { var21, var3, tbl1.universeId })

    React.useEffect(function()
        local current = var15.current
        var15.current = tbl1.isPageVisible
        if tbl1.isPageVisible and not current then
            var12(DateTime.now().UnixTimestampMillis)
        end
    end, { tbl1.isPageVisible })
    React.useEffect(function()
        if not tbl1.isPageVisible then
            return
        end
        local huge = math.huge
        for _, value in var22 do
            local var23 = adCampaignScheduleUtils.campaignEndExclusiveMs(value.startMs, value.durationDays)
            if var11 < var23 then
                huge = math.min(huge, var23)
            end
        end
        if huge == math.huge then
            return
        end
        local var23 = nil
        var23 = task.delay(math.max(0, huge - DateTime.now().UnixTimestampMillis) / 1000, function()
            var23 = nil
            var12(DateTime.now().UnixTimestampMillis)
        end)
        return function()
            if var23 ~= nil then
                task.cancel(var23)
            end
        end
    end, { var22, tbl1.isPageVisible, var11 })

    local getCardState = React.useCallback(function(toolCallId: string)
        local var23 = var21[toolCallId]
        if var23 == nil or var23.campaignId == nil then
            return if FFlagBuildAgentAdCampaignRefreshEligibility and var18 ~= nil and var18.toolCallId == toolCallId then {
                eligibilityStatus = var18.status
            } else nil
        end
        local var24 = var22[toolCallId]
        return {
            campaignId = var23.campaignId,
            variant = if var24 == nil then nil elseif var11 >= adCampaignScheduleUtils.campaignEndExclusiveMs(var24.startMs, var24.durationDays) then "complete" else "active",
            campaignStartDate = if var24 == nil then nil else LocalizationStrings.formatAdCampaignSheetLocalDate(var24.startMs),
            campaignEndDate = if var24 == nil then nil else LocalizationStrings.formatAdCampaignSheetLocalDate(
                adCampaignScheduleUtils.campaignEndMs(var24.startMs, var24.durationDays)
            )
        }
    end, {
        var21,
        var22,
        var11,
        var18
    })
    local isCreateDisabled = React.useCallback(function(str1: string)
        if FFlagBuildAgentAdCampaignRefreshEligibility and var18 ~= nil and var18.status == "loading" then
            return true
        end
        local var24 = var2[str1]
        local bool1 = not tbl1.isPageVisible
        return bool1 or var24 ~= nil and var24.isPending
    end, { tbl1.isPageVisible, var2, var18 })

    local var25 = React.useCallback(function(arg1, campaignId: string, idempotencyKey: string?): boolean
        if idempotencyKey ~= nil and idempotencyKey ~= arg1.idempotencyKey then
            return false
        end
        local var25 = table.clone(arg1)
        var25.campaignId = campaignId
        var25.phase = "created"
        var25.updatedAtMs = math.max(arg1.updatedAtMs, DateTime.now().UnixTimestampMillis)
        local var26, var27 = adUpsellEventStore.recordAdCampaignCreatedReceipt(var25)
        if not (var26 or var27) then
            return false
        end
        agentAdCampaignStore.completeDurable(arg1)
        local current = var6.current
        local current2 = var14.current

        if var13.current
            and current ~= nil
            and current.toolCallId == arg1.toolCallId
            and current.universeId == arg1.universeId
            and current.sessionId == arg1.sessionId
            and current2.universeId == arg1.universeId
            and current2.sessionId == arg1.sessionId
            and current2.userId == arg1.userId
        then
            var6.current = nil
            var5(nil)
        end
        return var27
    end, { agentAdCampaignStore, adUpsellEventStore })

    React.useEffect(function()
        if not FFlagBuildAgentAdCampaignToolCallStatusFallback or num1 == nil then
            return
        end

        local tbl3 = {}
        for _, value in var20 do
            if value.userId ~= num1 or value.campaignId ~= nil then
                continue
            end

            local var26 = var2[value.toolCallId]
            if var26 ~= nil and var26.isPending then
                continue
            end

            local var27 = AdCampaignToolCallStatus.getAdCampaignToolCallStatusStore(false).getAndFetchToolCallStatus(num1, value.toolCallId)
            table.insert(tbl3, Signals.createEffect(function(arg1)
                local var28 = var27.data(arg1)
                if var27.status(arg1) == "Ready" and var28 ~= nil and var28.campaignId ~= nil and var25(value, var28.campaignId) then
                    var8.refresh()
                end
            end))
        end

        return function()
            for _, value in tbl3 do
                value()
            end
        end
    end, {
        var20,
        var2,
        num1,
        var25,
        var8.refresh
    })
    local var26 = React.useCallback(function(toolCallId: string, offers)
        if num1 == nil or var14.current.userId ~= num1 then
            return "ignored"
        end

        if not tbl1.isPageVisible
            or tbl1.universeId == nil
            or tbl1.universeId == 0
            or tbl1.sessionId == nil
            or toolCallId == ""
            or var21[toolCallId] ~= nil
            or var14.current.universeId ~= tbl1.universeId
            or var14.current.sessionId ~= tbl1.sessionId
            or not var14.current.isPageVisible
            or var6.current ~= nil
            or offers.feedback == nil and offers.plays == nil
        then
            return "ignored"
        end
        local record = adUpsellEventStore.getAdCampaignCard(tbl1.sessionId, toolCallId).record
        if record ~= nil and record.universeId == tbl1.universeId and record.campaignId ~= nil then
            return "ignored"
        end

        if not agentAdCampaignStore.restore({
            universeId = tbl1.universeId,
            sessionId = tbl1.sessionId,
            toolCallId = toolCallId,
            offers = offers,
            runStartTimeMs = DateTime.now().UnixTimestampMillis
        }, num1, (persistenceFor(adUpsellEventStore))) then
            var10(true)
            return "failed"
        end
        var10(false)
        local var26 = agentAdCampaignStore.getAttempts(false)[toolCallId]

        if FFlagBuildAgentAdCampaignRefreshEligibility
            and FFlagBuildAgentAdCampaignToolCallStatusFallback
            and var26 == nil
            and hasFailedBackendAttempt(num1, toolCallId)
        then
            return "failed"
        end
        if var26 ~= nil
            and (var26.isPending or var26.userId ~= num1 or var26.universeId ~= tbl1.universeId or var26.sessionId ~= tbl1.sessionId)
        then
            return "ignored"
        end

        local retrySelection

        if var26 ~= nil then
            retrySelection = agentAdCampaignStore.getRetrySelection(var26, DateTime.now().UnixTimestampMillis)
        else
            retrySelection = {
                universeId = tbl1.universeId,
                sessionId = tbl1.sessionId,
                toolCallId = toolCallId,
                offers = {
                    feedback = if offers.feedback == nil then nil else table.clone(offers.feedback),
                    plays = if offers.plays == nil then nil else table.clone(offers.plays)
                },
                runStartTimeMs = DateTime.now().UnixTimestampMillis
            }
        end

        if FFlagBuildAgentAdCampaignRefreshEligibility and var26 ~= nil then
            local retryOffers = agentAdCampaignStore.getRetryOffers(var26, offers)
            if retryOffers == nil then
                return "failed"
            end
            retrySelection = table.clone(retrySelection)
            retrySelection.offers = retryOffers
        end
        if FFlagBuildAgentAdCampaignRefreshEligibility then
            local var27 = var17

            if var26 == nil or not agentAdCampaignStore.canReplaceRejectedAttempt(var26) then
                var26 = nil
            end

            var27.current = var26
        end

        var6.current = retrySelection
        var5(retrySelection)
        var8.clearCreateError()
        return "opened"
    end, {
        tbl1.isPageVisible,
        tbl1.universeId,
        tbl1.sessionId,
        var21,
        adUpsellEventStore,
        agentAdCampaignStore,
        var8.clearCreateError,
        num1,
        var10,
        var17
    })

    local onOfferSelected = React.useCallback(function(toolCallId: string, arg1)
        if not FFlagBuildAgentAdCampaignRefreshEligibility then
            var26(toolCallId, arg1)
            return
        end
        local current = var14.current

        if not var13.current
            or not current.isPageVisible
            or current.universeId == nil
            or current.universeId == 0
            or current.sessionId == nil
            or num1 == nil
            or current.userId ~= num1
            or current.universeId ~= tbl1.universeId
            or current.sessionId ~= tbl1.sessionId
            or toolCallId == ""
            or var6.current ~= nil
            or var16.current ~= nil
        then
            return
        end
        local record = adUpsellEventStore.getAdCampaignCard(current.sessionId, toolCallId).record
        local var27 = agentAdCampaignStore.getAttempts(false)[toolCallId]
        if record ~= nil and record.campaignId ~= nil or var27 ~= nil and var27.isPending then
            return
        end
        local tbl2 = {}
        var16.current = tbl2
        var19({ toolCallId = toolCallId, status = "loading" })
        local function isCurrent() -- Luacid: Inlined by compiler; 2 call sites recovered
            local current2 = var14.current
            local current3 = var13.current

            if current3 then
                if var16.current == tbl2 then
                    current3 = current2.isPageVisible

                    if current3 then
                        if current2.universeId == current.universeId and current2.sessionId == current.sessionId then
                            current3 = current2.userId == current.userId
                        else
                            current3 = false
                        end
                    end
                else
                    current3 = false
                end
            end

            return current3
        end
        tbl2.timer = task.delay(15, function()
            tbl2.timer = nil

            if not isCurrent() then
                return
            end

            var16.current = nil
            var19({ toolCallId = toolCallId, status = "failed" })
        end)

        AdCampaignEligibility.getAdCampaignEligibilityStore(false).fetchEligibility(current.universeId, function(arg2)
            if not isCurrent() then
                return
            end
            if tbl2.timer ~= nil then
                task.cancel(tbl2.timer)
                tbl2.timer = nil
            end
            if arg2 == nil then
                var16.current = nil
                var19({ toolCallId = toolCallId, status = "failed" })
                return
            end

            local selectableOffers = if arg2.cardType == "none" or not adCampaignEligibilityUtils.canCreateCampaign(arg2) then nil else adCampaignEligibilityUtils.getSelectableOffers(arg2)

            if selectableOffers == nil then
                var16.current = nil
                var19({ toolCallId = toolCallId, status = "unavailable" })
                return
            end
            local var28 = var26(toolCallId, selectableOffers)
            var16.current = nil
            var19(var28 == "failed" and { toolCallId = toolCallId, status = "failed" } or nil)
        end)
    end, {
        var26,
        tbl1.universeId,
        tbl1.sessionId,
        num1,
        adUpsellEventStore,
        agentAdCampaignStore,
        var16,
        var19
    })

    local onSheetClose = React.useCallback(function()
        if not var8.isCreatePending and var4 ~= nil and var6.current == var4 then
            var6.current = nil
            var5(nil)
        end
    end, { var8.isCreatePending, var4 })

    local isPageVisible = not (var4 == nil or var4.universeId ~= tbl1.universeId or var4.sessionId ~= tbl1.sessionId) and tbl1.isPageVisible

    local onSheetCreate = React.useCallback(function(arg1)
        if num1 == nil
            or var14.current.userId ~= num1
            or var4 == nil
            or var6.current ~= var4
            or arg1 == nil
            or not isPageVisible
            or not var14.current.isPageVisible
            or var14.current.universeId ~= var4.universeId
            or var14.current.sessionId ~= var4.sessionId
            or var8.isCreatePending
            or var21[var4.toolCallId] ~= nil
        then
            return
        end

        local var29 = if arg1.campaignOption == "feedback" then var4.offers.feedback else var4.offers.plays

        if var29 == nil or var29.fundingType ~= arg1.paymentType then
            return
        end
        local var30 = agentAdCampaignStore.getAttempts(false)[var4.toolCallId]
        if var30 ~= nil and var30.isPending then
            return
        end

        if not agentAdCampaignStore.restore(var4, num1, (persistenceFor(adUpsellEventStore))) then
            var10(true)
            return
        end

        local var31 = agentAdCampaignStore.getAttempts(false)[var4.toolCallId]

        if FFlagBuildAgentAdCampaignRefreshEligibility
            and FFlagBuildAgentAdCampaignToolCallStatusFallback
            and var31 == nil
            and hasFailedBackendAttempt(num1, var4.toolCallId)
        then
            var6.current = nil
            var5(nil)
            var19({ toolCallId = var4.toolCallId, status = "failed" })
            return
        end
        if var31 ~= nil then
            local retrySelection = agentAdCampaignStore.getRetrySelection(var31, var4.runStartTimeMs)
            if FFlagBuildAgentAdCampaignRefreshEligibility then
                local offers = agentAdCampaignStore.getRetryOffers(var31, var4.offers)
                if offers == nil then
                    var6.current = nil
                    var5(nil)
                    var19({ toolCallId = var4.toolCallId, status = "failed" })
                    return
                end
                if offers[arg1.campaignOption] == nil then
                    return
                end
                retrySelection = table.clone(retrySelection)
                retrySelection.offers = offers
            end

            local var32 = if arg1.campaignOption == "feedback" then retrySelection.offers.feedback else retrySelection.offers.plays

            if var4.runStartTimeMs ~= retrySelection.runStartTimeMs
                or var32 == nil
                or var29.fundingType ~= var32.fundingType
                or var29.durationDays ~= var32.durationDays
                or var29.priceRobux ~= var32.priceRobux
            then
                var6.current = retrySelection
                var5(retrySelection)
                var10(false)
                return
            end
        end

        local var32 = agentAdCampaignStore.startDurable(var4, arg1, num1, (persistenceFor(adUpsellEventStore)))
        var10(var32 == nil)
        if var32 == nil then
            return
        end
        sendBuildExperienceEvent(
            "AD_UPSELL_CREATE_CONFIRM_CLICK",
            {
                universeId = var4.universeId,
                conversationId = var4.sessionId
            },
            {
                context = "agent_card",
                fundingType = arg1.paymentType,
                campaignOption = arg1.campaignOption
            }
        )
        local createCampaign = var8.createCampaign

        local function func1(arg2, arg3, arg4)
            if arg4 ~= nil then
                var25(agentAdCampaignStore.toRecord(var32), arg2, arg3)
            end
        end

        local toolCallId = if FFlagBuildAgentAdCampaignToolCallStatusFallback then var4.toolCallId else nil

        createCampaign(arg1, func1, toolCallId, {
            idempotencyKey = var32.idempotencyKey,
            onFailed = function(arg2)
                if agentAdCampaignStore.finishDurable(var32, arg2, (persistenceFor(adUpsellEventStore)))
                    and FFlagBuildAgentAdCampaignToolCallStatusFallback
                    and num1 ~= nil
                then
                    AdCampaignToolCallStatus.getAdCampaignToolCallStatusStore(false).fetchToolCallStatus(num1, var32.toolCallId)
                end
            end
        })
    end, {
        var4,
        agentAdCampaignStore,
        var25,
        num1,
        isPageVisible,
        var21,
        var8.isCreatePending,
        var8.createCampaign,
        adUpsellEventStore,
        var10,
        var19
    })

    local offers = if var4 == nil then nil else var4.offers

    if FFlagBuildAgentAdCampaignRefreshEligibility and var7 ~= nil and offers ~= nil and not var7.isPending then
        offers = agentAdCampaignStore.getRetryOffers(var7, offers) or offers
    end

    local selectedOption = if var7 == nil then nil else var7.selectedOption
    local var30 = if FFlagBuildAgentAdCampaignRefreshEligibility then if var7 == var17.current then nil else var7 else var7

    if FFlagBuildAgentAdCampaignRefreshEligibility
        and selectedOption ~= nil
        and offers ~= nil
        and offers[selectedOption.campaignOption] == nil
    then
        selectedOption = nil
    end

    local tbl3 = {
        isSheetOpen = isPageVisible,
        isCreatePending = 0,
        hasCreateError = 0,
        createErrorKind = 0,
        campaignOffers = 0,
        attemptedOption = 0,
        runStartTimeMs = 0,
        onOfferSelected = 0,
        isCreateDisabled = 0,
        getCardState = 0,
        onSheetClose = 0,
        onSheetCreate = 0
    }
    local isCreatePending = var8.isCreatePending

    if not isCreatePending then
        if var7 == nil then
            isCreatePending = false
        else
            isCreatePending = var7.isPending
        end
    end

    tbl3.isCreatePending = isCreatePending
    if var30 ~= nil then
        var9 = not var30.isPending or var9
    end

    tbl3.hasCreateError = var9
    tbl3.createErrorKind = if var30 ~= nil then var30.failureKind else var8.createErrorKind
    tbl3.campaignOffers = offers
    tbl3.attemptedOption = selectedOption
    tbl3.runStartTimeMs = if var4 == nil then nil else var4.runStartTimeMs
    tbl3.onOfferSelected = onOfferSelected
    tbl3.isCreateDisabled = isCreateDisabled
    tbl3.getCardState = getCardState
    tbl3.onSheetClose = onSheetClose
    tbl3.onSheetCreate = onSheetCreate
    return tbl3
end

return useAgentAdCampaignChatViewModel
