-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local useBuildModelSelection = require(BuildExperience.Chat.useBuildModelSelection)
local GetBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore)

local GuiService = game:GetService("GuiService")
local MessageBusService = game:GetService("MessageBusService")
local UserInputService = game:GetService("UserInputService")

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local useChatPlaytestFooter = require(BuildExperience.Chat.useChatPlaytestFooter)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)

local FFlagBuildExperienceDeveloperProductContext = require(BuildExperience.Flags.FFlagBuildExperienceDeveloperProductContext)
local FFlagBuildRequestPromptChipsOnEdit = require(BuildExperience.Flags.FFlagBuildRequestPromptChipsOnEdit)
local useBuildPromptChipRequests = require(BuildExperience.Chat.useBuildPromptChipRequests)
local useBuildPromptDraft = require(BuildExperience.Chat.useBuildPromptDraft)
local useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildExperienceChatOpenId = require(BuildExperience.Flags.FFlagBuildExperienceChatOpenId)
local GetBuildPromptChipsStore = require(BuildExperience.Stores.GetBuildPromptChipsStore)
local GetBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore)
local GetCreatorAgentResumeStore = require(BuildExperience.Stores.GetCreatorAgentResumeStore)
local promptChipsStatus = require(BuildExperience.Stores.GetBuildPromptChipsStore.promptChipsStatus)
local _BuildChatPageView = require(script.Parent.BuildChatPageView)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local FFlagBuildEnableFTUXChips = require(BuildExperience.Flags.FFlagBuildEnableFTUXChips)

local FFlagBuildExperienceFTUXChipConversationIdTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceFTUXChipConversationIdTelemetry)

local FFlagBuildExperienceFTUXChipExhaustedTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceFTUXChipExhaustedTelemetry)
local useCreatorCreditChatUpsellViewModel = require(script.Parent.useCreatorCreditChatUpsellViewModel)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary
local FFlagBuildExperienceAnalytics = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceAnalytics
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local useAgentAdCampaignChatViewModel = if FFlagBuildAgentAdCampaignCard then require(script.Parent.useAgentAdCampaignChatViewModel) else nil
local FFlagEnableBuildAdPromotion = require(BuildExperience.Flags.FFlagEnableBuildAdPromotion)
local GetAdUpsellEventStore = if FFlagBuildAdUpsell then require(BuildExperience.Stores.GetAdUpsellEventStore) else nil
local GameConfigurationLabels = if FFlagBuildAdUpsell or FFlagEnableBuildAdPromotion then require(BuildExperience.utils.GameConfigurationLabels) else nil
local useAdUpsellChatViewModel = if FFlagBuildAdUpsell then require(script.Parent.useAdUpsellChatViewModel) else nil
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildEventsUpdate1 = require(BuildExperience.Flags.FFlagBuildEventsUpdate1)

local FFlagBuildExperiencePlaytestCardPublishCta = require(BuildExperience.Flags.FFlagBuildExperiencePlaytestCardPublishCta)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local engineFeature = game:GetEngineFeature("BuildAppStorageKey")
local BuildAppStorage = if engineFeature then require(BuildExperience.Storage.BuildAppStorage) else nil
local default = require(BuildExperienceParent.LinkingProtocol).LinkingProtocol.default
local PermissionsProtocol = require(BuildExperienceParent.PermissionsProtocol).PermissionsProtocol
local useTokens = Foundation.Hooks.useTokens

local messageId = MessageBusService:GetMessageId("Realtime", "appResume")

local tbl1 = {
    groups = {},
    allComplete = false
}

local tbl2 = {
    adUpsellCards = {},
    adUpsellCongratsAnchorIndex = nil,
    adUpsellFreePromotionsRemaining = 0,
    isAdUpsellCreatePending = false,
    isAdCampaignSheetOpen = false,
    hasAdCampaignCreateError = false,
    adCampaignCreateErrorKind = nil,
    adCampaignDurationDays = nil,
    adCampaignEstimatedPriceRobux = nil,
    adCampaignOffers = nil,
    adCampaignRunStartTimeMs = nil,
    adCampaignRunEndTimeMs = nil,
    isAdCampaignCreatedToastVisible = false,
    onAdCampaignCreatedToastDismiss = function() end,
    onAdUpsellCreate = function() end,
    onAdUpsellDismiss = function() end,
    onAdUpsellImpression = function() end,
    onAdCampaignSheetClose = function() end,
    onAdCampaignSheetCreate = function() end
}

