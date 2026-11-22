-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _HttpClient = require(MomentsParent.HttpClient)
local EventNames = require(MomentsParent.MomentsCommon).Analytics.EventNames
local _createCommentsAnalyticsSession = require(Moments.Components.Comments.createCommentsAnalyticsSession)
local getCommentsFailureReason = require(Moments.Analytics.getCommentsFailureReason)

local MomentsComments = require(MomentsParent.DataHydration.MomentsComments)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local SignalsExperimental = require(MomentsParent.SignalsExperimental)

local _createCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore.createCommentCollectionStore)

local _createCommentSessionFiltersStore = require(Moments.Components.Comments.GetCommentSessionFiltersStore.createCommentSessionFiltersStore)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentActionsRealtime = require(Moments.Flags.FFlagMomentsCommentActionsRealtime)
local FFlagMomentsCommentsCountAnalytics = require(Moments.Flags.FFlagMomentsCommentsCountAnalytics)
local FFlagMomentsCommentDeepLinks = SharedFlags.FFlagMomentsCommentDeepLinks

local CommentCollectionTypes = require(Moments.Components.Comments.GetCommentCollectionStore.CommentCollectionTypes)
local _createCommentReactionsStore = require(Moments.Stores.GetCommentReactionsStore.createCommentReactionsStore)

local LoadStatus = CommentCollectionTypes.LoadStatus

local tbl1 = { 250, 500 }

local tbl2 = {
    AuthenticationRequired = true,
    CommentsEndpointDisabled = true,
    ViewerNotEligibleToReact = true
}

local tbl3 = {
    CommentsDisabledByCreator = true,
    MomentUnavailable = true,
    ViewerNotEligibleToRead = true
}

local tbl4 = {
    CommentsDisabledByCreator = true,
    MomentNotFound = true,
    MomentNotVisible = true,
    ViewerNotEligibleToRead = true,
    ViewerNotEligibleToWrite = true
}

local tbl5 = {
    Jan = 1,
    Feb = 2,
    Mar = 3,
    Apr = 4,
    May = 5,
    Jun = 6,
    Jul = 7,
    Aug = 8,
    Sep = 9,
    Oct = 10,
    Nov = 11,
    Dec = 12
}

local function cursorKey(str1: string?): string -- Luacid: Inlined by compiler; 5 call sites recovered
    return str1 or "<initial>"
end

local function defaultSchedule(num1: number, func1: (...any) -> (...any))
    local var1 = task.delay(num1 / 1000, func1)
    return function()
        pcall(task.cancel, var1)
    end
end

local function defaultReadStatusCode(arg1, num1: number?)
    if num1 == nil then
        if arg1.response == nil then
            return arg1.errorCode
        end

        return arg1.response.statusCode
    end

    return num1
end

local function defaultReadRetryAfter(arg1)
    if arg1.headers == nil then
        return nil
    end

    return arg1.headers["retry-after"] or arg1.headers["Retry-After"]
end

local function parseHttpDateMs(str1: string)
    local var1, var2, var3, var4, var5, var6 = string.match(str1, "^%a%a%a, (%d%d) (%a%a%a) (%d%d%d%d) (%d%d):(%d%d):(%d%d) GMT$")
    local var7 = if var2 == nil then nil else tbl5[var2]

    if var1 == nil or var7 == nil or var3 == nil or var4 == nil or var5 == nil or var6 == nil then
        return nil
    end
    local success, result = pcall(DateTime.fromUniversalTime, tonumber(var3), var7, tonumber(var1), tonumber(var4), tonumber(var5), tonumber(var6))

    return if success then result.UnixTimestampMillis else nil
end

