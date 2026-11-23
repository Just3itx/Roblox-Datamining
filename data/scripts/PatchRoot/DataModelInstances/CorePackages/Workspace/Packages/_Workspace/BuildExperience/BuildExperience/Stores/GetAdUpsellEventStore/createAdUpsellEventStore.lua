-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Signals = require(BuildExperienceParent.Signals)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)

local chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local FFlagBuildAdUpsellPinned = require(BuildExperience.Flags.FFlagBuildAdUpsellPinned)
local getAdUpsellEligibility = require(BuildExperience.Components.Ads.getAdUpsellEligibility)
local observeAdUpsellEligibility = require(BuildExperience.Components.Ads.observeAdUpsellEligibility)
local GameConfigurationLabels = require(BuildExperience.utils.GameConfigurationLabels)

local engineFeature = game:GetEngineFeature("BuildAppStorageKey")
local BuildAppStorage = if engineFeature then require(BuildExperience.Storage.BuildAppStorage) else nil
local _createAdCampaignCardStorage = require(BuildExperience.Storage.createAdCampaignCardStorage)

local function defaultDependencies(): {attachPendingMilestones: number, cancelRetry: number, dismissPermanently: number, getAdCampaignCardStorage: number, getAudience: number, getEligibility: number, isDismissedPermanently: number, markAnchorImpressed: number, observeEligibility: number, pruneAnchors: number, publicAudience: number, recordCompletedTurn: number, recordPublish: number, refreshSummary: number, retryStorageRead: number, scheduleRetry: number}?
    if not engineFeature then
        return nil
    end
    local module = {
        getAdCampaignCardStorage = if FFlagBuildAgentAdCampaignCard then BuildAppStorage.getAdCampaignCardStorage else nil,
        recordCompletedTurn = BuildAppStorage.recordAdUpsellCompletedTurn,
        recordPublish = BuildAppStorage.recordAdUpsellPublish,
        attachPendingMilestones = BuildAppStorage.attachPendingAdUpsellMilestones,
        pruneAnchors = BuildAppStorage.pruneAdUpsellAnchors,
        markAnchorImpressed = BuildAppStorage.markAdUpsellAnchorImpressed,
        dismissPermanently = BuildAppStorage.markAdUpsellDismissedPermanently,
        isDismissedPermanently = 0,
        retryStorageRead = 0,
        refreshSummary = 0,
        getAudience = 0,
        publicAudience = 0,
        getEligibility = 0,
        observeEligibility = 0,
        scheduleRetry = 0,
        cancelRetry = 0
    }

    function module.isDismissedPermanently(num1: number)
        local adUpsellState = BuildAppStorage.getAdUpsellState(num1, nil)
        return adUpsellState.isAvailable and adUpsellState.dismissedPermanently
    end
    module.retryStorageRead = BuildAppStorage.retryAdUpsellRead
    function module.refreshSummary(num1: number)
        return UniverseConfiguration.getUniverseConfigurationStore().refreshSummary(num1)
    end
    function module.getAudience(arg1)
        return GameConfigurationLabels.getAudience(arg1)
    end
    module.publicAudience = UniverseConfiguration.PrivacyType.Public
    module.getEligibility = getAdUpsellEligibility
    module.observeEligibility = observeAdUpsellEligibility
    function module.scheduleRetry(num1: number, func1: (...any) -> (...any))
        return task.delay(num1, func1)
    end
    function module.cancelRetry(thread1: thread)
        task.cancel(thread1)
    end

    return module
end

local function hasSuccessfulPublish(turnState): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return CreatorAgentChat.PublishToolUtils.getLatestSuccessfulResult(turnState, { parseDirectText = true }) ~= nil
end

