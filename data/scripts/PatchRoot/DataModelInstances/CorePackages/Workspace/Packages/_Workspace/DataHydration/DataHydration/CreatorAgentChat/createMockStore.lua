-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AcpProtocol = require(script.Parent.Acp.AcpProtocol)
local _types = require(script.Parent.types)
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData
local createCreatorAgentChatStore = require(script.Parent.createCreatorAgentChatStore)

local function isoNow(): string -- Luacid: Inlined by compiler; 6 call sites recovered
    return DateTime.now():ToIsoDate()
end

local function jsonError(id, code: number, message: string, statusCode: number)
    return {
        statusCode = statusCode,
        responseBody = HttpService:JSONEncode({ jsonrpc = "2.0", id = id, error = { code = code, message = message } })
    }
end

local function jsonOk(id, arg1)
    return {
        statusCode = 200,
        responseBody = HttpService:JSONEncode({ jsonrpc = "2.0", id = id, result = arg1 })
    }
end

local function streamWords(str1: string)
    local result = {}
    local bool1 = true
    for value in str1:gmatch("%S+") do
        if bool1 then
            table.insert(result, value)
            bool1 = false
        else
            table.insert(result, " " .. value)
        end
    end
    return result
end

local function httpStatusForCode(code: number): number
    if code == AcpProtocol.ErrorCodes.NotFound then
        return 404
    end

    if code == AcpProtocol.ErrorCodes.Gone then
        return 410
    end

    if code == AcpProtocol.ErrorCodes.Conflict then
        return 409
    end

    if code == AcpProtocol.ErrorCodes.UpstreamUnavailable then
        return 502
    end

    if code == AcpProtocol.ErrorCodes.Unauthorized then
        return 401
    end

    if code == AcpProtocol.ErrorCodes.Forbidden then
        return 403
    end

    if code == AcpProtocol.ErrorCodes.InternalError then
        return 500
    end

    return 400
end

