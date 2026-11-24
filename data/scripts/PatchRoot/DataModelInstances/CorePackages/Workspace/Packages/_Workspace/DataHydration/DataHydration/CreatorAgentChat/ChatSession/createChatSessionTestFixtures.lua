-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local function makeRequestHandle()
    local state, var2 = Signals.createSignal({ status = "pending" })
    local function succeed(arg1)
        var2({ status = "succeeded", result = arg1 })
    end
    local function fail(error: string)
        var2({ status = "failed", error = error })
    end
    return {
        state = state,
        dispose = function() end
    }, succeed, fail
end

local function makeImmediateSuccess(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    local tbl1, func1 = makeRequestHandle()
    func1(arg1)
    return tbl1
end

local function makeTurnHandle(sessionId: string)
    local state, var2 = Signals.createSignal({
        sessionId = sessionId,
        requestId = nil,
        status = "queued",
        assistantText = "",
        assistantMessages = {},
        assistantMessageOrder = {},
        pendingAgentMessageId = nil,
        pendingAgentMessageContent = {},
        pendingAgentMessageSequenceIndex = nil,
        activitySlots = {},
        activityItems = {},
        toolCalls = {},
        toolCallCount = 0,
        infoUpdate = nil,
        stopReason = nil,
        error = nil,
        errorCode = nil,
        isDone = false
    })
    local isAccepted, var4 = Signals.createSignal(false)
    local wasCancelled = false
    local getTurnId = nil
    local tbl1 = ({})
    local num1 = 0
    local tbl2 = ({})
    local getLatestProcessedSequenceNumber = nil
    local var7 = nil
    local num2 = 0

    local function noteProcessedSequenceNumber(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl2[num3] == true then
            return
        end
        tbl2[num3] = true
        if getLatestProcessedSequenceNumber == nil then
            getLatestProcessedSequenceNumber = num3
            var7 = num3
        elseif getLatestProcessedSequenceNumber < num3 then
            num2 += num3 - getLatestProcessedSequenceNumber - 1
            getLatestProcessedSequenceNumber = num3
        elseif num3 < var7 then
            num2 += var7 - num3 - 1
            var7 = num3
        else
            num2 -= 1
        end
    end

    local tbl3 = {
        state = state,
        getTurnId = function()
            return getTurnId
        end,
        onNotification = function(arg1)
            num1 += 1
            local num3 = num1
            tbl1[num3] = arg1
            return function()
                tbl1[num3] = nil
            end
        end,
        getLatestProcessedSequenceNumber = function()
            return getLatestProcessedSequenceNumber
        end,
        hasSequenceGap = function(): boolean
            return num2 > 0
        end,
        noteProcessedSequenceNumber = noteProcessedSequenceNumber,
        isAccepted = isAccepted,
        cancel = function()
            wasCancelled = true
            local var8 = table.clone(state(false))
            var8.status = "cancelled"
            var8.isDone = true
            var2(var8)
        end
    }

    local function finish(arg1)
        if arg1 == nil then
            arg1 = table.clone(state(false))
            arg1.status = "succeeded"
            arg1.isDone = true
        end
        var2(arg1)
    end

    function tbl3.wasCancelled()
        return wasCancelled
    end
    function tbl3.setTurnId(num3: number?)
        getTurnId = num3
    end
    function tbl3.setLatestProcessedSequenceNumber(num3: number)
        noteProcessedSequenceNumber(num3)
    end

    function tbl3.emitNotification()
        for _, value in tbl1 do
            value()
        end
    end
    function tbl3.markStreaming()
        local var8 = table.clone(state(false))
        var8.status = "streaming"
        var2(var8)
    end
    function tbl3.markAccepted()
        var4(true)
    end
    function tbl3.fail()
        local var8 = table.clone(state(false))
        var8.status = "failed"
        var8.isDone = true
        var2(var8)
    end
    return tbl3, finish
end

return {
    Types = require(script.Parent.Parent.types),
    makeRequestHandle = makeRequestHandle,
    makeImmediateSuccess = makeImmediateSuccess,
    makeImmediateFailure = function(str1: string)
        local tbl1, _, func1 = makeRequestHandle()
        func1(str1)
        return tbl1
    end,
    makeImmediateFailureWithCode = function(error: string, errorCode: number)
        return {
            state = Signals.createSignal({ status = "failed", error = error, errorCode = errorCode }),
            dispose = function() end
        }
    end,
    makeTurnHandle = makeTurnHandle,
    defaultDeps = function()
        local initializeCalls = {}
        local sessionNewCalls = {}
        local sessionLoadCalls = {}
        local sessionLoadResults = {}
        local sessionPromptCalls = {}
        local ingestSessionHistoryCalls = {}
        local ingestSessionHistoryResults = {}
        local tbl8 = ({})
        local turnHandles = {}
        local tbl10 = {}

        return {
            deps = {
                initialize = function(_)
                    table.insert(initializeCalls, #initializeCalls + 1)
                    return makeImmediateSuccess({ protocolVersion = 2 })
                end,
                sessionNew = function(arg1)
                    table.insert(sessionNewCalls, arg1)
                    return makeImmediateSuccess({ sessionId = "cas-session-1" })
                end,
                sessionLoad = function(sessionId, params)
                    table.insert(sessionLoadCalls, { sessionId = sessionId, params = params })
                    local history = sessionLoadResults[#sessionLoadCalls] or {}
                    if history.history ~= nil or history.nextHistoryPageToken ~= nil then
                        return makeImmediateSuccess(history)
                    end

                    return makeImmediateSuccess({ history = history })
                end,
                sessionPrompt = function(arg1)
                    table.insert(sessionPromptCalls, arg1)
                    local tbl11, func1 = makeTurnHandle(arg1.sessionId)
                    table.insert(turnHandles, tbl11)
                    table.insert(tbl10, func1)
                    return tbl11
                end,
                ingestSessionHistory = function(sessionId, history, afterSequenceId)
                    table.insert(ingestSessionHistoryCalls, { sessionId = sessionId, history = history, afterSequenceId = afterSequenceId })

                    local var1 = ingestSessionHistoryResults[#ingestSessionHistoryCalls]
                    if var1 ~= nil then
                        return var1
                    end
                    local result = {}
                    for _, value in history do
                        local sequenceId = value.sequenceId
                        if typeof(sequenceId) ~= "number" or afterSequenceId ~= nil and not (afterSequenceId < sequenceId) then
                            continue
                        end

                        if tbl8[sequenceId] ~= true then
                            tbl8[sequenceId] = true
                            table.insert(result, sequenceId)
                        end
                        local var2 = turnHandles[#turnHandles]
                        if var2 ~= nil and var2.noteProcessedSequenceNumber ~= nil then
                            var2.noteProcessedSequenceNumber(sequenceId)
                        end
                    end

                    return result
                end,
                submitToolResult = function(_)
                    return makeImmediateSuccess(nil)
                end,
                getActiveTurnHandle = function(_)
                    return turnHandles[#turnHandles]
                end,
                onCasSessionIdChanged = function(_) end,
                rpcTimeoutSeconds = 5
            },
            initializeCalls = initializeCalls,
            sessionNewCalls = sessionNewCalls,
            sessionLoadCalls = sessionLoadCalls,
            sessionLoadResults = sessionLoadResults,
            sessionPromptCalls = sessionPromptCalls,
            ingestSessionHistoryCalls = ingestSessionHistoryCalls,
            ingestSessionHistoryResults = ingestSessionHistoryResults,
            turnHandles = turnHandles,
            finishLastTurn = function(arg1)
                local var1 = tbl10[#tbl10]
                if var1 ~= nil then
                    var1(arg1)
                end
            end
        }
    end,
    awaitTurnHandle = function(arg1, num1: number?)
        local num2 = os.clock() + (num1 or 3)

        while arg1.getTurnHandle(false) == nil and arg1.getSetupError(false) == nil and not (num2 < os.clock()) do
            task.wait()
        end
    end,
    waitFor = function(func1: (...any) -> (...any), num1: number?)
        local num2 = os.clock() + (num1 or 3)

        while not (func1() or num2 < os.clock()) do
            task.wait()
        end
    end
}
