-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local CommentCollectionTypes = require(script.Parent.CommentCollectionTypes)
local mergeCommentPage = require(script.Parent.mergeCommentPage)

local createCommentSessionFiltersStore = require(script.Parent.Parent.GetCommentSessionFiltersStore.createCommentSessionFiltersStore)

local LoadStatus = CommentCollectionTypes.LoadStatus
local pendingSentinel = CommentCollectionTypes.pendingSentinel
local createSignal = Signals.createSignal

local function specialOrderedIds(pendingSubmission, tbl1)
    local result = {}
    local tbl2 = ({})
    local tbl3 = tbl1 or {}
    if pendingSubmission ~= nil then
        local var1 = pendingSentinel(pendingSubmission.clientRequestId)
        table.insert(result, var1)
        tbl2[var1] = true
    end
    for _, value in tbl3 do
        if not tbl2[value] then
            table.insert(result, value)
            tbl2[value] = true
        end
    end
    return result
end

local function defaultState(pendingSubmission, tbl1)
    local tbl2 = tbl1 or {}
    return {
        orderedCommentIds = specialOrderedIds(pendingSubmission, tbl2),
        channelId = nil,
        nextCursor = nil,
        hasMore = false,
        initialLoadStatus = LoadStatus.Idle,
        loadMoreStatus = LoadStatus.Idle,
        errorCode = nil,
        pendingSubmission = pendingSubmission,
        stickyPostedCommentIds = table.clone(tbl2),
        pinnedCommentId = nil,
        submissionError = nil
    }
end

