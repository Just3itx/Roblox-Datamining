-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local chatConstants = require(script.Parent.chatConstants)
local clientDataModelCollector = require(script.Parent.clientDataModelCollector)
local toolControllerUtils = require(script.Parent.toolControllerUtils)

local StudioClientDataModelTools = CreatorAgentChat.StudioClientDataModelTools
local debug2 = CreatorAgentChat.debug

local function createClientDataModelController(arg1, tbl1, func1: ((...any) -> (...any))?)
    local var1 = func1 or function(): boolean
        return true
    end
    local tbl2 = ({})

    local function clearPending(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        tbl2[str1] = nil
        tbl1[str1] = nil
    end

    local function collectResult(tbl3)
        if tbl3.toolName == StudioClientDataModelTools.SEARCH_TOOL_NAME then
            return clientDataModelCollector.searchClientDataModel(tbl3.rawInput)
        end
        return clientDataModelCollector.inspectClientInstance(tbl3.rawInput)
    end

    local function submitResult(tbl3)
        if not var1() then
            clearPending(tbl3.toolCallId)
            return
        end
        debug2.log(
            "info",
            `{tbl3.toolName} tool_result collecting`,
            {
                sessionId = tbl3.sessionId,
                toolCallId = tbl3.toolCallId,
                turnId = tbl3.turnId,
                referenceId = tbl3.referenceId
            }
        )
        local startTime = os.clock()
        local success, result = pcall(collectResult, tbl3)
        local var2 = StudioClientDataModelTools.formatResultContent(
            not success and {
                status = "collection_failed",
                message = "The client DataModel could not be inspected."
            } or result
        )
        local collectDurationMs = math.floor((os.clock() - startTime) * 1000 + 0.5)

        if not var1() then
            clearPending(tbl3.toolCallId)
            return
        end
        local var3 = arg1.submitActiveToolResult(var2, false, tbl3.turnId, tbl3.referenceId)
        if var3 == nil then
            clearPending(tbl3.toolCallId)
            debug2.log(
                "warn",
                `{tbl3.toolName} tool_result submit aborted (no active session)`,
                {
                    toolCallId = tbl3.toolCallId,
                    collectDurationMs = collectDurationMs
                }
            )
            return
        end

        local startTime2 = os.clock()

        local var4 = toolControllerUtils.awaitRequestState(var3.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        local submitDurationMs = math.floor((os.clock() - startTime2) * 1000 + 0.5)
        tbl2[tbl3.toolCallId] = nil
        if var4.status == "succeeded" then
            debug2.log("info", `{tbl3.toolName} tool_result submitted`, {
                sessionId = tbl3.sessionId,
                toolCallId = tbl3.toolCallId,
                turnId = tbl3.turnId,
                referenceId = tbl3.referenceId,
                collectDurationMs = collectDurationMs,
                submitDurationMs = submitDurationMs
            })
            return
        end

        if var4.status == "pending" then
            var3.dispose()
        else
            tbl1[tbl3.toolCallId] = nil
        end
        debug2.log("warn", `{tbl3.toolName} tool_result submit failed`, {
            sessionId = tbl3.sessionId,
            toolCallId = tbl3.toolCallId,
            turnId = tbl3.turnId,
            referenceId = tbl3.referenceId,
            collectDurationMs = collectDurationMs,
            submitDurationMs = submitDurationMs,
            state = debug2.formatRequestState(var4)
        })
    end

    local function syncRequest(arg2, toolName: string, func2: (...any) -> (...any)): boolean
        if not var1() then
            return false
        end
        local toolCallId, rawInput, turnId, referenceId = func2(arg2, tbl1)
        if toolCallId == nil then
            return false
        end

        tbl1[toolCallId] = true
        tbl2[toolCallId] = true
        local tbl3 = {
            sessionId = arg2.sessionId,
            toolCallId = toolCallId,
            toolName = toolName,
            rawInput = rawInput,
            turnId = turnId,
            referenceId = referenceId
        }
        debug2.log("info", "runtime client tool call accepted", {
            sessionId = tbl3.sessionId,
            toolCallId = tbl3.toolCallId,
            toolName = tbl3.toolName,
            turnId = tbl3.turnId,
            referenceId = tbl3.referenceId,
            gameId = game.GameId,
            path = if typeof(rawInput) == "table" then rawInput.path else nil
        })
        task.spawn(function()
            submitResult(tbl3)
        end)
        return true
    end

    return {
        revokePending = function()
            for value in tbl2 do
                clearPending(value)
            end
        end,
        syncClientDataModelRequests = function(arg2): boolean
            local bool1 = syncRequest(arg2, StudioClientDataModelTools.SEARCH_TOOL_NAME, StudioClientDataModelTools.findSearchRequestInTurnState)

            local bool2 = syncRequest(
                arg2,
                StudioClientDataModelTools.INSPECT_TOOL_NAME,
                StudioClientDataModelTools.findInspectRequestInTurnState
            )
            return bool1 or bool2
        end
    }
end
return createClientDataModelController
