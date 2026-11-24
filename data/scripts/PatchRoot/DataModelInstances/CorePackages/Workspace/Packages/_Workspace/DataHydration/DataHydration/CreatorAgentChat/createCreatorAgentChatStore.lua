-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Signals = require(DataHydrationParent.Signals)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local SignalsUtils = require(DataHydrationParent.SignalsUtils)
local FFlagBuildAgentAdCampaignCard = require(script.Parent.FFlagBuildAgentAdCampaignCard)

local FFlagBuildAgentAdCampaignToolCallStatusFallback = require(DataHydrationParent.SharedFlags).FFlagBuildAgentAdCampaignToolCallStatusFallback
local decodeAdCampaignToolCallStatusResult = if FFlagBuildAgentAdCampaignToolCallStatusFallback then require(script.Parent.decodeAdCampaignToolCallStatusResult) else nil
local AcpProtocol = require(script.Parent.Acp.AcpProtocol)
local classifyRequestFailure = require(script.Parent.classifyRequestFailure)
local historyIngest = require(script.Parent.CasStore.historyIngest)
local ingestFrameHandler = require(script.Parent.CasStore.ingestFrameHandler)
local sessionRegistry = require(script.Parent.CasStore.sessionRegistry)
local constants = require(script.Parent.ChatSession.constants)
local createTurnHandle = require(script.Parent.createTurnHandle)
local experimentOverride = require(script.Parent.experimentOverride)
local onTerminal = require(script.Parent.onTerminal)
local rpcDecoder = require(script.Parent.rpcDecoder)
local getFundingError = require(script.Parent.getFundingError)
local _types = require(script.Parent.types)
local withCsrfRetry = require(DataHydration.withCsrfRetry)

local FFlagBuildExperienceModelPickerData = SharedFlags.FFlagBuildExperienceModelPickerData
local FFlagBuildExperienceChatOpenId = SharedFlags.FFlagBuildExperienceChatOpenId
local FFlagBuildExperiencePromptFailureTelemetry = SharedFlags.FFlagBuildExperiencePromptFailureTelemetry
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary

local function validateModelTier(model) -- Luacid: Inlined by compiler; 2 call sites recovered
    assert(model == nil or model == "default" or model == "advanced", "invalid model tier")
end

local function normalizeNextPageToken(nextPageToken): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if typeof(nextPageToken) == "string" and nextPageToken ~= "" then nextPageToken else nil
end

local function appendSessionListEntries(tbl1, tbl2)
    local tbl3 = ({})
    local result = {}
    for _, value in tbl1 do
        local sessionId = value.sessionId
        if typeof(sessionId) == "string" and sessionId ~= "" then
            tbl3[sessionId] = true
        end
        table.insert(result, value)
    end

    for _, value in tbl2 do
        local sessionId = value.sessionId
        if typeof(sessionId) == "string" and sessionId ~= "" and not tbl3[sessionId] then
            tbl3[sessionId] = true
            table.insert(result, value)
        end
    end

    return result
end

local function normalizePrompt(text) -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(text) == "string" then {{ type = "text", text = text }} else text
end

local tbl1 = {
    debug = function() end,
    info = function() end,
    warning = function() end,
    error = function() end
}

