-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local Signals = require(MomentsParent.Signals)
local SignalsExperimental = require(MomentsParent.SignalsExperimental)
local FFlagMomentsOptimisticProfilePending = require(MomentsParent.SharedFlags).FFlagMomentsOptimisticProfilePending
local createPendingFeedOverlay = require(script.Parent.createPendingFeedOverlay)
local GetDeletedMomentsStore = require(Moments.Stores.GetDeletedMomentsStore)
local FFlagMomentsParentTimeLimit = MomentsCommon.Flags.FFlagMomentsParentTimeLimit

local Analytics = MomentsCommon.Analytics
local MomentsSurfaceLoadManager = MomentsCommon.Performance.MomentsSurfaceLoadManager

local _FeedTypes = require(script.Parent.FeedTypes)
local createPagerStore = require(Moments.Components.VerticalPager.createPagerStore)
local FFlagMomentsLoadMoreKeepsPosition = require(Moments.Flags.FFlagMomentsLoadMoreKeepsPosition)
local FFlagMomentsModeratedMomentPage = require(Moments.Flags.FFlagMomentsModeratedMomentPage)

local createSignal = Signals.createSignal

local tbl1 = { kind = "skeleton" }

local tbl2 = { kind = "endState" }

local tbl3 = { kind = "caughtUp" }

local function isTerminalPage(arg1): boolean -- Luacid: Inlined by compiler; 27 call sites recovered
    return arg1.kind == "endState" or arg1.kind == "caughtUp"
end

local function isSentinel(arg1): boolean -- Luacid: Inlined by compiler; 28 call sites recovered
    return arg1.kind == "skeleton" or arg1.kind == "endState" or arg1.kind == "caughtUp"
end