local function createMockStore(tbl1)
    local tbl2 = tbl1 or {}
    local chunkDelay = tbl2.chunkDelay or 0.04

    local tbl3 = ({})
    local num1 = 0

    if tbl2.initialSessions then
        for _, initialSession in tbl2.initialSessions do
            num1 += 1
            local sessionId = initialSession.sessionId or ("mock_seed_%08d"):format(num1)
            local str1 = isoNow()

            tbl3[sessionId] = {
                sessionId = sessionId,
                title = initialSession.title,
                createdUtc = str1,
                updatedUtc = str1,
                closedUtc = nil
            }
        end
    end

    local function newSessionId(): string -- Luacid: Inlined by compiler; 1 call site recovered
        num1 += 1
        return ("mock_%08d"):format(num1)
    end

    local creatorAgentChatStore = nil

    local function emitNotification(sessionId: string, update, sequenceNumber: number)
        creatorAgentChatStore.ingestFrame({
            kind = "notification",
            notification = {
                method = AcpProtocol.Notifications.SessionUpdate,
                params = { sessionId = sessionId, update = update }
            }
        }, { sequenceNumber = sequenceNumber })
    end

    local function emitResponse(id, tbl4)
        creatorAgentChatStore.ingestFrame(
            {
                kind = "response",
                response = {
                    jsonrpc = "2.0",
                    id = id,
                    result = tbl4.result,
                    error = tbl4.error
                }
            }
        )
    end
    local function defaultResponder(tbl4)
        local str1 = ("Sure! I'll work on \"%s\" for you."):format(tbl4.promptText:sub(1, 60))
        for _, value in streamWords(str1) do
            tbl4.emitText(value)
            tbl4.sleep(chunkDelay)
        end
        tbl4.finish("end_turn")
    end

    local function stringResponder(respond: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        return function(arg1)
            for _, value in streamWords(respond) do
                arg1.emitText(value)
                arg1.sleep(chunkDelay)
            end
            arg1.finish("end_turn")
        end
    end

    local function pickResponder() -- Luacid: Inlined by compiler; 1 call site recovered
        local respond = tbl2.respond
        if respond == nil then
            return defaultResponder
        elseif typeof(respond) == "string" then
            return stringResponder(respond)
        end

        return respond
    end

    local function runResponder(id, sessionId: string, tbl4)
        local str1 = tostring(id)
        local messageId = `{str1}:user`
        local str2 = `{str1}:assistant`
        local str4 = ""
        for _, value in tbl4 do
            if value.type ~= "text" or typeof(value.text) ~= "string" then
                continue
            end

            if str4 == "" then
                str4 = value.text
            else
                str4 ..= "\n" .. value.text
            end
        end

        local num2 = 0
        local function emitSessionUpdate(update) -- Luacid: Inlined by compiler; 9 call sites recovered
            if tbl2.onSessionUpdate then
                tbl2.onSessionUpdate(update, num2)
            end
            emitNotification(sessionId, update, num2)
            num2 += 1
        end

        local bool1 = false
        local function finishTurn(stopReason) -- Luacid: Inlined by compiler; 1 call site recovered
            if bool1 then
                return
            end
            bool1 = true
            emitSessionUpdate({ sessionUpdate = "state_change", state = "idle", stop_reason = stopReason or "end_turn" })
        end

        local function failTurn(code: number, message: string)
            if bool1 then
                return
            end
            bool1 = true
            emitResponse(id, { error = { code = code, message = message } })
        end

        emitSessionUpdate({ sessionUpdate = "user_message", messageId = messageId, content = tbl4 })

        emitSessionUpdate({ sessionUpdate = "state_change", state = "running" })

        local tbl5 = {
            sessionId = sessionId,
            promptText = str4,
            promptBlocks = tbl4,
            sleep = task.wait,
            emitText = function(text)
                emitSessionUpdate({ sessionUpdate = "agent_message_chunk", messageId = str2, content = { type = "text", text = text } })
            end,
            emitToolCall = function(arg1)
                emitSessionUpdate({
                    sessionUpdate = "tool_call_update",
                    toolCallId = arg1.toolCallId,
                    title = arg1.title,
                    kind = arg1.kind,
                    status = arg1.status,
                    rawInput = arg1.rawInput
                })
            end,
            updateToolCall = function(toolCallId, arg1)
                emitSessionUpdate({
                    sessionUpdate = "tool_call_update",
                    toolCallId = toolCallId,
                    status = arg1.status,
                    rawOutput = arg1.rawOutput,
                    content = arg1.content
                })
            end,
            setTitle = function(title)
                local var1 = tbl3[sessionId]
                if var1 then
                    var1.title = title
                    var1.updatedUtc = isoNow()
                end
                emitSessionUpdate({ sessionUpdate = "session_info_update", title = title })
            end,
            finish = function(stopReason)
                finishTurn(stopReason)
            end,
            fail = function(code, message)
                failTurn(code, message)
            end
        }

        task.spawn(function()
            local success, result = pcall(function() -- name: callResponder
                pickResponder()(tbl5)
                return nil
            end)

            if not success then
                failTurn(AcpProtocol.ErrorCodes.InternalError, "Mock responder errored: " .. tostring(result))
                return
            end

            if bool1 then
                return
            end

            if bool1 then
                return
            end
            bool1 = true
            emitSessionUpdate({ sessionUpdate = "state_change", state = "idle", stop_reason = "end_turn" })
        end)
    end

    local function findSession(str1: string) -- Luacid: unused: defined but never referenced
        local var1 = tbl3[str1]
        if var1 == nil or var1.closedUtc ~= nil then
            return nil, {
                code = AcpProtocol.ErrorCodes.NotFound,
                message = "session not found"
            }
        end

        return var1, nil
    end

    local function sessionListEntry(tbl4)
        local tbl5 = {
            sessionId = tbl4.sessionId,
            title = tbl4.title,
            updatedAt = tbl4.updatedUtc
        }
        if tbl4.project ~= nil then
            tbl5._meta = {
                _roblox = {
                    universeId = tbl4.project.universeId
                }
            }
        end
        return tbl5
    end

    local tbl4 = {}
    tbl4[AcpProtocol.Methods.Initialize] = function()
        return {
            protocolVersion = AcpProtocol.ProtocolVersion,
            capabilities = {
                session = {
                    load = {},
                    prompt = { image = true, audio = false, embeddedContext = true },
                    mcp = {
                        http = {}
                    }
                },
                _meta = {
                    _roblox = { localToolExecution = true }
                }
            },
            agentInfo = { name = "mock-my-stats-service", version = "0.0.1-mock" }
        }, nil
    end
    tbl4[AcpProtocol.Methods.SessionNew] = function(arg1)
        local project = AcpProtocol.extractSessionNewProject(arg1)
        if project == nil then
            return nil, {
                code = AcpProtocol.ErrorCodes.InvalidParams,
                message = "_meta._roblox universeId/placeId is required on session/new"
            }
        end

        local sessionId = newSessionId()
        local str2 = isoNow()

        tbl3[sessionId] = {
            sessionId = sessionId,
            title = nil,
            createdUtc = str2,
            updatedUtc = str2,
            closedUtc = nil,
            project = project
        }
        if not FFlagBuildExperienceModelPickerData or tbl2.models == nil then
            return { sessionId = sessionId }, nil
        end

        return {
            sessionId = sessionId,
            _meta = {
                _roblox = {
                    models = tbl2.models
                }
            }
        }, nil
    end
    tbl4[AcpProtocol.Methods.SessionList] = function(_)
        local sessions = {}
        for _, value in tbl3 do
            if value.closedUtc == nil then
                table.insert(sessions, (sessionListEntry(value)))
            end
        end
        table.sort(sessions, function(arg1, arg2): boolean
            return (arg1.updatedAt or "") > (arg2.updatedAt or "")
        end)
        return { sessions = sessions }, nil
    end
    tbl4[AcpProtocol.Methods.SessionFindByUniverse] = function(arg1)
        if typeof(arg1.universeId) ~= "number" or arg1.universeId == 0 then
            return nil, {
                code = AcpProtocol.ErrorCodes.InvalidParams,
                message = "universeId is required"
            }
        end

        local sessions = {}
        for _, value in tbl3 do
            if value.closedUtc == nil and value.project ~= nil and value.project.universeId == arg1.universeId then
                table.insert(sessions, (sessionListEntry(value)))
            end
        end
        table.sort(sessions, function(arg2, arg3): boolean
            return (arg2.updatedAt or "") > (arg3.updatedAt or "")
        end)
        return { sessions = sessions }, nil
    end
    tbl4[AcpProtocol.Methods.SessionLoad] = function(arg1)
        local sessionId = arg1.sessionId
        local var1 = tbl3[sessionId]
        local tbl5

        if var1 == nil or var1.closedUtc ~= nil then
            tbl5 = {
                code = AcpProtocol.ErrorCodes.NotFound,
                message = "session not found"
            }
            var1 = nil
        else
            tbl5 = nil
        end

        if tbl5 then
            return nil, tbl5
        end
        return {
            _meta = {
                _roblox = {
                    models = if FFlagBuildExperienceModelPickerData then tbl2.models else nil,
                    universeId = if var1.project == nil then nil else var1.project.universeId
                }
            }
        }, nil
    end
    tbl4[AcpProtocol.Methods.SessionReadTasks] = function(arg1)
        local sessionId = arg1.sessionId
        local var1 = tbl3[sessionId]
        local var2 = (var1 == nil or var1.closedUtc ~= nil) and {
            code = AcpProtocol.ErrorCodes.NotFound,
            message = "session not found"
        }
            or nil

        if var2 then
            return nil, var2
        end
        return {
            tasks = {}
        }, nil
    end
    tbl4[AcpProtocol.Methods.SessionCancel] = function(arg1)
        local sessionId = arg1.sessionId
        local var1 = tbl3[sessionId]
        local var2 = (var1 == nil or var1.closedUtc ~= nil) and {
            code = AcpProtocol.ErrorCodes.NotFound,
            message = "session not found"
        }
            or nil

        if var2 then
            return nil, var2
        end

        return {}, nil
    end
    tbl4[AcpProtocol.Methods.SessionDelete] = function(arg1)
        local var1 = tbl3[arg1.sessionId]
        if var1 == nil then
            return nil, {
                code = AcpProtocol.ErrorCodes.NotFound,
                message = "session not found"
            }
        end

        var1.closedUtc = isoNow()
        return {}, nil
    end
    tbl4[AcpProtocol.Methods.SessionUpdateInfo] = function(arg1)
        local sessionId = arg1.sessionId
        local var1 = tbl3[sessionId]
        local tbl5

        if var1 == nil or var1.closedUtc ~= nil then
            tbl5 = {
                code = AcpProtocol.ErrorCodes.NotFound,
                message = "session not found"
            }
            var1 = nil
        else
            tbl5 = nil
        end

        if tbl5 then
            return nil, tbl5
        end
        if arg1.title ~= nil then
            var1.title = arg1.title
            var1.updatedUtc = isoNow()
        end
        return {}, nil
    end
    tbl4[AcpProtocol.Methods.SessionSaveAndPublish] = function(_)
        return { status = "success", version = "1" }, nil
    end
    tbl4[AcpProtocol.Methods.AdCampaignEligibility] = function(arg1)
        if typeof(arg1.universeId) ~= "number" or arg1.universeId <= 0 then
            return nil, {
                code = AcpProtocol.ErrorCodes.InvalidParams,
                message = "universeId is required"
            }
        end

        return {
            schemaVersion = 2,
            userEligible = true,
            universeEligible = true,
            freeCreditsRemaining = 1,
            cardType = "promote_free",
            ineligibleReasons = {},
            offer = { displayAmountRobux = 0, durationDays = 3 },
            offers = {
                {
                    campaignOption = "feedback",
                    fundingType = "free",
                    durationDays = 3,
                    priceRobux = 500
                },
                {
                    campaignOption = "plays",
                    fundingType = "paid",
                    durationDays = 7,
                    priceRobux = 2000
                }
            }
        }, nil
    end
    tbl4[AcpProtocol.Methods.AdCampaignCheckFunds] = function(arg1)
        if arg1.campaignOption ~= "feedback" and arg1.campaignOption ~= "plays" then
            return nil, {
                code = AcpProtocol.ErrorCodes.InvalidParams,
                message = "campaignOption is required"
            }
        end

        return { canFund = true, fundingSource = "robux" }, nil
    end
    tbl4[AcpProtocol.Methods.AdCampaignCreate] = function(arg1)
        if typeof(arg1.universeId) ~= "number" or arg1.universeId <= 0 then
            return nil, {
                code = AcpProtocol.ErrorCodes.InvalidParams,
                message = "universeId is required"
            }
        elseif typeof(arg1.idempotencyKey) ~= "string" or arg1.idempotencyKey == "" then
            return nil, {
                code = AcpProtocol.ErrorCodes.InvalidParams,
                message = "idempotencyKey is required"
            }
        end

        return {
            campaignId = "mock_campaign_0001",
            status = "in_review",
            toolCallId = arg1.toolCallId
        }, nil
    end

    local function dispatch(tbl5)
        if tbl5.method ~= AcpProtocol.Methods.SessionPrompt then
            local var1 = tbl4[tbl5.method]
            if var1 == nil then
                return (jsonError(tbl5.id, AcpProtocol.ErrorCodes.MethodNotFound, "Method not found: " .. tbl5.method, 404))
            end

            local success, result, result2 = pcall(var1, tbl5.params or {})
            if not success then
                return (jsonError(tbl5.id, AcpProtocol.ErrorCodes.InternalError, tostring(result), 500))
            elseif result2 then
                return (jsonError(tbl5.id, result2.code, result2.message, (httpStatusForCode(result2.code))))
            end
            return (jsonOk(tbl5.id, result))
        end

        local sessionId = tbl5.params.sessionId
        local var1 = tbl3[sessionId]
        local tbl6

        if var1 == nil or var1.closedUtc ~= nil then
            tbl6 = {
                code = AcpProtocol.ErrorCodes.NotFound,
                message = "session not found"
            }
            var1 = nil
        else
            tbl6 = nil
        end

        if tbl6 then
            return (jsonError(tbl5.id, tbl6.code, tbl6.message, (httpStatusForCode(tbl6.code))))
        end

        var1.updatedUtc = isoNow()
        runResponder(tbl5.id, tbl5.params.sessionId, tbl5.params.prompt or {})
        if FFlagBuildExperienceModelPickerData then
            return { statusCode = 202, responseBody = "" }
        end
        return (jsonOk(tbl5.id, {}))
    end

    creatorAgentChatStore = createCreatorAgentChatStore({
        network = {
            request = function(arg1, callback)
                local var1 = HttpService:JSONDecode(arg1.body or "{}")

                if typeof(var1) ~= "table" or typeof(var1.result) ~= "table" or var1.result.tool_name ~= "ask_tool" then
                    callback(true, (dispatch(var1)))
                    return function() end
                end

                callback(true, { statusCode = 200, responseBody = "{\"jsonrpc\":\"2.0\",\"id\":1,\"result\":{}}" })
                return function() end
            end
        },
        baseUrl = "mock://my-stats/v2"
    })

    return creatorAgentChatStore
end

return createMockStore
