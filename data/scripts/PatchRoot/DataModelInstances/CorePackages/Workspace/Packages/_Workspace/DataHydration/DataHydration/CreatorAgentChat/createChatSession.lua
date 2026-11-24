-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)
local SharedFlags = require(DataHydrationParent.SharedFlags)

local AcpProtocol = require(script.Parent.Acp.AcpProtocol)
local classifyRequestFailure = require(script.Parent.classifyRequestFailure)
local chatOpenTelemetry = require(script.Parent.chatOpenTelemetry)
local experimentOverride = require(script.Parent.experimentOverride)
local getFundingError = require(script.Parent.getFundingError)
local sendConfiguration = require(script.Parent.sendConfiguration)
local FFlagBuildExperienceModelPickerData = SharedFlags.FFlagBuildExperienceModelPickerData
local FFlagBuildExperienceChatOpenId = SharedFlags.FFlagBuildExperienceChatOpenId
local FFlagBuildExperienceAdvancedPreviewSpecs = SharedFlags.FFlagBuildExperienceAdvancedPreviewSpecs
local sessionHistoryMerge = require(script.Parent.sessionHistoryMerge)
local _types = require(script.Parent.types)

local constants = require(script.Parent.ChatSession.constants)
local historyLoader = require(script.Parent.ChatSession.historyLoader)
local historyPageUtils = require(script.Parent.ChatSession.historyPageUtils)
local historyPolling = require(script.Parent.ChatSession.historyPolling)
local sendPrompt = require(script.Parent.ChatSession.sendPrompt)
local sessionHistoryCache = require(script.Parent.ChatSession.sessionHistoryCache)
local sessionScalarState = require(script.Parent.ChatSession.sessionScalarState)
local _sessionDeps = require(script.Parent.ChatSession.sessionDeps)
local FFlagBuildExperiencePromptFailureTelemetry = SharedFlags.FFlagBuildExperiencePromptFailureTelemetry