local function retryAfterDelayMs(str1: string?, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == nil then
        return 5000
    end
    local var1 = tonumber(str1)
    local var2 = if var1 == nil then nil else var1 * 1000

    if var2 == nil then
        local var3 = parseHttpDateMs(str1)
        if var3 == nil then
            var2 = nil
        else
            var2 = math.max(0, var3 - num1)
        end
    end

    return if var2 == nil or var2 < 0 or var2 > 60000 then 5000 else var2
end

local function definitePostRejectionCode(num1: number?, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "CommentsUnavailable" then
        return nil
    end

    if str1 ~= nil then
        return str1
    end

    if num1 == nil or num1 == 408 or num1 < 400 or num1 >= 500 then
        return nil
    end

    if num1 == 429 then
        return "RateLimited"
    elseif num1 == 401 then
        return "AuthenticationRequired"
    end

    return "PostRejected"
end

local function selectedEmoteId(reactions) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if reactions == nil or reactions.userReaction == nil then nil else reactions.userReaction.emoteId
end

local function isUncertainStatus(num1: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 == nil or num1 == 408 or not (num1 == nil or not (num1 >= 500)) and num1 <= 599
end

local function errorCodeFrom(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = MomentsComments.parseCommentsError(arg1.error)
    return if var1 == nil then "CommentsUnavailable" else var1.errorCode
end

local function observeRequest(arg1, callback: (...any) -> (...any))
    local bool1 = false
    local effect = nil

    local function stop()
        if bool1 then
            return
        end
        bool1 = true
        if effect ~= nil then
            effect()
            effect = nil
        end
        arg1.dispose()
    end

    local function settle(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 or arg2.status == "pending" then
            return
        end
        bool1 = true
        if effect ~= nil then
            effect()
            effect = nil
        end
        arg1.dispose()
        callback(arg2)
    end

    local var1 = arg1.state(false)
    if var1.status ~= "pending" then
        settle(var1)
        return stop
    end

    effect = Signals.createEffect(function(arg2)
        settle((arg1.state(arg2)))
    end)
    if bool1 and effect ~= nil then
        effect()
        effect = nil
    end

    return stop
end

local function rejectReactionMutation(_: string, _: string, _: string, _): boolean
    return false
end

local function noOp() end

local function createCommentsListCoordinator(tbl6)
    local collectionStore = tbl6.collectionStore
    local commentsStore = tbl6.commentsStore

    local reactionStore = tbl6.reactionStore
    local catalogStore = tbl6.catalogStore
    local var1 = tbl6.fetchPage or MomentsComments.fetchMomentComments
    local var2 = tbl6.fetchComment or MomentsComments.fetchMomentComment
    local var3 = tbl6.postComment or MomentsComments.postMomentComment
    local var4 = tbl6.putReaction or MomentsComments.putMomentCommentReaction
    local var5 = tbl6.deleteReaction or MomentsComments.deleteMomentCommentReaction
    local var6 = tbl6.deleteComment or MomentsComments.deleteMomentComment
    local sessionFilters = tbl6.sessionFilters
    local var7 = tbl6.nowMs or function(): number
        return DateTime.now().UnixTimestampMillis
    end
    local var8 = tbl6.schedule or defaultSchedule
    local var9 = tbl6.readStatusCode or defaultReadStatusCode
    local var10 = tbl6.readRetryAfter or defaultReadRetryAfter
    local reactionDebounceMs = tbl6.reactionDebounceMs or 500
    local var11 = nil
    local var12 = nil
    local tbl7 = ({})
    local tbl8 = ({})
    local tbl9 = ({})
    local tbl10 = ({})
    local var13 = nil
    local getPostCooldownUntilMs, var15 = Signals.createSignal(0)
    local var16 = nil
    local ownerGeneration = commentsStore.getOwnerGeneration(false)
    local bool1 = false
    local commentPostedCallback = nil
    local analyticsSession = nil

    local function cancelActivePage(tbl11) -- Luacid: Inlined by compiler; 7 call sites recovered
        local activePageRequest = tbl11.activePageRequest
        tbl11.activePageRequest = nil
        if activePageRequest ~= nil then
            activePageRequest.cancel()
        end
        local activePinnedRequest = tbl11.activePinnedRequest
        tbl11.activePinnedRequest = nil
        if activePinnedRequest ~= nil then
            tbl11.hasRequestedPinnedComment = false
            activePinnedRequest.cancel()
        end
    end

    local function getSession(feedItemId: string, sessionId: number) -- Luacid: Inlined by compiler; 8 call sites recovered
        local var17 = var11

        return if bool1
            or var17 == nil
            or var17.feedItemId ~= feedItemId
            or var17.sessionId ~= sessionId
            or var17.ownerGeneration ~= commentsStore.getOwnerGeneration(false)
            or var17.refCount == 0 then nil else var17
    end

    local function isCurrentRequestSession(session, feedItemId: string, sessionId: number, ownerGeneration2: number): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
        local bool2 = not bool1
        return bool2
            and var11 == session
            and session.feedItemId == feedItemId
            and session.sessionId == sessionId
            and session.ownerGeneration == ownerGeneration2
            and commentsStore.getOwnerGeneration(false) == ownerGeneration2
    end

    local function cancelIntentExpiry(str1: string) -- Luacid: Inlined by compiler; 17 call sites recovered
        local var17 = tbl9[str1]
        tbl9[str1] = nil
        if var17 ~= nil then
            var17()
        end
    end

    local function scheduleIntentExpiry(commentId: string, generation: number) -- Luacid: Inlined by compiler; 7 call sites recovered
        cancelIntentExpiry(commentId)

        tbl9[commentId] = var8(10000, function()
            tbl9[commentId] = nil
            if reactionStore.expireIntent(commentId, generation) then
                tbl10[commentId] = nil
            end
        end)
    end

    local function cancelReactionRequest(str1: string)
        local var17 = tbl7[str1]
        tbl7[str1] = nil
        if var17 == nil then
            return
        end
        if var17.cancelRequest ~= nil then
            var17.cancelRequest()
            var17.cancelRequest = nil
        end
        if var17.cancelRetry ~= nil then
            var17.cancelRetry()
            var17.cancelRetry = nil
        end
        if var17.cancelDebounce ~= nil then
            var17.cancelDebounce()
            var17.cancelDebounce = nil
        end
    end

    local function hardResetReaction(feedItemId: string, commentId: string, str1: string?, generation: number) -- Luacid: Inlined by compiler; 1 call site recovered
        cancelReactionRequest(commentId)
        cancelIntentExpiry(commentId)
        tbl10[commentId] = nil
        reactionStore.clearComment(commentId)
        if str1 ~= nil then
            reactionStore.setCommentRestriction(feedItemId, commentId, str1, generation)
        end
    end

    local function clearReactionState()
        local tbl11 = {}
        for value in tbl7 do
            table.insert(tbl11, value)
        end
        for _, value in tbl11 do
            cancelReactionRequest(value)
        end
        local tbl12 = {}
        for value in tbl9 do
            table.insert(tbl12, value)
        end
        for _, value in tbl12 do
            cancelIntentExpiry(value)
        end

        if var13 ~= nil then
            var13()
            var13 = nil
        end
        table.clear(tbl10)
        reactionStore.clear()
    end

    local function clearReactionsForFeed(feedItemId: string, str1: string?)
        local tbl11 = {}
        for value, value2 in tbl10 do
            if value2 == feedItemId then
                table.insert(tbl11, value)
            end
        end
        for _, value in tbl11 do
            cancelReactionRequest(value)
            cancelIntentExpiry(value)
            tbl10[value] = nil
        end
        reactionStore.clearFeed(feedItemId)
        reactionStore.setFeedRestriction(feedItemId, str1)
    end

    local function setReactionCooldown(str1: string?)
        local var17 = var7()
        local num1 = math.max(reactionStore.getCooldownUntilMs(false), var17 + retryAfterDelayMs(str1, var17))

        reactionStore.setCooldownUntilMs(num1)
        if var13 ~= nil then
            var13()
        end
        var13 = var8(math.max(0, num1 - var17), function()
            var13 = nil
            if reactionStore.getCooldownUntilMs(false) == num1 then
                reactionStore.setCooldownUntilMs(0)
            end
        end)
    end

    local function clearPostCooldown() -- Luacid: Inlined by compiler; 5 call sites recovered
        if var16 ~= nil then
            var16()
            var16 = nil
        end
        var15(0)
    end

    local function setPostCooldown(str1: string?)
        local var17 = var7()
        local num1 = math.max(getPostCooldownUntilMs(false), var17 + retryAfterDelayMs(str1, var17))
        var15(num1)
        if var16 ~= nil then
            var16()
        end
        var16 = var8(math.max(0, num1 - var17), function()
            var16 = nil
            if getPostCooldownUntilMs(false) == num1 then
                var15(0)
            end
        end)
    end

    local function isPostCoolingDown(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        local var17 = getPostCooldownUntilMs(false)
        if var17 == 0 then
            return false
        end
        if var7() < var17 then
            return true
        end

        clearPostCooldown()
        return false
    end

    local function markFeedUnavailable(feedItemId: string, str1: string)
        local var17 = var11
        if var17 == nil or var17.feedItemId ~= feedItemId or var17.ownerGeneration ~= commentsStore.getOwnerGeneration(false) then
            return
        end

        cancelActivePage(var17)
        local str2 = if collectionStore.getState(feedItemId)(false).initialLoadStatus == LoadStatus.Success then "more" else "initial"
        collectionStore.failLoad(feedItemId, str2, str1)
    end

    local function getOpenAnalyticsSession(feedItemId: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var17 = var11
        if tbl6.getAnalyticsSession == nil or var17 == nil or var17.feedItemId ~= feedItemId then
            return nil
        end
        return tbl6.getAnalyticsSession(feedItemId, var17.sessionId)
    end

    local function logReactionRequest(tbl11, verb: string, status: string, failureReason: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local analyticsSession2 = tbl11.analyticsSession
        if analyticsSession2 == nil then
            return
        end
        local tbl12 = {
            status = status,
            action = if verb == "PUT" then "add" else "remove"
        }
        if failureReason ~= nil then
            tbl12.failureReason = failureReason
        end
        analyticsSession2.logRealtimeEvent("MomentsCommentReaction", tbl12)
    end

    local function commitProjectedReaction(tbl11)
        local intent = reactionStore.getIntent(tbl11.commentId, false)
        if intent == nil or intent.generation ~= tbl11.generation then
            return false
        end
        local var17 = commentsStore.getCachedComment(tbl11.commentId).data(false)
        if var17 == nil then
            return reactionStore.markLocallyConfirmed(tbl11.commentId, tbl11.generation)
        end

        local reactions = reactionStore.getProjection(tbl11.feedItemId, tbl11.commentId, var17.reactions, false).reactions
        if reactions == nil then
            return reactionStore.markLocallyConfirmed(tbl11.commentId, tbl11.generation)
        end
        local var18 = table.clone(var17)
        var18.reactions = reactions
        local bool2 = false
        SignalsExperimental.batch(function()
            commentsStore.upsertComments({ var18 }, tbl11.ownerGeneration)
            bool2 = reactionStore.confirmAndRebase(tbl11.commentId, tbl11.generation, reactions)
        end)
        return bool2
    end

    local function retainUncertainUntilExpiry(tbl11) -- Luacid: Inlined by compiler; 3 call sites recovered
        tbl7[tbl11.commentId] = nil
        tbl11.cancelRetry = nil
        reactionStore.markUncertain(tbl11.commentId, tbl11.generation)
        scheduleIntentExpiry(tbl11.commentId, tbl11.generation)
    end

    local function rollbackReaction(tbl11, str1: string?)
        cancelIntentExpiry(tbl11.commentId)
        if not reactionStore.rollback(tbl11.commentId, tbl11.generation, str1) then
            return
        end
        local intent = reactionStore.getIntent(tbl11.commentId, false)
        if intent ~= nil and intent.status == "LocallyConfirmed" then
            tbl10[tbl11.commentId] = tbl11.feedItemId
            scheduleIntentExpiry(tbl11.commentId, intent.generation)
            return
        end
        tbl10[tbl11.commentId] = nil
    end

    local function applyTerminalFailure(tbl11, num1: number?, str1: string)
        if str1 == "MomentUnavailable" then
            clearReactionsForFeed(tbl11.feedItemId, str1)
            markFeedUnavailable(tbl11.feedItemId, str1)
            return
        end

        if tbl2[str1] then
            clearReactionState()
            reactionStore.setGlobalRestriction(str1)
            return
        end

        if tbl4[str1] then
            clearReactionsForFeed(tbl11.feedItemId, str1)
            return
        end

        if str1 == "CommentNotFound" or num1 == 404 then
            hardResetReaction(tbl11.feedItemId, tbl11.commentId, str1, tbl11.generation)
        else
            rollbackReaction(tbl11, str1)
        end
    end

    local function func1(tbl11)
        if bool1
            or tbl7[tbl11.commentId] ~= tbl11
            or commentsStore.getOwnerGeneration(false) ~= tbl11.ownerGeneration
            or reactionStore.getIntent(tbl11.commentId, false) == nil
        then
            return
        end

        if not tbl11.syncIsUncertain and tbl11.desiredEmoteId == tbl11.syncedEmoteId then
            tbl7[tbl11.commentId] = nil
            rollbackReaction(tbl11, nil)
            return
        end

        local startedAtMs = var7()
        local cooldownUntilMs = reactionStore.getCooldownUntilMs(false)
        if startedAtMs < cooldownUntilMs then
            reactionStore.markUncertain(tbl11.commentId, tbl11.generation)
            local var18 = cooldownUntilMs - startedAtMs
            if startedAtMs - tbl11.startedAtMs + var18 <= 2000 then
                tbl11.cancelRetry = var8(var18, function()
                    tbl11.cancelRetry = nil
                    func1(tbl11)
                end)

                return
            end

            retainUncertainUntilExpiry(tbl11)
            return
        end

        if cooldownUntilMs > 0 then
            reactionStore.setCooldownUntilMs(0)
        end

        if tbl11.attemptGeneration ~= tbl11.generation then
            tbl11.attemptGeneration = tbl11.generation
            tbl11.attempt = 0
            tbl11.startedAtMs = startedAtMs
        end
        if tbl11.attempt > 0 and startedAtMs - tbl11.startedAtMs > 2000 then
            retainUncertainUntilExpiry(tbl11)
            return
        end
        tbl11.attempt += 1
        if not reactionStore.markPending(tbl11.commentId, tbl11.generation) then
            tbl7[tbl11.commentId] = nil
            return
        end

        tbl11.readyToCommit = false
        local generation = tbl11.generation
        local desiredEmoteId = tbl11.desiredEmoteId
        local verb = tbl11.verb
        local statusCode = nil
        local var18 = nil
        local tbl12 = {
            [429] = {
                function(arg1)
                    statusCode = arg1.statusCode
                    var18 = var10(arg1)
                end
            }
        }

        local var19 = (if verb == "PUT" then var4 else var5)(tbl11.feedItemId, tbl11.commentId, tbl11.emoteId, tbl6.network, tbl12)
        if FFlagMomentsCommentActionsRealtime then
            logReactionRequest(tbl11, verb, "attempted", nil)
        end

        tbl11.cancelRequest = observeRequest(var19, function(arg1)
            if bool1 or tbl7[tbl11.commentId] ~= tbl11 or commentsStore.getOwnerGeneration(false) ~= tbl11.ownerGeneration then
                return
            end
            tbl11.cancelRequest = nil

            if FFlagMomentsCommentActionsRealtime and arg1.status == "succeeded" then
                logReactionRequest(tbl11, verb, "succeeded", nil)
            end
            if arg1.status == "succeeded" then
                tbl11.syncedEmoteId = desiredEmoteId
                tbl11.syncIsUncertain = false
                if tbl11.generation ~= generation then
                    if tbl11.desiredEmoteId == tbl11.syncedEmoteId then
                        tbl7[tbl11.commentId] = nil
                        if commitProjectedReaction(tbl11) then
                            scheduleIntentExpiry(tbl11.commentId, tbl11.generation)
                            return
                        end
                    elseif tbl11.readyToCommit then
                        func1(tbl11)
                    end
                    return
                end
                tbl7[tbl11.commentId] = nil
                if commitProjectedReaction(tbl11) then
                    scheduleIntentExpiry(tbl11.commentId, generation)

                    return
                end

                return
            end

            local var20 = var9(arg1, statusCode)
            local var21 = MomentsComments.parseCommentsError(arg1.error)
            local var22 = if var21 == nil then "CommentsUnavailable" else var21.errorCode
            if FFlagMomentsCommentActionsRealtime then
                logReactionRequest(tbl11, verb, "failed", (getCommentsFailureReason(var22, var20)))
            end
            if var20 == 429 then
                tbl7[tbl11.commentId] = nil
                rollbackReaction(tbl11, nil)
                setReactionCooldown(var18)
                return
            end

            if not isUncertainStatus(var20) then
                tbl7[tbl11.commentId] = nil
                applyTerminalFailure(tbl11, var20, var22)
                return
            end

            tbl11.syncIsUncertain = true
            if tbl11.generation ~= generation then
                if tbl11.readyToCommit then
                    func1(tbl11)
                end
                return
            end
            reactionStore.markUncertain(tbl11.commentId, generation)
            local var23 = tbl1[tbl11.attempt]

            if not (tbl11.attempt <= 2) or var23 == nil or not (var7() - tbl11.startedAtMs + var23 <= 2000) then
                retainUncertainUntilExpiry(tbl11)
                return
            end

            tbl11.cancelRetry = var8(var23, function()
                tbl11.cancelRetry = nil

                if tbl7[tbl11.commentId] == tbl11 and commentsStore.getOwnerGeneration(false) == tbl11.ownerGeneration then
                    func1(tbl11)
                end
            end)
        end)
    end

    local function scheduleReactionCommit(tbl11)
        if tbl11.cancelDebounce ~= nil then
            tbl11.cancelDebounce()
            tbl11.cancelDebounce = nil
        end
        tbl11.readyToCommit = false
        if reactionDebounceMs <= 0 then
            tbl11.readyToCommit = true
            if tbl11.cancelRequest == nil and tbl11.cancelRetry == nil then
                func1(tbl11)
            end
            return
        end
        tbl11.cancelDebounce = var8(reactionDebounceMs, function()
            tbl11.cancelDebounce = nil
            if bool1 or tbl7[tbl11.commentId] ~= tbl11 then
                return
            end
            tbl11.readyToCommit = true
            if tbl11.cancelRequest == nil and tbl11.cancelRetry == nil then
                func1(tbl11)
            end
        end)
    end

    local function beginReactionMutation(feedItemId: string, commentId: string, emoteId: string, arg1, desiredEmoteId: string?, verb: string, syncedEmoteId: string?): boolean
        if bool1 or reactionStore.getRestriction(feedItemId, commentId, false) ~= nil then
            return false
        end
        local startedAtMs = var7()
        local cooldownUntilMs = reactionStore.getCooldownUntilMs(false)
        if startedAtMs < cooldownUntilMs then
            return false
        end

        if cooldownUntilMs > 0 then
            reactionStore.setCooldownUntilMs(0)
        end

        cancelIntentExpiry(commentId)
        local var18 = reactionStore.beginIntent(feedItemId, commentId, arg1, desiredEmoteId)
        local tbl11 = tbl7[commentId]
        if tbl11 == nil then
            tbl11 = {
                feedItemId = feedItemId,
                commentId = commentId,
                emoteId = emoteId,
                verb = verb,
                generation = var18,
                ownerGeneration = commentsStore.getOwnerGeneration(false),
                attempt = 0,
                startedAtMs = startedAtMs,
                attemptGeneration = var18,
                desiredEmoteId = desiredEmoteId,
                syncedEmoteId = syncedEmoteId,
                syncIsUncertain = false,
                readyToCommit = false,
                cancelRequest = nil,
                cancelRetry = nil,
                cancelDebounce = nil
            }

            tbl7[commentId] = tbl11
        else
            tbl11.verb = verb
            tbl11.generation = var18
            tbl11.desiredEmoteId = desiredEmoteId
            if tbl11.cancelRetry ~= nil then
                tbl11.cancelRetry()
                tbl11.cancelRetry = nil
                tbl11.syncIsUncertain = true
            end
        end
        if FFlagMomentsCommentActionsRealtime then
            tbl11.analyticsSession = getOpenAnalyticsSession(feedItemId)
        end
        tbl10[commentId] = feedItemId
        scheduleReactionCommit(tbl11)
        return true
    end

    local function ensureReactionPresent(feedItemId: string, commentId: string, str1: string, arg1)
        if arg1 == nil then
            return false
        end
        local reactions = reactionStore.getProjection(feedItemId, commentId, arg1, false).reactions

        if reactions == nil or selectedEmoteId(reactions) ~= nil then
            return false
        end
        return (beginReactionMutation(feedItemId, commentId, str1, arg1, str1, "PUT", nil))
    end

    local function ensureReactionAbsent(feedItemId: string, commentId: string, str1: string, arg1)
        if arg1 == nil then
            return false
        end
        local reactions = reactionStore.getProjection(feedItemId, commentId, arg1, false).reactions

        if reactions == nil or selectedEmoteId(reactions) ~= str1 then
            return false
        end
        return (beginReactionMutation(feedItemId, commentId, str1, arg1, nil, "DELETE", str1))
    end

    local var17 = nil

    local function failInvalidContinuation(feedItemId: string)
        local var18 = collectionStore.getState(feedItemId)(false)
        if #var18.orderedCommentIds > 0 or var18.pendingSubmission ~= nil then
            collectionStore.failLoad(feedItemId, "more", "CommentsUnavailable")
            return
        end
        collectionStore.failLoad(feedItemId, "initial", "CommentsUnavailable")
    end

    local function continueAfterMerge(feedItemId: string, sessionId: number, result, shouldContinuePaging: boolean)
        if not result.hasMore then
            return
        end

        local session = getSession(feedItemId, sessionId)

        if session == nil then
            return
        end

        local nextCursor = result.nextCursor

        if nextCursor == nil or session.requestedCursors[cursorKey(nextCursor)] == true then
            failInvalidContinuation(feedItemId)
            return
        end

        if shouldContinuePaging then
            var17(feedItemId, sessionId, "more", nextCursor)
        end
    end

    local function commentsForUpsert(tbl11, generation: number)
        local var18 = table.create(#tbl11)
        for _, value in tbl11 do
            local intent = reactionStore.getIntent(value.commentId, false)
            local bool2 = not (value.reactions == nil or intent == nil) and selectedEmoteId(value.reactions) == intent.desiredEmoteId

            if intent ~= nil and generation < intent.generation and not bool2 then
                local var19 = commentsStore.getCachedComment(value.commentId).data(false)
                if var19 ~= nil then
                    value = table.clone(value)
                    value.reactions = var19.reactions
                end
            end
            table.insert(var18, value)
        end
        return var18
    end

    local function requestPinnedComment(session, feedItemId: string, sessionId: number)
        if session.hasRequestedPinnedComment or tbl6.getPinnedCommentId == nil then
            return
        end
        session.hasRequestedPinnedComment = true
        local pinnedCommentId = tbl6.getPinnedCommentId(feedItemId, sessionId)
        if pinnedCommentId == nil or pinnedCommentId == "" then
            return
        end
        local ownerGeneration2 = commentsStore.getOwnerGeneration(false)
        local generation = reactionStore.getGeneration(false)
        local var18 = var2(feedItemId, pinnedCommentId, tbl6.network)
        local activePinnedRequest = {
            cancel = function() end
        }
        session.activePinnedRequest = activePinnedRequest
        activePinnedRequest.cancel = observeRequest(var18, function(arg1)
            if not isCurrentRequestSession(session, feedItemId, sessionId, ownerGeneration2)
                or session.activePinnedRequest ~= activePinnedRequest
            then
                return
            end
            session.activePinnedRequest = nil
            local result = if arg1.status == "succeeded" then arg1.result else nil

            if result == nil or result.commentId ~= pinnedCommentId or result.feedItemId ~= feedItemId or result.status ~= "Active" then
                return
            end

            local userId = if result.author == nil then nil else result.author.userId

            if sessionFilters ~= nil
                and (sessionFilters.isCommentSessionHidden(pinnedCommentId)
                    or userId ~= nil and sessionFilters.isAuthorRecentlyBlocked(userId))
            then
                return
            end
            commentsStore.upsertComments(commentsForUpsert({ result }, generation), ownerGeneration2)
            if reactionStore.reconcile(feedItemId, pinnedCommentId, result.reactions, generation) then
                cancelReactionRequest(pinnedCommentId)
                cancelIntentExpiry(pinnedCommentId)
                tbl10[pinnedCommentId] = nil
            end
            collectionStore.setPinnedComment(feedItemId, pinnedCommentId)
        end)
    end

    var17 = function(feedItemId: string, sessionId: number, str1: string, cursor: string?)
        local session = getSession(feedItemId, sessionId)

        if session == nil or session.activePageRequest ~= nil then
            return false
        end
        local ownerGeneration2 = commentsStore.getOwnerGeneration(false)
        local var18 = if FFlagMomentsComments then reactionStore.getGeneration(false) else 0
        if str1 == "more" then
            if cursor == nil or session.requestedCursors[cursorKey(cursor)] == true then
                failInvalidContinuation(feedItemId)
                return false
            end

            local str2 = cursorKey(cursor)

            session.requestedCursors[str2] = true
        end

        if str1 == "initial" then
            collectionStore.beginInitialLoad(feedItemId)
        else
            collectionStore.beginLoadMore(feedItemId)
        end

        local analyticsSession2 = nil
        local loadType = if str1 == "more" then "pagination" else session.initialLoadType
        if FFlagMomentsComments and tbl6.getAnalyticsSession ~= nil then
            analyticsSession2 = tbl6.getAnalyticsSession(feedItemId, sessionId)
            if analyticsSession2 ~= nil then
                analyticsSession2.logEvent(EventNames.MomentCommentsListLoadAttempted, { loadType = loadType })
            end
        end
        local var20 = var1({ feedItemId = feedItemId, cursor = cursor, sort = "newest" }, tbl6.network)

        local activePageRequest = {
            cancel = function() end
        }
        session.activePageRequest = activePageRequest

        activePageRequest.cancel = observeRequest(var20, function(arg1)
            if not isCurrentRequestSession(session, feedItemId, sessionId, ownerGeneration2)
                or session.activePageRequest ~= activePageRequest
            then
                return
            end
            session.activePageRequest = nil

            if FFlagMomentsComments and analyticsSession2 ~= nil then
                if arg1.status == "succeeded" and arg1.result ~= nil then
                    local tbl12 = { loadType = loadType }
                    if FFlagMomentsCommentsCountAnalytics then
                        tbl12.loadedCommentCount = tostring(#arg1.result.comments)
                    end
                    analyticsSession2.logEvent(EventNames.MomentCommentsListLoadSucceeded, tbl12)
                else
                    analyticsSession2.logEvent(
                        EventNames.MomentCommentsListLoadFailed,
                        {
                            loadType = loadType,
                            failureReason = getCommentsFailureReason(errorCodeFrom(arg1), var9(arg1, nil))
                        }
                    )
                end
            end
            if arg1.status == "succeeded" and arg1.result ~= nil then
                if FFlagMomentsComments then
                    commentsStore.upsertComments(commentsForUpsert(arg1.result.comments, var18), ownerGeneration2)

                    for _, comment in arg1.result.comments do
                        if reactionStore.reconcile(feedItemId, comment.commentId, comment.reactions, var18) then
                            cancelReactionRequest(comment.commentId)
                            cancelIntentExpiry(comment.commentId)
                            tbl10[comment.commentId] = nil
                        end
                    end
                else
                    commentsStore.upsertComments(arg1.result.comments, ownerGeneration2)
                end

                local var21 = if str1 == "initial" then collectionStore.completeInitialLoad(feedItemId, arg1.result) else collectionStore.completeLoadMore(feedItemId, arg1.result)
                continueAfterMerge(feedItemId, sessionId, arg1.result, var21.shouldContinuePaging)
                return
            end

            local var21 = errorCodeFrom(arg1)

            if FFlagMomentsComments and var21 == "MomentUnavailable" then
                clearReactionsForFeed(feedItemId, var21)
            end
            if str1 == "more" and var21 == "InvalidCursor" then
                if FFlagMomentsComments then
                    session.initialLoadType = "refresh"
                end
                collectionStore.resetListSession(feedItemId)
                table.clear(session.requestedCursors)
                var17(feedItemId, sessionId, "initial", nil)
                return
            end
            if str1 == "more" and cursor ~= nil then
                session.requestedCursors[cursorKey(cursor)] = nil
            end
            collectionStore.failLoad(feedItemId, str1, var21)
        end)

        if isCurrentRequestSession(session, feedItemId, sessionId, ownerGeneration2) then
            if FFlagMomentsCommentDeepLinks and str1 == "initial" then
                requestPinnedComment(session, feedItemId, sessionId)
            end

            return true
        end

        if session.activePageRequest == activePageRequest then
            session.activePageRequest = nil
        end
        activePageRequest.cancel()
        return false
    end

    local function revokeViewerWrite(feedItemId: string, ownerGeneration2: number)
        local var18 = commentsStore.getCachedMomentComments(feedItemId).data(false)
        if var18 == nil then
            markFeedUnavailable(feedItemId, "ViewerNotEligibleToWrite")
            return
        end
        local var19 = table.clone(var18)
        var19.viewerCanWrite = false
        commentsStore.upsertMomentComments({ [feedItemId] = var19 }, ownerGeneration2)
    end

    local function incrementMomentCommentCount(feedItemId: string, ownerGeneration2: number)
        local var18 = commentsStore.getCachedMomentComments(feedItemId).data(false)

        if var18 == nil or var18.count == nil or var18.countIsCapped == true then
            return
        end
        local var19 = table.clone(var18)
        var19.count = var18.count + 1
        commentsStore.upsertMomentComments({ [feedItemId] = var19 }, ownerGeneration2)
    end

    local function startPendingPost(session, feedItemId: string, sessionId: number, pendingSubmission, bool2: boolean?): boolean
        if var12 ~= nil then
            return false
        end
        local ownerGeneration2 = commentsStore.getOwnerGeneration(false)
        local statusCode = nil
        local var18 = nil

        local var19 = FFlagMomentsComments and {
            [429] = {
                function(arg1)
                    statusCode = arg1.statusCode
                    var18 = var10(arg1)
                end
            }
        } or nil

        local var14 = analyticsSession
        if FFlagMomentsComments and var14 ~= nil then
            var14.logEvent(EventNames.MomentCommentPostAttempted)
        end
        local var21 = var3(
            feedItemId,
            {
                text = pendingSubmission.text,
                clientRequestId = pendingSubmission.clientRequestId
            },
            tbl6.network,
            var19
        )
        local tbl11 = {
            analyticsSession = var14,
            clientRequestId = pendingSubmission.clientRequestId,
            feedItemId = feedItemId,
            sessionId = sessionId,
            ownerGeneration = ownerGeneration2,
            cancel = function() end
        }
        var12 = tbl11
        tbl11.cancel = observeRequest(var21, function(arg1)
            if var12 ~= tbl11
                or tbl11.feedItemId ~= feedItemId
                or tbl11.sessionId ~= sessionId
                or tbl11.ownerGeneration ~= ownerGeneration2
                or not isCurrentRequestSession(session, feedItemId, sessionId, ownerGeneration2)
            then
                return
            end
            var12 = nil

            local pendingSubmission2 = collectionStore.getPendingSubmission(feedItemId)
            if pendingSubmission2 == nil or pendingSubmission2.clientRequestId ~= tbl11.clientRequestId then
                return
            end

            if arg1.status == "succeeded" and arg1.result ~= nil then
                commentsStore.upsertComments({ arg1.result }, ownerGeneration2)
                collectionStore.resolvePendingSubmission(feedItemId, arg1.result)
                incrementMomentCommentCount(feedItemId, ownerGeneration2)
                if FFlagMomentsComments and var14 ~= nil then
                    var14.logEvent(EventNames.MomentCommentPostResult, { outcome = "success", commentId = arg1.result.commentId })
                end

                if FFlagMomentsComments then
                    local var22 = commentPostedCallback
                    commentPostedCallback = nil
                    if var22 ~= nil then
                        var22(arg1.result.text)
                    end
                end

                return
            end

            if not FFlagMomentsComments then
                local var22 = MomentsComments.parseCommentsError(arg1.error)
                if var22 ~= nil and (var22.errorCode == "TextFilterRejected" or var22.errorCode == "RateLimited") then
                    collectionStore.rejectPendingSubmission(feedItemId, var22.errorCode)
                    if FFlagMomentsComments then
                        commentPostedCallback = nil
                    end
                else
                    collectionStore.markPendingOutcomeUnknown(feedItemId)
                end

                return
            end

            local var22 = var9(arg1, statusCode)
            local var23 = MomentsComments.parseCommentsError(arg1.error)
            local errorCode = if var23 == nil then nil else var23.errorCode
            local var24 = definitePostRejectionCode(var22, errorCode)

            if bool2 and var24 ~= nil and (var22 == 429 or var23 == nil) then
                var24 = nil
            end

            if var22 == 429 then
                setPostCooldown(var18)
            end
            if var14 ~= nil then
                var14.logEvent(EventNames.MomentCommentPostResult, {
                    outcome = if var24 == nil then "unknown" else "rejected",
                    failureReason = getCommentsFailureReason(if var23 == nil then nil else var23.errorCode, var22)
                })
            end

            if var24 == nil then
                collectionStore.markPendingOutcomeUnknown(feedItemId)
                return
            end

            collectionStore.rejectPendingSubmission(feedItemId, var24)
            if tbl3[var24] then
                markFeedUnavailable(feedItemId, var24)
            elseif var24 == "ViewerNotEligibleToWrite" then
                revokeViewerWrite(feedItemId, ownerGeneration2)
            end
        end)

        if isCurrentRequestSession(session, feedItemId, sessionId, ownerGeneration2) then
            return true
        end

        if var12 == tbl11 then
            var12 = nil
        end
        tbl11.cancel()
        return false
    end

    local function submitComment(feedItemId: string, sessionId: number, str1: string)
        local session = getSession(feedItemId, sessionId)

        if session == nil or var12 ~= nil or collectionStore.getPendingSubmission(feedItemId) ~= nil then
            return false
        end

        if FFlagMomentsComments and isPostCoolingDown() then
            return false
        end

        local var18 = collectionStore.beginPendingSubmission(feedItemId, str1)
        local pendingSubmission = collectionStore.getPendingSubmission(feedItemId)
        if pendingSubmission == nil or pendingSubmission.clientRequestId ~= var18 then
            return false
        end
        if FFlagMomentsComments and tbl6.getAnalyticsSession ~= nil then
            analyticsSession = tbl6.getAnalyticsSession(feedItemId, sessionId)
        end
        if FFlagMomentsComments and tbl6.getCommentPostedCallback ~= nil then
            commentPostedCallback = tbl6.getCommentPostedCallback(feedItemId, sessionId)
        end
        return (startPendingPost(session, feedItemId, sessionId, pendingSubmission))
    end

    local function retryPendingSubmission(feedItemId: string, sessionId: number)
        local session = getSession(feedItemId, sessionId)

        if session == nil or var12 ~= nil then
            return false
        end

        local pendingSubmission = collectionStore.getPendingSubmission(feedItemId)
        if pendingSubmission == nil
            or pendingSubmission.status ~= "OutcomeUnknown"
            or FFlagMomentsComments and isPostCoolingDown()
        then
            return false
        else
            collectionStore.markPendingSending(feedItemId)
            local pendingSubmission2 = collectionStore.getPendingSubmission(feedItemId)
            if pendingSubmission2 == nil or pendingSubmission2.clientRequestId ~= pendingSubmission.clientRequestId then
                return false
            end
            return (startPendingPost(session, feedItemId, sessionId, pendingSubmission2, true))
        end
    end

    local function editPendingSubmission(feedItemId: string, sessionId: number): boolean
        if getSession(feedItemId, sessionId) == nil or var12 ~= nil then
            return false
        end
        local pendingSubmission = collectionStore.getPendingSubmission(feedItemId)
        if pendingSubmission == nil or pendingSubmission.status ~= "OutcomeUnknown" then
            return false
        end
        collectionStore.rejectPendingSubmission(feedItemId, "SubmissionOutcomeUnknown")
        return true
    end

    local function decrementMomentCommentCount(feedItemId: string, ownerGeneration2: number)
        local var18 = commentsStore.getCachedMomentComments(feedItemId).data(false)
        if var18 == nil or var18.count == nil or var18.countIsCapped == true or var18.count <= 0 then
            return
        end
        local var19 = table.clone(var18)
        var19.count = var18.count - 1
        commentsStore.upsertMomentComments({ [feedItemId] = var19 }, ownerGeneration2)
    end

    local function removeDeletedComment(feedItemId: string, str1: string, ownerGeneration2: number)
        if sessionFilters ~= nil then
            sessionFilters.hideCommentForSession(str1)
        end

        local var18 = collectionStore.getState(feedItemId)(false)

        if table.find(var18.orderedCommentIds, str1) ~= nil or table.find(var18.stickyPostedCommentIds, str1) ~= nil then
            collectionStore.removeCommentId(feedItemId, str1)
        end
        if FFlagMomentsComments then
            cancelReactionRequest(str1)
            cancelIntentExpiry(str1)
            tbl10[str1] = nil
            reactionStore.clearComment(str1)
        end
        decrementMomentCommentCount(feedItemId, ownerGeneration2)
    end

    local function deleteComment(feedItemId: string, str1: string, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?): boolean
        if bool1 or tbl8[str1] ~= nil then
            return false
        end
        local ownerGeneration2 = commentsStore.getOwnerGeneration(false)
        local commentDeletedCallback = nil
        if FFlagMomentsComments and tbl6.getCommentDeletedCallback ~= nil then
            local var18 = var11
            if var18 ~= nil and var18.feedItemId == feedItemId then
                commentDeletedCallback = tbl6.getCommentDeletedCallback(feedItemId, var18.sessionId)
            end
        end
        local analyticsSession2 = nil
        if FFlagMomentsCommentActionsRealtime then
            local var18 = var11
            if tbl6.getAnalyticsSession == nil or var18 == nil or var18.feedItemId ~= feedItemId then
                analyticsSession2 = nil
            else
                analyticsSession2 = tbl6.getAnalyticsSession(feedItemId, var18.sessionId)
            end
        end
        local var18 = var6(feedItemId, str1, tbl6.network)
        if FFlagMomentsCommentActionsRealtime and analyticsSession2 ~= nil then
            analyticsSession2.logRealtimeEvent("MomentsCommentDelete", { status = "attempted" })
        end
        local tbl11 = {
            cancel = function() end
        }
        tbl8[str1] = tbl11
        tbl11.cancel = observeRequest(var18, function(arg1)
            if tbl8[str1] ~= tbl11 then
                return
            end
            tbl8[str1] = nil
            if bool1 or commentsStore.getOwnerGeneration(false) ~= ownerGeneration2 then
                return
            end
            local var19 = MomentsComments.parseCommentsError(arg1.error)
            local bool2 = var9(arg1, nil) == 404 or not (var19 == nil) and var19.errorCode == "CommentNotFound"

            if FFlagMomentsCommentActionsRealtime and analyticsSession2 ~= nil then
                if arg1.status == "succeeded" then
                    analyticsSession2.logRealtimeEvent("MomentsCommentDelete", { status = "succeeded" })
                elseif bool2 then
                    analyticsSession2.logRealtimeEvent("MomentsCommentDelete", { status = "already_deleted" })
                else
                    local logRealtimeEvent = analyticsSession2.logRealtimeEvent

                    local var20 = getCommentsFailureReason
                    local var21 = errorCodeFrom(arg1)
                    local tbl12 = { status = "failed", failureReason = 0 }
                    local str2 = "MomentsCommentDelete"
                    tbl12.failureReason = var20(var21, var9(arg1, nil))
                    logRealtimeEvent(str2, tbl12)
                end
            end

            if arg1.status == "succeeded" or bool2 then
                removeDeletedComment(feedItemId, str1, ownerGeneration2)
                if FFlagMomentsComments and arg1.status == "succeeded" and callback2 ~= nil then
                    callback2()
                end
            elseif callback ~= nil then
                callback()
            end

            if FFlagMomentsComments and arg1.status == "succeeded" and commentDeletedCallback ~= nil then
                commentDeletedCallback()
            end
        end)
        return true
    end

    local function cancelActiveDeletes() -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl11 = tbl8
        tbl8 = {}
        for _, value in tbl11 do
            value.cancel()
        end
    end

    local function cancelActivePost(bool2: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var18 = var12
        var12 = nil
        if var18 == nil then
            return
        end

        if FFlagMomentsComments
            and var18.analyticsSession ~= nil
            and var18.ownerGeneration == commentsStore.getOwnerGeneration(false)
        then
            var18.analyticsSession.logEvent(
                EventNames.MomentCommentPostResult,
                { outcome = "cancelled", failureReason = "cancelled" }
            )
        end
        var18.cancel()
        if not bool2 then
            return
        end

        local pendingSubmission = collectionStore.getPendingSubmission(var18.feedItemId)
        if pendingSubmission ~= nil and pendingSubmission.clientRequestId == var18.clientRequestId then
            collectionStore.markPendingOutcomeUnknown(var18.feedItemId)
        end
    end

    local function retireActiveSession(bool2: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
        if FFlagMomentsComments and not bool2 then
            commentPostedCallback = nil
        end
        local var18 = var11
        var11 = nil
        if var18 ~= nil then
            cancelActivePage(var18)
        end

        cancelActivePost(bool2)
        if FFlagMomentsComments and not bool2 then
            analyticsSession = nil
        end
    end

    local function acquireSession(feedItemId: string, sessionId: number)
        if bool1 then
            return function() end
        end
        if FFlagMomentsComments and catalogStore ~= nil and catalogStore.getAndFetchEmojiSets ~= nil then
            catalogStore.getAndFetchEmojiSets()
        end
        local ownerGeneration2 = commentsStore.getOwnerGeneration(false)
        local tbl11 = var11
        if tbl11 == nil
            or tbl11.feedItemId ~= feedItemId
            or tbl11.sessionId ~= sessionId
            or tbl11.ownerGeneration ~= ownerGeneration2
        then
            local bool2 = not (tbl11 == nil or tbl11.feedItemId ~= feedItemId) and tbl11.ownerGeneration == ownerGeneration2
            retireActiveSession(bool2)
            collectionStore.selectFeed(feedItemId, ownerGeneration2)
            tbl11 = {
                feedItemId = feedItemId,
                sessionId = sessionId,
                ownerGeneration = ownerGeneration2,
                refCount = 0,
                activePageRequest = nil,
                activePinnedRequest = nil,
                hasRequestedPinnedComment = false,
                requestedCursors = {},
                initialLoadType = "initial"
            }

            var11 = tbl11
            collectionStore.beginListSession(feedItemId)
        elseif tbl11.refCount == 0 then
            collectionStore.resetListSession(feedItemId)
        end

        tbl11.refCount += 1

        local bool2 = false
        return function()
            if bool2 then
                return
            end
            bool2 = true
            local var18 = var11
            if var18 == nil or var18 ~= tbl11 then
                return
            end
            var18.refCount = math.max(0, var18.refCount - 1)
            if var18.refCount == 0 then
                cancelActivePage(var18)
            end
        end
    end

    local function ensureInitialLoad(feedItemId: string, sessionId: number)
        if getSession(feedItemId, sessionId) == nil then
            return false
        end
        local var18 = collectionStore.getState(feedItemId)(false)
        if var18.initialLoadStatus ~= LoadStatus.Idle or var18.loadMoreStatus == LoadStatus.Loading then
            return false
        end
        return var17(feedItemId, sessionId, "initial", nil)
    end

    local function loadMore(str1: string, num1: number)
        local var18 = collectionStore.getState(str1)(false)

        if var18.hasMore ~= true
            or var18.initialLoadStatus == LoadStatus.Loading
            or var18.loadMoreStatus == LoadStatus.Loading
            or var18.loadMoreStatus == LoadStatus.Failed
        then
            return false
        end
        return var17(str1, num1, "more", var18.nextCursor)
    end

    local function retryInitial(feedItemId: string, sessionId: number)
        local session = getSession(feedItemId, sessionId)

        if session == nil then
            return false
        end
        if FFlagMomentsComments and collectionStore.getState(feedItemId)(false).initialLoadStatus == LoadStatus.Success then
            session.initialLoadType = "refresh"
        end

        cancelActivePage(session)
        table.clear(session.requestedCursors)
        collectionStore.resetListSession(feedItemId)
        return ensureInitialLoad(feedItemId, sessionId)
    end

    local function retryLoadMore(feedItemId: string, sessionId: number)
        local session = getSession(feedItemId, sessionId)

        if session == nil then
            return false
        end
        local var18 = collectionStore.getState(feedItemId)(false)

        if var18.hasMore ~= true or var18.initialLoadStatus == LoadStatus.Loading or var18.loadMoreStatus == LoadStatus.Loading then
            return false
        elseif var18.nextCursor == nil or session.requestedCursors[cursorKey(var18.nextCursor)] == true then
            return retryInitial(feedItemId, sessionId)
        end
        return var17(feedItemId, sessionId, "more", var18.nextCursor)
    end

    local function resolveCommentAuthor(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var18 = commentsStore.getCachedComment(str1).data(false)
        return if var18 == nil or var18.author == nil then nil else var18.author.userId
    end

    local function containsCommentByAuthor(tbl11, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, value in tbl11 do
            if resolveCommentAuthor(value) == str1 then
                return true
            end
        end
        return false
    end

    local function hideCommentsByAuthor(str1: string, str2: string)
        if bool1 then
            return
        end

        if sessionFilters ~= nil then
            sessionFilters.markAuthorRecentlyBlocked(str2)
        end

        local var18 = collectionStore.getState(str1)(false)

        if not containsCommentByAuthor(var18.orderedCommentIds, str2)
            and not containsCommentByAuthor(var18.stickyPostedCommentIds, str2)
            and (var18.pinnedCommentId == nil or resolveCommentAuthor(var18.pinnedCommentId) ~= str2)
        then
            return
        end
        collectionStore.removeCommentIdsByAuthor(str1, str2, resolveCommentAuthor)

        local var19 = var11
        if var19 ~= nil and #collectionStore.getState(str1)(false).orderedCommentIds == 0 then
            loadMore(str1, var19.sessionId)
        end
    end

    local function restoreCommentsByAuthor(feedItemId: string, str1: string)
        if bool1 then
            return
        end
        if sessionFilters ~= nil then
            if not sessionFilters.isAuthorRecentlyBlocked(str1) then
                return
            end
            sessionFilters.unmarkAuthorRecentlyBlocked(str1)
        end
        local var18 = var11
        if var18 ~= nil then
            retryInitial(feedItemId, var18.sessionId)
        end
    end

    local effect = Signals.createEffect(function(arg1)
        local ownerGeneration2 = commentsStore.getOwnerGeneration(arg1)
        if ownerGeneration2 == ownerGeneration then
            return
        end
        ownerGeneration = ownerGeneration2
        retireActiveSession(false)
        cancelActiveDeletes()

        if FFlagMomentsComments then
            clearReactionState()
        end
        if FFlagMomentsComments then
            clearPostCooldown()
        end

        collectionStore.clear()
    end)

    local function dispose()
        if bool1 then
            return
        end
        bool1 = true
        effect()
        retireActiveSession(false)
        cancelActiveDeletes()

        if FFlagMomentsComments then
            clearReactionState()
        end
        if FFlagMomentsComments then
            clearPostCooldown()
        end

        collectionStore.clear()
    end

    local tbl11 = {
        acquireSession = acquireSession,
        ensureInitialLoad = ensureInitialLoad,
        loadMore = loadMore,
        retryInitial = retryInitial,
        retryLoadMore = retryLoadMore,
        submitComment = submitComment,
        retryPendingSubmission = retryPendingSubmission,
        editPendingSubmission = editPendingSubmission,
        getPostCooldownUntilMs = getPostCooldownUntilMs,
        ensureReactionPresent = 0,
        ensureReactionAbsent = 0,
        clearReactionState = 0,
        deleteComment = 0,
        hideCommentsByAuthor = 0,
        restoreCommentsByAuthor = 0,
        dispose = 0
    }

    if not FFlagMomentsComments then
        ensureReactionPresent = rejectReactionMutation
    end

    tbl11.ensureReactionPresent = ensureReactionPresent
    if not FFlagMomentsComments then
        ensureReactionAbsent = rejectReactionMutation
    end

    tbl11.ensureReactionAbsent = ensureReactionAbsent
    tbl11.clearReactionState = if FFlagMomentsComments then clearReactionState else noOp
    tbl11.deleteComment = deleteComment
    tbl11.hideCommentsByAuthor = hideCommentsByAuthor
    tbl11.restoreCommentsByAuthor = restoreCommentsByAuthor
    tbl11.dispose = dispose
    return tbl11
end

return createCommentsListCoordinator
