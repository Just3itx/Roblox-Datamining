-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local RealtimeDelivery = require(DataHydrationParent.RealtimeDelivery)

local AcpProtocol = require(script.Parent.AcpProtocol)
local debug2 = require(script.Parent.Parent.debug)
local parseFrame = require(script.Parent.parseFrame)
local _types = require(script.Parent.Parent.types)

local robloxEventReceiver = nil
local num1 = 0
local var1 = nil
local num2 = 0

local function isConnectionState(enumItem): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return typeof(enumItem) == "EnumItem" and enumItem.EnumType == Enum.ConnectionState
end

local function previewString(str1: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    if #str1 <= 4000 then
        return str1
    end

    return string.sub(str1, 1, 4000) .. "…"
end

local function summarizeDetail(arg1, detailType)
    if typeof(arg1) == "string" then
        return {
            shape = "string",
            length = #arg1,
            preview = previewString(arg1),
            detailType = detailType
        }
    end
    if typeof(arg1) ~= "table" then
        return {
            shape = typeof(arg1),
            value = tostring(arg1),
            detailType = detailType
        }
    end

    local keys = {}
    for value in arg1 do
        table.insert(keys, value)
    end
    table.sort(keys)

    return { shape = "table", keys = keys, detailType = detailType }
end

local function extractRawFrame(arg1)
    if typeof(arg1) == "string" then
        return arg1
    end
    if typeof(arg1) ~= "table" then
        return nil
    end
    for _, value in {
        "frame",
        "payload",
        "message",
        "data",
        "body"
    } do
        local var2 = arg1[value]
        if typeof(var2) == "string" and var2 ~= "" then
            return var2
        end
    end
    return nil
end

local function extractRtnSequenceNumber(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if typeof(arg1) == "table" then arg1.sequence_number else nil
end

local function describeParsedFrame(arg1)
    if typeof(arg1) ~= "table" then
        return { kind = "unknown" }
    end
    if arg1.kind ~= "notification" or typeof(arg1.notification) ~= "table" then
        if arg1.kind ~= "response" or typeof(arg1.response) ~= "table" then
            return {
                kind = arg1.kind
            }
        end

        return {
            kind = "response",
            id = arg1.response.id,
            hasError = typeof(arg1.response.error) == "table"
        }
    end

    local tbl1 = {
        kind = "notification",
        method = arg1.notification.method
    }
    local params = arg1.notification.params
    if typeof(params) == "table" then
        tbl1.sessionId = params.sessionId
        local update = params.update
        if typeof(update) == "table" then
            if typeof(update.sessionUpdate) == "string" then
                tbl1.sessionUpdate = update.sessionUpdate
            end
            if update.sessionUpdate == "state_change" then
                tbl1.state = update.state
                tbl1.stopReason = update.stop_reason
            end
        end
    end
    return tbl1
end

local function onCapConnectionState(arg1, sequenceNumber, seqByNamespace) -- Luacid: Inlined by compiler; 2 call sites recovered
    debug2.log("info", "CAP RTN connection state", {
        namespace = AcpProtocol.CapRtnNamespace,
        connectionState = tostring(arg1),
        sequenceNumber = sequenceNumber,
        seqByNamespace = seqByNamespace
    })
end

local function onSignalRConnectionState(arg1, sequenceNumber, arg2)
    local capSequenceNumber = if typeof(arg2) == "table" then arg2[AcpProtocol.CapRtnNamespace] else nil
    debug2.log("info", "SignalR connection state", {
        connectionState = tostring(arg1),
        sequenceNumber = sequenceNumber,
        capNamespace = AcpProtocol.CapRtnNamespace,
        capSequenceNumber = capSequenceNumber
    })
end

local function onCapEvent(arg1, arg2, detailType)
    num2 += 1
    local messageIndex = num2

    debug2.log("info", "CAP RTN message received", {
        namespace = AcpProtocol.CapRtnNamespace,
        messageIndex = messageIndex,
        sequenceNumber = extractRtnSequenceNumber(arg2),
        summary = summarizeDetail(arg2, detailType)
    })

    local var2 = extractRawFrame(arg2)
    if var2 == nil then
        debug2.log("warn", "CAP RTN message has no parseable frame field", {
            namespace = AcpProtocol.CapRtnNamespace,
            messageIndex = messageIndex,
            summary = summarizeDetail(arg2, detailType),
            hint = "Expected string body or table key frame|payload|message|data|body"
        })

        return
    end

    debug2.log(
        "info",
        "CAP RTN raw frame",
        {
            namespace = AcpProtocol.CapRtnNamespace,
            messageIndex = messageIndex,
            length = #var2,
            preview = previewString(var2)
        }
    )
    local var3 = parseFrame(var2)
    if var3 == nil then
        debug2.log(
            "warn",
            "CAP frame dropped (parseFrame returned nil)",
            {
                messageIndex = messageIndex,
                preview = previewString(var2),
                hint = "Expected JSON-RPC notification or response"
            }
        )
        return
    end

    local parsed = describeParsedFrame(var3)
    debug2.log("info", "CAP frame ingested", { messageIndex = messageIndex, parsed = parsed })

    arg1.ingestFrame(var3, { sequenceNumber = extractRtnSequenceNumber(arg2) })

    if var3.kind == "response" then
        debug2.log("info", "CAP response ingested", { messageIndex = messageIndex, parsed = parsed })

        return
    end

    local sessionId = parsed.sessionId
    local function logTurnSnapshot(str1: string)
        if typeof(sessionId) ~= "string" then
            return
        end
        local activeTurnHandle = arg1.getActiveTurnHandle(sessionId)
        if activeTurnHandle == nil then
            return
        end
        debug2.log("info", str1, { messageIndex = messageIndex, turn = debug2.formatTurnState(activeTurnHandle.state(false)) })
    end

    if parsed.sessionUpdate == "agent_message_chunk" or parsed.sessionUpdate == "state_change" then
        logTurnSnapshot(`CAP turn state after {parsed.sessionUpdate}`)
    end
end

local function onNamespaceSignal(arg1, enumItem, arg2, seqByNamespace) -- Luacid: Inlined by compiler; 1 call site recovered
    if isConnectionState(enumItem) then
        onCapConnectionState(enumItem, arg2, seqByNamespace)
        return
    end

    onCapEvent(arg1, enumItem, arg2)
end

local function ensureReceiver() -- Luacid: Inlined by compiler; 1 call site recovered
    if robloxEventReceiver == nil then
        robloxEventReceiver = RealtimeDelivery.RobloxEventReceiver.new(NotificationService)
    end
end

local function subscribeCapNamespace(arg1)
    local capRtnNamespace = AcpProtocol.CapRtnNamespace
    debug2.log(
        "info",
        "listening on CAP RTN namespace (SignalR topic)",
        {
            namespace = capRtnNamespace,
            via = "NotificationService.RobloxEventReceived + RobloxConnectionChanged"
        }
    )

    local var2 = robloxEventReceiver:observeEvent(capRtnNamespace, function(enumItem, arg2, seqByNamespace)
        onNamespaceSignal(arg1, enumItem, arg2, seqByNamespace)
    end)

    local var3 = robloxEventReceiver:observeEvent("signalR", function(enumItem, sequenceNumber, arg2)
        if isConnectionState(enumItem) then
            onSignalRConnectionState(enumItem, sequenceNumber, arg2)
        end
    end)

    return function()
        var2:Disconnect()
        var3:Disconnect()
    end
end

local function wireCapDelivery(arg1)
    ensureReceiver()
    num1 += 1
    if var1 == nil then
        num2 = 0
        var1 = subscribeCapNamespace(arg1)
        debug2.log("info", "CAP RTN listener active — waiting for SignalR posts", { namespace = AcpProtocol.CapRtnNamespace })
    end

    return function()
        num1 -= 1
        if not (num1 <= 0) or not var1 then
            return
        end

        var1()
        var1 = nil
        num1 = 0
        debug2.log("info", "CAP RTN listener stopped", { namespace = AcpProtocol.CapRtnNamespace, framesReceivedCount = num2 })
    end
end

return wireCapDelivery
