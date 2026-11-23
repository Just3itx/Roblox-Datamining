-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local chatConstants = require(script.Parent.chatConstants)
local clientLogsCollector = require(script.Parent.clientLogsCollector)
local toolControllerUtils = require(script.Parent.toolControllerUtils)

local StudioClientLogsTool = CreatorAgentChat.StudioClientLogsTool
local debug2 = CreatorAgentChat.debug
local awaitRequestState = toolControllerUtils.awaitRequestState

local function getClientLogsReason(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "table" then
        return nil
    end
    return if typeof(arg1.reason) == "string" and arg1.reason ~= "" then arg1.reason else nil
end

local function fetchLatestSavedVersion(placeId: number?)
    if placeId == nil then
        return nil
    end

    local var1, var2 = require(BuildExperienceParent.DataHydration.PlaceVersionHistory).getPlaceVersionHistoryStore().fetchPageHistory(placeId):await()
    if not var1 or typeof(var2) ~= "table" or typeof(var2.placeVersions) ~= "table" then
        return nil
    end
    local placeVersion = var2.placeVersions[1]
    if typeof(placeVersion) ~= "table" then
        return nil
    end
    return tonumber(placeVersion.version)
end

local function createClientLogsController(arg1, tbl1, func1: ((...any) -> (...any))?)
    local function canHandleClientLogs() -- Luacid: Inlined by compiler; 2 call sites recovered
        return func1 == nil or func1()
    end

    local function submitClientLogsResult(tbl2)
        debug2.log("info", "ask_for_logs tool_result collecting", {
            sessionId = tbl2.sessionId,
            toolCallId = tbl2.toolCallId,
            turnId = tbl2.turnId,
            referenceId = tbl2.referenceId,
            reason = tbl2.reason
        })

        local startTime = os.clock()

        local minimumPlaceVersion = fetchLatestSavedVersion(arg1.placeId)

        if not canHandleClientLogs() then
            tbl1[tbl2.toolCallId] = nil
            return
        end
        local var2 = clientLogsCollector.collectToolResultContent(
            {
                universeId = arg1.universeId,
                placeId = arg1.placeId,
                minimumPlaceVersion = minimumPlaceVersion
            }
        )
        local collectDurationMs = math.floor((os.clock() - startTime) * 1000 + 0.5)

        local var3 = arg1.submitActiveToolResult(var2, false, tbl2.turnId, tbl2.referenceId)
        if var3 == nil then
            debug2.log(
                "warn",
                "ask_for_logs tool_result submit aborted (no active session)",
                {
                    toolCallId = tbl2.toolCallId,
                    collectDurationMs = collectDurationMs
                }
            )
            return
        end

        local startTime2 = os.clock()
        local var4 = awaitRequestState(var3.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        local submitDurationMs = math.floor((os.clock() - startTime2) * 1000 + 0.5)
        if var4.status ~= "succeeded" then
            debug2.log("warn", "ask_for_logs tool_result submit failed", {
                sessionId = tbl2.sessionId,
                toolCallId = tbl2.toolCallId,
                turnId = tbl2.turnId,
                referenceId = tbl2.referenceId,
                collectDurationMs = collectDurationMs,
                submitDurationMs = submitDurationMs,
                state = debug2.formatRequestState(var4)
            })
            return
        end

        debug2.log("info", "ask_for_logs tool_result submitted", {
            sessionId = tbl2.sessionId,
            toolCallId = tbl2.toolCallId,
            turnId = tbl2.turnId,
            referenceId = tbl2.referenceId,
            collectDurationMs = collectDurationMs,
            submitDurationMs = submitDurationMs
        })
    end

    return {
        syncClientLogsRequest = function(arg2): boolean
            if not canHandleClientLogs() then
                return false
            end

            local toolCallId, var2, turnId, referenceId = StudioClientLogsTool.findClientLogsRequestInTurnState(arg2, tbl1)
            if toolCallId == nil then
                return false
            end

            tbl1[toolCallId] = true
            local tbl2 = {
                sessionId = arg2.sessionId,
                toolCallId = toolCallId,
                turnId = turnId,
                referenceId = referenceId,
                reason = getClientLogsReason(var2)
            }
            task.spawn(function()
                submitClientLogsResult(tbl2)
            end)
            return true
        end
    }
end
return createClientLogsController
