-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AcpProtocol = require(script.Parent.Parent.Acp.AcpProtocol)
local _createTurnHandle = require(script.Parent.Parent.createTurnHandle)
local _types = require(script.Parent.Parent.types)

local tbl1 = {
    agent_message = true,
    agent_message_chunk = true,
    tool_call_update = true,
    tool_call_content_chunk = true,
    state_change = true
}

local function getHistorySequenceId(arg1): number? -- Luacid: Inlined by compiler; 1 call site recovered
    local sequenceId = arg1.sequenceId
    return if typeof(sequenceId) == "number" then sequenceId else nil
end

local function isAssistantSessionUpdate(update): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local sessionUpdate = update.sessionUpdate
    return typeof(sessionUpdate) == "string" and tbl1[sessionUpdate] == true
end

local function orderHistoryItems(tbl2)
    local result = {}
    for originalIndex, update in tbl2 do
        local sequenceId = getHistorySequenceId(update)
        table.insert(result, { update = update, originalIndex = originalIndex, sequenceId = sequenceId })
    end

    table.sort(result, function(arg1, arg2): boolean
        if arg1.sequenceId == nil or arg2.sequenceId == nil then
            return arg1.originalIndex < arg2.originalIndex
        end

        return arg1.sequenceId < arg2.sequenceId
    end)

    return result
end

return {
    ingestSessionHistory = function(tbl2, sessionId: string, tbl3, num1: number?)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        local activeTurnInternals = tbl2.getActiveTurnInternals(sessionId)
        if activeTurnInternals == nil then
            return {}
        end

        local result = {}
        for _, value in orderHistoryItems(tbl3) do
            local sequenceId = value.sequenceId
            if sequenceId == nil or num1 ~= nil and not (num1 < sequenceId) then
                continue
            end

            local var1 = if isAssistantSessionUpdate(value.update) then activeTurnInternals.dispatchFrame(
                {
                    kind = "notification",
                    notification = {
                        method = AcpProtocol.Notifications.SessionUpdate,
                        params = {
                            sessionId = sessionId,
                            update = value.update
                        }
                    }
                },
                { sequenceNumber = sequenceId },
                false
            ) else activeTurnInternals.noteProcessedSequenceNumber(sequenceId)

            if var1 then
                table.insert(result, sequenceId)
            end
            if activeTurnInternals.isDone() then
                tbl2.onTurnDone(activeTurnInternals)
                return result
            end
        end

        return result
    end
}