local function createCreatorAgentChatStore(arg1)
    local var1 = arg1 or {}
    local networkImpl = var1.network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
    local url = var1.baseUrl or AcpProtocol.acpUrl()
    local logger = var1.logger or tbl1

    local function authHeaders() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var1.getAuthHeaders then
            return (var1.getAuthHeaders())
        end

        return {}
    end

    local num1 = 0
    local function nextId() -- Luacid: Inlined by compiler; 7 call sites recovered
        if var1.generateRequestId then
            return var1.generateRequestId()
        end
        num1 += 1
        return num1
    end

    local function createActiveTurns()
        return {
            activeBySession = {},
            activeByRequestId = {},
            publicBySession = {},
            pendingCancels = {}
        }
    end
    local activeTurns = createActiveTurns()
    local var5 = not FFlagBuildExperienceModelPickerData and function(_)
        return activeTurns
    end or SignalsUtils.createSessionScopedSignal(createActiveTurns)

    local function requestIdKey(requestId) -- Luacid: Inlined by compiler; 1 call site recovered
        if requestId == nil then
            return nil
        end

        return tostring(requestId)
    end

    local function unregisterHandle(arg2)
        for value, value2 in var5(false).activeBySession do
            if value2 == arg2 then
                var5(false).activeBySession[value] = nil
                var5(false).publicBySession[value] = nil
                break
            end
        end

        local var6 = requestIdKey(arg2.requestId)
        if var6 and var5(false).activeByRequestId[var6] == arg2 then
            var5(false).activeByRequestId[var6] = nil
        end
    end

    local function rpcCall(id, method: string, params, func1: ((...any) -> (...any))?)
        logger:debug(`[CAS] -> {method} id={tostring(id)}`)
        return HttpClient.createRequest({
            networkImpl = networkImpl,
            method = "POST",
            url = url,
            headers = authHeaders(),
            body = {
                jsonrpc = "2.0",
                id = id,
                method = method,
                params = params or {}
            },
            analyticsKey = "cas." .. method:gsub("/", "-"):lower(),
            decode = rpcDecoder(func1)
        })
    end

    local function rpcCallSync(method: string, params, func1: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 4 call sites recovered
        return rpcCall(nextId(), method, params, func1)
    end

    local function submitToolResult(arg2)
        assert(typeof(arg2.sessionId) == "string" and arg2.sessionId ~= "", "sessionId is required")

        local content = arg2.content
        local bool1 = typeof(content) == "table" and typeof(arg2.content.text) == "string"
        assert(bool1, "content.text is required")

        if arg2.turnId ~= nil then
            assert(typeof(arg2.turnId) == "number" and arg2.turnId > 0, "turnId must be a positive number")
        end
        if arg2.referenceId ~= nil then
            assert(typeof(arg2.referenceId) == "string" and arg2.referenceId ~= "", "referenceId must be a string")
        end

        local id = nextId()
        local tbl2 = {
            sessionId = arg2.sessionId,
            tool_name = AcpProtocol.AskTool.Name,
            content = arg2.content,
            isError = not (arg2.isError == nil) and arg2.isError
        }
        if arg2.turnId ~= nil then
            tbl2.turnId = arg2.turnId
        end
        if arg2.referenceId ~= nil then
            tbl2.referenceId = arg2.referenceId
        end
        return (HttpClient.createRequest({
            networkImpl = networkImpl,
            method = "POST",
            url = url,
            headers = authHeaders(),
            body = { jsonrpc = "2.0", id = id, result = tbl2 },
            analyticsKey = "cas.ask-tool-result",
            decode = rpcDecoder()
        }))
    end

    local function initialize(arg2)
        return rpcCallSync(AcpProtocol.Methods.Initialize, arg2 or { protocolVersion = AcpProtocol.ProtocolVersion })
    end

    local function sessionNew(arg2)
        assert(arg2 ~= nil, "sessionNew requires params")
        assert(typeof(arg2.project) == "table", "sessionNew requires params.project")
        assert(typeof(arg2.project.universeId) == "number", "sessionNew requires params.project.universeId")
        assert(typeof(arg2.project.placeId) == "number", "sessionNew requires params.project.placeId")
        if FFlagBuildExperienceModelPickerData then
            validateModelTier(arg2.model)
        end
        return rpcCallSync(
            AcpProtocol.Methods.SessionNew,
            AcpProtocol.buildSessionNewWireParams({
                cwd = arg2.cwd or "/",
                mcpServers = arg2.mcpServers,
                project = arg2.project,
                model = if FFlagBuildExperienceModelPickerData then arg2.model else nil,
                experiment = arg2.experiment,
                application = arg2.application,
                chatOpenId = if FFlagBuildExperienceChatOpenId then arg2.chatOpenId else nil
            })
        )
    end

    local function sessionList(arg2)
        return rpcCallSync(AcpProtocol.Methods.SessionList, arg2 or {})
    end

    local getSessions, var7 = Signals.createSignal({})
    local getNextPageToken, var9 = Signals.createSignal(nil)
    local getStatus, var11 = Signals.createSignal("pending")
    local getLoadMoreStatus, var13 = Signals.createSignal(nil)
    local var14 = nil
    local var15 = nil
    local num2 = 0

    local getSessionListStore = {
        getSessions = getSessions,
        getNextPageToken = getNextPageToken,
        getStatus = getStatus,
        getLoadMoreStatus = getLoadMoreStatus,
        refresh = function() -- name: refreshSessionList
            if var14 ~= nil then
                if var14.state(false).status == "pending" then
                    return var14
                end

                var14 = nil
            end

            num2 += 1
            local num3 = num2
            var15 = nil
            var11("pending")
            var13(nil)
            local var16 = rpcCallSync(AcpProtocol.Methods.SessionList, {}, nil)

            var14 = var16
            onTerminal(var16.state, function(arg2)
                if num3 ~= num2 then
                    return
                end
                var14 = nil
                local var17 = arg2.sessions or {}
                local var18 = normalizeNextPageToken(arg2.nextPageToken)
                var7(var17)
                var9(var18)
                var11("succeeded")
            end, function(_)
                if num3 ~= num2 then
                    return
                end
                var14 = nil
                var11("failed")
            end)
            return var16
        end,
        loadMore = function() -- name: loadMoreSessionList
            local pageToken = getNextPageToken(false)
            if pageToken == nil then
                return nil
            end
            if var14 ~= nil then
                return nil
            end
            if var15 ~= nil then
                return nil
            end
            if getStatus(false) ~= "succeeded" then
                return nil
            end

            local num3 = num2

            var13("pending")
            local var17 = rpcCallSync(AcpProtocol.Methods.SessionList, { pageToken = pageToken } or {}, nil)

            var15 = var17
            onTerminal(var17.state, function(arg2)
                if num3 ~= num2 then
                    return
                end
                var15 = nil
                local var18 = arg2.sessions or {}
                local var19 = normalizeNextPageToken(arg2.nextPageToken)
                local tbl2 = appendSessionListEntries(getSessions(false), var18)
                var7(tbl2)
                var9(var19)
                var13("succeeded")
            end, function(_)
                if num3 ~= num2 then
                    return
                end
                var15 = nil
                var13("failed")
            end)
            return var17
        end
    }
    local function sessionFindByUniverse(params)
        assert(typeof(params) == "table", "sessionFindByUniverse requires params")
        assert(typeof(params.universeId) == "number" and params.universeId ~= 0, "universeId is required")
        return rpcCallSync(AcpProtocol.Methods.SessionFindByUniverse, params)
    end

    local function sessionLoad(sessionId: string, tbl3)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        return rpcCallSync(AcpProtocol.Methods.SessionLoad, {
            sessionId = sessionId,
            cwd = tbl3 and tbl3.cwd or "/",
            mcpServers = tbl3 and tbl3.mcpServers,
            historyPageToken = tbl3 and tbl3.historyPageToken
        })
    end

    local function sessionReadTasks(sessionId: string)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        return rpcCallSync(AcpProtocol.Methods.SessionReadTasks, { sessionId = sessionId })
    end

    local function postSessionCancel(sessionId: string) -- Luacid: unused: defined but never referenced
        return rpcCallSync(AcpProtocol.Methods.SessionCancel, { sessionId = sessionId })
    end

    local function sessionCancel(sessionId: string)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        local var16 = var5(false)
        local turn = var16.activeBySession[sessionId]

        local pendingCancel = var16.pendingCancels[sessionId]
        if FFlagBuildExperienceModelPickerData and pendingCancel ~= nil and pendingCancel.turn == turn then
            return pendingCancel.handle
        end

        local handle = rpcCallSync(AcpProtocol.Methods.SessionCancel, { sessionId = sessionId }, nil)

        local tbl3 = { handle = handle, turn = turn }
        if FFlagBuildExperienceModelPickerData then
            var16.pendingCancels[sessionId] = tbl3
        end
        local function clearPending() -- Luacid: Inlined by compiler; 1 call site recovered
            if var16.pendingCancels[sessionId] == tbl3 then
                var16.pendingCancels[sessionId] = nil
            end
        end
        onTerminal(handle.state, function()
            clearPending()
            local var19 = if FFlagBuildExperienceModelPickerData then turn else var5(false).activeBySession[sessionId]

            if var19 then
                var19.markCancelled()
                unregisterHandle(var19)
            end
        end, clearPending)

        return handle
    end

    local function sessionDelete(sessionId: string)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        local var16 = rpcCallSync(AcpProtocol.Methods.SessionDelete, { sessionId = sessionId }, nil)
        onTerminal(var16.state, function()
            local var17 = var5(false).activeBySession[sessionId]
            if var17 then
                var17.fail("Session deleted before prompt response", AcpProtocol.ErrorCodes.Gone)
                unregisterHandle(var17)
            end
        end)
        return var16
    end

    local function sessionUpdateInfo(sessionId: string, title: string?)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        return rpcCallSync(AcpProtocol.Methods.SessionUpdateInfo, { sessionId = sessionId, title = title })
    end

    local function sessionSaveAndPublish(params)
        assert(typeof(params) == "table", "sessionSaveAndPublish requires params")
        assert(typeof(params.placeId) == "number" and params.placeId > 0, "placeId must be a positive number")
        local bool1 = params.title == nil or typeof(params.title) == "string"
        assert(bool1, "title must be a string")
        local bool2 = params.description == nil or typeof(params.description) == "string"
        assert(bool2, "description must be a string")
        return rpcCallSync(AcpProtocol.Methods.SessionSaveAndPublish, params)
    end

    local function adCampaignEligibility(params)
        assert(typeof(params) == "table", "adCampaignEligibility requires params")
        assert(typeof(params.universeId) == "number" and params.universeId > 0, "universeId must be a positive number")
        local decodeAdCampaignEligibilityResult = require(script.Parent.decodeAdCampaignEligibilityResult)
        return rpcCallSync(AcpProtocol.Methods.AdCampaignEligibility, params, decodeAdCampaignEligibilityResult)
    end

    local function adCampaignCreate(params)
        assert(typeof(params) == "table", "adCampaignCreate requires params")
        assert(typeof(params.universeId) == "number" and params.universeId > 0, "universeId must be a positive number")
        assert(typeof(params.idempotencyKey) == "string" and params.idempotencyKey ~= "", "idempotencyKey is required")
        local decodeAdCampaignCreateResult = require(script.Parent.decodeAdCampaignCreateResult)
        if not FFlagBuildAgentAdCampaignCard or params.toolCallId == nil then
            return rpcCallSync(AcpProtocol.Methods.AdCampaignCreate, params, decodeAdCampaignCreateResult)
        end

        assert(typeof(params.toolCallId) == "string" and params.toolCallId ~= "", "toolCallId is required")
        return rpcCallSync(AcpProtocol.Methods.AdCampaignCreate, params, function(arg2)
            local var16, var17 = decodeAdCampaignCreateResult(arg2)
            if var16 ~= nil and var16.toolCallId ~= nil and var16.toolCallId ~= params.toolCallId then
                return nil, "Ad campaign create response does not match the requested tool call"
            end
            return var16, var17
        end)
    end
    local function adCampaignToolCallStatus(params)
        assert(typeof(params) == "table", "adCampaignToolCallStatus requires params")
        assert(typeof(params.toolCallId) == "string" and params.toolCallId ~= "", "toolCallId is required")
        return rpcCallSync(AcpProtocol.Methods.AdCampaignToolCallStatus, params, decodeAdCampaignToolCallStatusResult)
    end

    local function adCampaignCheckFunds(params)
        assert(typeof(params) == "table", "adCampaignCheckFunds requires params")
        assert(
            params.campaignOption == "feedback" or params.campaignOption == "plays",
            "campaignOption must be feedback or plays"
        )

        local decodeAdCampaignCheckFundsResult = require(script.Parent.decodeAdCampaignCheckFundsResult)
        return rpcCallSync(AcpProtocol.Methods.AdCampaignCheckFunds, params, decodeAdCampaignCheckFundsResult)
    end

    local function registerTurnHandle(sessionId: string, arg2, arg3, tbl3)
        local var16 = var5(false)
        local var17, var18 = createTurnHandle(sessionId, arg2, function()
            if not FFlagBuildExperienceModelPickerData or var5(false) == var16 then
                sessionCancel(sessionId)
            end
        end, arg3, tbl3)

        var5(false).activeBySession[sessionId] = var18
        var5(false).publicBySession[sessionId] = var17
        if arg2 ~= nil then
            var5(false).activeByRequestId[tostring(arg2)] = var18
        end
        if FFlagBuildExperienceModelPickerData then
            function var17.isCurrentOwner(): boolean
                return var5(false) == var16
            end
        end
        return var17
    end

    local function sessionPrompt(arg2)
        local bool1 = arg2 and typeof(arg2.sessionId) == "string" and arg2.sessionId ~= ""
        assert(bool1, "sessionId is required")
        assert(arg2.prompt, "prompt is required")
        if FFlagBuildExperienceModelPickerData then
            validateModelTier(arg2.model)
            local model = arg2._meta and arg2._meta._roblox and arg2._meta._roblox.model
            assert(arg2.model == nil or model == nil or model == arg2.model, "conflicting model tiers")
        end

        local sessionId = arg2.sessionId
        local var16 = nextId()
        local var17 = registerTurnHandle(sessionId, var16, nil, nil)
        local var18 = var5(false).activeBySession[sessionId]
        local sessionPromptWireParams = AcpProtocol.buildSessionPromptWireParams({
            sessionId = sessionId,
            prompt = normalizePrompt(arg2.prompt),
            meta = arg2._meta,
            model = if FFlagBuildExperienceModelPickerData then arg2.model else nil,
            experiment = if FFlagBuildExperienceModelPickerData or experimentOverride.isEnabled() then arg2.experiment else nil
        })

        local var19 = rpcCall(var16, AcpProtocol.Methods.SessionPrompt, sessionPromptWireParams)
        local markAccepted = if FFlagBuildExperienceLibrary then var18.markAccepted else nil

        onTerminal(var19.state, markAccepted, function(arg3, arg4)
            local var20 = if FFlagBuildExperiencePromptFailureTelemetry then classifyRequestFailure(var19.state(false)) else nil

            task.defer(function()
                if var18.isDone() then
                    return
                end

                local var21, var22

                if FFlagBuildExperienceModelPickerData then
                    var21, var22 = getFundingError(var19.state(false))
                else
                    var21 = nil
                    var22 = nil
                end
                var18.fail(arg3, arg4, var20, var21, var22)
                if var18.isDone() then
                    unregisterHandle(var18)
                end
            end)
        end)

        return var17
    end

    local function resumeTurnFromHistory(sessionId: string, arg2, tbl3)
        assert(typeof(sessionId) == "string" and sessionId ~= "", "sessionId is required")
        if arg2.isDone then
            return nil
        end
        local var16 = var5(false).publicBySession[sessionId]
        if var16 ~= nil then
            return var16
        end
        return (registerTurnHandle(sessionId, nil, arg2, tbl3))
    end

    local function getActiveTurnHandle(str1: string)
        return var5(false).publicBySession[str1]
    end

    local function ingestSessionHistory(str1: string, tbl3, num3: number?)
        return historyIngest.ingestSessionHistory({
            getActiveTurnInternals = function(str2: string)
                return var5(false).activeBySession[str2]
            end,
            onTurnDone = unregisterHandle
        }, str1, tbl3, num3)
    end

    local sessionRegistry2 = sessionRegistry.createSessionRegistry({
        initialize = initialize,
        sessionNew = sessionNew,
        sessionLoad = sessionLoad,
        sessionPrompt = sessionPrompt,
        ingestSessionHistory = ingestSessionHistory,
        submitToolResult = submitToolResult,
        getActiveTurnHandle = getActiveTurnHandle,
        onCasSessionIdChanged = function(_: string?) end,
        rpcTimeoutSeconds = constants.getRpcTimeoutSeconds()
    })

    local function ingestFrame(arg2, arg3)
        ingestFrameHandler.ingestFrame({
            logger = logger,
            getSessionByCasSessionId = sessionRegistry2.getSessionByCasSessionId,
            getSessionForProject = sessionRegistry2.getSessionForProject,
            getActiveTurnBySession = function(str1: string)
                return var5(false).activeBySession[str1]
            end,
            getActiveTurnByRequestId = function(str1: string)
                return var5(false).activeByRequestId[str1]
            end,
            onTurnDone = unregisterHandle
        }, arg2, arg3)
    end

    local tbl3 = {
        initialize = initialize,
        sessionNew = sessionNew,
        sessionList = sessionList,
        getSessionListStore = function()
            return getSessionListStore
        end,
        sessionFindByUniverse = sessionFindByUniverse,
        sessionLoad = sessionLoad,
        sessionReadTasks = sessionReadTasks,
        sessionPrompt = sessionPrompt,
        submitToolResult = submitToolResult,
        sessionCancel = sessionCancel,
        sessionDelete = sessionDelete,
        sessionUpdateInfo = sessionUpdateInfo,
        sessionSaveAndPublish = sessionSaveAndPublish,
        adCampaignEligibility = adCampaignEligibility,
        adCampaignCheckFunds = adCampaignCheckFunds,
        adCampaignCreate = adCampaignCreate,
        adCampaignToolCallStatus = 0,
        ingestSessionHistory = 0,
        ingestFrame = 0,
        resumeTurnFromHistory = 0,
        getActiveTurnHandle = 0,
        getSessionForProject = 0
    }

    if not FFlagBuildAgentAdCampaignToolCallStatusFallback then
        adCampaignToolCallStatus = nil
    end

    tbl3.adCampaignToolCallStatus = adCampaignToolCallStatus

    tbl3.ingestSessionHistory = ingestSessionHistory
    tbl3.ingestFrame = ingestFrame
    tbl3.resumeTurnFromHistory = resumeTurnFromHistory
    tbl3.getActiveTurnHandle = getActiveTurnHandle
    tbl3.getSessionForProject = sessionRegistry2.getSessionForProject
    return tbl3
end

return createCreatorAgentChatStore
