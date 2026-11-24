-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local SharedFlags = require(DataHydrationParent.SharedFlags)

local _types = require(script.Parent.Parent.types)

local constants = require(script.Parent.constants)
local historyPageUtils = require(script.Parent.historyPageUtils)
local _sessionDeps = require(script.Parent.sessionDeps)

local FFlagBuildExperienceHistoryPollTelemetry = SharedFlags.FFlagBuildExperienceHistoryPollTelemetry

return {
    createHistoryPolling = function(tbl1, arg1)
        local function pollSessionHistory(str1: string, afterSequenceId: number?, callback: ((...any) -> (...any))?, func1: (...any) -> (...any), pollTrigger, priorSequenceId: number?)
            if func1() then
                return false
            end

            local var1

            if arg1 ~= nil then
                var1 = arg1(str1, nil, func1)
            else
                local var2 = tbl1.deps.sessionLoad(str1, nil)
                var1 = historyPageUtils.awaitRequestState(var2.state, os.clock() + tbl1.rpcTimeoutSeconds)
                if var1.status == "pending" then
                    var2.dispose()
                    return false
                end
            end
            if func1() or var1.status ~= "succeeded" then
                return false
            end

            local sessionLoadHistory = historyPageUtils.getSessionLoadHistory(var1.result)
            if #sessionLoadHistory == 0 or func1() then
                return false
            end

            if func1() then
                return false
            end

            tbl1.mergeHistoryPage(sessionLoadHistory, tbl1.getNextHistoryPageToken())
            local var2 = tbl1.deps.ingestSessionHistory(str1, sessionLoadHistory, afterSequenceId)
            if callback ~= nil then
                local var3 = pollTrigger ~= nil and {
                    pollTrigger = pollTrigger,
                    appliedFromThisPoll = #var2,
                    priorSequenceId = priorSequenceId
                }
                    or nil

                for _, value in var2 do
                    callback(value, var3)
                end
            end
            return not func1() and #var2 > 0
        end

        local function startPollingTurnFromHistory(str1: string, arg2, arg3)
            local var1 = arg3 or {}
            local var2 = historyPageUtils.resolveNonNegativeNumber(var1.rtnIdleFallbackSeconds, constants.getRtnIdleFallbackSeconds())

            local var3 = historyPageUtils.resolveNonNegativeNumber(
                var1.rtnSequenceGapFallbackSeconds,
                constants.getRtnSequenceGapFallbackSeconds()
            )
            local var4 = historyPageUtils.resolvePositiveNumber(var1.pollMinIntervalSeconds, constants.getPollMinIntervalSeconds())

            local var5 = historyPageUtils.resolvePositiveNumber(var1.pollMaxIntervalSeconds, constants.getPollMaxIntervalSeconds())

            if var5 < var4 then
                var5 = var4
            end

            local afterSequenceId = var1.afterSequenceId
            if afterSequenceId ~= nil and arg2.setHistoryBoundary ~= nil then
                arg2.setHistoryBoundary(afterSequenceId)
            end
            local noteProcessedSequenceNumber = arg2.noteProcessedSequenceNumber
            if afterSequenceId ~= nil and noteProcessedSequenceNumber ~= nil then
                noteProcessedSequenceNumber(afterSequenceId)
            end

            local bool1 = false
            local bool2 = false
            local bool3 = false
            local bool4 = false
            local bool5 = false
            local var6 = var4
            local num1 = os.clock()
            local bool6 = false
            local num2 = 0
            local num3 = 0
            local num4 = 0

            local function shouldStopPolling() -- Luacid: Inlined by compiler; 21 call sites recovered
                local bool7 = bool1 or arg2.state(false).isDone
                return bool7 or tbl1.getCasSessionId() ~= str1 or arg2.isCurrentOwner ~= nil and not arg2.isCurrentOwner()
            end

            local var7 = nil

            local function stopPolling() -- Luacid: Inlined by compiler; 17 call sites recovered
                if not bool2 then
                    return
                end
                bool2 = false
                var6 = var4
                num4 += 1
            end

            local function startPolling() -- Luacid: Inlined by compiler; 8 call sites recovered
                if bool2 or shouldStopPolling() then
                    return
                end
                bool2 = true
                var6 = var4
                var7(0)
            end

            local function updatePollingState() -- Luacid: Inlined by compiler; 5 call sites recovered
                if shouldStopPolling() then
                    stopPolling()
                elseif bool3 or bool5 then
                    startPolling()
                else
                    stopPolling()
                end
            end

            local function refreshSequenceGapState()
                local hasSequenceGap = arg2.hasSequenceGap
                local var8 = not (hasSequenceGap == nil) and hasSequenceGap()

                if var8 == bool4 then
                    return
                end

                bool4 = var8
                bool5 = false
                num3 += 1
                local num5 = num3
                if var8 then
                    task.delay(var3, function()
                        if num5 ~= num3 or shouldStopPolling() or not bool4 then
                            return
                        end
                        bool5 = true
                        updatePollingState()
                    end)
                end

                updatePollingState()
            end

            local function func1(num5: number)
                if bool6 then
                    return
                end
                bool6 = true
                local num6 = num2
                task.delay(num5, function()
                    bool6 = false

                    if num6 ~= num2 or shouldStopPolling() then
                        return
                    end

                    local var8 = var2 - (os.clock() - num1)
                    if var8 > 0 then
                        func1(var8)
                        return
                    end
                    bool3 = true
                    updatePollingState()
                end)
            end

            local function noteRtnActivity() -- Luacid: Inlined by compiler; 2 call sites recovered
                num1 = os.clock()
                bool3 = false
                updatePollingState()
                func1(var2)
            end

            var7 = function(num5: number)
                num4 += 1
                local num6 = num4
                task.delay(num5, function()
                    if num6 ~= num4 or not bool2 or shouldStopPolling() then
                        return
                    end

                    local var8, var9

                    if FFlagBuildExperienceHistoryPollTelemetry then
                        var8 = if bool3 and bool5 then "both" elseif bool5 then "sequence_gap" else "rtn_idle"

                        local getLatestProcessedSequenceNumber = arg2.getLatestProcessedSequenceNumber
                        if getLatestProcessedSequenceNumber == nil then
                            var9 = nil
                        else
                            var9 = getLatestProcessedSequenceNumber()
                        end
                    else
                        var8 = nil
                        var9 = nil
                    end

                    local bool7 = pollSessionHistory(str1, afterSequenceId, var1.onDroppedChatMessage, shouldStopPolling, var8, var9)

                    if shouldStopPolling() then
                        stopPolling()
                        return
                    end

                    refreshSequenceGapState()
                    updatePollingState()

                    if not bool2 then
                        return
                    end

                    if bool7 then
                        var6 = var4
                    else
                        var6 = math.min(var5, var6 * constants.getPollBackoffMultiplier())
                    end
                    var7(var6)
                end)
            end

            local var8 = arg2.onNotification(function()
                noteRtnActivity()
                refreshSequenceGapState()
            end)

            refreshSequenceGapState()
            noteRtnActivity()

            return function()
                bool1 = true
                num2 += 1
                num3 += 1
                num4 += 1
                var8()
            end
        end

        return {
            startPollingTurnFromHistory = startPollingTurnFromHistory,
            startPollingActiveTurn = function(str1: string, arg2)
                local activeTurnHandle = tbl1.deps.getActiveTurnHandle(str1)
                if activeTurnHandle == nil then
                    return function() end
                end
                return (startPollingTurnFromHistory(str1, activeTurnHandle, arg2))
            end
        }
    end
}