local function createFeedStore(arg1, callback: ((...any) -> (...any))?, bool1: boolean?, num1: number?, tbl4)
    local bool2 = arg1.endsWithCaughtUp == true
    local pager = createPagerStore()
    local pendingFeedOverlay = if FFlagMomentsOptimisticProfilePending and arg1.getPendingItems ~= nil then createPendingFeedOverlay() else nil
    local effect = nil

    local getInitialIndex, var2 = createSignal(nil)

    local getStatus, var4 = createSignal("Loading")
    local str1 = "Loading"

    local getError, var6 = createSignal(nil)
    local getHasMore, var8 = createSignal(true)
    local getLoadMoreFailed, var10 = createSignal(false)
    local recommendationSource = arg1.recommendationSource or "Unknown"

    local nextCursor = nil
    local bool3 = false
    local bool4 = false
    local bool5 = false
    local effect2 = nil

    local var11 = nil

    local num2 = 0

    local num3 = 0

    local tbl5 = ({})

    local var12 = num1
    local getAtScrollLimit, var14 = createSignal(false)

    local getCanLoadMoreBeyondLimit, var16 = createSignal(false)
    local var17 = var16

    local tbl6 = {}

    local function stripTrailingSkeleton() -- Luacid: Inlined by compiler; 6 call sites recovered
        local items = pager.getItems(false)
        local item = items[#items]
        if item ~= nil and item.kind == "skeleton" then
            pager.removeItem(#items)
        end
    end

    local function dedupeAndTrack(tbl7)
        if callback == nil then
            return tbl7
        end
        local result = {}
        for _, value in tbl7 do
            local success, result2 = pcall(callback, value)
            if success then
                if result2 == nil or result2 == "" then
                    table.insert(result, value)
                elseif not tbl5[result2] then
                    tbl5[result2] = true
                    table.insert(result, value)
                else
                    Analytics.reportMomentsFeedItemFiltered("duplicate", recommendationSource)
                end
            else
                Analytics.reportMomentsFeedItemFiltered("malformed", recommendationSource)
            end
        end
        return result
    end

    local function countRealItems(tbl7): number -- Luacid: Inlined by compiler; 26 call sites recovered
        local num4 = 0
        for _, value in tbl7 do
            if value.kind ~= "skeleton" and value.kind ~= "endState" and value.kind ~= "caughtUp" then
                num4 += 1
            end
        end
        return num4
    end

    local function publishStatus() -- Luacid: Inlined by compiler; 9 call sites recovered
        local str2 = str1
        if FFlagMomentsParentTimeLimit and bool5 then
            str2 = "LimitReached"
        elseif pendingFeedOverlay ~= nil then
            str2 = countRealItems((pager.getItems(false))) > 0 and (if str1 == "LoadingMore" then "LoadingMore" else "Loaded")
                or (if str1 == "Loaded" then "Empty" else str2)
        end

        var4(str2)
    end

    local function setStatus(str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        str1 = str2
        publishStatus()
    end

    local function getRetainedItems() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var18 = table.clone(pager.getItems(false))
        for _, value in tbl6 do
            table.insert(var18, value)
        end
        return var18
    end

    local function maybeAppendEndState()
        if var12 == nil or getAtScrollLimit(false) then
            return
        end
        local items = pager.getItems(false)
        if countRealItems(items) < var12 then
            return
        end
        if countRealItems(items) > var12 then
            local tbl7 = {}
            local num4 = 0
            for _, item in items do
                if isSentinel(item) then
                    continue
                end

                if num4 < var12 then
                    num4 += 1
                    table.insert(tbl7, item)
                else
                    table.insert(tbl6, item)
                end
            end
            pager.setItems(tbl7)
        end
        assert(var17, "end-state fixes require the eligibility signal")(getHasMore(false) or #tbl6 > 0)

        var14(true)
        pager.addItems({ tbl2 })
    end

    local function appendTerminalPage()
        local items = pager.getItems(false)
        if not bool2 or getHasMore(false) or #tbl6 ~= 0 or var12 ~= nil and not (countRealItems(items) <= var12) then
            maybeAppendEndState()
            return
        end

        local item = items[#items]

        if item ~= nil and not isSentinel(item) then
            pager.addItems({ tbl3 })
        end
    end

    local function commitItems(tbl7)
        if pendingFeedOverlay == nil then
            pager.setItems(tbl7)
            return
        end
        local currentItem = pager.getCurrentItem(false)
        local var18 = if currentItem == nil then nil else pendingFeedOverlay.identity(currentItem)
        pendingFeedOverlay.retireMissing((getRetainedItems()))
        local var19 = pendingFeedOverlay.merge(tbl7)
        SignalsExperimental.batch(function()
            pager.setItems(var19)
            for value, value2 in var19 do
                local var20 = pendingFeedOverlay.identity(value2)
                if var18 ~= nil and var20 == var18 then
                    pager.goToItem(value)
                end
            end
        end)

        if callback == nil then
            return
        end

        for _, value in var19 do
            if value.kind ~= "moment" then
                continue
            end

            local var20 = callback(value)
            if var20 ~= nil then
                tbl5[var20] = true
            end
        end
    end

    local function findMomentIndex(initialMomentId: string?)
        if initialMomentId == nil then
            return nil
        end
        local var18 = assert(pendingFeedOverlay, "initial identity resolution requires the pending overlay")
        for value, value2 in pager.getItems(false) do
            if value2.kind == "moment" and (var18.identity(value2) == initialMomentId or value2.moment.momentId == initialMomentId) then
                return value
            end
            if value2.kind == "unavailableMoment" and value2.targetId == initialMomentId then
                return value
            end
        end
        return nil
    end

    local function resolveInitialIndex(bool6: boolean) -- Luacid: Inlined by compiler; 11 call sites recovered
        local momentIndex = findMomentIndex(arg1.initialMomentId)
        if momentIndex ~= nil or bool6 then
            var2(momentIndex)
        end
    end

    local function runFetch(bool6: boolean, bool7: boolean?)
        if bool4 or not bool6 and not getHasMore(false) or FFlagMomentsParentTimeLimit and bool5 then
            return
        end

        num3 += 1
        local num4 = num3
        bool3 = true
        var10(false)

        local sessionGeneration = nil

        if bool6 then
            Analytics.reportMomentsFeedLoadAttempt(recommendationSource)

            var6(nil)
            commitItems({ tbl1 })
            if pendingFeedOverlay ~= nil then
                resolveInitialIndex(false)
            end

            str1 = "Loading"
            local str2 = str1
            if FFlagMomentsParentTimeLimit and bool5 then
                str2 = "LimitReached"
            elseif pendingFeedOverlay ~= nil then
                if countRealItems((pager.getItems(false))) > 0 then
                    str2 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
                elseif str1 == "Loaded" then
                    str2 = "Empty"
                end
            end

            var4(str2)

            var12 = num1
            var14(false)
            assert(var17, "end-state fixes require the eligibility signal")(false)
            table.clear(tbl6)
            if bool1 then
                MomentsSurfaceLoadManager.start()
                MomentsSurfaceLoadManager.primaryDataStarted()
                MomentsSurfaceLoadManager.primaryDataNetworkFetch()
                sessionGeneration = MomentsSurfaceLoadManager.getSessionGeneration()
                if FFlagMomentsParentTimeLimit then
                    var11 = sessionGeneration
                end
            end
        else
            Analytics.reportMomentsFeedLoadMore("attempted", recommendationSource)

            if not (FFlagMomentsLoadMoreKeepsPosition and bool7) then
                pager.addItems({ tbl1 })
            end

            str1 = "LoadingMore"
            local str2 = str1
            if FFlagMomentsParentTimeLimit and bool5 then
                str2 = "LimitReached"
            elseif pendingFeedOverlay ~= nil then
                if countRealItems((pager.getItems(false))) > 0 then
                    str2 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
                elseif str1 == "Loaded" then
                    str2 = "Empty"
                end
            end

            var4(str2)
        end

        local var18 = if bool6 then nil else nextCursor

        task.spawn(function()
            local success, result = pcall(arg1.fetchAsync, var18)

            if bool4 or num4 ~= num3 then
                return
            end
            bool3 = false

            local bool8 = bool1 and bool6

            if bool8 then
                if sessionGeneration == nil then
                    bool8 = false
                else
                    bool8 = MomentsSurfaceLoadManager.getSessionGeneration() == sessionGeneration
                end
            end

            if bool8 then
                MomentsSurfaceLoadManager.primaryDataResponseReceived()
            end

            local var19 = if FFlagMomentsParentTimeLimit and not success and tbl4 ~= nil then require(MomentsParent.DataHydration.MomentsParseMomentsLimitError)(result) else nil

            if var19 ~= nil then
                if bool6 and pendingFeedOverlay ~= nil then
                    commitItems({})
                    resolveInitialIndex(true)
                else
                    stripTrailingSkeleton()
                end

                bool5 = true
                str1 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
                publishStatus()

                if bool6 then
                    Analytics.reportMomentsFeedState("failed", recommendationSource, "parentalTimeLimitReached")
                else
                    Analytics.reportMomentsFeedLoadMore("failed", recommendationSource, "parentalTimeLimitReached")
                end
                if bool8 then
                    MomentsSurfaceLoadManager.abort("parentalTimeLimitReached")
                end
                tbl4.markLimitReached(var19.limitSeconds)
                return
            end

            local var20 = if success and type(result) == "table" then if type(result.items) == "table" then result else nil else nil

            if var20 == nil then
                if bool6 then
                    if pendingFeedOverlay ~= nil then
                        commitItems({})
                        resolveInitialIndex(true)
                    else
                        pager.reset()
                    end
                    var6(if success then "Malformed feed batch" else tostring(result))
                    str1 = "Failed"
                    local str2 = str1
                    if FFlagMomentsParentTimeLimit and bool5 then
                        str2 = "LimitReached"
                    elseif pendingFeedOverlay ~= nil then
                        if countRealItems((pager.getItems(false))) > 0 then
                            str2 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
                        elseif str1 == "Loaded" then
                            str2 = "Empty"
                        end
                    end

                    var4(str2)

                    Analytics.reportMomentsFeedState(
                        "failed",
                        recommendationSource,
                        if success then "malformedResponse" else "requestFailed"
                    )
                    if bool8 then
                        MomentsSurfaceLoadManager.abort("failed")
                    end
                else
                    stripTrailingSkeleton()
                    var10(true)
                    str1 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
                    publishStatus()
                    Analytics.reportMomentsFeedLoadMore(
                        "failed",
                        recommendationSource,
                        if success then "malformedResponse" else "requestFailed"
                    )
                end

                return
            end

            local var21

            if bool6 then
                tbl5 = {}
                var21 = dedupeAndTrack(var20.items)
                commitItems(var21)
                if pendingFeedOverlay ~= nil then
                    resolveInitialIndex(true)
                    local momentIndex = findMomentIndex(var20.initialMomentId)
                    if momentIndex ~= nil then
                        pager.goToItem(momentIndex)
                    end
                end
            else
                var21 = dedupeAndTrack(var20.items)
                local var22 = table.clone(pager.getItems(false))
                local var23 = var22[#var22]
                if var23 ~= nil and var23.kind == "skeleton" then
                    table.remove(var22)
                end
                for _, value in var21 do
                    table.insert(var22, value)
                end
                commitItems(var22)
            end
            nextCursor = var20.nextCursor

            num2 = if bool6 then 0 elseif #var21 ~= 0 then 0 else num2 + 1
            var8(not (var20.nextCursor == nil) and num2 < 3)
            local str2 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
            setStatus(str2)

            if bool6 then
                Analytics.reportMomentsFeedState(if str2 == "Loaded" then "loaded" else "empty", recommendationSource, nil)
            end

            if bool8 then
                local currentItem = pager.getCurrentItem(false)

                if FFlagMomentsModeratedMomentPage and currentItem ~= nil and currentItem.kind == "unavailableMoment" then
                    MomentsSurfaceLoadManager.abort("unavailable")
                elseif str2 == "Loaded" then
                    MomentsSurfaceLoadManager.primaryDataReady()
                else
                    MomentsSurfaceLoadManager.abort("empty")
                end
            end
            if var20.onAccepted ~= nil then
                var20.onAccepted()
            end
            if num1 ~= nil or bool2 then
                appendTerminalPage()
            end
        end)
    end

    local function loadInitial()
        runFetch(true)
    end

    local function loadMore()
        if pendingFeedOverlay ~= nil and (num3 == 0 or getError(false) ~= nil)
            or num1 ~= nil and getAtScrollLimit(false)
            or bool3
            or getLoadMoreFailed(false)
            or bool4
            or not getHasMore(false)
            or FFlagMomentsParentTimeLimit and bool5
        then
            return
        end

        num3 += 1
        local num4 = num3
        bool3 = true
        var10(false)

        local var18 = nil

        Analytics.reportMomentsFeedLoadMore("attempted", recommendationSource)

        pager.addItems({ tbl1 })
        str1 = "LoadingMore"
        local str2 = str1
        if FFlagMomentsParentTimeLimit and bool5 then
            str2 = "LimitReached"
        elseif pendingFeedOverlay ~= nil then
            if countRealItems((pager.getItems(false))) > 0 then
                str2 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
            elseif str1 == "Loaded" then
                str2 = "Empty"
            end
        end

        var4(str2)

        local var19 = nextCursor

        local bool6 = false

        task.spawn(function()
            local success, result = pcall(arg1.fetchAsync, var19)

            if bool4 or num4 ~= num3 then
                return
            end
            bool3 = false

            local bool7 = bool1 and bool6

            if bool7 then
                if var18 == nil then
                    bool7 = false
                else
                    bool7 = MomentsSurfaceLoadManager.getSessionGeneration() == var18
                end
            end

            if bool7 then
                MomentsSurfaceLoadManager.primaryDataResponseReceived()
            end

            local var20 = if FFlagMomentsParentTimeLimit and not success and tbl4 ~= nil then require(MomentsParent.DataHydration.MomentsParseMomentsLimitError)(result) else nil

            if var20 ~= nil then
                if bool6 and pendingFeedOverlay ~= nil then
                    commitItems({})
                    resolveInitialIndex(true)
                else
                    stripTrailingSkeleton()
                end

                bool5 = true
                str1 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
                publishStatus()

                if bool6 then
                    Analytics.reportMomentsFeedState("failed", recommendationSource, "parentalTimeLimitReached")
                else
                    Analytics.reportMomentsFeedLoadMore("failed", recommendationSource, "parentalTimeLimitReached")
                end
                if bool7 then
                    MomentsSurfaceLoadManager.abort("parentalTimeLimitReached")
                end
                tbl4.markLimitReached(var20.limitSeconds)
                return
            end

            local var21 = if success and type(result) == "table" then if type(result.items) == "table" then result else nil else nil

            if var21 == nil then
                if bool6 then
                    if pendingFeedOverlay ~= nil then
                        commitItems({})
                        resolveInitialIndex(true)
                    else
                        pager.reset()
                    end
                    var6(if success then "Malformed feed batch" else tostring(result))
                    str1 = "Failed"
                    local str3 = str1
                    if FFlagMomentsParentTimeLimit and bool5 then
                        str3 = "LimitReached"
                    elseif pendingFeedOverlay ~= nil then
                        if countRealItems((pager.getItems(false))) > 0 then
                            str3 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
                        elseif str1 == "Loaded" then
                            str3 = "Empty"
                        end
                    end

                    var4(str3)

                    Analytics.reportMomentsFeedState(
                        "failed",
                        recommendationSource,
                        if success then "malformedResponse" else "requestFailed"
                    )
                    if bool7 then
                        MomentsSurfaceLoadManager.abort("failed")
                    end
                else
                    stripTrailingSkeleton()
                    var10(true)
                    str1 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
                    publishStatus()
                    Analytics.reportMomentsFeedLoadMore(
                        "failed",
                        recommendationSource,
                        if success then "malformedResponse" else "requestFailed"
                    )
                end

                return
            end

            local var22

            if bool6 then
                tbl5 = {}
                var22 = dedupeAndTrack(var21.items)
                commitItems(var22)
                if pendingFeedOverlay ~= nil then
                    resolveInitialIndex(true)
                    local momentIndex = findMomentIndex(var21.initialMomentId)
                    if momentIndex ~= nil then
                        pager.goToItem(momentIndex)
                    end
                end
            else
                var22 = dedupeAndTrack(var21.items)
                local var23 = table.clone(pager.getItems(false))
                local var24 = var23[#var23]
                if var24 ~= nil and var24.kind == "skeleton" then
                    table.remove(var23)
                end
                for _, value in var22 do
                    table.insert(var23, value)
                end
                commitItems(var23)
            end
            nextCursor = var21.nextCursor

            num2 = if bool6 then 0 elseif #var22 ~= 0 then 0 else num2 + 1
            var8(not (var21.nextCursor == nil) and num2 < 3)
            local str3 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
            setStatus(str3)

            if bool6 then
                Analytics.reportMomentsFeedState(if str3 == "Loaded" then "loaded" else "empty", recommendationSource, nil)
            end

            if bool7 then
                local currentItem = pager.getCurrentItem(false)

                if FFlagMomentsModeratedMomentPage and currentItem ~= nil and currentItem.kind == "unavailableMoment" then
                    MomentsSurfaceLoadManager.abort("unavailable")
                elseif str3 == "Loaded" then
                    MomentsSurfaceLoadManager.primaryDataReady()
                else
                    MomentsSurfaceLoadManager.abort("empty")
                end
            end
            if var21.onAccepted ~= nil then
                var21.onAccepted()
            end
            if num1 ~= nil or bool2 then
                appendTerminalPage()
            end
        end)
    end

    local function loadBeyondLimit()
        if bool4 or num1 == nil or not getAtScrollLimit(false) or not getHasMore(false) and #tbl6 == 0 then
            return
        end

        local items = pager.getItems(false)
        local var18 = table.clone(items)
        local var19 = var18[#var18]
        local bool6 = not (var19 == nil) and var19.kind == "endState"

        if bool6 then
            table.remove(var18)
        end
        if FFlagMomentsLoadMoreKeepsPosition and bool6 then
            pager.goToItem(#items)
        end
        if not FFlagMomentsLoadMoreKeepsPosition and bool6 then
            pager.removeItem(#items)
        end

        var12 = if FFlagMomentsLoadMoreKeepsPosition then countRealItems(var18) + num1 else countRealItems((pager.getItems(false))) + num1

        var14(false)
        local bool7 = false
        if #tbl6 > 0 then
            if not FFlagMomentsLoadMoreKeepsPosition then
                var18 = table.clone(pager.getItems(false))
            end
            for _, value in tbl6 do
                table.insert(var18, value)
            end
            table.clear(tbl6)
            pager.setItems(var18)

            appendTerminalPage()
            if getAtScrollLimit(false) then
                return
            end
        elseif FFlagMomentsLoadMoreKeepsPosition then
            table.insert(var18, tbl1)
            pager.setItems(var18)
            bool7 = true
        end

        if not FFlagMomentsLoadMoreKeepsPosition then
            bool7 = nil
        end

        if bool4 or not getHasMore(false) or FFlagMomentsParentTimeLimit and bool5 then
            return
        end

        num3 += 1
        local num4 = num3
        bool3 = true
        var10(false)

        local var20 = nil

        Analytics.reportMomentsFeedLoadMore("attempted", recommendationSource)

        if not (FFlagMomentsLoadMoreKeepsPosition and bool7) then
            pager.addItems({ tbl1 })
        end

        str1 = "LoadingMore"
        local str2 = str1
        if FFlagMomentsParentTimeLimit and bool5 then
            str2 = "LimitReached"
        elseif pendingFeedOverlay ~= nil then
            if countRealItems((pager.getItems(false))) > 0 then
                str2 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
            elseif str1 == "Loaded" then
                str2 = "Empty"
            end
        end

        var4(str2)

        local var21 = nextCursor

        local bool8 = false

        task.spawn(function()
            local success, result = pcall(arg1.fetchAsync, var21)

            if bool4 or num4 ~= num3 then
                return
            end
            bool3 = false

            local bool9 = bool1 and bool8

            if bool9 then
                if var20 == nil then
                    bool9 = false
                else
                    bool9 = MomentsSurfaceLoadManager.getSessionGeneration() == var20
                end
            end

            if bool9 then
                MomentsSurfaceLoadManager.primaryDataResponseReceived()
            end

            local var22 = if FFlagMomentsParentTimeLimit and not success and tbl4 ~= nil then require(MomentsParent.DataHydration.MomentsParseMomentsLimitError)(result) else nil

            if var22 ~= nil then
                if bool8 and pendingFeedOverlay ~= nil then
                    commitItems({})
                    resolveInitialIndex(true)
                else
                    stripTrailingSkeleton()
                end

                bool5 = true
                str1 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
                publishStatus()

                if bool8 then
                    Analytics.reportMomentsFeedState("failed", recommendationSource, "parentalTimeLimitReached")
                else
                    Analytics.reportMomentsFeedLoadMore("failed", recommendationSource, "parentalTimeLimitReached")
                end
                if bool9 then
                    MomentsSurfaceLoadManager.abort("parentalTimeLimitReached")
                end
                tbl4.markLimitReached(var22.limitSeconds)
                return
            end

            local var23 = if success and type(result) == "table" then if type(result.items) == "table" then result else nil else nil

            if var23 == nil then
                if bool8 then
                    if pendingFeedOverlay ~= nil then
                        commitItems({})
                        resolveInitialIndex(true)
                    else
                        pager.reset()
                    end
                    var6(if success then "Malformed feed batch" else tostring(result))
                    str1 = "Failed"
                    local str3 = str1
                    if FFlagMomentsParentTimeLimit and bool5 then
                        str3 = "LimitReached"
                    elseif pendingFeedOverlay ~= nil then
                        if countRealItems((pager.getItems(false))) > 0 then
                            str3 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
                        elseif str1 == "Loaded" then
                            str3 = "Empty"
                        end
                    end

                    var4(str3)

                    Analytics.reportMomentsFeedState(
                        "failed",
                        recommendationSource,
                        if success then "malformedResponse" else "requestFailed"
                    )
                    if bool9 then
                        MomentsSurfaceLoadManager.abort("failed")
                    end
                else
                    stripTrailingSkeleton()
                    var10(true)
                    str1 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
                    publishStatus()
                    Analytics.reportMomentsFeedLoadMore(
                        "failed",
                        recommendationSource,
                        if success then "malformedResponse" else "requestFailed"
                    )
                end

                return
            end

            local var24

            if bool8 then
                tbl5 = {}
                var24 = dedupeAndTrack(var23.items)
                commitItems(var24)
                if pendingFeedOverlay ~= nil then
                    resolveInitialIndex(true)
                    local momentIndex = findMomentIndex(var23.initialMomentId)
                    if momentIndex ~= nil then
                        pager.goToItem(momentIndex)
                    end
                end
            else
                var24 = dedupeAndTrack(var23.items)
                local var25 = table.clone(pager.getItems(false))
                local var26 = var25[#var25]
                if var26 ~= nil and var26.kind == "skeleton" then
                    table.remove(var25)
                end
                for _, value in var24 do
                    table.insert(var25, value)
                end
                commitItems(var25)
            end
            nextCursor = var23.nextCursor

            num2 = if bool8 then 0 elseif #var24 ~= 0 then 0 else num2 + 1
            var8(not (var23.nextCursor == nil) and num2 < 3)
            local str3 = if pager.getCount(false) == 0 then "Empty" else "Loaded"
            setStatus(str3)

            if bool8 then
                Analytics.reportMomentsFeedState(if str3 == "Loaded" then "loaded" else "empty", recommendationSource, nil)
            end

            if bool9 then
                local currentItem = pager.getCurrentItem(false)

                if FFlagMomentsModeratedMomentPage and currentItem ~= nil and currentItem.kind == "unavailableMoment" then
                    MomentsSurfaceLoadManager.abort("unavailable")
                elseif str3 == "Loaded" then
                    MomentsSurfaceLoadManager.primaryDataReady()
                else
                    MomentsSurfaceLoadManager.abort("empty")
                end
            end
            if var23.onAccepted ~= nil then
                var23.onAccepted()
            end
            if num1 ~= nil or bool2 then
                appendTerminalPage()
            end
        end)
    end

    local function prependItem(arg2)
        local tbl7 = dedupeAndTrack({ arg2 })
        if #tbl7 == 0 then
            return
        end

        pager.addItemAt(1, tbl7[1])
        if getStatus(false) ~= "Empty" then
            return
        end

        str1 = "Loaded"
        local str2 = str1
        if FFlagMomentsParentTimeLimit and bool5 then
            str2 = "LimitReached"
        elseif pendingFeedOverlay ~= nil then
            if countRealItems((pager.getItems(false))) > 0 then
                str2 = if str1 == "LoadingMore" then "LoadingMore" else "Loaded"
            elseif str1 == "Loaded" then
                str2 = "Empty"
            end
        end

        var4(str2)
    end

    local function retry()
        if pendingFeedOverlay ~= nil and getError(false) ~= nil then
            runFetch(true)
            return
        end
        runFetch(pager.getCount(false) == 0)
    end

    local function dispose()
        bool4 = true
        if effect ~= nil then
            effect()
        end
        if FFlagMomentsParentTimeLimit and effect2 ~= nil then
            effect2()
        end
        if arg1.dispose then
            arg1.dispose()
        end
        pager.dispose()
    end

    if FFlagMomentsParentTimeLimit and tbl4 ~= nil then
        local getIsLimitReached = tbl4.getIsLimitReached
        effect2 = Signals.createEffect(function(arg2)
            local isLimitReached = getIsLimitReached(arg2)
            if isLimitReached == bool5 then
                return
            end
            bool5 = isLimitReached
            if isLimitReached then
                publishStatus()

                if bool1 and var11 == MomentsSurfaceLoadManager.getSessionGeneration() then
                    MomentsSurfaceLoadManager.abort("parentalTimeLimitReached")
                end
            else
                runFetch(true)
            end
        end)
    end

    if pendingFeedOverlay ~= nil and arg1.getPendingItems ~= nil then
        if arg1.initialMomentId ~= nil then
            var2(math.huge)
        end

        local getPendingItems = arg1.getPendingItems
        effect = Signals.createEffect(function(arg2)
            local var18 = pendingFeedOverlay.update(getPendingItems(arg2), GetDeletedMomentsStore(false).getDeletedIds(arg2))
            local retainedItems = getRetainedItems()

            for i = #retainedItems, 1, -1 do
                if isTerminalPage(retainedItems[i]) then
                    table.remove(retainedItems, i)
                end
            end
            SignalsExperimental.batch(function()
                commitItems(retainedItems)
                table.clear(tbl6)
                resolveInitialIndex(false)
                var14(false)
                appendTerminalPage()
                publishStatus()

                if var18 and arg1.recommendationSource == "Trending" then
                    pager.goToItem(1)
                end
            end)
        end)
    end

    return {
        getInitialIndex = getInitialIndex,
        observabilityFeedType = recommendationSource,
        pager = pager,
        getStatus = getStatus,
        getError = getError,
        getHasMore = getHasMore,
        getLoadMoreFailed = getLoadMoreFailed,
        getAtScrollLimit = getAtScrollLimit,
        getCanLoadMoreBeyondLimit = getCanLoadMoreBeyondLimit,
        loadInitial = loadInitial,
        loadMore = loadMore,
        loadBeyondLimit = loadBeyondLimit,
        prependItem = prependItem,
        refresh = loadInitial,
        retry = retry,
        dispose = dispose
    }
end

return createFeedStore