local function createCommentCollectionStore(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = if tbl2.sessionFilters ~= nil then tbl2.sessionFilters else createCommentSessionFiltersStore()
    local var2, var3 = createSignal(nil)
    local get, set = createSignal((defaultState()))
    local tbl3 = { get = get, set = set }

    local var6 = nil
    local bool1 = false

    local function requireSelectedSlot(str1: string) -- Luacid: Inlined by compiler; 15 call sites recovered
        assert(not bool1, "Comment collection store is disposed")
        assert(var2(false) == str1, "Comment feed must be selected before mutation")
        return tbl3
    end

    local function clear() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end
        tbl3.set((defaultState()))
        var6 = nil
        var3(nil)
        var1.reset()
    end

    local function currentFilters(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        if arg1 ~= nil then
            return arg1
        end
        return var1.getFilters(false)
    end

    local function pendingSentinelFor(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local pendingSubmission = arg1.pendingSubmission
        if pendingSubmission == nil then
            return nil
        end
        return pendingSentinel(pendingSubmission.clientRequestId)
    end

    local function applyMerge(str1: string, arg1, replace: boolean, filters)
        local tbl4 = requireSelectedSlot(str1)
        local var7 = tbl4.get(false)
        local visibleIdsBeforeReconciliation = ({})
        for _, orderedCommentId in var7.orderedCommentIds do
            visibleIdsBeforeReconciliation[orderedCommentId] = true
        end
        local tbl6 = {}
        for _, comment in arg1.comments do
            tbl6[comment.commentId] = true
        end
        local stickyPostedCommentIds = {}
        local tbl8 = ({})
        for _, stickyPostedCommentId in var7.stickyPostedCommentIds do
            if tbl6[stickyPostedCommentId] then
                tbl8[stickyPostedCommentId] = true
            else
                table.insert(stickyPostedCommentIds, stickyPostedCommentId)
            end
        end
        local existingIds = {}
        for _, orderedCommentId in var7.orderedCommentIds do
            if not tbl8[orderedCommentId] then
                table.insert(existingIds, orderedCommentId)
            end
        end
        local var8 = mergeCommentPage
        local tbl10 = {
            existingIds = existingIds,
            pageComments = arg1.comments,
            filters = 0,
            replace = 0,
            pendingSentinel = 0,
            stickyPostedCommentIds = 0,
            pinnedCommentId = 0,
            visibleIdsBeforeReconciliation = 0,
            hasMore = 0
        }

        if filters == nil then
            filters = currentFilters(nil)
        end

        tbl10.filters = filters
        tbl10.replace = replace
        tbl10.pendingSentinel = pendingSentinelFor(var7)
        tbl10.stickyPostedCommentIds = stickyPostedCommentIds
        tbl10.pinnedCommentId = var7.pinnedCommentId
        tbl10.visibleIdsBeforeReconciliation = visibleIdsBeforeReconciliation
        tbl10.hasMore = arg1.hasMore
        local var9 = var8(tbl10)

        tbl4.set({
            orderedCommentIds = var9.orderedCommentIds,
            channelId = arg1.channelId or var7.channelId,
            nextCursor = arg1.nextCursor,
            hasMore = arg1.hasMore,
            initialLoadStatus = if replace then LoadStatus.Success else var7.initialLoadStatus,
            loadMoreStatus = if replace then LoadStatus.Idle else LoadStatus.Success,
            errorCode = nil,
            pendingSubmission = var7.pendingSubmission,
            stickyPostedCommentIds = stickyPostedCommentIds,
            pinnedCommentId = var7.pinnedCommentId,
            submissionError = var7.submissionError
        })
        return var9
    end

    local function dropId(tbl4, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local result = {}
        for _, value in tbl4 do
            if value ~= str1 then
                table.insert(result, value)
            end
        end
        return result
    end

    local function replaceId(orderedCommentIds, str1: string, commentId: string)
        local result = {}
        local bool2 = false
        local tbl4 = ({})
        for _, orderedCommentId in orderedCommentIds do
            local var7 = if orderedCommentId == str1 then commentId else orderedCommentId

            if tbl4[var7] then
                continue
            end

            table.insert(result, var7)
            tbl4[var7] = true
            if orderedCommentId == str1 then
                bool2 = true
            end
        end

        if not (bool2 or tbl4[commentId]) then
            table.insert(result, 1, commentId)
        end
        return result
    end

    local function moveToFront(stickyPostedCommentIds, commentId: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local tbl4 = { commentId }
        for _, stickyPostedCommentId in stickyPostedCommentIds do
            if stickyPostedCommentId ~= commentId then
                table.insert(tbl4, stickyPostedCommentId)
            end
        end
        return tbl4
    end

    return {
        getState = function(str1: string)
            return function(arg1)
                if var2(arg1) ~= str1 then
                    return (defaultState())
                end
                return tbl3.get(arg1)
            end
        end,
        selectFeed = function(str1: string, num1: number)
            assert(not bool1, "Comment collection store is disposed")
            if var2(false) == str1 and var6 == num1 then
                return
            end
            tbl3.set((defaultState()))
            var6 = num1
            var3(str1)
            var1.reset()
        end,
        clear = clear,
        dispose = function()
            if bool1 then
                return
            end

            clear()
            bool1 = true
        end,
        beginListSession = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            tbl4.set((defaultState(var7.pendingSubmission, var7.stickyPostedCommentIds)))
        end,
        resetListSession = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            tbl4.set({
                orderedCommentIds = specialOrderedIds(var7.pendingSubmission, var7.stickyPostedCommentIds),
                channelId = nil,
                nextCursor = nil,
                hasMore = false,
                initialLoadStatus = LoadStatus.Idle,
                loadMoreStatus = LoadStatus.Idle,
                errorCode = nil,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        beginInitialLoad = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            tbl4.set({
                orderedCommentIds = var7.orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = LoadStatus.Loading,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = nil,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        completeInitialLoad = function(str1: string, arg1, arg2)
            return (applyMerge(str1, arg1, true, arg2))
        end,
        beginLoadMore = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            tbl4.set({
                orderedCommentIds = var7.orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = LoadStatus.Loading,
                errorCode = var7.errorCode,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        completeLoadMore = function(str1: string, arg1, arg2)
            return (applyMerge(str1, arg1, false, arg2))
        end,
        failLoad = function(str1: string, str2: string, errorCode: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            tbl4.set({
                orderedCommentIds = var7.orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = if str2 == "initial" then LoadStatus.Failed else var7.initialLoadStatus,
                loadMoreStatus = if str2 == "more" then LoadStatus.Failed else var7.loadMoreStatus,
                errorCode = errorCode,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        beginPendingSubmission = function(str1: string, text: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local pendingSubmission = var7.pendingSubmission
            if pendingSubmission ~= nil and pendingSubmission.text == text then
                if var7.submissionError ~= nil then
                    tbl4.set({
                        orderedCommentIds = var7.orderedCommentIds,
                        channelId = var7.channelId,
                        nextCursor = var7.nextCursor,
                        hasMore = var7.hasMore,
                        initialLoadStatus = var7.initialLoadStatus,
                        loadMoreStatus = var7.loadMoreStatus,
                        errorCode = var7.errorCode,
                        pendingSubmission = pendingSubmission,
                        stickyPostedCommentIds = var7.stickyPostedCommentIds,
                        pinnedCommentId = var7.pinnedCommentId,
                        submissionError = nil
                    })
                end

                return pendingSubmission.clientRequestId
            end

            local clientRequestId = HttpService:GenerateGUID(false)
            local var8 = pendingSentinel(clientRequestId)
            local orderedCommentIds = if pendingSubmission ~= nil then dropId(var7.orderedCommentIds, (pendingSentinel(pendingSubmission.clientRequestId))) else table.clone(var7.orderedCommentIds)
            table.insert(orderedCommentIds, 1, var8)
            tbl4.set({
                orderedCommentIds = orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = {
                    clientRequestId = clientRequestId,
                    text = text,
                    status = "Sending"
                },
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = nil
            })

            return clientRequestId
        end,
        markPendingSending = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local pendingSubmission = var7.pendingSubmission
            if pendingSubmission == nil then
                return
            end
            tbl4.set({
                orderedCommentIds = var7.orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = {
                    clientRequestId = pendingSubmission.clientRequestId,
                    text = pendingSubmission.text,
                    status = "Sending"
                },
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        markPendingOutcomeUnknown = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local pendingSubmission = var7.pendingSubmission
            if pendingSubmission == nil then
                return
            end
            tbl4.set({
                orderedCommentIds = var7.orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = {
                    clientRequestId = pendingSubmission.clientRequestId,
                    text = pendingSubmission.text,
                    status = "OutcomeUnknown"
                },
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        resolvePendingSubmission = function(str1: string, arg1)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local pendingSubmission = var7.pendingSubmission
            if pendingSubmission == nil then
                return
            end
            local var8 = pendingSentinel(pendingSubmission.clientRequestId)
            tbl4.set({
                orderedCommentIds = replaceId(var7.orderedCommentIds, var8, arg1.commentId),
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = nil,
                stickyPostedCommentIds = moveToFront(var7.stickyPostedCommentIds, arg1.commentId),
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = nil
            })
        end,
        rejectPendingSubmission = function(str1: string, errorCode: string?)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local pendingSubmission = var7.pendingSubmission
            if pendingSubmission == nil then
                return
            end
            local submissionError = errorCode ~= nil and {
                errorCode = errorCode,
                text = pendingSubmission.text
            } or nil

            tbl4.set({
                orderedCommentIds = dropId(var7.orderedCommentIds, (pendingSentinel(pendingSubmission.clientRequestId))),
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = nil,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = submissionError
            })
        end,
        clearSubmissionError = function(str1: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            if var7.submissionError == nil then
                return
            end
            tbl4.set({
                orderedCommentIds = var7.orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = var7.pinnedCommentId,
                submissionError = nil
            })
        end,
        getPendingSubmission = function(str1: string)
            if var2(false) == str1 then
                return tbl3.get(false).pendingSubmission
            end

            return nil
        end,
        removeCommentId = function(str1: string, pinnedCommentId: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            tbl4.set({
                orderedCommentIds = dropId(var7.orderedCommentIds, pinnedCommentId),
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = dropId(var7.stickyPostedCommentIds, pinnedCommentId),
                pinnedCommentId = if var7.pinnedCommentId == pinnedCommentId then nil else var7.pinnedCommentId,
                submissionError = var7.submissionError
            })
        end,
        removeCommentIdsByAuthor = function(str1: string, str2: string, func1: (...any) -> (...any))
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local orderedCommentIds = {}
            for _, orderedCommentId in var7.orderedCommentIds do
                if func1(orderedCommentId) ~= str2 then
                    table.insert(orderedCommentIds, orderedCommentId)
                end
            end
            local stickyPostedCommentIds = {}
            for _, stickyPostedCommentId in var7.stickyPostedCommentIds do
                if func1(stickyPostedCommentId) ~= str2 then
                    table.insert(stickyPostedCommentIds, stickyPostedCommentId)
                end
            end
            tbl4.set({
                orderedCommentIds = orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = stickyPostedCommentIds,
                pinnedCommentId = if var7.pinnedCommentId == nil or func1(var7.pinnedCommentId) ~= str2 then var7.pinnedCommentId else nil,
                submissionError = var7.submissionError
            })
        end,
        setPinnedComment = function(str1: string, pinnedCommentId: string)
            local tbl4 = requireSelectedSlot(str1)
            local var7 = tbl4.get(false)
            local orderedCommentIds = var7.orderedCommentIds
            if var7.initialLoadStatus == LoadStatus.Success then
                local tbl5 = ({})
                local var8 = pendingSentinelFor(var7)

                if var8 ~= nil then
                    tbl5[var8] = true
                end
                for _, stickyPostedCommentId in var7.stickyPostedCommentIds do
                    tbl5[stickyPostedCommentId] = true
                end
                orderedCommentIds = {}
                local bool2 = false
                for _, orderedCommentId in var7.orderedCommentIds do
                    if not (bool2 or tbl5[orderedCommentId]) then
                        table.insert(orderedCommentIds, pinnedCommentId)
                        bool2 = true
                    end

                    if orderedCommentId ~= pinnedCommentId then
                        table.insert(orderedCommentIds, orderedCommentId)
                    end
                end
                if not bool2 then
                    table.insert(orderedCommentIds, pinnedCommentId)
                end
            end
            tbl4.set({
                orderedCommentIds = orderedCommentIds,
                channelId = var7.channelId,
                nextCursor = var7.nextCursor,
                hasMore = var7.hasMore,
                initialLoadStatus = var7.initialLoadStatus,
                loadMoreStatus = var7.loadMoreStatus,
                errorCode = var7.errorCode,
                pendingSubmission = var7.pendingSubmission,
                stickyPostedCommentIds = var7.stickyPostedCommentIds,
                pinnedCommentId = pinnedCommentId,
                submissionError = var7.submissionError
            })
        end
    }
end

return createCommentCollectionStore