local function createAdUpsellEventStore(tbl1)
    local var1 = tbl1 or defaultDependencies()
    local getRevision, var3 = Signals.createSignal(0)
    local getAdCampaignRevision, var5 = Signals.createSignal(0)
    local tbl2 = ({})
    local tbl3 = {}
    local tbl4 = {}
    local var6 = nil
    local tbl5 = ({})
    local num1 = 0

    local var7 = nil

    local function bumpRevision() -- Luacid: Inlined by compiler; 13 call sites recovered
        var3(function(arg1): number
            return arg1 + 1
        end)
    end

    local function getCardStorage() -- Luacid: Inlined by compiler; 7 call sites recovered
        if var1 ~= nil then
            return (var1.getAdCampaignCardStorage())
        end

        return nil
    end

    local function bumpAdCampaignRevision() -- Luacid: Inlined by compiler; 6 call sites recovered
        var5(function(arg1): number
            return arg1 + 1
        end)

        bumpRevision()
    end

    local function recordCardMutation(bool1: boolean, bool2: boolean, bool3: boolean): (boolean, boolean)
        if bool2 or bool1 and bool3 then
            bumpAdCampaignRevision()
        end

        return bool1, bool2
    end

    local function disposeEligibilitySubscription(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
        local var8 = tbl5[str1]
        if var8 == nil then
            return
        end

        tbl5[str1] = nil
        var8()
    end

    local function removePending(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl2[str1] == nil then
            return
        end

        disposeEligibilitySubscription(str1)
        tbl2[str1] = nil
        local var8 = table.find(tbl3, str1)
        if var8 ~= nil then
            table.remove(tbl3, var8)
        end
    end

    local function retainPending(tbl6)
        local var8 = tbl2[tbl6.id]
        if var8 ~= nil then
            return var8
        end
        tbl2[tbl6.id] = tbl6
        table.insert(tbl3, tbl6.id)
        while #tbl3 > 50 do
            local var9 = table.remove(tbl3, 1)
            if var9 ~= nil then
                disposeEligibilitySubscription(var9)
                tbl2[var9] = nil
            end
        end
        return tbl6
    end

    local function canRetryAutomatically(tbl6): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        return not tbl6.isAwaitingEligibility
            and (if tbl6.requiresAudienceVerification and tbl6.isEligiblePublish == nil then not tbl6.isVerifyingAudience and tbl6.audienceVerificationAttempts < 3 else tbl6.storagePersistenceAttempts < 3)
    end

    local function hasAutomaticallyRetryableEvent() -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, value in tbl3 do
            local var8 = tbl2[value]

            if var8 ~= nil and canRetryAutomatically(var8) then
                return true
            end
        end
        return false
    end

    local function func1()
        if var1 == nil or var6 ~= nil or not hasAutomaticallyRetryableEvent() then
            return
        end
        local num2 = num1
        var6 = var1.scheduleRetry(1, function()
            var6 = nil
            if num1 ~= num2 then
                return
            end
            for _, value in (table.clone(tbl3)) do
                local var8 = tbl2[value]

                if var8 ~= nil and canRetryAutomatically(var8) then
                    var7(var8)
                end
            end

            if hasAutomaticallyRetryableEvent() then
                func1()
            end
        end)
    end

    local function persistEvent(tbl6)
        if var1 == nil then
            return
        end
        local tbl7 = {
            universeId = tbl6.universeId,
            sessionId = tbl6.sessionId,
            eventId = tbl6.id,
            afterMessageKey = tbl6.afterMessageKey,
            isEligiblePublish = tbl6.isEligiblePublish == true
        }
        local var8, var9

        if tbl6.isCompletedTurn then
            var8, var9 = var1.recordCompletedTurn(tbl7)
        else
            var8, var9 = var1.recordPublish(tbl7)
        end
        if var9 then
            if FFlagBuildAdUpsellPinned and tbl6.afterMessageKey ~= nil then
                tbl4[tbl6.id] = tbl6.afterMessageKey
            end

            bumpRevision()
        end

        if var8 or var9 then
            removePending(tbl6.id)
            return
        end
        tbl6.storagePersistenceAttempts += 1
        if tbl6.storagePersistenceAttempts < 3 then
            func1()
        end
    end

    local function handleAudienceVerificationFailure(tbl6) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl6.isVerifyingAudience = false
        tbl6.audienceVerificationAttempts += 1
        if tbl6.audienceVerificationAttempts < 3 then
            func1()
        end
    end

    local function awaitEligibility(tbl6, arg1)
        if var1 == nil then
            return
        end
        tbl6.isVerifyingAudience = false
        if tbl6.isAwaitingEligibility then
            return
        end
        tbl6.isAwaitingEligibility = true

        local num2 = num1
        local var8 = nil
        local bool1 = false
        local var9 = var1.observeEligibility(tbl6.universeId, function() -- name: onEligibilityChanged
            if num1 ~= num2 or tbl2[tbl6.id] ~= tbl6 then
                return
            end
            local eligibility = var1.getEligibility(tbl6.universeId)
            if not eligibility.isResolved then
                return
            end
            tbl6.isAwaitingEligibility = false
            if var8 ~= nil then
                disposeEligibilitySubscription(tbl6.id)
            else
                bool1 = true
            end
            local tbl7 = tbl6
            tbl7.isEligiblePublish = var1.getAudience(arg1) == var1.publicAudience and eligibility.isEligible and eligibility.freePromotionsRemaining > 0

            persistEvent(tbl6)
        end)

        var8 = var9
        if bool1 then
            var9()
            return
        end
        tbl5[tbl6.id] = var9
    end

    var7 = function(tbl6)
        if var1 == nil or tbl2[tbl6.id] ~= tbl6 then
            return
        end

        if not tbl6.requiresAudienceVerification or tbl6.isEligiblePublish ~= nil then
            persistEvent(tbl6)
            return
        end

        if tbl6.isVerifyingAudience or tbl6.isAwaitingEligibility then
            return
        end

        tbl6.isVerifyingAudience = true
        local success, result = pcall(var1.refreshSummary, tbl6.universeId)
        if not success or result == nil then
            handleAudienceVerificationFailure(tbl6)
            return
        end
        local num2 = num1
        result:andThen(function(arg1)
            if num1 ~= num2 or tbl2[tbl6.id] ~= tbl6 then
                return
            end

            local eligibility = var1.getEligibility(tbl6.universeId)
            if not eligibility.isResolved then
                awaitEligibility(tbl6, arg1)
                return
            end
            tbl6.isVerifyingAudience = false
            local tbl7 = tbl6
            tbl7.isEligiblePublish = var1.getAudience(arg1) == var1.publicAudience and eligibility.isEligible and eligibility.freePromotionsRemaining > 0

            persistEvent(tbl6)
        end, function()
            if num1 ~= num2 or tbl2[tbl6.id] ~= tbl6 then
                return
            end
            handleAudienceVerificationFailure(tbl6)
        end)
    end

    local function disposeAllEligibilitySubscriptions()
        local tbl6 = {}
        for value in tbl5 do
            table.insert(tbl6, value)
        end
        for _, value in tbl6 do
            disposeEligibilitySubscription(value)
        end
    end

    return {
        recordAdCampaignAttempt = FFlagBuildAgentAdCampaignCard and function(arg1, arg2): boolean
            local cardStorage = getCardStorage()

            if cardStorage == nil or not cardStorage.saveAttempt(arg1, arg2) then
                return false
            end

            bumpAdCampaignRevision()
            return true
        end or nil,
        getAdCampaignCard = FFlagBuildAgentAdCampaignCard and function(arg1, arg2)
            local cardStorage = getCardStorage()

            if cardStorage == nil then
                return { isAvailable = false, isPersisted = false }
            end
            return cardStorage.get(arg1, arg2)
        end or nil,
        listAdCampaignCards = FFlagBuildAgentAdCampaignCard and function(arg1)
            local cardStorage = getCardStorage()

            if cardStorage ~= nil then
                return cardStorage.list(arg1)
            end

            return {
                isAvailable = false,
                records = {}
            }
        end or nil,
        recordAdCampaignCreatedReceipt = FFlagBuildAgentAdCampaignCard and function(arg1)
            local cardStorage = getCardStorage()

            if cardStorage == nil then
                return false, false
            end
            local var8 = cardStorage.hasPendingWrites()
            local var9, var10 = cardStorage.confirm(arg1)
            return recordCardMutation(var9, var10, var8)
        end or nil,
        retryAdCampaignCardWrites = FFlagBuildAgentAdCampaignCard and function(): boolean
            local cardStorage = getCardStorage()

            if cardStorage == nil then
                return false
            end
            local var8 = cardStorage.hasPendingWrites()
            if not cardStorage.retryWrites() then
                return false
            end
            if var8 then
                bumpAdCampaignRevision()
            end

            return true
        end or nil,
        pruneAdCampaignCards = FFlagBuildAgentAdCampaignCard and function(arg1)
            local cardStorage = getCardStorage()

            if cardStorage == nil then
                return false, false
            end
            local var8, var9 = cardStorage.prune(arg1)
            if var9 then
                bumpAdCampaignRevision()
            end

            return var8, var9
        end or nil,
        getRevision = getRevision,
        getAdCampaignRevision = getAdCampaignRevision,
        reportAssistantTurnCompleted = function(arg1)
            if var1 == nil or arg1.universeId == 0 or var1.isDismissedPermanently(arg1.universeId) then
                return
            end
            local afterMessageKey = chatTypes.makeAssistantTurnAnchorKey(arg1.sessionId, arg1.latestSequenceId)
            if afterMessageKey == nil then
                return
            end
            local id = `chat:{arg1.universeId}:{afterMessageKey}`
            local requiresAudienceVerification = not not hasSuccessfulPublish(arg1.turnState)

            local var8 = retainPending({
                id = id,
                universeId = arg1.universeId,
                sessionId = if arg1.sessionId == "" then nil else arg1.sessionId,
                afterMessageKey = afterMessageKey,
                isCompletedTurn = true,
                isEligiblePublish = if requiresAudienceVerification then nil else false,
                requiresAudienceVerification = requiresAudienceVerification,
                isVerifyingAudience = false,
                isAwaitingEligibility = false,
                audienceVerificationAttempts = 0,
                storagePersistenceAttempts = 0
            })

            var7(var8)
        end,
        reportMenuPublish = function(universeId: number, sessionId: string?, str2: string, bool1: boolean)
            if var1 == nil or universeId == 0 or str2 == "" or var1.isDismissedPermanently(universeId) then
                return
            end
            local eligibility = var1.getEligibility(universeId)

            local requiresAudienceVerification = bool1 and not eligibility.isResolved
            local func2 = retainPending
            local tbl6 = {
                id = `menu:{universeId}:{str2}`,
                universeId = universeId,
                sessionId = 0,
                afterMessageKey = nil,
                isCompletedTurn = false,
                isEligiblePublish = 0,
                requiresAudienceVerification = 0,
                isVerifyingAudience = false,
                isAwaitingEligibility = false,
                audienceVerificationAttempts = 0,
                storagePersistenceAttempts = 0
            }

            if sessionId == "" then
                sessionId = nil
            end

            tbl6.sessionId = sessionId

            tbl6.isEligiblePublish = if requiresAudienceVerification then nil else bool1 and eligibility.isEligible and eligibility.freePromotionsRemaining > 0

            tbl6.requiresAudienceVerification = requiresAudienceVerification
            local var8 = func2(tbl6)

            var7(var8)
        end,
        retryStorageRead = function()
            if FFlagBuildAgentAdCampaignCard then
                local cardStorage = getCardStorage()

                if cardStorage ~= nil and cardStorage.hasPendingWrites() and cardStorage.retryWrites() then
                    bumpAdCampaignRevision()
                end
            end

            if var1 == nil or not var1.retryStorageRead() then
                return
            end

            if FFlagBuildAgentAdCampaignCard then
                bumpAdCampaignRevision()
            else
                bumpRevision()
            end

            for _, value in (table.clone(tbl3)) do
                local var8 = tbl2[value]
                if var8 ~= nil then
                    var8.storagePersistenceAttempts = 0
                    var7(var8)
                end
            end
        end,
        attachPendingMilestones = function(num2: number, str1: string, str2: string?)
            if var1 ~= nil then
                var1.attachPendingMilestones(num2, str1, str2)
                bumpRevision()
            end
        end,
        pruneAnchors = function(num2: number, str1: string, tbl6)
            if FFlagBuildAdUpsellPinned or var1 == nil then
                return false
            end

            local var8, var9 = var1.pruneAnchors(num2, str1, tbl6)
            if var9 then
                bumpRevision()
            end

            return var8
        end,
        getTransientCongratsMessageKey = function(str1: string)
            return if FFlagBuildAdUpsellPinned then tbl4[str1] else nil
        end,
        markAnchorImpressed = function(num2: number, str1: string, str2: string)
            if var1 == nil then
                return false
            end
            local var8 = var1.markAnchorImpressed(num2, str1, str2)
            if var8 then
                bumpRevision()
            end

            return var8
        end,
        dismissPermanently = function(universeId: number)
            if var1 == nil then
                return
            end

            for _, value in (table.clone(tbl3)) do
                local var8 = tbl2[value]
                if var8 ~= nil and var8.universeId == universeId then
                    removePending(value)
                end
            end

            var1.dismissPermanently(universeId)
            bumpRevision()
        end,
        reset = function()
            num1 += 1
            if var1 ~= nil and var6 ~= nil then
                var1.cancelRetry(var6)
            end
            var6 = nil
            disposeAllEligibilitySubscriptions()
            table.clear(tbl2)
            table.clear(tbl3)
            if FFlagBuildAdUpsellPinned then
                table.clear(tbl4)
            end
            var3(0)
            var5(0)
        end
    }
end
return createAdUpsellEventStore
