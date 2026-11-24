-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.Parent.types)
local sessionHistoryMerge = require(script.Parent.Parent.sessionHistoryMerge)

local constants = require(script.Parent.constants)
local historyPageUtils = require(script.Parent.historyPageUtils)
local _sessionDeps = require(script.Parent.sessionDeps)

return {
    createHistoryLoader = function(tbl1, arg1)
        local num1 = 0
        local currentCasSessionId = nil
        local var1 = nil

        local function isRefreshGenerationStale(num2: number): boolean -- Luacid: Inlined by compiler; 13 call sites recovered
            return num2 ~= tbl1.getRefreshGeneration()
        end

        local function clearHistoryLoadInFlightIfOwned(casSessionId: string) -- Luacid: Inlined by compiler; 5 call sites recovered
            if currentCasSessionId == casSessionId then
                tbl1.setHistoryLoadInFlight(false)
                currentCasSessionId = nil
            end
        end

        local function tryAcquireHistoryLoad(casSessionId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
            if tbl1.getHistoryLoadInFlight() then
                if currentCasSessionId == casSessionId then
                    return false
                end
                tbl1.setHistoryLoadInFlight(false)
                currentCasSessionId = nil
            end
            currentCasSessionId = casSessionId
            tbl1.setHistoryLoadInFlight(true)
            return true
        end

        local function loadHistoryPage(str1: string, historyPageToken: string?, func1: (...any) -> (...any))
            local var2

            if arg1 ~= nil then
                var2 = arg1(str1, historyPageToken, func1, math.huge)
            else
                local var3 = tbl1.deps.sessionLoad(str1, { historyPageToken = historyPageToken })
                var2 = historyPageUtils.awaitRequestStateCancelled(var3.state, func1)
            end
            if func1() or var2.status ~= "succeeded" then
                return false, {}, nil
            end
            if historyPageToken == nil and arg1 == nil then
                tbl1.onInitialSessionLoad(str1, var2.result)
            end

            return true, historyPageUtils.getSessionLoadHistory(var2.result), historyPageUtils.getNextHistoryPageToken(var2.result)
        end

        local function isSessionLoadStale(str1: string, num2: number, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 12 call sites recovered
            return func1() or tbl1.getCasSessionId() ~= str1 or not not isRefreshGenerationStale(num2)
        end

        local function isPrefetchStale(str1: string, num2: number, num3: number, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 6 call sites recovered
            return isSessionLoadStale(str1, num3, func1) or num2 ~= num1
        end

        local function commitRefreshedHistory(casSessionId: string, refreshGeneration: number, tbl2, str1: string?, func1: (...any) -> (...any)): boolean
            if isSessionLoadStale(casSessionId, refreshGeneration, func1) then
                return false
            end

            local tbl3 = {}
            local tbl4 = ({})
            sessionHistoryMerge.mergeHistoryIntoMap(tbl3, tbl2, tbl4)

            for value, value2 in tbl1.getOverlayBySequenceId() do
                if tbl3[value] == nil then
                    tbl4[value] = value2
                end
            end
            tbl1.setLoadedBySequenceId(tbl3)
            tbl1.setOverlayBySequenceId(tbl4)
            tbl1.setNextHistoryPageToken(str1)
            tbl1.noteHistorySequenceIds(tbl2)
            tbl1.notifyMergedHistoryChanged()
            tbl1.markHistoryLoaded()
            return true
        end

        local function prefetchOlderHistoryPagesInBackground(str1: string, str2: string?, func1: (...any) -> (...any), num2: number, num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
            task.spawn(function()
                local var2 = str2
                local prefetchHistoryPagesOnRefresh = constants.getPrefetchHistoryPagesOnRefresh()

                while prefetchHistoryPagesOnRefresh > 0 and var2 ~= nil do
                    if isPrefetchStale(str1, num2, num3, func1) then
                        return
                    end

                    local var3, var4
                    var3, var4, var2 = loadHistoryPage(str1, var2, func1)

                    if not var3 or isPrefetchStale(str1, num2, num3, func1) then
                        return
                    end
                    tbl1.mergeHistoryPage(var4, var2)

                    prefetchHistoryPagesOnRefresh -= 1
                end
            end)
        end

        local function beginPrefetchGeneration(): number -- Luacid: Inlined by compiler; 2 call sites recovered
            num1 += 1
            return num1
        end

        local var2 = nil
        local function refreshSession(func1: (...any) -> (...any), bool1: boolean?)
            local casSessionId = tbl1.getCasSessionId()
            if casSessionId == nil or casSessionId == "" then
                return false
            end
            local refreshGeneration = tbl1.getRefreshGeneration()

            if not tryAcquireHistoryLoad(casSessionId) then
                return false
            end

            local mergedHistory = tbl1.buildMergedHistory()
            local var3 = historyPageUtils.collectSequenceIds(mergedHistory)
            local bool2 = #mergedHistory > 0
            local num2 = 0
            local var4 = nil
            local tbl2 = {}
            local tbl3 = {}
            local bool3 = not bool2

            while true do
                num2 += 1
                local bool4, var5, var6 = loadHistoryPage(casSessionId, var4, func1)

                if not bool4 or isSessionLoadStale(casSessionId, refreshGeneration, func1) then
                    break
                end

                if bool2 and historyPageUtils.historyOverlapsSequenceIds(var5, var3) then
                    bool3 = true
                end

                historyPageUtils.appendUniqueHistoryBySequenceId(tbl2, var5, tbl3)
                local var7 = var6

                if not bool2 or bool3 or var7 == nil or constants.getMaxReconciliationHistoryPages() <= num2 then
                    if bool2 and bool3 then
                        if historyPageUtils.appendUniqueHistoryBySequenceId(tbl2, mergedHistory, tbl3) > 0 then
                            var7 = tbl1.getNextHistoryPageToken()
                        end
                    elseif bool2 then
                        historyPageUtils.appendUniqueHistoryBySequenceId(tbl2, mergedHistory, tbl3)
                    end

                    if not commitRefreshedHistory(casSessionId, refreshGeneration, tbl2, var7, func1) then
                        clearHistoryLoadInFlightIfOwned(casSessionId)
                        return false
                    end

                    clearHistoryLoadInFlightIfOwned(casSessionId)

                    if not bool2 and var7 ~= nil then
                        if bool1 then
                            var2(constants.getPrefetchHistoryPagesOnRefresh(), func1, nil)
                        else
                            local num3 = beginPrefetchGeneration()

                            task.defer(function()
                                prefetchOlderHistoryPagesInBackground(casSessionId, var7, func1, num3, refreshGeneration)
                            end)
                        end
                    end

                    return true
                end

                var4 = var7
            end

            clearHistoryLoadInFlightIfOwned(casSessionId)
            return false
        end

        local function loadOlderHistoryPage(func1: (...any) -> (...any))
            local casSessionId = tbl1.getCasSessionId()
            local nextHistoryPageToken = tbl1.getNextHistoryPageToken()
            if casSessionId == nil or nextHistoryPageToken == nil then
                return false, nil, nil, nil
            end
            local refreshGeneration = tbl1.getRefreshGeneration()

            if not tryAcquireHistoryLoad(casSessionId) then
                return false, nil, nil, nil
            end

            local bool1, var3, var4 = loadHistoryPage(casSessionId, nextHistoryPageToken, func1)

            if not bool1 or isSessionLoadStale(casSessionId, refreshGeneration, func1) then
                clearHistoryLoadInFlightIfOwned(casSessionId)
                return false, nil, nil, nil
            end

            tbl1.mergeHistoryPage(var3, var4)
            clearHistoryLoadInFlightIfOwned(casSessionId)

            if isSessionLoadStale(casSessionId, refreshGeneration, func1) then
                return false, nil, nil, nil
            end

            return true, casSessionId, refreshGeneration, var4
        end

        var2 = function(minimumPagesRemaining: number, isCancelled: (...any) -> (...any), shouldContinue: ((...any) -> (...any))?)
            local sessionId = tbl1.getCasSessionId()
            if sessionId == nil or tbl1.getNextHistoryPageToken() == nil then
                return
            end
            local refreshGeneration = tbl1.getRefreshGeneration()
            local var3 = var1
            if var3 ~= nil and var3.sessionId == sessionId and var3.refreshGeneration == refreshGeneration then
                var3.minimumPagesRemaining = math.max(var3.minimumPagesRemaining, minimumPagesRemaining)
                var3.isCancelled = isCancelled
                if shouldContinue ~= nil then
                    var3.shouldContinue = shouldContinue
                end
                return
            end

            local tbl2 = {
                sessionId = sessionId,
                refreshGeneration = refreshGeneration,
                minimumPagesRemaining = minimumPagesRemaining,
                isCancelled = isCancelled,
                shouldContinue = shouldContinue
            }
            var1 = tbl2
            task.defer(function()
                local success, result = xpcall(function()
                    while not isSessionLoadStale(tbl2.sessionId, tbl2.refreshGeneration, tbl2.isCancelled)
                        and tbl1.getNextHistoryPageToken() ~= nil do
                        local var4 = tbl2.minimumPagesRemaining > 0 or not (tbl2.shouldContinue == nil) and tbl2.shouldContinue()

                        if not (var4 and loadOlderHistoryPage(function()
                            return tbl2.isCancelled() or var1 ~= tbl2
                        end)) then
                            break
                        end

                        if tbl2.minimumPagesRemaining > 0 then
                            local tbl3 = tbl2
                            tbl3.minimumPagesRemaining -= 1
                        end
                        task.wait()
                    end
                end, debug.traceback)
                if var1 == tbl2 then
                    var1 = nil
                end
                if not success then
                    error(result)
                end
            end)
        end

        return {
            refreshSession = refreshSession,
            loadOlderHistory = function(func1: (...any) -> (...any))
                local bool1, var3, var4, var5 = loadOlderHistoryPage(func1)
                if bool1 and var3 ~= nil and var4 ~= nil and var5 ~= nil then
                    local num2 = beginPrefetchGeneration()

                    task.defer(function()
                        prefetchOlderHistoryPagesInBackground(var3, var5, func1, num2, var4)
                    end)
                end

                return bool1
            end,
            requestOlderHistoryWhile = function(func1: (...any) -> (...any), func2: (...any) -> (...any))
                var2(0, func1, func2)
            end
        }
    end
}