local function createChatSession(deps, universeId: number?, placeId: number?, str1: string?)
    local tbl1 = {}
    local tbl2 = {}

    local sessionScalarState2 = sessionScalarState.createSessionScalarState(str1)
    local var1 = nil
    local rpcTimeoutSeconds = deps.rpcTimeoutSeconds or constants.getRpcTimeoutSeconds()
    local sessionHistoryCache2 = sessionHistoryCache.createSessionHistoryCache()
    local num1 = 0
    local num2 = 0
    local num3 = 0

    local var2 = nil

    local experiment = nil

    local function getExperimentKey() -- Luacid: Inlined by compiler; 5 call sites recovered
        return experimentOverride.getKey(sessionScalarState2.getCasSessionId(false)) or var2
    end

    local function captureSessionNewExperiment() -- Luacid: Inlined by compiler; 2 call sites recovered
        experiment = if experimentOverride.isEnabled() then experimentOverride.getExperiment((getExperimentKey())) else nil
    end

    local function getSendChatOpenId() -- Luacid: Inlined by compiler; 1 call site recovered
        return chatOpenTelemetry.getChatOpenIdForUniverse(universeId)
    end

    local function buildMergedHistory()
        return sessionHistoryMerge.orderMergedHistoryItems(tbl1, tbl2)
    end

    local getMergedHistory, var4 = Signals.createSignal(buildMergedHistory())

    local function notifySessionStateChanged() -- Luacid: Inlined by compiler; 5 call sites recovered
        var4(buildMergedHistory())
    end

    local function noteHistorySequenceIds(tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
        sessionScalarState2.noteHistorySequenceId(historyPageUtils.getMaxHistorySequenceId(tbl3))
    end

    local function noteTurnSequenceIds(arg1)
        local getLatestProcessedSequenceNumber = arg1.getLatestProcessedSequenceNumber
        if getLatestProcessedSequenceNumber ~= nil then
            sessionScalarState2.noteHistorySequenceId(getLatestProcessedSequenceNumber())
        end
    end

    local function snapshotActiveSession()
        local casSessionId = sessionScalarState2.getCasSessionId(false)

        if casSessionId == nil or casSessionId == "" then
            return nil
        end

        return {
            loadedBySequenceId = tbl1,
            overlayBySequenceId = tbl2,
            hasLoadedHistory = sessionScalarState2.getHasLoadedHistory(false),
            nextHistoryPageToken = sessionScalarState2.getNextHistoryPageToken(false),
            latestObservedHistorySequenceId = sessionScalarState2.getLatestObservedHistorySequenceId(false)
        }
    end

    local function saveActiveSessionToCache() -- Luacid: Inlined by compiler; 1 call site recovered
        local casSessionId = sessionScalarState2.getCasSessionId(false)
        if casSessionId == nil or casSessionId == "" or not sessionScalarState2.getHasLoadedHistory(false) then
            return
        end
        local var5 = snapshotActiveSession()
        if var5 ~= nil then
            sessionHistoryCache2.save(casSessionId, var5)
        end
    end

    local function restoreSessionFromCache(str2: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local var5 = sessionHistoryCache2.restore(str2)
        if var5 == nil then
            return false
        end
        tbl1 = var5.loadedBySequenceId
        tbl2 = var5.overlayBySequenceId
        sessionScalarState2.setHasLoadedHistory(var5.hasLoadedHistory)
        sessionScalarState2.setNextHistoryPageToken(var5.nextHistoryPageToken)
        sessionScalarState2.setLatestObservedHistorySequenceId(var5.latestObservedHistorySequenceId)
        notifySessionStateChanged()
        return true
    end

    local function clearActiveSessionState()
        tbl1 = {}
        tbl2 = {}
        sessionScalarState2.setHasLoadedHistory(false)
        sessionScalarState2.setNextHistoryPageToken(nil)
        sessionScalarState2.setHistoryLoadInFlight(false)
        sessionScalarState2.setLatestObservedHistorySequenceId(nil)
        notifySessionStateChanged()
    end

    local function setCasSessionIdInternal(str2: string)
        if str2 == "" or sessionScalarState2.getCasSessionId(false) == str2 then
            return
        end

        num1 += 1
        if FFlagBuildExperienceModelPickerData then
            sessionScalarState2.setModels(nil)
            sessionScalarState2.setHasObservedModels(false)
        end

        saveActiveSessionToCache()
        sessionScalarState2.setCasSessionId(str2)
        if FFlagBuildExperienceModelPickerData and experimentOverride.isEnabled() then
            experimentOverride.move(var2, experimentOverride.getKey(str2))
        end
        sessionScalarState2.setHistoryLoadInFlight(false)

        if restoreSessionFromCache(str2) then
            deps.onCasSessionIdChanged(str2)
            return
        end
        clearActiveSessionState()
        deps.onCasSessionIdChanged(str2)
    end

    local function mergeHistoryPage(tbl3, str2: string?)
        sessionHistoryMerge.mergeHistoryIntoMap(tbl1, tbl3, tbl2)
        sessionScalarState2.setNextHistoryPageToken(str2)
        noteHistorySequenceIds(tbl3)
        notifySessionStateChanged()
    end

    local function ingestRealtimeUpdate(arg1, num4: number)
        if sessionHistoryMerge.ingestOverlayUpdate(tbl2, tbl1, arg1, num4) then
            sessionScalarState2.noteHistorySequenceId(num4)
            notifySessionStateChanged()
        end
    end

    local function awaitRequest(arg1, func1: ((...any) -> (...any))?, num4: number?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var5 = historyPageUtils.awaitRequestState(arg1.state, num4 or os.clock() + rpcTimeoutSeconds, func1)
        if func1 ~= nil then
            arg1.dispose()
        end
        return var5
    end

    local function publishModels(result) -- Luacid: Inlined by compiler; 2 call sites recovered
        local _roblox = if result and result._meta then result._meta._roblox else nil
        sessionScalarState2.setModels(if _roblox then _roblox.models else nil)
        sessionScalarState2.setHasObservedModels(true)
    end

    local function publishExperiment(str2: string, arg1)
        if not experimentOverride.isEnabled() then
            return
        end
        local key = experimentOverride.getKey(str2)

        if experimentOverride.isPending(key) or FFlagBuildExperienceModelPickerData and experimentOverride.hasInternalEdit(key) then
            return
        end

        local experiment2 = if arg1 == nil or arg1._meta == nil or arg1._meta._roblox == nil then nil else arg1._meta._roblox.experiment

        if experiment2 == nil then
            experimentOverride.clear(key)

            return
        end

        local hydrate = experimentOverride.hydrate

        local specVersion = experiment2.specVersion
        if not FFlagBuildExperienceModelPickerData then
            experiment2 = nil
        end

        hydrate(key, specVersion, experiment2)
    end
    local function loadSession(str2: string, historyPageToken: string?, func1: (...any) -> (...any), num4: number?)
        local num5 = num1
        num2 += 1
        local num6 = num2
        local function isStale() -- Luacid: Inlined by compiler; 2 call sites recovered
            return func1() or num5 ~= num1 or sessionScalarState2.getCasSessionId(false) ~= str2
        end

        if isStale() then
            return { status = "pending" }
        end
        local var5 = awaitRequest(deps.sessionLoad(str2, { historyPageToken = historyPageToken }), isStale, num4)

        if isStale() then
            return { status = "pending" }
        end
        if var5.status == "succeeded" and num3 < num6 then
            num3 = num6
            publishModels(var5.result)
            publishExperiment(str2, var5.result)
        end
        return var5
    end

    local tbl3 = {
        deps = deps,
        rpcTimeoutSeconds = rpcTimeoutSeconds,
        getCasSessionId = function()
            return sessionScalarState2.getCasSessionId(false)
        end,
        getHistoryLoadInFlight = function()
            return sessionScalarState2.getHistoryLoadInFlight(false)
        end,
        setHistoryLoadInFlight = sessionScalarState2.setHistoryLoadInFlight,
        getNextHistoryPageToken = function()
            return sessionScalarState2.getNextHistoryPageToken(false)
        end,
        setNextHistoryPageToken = sessionScalarState2.setNextHistoryPageToken,
        getLoadedBySequenceId = function()
            return tbl1
        end,
        setLoadedBySequenceId = function(tbl3)
            tbl1 = tbl3
        end,
        getOverlayBySequenceId = function()
            return tbl2
        end,
        setOverlayBySequenceId = function(tbl3)
            tbl2 = tbl3
        end,
        buildMergedHistory = buildMergedHistory,
        mergeHistoryPage = mergeHistoryPage,
        noteHistorySequenceIds = noteHistorySequenceIds,
        notifyMergedHistoryChanged = notifySessionStateChanged,
        markHistoryLoaded = sessionScalarState2.markHistoryLoaded,
        getRefreshGeneration = function()
            return num1
        end,
        onInitialSessionLoad = publishExperiment
    }
    local historyLoader2 = historyLoader.createHistoryLoader(tbl3, if FFlagBuildExperienceModelPickerData then loadSession else nil)

    local historyPolling2 = historyPolling.createHistoryPolling(
        {
            deps = deps,
            rpcTimeoutSeconds = rpcTimeoutSeconds,
            getCasSessionId = function()
                return sessionScalarState2.getCasSessionId(false)
            end,
            getNextHistoryPageToken = function()
                return sessionScalarState2.getNextHistoryPageToken(false)
            end,
            mergeHistoryPage = mergeHistoryPage
        },
        if FFlagBuildExperienceModelPickerData then loadSession else nil
    )

    local function ensureInitialized(func1: ((...any) -> (...any))?)
        if sessionScalarState2.getInitialized(false) then
            return true, nil, nil
        end
        local var5 = awaitRequest(deps.initialize({ protocolVersion = AcpProtocol.ProtocolVersion }), func1, false)

        if func1 ~= nil and func1() then
            return false, nil, nil
        elseif var5.status ~= "succeeded" then
            local bool1 = false
            local errorCode = var5.errorCode
            if FFlagBuildExperiencePromptFailureTelemetry then
                return bool1, errorCode, (classifyRequestFailure(var5))
            end

            return bool1, errorCode, nil
        else
            sessionScalarState2.setInitialized(true)
            return true, nil, nil
        end
    end
    local function createCasSession(model, func1: ((...any) -> (...any))?, arg2, func2: ((...any) -> (...any))?, chatOpenId: string?)
        local num4 = num1
        local function isStale() -- Luacid: Inlined by compiler; 2 call sites recovered
            return num4 ~= num1 or not (func1 == nil) and func1()
        end

        local var5 = if FFlagBuildExperienceModelPickerData and arg2 ~= nil then arg2.experiment else experiment
        local casSessionId = sessionScalarState2.getCasSessionId(false)
        if casSessionId ~= nil and not FFlagBuildExperienceModelPickerData then
            return casSessionId, nil
        end
        if casSessionId == nil and (universeId == nil or placeId == nil) then
            return nil, { stage = "missing_project" }
        end

        local bool1, errorCode, var7 = ensureInitialized(if FFlagBuildExperienceModelPickerData then isStale else func1)

        if FFlagBuildExperienceModelPickerData and isStale() then
            return nil, nil
        end
        if not bool1 then
            local var8 = nil
            local tbl4 = { stage = "initialize", errorCode = errorCode, requestFailure = 0 }
            if not FFlagBuildExperiencePromptFailureTelemetry then
                var7 = nil
            end

            tbl4.requestFailure = var7
            return var8, tbl4
        end

        if casSessionId ~= nil then
            return casSessionId, nil
        end

        if func2 ~= nil and func2() then
            return nil, nil
        end
        local sessionNew = deps.sessionNew
        local tbl4 = {
            project = { universeId = universeId, placeId = placeId },
            experiment = if FFlagBuildExperienceModelPickerData then var5 else experiment,
            model = 0,
            application = "build",
            chatOpenId = 0
        }

        if not FFlagBuildExperienceModelPickerData then
            model = nil
        end

        tbl4.model = model

        if not FFlagBuildExperienceChatOpenId then
            chatOpenId = nil
        end

        tbl4.chatOpenId = chatOpenId
        local var8 = sessionNew(tbl4)
        local var9 = awaitRequest(var8, if FFlagBuildExperienceModelPickerData then isStale else func1, false)

        if FFlagBuildExperienceModelPickerData and isStale() then
            return nil, nil
        end
        if var9.status ~= "succeeded" then
            local var10, var11

            if FFlagBuildExperienceModelPickerData then
                var10, var11 = getFundingError(var9)
            else
                var10 = nil
                var11 = nil
            end
            return nil, {
                stage = "session_new",
                message = if FFlagBuildExperienceModelPickerData then var9.error else nil,
                errorCode = var9.errorCode,
                fundingReason = var10,
                fundingDetails = var11,
                requestFailure = if FFlagBuildExperiencePromptFailureTelemetry then classifyRequestFailure(var9) else nil
            }
        end

        local result = var9.result
        local sessionId = if typeof(result) == "table" then result.sessionId else nil

        if typeof(sessionId) ~= "string" or sessionId == "" then
            return nil, { stage = "session_new" }
        end
        if experimentOverride.isEnabled() then
            local key = experimentOverride.getKey(sessionId)
            if not FFlagBuildExperienceModelPickerData then
                var5 = experiment
            end

            if experimentOverride.has(var2) then
                experimentOverride.move(var2, key)
            elseif var5 ~= nil then
                experimentOverride.hydrate(key, var5.specVersion, if FFlagBuildExperienceAdvancedPreviewSpecs then var5 else nil)
            end

            if not FFlagBuildExperienceModelPickerData
                or arg2 == nil
                or sendConfiguration.sameExperiment(experimentOverride.getPromptExperiment(key), var5)
            then
                experimentOverride.consumePending(key)
            end
        end
        setCasSessionIdInternal(sessionId)
        if not FFlagBuildExperienceModelPickerData then
            return sessionId, nil
        end

        if sessionScalarState2.getCasSessionId(false) ~= sessionId then
            return nil, nil
        end

        publishModels(result)
        return sessionId, nil
    end

    local var5 = nil

    local function newSetup(model, arg1, chatOpenId: string?)
        local tbl4 = {
            generation = num1,
            model = model,
            experiment = if arg1 ~= nil then arg1.experiment else experiment,
            abandoners = {},
            persistent = false,
            committed = false,
            done = false,
            chatOpenId = 0
        }

        if not FFlagBuildExperienceChatOpenId then
            chatOpenId = nil
        end

        tbl4.chatOpenId = chatOpenId
        return tbl4
    end

    local function canAbandon(tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl4.persistent then
            return false
        end
        for k in tbl4.abandoners do
            if not k() then
                return false
            end
        end
        return true
    end

    local function isReplaceable(tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
        local bool1 = not (tbl4.committed or tbl4.done)

        if bool1 then
            if tbl4.persistent then
                return false
            end
            for k in tbl4.abandoners do
                if not k() then
                    return false
                end
            end

            bool1 = true
        end

        return bool1
    end

    local function ensureCasSession(model, func1: ((...any) -> (...any))?, arg1, bool1: boolean?, str2: string?)
        if not FFlagBuildExperienceModelPickerData
            or sessionScalarState2.getCasSessionId(false) ~= nil and sessionScalarState2.getInitialized(false)
        then
            local func2 = createCasSession

            local var6 = nil
            if not FFlagBuildExperienceChatOpenId then
                str2 = nil
            end

            return func2(model, func1, arg1, var6, str2)
        end

        local function callerCancelled() -- Luacid: Inlined by compiler; 3 call sites recovered
            return not (func1 == nil) and func1()
        end

        if callerCancelled() then
            return nil, nil
        end
        local var6 = var5
        local bool2 = var6 == nil or var6.generation ~= num1
        if bool2 then
            var6 = newSetup(model, arg1, str2)
            var5 = var6
        end

        local bool3 = sessionScalarState2.getCasSessionId(false) == nil and var6.model ~= nil and model ~= nil and model ~= var6.model
        local bool4 = sessionScalarState2.getCasSessionId(false) == nil
            and arg1 ~= nil
            and (var6.model ~= arg1.tier or not sendConfiguration.sameExperiment(var6.experiment, arg1.experiment))

        if not bool2 and (bool3 or bool4) and isReplaceable(var6) then
            bool2 = true
            var6 = newSetup(model, arg1, str2)
            var5 = var6
        else
            if bool3 then
                return nil, {
                    stage = "session_new",
                    message = "session creation already started with a different model"
                }
            end

            if bool4 then
                return nil, {
                    stage = "session_new",
                    message = "session creation already started with a different send configuration"
                }
            end
        end

        if bool1 and func1 ~= nil then
            var6.abandoners[callerCancelled] = true
        else
            var6.persistent = true
        end
        if bool2 then
            task.spawn(function()
                local success, result, result2 = pcall(createCasSession, model, nil, arg1, function(): boolean
                    if canAbandon(var6) then
                        return true
                    end
                    var6.committed = true
                    return false
                end, var6.chatOpenId)
                local var7 = var6
                var7.sessionId = if success then result else nil
                var6.error = not success and {
                    stage = "session_new",
                    message = tostring(result)
                } or result2
                var6.done = true
                if var5 == var6 then
                    var5 = nil
                end
            end)
        end
        while not (var6.done or callerCancelled()) do
            task.wait()
        end

        if callerCancelled() or var6.sessionId ~= nil and var6.sessionId ~= sessionScalarState2.getCasSessionId(false) then
            return nil, nil
        end
        return var6.sessionId, var6.error
    end

    local function prepareSession(arg1)
        local sendChatOpenId = if FFlagBuildExperienceChatOpenId then getSendChatOpenId() else nil
        local var6 = if arg1 == nil or arg1.sendConfiguration == nil then nil else sendConfiguration.capture(arg1.sendConfiguration.tier, arg1.sendConfiguration.experiment)
        local var7 = if var6 ~= nil then var6.tier elseif arg1 == nil then nil else arg1.model
        assert(var6 == nil or arg1 == nil or arg1.model == nil or arg1.model == var7, "conflicting model tiers")

        local num4 = num1
        local function isCancelled() -- Luacid: Inlined by compiler; 3 call sites recovered
            return num4 ~= num1 or not (arg1 == nil or arg1.isCancelled == nil) and arg1.isCancelled()
        end

        if isCancelled() then
            return nil, nil
        end
        if var6 == nil then
            captureSessionNewExperiment()
        end

        local casSessionId = sessionScalarState2.getCasSessionId(false)
        if casSessionId == nil then
            if var5 ~= nil and var5.generation == num4 and var7 ~= nil and var7 ~= var5.model and not isReplaceable(var5) then
                return nil, {
                    stage = "session_new",
                    message = "session creation already started with a different model"
                }
            end
            return ensureCasSession(var7, if arg1 == nil then nil else arg1.isCancelled, var6, var6 ~= nil, sendChatOpenId)
        end

        local var8, var9 = ensureCasSession(nil, isCancelled, var6, nil, sendChatOpenId)

        if isCancelled() then
            return nil, nil
        end
        if var8 == nil then
            return nil, var9
        end
        local var10 = loadSession(casSessionId, nil, isCancelled)

        if isCancelled() then
            return nil, nil
        end
        if var10.status == "succeeded" then
            noteHistorySequenceIds((historyPageUtils.getSessionLoadHistory(var10.result)))
            return casSessionId, nil
        end

        local var11, var12

        if FFlagBuildExperienceModelPickerData then
            var11, var12 = getFundingError(var10)
        else
            var11 = nil
            var12 = nil
        end
        return nil, {
            stage = "session_load",
            message = var10.error,
            errorCode = var10.errorCode,
            fundingReason = var11,
            fundingDetails = var12,
            requestFailure = if FFlagBuildExperiencePromptFailureTelemetry then classifyRequestFailure(var10) else nil
        }
    end
    local sendPrompt2 = sendPrompt.createSendPrompt({
        ensureInitialized = ensureInitialized,
        ensureCasSession = ensureCasSession,
        getSendChatOpenId = getSendChatOpenId,
        getLatestObservedHistorySequenceId = function()
            return sessionScalarState2.getLatestObservedHistorySequenceId(false)
        end,
        noteTurnSequenceIds = noteTurnSequenceIds,
        startPollingTurnFromHistory = historyPolling2.startPollingTurnFromHistory,
        getAssistantTurnSequence = function()
            return sessionScalarState2.getAssistantTurnSequence(false)
        end,
        incrementAssistantTurnSequence = sessionScalarState2.incrementAssistantTurnSequence,
        sessionPrompt = function(arg1, arg2)
            local var3 = if FFlagBuildExperienceModelPickerData and arg2 ~= nil then arg2.experiment elseif experimentOverride.isEnabled() then experimentOverride.getPromptExperiment((getExperimentKey())) else nil
            local var7 = deps.sessionPrompt({
                sessionId = arg1.sessionId,
                prompt = arg1.prompt,
                model = if FFlagBuildExperienceModelPickerData then arg1.model else nil,
                _meta = arg1._meta,
                experiment = var3
            })
            if not FFlagBuildExperienceModelPickerData then
                if var3 ~= nil then
                    experimentOverride.consumePending((getExperimentKey()))
                end
                return var7, nil
            end

            local key = experimentOverride.getKey(arg1.sessionId)

            if var3 == nil then
                return var7, nil
            end

            return var7, function()
                if (var7.isCurrentOwner == nil or var7.isCurrentOwner())
                    and sendConfiguration.sameExperiment(experimentOverride.getPromptExperiment(key), var3)
                then
                    experimentOverride.consumePending(key)
                end
            end
        end,
        setActiveStop = function(func1: ((...any) -> (...any))?)
            var1 = func1
        end
    })

    local function getActiveTurnHandle()
        local casSessionId = sessionScalarState2.getCasSessionId(false)
        if casSessionId == nil then
            return nil
        end
        return deps.getActiveTurnHandle(casSessionId)
    end

    local function submitActiveToolResult(content, isError: boolean?, turnId: number?, referenceId: string?)
        local sessionId = sessionScalarState2.getCasSessionId(false)
        if sessionId == nil then
            return nil
        end
        local submitToolResult = deps.submitToolResult
        local tbl4 = {
            sessionId = sessionId,
            turnId = turnId,
            referenceId = referenceId,
            content = content,
            isError = 0
        }

        if isError == nil then
            isError = false
        end

        tbl4.isError = isError
        return submitToolResult(tbl4)
    end

    local function stopActiveTurn()
        if var1 ~= nil then
            var1()
        end
    end

    local module = {
        getModels = sessionScalarState2.getModels,
        hasObservedModels = sessionScalarState2.hasObservedModels,
        prepareSession = 0,
        universeId = 0,
        placeId = 0,
        getCasSessionId = 0,
        setCasSessionId = 0,
        setPendingExperimentKey = 0,
        hasLoadedHistory = 0,
        markHistoryLoaded = 0,
        getNextHistoryPageToken = 0,
        getMergedHistory = 0,
        ingestRealtimeUpdate = 0,
        mergeHistoryPage = 0,
        refreshSession = 0,
        loadOlderHistory = 0,
        requestOlderHistoryWhile = 0,
        sendPrompt = 0,
        stopActiveTurn = 0,
        submitActiveToolResult = 0,
        getActiveTurnHandle = 0,
        startPollingActiveTurn = 0
    }

    if not FFlagBuildExperienceModelPickerData then
        prepareSession = nil
    end

    module.prepareSession = prepareSession
    module.universeId = universeId
    module.placeId = placeId
    function module.getCasSessionId()
        return sessionScalarState2.getCasSessionId(false)
    end
    module.setCasSessionId = setCasSessionIdInternal
    function module.setPendingExperimentKey(str2: string?)
        var2 = str2
        if FFlagBuildExperienceModelPickerData and experimentOverride.isEnabled() then
            experimentOverride.move(str2, experimentOverride.getKey(sessionScalarState2.getCasSessionId(false)))
        end
    end
    function module.hasLoadedHistory()
        return sessionScalarState2.getHasLoadedHistory(false)
    end
    module.markHistoryLoaded = sessionScalarState2.markHistoryLoaded
    function module.getNextHistoryPageToken()
        return sessionScalarState2.getNextHistoryPageToken(false)
    end
    module.getMergedHistory = getMergedHistory
    module.ingestRealtimeUpdate = ingestRealtimeUpdate
    module.mergeHistoryPage = mergeHistoryPage
    module.refreshSession = historyLoader2.refreshSession
    module.loadOlderHistory = historyLoader2.loadOlderHistory
    module.requestOlderHistoryWhile = historyLoader2.requestOlderHistoryWhile
    function module.sendPrompt(arg1)
        if not FFlagBuildExperienceModelPickerData or arg1.sendConfiguration == nil then
            captureSessionNewExperiment()
        end

        return sendPrompt2.sendPrompt(arg1)
    end
    module.stopActiveTurn = stopActiveTurn
    module.submitActiveToolResult = submitActiveToolResult
    module.getActiveTurnHandle = getActiveTurnHandle
    function module.startPollingActiveTurn(arg1)
        local casSessionId = sessionScalarState2.getCasSessionId(false)
        if casSessionId == nil then
            return function() end
        end
        return historyPolling2.startPollingActiveTurn(casSessionId, arg1)
    end

    return module
end

return createChatSession