local tbl3 = {
    isSheetOpen = false,
    isCreatePending = false,
    hasCreateError = false,
    createErrorKind = nil,
    campaignOffers = nil,
    runStartTimeMs = nil,
    onOfferSelected = function() end,
    isCreateDisabled = function(): boolean
        return true
    end,
    getCardState = function()
        return nil
    end,
    onSheetClose = function() end,
    onSheetCreate = function() end
}

local function getKeyboardTop(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if not UserInputService.OnScreenKeyboardVisible then
        return 0
    end
    local vector2 = GuiService:GetGuiInset()
    return math.max(0, UserInputService.OnScreenKeyboardPosition.Y - vector2.Y)
end

local function useUniverseSummary(universeId: number?)
    local universeConfigurationStore = UniverseConfiguration.getUniverseConfigurationStore()
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if universeId == nil or universeId == 0 then
                return nil
            end
            return universeConfigurationStore.getAndFetchSummary(universeId).data(arg1)
        end)
    end, { universeConfigurationStore, universeId })

    return SignalsReact.useSignalState(var1)
end

local function fetchCachedUniverseSummary(universeId: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local universeConfigurationStore = UniverseConfiguration.getUniverseConfigurationStore()
    if universeConfigurationStore.getSummary(universeId).data(false) ~= nil then
        universeConfigurationStore.fetchSummary(universeId)
    end
end

local function getResolvedSessionId(messages, sessionId: string?, universeId: number?)
    if sessionId ~= nil and sessionId ~= "" then
        return sessionId
    end
    for i = #messages, 1, -1 do
        local var1 = messages[i]

        if var1.kind == "assistant_turn" and var1.sessionId ~= nil and (universeId == nil or var1.universeId == universeId) then
            return var1.sessionId
        end
    end
    return nil
end

local function getHydratedExperienceName(experienceName: string, arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local name = if arg1 == nil then nil else arg1.name
    return if typeof(name) == "string" and name ~= "" then name else experienceName
end

local function usePromptChipViewModel(arg1, target, bool1: boolean)
    local tbl4 = {}
    local bool2 = false
    local function func1() end
    local onChipExhausted = nil
    local setComposerText = arg1.setComposerText

    if not (FFlagBuildEnableFTUXChips or FFlagBuildRequestPromptChipsOnEdit) then
        return {
            promptChips = tbl4,
            isPromptChipsLoading = bool2,
            onPromptChipActivated = func1,
            onPromptChipExhausted = onChipExhausted,
            onComposerChanged = setComposerText
        }
    end

    local buildPromptChipsStore = GetBuildPromptChipsStore()
    local var1 = FFlagBuildEnableFTUXChips
        and not bool1
        and arg1.isHistoryHydrationComplete
        and not arg1.isHistoryLoading
        and #arg1.messages == 0
    local sessionKey = `{target.universeId or 0}:{target.placeId or 0}:{target.sessionId or "new"}`
    local conversationId = if FFlagBuildExperienceFTUXChipConversationIdTelemetry then arg1.currentSessionId else target.sessionId

    local telemetryGranularity = React.useMemo(function()
        return {
            universeId = target.universeId,
            placeId = target.placeId,
            conversationId = conversationId
        }
    end, { target.universeId or 0, target.placeId or 0, conversationId or "" })

    local var4 = useBuildPromptChipRequests(buildPromptChipsStore, {
        isActive = var1,
        sessionKey = sessionKey,
        shouldRequestInitialChips = var1,
        telemetryGranularity = telemetryGranularity
    })
    local var5 = React.useRef(nil)

    if FFlagBuildEnableFTUXChips then
        local var6 = SignalsReact.useSignalState(buildPromptChipsStore.getChips)
        local var7 = SignalsReact.useSignalState(buildPromptChipsStore.getStatus)
        tbl4 = not var1 and {} or var6
        bool2 = var1 and var7 == promptChipsStatus.PROMPT_CHIPS_STATUS.Loading
        func1 = React.useCallback(function(arg2)
            local value = arg1.composerText:getValue()
            var4.requestChipsForSelection(value, arg2, function(current)
                if arg1.composerText:getValue() == value then
                    var5.current = current
                    arg1.setComposerText(current)
                end
            end)
        end, {
            arg1.composerText,
            arg1.setComposerText,
            var4,
            var5
        })

        if FFlagBuildExperienceFTUXChipExhaustedTelemetry then
            onChipExhausted = var4.onChipExhausted
        end
    end

    if FFlagBuildRequestPromptChipsOnEdit then
        setComposerText = React.useCallback(function(current: string)
            arg1.setComposerText(current)
            if var5.current == current then
                var5.current = nil
                return
            end
            var5.current = nil
            var4.requestChipsForEdit(current)
        end, { arg1.setComposerText, var4, var5 })
    end

    return {
        promptChips = tbl4,
        isPromptChipsLoading = bool2,
        onPromptChipActivated = func1,
        onPromptChipExhausted = onChipExhausted,
        onComposerChanged = setComposerText
    }
end

local function useChatOpen(target)
    local var1 = React.useRef(nil)
    if target.chatOpenId ~= nil then
        var1.current = target.chatOpenId
    end
    local current = var1.current

    if current ~= nil then
        CreatorAgentChat.chatOpenTelemetry.open(current, target.universeId)
        if target.universeId ~= nil then
            CreatorAgentChat.chatOpenTelemetry.setUniverseId(current, target.universeId)
        end
    end
    React.useEffect(function()
        if current == nil then
            return nil
        end
        local var2 = current
        return function()
            CreatorAgentChat.chatOpenTelemetry.close(var2)
        end
    end, { current })
    return current
end

local function useChatOpenSessionLink(chatOpenId: string?, target, currentSessionId: string?)
    local var1 = React.useRef(nil)
    local var2 = currentSessionId or target.sessionId

    if chatOpenId ~= nil then
        CreatorAgentChat.chatOpenTelemetry.setSessionId(chatOpenId, var2)
    end
    React.useEffect(function()
        if chatOpenId == nil or var2 == nil then
            return
        end
        local current = var1.current
        if current ~= nil and current.chatOpenId == chatOpenId and current.sessionId == var2 then
            return
        end

        var1.current = { chatOpenId = chatOpenId, sessionId = var2 }
        sendBuildExperienceEvent(
            "CHAT_SESSION_LINKED",
            {
                universeId = target.universeId,
                placeId = target.placeId,
                conversationId = var2,
                chatOpenId = chatOpenId
            }
        )
    end, { chatOpenId, var2 })
end

local function useBuildChatPageViewModel(tbl4)
    local var1 = useTokens()
    local var2 = useUniverseSummary(tbl4.target.universeId)
    local buildOverflowMenuStore = GetBuildOverflowMenuStore()
    local creatorAgentResumeStore = GetCreatorAgentResumeStore()
    local selectedChipGroupName, var4 = React.useState(nil)
    local isChatScrollable, var6 = React.useState(false)

    local var7, var8 = React.useState(nil)
    local var9, var10 = React.useState(function()
        return engineFeature and BuildAppStorage.isPushNotificationsUpsellDismissedPermanently()
    end)
    local isPushNotificationsRequestPending, var12 = React.useState(false)
    local shouldOpenPushNotificationsSettings, var14 = React.useState(false)
    local var15, var16 = React.useState(function()
        return engineFeature and BuildAppStorage.wasPushNotificationsUpsellShownToday()
    end)

    local var17, var18 = React.useState(false)
    local var19 = React.useRef(false)

    local var20, var21 = React.useState((getKeyboardTop()))
    local var22, var23 = React.useState(0)

    local callback = React.useCallback(function()
        return PermissionsProtocol.default:hasPermissions({ PermissionsProtocol.Permissions.POST_NOTIFICATIONS }):andThen(function(arg1)
            if not var19.current then
                return
            end

            var8(arg1.status)
            if arg1.status == PermissionsProtocol.Status.AUTHORIZED then
                var14(false)
            end
        end, function() end)
    end, {})

    React.useEffect(function()
        var19.current = true
        callback()

        local var24 = MessageBusService:Subscribe(messageId, callback, false, true)
        return function()
            var19.current = false
            var24:Disconnect()
        end
    end, { callback })

    local onNotifyMe = React.useCallback(function()
        if isPushNotificationsRequestPending then
            return
        end

        var12(true)
        PermissionsProtocol.default:requestPermissions({ PermissionsProtocol.Permissions.POST_NOTIFICATIONS }):andThen(
            function(arg1)
                if not var19.current then
                    return
                end
                var8(arg1.status)
                if arg1.status == PermissionsProtocol.Status.DENIED then
                    var14(true)
                end
                var12(false)
            end,
            function()
                if var19.current then
                    var12(false)
                end
            end
        )
    end, { isPushNotificationsRequestPending })

    local onOpenPushNotificationsSettings = React.useCallback(function()
        default:switchToSettingsApp():catch(function() end)
    end, {})

    local onNotNow = React.useCallback(function()
        if engineFeature then
            BuildAppStorage.markPushNotificationsUpsellDismissedPermanently()
        end
        var10(true)
    end, {})

    local var27 = React.useCallback(function()
        var21((getKeyboardTop()))
    end, {})

    React.useEffect(function()
        var27()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(var27)
        local connection2 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(var27)
        local connection3 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(var27)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { var27 })

    local onPageMetricsChanged = React.useCallback(function(arg1)
        var23(arg1.AbsolutePosition.Y + arg1.AbsoluteSize.Y)
    end, {})

    local onChatViewportChanged = React.useCallback(function(arg1)
        local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
        var6(absoluteWindowSizeY > 0 and absoluteWindowSizeY < arg1.AbsoluteCanvasSize.Y)
    end, {})

    local var30 = if var20 <= 0 or var22 <= 0 then 0 else math.max(0, var22 - var20)
    local bool1 = tbl4.target.isNewGameTarget == true
    local var31, var32, bool2, bool3, bool4, bool5

    if FFlagBuildCheckGamePermissions then
        var31, var32 = useGamePermissions({ universeId = tbl4.target.universeId, isNewGame = bool1 })

        bool2 = not var31.canEditOnBuild

        bool3 = not var31.canEdit
        bool4 = not var31.canEdit
        bool5 = not var31.canAdvertise
    else
        bool2 = false
        bool4 = false
        bool5 = false
        var32 = false
        var31 = nil
        bool3 = false
    end

    local chatOpenId = if FFlagBuildExperienceChatOpenId then useChatOpen(tbl4.target) else nil
    local useMemo = React.useMemo
    local function func1()
        return {
            universeId = tbl4.target.universeId,
            placeId = tbl4.target.placeId,
            sessionId = tbl4.target.sessionId,
            experienceName = getHydratedExperienceName(tbl4.target.experienceName, var2),
            isNewGameTarget = tbl4.target.isNewGameTarget,
            modelSelectionDraftId = if FFlagBuildExperienceModelPicker then tbl4.target.modelSelectionDraftId else nil,
            creatorName = tbl4.target.creatorName,
            gameIcon = tbl4.target.gameIcon,
            chatOpenId = if FFlagBuildExperienceChatOpenId then chatOpenId else nil
        }
    end

    local universeId = tbl4.target.universeId
    local placeId = tbl4.target.placeId
    local sessionId = tbl4.target.sessionId
    local experienceName = tbl4.target.experienceName
    local isNewGameTarget = tbl4.target.isNewGameTarget
    local modelSelectionDraftId = tbl4.target.modelSelectionDraftId
    local creatorName = tbl4.target.creatorName
    local gameIcon = tbl4.target.gameIcon
    local var33 = if FFlagBuildExperienceChatOpenId then chatOpenId else nil
    local target = useMemo(func1, {
        universeId,
        placeId,
        sessionId,
        experienceName,
        isNewGameTarget,
        modelSelectionDraftId,
        creatorName,
        gameIcon,
        var2,
        var33
    })

    local useCallback = React.useCallback
    local function func2(tbl5)
        if FFlagBuildExperienceModelPicker and target.modelSelectionDraftId ~= nil then
            GetBuildModelSelectionStore(false).promoteDraft(target.modelSelectionDraftId, tbl5.universeId)
        end

        if FFlagBuildExperienceChatOpenId and target.chatOpenId ~= nil then
            CreatorAgentChat.chatOpenTelemetry.setUniverseId(target.chatOpenId, tbl5.universeId)
        end
        if tbl4.onNavigateToResolvedTarget == nil then
            return
        end

        tbl4.onNavigateToResolvedTarget({
            universeId = tbl5.universeId,
            placeId = tbl5.placeId,
            sessionId = tbl5.sessionId,
            experienceName = target.experienceName,
            isNewGameTarget = target.isNewGameTarget,
            modelSelectionDraftId = if FFlagBuildExperienceModelPicker then target.modelSelectionDraftId else nil,
            creatorName = target.creatorName,
            gameIcon = target.gameIcon,
            chatOpenId = if FFlagBuildExperienceChatOpenId then target.chatOpenId else nil
        })
    end

    local tbl5 = if FFlagBuildExperienceModelPicker then { tbl4.onNavigateToResolvedTarget, target } else {
        tbl4.onNavigateToResolvedTarget,
        target.experienceName,
        target.isNewGameTarget,
        target.creatorName,
        target.gameIcon,
        if FFlagBuildExperienceChatOpenId then target.chatOpenId else nil
    }
    local onProjectResolved = useCallback(func2, tbl5)

    local var36, var37 = React.useState({ count = 0, reason = nil })

    local var38 = React.useCallback(function(outOfCredits: number?, reason)
        if outOfCredits ~= CreatorAgentChat.ErrorCodes.OutOfCredits then
            return
        end

        var37(function(arg1)
            return {
                count = arg1.count + 1,
                reason = reason
            }
        end)
    end, {})

    local adUpsellEventStore = if FFlagBuildAdUpsell then GetAdUpsellEventStore(false) else nil

    local onAssistantTurnCompleted = if FFlagBuildAdUpsell then React.useCallback(function(arg1)
        if adUpsellEventStore ~= nil then
            adUpsellEventStore.reportAssistantTurnCompleted(arg1)
        end
    end, { adUpsellEventStore }) else nil

    local var40 = useChatSessionCore
    local tbl6 = {
        universeId = tbl4.target.universeId,
        placeId = tbl4.target.placeId,
        sessionId = tbl4.target.sessionId,
        autoFocusComposer = bool1,
        createUniverseOnFirstPrompt = bool1,
        modelSelectionDraftId = if FFlagBuildExperienceModelPicker then target.modelSelectionDraftId else nil,
        onProjectResolved = onProjectResolved,
        onPromptFailure = 0,
        trackAdUpsellTurns = 0,
        onAssistantTurnCompleted = 0,
        sendMessageWhen = 0
    }

    if FFlagBuildExperienceModelPicker then
        var38 = nil
    end

    tbl6.onPromptFailure = var38
    tbl6.trackAdUpsellTurns = FFlagBuildAdUpsell
    tbl6.onAssistantTurnCompleted = onAssistantTurnCompleted
    tbl6.sendMessageWhen = not bool2
    local var41 = var40(tbl6)

    if FFlagBuildExperienceChatOpenId then
        useChatOpenSessionLink(chatOpenId, tbl4.target, var41.currentSessionId)
    end
    local isChatEmpty = #var41.messages == 0
    local var42 = usePromptChipViewModel(var41, tbl4.target, bool2)
    local promptChips = var42.promptChips
    local isPromptChipsLoading = var42.isPromptChipsLoading
    local onPromptChipActivated = var42.onPromptChipActivated
    local onPromptChipExhausted = var42.onPromptChipExhausted
    local onComposerChanged = var42.onComposerChanged
    local modelPicker = if FFlagBuildExperienceModelPicker then useBuildModelSelection(
        tbl4.target.universeId,
        tbl4.target.modelSelectionDraftId,
        tbl4.modelPicker,
        var41.modelSessionModels,
        var41.hasPreparedModelSession,
        var41.internalTesting
    ) else nil

    if FFlagBuildExperienceAnalytics then
        local var44 = React.useRef(false)

        React.useEffect(function()
            local initialPrompt = tbl4.initialPrompt
            if var44.current or initialPrompt == nil or initialPrompt == "" then
                return
            end
            var41.setComposerText(initialPrompt)
            if var41.sendMessage() then
                var44.current = true
            end
        end, { tbl4.initialPrompt, var41.sendMessage, var41.setComposerText })
    end

    if FFlagBuildExperienceMonetizationNativeUI then
        useBuildPromptDraft(
            tbl4.target.universeId,
            tbl4.target.sessionId,
            var41.setPrefilledComposerText,
            var41.sendMessage,
            tbl4.isFocused ~= false,
            if FFlagBuildExperienceDeveloperProductContext then var41 else nil
        )
    elseif FFlagBuildExperienceManageDevProduct then
        useBuildPromptDraft(
            tbl4.target.universeId,
            tbl4.target.sessionId,
            var41.setPrefilledComposerText,
            var41.sendMessage,
            nil,
            if FFlagBuildExperienceDeveloperProductContext then var41 else nil
        )
    end

    local var44 = useChatPlaytestFooter(var41, "BuildChatPlaytestCta")
    local subagentTaskState = var41.subagentTaskState
    local hasTaskGroups = not (subagentTaskState == nil) and #subagentTaskState.groups > 0
    local bool8 = false
    for _, value in var41.messages do
        if value.kind == "user_message" then
            bool8 = true
            break
        end
    end

    local var45 = var7 == PermissionsProtocol.Status.DENIED and not var9 and (not var15 or var17)
    local var46 = React.useRef(false)

    React.useEffect(function()
        if not engineFeature then
            return function() end
        end

        local isAssistantResponding = var45 and bool8 and var41.isAssistantResponding
        if isAssistantResponding and not var17 then
            var18(true)
            var16(true)
            BuildAppStorage.markPushNotificationsUpsellShown()
        elseif not isAssistantResponding and var17 then
            var18(false)
        end

        return function() end
    end, {
        var45,
        bool8,
        var41.isAssistantResponding,
        var15,
        var17
    })

    React.useEffect(function()
        local universeId2 = tbl4.target.universeId
        local var47 = var46.current and not var41.isAssistantResponding
        var46.current = var41.isAssistantResponding

        if not var47 or universeId2 == nil or universeId2 == 0 then
            return function() end
        end
        if FFlagBuildAdUpsell then
            task.defer(function()
                if var19.current then
                    fetchCachedUniverseSummary(universeId2)
                end
            end)
        else
            fetchCachedUniverseSummary(universeId2)
        end

        return function() end
    end, { tbl4.target.universeId, var41.isAssistantResponding })

    React.useEffect(function()
        if FFlagBuildExperienceMonetizationNativeUI and tbl4.isFocused == false then
            return
        end

        creatorAgentResumeStore.setActiveTarget({ universeId = tbl4.target.universeId, sessionId = tbl4.target.sessionId })

        return function()
            creatorAgentResumeStore.setActiveTarget(nil)
        end
    end, FFlagBuildExperienceMonetizationNativeUI
        and {
            creatorAgentResumeStore,
            tbl4.target.universeId or false,
            tbl4.target.sessionId or false,
            tbl4.isFocused ~= false
        }
        or { creatorAgentResumeStore, tbl4.target.universeId, tbl4.target.sessionId })

    local var47 = React.useCallback(function()
        if var41.textBoxRef.current then
            var41.textBoxRef.current.releaseFocus()
        end
    end, { var41.textBoxRef })

    local var48 = React.useCallback(function()
        var47()
        if tbl4.onOpenCreatorCreditPage ~= nil then
            tbl4.onOpenCreatorCreditPage()
        end
    end, { var47, tbl4.onOpenCreatorCreditPage })
    if tbl4.onOpenCreatorCreditPage == nil then
        var48 = nil
    end

    local var49 = if FFlagEnableBuildAdPromotion then React.useCallback(function()
        var47()
        if tbl4.onOpenGetUsersPage ~= nil then
            tbl4.onOpenGetUsersPage()
        end
    end, { var47, tbl4.onOpenGetUsersPage }) else nil

    if tbl4.onOpenGetUsersPage == nil then
        var49 = nil
    end
    local var50 = useCreatorCreditChatUpsellViewModel({
        namedTier = if FFlagBuildExperienceModelPicker and modelPicker and modelPicker.selectedId == "advanced" then if modelPicker.internalTesting then if modelPicker.internalTesting.isSelected then nil else "advanced" else "advanced" else nil,
        onOpenCreatorCreditPage = var48,
        outOfCreditsPromptFailureCount = if FFlagBuildExperienceModelPicker then if var41.fundingFailure then var41.fundingFailure.count else nil else var36.count,
        outOfCreditsPromptFailureReason = if FFlagBuildExperienceModelPicker then if var41.fundingFailure then var41.fundingFailure.reason else nil else var36.reason,
        isAssistantResponding = var41.isAssistantResponding
    })

    local var51 = (FFlagBuildAdUpsell or FFlagEnableBuildAdPromotion)
        and GameConfigurationLabels.getAudience(var2) == UniverseConfiguration.PrivacyType.Public
    local resolvedSessionId = if FFlagBuildAdUpsell or FFlagBuildExperienceLibrary then getResolvedSessionId(var41.messages, tbl4.target.sessionId, tbl4.target.universeId) else nil
    local var52 = if FFlagBuildAdUpsell then useAdUpsellChatViewModel({
        messages = var41.messages,
        isHistoryExhausted = var41.isHistoryExhausted,
        sessionId = resolvedSessionId,
        isPublic = var51,
        isPageVisible = tbl4.isFocused ~= false,
        universeId = tbl4.target.universeId
    }) else tbl2
    local var53 = if FFlagBuildAgentAdCampaignCard then useAgentAdCampaignChatViewModel(
        {
            universeId = tbl4.target.universeId,
            sessionId = resolvedSessionId,
            isPageVisible = tbl4.isFocused ~= false
        }
    ) else tbl3

    local onClose = React.useCallback(function()
        var47()
        tbl4.onClose()
    end, { var47, tbl4.onClose })

    local onOverflowMenuAction = React.useCallback(function(arg1)
        if arg1.type == "openPage" then
            var47()
            if tbl4.onOpenConfigurationPage then
                tbl4.onOpenConfigurationPage(arg1.page)
            end
        elseif arg1.type == "openInvitePicker" then
            var47()
            if tbl4.onOpenInvitePicker then
                tbl4.onOpenInvitePicker()
            end
        elseif arg1.type == "openInviteManagement" then
            var47()
            if tbl4.onOpenInviteManagement then
                tbl4.onOpenInviteManagement()
            end
        end
    end, {
        var47,
        tbl4.onOpenConfigurationPage,
        tbl4.onOpenInvitePicker,
        tbl4.onOpenInviteManagement
    })

    local var56 = if FFlagBuildExperiencePlaytestCardPublishCta then React.useCallback(function()
        onOverflowMenuAction({ type = "openPage", page = "publish" })
    end, { onOverflowMenuAction }) else nil

    local onOpenLibrary = React.useCallback(function()
        var47()
        if tbl4.onOpenLibrary ~= nil then
            tbl4.onOpenLibrary(resolvedSessionId)
        end
    end, { var47, tbl4.onOpenLibrary, resolvedSessionId })

    local onPlayActivated = React.useCallback(function()
        sendBuildExperienceEvent(
            if FFlagBuildEventsUpdate1 then "PLAYTEST_CLICK" else "PLAY_CLICK",
            {
                universeId = tbl4.target.universeId,
                placeId = var41.playtestPlaceId
            },
            FFlagBuildEventsUpdate1 and { context = "app_header" } or nil
        )

        if var41.launchPlaytest then
            var41.launchPlaytest("BuildChatPage")
        end
    end, { var41.launchPlaytest, var41.playtestPlaceId, tbl4.target.universeId })

    local onOpenAgentsPage = React.useCallback(function()
        var47()
        tbl4.onOpenAgentsPage(subagentTaskState or tbl1)
    end, { var47, tbl4.onOpenAgentsPage, subagentTaskState })

    local onChipActivated = React.useCallback(function(str1: string)
        var47()
        var4(str1)
    end, { var47 })

    local tbl7 = {
        target = target,
        agentSpecVersion = var41.agentSpecVersion,
        setAgentSpecVersion = var41.setAgentSpecVersion,
        keyboardOverlap = var30,
        onPageMetricsChanged = onPageMetricsChanged,
        selectedChipGroupName = selectedChipGroupName,
        onChipActivated = onChipActivated,
        onChipBottomSheetClose = function()
            var4(nil)
        end,
        onClose = onClose,
        onOpenLibrary = onOpenLibrary,
        isLibraryDisabled = FFlagBuildExperienceLibrary and (tbl4.target.universeId == nil or bool3),
        onOverflowMenuAction = onOverflowMenuAction,
        onPlayActivated = onPlayActivated,
        onOpenAgentsPage = onOpenAgentsPage,
        onOpenCreatorCreditPage = var48,
        onOpenGetUsersPage = var49,
        isUniversePublic = var51,
        buildOverflowMenuStore = buildOverflowMenuStore,
        messages = var41.messages,
        localToolActions = var41.localToolActions,
        answerForm = if FFlagBuildExperienceAnswerForm then var41.answerForm else nil,
        onSubmitAnswerText = if FFlagBuildExperienceAnswerForm then var41.submitAnswerText else nil,
        clockBinding = var41.clockBinding,
        onPlaytest = var44.onPlaytest
    }

    if tbl4.onOpenConfigurationPage == nil then
        var56 = nil
    end

    tbl7.onPublish = var56
    tbl7.isPlaytestLoading = var44.isPlaytestLoading
    tbl7.isPlaytestDisabled = bool4
    tbl7.showPushNotificationsUpsell = if engineFeature then var17 and var45 else var45

    tbl7.isPushNotificationsRequestPending = isPushNotificationsRequestPending
    tbl7.shouldOpenPushNotificationsSettings = shouldOpenPushNotificationsSettings
    tbl7.onNotifyMe = onNotifyMe
    tbl7.onOpenPushNotificationsSettings = onOpenPushNotificationsSettings
    tbl7.onNotNow = onNotNow
    tbl7.showBuyMoreRobuxCard = var50.showBuyMoreRobuxCard
    tbl7.buyMoreRobuxCardTitle = var50.buyMoreRobuxCardTitle
    tbl7.buyMoreRobuxCardDescription = var50.buyMoreRobuxCardDescription
    tbl7.buyMoreRobuxCardPrimaryActionText = var50.buyMoreRobuxCardPrimaryActionText
    tbl7.onBuyMoreRobuxCardPrimaryAction = var50.onBuyMoreRobuxCardPrimaryAction
    tbl7.buyMoreRobuxCardSecondaryActionText = var50.buyMoreRobuxCardSecondaryActionText
    tbl7.onBuyMoreRobuxCardSecondaryAction = var50.onBuyMoreRobuxCardSecondaryAction
    tbl7.adUpsellCards = var52.adUpsellCards
    tbl7.adUpsellCongratsAnchorIndex = var52.adUpsellCongratsAnchorIndex
    tbl7.adUpsellFreePromotionsRemaining = var52.adUpsellFreePromotionsRemaining
    tbl7.isAdUpsellCreatePending = var52.isAdUpsellCreatePending
    tbl7.isAdUpsellCreateDisabled = bool5
    tbl7.isAdCampaignSheetOpen = var52.isAdCampaignSheetOpen
    tbl7.hasAdCampaignCreateError = var52.hasAdCampaignCreateError
    tbl7.adCampaignCreateErrorKind = var52.adCampaignCreateErrorKind
    tbl7.adCampaignDurationDays = var52.adCampaignDurationDays
    tbl7.adCampaignEstimatedPriceRobux = var52.adCampaignEstimatedPriceRobux
    tbl7.adCampaignOffers = var52.adCampaignOffers
    tbl7.adCampaignRunStartTimeMs = var52.adCampaignRunStartTimeMs
    tbl7.adCampaignRunEndTimeMs = var52.adCampaignRunEndTimeMs
    tbl7.isAdCampaignCreatedToastVisible = var52.isAdCampaignCreatedToastVisible
    tbl7.onAdCampaignCreatedToastDismiss = var52.onAdCampaignCreatedToastDismiss
    tbl7.onAdUpsellCreate = var52.onAdUpsellCreate
    tbl7.onAdUpsellDismiss = var52.onAdUpsellDismiss
    tbl7.onAdUpsellImpression = var52.onAdUpsellImpression
    tbl7.onAdCampaignSheetClose = var52.onAdCampaignSheetClose
    tbl7.onAdCampaignSheetCreate = var52.onAdCampaignSheetCreate
    tbl7.isAgentAdCampaignSheetOpen = var53.isSheetOpen
    tbl7.isAgentAdCampaignCreatePending = var53.isCreatePending
    tbl7.hasAgentAdCampaignCreateError = var53.hasCreateError
    tbl7.agentAdCampaignCreateErrorKind = var53.createErrorKind
    tbl7.agentAdCampaignOffers = var53.campaignOffers
    tbl7.agentAdCampaignRunStartTimeMs = var53.runStartTimeMs
    tbl7.onAgentAdCampaignOfferSelected = var53.onOfferSelected
    tbl7.getAgentAdCampaignCardState = var53.getCardState
    tbl7.isAgentAdCampaignCreateDisabled = if bool5 then tbl3.isCreateDisabled else var53.isCreateDisabled

    tbl7.agentAdCampaignAttemptedOption = var53.attemptedOption
    if bool5 then
        var49 = nil
    end

    tbl7.onAgentAdCampaignActive = var49
    tbl7.onAgentAdCampaignSheetClose = var53.onSheetClose
    tbl7.onAgentAdCampaignSheetCreate = var53.onSheetCreate
    tbl7.isAdUpsellVisible = tbl4.isFocused ~= false
    tbl7.isChatEmpty = isChatEmpty
    tbl7.isHistoryLoading = var41.isHistoryLoading or var32
    tbl7.isNewGameTarget = bool1
    tbl7.hasPublishedTurn = var41.hasPublishedTurn
    tbl7.hasPublishedVersion = not (var2 == nil) and var2.isActive
    tbl7.hasTaskGroups = hasTaskGroups
    tbl7.taskState = subagentTaskState
    tbl7.scrollingFrameRef = var41.setScrollingFrame
    tbl7.anchorScrollToInstance = var41.anchorScrollToInstance
    tbl7.onChatViewportChanged = onChatViewportChanged
    tbl7.isChatScrollable = isChatScrollable
    tbl7.modelPicker = modelPicker
    tbl7.composerText = var41.composerText
    tbl7.composerErrorText = var41.composerErrorText
    tbl7.onComposerChanged = onComposerChanged
    tbl7.promptChips = promptChips
    tbl7.isPromptChipsLoading = isPromptChipsLoading
    tbl7.onPromptChipActivated = onPromptChipActivated
    tbl7.onPromptChipExhausted = onPromptChipExhausted
    tbl7.composerImages = var41.composerImages
    tbl7.onComposerImagesChanged = var41.setComposerImages
    tbl7.onRetryComposerImage = var41.retryComposerImage
    tbl7.composerResourceAttachments = var41.composerResourceAttachments
    tbl7.onRemoveComposerResourceAttachment = var41.removeComposerResourceAttachmentAtIndex
    tbl7.isComposerSendBlocked = var41.isComposerSendBlocked
    tbl7.textBoxRef = var41.textBoxRef
    tbl7.isAssistantResponding = var41.isAssistantResponding
    tbl7.canStopAssistantResponse = var41.canStopAssistantResponse
    tbl7.canSendWhileResponding = var41.canSendWhileResponding
    tbl7.isChatReadOnly = bool2
    tbl7.chatPermissions = var31
    tbl7.onSend = var41.sendMessage
    tbl7.onStop = var41.stopAssistantResponse
    tbl7.statusChipGap = var1.Gap.Small
    tbl7.paddingBottom = var1.Padding.Small + var30
    return tbl7
end

return useBuildChatPageViewModel
