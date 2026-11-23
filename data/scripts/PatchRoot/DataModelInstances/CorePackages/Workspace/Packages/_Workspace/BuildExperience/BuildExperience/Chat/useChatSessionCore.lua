-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local FFlagBuildExperienceChatOpenId = require(BuildExperience.Flags.FFlagBuildExperienceChatOpenId)
local engineFeature = game:GetEngineFeature("BuildAppStorageKey")

local FFlagBuildExperiencePrefillSkipsDraftPersist = require(BuildExperience.Flags.FFlagBuildExperiencePrefillSkipsDraftPersist)

local MessageBusService = game:GetService("MessageBusService")
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local UniverseCreate = require(BuildExperienceParent.DataHydration.UniverseCreate)
local React = require(BuildExperienceParent.React)
local ReactUtils = require(BuildExperienceParent.ReactUtils)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local LocalizationRoactContext = require(BuildExperienceParent.Localization).LocalizationRoactContext
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceChatAccordionScrollAnchor = require(BuildExperience.Flags.FFlagBuildExperienceChatAccordionScrollAnchor)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary
local FFlagBuildExperiencePromptFailureTelemetry = SharedFlags.FFlagBuildExperiencePromptFailureTelemetry
local FFlagBuildExperienceNewGameChatDraft = require(BuildExperience.Flags.FFlagBuildExperienceNewGameChatDraft)
local FFlagBuildExperienceRestoreStoppedPrompt = require(BuildExperience.Flags.FFlagBuildExperienceRestoreStoppedPrompt)

local chatConstants = require(script.Parent.chatConstants)
local chatTypes = require(script.Parent.chatTypes)
local creatorAgentChat = require(script.Parent.creatorAgentChat)
local getNewGameChatDraftKey = require(script.Parent.getNewGameChatDraftKey)
local parseSessionStream = require(script.Parent.parseSessionStream)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local getActiveAnswerForm = if FFlagBuildExperienceAnswerForm then require(script.Parent.getActiveAnswerForm) else nil
local sessionPromptMessageFilter = require(script.Parent.sessionPromptMessageFilter)
local useAgentRollbackRequest = require(script.Parent.useAgentRollbackRequest)
local useChatScroll = require(script.Parent.useChatScroll)
local buildAgentRollbackPrompt = require(BuildExperience.utils.buildAgentRollbackPrompt)
local beginBuildModelSend = require(script.Parent.beginBuildModelSend)
local useBuildModelSession = require(script.Parent.useBuildModelSession)
local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local GetBuildCreatorCreditRefreshStore = require(BuildExperience.Stores.GetBuildCreatorCreditRefreshStore)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore
local CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local GetBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore)
local GetAgentRollbackRequestStore = require(BuildExperience.Stores.GetAgentRollbackRequestStore)
local GetPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)
local _createPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.createPlaytestLoadingStore)
local getDefaultTemplatePlaceId = require(BuildExperience.utils.getDefaultTemplatePlaceId)
local launchPlaytestWithLoadingState = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.launchPlaytestWithLoadingState)
local var1 = CreatorAgentChat.experimentOverride.isEnabled()
local useBuildInternalTesting = if FFlagBuildExperienceModelPicker and var1 then require(script.Parent.useBuildInternalTesting) else nil
local BuildAppStorage = if engineFeature then require(BuildExperience.Storage.BuildAppStorage) else nil
local uploadCaptureAsync = require(BuildExperience.utils.uploadCaptureAsync)

local debug2 = CreatorAgentChat.debug
local RequestFailureKind = CreatorAgentChat.RequestFailureKind
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local signal = Signals.createSignal(false)
local function noopSetAgentSpecVersion(_: string?) end

local messageId = MessageBusService:GetMessageId("Game", "onGameLeave")
local signal2 = Signals.createSignal(
    {
        submittedToolCallIds = {},
        askUserByToolCallId = {},
        planByToolCallId = {},
        devProductByToolCallId = {}
    }
)
local signal3 = Signals.createSignal({
    onAnswerSelectedByToolCallId = {},
    onAnswerConfirmedByToolCallId = {},
    onPlanAcceptedByToolCallId = {},
    onDevProductApprovedByToolCallId = {},
    onDevProductRejectedByToolCallId = {}
})
local signal4 = Signals.createSignal(nil)
local signal5 = Signals.createSignal({ session = nil, sessionId = nil, events = {} })

local function sessionOwnerMatches(tbl1, session, sessionId: string?): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    if tbl1 == nil or tbl1.session ~= session then
        return false
    end
    if sessionId == nil or sessionId == "" then
        return true
    end
    return tbl1.sessionId == sessionId or tbl1.sessionId == nil and tbl1.session.getCasSessionId() == sessionId
end

local function isEvolvingAdUpsellScope(tbl1, universeId: number?, sessionId: string?): boolean -- Luacid: unused: defined but never referenced
    local bool1 = tbl1.universeId == nil or universeId == nil or tbl1.universeId == universeId
    local bool2 = tbl1.sessionId == nil or sessionId == nil or tbl1.sessionId == sessionId
    return bool1 and bool2
end

local function getCompletedTurnSequenceId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.kind == "assistant_turn" and arg1.isDone and arg1.isOptimisticallyCancelled ~= true and arg1.turnState ~= nil then
        return arg1.endSequenceId or arg1.startSequenceId
    end

    return nil
end

local function getTurnId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local turnFeedbackIds = arg1.turnFeedbackIds
    return if turnFeedbackIds == nil or typeof(turnFeedbackIds) == "function" then nil else turnFeedbackIds.turnId
end

local function noteLiveAdUpsellTurns(tbl1, messages)
    for _, value in messages do
        if value.kind ~= "assistant_turn" or value.startSequenceId == nil then
            continue
        end

        local turnId = getTurnId(value)
        local bool1 = not (turnId == nil) and tbl1.liveTurnIds[turnId] == true
        local historyWatermarkSequenceId = tbl1.historyWatermarkSequenceId
        local bool2 = not value.isDone

        if bool2 then
            if historyWatermarkSequenceId == nil then
                bool2 = false
            else
                bool2 = historyWatermarkSequenceId < value.startSequenceId
            end
        end

        if bool1 or bool2 then
            tbl1.liveTurnStartSequenceIds[value.startSequenceId] = true
        end
    end
end

local function hasPendingLocalToolResponse(arg1)
    for value in arg1.askUserByToolCallId do
        if not arg1.submittedToolCallIds[value] then
            return true
        end
    end
    for value in arg1.planByToolCallId do
        if not arg1.submittedToolCallIds[value] then
            return true
        end
    end
    if FFlagBuildExperienceManageDevProduct then
        for value in arg1.devProductByToolCallId do
            if not arg1.submittedToolCallIds[value] then
                return true
            end
        end
    end
    return false
end

