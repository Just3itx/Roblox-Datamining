-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local createSignal = require(DataHydrationParent.Signals).createSignal

local AcpProtocol = require(script.Parent.Acp.AcpProtocol)
local turnState = require(script.Parent.turnState)
local _types = require(script.Parent.types)
local decodeFundingError = require(script.Parent.decodeFundingError)
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData

local FFlagBuildExperiencePromptFailureTelemetry = require(DataHydrationParent.SharedFlags).FFlagBuildExperiencePromptFailureTelemetry
local FFlagBuildExperienceLibrary = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceLibrary

local function createTurnHandle(str1: string, requestId, cancel: (...any) -> (...any), arg1, tbl1)
    local state, var2 = createSignal(arg1 or turnState.createEmptyTurnState(str1, requestId))

    local getTurnId = nil
    local tbl2 = ({})
    local tbl3 = ({})
    local num1 = 1
    local tbl4 = ({})
    local getLatestProcessedSequenceNumber = nil
    local num3 = nil
    local num4 = 0
    local var4 = nil

    local function noteProcessedSequenceNumber(num5: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl4[num5] == true then
            return false
        end

        tbl4[num5] = true
        if getLatestProcessedSequenceNumber == nil then
            getLatestProcessedSequenceNumber = num5
            num3 = num5
        elseif getLatestProcessedSequenceNumber < num5 then
            num4 += num5 - getLatestProcessedSequenceNumber - 1
            getLatestProcessedSequenceNumber = num5
        elseif num5 < num3 then
            num4 += num3 - num5 - 1
            num3 = num5
        else
            num4 -= 1
        end
        return true
    end

    local function hasSequenceGap(): boolean
        return num4 > 0
    end

    if tbl1 ~= nil then
        for _, value in tbl1 do
            if typeof(value) ~= "number" or tbl4[value] == true then
                continue
            end

            tbl4[value] = true
            if getLatestProcessedSequenceNumber == nil then
                getLatestProcessedSequenceNumber = value
                num3 = value
            elseif getLatestProcessedSequenceNumber < value then
                local var5 = value - getLatestProcessedSequenceNumber - 1
                num4 += var5
                getLatestProcessedSequenceNumber = value
            elseif value < num3 then
                local var5 = num3 - value - 1
                num4 += var5
                num3 = value
            else
                num4 -= 1
            end
        end
    end

    local function onNotification(arg2)
        local num5 = num1
        num1 += 1
        tbl2[num5] = arg2
        return function()
            tbl2[num5] = nil
        end
    end

    local function onUpdate(arg2)
        local num5 = num1
        num1 += 1
        tbl3[num5] = arg2
        return function()
            tbl3[num5] = nil
        end
    end

    local function fireUpdateHandlers(arg2, eventSequenceId: number?)
        for _, value in tbl3 do
            local success, result = pcall(function()
                value(arg2, eventSequenceId)
            end)
            if not success then
                warn(("CreatorAgentClient onUpdate handler errored: %s"):format(tostring(result)))
            end
        end
    end

    local function mutate(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 6 call sites recovered
        var2(function(arg2)
            if arg2.isDone then
                return arg2
            end
            local var5 = table.clone(arg2)
            callback(var5)
            return var5
        end)
    end

    local function fireHandlers(notification)
        for _, value in tbl2 do
            local success, result = pcall(function()
                value(notification)
            end)
            if not success then
                warn(("CreatorAgentClient onNotification handler errored: %s"):format(tostring(result)))
            end
        end
    end

    local function completeFromResponse(response) -- Luacid: Inlined by compiler; 1 call site recovered
        if not response.error then
            return
        end

        local error = response.error
        mutate(function(arg2)
            arg2.error = tostring(error.message or "JSON-RPC error")
            arg2.errorCode = tonumber(error.code)
            if FFlagBuildExperienceModelPickerData then
                local fundingReason, fundingDetails = decodeFundingError(error)
                arg2.fundingReason = fundingReason
                arg2.fundingDetails = fundingDetails
            end
            if FFlagBuildExperiencePromptFailureTelemetry then
                arg2.requestFailure = { kind = "rpc_error" }
            end
            arg2.status = "failed"
            arg2.isDone = true
        end)
    end

    local function getEventSequenceId(arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        local sequenceId = arg2.sequenceId
        if typeof(sequenceId) == "number" then
            return sequenceId
        end

        local sequenceNumber = if arg3 == nil then nil else arg3.sequenceNumber
        return if typeof(sequenceNumber) == "number" then sequenceNumber else nil
    end

    local function applyTerminalUpdate(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        local bool1 = arg2.sessionUpdate == "state_change" and arg2.state == "idle"

        if not bool1 and state(false).status ~= "queued" then
            return
        end
        mutate(function(arg3)
            if arg3.status == "queued" then
                arg3.status = "streaming"
            end
            if bool1 then
                local stopReason = if typeof(arg2.stop_reason) ~= "string" then "end_turn" else arg2.stop_reason
                arg3.stopReason = stopReason
                arg3.status = if stopReason == "cancelled" then "cancelled" else "succeeded"
                arg3.isDone = true
            end
        end)
    end

    local function dispatchFrame(arg2, arg3, bool1: boolean?)
        if state(false).isDone then
            return false
        end

        local bool2 = false
        if arg2.kind == "notification" then
            if arg2.notification.method == AcpProtocol.Notifications.SessionUpdate then
                local update = arg2.notification.params and arg2.notification.params.update
                if update ~= nil then
                    local eventSequenceId = getEventSequenceId(update, arg3)

                    if FFlagBuildExperienceModelPickerData and eventSequenceId ~= nil and var4 ~= nil and eventSequenceId <= var4 then
                        return false
                    end

                    bool2 = eventSequenceId == nil or noteProcessedSequenceNumber(eventSequenceId)

                    if FFlagBuildExperienceModelPickerData and not bool2 then
                        return false
                    end
                    if getTurnId == nil then
                        getTurnId = turnState.extractTurnId(update)
                    end

                    applyTerminalUpdate(update)

                    if FFlagBuildExperiencePromptFailureTelemetry and bool2 then
                        fireUpdateHandlers(update, eventSequenceId)
                    end
                end
            end
            if bool1 ~= false then
                fireHandlers(arg2.notification)
                return bool2
            end
        elseif arg2.kind == "response" then
            completeFromResponse(arg2.response)
            bool2 = arg2.response.error ~= nil
        end
        return bool2
    end

    local function fail(error: string, errorCode: number?, requestFailure, fundingReason, fundingDetails)
        mutate(function(arg2)
            arg2.error = error
            arg2.errorCode = errorCode
            if FFlagBuildExperienceModelPickerData then
                arg2.fundingReason = fundingReason
                arg2.fundingDetails = fundingDetails
            end
            if FFlagBuildExperiencePromptFailureTelemetry then
                arg2.requestFailure = requestFailure
            end

            arg2.status = "failed"
            arg2.isDone = true
        end)
    end

    local function markCancelled()
        mutate(function(arg2)
            arg2.status = "cancelled"
            arg2.stopReason = "cancelled"
            arg2.isDone = true
        end)
    end

    local var5, func1

    if FFlagBuildExperienceLibrary then
        local var6
        var5, var6 = createSignal(false)
        func1 = function()
            var6(true)
        end
    else
        var5 = nil
        func1 = nil
    end

    return {
        state = state,
        getTurnId = function()
            return getTurnId
        end,
        onNotification = onNotification,
        onUpdate = onUpdate,
        getLatestProcessedSequenceNumber = function()
            return getLatestProcessedSequenceNumber
        end,
        hasSequenceGap = hasSequenceGap,
        noteProcessedSequenceNumber = function(num5: number)
            if tbl4[num5] == true then
                return
            end

            tbl4[num5] = true
            if getLatestProcessedSequenceNumber == nil then
                getLatestProcessedSequenceNumber = num5
                num3 = num5
            elseif getLatestProcessedSequenceNumber < num5 then
                num4 += num5 - getLatestProcessedSequenceNumber - 1
                getLatestProcessedSequenceNumber = num5
            elseif num5 < num3 then
                num4 += num3 - num5 - 1
                num3 = num5
            else
                num4 -= 1
            end
        end,
        setHistoryBoundary = FFlagBuildExperienceModelPickerData and function(num5: number)
            if var4 == nil then
                var4 = num5
            end
        end or nil,
        cancel = cancel,
        isAccepted = var5
    }, {
        dispatchFrame = dispatchFrame,
        noteProcessedSequenceNumber = noteProcessedSequenceNumber,
        fail = fail,
        markCancelled = markCancelled,
        markAccepted = func1,
        isDone = function()
            return state(false).isDone
        end,
        requestId = requestId
    }
end
return createTurnHandle