local function trimMessage(current: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return string.gsub(current, "^%s*(.-)%s*$", "%1")
end

local function scheduleComposerAutoFocus(tbl1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 8
    local function tryFocus()
        if func1() then
            return
        end
        local current = tbl1.current
        if current then
            current.focus()
            return
        end
        num1 -= 1
        if num1 > 0 then
            task.delay(0, tryFocus)
        end
    end
    task.defer(tryFocus)
end

local function getResumeSessionKey(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local casSessionId = arg1.getCasSessionId()
    if typeof(casSessionId) == "string" and casSessionId ~= "" then
        return casSessionId
    end
    local universeId = arg1.universeId
    local placeId = arg1.placeId
    if universeId ~= nil and placeId ~= nil then
        return `{universeId}:{placeId}`
    end
    return nil
end

local function getLiveAssistantMessage(arg1, createUniverseOnFirstPrompt: boolean?, arg2, tbl1, setupErrorText: string?): {setupErrorText: string?}? -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == nil and not (createUniverseOnFirstPrompt == true and arg2 == nil and tbl1 ~= nil) then nil else {
        setupErrorText = setupErrorText
    }
end

local function useChatSessionCore(tbl1)
    if FFlagBuildExperienceModelPicker then
        React.useEffect(function()
            return GetBuildCreatorCreditRefreshStore(false).acquire()
        end, {})
    end
    local var2 = React.useContext(LocalizationRoactContext)
    local var3 = var2:Format(LocalizationStrings.CHAT_CREATE_UNIVERSE_ERROR)
    local var4 = var2:Format(LocalizationStrings.CHAT_CAPTURE_UPLOAD_ERROR)
    local accountId = if FFlagBuildExperienceModelPicker then SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId) else nil

    local var6, var7 = React.useState(nil)
    local var8, var9 = React.useState(nil)
    if FFlagBuildExperienceModelPicker and var6 ~= nil and var6.accountId ~= accountId then
        var6 = nil
    end

    if FFlagBuildExperienceModelPicker and var8 ~= nil and var8.accountId ~= accountId then
        var8 = nil
    end

    local var10 = React.useRef(true)
    local var11 = React.useCallback(function()
        return var10.current
    end, { var10 })
    local placeId = tbl1.placeId
    local universeId = tbl1.universeId
    local sessionId = tbl1.sessionId
    if var6 ~= nil then
        placeId = var6.placeId
        universeId = var6.universeId
        sessionId = var6.sessionId
    end
    if (sessionId == nil or sessionId == "") and var8 ~= nil and var8.universeId == universeId and var8.placeId == placeId then
        sessionId = var8.sessionId
    end
    local var12 = tbl1.hydrateHistoryWhen == nil or tbl1.hydrateHistoryWhen
    local var13 = tbl1.sendMessageWhen == nil or tbl1.sendMessageWhen
    local var14 = FFlagBuildExperienceLibrary and tbl1.isLibraryChat == true
    local current = if FFlagBuildAdUpsell then React.useRef(tbl1.trackAdUpsellTurns == true).current else false
    local creatorAgentChatStore = CreatorAgentChat.getCreatorAgentChatStore()
    local agentRollbackRequestStore = GetAgentRollbackRequestStore()

    local var15 = React.useMemo(function()
        if universeId == nil then
            return nil
        end
        return creatorAgentChatStore.getSessionForProject(universeId, placeId, sessionId)
    end, {
        universeId,
        placeId,
        sessionId,
        creatorAgentChatStore,
        accountId
    })
    React.useLayoutEffect(function()
        if var15 == nil or sessionId == nil or sessionId == "" then
            return
        end
        var15.setCasSessionId(sessionId)
    end, { var15, sessionId })

    local var16 = nil
    local var17 = nil
    local bool1 = false
    local var18 = nil
    if FFlagBuildExperienceModelPicker then
        local var19 = React.useRef(true)
        var17 = var19

        React.useLayoutEffect(function()
            var19.current = true
            return function()
                var19.current = false
            end
        end, { var19 })

        var16 = React.useMemo(function()
            return { pending = false, mounted = true }
        end, {
            accountId,
            tbl1.modelSelectionDraftId,
            tbl1.universeId,
            tbl1.placeId,
            tbl1.sessionId
        })

        local var20
        bool1, var20 = React.useState(false)
        var18 = var20
        local var21 = var16
        local var22 = var18

        React.useLayoutEffect(function()
            var21.mounted = true
            var22(false)
            return function()
                var21.mounted = false
            end
        end, { var21, var22 })
    end

    local var19 = if FFlagBuildExperienceModelPicker then useBuildModelSession(universeId, tbl1.modelSelectionDraftId, var15) else nil

    local var20 = React.useMemo(function()
        if var15 == nil then
            return signal5
        end
        return (Signals.createComputed(function(arg1)
            return {
                session = var15,
                sessionId = var15.getCasSessionId(),
                events = var15.getMergedHistory(arg1)
            }
        end))
    end, { var15 })
    local var21 = SignalsReact.useSignalState(var20)
    local casSessionId = if var15 == nil then nil else var15.getCasSessionId()
    local var22 = nil
    local func1 = noopSetAgentSpecVersion
    local var23 = nil
    local var24 = nil
    local var25 = nil
    if FFlagBuildExperienceModelPicker and var1 then
        local var26 = useBuildInternalTesting
        local entry = if var19 == nil then nil else var19.entry
        var25, var23 = var26(entry, var15, tbl1.sessionId)
        if var25 == nil then
            var22 = nil
        else
            var22 = var25.previewHash
        end

        func1 = function(str1: string?)
            if var25 ~= nil then
                var25.onSelect()
                var25.onSaveSpec(str1, var25.previewSpecName)
            end
        end
    elseif var1 then
        local var26 = React.useRef(nil)
        if var26.current == nil then
            var26.current = CreatorAgentChat.experimentOverride.createPendingKey()
        end
        local current2 = var26.current
        var23 = current2

        local var27 = React.useRef(false)
        var24 = var27
        local var28 = CreatorAgentChat.experimentOverride.getKey(casSessionId) or current2

        local var29 = React.useMemo(function()
            return CreatorAgentChat.experimentOverride.getStateSignal(var28)
        end, { var28 })

        var22 = SignalsReact.useSignalState(var29).specVersion

        func1 = React.useCallback(function(str1: string?)
            local casSessionId2 = if var15 == nil then nil else var15.getCasSessionId()
            local key = CreatorAgentChat.experimentOverride.getKey(casSessionId2)
            if key == nil then
                key = current2
                var27.current = true
                if var15 ~= nil then
                    var15.setPendingExperimentKey(current2)
                end
            end
            CreatorAgentChat.experimentOverride.set(key, str1)
        end, { var15, current2 })

        React.useEffect(function()
            if var15 == nil or not var27.current then
                return
            end
            var15.setPendingExperimentKey(current2)
        end, { var15, current2 })

        React.useEffect(function()
            return function()
                CreatorAgentChat.experimentOverride.clear(current2)
            end
        end, { current2 })
    end

    local var26 = var21.session ~= var15 and {} or var21.sessionId ~= casSessionId and {} or var21.events
    local bool2 = not (sessionId == nil) and sessionId ~= ""

    if not bool2 then
        if universeId == nil then
            bool2 = false
        else
            bool2 = universeId ~= 0
        end
    end

    local var27 = var12 and not (var15 == nil) and bool2 and not (var15.hasLoadedHistory() and #var26 > 0)

    local var28, var29 = React.useState(function()
        return {
            session = var15,
            sessionId = sessionId,
            universeId = universeId,
            hydrateHistoryWhen = var12,
            isLoading = var27
        }
    end)

    local var30 = var29
    local isHistoryHydrationComplete = if not (var28 == nil or var28.session ~= var15 or var28.sessionId ~= sessionId or var28.universeId ~= universeId)
        and var28.hydrateHistoryWhen == var12 then not var28.isLoading else not var27
    local bool4 = not isHistoryHydrationComplete

    if not bool4 then
        if var15 == nil then
            bool4 = false
        else
            bool4 = var15.getNextHistoryPageToken() ~= nil
        end
    end

    local var31, var32 = React.useState(nil)

    local var33, var34 = React.useState(nil)

    React.useEffect(function()
        var34(nil)
    end, { var15, sessionId })

    if not sessionOwnerMatches(var33, var15, sessionId) then
        var33 = nil
    end

    local var35, var36 = React.useState(nil)
    local activeTurnHandleRef = React.useRef(nil)
    local var38 = React.useRef(nil)
    local var39 = React.useRef(0)
    local var40 = nil
    local bool5 = false
    local var41 = nil
    if FFlagBuildExperienceModelPicker then
        var40 = React.useRef(nil)
        local var42
        bool5, var42 = React.useState(false)
        var41 = var42
        local var43 = var40
        local var44 = var41

        React.useLayoutEffect(function()
            if var1
                and var43.current ~= nil
                and not var43.current.started
                and var38.current ~= nil
                and tbl1.sessionId ~= nil
                and tbl1.sessionId ~= ""
                and var38.current.sessionId ~= tbl1.sessionId
            then
                var43.current.attempt.release()
                var43.current = nil
            end
            if var43.current == nil then
                var44(false)
                var32(nil)
            end
            return function()
                local current2 = var43.current
                if current2 == nil or current2.started and current2.attempt.isCurrent() then
                    return
                end

                current2.attempt.release()
                var43.current = nil
                if current2.onTerminal ~= nil then
                    current2.onTerminal()
                end
            end
        end, {
            if var19 == nil then nil else var19.entry,
            tbl1.sessionId,
            var44,
            var32
        })
    end

    local var42 = React.useRef(nil)

    local var43 = React.useCallback(function(current2, session)
        assert(current2 == nil or session ~= nil, "Active turns require an owning session")
        activeTurnHandleRef.current = current2
        var38.current = current2 ~= nil and {
            session = session,
            sessionId = session.getCasSessionId()
        } or nil

        var36(current2)
    end, { var36 })

    local var44 = if sessionOwnerMatches(var38.current, var15, sessionId) then var35 else nil
    local var45 = if var44 ~= nil then var44.getOptimisticLocalTools else signal2
    local var46 = if var44 ~= nil then var44.getLocalToolActions else signal3
    local var47 = if var44 ~= nil then var44.getSetupErrorText else signal4
    local optimisticLocalTools = SignalsReact.useSignalState(var45)
    local var49 = SignalsReact.useSignalState(var46)
    local var50 = SignalsReact.useSignalState(var47)
    local setupErrorText = if var50 ~= nil then var2:Format(var50) else var50

    local liveAssistantMessage = React.useMemo(function()
        return getLiveAssistantMessage(var44, tbl1.createUniverseOnFirstPrompt, var15, var31, setupErrorText)
    end, {
        var44,
        tbl1.createUniverseOnFirstPrompt,
        var31,
        var15,
        setupErrorText
    })

    local var52 = React.useMemo(function()
        return parseSessionStream(var26, {
            sessionId = if var15 ~= nil then var15.getCasSessionId() or sessionId else sessionId,
            universeId = if var15 ~= nil then var15.universeId else universeId,
            placeId = if var15 ~= nil then var15.placeId else placeId,
            optimisticLocalTools = optimisticLocalTools,
            pendingUserMessage = if var31 == nil or not sessionPromptMessageFilter.shouldOptimisticallyDisplay(var31.text) then nil else var31.text,
            pendingUserImages = if var31 == nil or not sessionPromptMessageFilter.shouldOptimisticallyDisplay(var31.text) then nil else var31.images,
            pendingUserResourceAttachments = if var31 == nil or not sessionPromptMessageFilter.shouldOptimisticallyDisplay(var31.text) then nil else var31.resourceAttachments,
            pendingUserMessageAfterSequenceId = if var31 == nil then nil else var31.afterSequenceId,
            liveAssistantMessage = liveAssistantMessage,
            optimisticCancelledStartSequenceId = if var33 == nil then nil else var33.startSequenceId
        })
    end, {
        var26,
        var15,
        sessionId,
        universeId,
        placeId,
        optimisticLocalTools,
        var31,
        liveAssistantMessage,
        var33
    })

    local var53 = if current then React.useRef({
        isInitialized = false,
        universeId = universeId,
        sessionId = if var15 ~= nil then var15.getCasSessionId() or sessionId else sessionId,
        historyWatermarkSequenceId = var52.latestSequenceId,
        lastProcessedSequenceId = nil,
        liveTurnIds = {},
        liveTurnStartSequenceIds = {}
    }) else nil

    local var54 = if var53 ~= nil then React.useCallback(function(num1: number?)
        if num1 ~= nil then
            var53.current.liveTurnIds[num1] = true
        end
    end, { var53 }) else nil

    local messages = var52.messages
    local bool6 = not (var15 == nil) and var15.getNextHistoryPageToken() ~= nil
    local var55 = var15 == nil or not bool2 or var15.hasLoadedHistory()
    local var56 = isHistoryHydrationComplete and var55 and (var15 == nil or #messages > 0 or not bool6)
    local isHistoryExhausted = var56 and not bool6
    local subagentTaskState = var52.subagentTaskState
    local includesPublishTool = var52.includesPublishTool
    local var58 = messages[#messages]
    local var59 = React.useMemo(function()
        if placeId ~= nil then
            return agentRollbackRequestStore.getIsPendingForPlaceId(placeId)
        end
        return signal
    end, { placeId, agentRollbackRequestStore })

    local var60 = SignalsReact.useSignalState(var59)
    local isAssistantResponding = var44 ~= nil or (if var58 == nil or var58.kind ~= "assistant_turn" then var60 else not var58.isDone or var60)
    local canSendWhileResponding = isAssistantResponding and not var60 and hasPendingLocalToolResponse(optimisticLocalTools)

    local activeTurnState = var52.activeTurnState
    React.useEffect(function()
        if var44 == nil or activeTurnState == nil then
            return
        end
        var44.syncFromTurnState(activeTurnState)
    end, { var44, activeTurnState })

    if current then
        React.useEffect(function()
            local onAssistantTurnCompleted = tbl1.onAssistantTurnCompleted

            local var63 = var53
            local var5 = if var15 ~= nil then var15.universeId or universeId else universeId
            local var37 = if var15 ~= nil then var15.getCasSessionId() or sessionId else sessionId
            local current2 = var63.current
            local bool7 = current2.universeId == nil or var5 == nil or current2.universeId == var5
            local bool8 = current2.sessionId == nil or var37 == nil or current2.sessionId == var37
            if not (bool7 and bool8) then
                current2 = {
                    isInitialized = false,
                    universeId = var5,
                    sessionId = var37,
                    historyWatermarkSequenceId = var52.latestSequenceId,
                    lastProcessedSequenceId = nil,
                    liveTurnIds = {},
                    liveTurnStartSequenceIds = {}
                }
                var63.current = current2
            else
                current2.universeId = var5 or current2.universeId
                current2.sessionId = var37 or current2.sessionId
            end

            if not var56 then
                current2.historyWatermarkSequenceId = current2.historyWatermarkSequenceId or var52.latestSequenceId
                noteLiveAdUpsellTurns(current2, messages)
                return
            end

            if not current2.isInitialized then
                current2.isInitialized = true
                noteLiveAdUpsellTurns(current2, messages)
                local var66 = nil
                for k in current2.liveTurnStartSequenceIds do
                    if var66 == nil or k < var66 then
                        var66 = k
                    end
                end

                if var66 ~= nil then
                    current2.lastProcessedSequenceId = var66 - 1
                else
                    current2.lastProcessedSequenceId = current2.historyWatermarkSequenceId or var52.latestSequenceId
                end
                current2.liveTurnIds = {}
                current2.liveTurnStartSequenceIds = {}
            end

            if var5 == nil or var5 == 0 then
                return
            end
            local lastProcessedSequenceId = current2.lastProcessedSequenceId or -1
            for _, value in messages do
                local completedTurnSequenceId = getCompletedTurnSequenceId(value)

                if completedTurnSequenceId == nil or completedTurnSequenceId <= lastProcessedSequenceId then
                    continue
                end

                if onAssistantTurnCompleted ~= nil then
                    onAssistantTurnCompleted({
                        universeId = var5,
                        sessionId = value.sessionId or var37,
                        turnState = value.turnState,
                        latestSequenceId = completedTurnSequenceId
                    })
                end
                current2.lastProcessedSequenceId = completedTurnSequenceId
                lastProcessedSequenceId = completedTurnSequenceId
            end
        end, {
            tbl1.onAssistantTurnCompleted,
            var15,
            universeId,
            sessionId,
            var56,
            messages,
            var52.latestSequenceId
        })
    end

    local composerText, var64 = React.useBinding("")
    local composerErrorText, var66 = React.useState(nil)

    local var67, var68 = React.useState(false)
    local var69 = React.useCallback(function(str1: string?)
        var66(str1)
        var68(false)
    end, {})
    local var70 = React.useCallback(function(str1: string)
        var66(str1)
        var68(true)
    end, {})
    local var71 = React.useRef("")
    local var72 = React.useRef("")
    local var73 = if FFlagBuildExperiencePrefillSkipsDraftPersist and engineFeature then React.useRef(nil) else nil
    local var74 = React.useRef(nil)
    local var75 = React.useRef(casSessionId)
    local var76 = React.useRef(nil)
    var75.current = casSessionId
    local bool7 = tbl1.createUniverseOnFirstPrompt == true and universeId == nil
    local bool3 = tbl1.createUniverseOnFirstPrompt == true
    local tbl2 = { current = bool3 }
    if FFlagBuildExperienceNewGameChatDraft then
        tbl2 = React.useRef(bool3)
    end

    tbl2.current = bool3

    local var77 = if FFlagBuildExperienceRestoreStoppedPrompt then React.useRef(nil) else nil

    local var78 = React.useRef({})
    local var79 = React.useRef(0)
    local composerImages, var81 = React.useState({})
    local var82 = React.useRef({})

    local composerResourceAttachments, var84 = React.useState({})

    local var85 = React.useRef({})
    local var86 = React.useRef({ universeId = tbl1.universeId, placeId = tbl1.placeId })

    local textBoxRef = React.useRef(nil)
    local clockBinding = ReactUtils.useClock()

    local var89 = useChatScroll(var14)

    local var90 = React.useCallback(function(num1: number, arg1)
        GetPlaytestLoadingStore().setAgentStatusForPlaceId(num1, arg1)
    end, {})

    local var91 = React.useCallback(function(func2: ((...any) -> (...any))?)
        local function func3()
            if func2 ~= nil then
                return func2()
            end
            return false
        end
        var89.captureDistanceFromBottom()
        if var15 == nil then
            return
        end
        var15.requestOlderHistoryWhile(func3, function()
            return var89.isNearTopRef.current
        end)
    end, { var15, var89 })

    local var92 = React.useCallback(function(func2: (...any) -> (...any))
        task.delay(0.1, function()
            if not func2() and var15 ~= nil and var15.getNextHistoryPageToken() ~= nil and var89.isNearTopRef.current then
                var91(func2)
            end
        end)
    end, { var91, var89, var15 })

    local var5 = React.useCallback(function(func2: (...any) -> (...any))
        if var15 ~= nil and var15.getNextHistoryPageToken() ~= nil then
            var92(func2)
        end
    end, { var92, var15 })
    local var94 = React.useRef(var5)
    var94.current = var5

    React.useEffect(function()
        var89.setOnScrolledToTop(function()
            var91(nil)
        end)
        return function()
            var89.setOnScrolledToTop(nil)
        end
    end, { var89.setOnScrolledToTop, var91 })

    React.useEffect(function()
        if not var12 or var15 == nil then
            if var30 ~= nil then
                var30(
                    {
                        session = var15,
                        sessionId = sessionId,
                        universeId = universeId,
                        hydrateHistoryWhen = var12,
                        isLoading = false
                    }
                )
            end

            return
        end

        local bool9 = false
        local function setHistoryLoading(isLoading: boolean) -- Luacid: Inlined by compiler; 7 call sites recovered
            if var30 == nil or bool9 then
                return
            end
            var30(
                {
                    session = var15,
                    sessionId = sessionId,
                    universeId = universeId,
                    hydrateHistoryWhen = var12,
                    isLoading = isLoading
                }
            )
        end

        setHistoryLoading(not (var15.hasLoadedHistory() and #var15.getMergedHistory(false) > 0))

        local var95 = sessionId
        local function isHydrateCancelled(): boolean -- Luacid: Inlined by compiler; 7 call sites recovered
            return if bool9 then true else not (var95 == nil or var95 == "") and var15.getCasSessionId() ~= var95
        end
        local function continueAfterSessionReady() -- Luacid: Inlined by compiler; 2 call sites recovered
            if isHydrateCancelled() then
                return
            end
            var94.current(isHydrateCancelled)
        end

        local function hydrateKnownSession(str1: string)
            var15.setCasSessionId(str1)

            if var14 and activeTurnHandleRef.current ~= nil then
                setHistoryLoading(false)
            elseif not var14
                and var15.hasLoadedHistory()
                and #var15.getMergedHistory(false) > 0
                and (not FFlagBuildExperienceModelPicker or var15.hasObservedModels(false))
            then
                continueAfterSessionReady()
                setHistoryLoading(false)
            else
                if var15.refreshSession(isHydrateCancelled, true) and not isHydrateCancelled() then
                    continueAfterSessionReady()
                end

                setHistoryLoading(false)
            end
        end

        task.spawn(function()
            local var96 = sessionId
            if var14 and (var96 == nil or var96 == "") then
                var96 = var15.getCasSessionId()
            end
            if var96 ~= nil and var96 ~= "" then
                hydrateKnownSession(var96)
                return
            end
            if FFlagBuildExperienceModelPicker then
                local casSessionId2 = var15.getCasSessionId()
                if casSessionId2 ~= nil
                    and var15.hasLoadedHistory()
                    and #var15.getMergedHistory(false) > 0
                    and not var15.hasObservedModels(false)
                then
                    hydrateKnownSession(casSessionId2)
                    return
                end
            end

            if universeId == nil or universeId == 0 or var15.hasLoadedHistory() and #var15.getMergedHistory(false) > 0 then
                setHistoryLoading(false)
                return
            end

            local var97 = creatorAgentChatStore.sessionFindByUniverse(
                {
                    universeId = universeId,
                    sort = "desc",
                    application = "build",
                    filterByPinForBuild = true
                }
            )

            while var97.state(false).status == "pending" and not isHydrateCancelled() do
                task.wait()
            end
            if var14 then
                if isHydrateCancelled() then
                    return
                end
                local casSessionId2 = var15.getCasSessionId()
                if casSessionId2 ~= nil and casSessionId2 ~= "" then
                    hydrateKnownSession(casSessionId2)
                    return
                end
            end

            if isHydrateCancelled() or var97.state(false).status ~= "succeeded" then
                setHistoryLoading(false)
                return
            end

            local result = var97.state(false).result
            local sessions = if result == nil then nil else result.sessions
            local session = if typeof(sessions) == "table" then sessions[1] else nil
            local sessionId2 = if typeof(session) == "table" then session.sessionId else nil

            if typeof(sessionId2) ~= "string" or sessionId2 == "" then
                var15.markHistoryLoaded()
                setHistoryLoading(false)
                return
            end

            var9({
                universeId = universeId,
                placeId = placeId,
                sessionId = sessionId2,
                accountId = if FFlagBuildExperienceModelPicker then accountId else nil
            })
        end)

        return function()
            bool9 = true
        end
    end, {
        var15,
        sessionId,
        universeId,
        placeId,
        creatorAgentChatStore,
        var12,
        var14,
        accountId
    })

    React.useEffect(function()
        if var15 == nil then
            return
        end

        local bool9 = false
        local function refreshKnownSession()
            local casSessionId2 = var15.getCasSessionId()
            if (casSessionId2 == nil or casSessionId2 == "") and sessionId ~= nil and sessionId ~= "" then
                casSessionId2 = sessionId
            end
            if casSessionId2 == nil or casSessionId2 == "" then
                return
            end
            task.spawn(function()
                if var15.refreshSession(function() -- name: isRefreshCancelled
                    return bool9
                end, true) and not bool9 then
                    var94.current(function()
                        return bool9
                    end)
                end
            end)
        end

        local var95 = MessageBusService:Subscribe(messageId, function(_)
            var10.current = true
            if engineFeature then
                local casSessionId2 = var15.getCasSessionId()
                if (casSessionId2 == nil or casSessionId2 == "") and sessionId ~= nil and sessionId ~= "" then
                    casSessionId2 = sessionId
                end
                local bool10 = FFlagBuildExperiencePrefillSkipsDraftPersist

                if bool10 then
                    if var71.current == "" then
                        bool10 = false
                    else
                        bool10 = var71.current == var73.current
                    end
                end

                if casSessionId2 ~= nil and casSessionId2 ~= "" and not bool10 then
                    local chatDraft = BuildAppStorage.getChatDraft(casSessionId2) or ""
                    var72.current = chatDraft
                    var71.current = chatDraft
                    var64(chatDraft)
                    var69(nil)
                end
            end
            refreshKnownSession()
        end, false, true)
        local connection = AppLifecycleObserverService.OnUnhide:Connect(refreshKnownSession)

        return function()
            bool9 = true
            var95:Disconnect()
            connection:Disconnect()
        end
    end, { var15, sessionId, var10 })

    React.useEffect(function()
        if not var12 then
            return
        end
        var89.lockToBottom()
    end, {
        var12,
        var14,
        var15,
        sessionId,
        var89
    })
    local var95 = React.useCallback(function(current2: string)
        var71.current = current2
        var64(current2)
        var69(nil)
    end, { var64, var69 })

    local var96 = if engineFeature then React.useCallback(function()
        if var74.current ~= nil then
            task.cancel(var74.current)
            var74.current = nil
        end
    end, {}) else nil

    local var97 = if FFlagBuildExperienceNewGameChatDraft then React.useCallback(function()
        local current2 = var75.current
        if current2 ~= nil and current2 ~= "" then
            return current2
        elseif tbl2.current then
            return getNewGameChatDraftKey()
        end

        return nil
    end, {}) else nil

    local var98 = if engineFeature then React.useCallback(function(current2: string)
        var72.current = current2
        var96()
        local var98 = if FFlagBuildExperienceNewGameChatDraft then var97() else var75.current

        if var98 == nil or var98 == "" then
            return
        end

        var74.current = task.delay(0.5, function()
            var74.current = nil
            BuildAppStorage.setChatDraft(var98, current2)
        end)
    end, { var96, var97 }) else nil

    local var99 = if engineFeature then React.useCallback(function(current2: string)
        local var99 = if FFlagBuildExperienceNewGameChatDraft then var97() else var75.current

        if var99 == nil or var99 == "" then
            return
        end

        var72.current = current2
        var96()
        BuildAppStorage.setChatDraft(var99, current2)
    end, { var96, var97 }) else nil

    local var100 = if engineFeature then React.useCallback(function(current2: string, str1: string?)
        local newGameChatDraftKey = if FFlagBuildExperienceNewGameChatDraft and tbl2.current then getNewGameChatDraftKey() else nil

        if newGameChatDraftKey ~= nil then
            BuildAppStorage.setChatDraft(newGameChatDraftKey, "")
        end

        if str1 == nil or str1 == "" or var72.current ~= current2 then
            return
        end
        var72.current = ""
        var96()
        BuildAppStorage.setChatDraft(str1, "")
    end, { var96 }) else nil

    local setComposerText = React.useCallback(function(str1: string)
        var95(str1)
        if not engineFeature then
            return
        end

        if FFlagBuildExperiencePrefillSkipsDraftPersist then
            local current2 = var73.current
            if current2 ~= nil and str1 == current2 then
                return
            end
            var73.current = nil
        end
        var98(str1)
    end, { var95, var98 })

    local setPrefilledComposerText = if FFlagBuildExperiencePrefillSkipsDraftPersist and engineFeature then React.useCallback(function(current2: string)
        var73.current = current2
        var95(current2)
    end, { var95 }) else setComposerText

    if FFlagBuildExperienceNewGameChatDraft and engineFeature then
        React.useEffect(function()
            if not bool7 or casSessionId ~= nil and casSessionId ~= "" then
                return
            end

            local newGameChatDraftKey = getNewGameChatDraftKey()
            if newGameChatDraftKey == nil then
                return
            end

            local chatDraft = BuildAppStorage.getChatDraft(newGameChatDraftKey) or ""
            if chatDraft ~= "" and var71.current == "" then
                var72.current = chatDraft
                var95(chatDraft)
            end
        end, { bool7, casSessionId, var95 })
    end

    local useEffect = React.useEffect
    local function func2()
        if not engineFeature then
            return
        end
        if casSessionId == nil or casSessionId == "" then
            return
        end
        local current2 = var76.current
        var76.current = casSessionId
        var96()

        if FFlagBuildExperiencePrefillSkipsDraftPersist
            and current2 == nil
            and var71.current ~= ""
            and var71.current == var73.current
        then
            var72.current = BuildAppStorage.getChatDraft(casSessionId) or ""
        elseif current2 == nil and var71.current ~= "" then
            var72.current = var71.current
            BuildAppStorage.setChatDraft(casSessionId, var71.current)
        else
            local chatDraft = BuildAppStorage.getChatDraft(casSessionId) or ""
            var72.current = chatDraft
            var95(chatDraft)
        end

        return function()
            local bool9 = var74.current ~= nil
            var96()
            if bool9 then
                BuildAppStorage.setChatDraft(casSessionId, var72.current)
            end
        end
    end

    local var103 = if FFlagBuildExperienceModelPicker then var15 else nil
    useEffect(func2, { casSessionId, var96, var95, var103 })

    local function commitComposerResourceAttachments(current2) -- Luacid: Inlined by compiler; 3 call sites recovered
        var85.current = current2
        var84(current2)
        var69(nil)
    end

    local function findComposerResourceAttachmentIndexByUri(str1: string)
        for value, value2 in var85.current do
            if chatTypes.getResourceAttachmentUri(value2) == str1 then
                return value
            end
        end
        return nil
    end

    local function addComposerResourceAttachment(arg1)
        local var104 = table.clone(var85.current)
        table.insert(var104, arg1)
        commitComposerResourceAttachments(var104)
    end

    local function removeComposerResourceAttachmentAtIndex(num1: number)
        local var104 = table.clone(var85.current)
        table.remove(var104, num1)
        commitComposerResourceAttachments(var104)
    end

    local function clearComposerResourceAttachments()
        commitComposerResourceAttachments({})
    end
    local var104 = React.useRef(commitComposerResourceAttachments)
    var104.current = commitComposerResourceAttachments
    React.useLayoutEffect(function()
        local current2 = var86.current
        if current2.universeId ~= tbl1.universeId or current2.placeId ~= tbl1.placeId then
            var104.current({})
        end
        var86.current = {
            universeId = tbl1.universeId,
            placeId = tbl1.placeId
        }
    end, { tbl1.universeId, tbl1.placeId })

    local function commitComposerImages(current2) -- Luacid: Inlined by compiler; 2 call sites recovered
        var82.current = current2
        var81(current2)
    end

    local function hasFailedComposerImage(tbl3) -- Luacid: Inlined by compiler; 3 call sites recovered
        for _, value in tbl3 do
            if value.uploadStatus == "failed" then
                return true
            end
        end
        return false
    end

    local function updateComposerImage(capture, func3: (...any) -> (...any))
        local current2 = var82.current
        local var105 = table.clone(current2)
        for value, value2 in current2 do
            if value2.capture == capture then
                var105[value] = func3(value2)
                commitComposerImages(var105)
                return var105
            end
        end
        return current2
    end

    local function beginComposerImageUpload(capture)
        local var105 = var79
        var105.current += 1
        local current2 = var79.current
        var78.current[capture] = current2

        if not hasFailedComposerImage((updateComposerImage(capture, function(arg1)
            local var106 = table.clone(arg1)
            var106.uri = nil
            var106.uploadStatus = "uploading"
            var106.uploadError = nil
            return var106
        end))) then
            var69(nil)
        end

        uploadCaptureAsync(capture):andThen(function(arg1)
            if var78.current[capture] ~= current2 then
                return
            end
            var78.current[capture] = nil

            if not hasFailedComposerImage((updateComposerImage(capture, function(arg2)
                local var106 = table.clone(arg2)
                var106.uri = `rbxassetid://{arg1.assetId}`
                var106.uploadStatus = "uploaded"
                var106.uploadError = nil
                return var106
            end))) then
                var69(nil)
            end
        end):catch(function(uploadError)
            if var78.current[capture] ~= current2 then
                return
            end
            var78.current[capture] = nil
            updateComposerImage(capture, function(arg1)
                local var106 = table.clone(arg1)
                var106.uri = nil
                var106.uploadStatus = "failed"
                var106.uploadError = uploadError
                return var106
            end)
            var69(var4)
        end)
    end

    local function setComposerImages(tbl3)
        local current2 = var82.current
        local tbl4 = {}
        local tbl5 = {}

        local num1 = #tbl3

        for i = 1, math.min(num1, 2) do
            local var105 = tbl3[i]
            local var106

            if var105.capture == nil or var105.uri ~= nil or var105.uploadStatus ~= nil then
                var106 = var105
            else
                var106 = var105

                for _, value in current2 do
                    if value.capture == var105.capture then
                        var106 = value
                        break
                    end
                end
            end

            if var106.uri ~= nil and var106.uploadStatus == nil then
                var106 = table.clone(var106)
                var106.uploadStatus = "uploaded"
            elseif var106.capture ~= nil and var106.uri == nil and var106.uploadStatus == nil then
                var106 = table.clone(var106)
                var106.uploadStatus = "uploading"
                table.insert(tbl5, var106.capture)
            end
            table.insert(tbl4, var106)
        end

        for _, value in current2 do
            local bool9 = false
            for _, value2 in tbl4 do
                if value2.capture == value.capture then
                    bool9 = true
                    break
                end
            end

            if not bool9 and value.capture ~= nil then
                var78.current[value.capture] = nil
            end
        end

        commitComposerImages(tbl4)

        if not hasFailedComposerImage(tbl4) then
            var69(nil)
        end
        for _, value in tbl5 do
            beginComposerImageUpload(value)
        end
    end
    local var105 = React.useRef(setComposerImages)
    var105.current = setComposerImages

    local function retryComposerImage(num1: number)
        local var106 = var82.current[num1]
        if var106 == nil or var106.capture == nil or var106.uploadStatus ~= "failed" then
            return
        end
        beginComposerImageUpload(var106.capture)
    end

    local bool9 = false
    for _, value in composerImages do
        if value.uri == nil or value.uploadStatus == "uploading" or value.uploadStatus == "failed" then
            bool9 = true
            break
        end
    end

    local var106 = React.useCallback(function(current2: number): (string?, number?) -> ()
        return function(str1: string?, num1: number?)
            if var39.current ~= current2 or not sessionOwnerMatches(var38.current, var15, sessionId) then
                return
            end
            local bool10 = false
            if FFlagBuildExperienceAnswerForm then
                local current3 = activeTurnHandleRef.current
                if current3 ~= nil then
                    local getLocalToolActions = current3.getLocalToolActions
                    bool10 = next(getLocalToolActions(false).onAnswerSelectedByToolCallId) ~= nil
                end
            end
            if str1 ~= nil and var71.current == "" and not bool10 then
                setComposerText(str1)
            end
            local toolResultFailureComposerError = creatorAgentChat.getToolResultFailureComposerError(num1)
            local var106 = var2:Format(toolResultFailureComposerError)
            var69(var106)
        end
    end, {
        var15,
        sessionId,
        setComposerText,
        var69,
        var2
    })

    local var107 = nil
    local onPromptFailure = tbl1.onPromptFailure
    if FFlagBuildExperienceModelPicker then
        local var108
        var107, var108 = React.useState(nil)
        if var107 == nil or var107.owner ~= var15 then
            var107 = nil
        end

        onPromptFailure = React.useCallback(function(outOfCredits: number?, reason)
            if outOfCredits == CreatorAgentChat.ErrorCodes.OutOfCredits then
                var108(function(tbl3)
                    return {
                        count = if tbl3 then tbl3.count + 1 else 1,
                        reason = reason,
                        owner = var15
                    }
                end)
            end

            if tbl1.onPromptFailure ~= nil then
                tbl1.onPromptFailure(outOfCredits, reason)
            end
        end, { var15, tbl1.onPromptFailure })
    end

    local var108 = React.useCallback(function(current2: number, arg1, str1: string?, tbl3, tbl4, arg2)
        if var39.current ~= current2 then
            return
        end

        if FFlagBuildExperienceModelPicker and var17 ~= nil and not var17.current then
            GetBuildCreatorCreditRefreshStore(false).settled()
            return
        end

        var43(nil)
        var42.current = nil
        var32(nil)
        if FFlagBuildExperienceModelPicker then
            GetBuildCreatorCreditRefreshStore(false).settled()
        end

        if arg1 ~= nil then
            if onPromptFailure ~= nil then
                onPromptFailure(arg1.errorCode, arg1.outOfCreditsReason)
            end
            if arg2.placeId ~= nil then
                var90(arg2.placeId, "Idle")
            end
            if tbl3 ~= nil then
                var105.current(tbl3)
            end
            if tbl4 ~= nil then
                var104.current(tbl4)
            end
            if str1 ~= nil then
                setComposerText(str1)
                local promptFailureComposerError = creatorAgentChat.getPromptFailureComposerError(arg1)
                local var108 = var2:Format(promptFailureComposerError)
                var69(var108)
            end
            task.spawn(function()
                arg2.refreshSession(function(): boolean
                    return var39.current ~= current2
                end)
            end)
            return
        end

        if arg2.placeId ~= nil then
            var90(arg2.placeId, "Completed")
        end
        var89.scrollToBottomAfterSend()

        local casSessionId2 = arg2.getCasSessionId()
        if casSessionId2 == nil or casSessionId2 == "" then
            return
        end

        if tbl1.createUniverseOnFirstPrompt and sessionId == nil and arg2.universeId ~= nil then
            local tbl5 = {
                universeId = arg2.universeId,
                placeId = arg2.placeId,
                sessionId = casSessionId2
            }
            if FFlagBuildExperienceModelPicker then
                local var108 = table.clone(tbl5)
                var108.accountId = accountId
                var7(var108)
            else
                var7(tbl5)
            end
            if tbl1.onProjectResolved ~= nil then
                tbl1.onProjectResolved(tbl5)
            end
        end

        task.spawn(function()
            arg2.refreshSession(function(): boolean
                return var39.current ~= current2
            end)
        end)
    end, {
        var17,
        tbl1.createUniverseOnFirstPrompt,
        onPromptFailure,
        tbl1.onProjectResolved,
        sessionId,
        var90,
        var7,
        accountId,
        var89,
        setComposerText,
        var69,
        var43,
        var32,
        var2
    })

    local var109 = React.useRef(var12)
    React.useEffect(function()
        local var110 = var12 and not var109.current
        var109.current = var12

        if not var14 and var12 and (var110 or isAssistantResponding or var44 ~= nil) then
            var89.scrollToBottomUnconditionally()
            task.defer(var89.scrollToBottomUnconditionally)
            task.delay(0.15, var89.scrollToBottomUnconditionally)
        end
    end, {
        var12,
        var14,
        isAssistantResponding,
        var44,
        #messages,
        var89
    })

    React.useEffect(function()
        if activeTurnHandleRef.current ~= nil and sessionOwnerMatches(var38.current, var15, sessionId)
            or var33 ~= nil
            or var15 == nil
        then
            return
        end

        local resumeSessionKey = getResumeSessionKey(var15)
        if resumeSessionKey == nil then
            return
        end

        local function attachResumedTurn(arg1, current2: number?)
            local var110 = var39
            var110.current += 1
            local current3 = var39.current
            var42.current = current2
            if placeId ~= nil then
                var90(placeId, "Loading")
            end
            local resumedAssistantTurn = creatorAgentChat.createResumedAssistantTurn(var15, arg1, function(arg2)
                var108(current3, arg2, nil, nil, nil, var15)
            end, if current2 == nil then nil else current2 - 1, var106(current3), var11)

            var43(resumedAssistantTurn, var15)
            resumedAssistantTurn.start()
            var89.scrollToBottomUnconditionally()
        end

        if var52.activeTurnState ~= nil and var52.activeTurnItemIndex ~= nil and not var52.activeTurnState.isDone then
            local activeTurnStartSequenceId = var52.activeTurnStartSequenceId
            if var42.current == activeTurnStartSequenceId and var44 ~= nil then
                return
            end
            local var110 = creatorAgentChatStore.resumeTurnFromHistory(resumeSessionKey, var52.activeTurnState, var52.activeTurnSequenceIds)

            if var110 ~= nil then
                attachResumedTurn(var110, activeTurnStartSequenceId)
            end
            return
        end

        var42.current = nil

        local activeTurnHandle = creatorAgentChatStore.getActiveTurnHandle(resumeSessionKey)
        local var110 = if activeTurnHandle == nil then nil else activeTurnHandle.state(false)
        local bool10 = not (activeTurnHandle == nil or var110 == nil) and not var110.isDone

        if not (isAssistantResponding or bool10) then
            return
        end

        if bool10 then
            attachResumedTurn(activeTurnHandle, nil)
        end
    end, {
        var52,
        var15,
        sessionId,
        creatorAgentChatStore,
        isAssistantResponding,
        var44,
        placeId,
        var90,
        var108,
        var89,
        var43,
        var33,
        var106,
        var11
    })

    local var110 = React.useCallback(function(arg1, text: string, arg2, images, resourceAttachments, current2: number, afterSequenceId: number?, str1: string?, callback: ((...any) -> (...any))?, onTerminal: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?, arg3, restoreDraft: ((...any) -> (...any))?)
        local function startAdmitted(arg4)
            var32({ text = text, images = images, resourceAttachments = resourceAttachments, afterSequenceId = afterSequenceId })

            local var110 = var54

            local func3 = if engineFeature and str1 ~= nil then function(num1: number?)
                if var110 ~= nil then
                    var110(num1)
                end
                var100(str1, arg1.getCasSessionId() or sessionId)
            end else var110

            local func4

            if FFlagBuildExperienceRestoreStoppedPrompt and var77 ~= nil then
                local var111 = var77
                func4 = function(num1: number?)
                    var111.current = current2
                    if func3 ~= nil then
                        func3(num1)
                    end
                end
            else
                func4 = func3
            end

            local func5 = if callback == nil then func4 else function(num1: number?)
                if func4 ~= nil then
                    func4(num1)
                end
                callback(arg1.getCasSessionId())
            end

            local var111 = FFlagBuildExperienceLibrary and callback2 ~= nil and function()
                if engineFeature and str1 ~= nil then
                    var100(str1, arg1.getCasSessionId() or sessionId)
                end
                callback2(arg1.getCasSessionId())
            end or nil

            local var112, var113

            if FFlagBuildExperienceModelPicker and arg3 ~= nil then
                local var114 = arg3

                var112 = func5 ~= nil and function(num1: number?)
                    if var114.isCurrent() then
                        func5(num1)
                    end
                end or func5

                if var111 == nil then
                    var113 = var111
                else
                    var113 = function()
                        if var114.isCurrent() then
                            var111()
                        end
                    end
                end
            else
                var113 = var111
                var112 = func5
            end

            local var114 = nil
            local createLiveAssistantTurn = creatorAgentChat.createLiveAssistantTurn
            local var115 = arg1
            local var116 = arg2
            local function func6(arg5)
                if FFlagBuildExperienceModelPicker and arg3 ~= nil then
                    local var117 = arg3.isCurrent()
                    arg3.release()
                    if not var117 then
                        if activeTurnHandleRef.current == var114 and var39.current == current2 then
                            var43(nil)
                            var42.current = nil
                            var32(nil)
                            if arg1.placeId ~= nil then
                                var90(arg1.placeId, "Idle")
                            end
                        end
                        if onTerminal ~= nil then
                            onTerminal()
                        end
                        return
                    end
                end
                var108(current2, arg5, str1, images, resourceAttachments, arg1)

                if onTerminal ~= nil then
                    onTerminal()
                end
            end
            local var117 = var106(current2)
            local var118 = var11
            local var119 = if FFlagBuildExperienceModelPicker then arg4 else nil
            local sessionId2 = if FFlagBuildExperienceModelPicker and arg4 ~= nil then arg4.sessionId else nil

            var114 = createLiveAssistantTurn(
                var115,
                var116,
                func6,
                var117,
                var118,
                var112,
                var113,
                var119,
                sessionId2,
                FFlagBuildExperienceModelPicker and arg3 ~= nil and function(): boolean
                    return not arg3.isCurrent()
                end or nil
            )

            if arg1.placeId ~= nil then
                var90(arg1.placeId, "Loading")
            end
            var43(var114, arg1)
            var89.scrollToBottomAfterSend()
            var114.start()
        end
        if not FFlagBuildExperienceModelPicker then
            startAdmitted(nil)
            return
        end
        local var110 = var40
        local var111 = var41
        local var112 = arg3

        if not var112 then
            var112 = beginBuildModelSend(
                if var19 == nil then nil else var19.entry,
                CreatorCredit.getCreatorCreditStore(false),
                CreatorAgentChat.experimentOverride.getPromptExperiment(
                    CreatorAgentChat.experimentOverride.getKey(arg1.getCasSessionId()) or var23
                ),
                if var1 and var23 ~= nil then CreatorAgentChat.experimentOverride.getInternalSelection(
                    CreatorAgentChat.experimentOverride.getKey(arg1.getCasSessionId()) or var23,
                    false
                ) else nil
            )
        end

        arg3 = var112

        if arg3 == nil then
            if onTerminal ~= nil then
                onTerminal()
            end
            return
        end
        local attempt = arg3

        local tbl3 = {
            attempt = attempt,
            started = false,
            onTerminal = onTerminal,
            restoreDraft = restoreDraft
        }
        var110.current = tbl3
        var111(true)
        task.spawn(function()
            local success, result, result2 = pcall(attempt.prepare, arg1)
            local bool10 = not attempt.isCurrent() or var39.current ~= current2
            if not bool10 and success and result ~= nil then
                var111(false)
                tbl3.started = true
                startAdmitted(result)
                return
            end

            attempt.release()
            if var110.current == tbl3 then
                var110.current = nil
                var111(false)
                var32(nil)
            end
            if not bool10 then
                local chatDefaultFailure = LocalizationStrings.CHAT_DEFAULT_FAILURE
                if success and result2 ~= nil then
                    if result2.kind == "setup" then
                        chatDefaultFailure = creatorAgentChat.getPromptFailureComposerError({
                            errorCode = result2.errorCode,
                            isContentPolicy = false,
                            setupStage = if result2.setupError and result2.setupError.stage ~= "session_load" then result2.setupError.stage else nil
                        })
                    elseif result2.kind == "unavailable" then
                        chatDefaultFailure = LocalizationStrings.MODEL_PICKER_UNAVAILABLE
                    elseif result2.kind == "denied" then
                        chatDefaultFailure = LocalizationStrings.CHAT_ERROR_OUT_OF_CREDITS
                        GetBuildCreatorCreditRefreshStore(false).refresh()
                    end
                    if onPromptFailure ~= nil then
                        onPromptFailure(result2.errorCode, result2.reason)
                    end
                end
                if restoreDraft ~= nil then
                    restoreDraft(false)
                end
                var70(var2:Format(chatDefaultFailure))
            elseif var39.current == current2 and restoreDraft ~= nil then
                restoreDraft(true)
            end
            if onTerminal ~= nil then
                onTerminal()
            end
        end)
    end, {
        var19,
        var23,
        var40,
        var16,
        var41,
        var70,
        var2,
        onPromptFailure,
        var108,
        var90,
        var89,
        var43,
        var32,
        var106,
        var11,
        var54,
        var100,
        sessionId
    })

    local var111 = React.useRef(var52.latestSequenceId)
    var111.current = var52.latestSequenceId
    local startRollbackTurn = React.useCallback(function(arg1, callback: (...any) -> (...any), callback2: (...any) -> (...any))
        local var112 = var15
        if var112 == nil then
            callback2()
            return
        end
        if FFlagBuildExperienceModelPicker then
            local current2 = var40.current
            if current2 ~= nil and not current2.started and current2.attempt.isCurrent() then
                callback2()
                return
            end
        end
        var89.captureStickToBottomForSend()
        local var113 = var39
        var113.current += 1
        local current2 = var39.current
        var34(nil)
        local agentRollbackPrompt = buildAgentRollbackPrompt(arg1.versionNumber, arg1.noteTitle, arg1.noteDescription)

        var110(var112, agentRollbackPrompt, agentRollbackPrompt, nil, nil, current2, var111.current, nil, function()
            var89.scrollToBottomUnconditionally()
            callback()
        end, callback2)
    end, {
        var15,
        var40,
        var89,
        var34,
        var110
    })

    local var113 = useAgentRollbackRequest({
        universeId = universeId,
        placeId = placeId,
        session = var15,
        activeTurnHandleRef = activeTurnHandleRef,
        startRollbackTurn = startRollbackTurn
    })

    React.useLayoutEffect(function()
        if var35 == nil or sessionOwnerMatches(var38.current, var15, sessionId) then
            return
        end
        local current2 = var38.current
        local var114 = var39
        var114.current += 1
        var42.current = nil
        if var113.stopRequestBeforeReceipt(var35) then
            if current2 ~= nil and current2.session.placeId ~= nil then
                var90(current2.session.placeId, "Idle")
            end
        else
            var35.detach()
            if FFlagBuildExperienceModelPicker then
                local var115 = var40
                local current3 = var115.current
                if current3 ~= nil and current3.started then
                    current3.attempt.unlockSelection()
                    var115.current = nil
                end
            end
        end
        var43(nil, nil)
        var32(nil)
        var34(nil)
    end, {
        var15,
        sessionId,
        var35,
        var43,
        var113,
        var90,
        var40
    })

    local var114 = React.useCallback(function(text: string, arg1, images, resourceAttachments, current2: number, afterSequenceId: number?, arg2, func3: ((...any) -> (...any))?)
        var32({ text = text, images = images, resourceAttachments = resourceAttachments, afterSequenceId = afterSequenceId })

        local var114 = nil
        local universeId2 = nil
        if FFlagBuildExperienceModelPicker and tbl1.modelSelectionDraftId ~= nil then
            var114 = GetBuildModelSelectionStore(false).retainDraftForCreation(tbl1.modelSelectionDraftId)
        end
        local var115 = var18
        local var116 = var16
        local entry = if var19 == nil then nil else var19.entry

        local function canConfigure(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
            return not (entry == nil) and entry.getSelection(false) ~= nil
        end
        if var116 ~= nil then
            var116.pending = true
            var115(true)
        end
        local startTime = os.clock()
        local var117 = nil
        local chatOpenId = if FFlagBuildExperienceChatOpenId then CreatorAgentChat.chatOpenTelemetry.getChatOpenIdForUniverse(nil) else nil

        local var118 = UniverseCreate.getUniverseCreateStore().createUniverse(
            {
                templatePlaceId = getDefaultTemplatePlaceId(),
                isPublish = true
            }
        ):andThen(
            function(arg3)
                if FFlagBuildExperienceModelPicker then
                    universeId2 = arg3.universeId
                end
                debug2.log("info", "build_experience create_universe succeeded", {
                    durationMs = math.floor((os.clock() - startTime) * 1000 + 0.5),
                    universeId = arg3.universeId,
                    rootPlaceId = arg3.rootPlaceId
                })
                if FFlagBuildExperiencePromptFailureTelemetry then
                    var117 = {
                        universeId = arg3.universeId,
                        placeId = arg3.rootPlaceId
                    }
                end

                local bool10 = if FFlagBuildExperienceModelPicker then not canConfigure() else var39.current ~= current2

                if bool10 then
                    return nil
                end

                local universeConfigurationStore = UniverseConfiguration.getUniverseConfigurationStore()

                return universeConfigurationStore.patchConfiguration(arg3.universeId, { audiences = { 1 } }):andThen(function()
                    if FFlagBuildExperienceModelPicker and not canConfigure() then
                        return nil
                    end
                    return universeConfigurationStore.setTeamCreate(arg3.universeId, true)
                end):andThen(function()
                    if if FFlagBuildExperienceModelPicker then not canConfigure() or var116 == nil or not var116.mounted else var39.current ~= current2 then
                        return nil
                    end

                    local tbl3 = {
                        universeId = arg3.universeId,
                        placeId = arg3.rootPlaceId
                    }
                    if FFlagBuildExperienceModelPicker then
                        local var118 = table.clone(tbl3)
                        var118.accountId = accountId
                        var7(var118)
                    else
                        var7(tbl3)
                    end
                    if tbl1.onProjectResolved ~= nil then
                        tbl1.onProjectResolved(tbl3)
                    end

                    if arg2 ~= nil and not arg2.isCurrent() then
                        return nil
                    end

                    local sessionForProject = creatorAgentChatStore.getSessionForProject(arg3.universeId, arg3.rootPlaceId, sessionId)

                    if var1
                        and (FFlagBuildExperienceModelPicker and CreatorAgentChat.experimentOverride.has(var23) or var24 ~= nil and var24.current)
                    then
                        sessionForProject.setPendingExperimentKey(var23)
                    end
                    var110(
                        sessionForProject,
                        text,
                        arg1,
                        images,
                        resourceAttachments,
                        current2,
                        afterSequenceId,
                        text,
                        nil,
                        nil,
                        nil,
                        arg2,
                        func3
                    )
                    return nil
                end)
            end
        ):catch(
            function(error)
                debug2.log(
                    "warn",
                    "build_experience create_or_configure_universe failed",
                    {
                        durationMs = math.floor((os.clock() - startTime) * 1000 + 0.5),
                        error = error
                    }
                )
                if var39.current ~= current2 or arg2 ~= nil and not arg2.isCurrent() then
                    return
                end

                if FFlagBuildExperiencePromptFailureTelemetry then
                    local num1 = math.round((os.clock() - startTime) * 1000)
                    local var118 = var117 == nil and {} or {
                        universeId = var117.universeId,
                        placeId = var117.placeId
                    }
                    local var119 = FFlagBuildExperienceChatOpenId and {
                        universeId = var118.universeId,
                        placeId = var118.placeId,
                        chatOpenId = chatOpenId
                    }
                        or var118

                    local tbl3 = {
                        isContentPolicy = "false",
                        setupStage = if var117 == nil then "create_universe" else "configure_universe",
                        errorCopyKey = LocalizationStrings.CHAT_CREATE_UNIVERSE_ERROR,
                        elapsedMs = tostring(num1),
                        receivedResponse = "false",
                        stalled = tostring(chatConstants.PROMPT_STALL_SECONDS * 1000 <= num1)
                    }

                    tbl3.failureKind = RequestFailureKind.Unknown
                    if typeof(error) == "table" and typeof(error.responseCode) == "number" then
                        tbl3.failureKind = RequestFailureKind.Http
                        tbl3.httpStatusCode = tostring(error.responseCode)
                    end

                    sendBuildExperienceEvent("SEND_PROMPT_START", var119)
                    sendBuildExperienceEvent("SEND_PROMPT_FAILED", var119, tbl3)
                end

                var43(nil)
                var32(nil)
                setComposerText(text)
                if images ~= nil then
                    var105.current(images)
                end
                if resourceAttachments ~= nil then
                    var104.current(resourceAttachments)
                end
                if arg2 ~= nil then
                    arg2.release()
                    var41(false)
                end
                var69(var3)
            end
        )

        if not FFlagBuildExperienceModelPicker then
            return
        end

        var118:finally(function()
            if var114 ~= nil then
                var114(universeId2)
            end
            if var116 == nil then
                return
            end

            var116.pending = false
            if var116.mounted then
                var115(false)
            end
        end)
    end, {
        var16,
        var19,
        var18,
        var41,
        sessionId,
        creatorAgentChatStore,
        tbl1.onProjectResolved,
        tbl1.modelSelectionDraftId,
        var43,
        setComposerText,
        var69,
        var7,
        accountId,
        var32,
        var110,
        var3,
        var23,
        var24
    })

    local sendMessage = React.useCallback(function(func3: ((...any) -> (...any))?)
        if not var13 then
            return false
        end
        if var16 ~= nil and var16.pending then
            return false
        end

        local text = trimMessage(var71.current)

        local current2 = var82.current
        local current3 = var85.current
        if text == "" and #current2 == 0 then
            setComposerText("")
            return false
        end
        for _, value in current2 do
            if value.uri == nil or value.uploadStatus == "uploading" or value.uploadStatus == "failed" then
                return false
            end
        end

        local current4 = if sessionOwnerMatches(var38.current, var15, sessionId) then activeTurnHandleRef.current else nil

        if isAssistantResponding or var14 and current4 ~= nil then
            if #current2 > 0 or #current3 > 0 then
                return false
            end
            if current4 == nil or not current4.trySubmitComposerText(text) then
                return false
            end

            setComposerText("")
            if textBoxRef.current then
                textBoxRef.current.releaseFocus()
            end
            var89.scrollToBottomAfterSend()
            return true
        end

        local bool10 = tbl1.createUniverseOnFirstPrompt == true and universeId == nil

        if not bool10 and var15 == nil then
            return false
        end
        if placeId ~= nil and agentRollbackRequestStore.getIsPendingForPlaceId(placeId)(false) then
            return false
        end

        local function restoreDraft(bool11: boolean)
            if bool11 and (var71.current ~= "" or #var82.current > 0 or #var85.current > 0) then
                return
            end
            setComposerText(text)
            var105.current(current2)
            var104.current(current3)
        end
        local var116 = nil
        if FFlagBuildExperienceModelPicker then
            var69(nil)
            local var117 = beginBuildModelSend
            local entry = if var19 == nil then nil else var19.entry
            local creatorCreditStore = CreatorCredit.getCreatorCreditStore(false)
            local promptExperiment = CreatorAgentChat.experimentOverride.getPromptExperiment(
                CreatorAgentChat.experimentOverride.getKey(if var15 == nil then nil else var15.getCasSessionId()) or var23
            )
            local internalSelection = if var1 and var23 ~= nil then CreatorAgentChat.experimentOverride.getInternalSelection(
                CreatorAgentChat.experimentOverride.getKey(if var15 == nil then nil else var15.getCasSessionId()) or var23,
                false
            ) else nil
            var116 = var117(entry, creatorCreditStore, promptExperiment, internalSelection)

            if var116 == nil then
                return false
            end
            var40.current = { attempt = var116, started = false, restoreDraft = restoreDraft }
            var41(true)
        end
        var89.captureStickToBottomForSend()
        local var117 = var39
        var117.current += 1
        local current5 = var39.current
        var34(nil)
        if engineFeature then
            var99(text)
        end
        var95("")
        var105.current({})
        var104.current({})
        if textBoxRef.current then
            textBoxRef.current.releaseFocus()
        end

        local function startPrompt(arg1, tbl3)
            if bool10 then
                var114(
                    text,
                    arg1,
                    tbl3,
                    current3,
                    current5,
                    var52.latestSequenceId,
                    var116,
                    if FFlagBuildExperienceModelPicker then restoreDraft else nil
                )
                return
            end

            var110(
                var15,
                text,
                arg1,
                tbl3,
                current3,
                current5,
                var52.latestSequenceId,
                text,
                nil,
                nil,
                if FFlagBuildExperienceLibrary then func3 else nil,
                var116,
                if FFlagBuildExperienceModelPicker then restoreDraft else nil
            )
        end

        if #current2 == 0 and #current3 == 0 then
            startPrompt(text, nil)
            return true
        end

        local tbl3 = {}
        if text ~= "" then
            table.insert(tbl3, { type = "text", text = text })
        end
        for _, value in current3 do
            if value.type == "resource_link" then
                table.insert(tbl3, { type = value.type, uri = value.uri, name = value.name, mimeType = value.mimeType })
            else
                table.insert(tbl3, {
                    type = value.type,
                    resource = {
                        uri = value.resource.uri,
                        text = value.resource.text,
                        blob = nil,
                        mimeType = value.resource.mimeType
                    }
                })
            end
        end
        local tbl4 = {}
        for _, value in current2 do
            local uri = value.uri
            table.insert(tbl3, { type = "image", uri = uri })
            table.insert(tbl4, { capture = value.capture, uri = uri, uploadStatus = "uploaded" })
        end

        startPrompt(tbl3, tbl4)
        return true
    end, {
        var13,
        var16,
        var19,
        var23,
        var40,
        var41,
        var69,
        var15,
        sessionId,
        universeId,
        placeId,
        isAssistantResponding,
        var14,
        var89,
        setComposerText,
        var95,
        var99,
        var114,
        var110,
        tbl1.createUniverseOnFirstPrompt,
        var34,
        var52,
        agentRollbackRequestStore
    })

    local useCallback = React.useCallback
    local function func3()
        if FFlagBuildExperienceModelPicker then
            local var116 = var40
            local current2 = var116.current
            if current2 ~= nil and not current2.started then
                current2.attempt.release()
                var116.current = nil
                var41(false)
                if not current2.started then
                    local var117 = var39
                    var117.current += 1
                    var32(nil)
                    if current2.restoreDraft ~= nil then
                        current2.restoreDraft(true)
                    end
                    if current2.onTerminal ~= nil then
                        current2.onTerminal()
                    end
                    return
                end
            end
        end

        local current2 = if sessionOwnerMatches(var38.current, var15, sessionId) then activeTurnHandleRef.current else nil

        if current2 == nil then
            var113.cancelRequestBeforeTurnStarts()
            return
        end

        if FFlagBuildExperienceModelPicker then
            if FFlagBuildExperiencePromptFailureTelemetry and current2.reportUserStop ~= nil then
                current2.reportUserStop()
            end
            current2.stop()
            return
        end

        local current3 = var39.current
        local var116 = var39
        var116.current += 1

        if FFlagBuildExperiencePromptFailureTelemetry and current2.reportUserStop ~= nil then
            current2.reportUserStop()
        end

        if not var113.stopRequestBeforeReceipt(current2) then
            current2.stop()
        end
        var43(nil)
        var42.current = nil

        if FFlagBuildExperienceRestoreStoppedPrompt
            and var77 ~= nil
            and var77.current ~= current3
            and var31 ~= nil
            and var71.current == ""
            and var52.isAwaitingUserMessageEcho
        then
            setComposerText(var31.text)

            if var31.images ~= nil and #var82.current == 0 then
                var105.current(var31.images)
            end
            if var31.resourceAttachments ~= nil and #var85.current == 0 then
                var104.current(var31.resourceAttachments)
            end
        end

        var32(nil)
        var34({ session = var15, sessionId = var15.getCasSessionId(), startSequenceId = var52.activeTurnStartSequenceId })

        if placeId ~= nil then
            var90(placeId, "Idle")
        end
    end

    local var116 = var40
    local var117 = var41

    local var118 = sessionId
    local var119 = placeId
    local var120 = if FFlagBuildExperienceRestoreStoppedPrompt then var31 else nil
    local var121 = if FFlagBuildExperienceRestoreStoppedPrompt then setComposerText else nil
    local stopAssistantResponse = useCallback(func3, { var116, var117, var15, var118, var119, var90, var43, var32, var34, var52, var113, var120, var121 })

    local var123 = tbl1.autoFocusComposer == nil or tbl1.autoFocusComposer
    local var124 = if tbl1.focusComposerWhen == nil then var123 else tbl1.focusComposerWhen

    React.useEffect(function()
        if not (var123 and var124) then
            return function() end
        end
        local bool10 = false
        local var125 = textBoxRef

        local function func4()
            return bool10
        end

        scheduleComposerAutoFocus(var125, func4)

        return function()
            bool10 = true
        end
    end, { var123, var124 })

    local var125 = React.useCallback(function(str1: string)
        if placeId == nil then
            return
        end

        local var125 = game.GameId == 0 and function()
            var10.current = true
        end or nil

        if launchPlaytestWithLoadingState(placeId, str1, true, var125) and var125 ~= nil then
            var10.current = false
        end
    end, { placeId, var10 })

    local localToolActions = if FFlagBuildExperienceAnswerForm then React.useMemo(function()
        local onAnswerSelectedByToolCallId = ({})
        for value, value2 in var49.onAnswerSelectedByToolCallId do
            onAnswerSelectedByToolCallId[value] = function(arg1, arg2, bool10: boolean?)
                var69(nil)
                value2(arg1, arg2, bool10)
            end
        end
        local onAnswerConfirmedByToolCallId = ({})
        for value, value2 in var49.onAnswerConfirmedByToolCallId do
            onAnswerConfirmedByToolCallId[value] = function()
                var69(nil)
                value2()
            end
        end
        return {
            onAnswerSelectedByToolCallId = onAnswerSelectedByToolCallId,
            onAnswerConfirmedByToolCallId = onAnswerConfirmedByToolCallId,
            onPlanAcceptedByToolCallId = var49.onPlanAcceptedByToolCallId,
            onDevProductApprovedByToolCallId = var49.onDevProductApprovedByToolCallId,
            onDevProductRejectedByToolCallId = var49.onDevProductRejectedByToolCallId
        }
    end, { var49, var69 }) else var49

    local answerForm = if FFlagBuildExperienceAnswerForm then React.useMemo(function()
        return getActiveAnswerForm(activeTurnState, optimisticLocalTools, localToolActions)
    end, { activeTurnState, optimisticLocalTools, localToolActions }) else nil

    local submitAnswerText = if FFlagBuildExperienceAnswerForm then React.useCallback(function(str1: string, str2: string, str3: string)
        local current2 = activeTurnHandleRef.current

        if current2 == nil or not sessionOwnerMatches(var38.current, var15, sessionId) then
            return false
        end
        var69(nil)
        return current2.trySubmitAnswerText(str1, str2, str3)
    end, { var15, sessionId, var69 }) else nil

    local tbl3 = {
        currentSessionId = casSessionId,
        internalTesting = var25,
        agentSpecVersion = var22,
        setAgentSpecVersion = func1,
        messages = messages,
        localToolActions = localToolActions,
        answerForm = answerForm,
        submitAnswerText = submitAnswerText,
        composerText = composerText,
        composerErrorText = composerErrorText,
        fundingFailure = var107,
        setComposerText = setComposerText,
        setPrefilledComposerText = setPrefilledComposerText,
        composerImages = composerImages,
        setComposerImages = setComposerImages,
        retryComposerImage = retryComposerImage,
        composerResourceAttachments = composerResourceAttachments,
        findComposerResourceAttachmentIndexByUri = findComposerResourceAttachmentIndexByUri,
        addComposerResourceAttachment = addComposerResourceAttachment,
        removeComposerResourceAttachmentAtIndex = removeComposerResourceAttachmentAtIndex,
        clearComposerResourceAttachments = clearComposerResourceAttachments,
        hasPreparedModelSession = if FFlagBuildExperienceModelPicker then not (var19 == nil) and var19.hasObservedModels else nil,
        modelSessionModels = if FFlagBuildExperienceModelPicker and var19 ~= nil then var19.models else nil
    }

    if not bool9 then
        bool9 = FFlagBuildExperienceModelPicker

        if bool9 then
            bool9 = bool1 or bool5 or var19 ~= nil and var19.isBusy and not isAssistantResponding

            if not bool9 then
                if composerErrorText == nil then
                    bool9 = false
                else
                    bool9 = not var67
                end
            end
        end
    end

    tbl3.isComposerSendBlocked = bool9

    tbl3.isAssistantResponding = isAssistantResponding
    tbl3.canStopAssistantResponse = var44 ~= nil or var60 or FFlagBuildExperienceModelPicker and bool5
    tbl3.canSendWhileResponding = canSendWhileResponding
    tbl3.sendMessage = sendMessage
    tbl3.stopAssistantResponse = stopAssistantResponse
    tbl3.setScrollingFrame = var89.setScrollingFrame
    tbl3.anchorScrollToInstance = if FFlagBuildExperienceChatAccordionScrollAnchor then var89.anchorToInstance else nil

    tbl3.textBoxRef = textBoxRef
    tbl3.clockBinding = clockBinding
    tbl3.playtestPlaceId = placeId
    if placeId == nil then
        var125 = nil
    end

    tbl3.launchPlaytest = var125
    tbl3.hasPublishedTurn = includesPublishTool
    tbl3.subagentTaskState = subagentTaskState
    tbl3.isHistoryHydrationComplete = isHistoryHydrationComplete
    tbl3.isHistoryLoading = bool4
    tbl3.isHistoryExhausted = isHistoryExhausted
    return tbl3
end

return useChatSessionCore
