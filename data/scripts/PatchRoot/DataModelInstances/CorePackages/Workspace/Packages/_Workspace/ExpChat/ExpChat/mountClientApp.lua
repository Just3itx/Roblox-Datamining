-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Promise = require(ExpChatParent.Promise)
local Roact = require(ExpChatParent.Roact)
local UIBlox = require(ExpChatParent.UIBlox)
local ColorMode = require(ExpChatParent.Foundation).Enums.ColorMode
local Dictionary = require(ExpChatParent.llama).Dictionary
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local NotificationModalsManager = require(ExpChatParent.NotificationModalsManager)
local SharedFlags = require(ExpChatParent.SharedFlags)
local Signals = require(ExpChatParent.Signals)
local AmpUpsell = require(ExpChatParent.AmpUpsell)
local AmpApiProvider = AmpUpsell.AmpApiProvider
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum

local GetAdorneeStore = require(ExpChat.Stores.GetAdorneeStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetCharacterStore = require(ExpChat.Stores.GetCharacterStore)
local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)
local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local GetChatModerationStore = require(ExpChat.Stores.GetChatModerationStore)
local GetUserChatSettingsStore = require(ExpChat.Stores.GetUserChatSettingsStore)
local GetGlobalMutedUsersStore = require(ExpChat.Stores.GetGlobalMutedUsersStore)
local DictationSafetyReminder = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.DictationSafetyReminder)
local DictationRateLimit = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.DictationRateLimit)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)
local GetChatWindowStatusStore = require(ExpChat.Stores.GetChatWindowStatusStore)
local initializePresetChat = require(ExpChat.PresetChat.initializePresetChat)
local isMessageForOpenChannel = require(ExpChat.isMessageForOpenChannel)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatPresetChatLoadTestEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatLoadTestEnabled
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore
local getFFlagExpChatProtectedChatInternalAPIs = SharedFlags.getFFlagExpChatProtectedChatInternalAPIs
local FFlagExpChatDictationContinuousSafetyReminder = SharedFlags.FFlagExpChatDictationContinuousSafetyReminder
local FFlagExpChatDictationStopOnRateLimit = require(ExpChat.Flags.FFlagExpChatDictationStopOnRateLimit)
local FFlagExpChatInitializeWindowFromGameSettings = SharedFlags.FFlagExpChatInitializeWindowFromGameSettings

local FFlagExpChatUseProximityStore = SharedFlags.FFlagExpChatUseProximityStore
local GetProximityStore = if FFlagExpChatUseProximityStore then require(ExpChat.Stores.GetProximityStore) else nil
local Analytics = ExpChatShared.Analytics
local countParticipantsInTextChannel = ExpChatShared.countParticipantsInTextChannel

local App = require(script.Parent.App)

local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

local createDispatchBindableEvent = require(script.Parent.createDispatchBindableEvent)
local bindableEventQueue = require(ExpChat.Events.bindableEventQueue)
local createStore = require(script.Parent.createStore)
local GetNameColor = require(script.Parent.GetNameColor)
local reportMessageReceived = require(script.Parent.reportMessageReceived)
local canPlatformEnableChat = require(script.Parent.canPlatformEnableChat)
local watchForErrors = ExpChatShared.watchForErrors

local Commands = ExpChatShared.Commands

local Actions = ExpChat.Actions
local MarkChannelUnreadForIncomingMessage = require(Actions.MarkChannelUnreadForIncomingMessage)
local MarkChannelUnreadForSystemMessage = require(Actions.MarkChannelUnreadForSystemMessage)
local TextChannelCreated = ExpChatShared.Actions.TextChannelCreated
local TextChannelRemoved = ExpChatShared.Actions.TextChannelRemoved
local PlayerAdded = ExpChatShared.Actions.PlayerAdded
local PlayerRemoved = ExpChatShared.Actions.PlayerRemoved
local CharacterAdded = ExpChatShared.Actions.CharacterAdded
local LocalCharacterLoaded = ExpChatShared.Actions.LocalCharacterLoaded
local LocalTeamChanged = ExpChatShared.Actions.LocalTeamChanged
local ClientAppLoaded = ExpChatShared.Actions.ClientAppLoaded
local LastInputTypeChanged = require(Actions.LastInputTypeChanged)
local ChatTopBarButtonActivated = require(Actions.ChatTopBarButtonActivated)
local CommandAliasChanged = ExpChatShared.Actions.CommandAliasChanged
local HumanoidDied = require(Actions.HumanoidDied)
local AdorneeAdded = require(Actions.AdorneeAdded)
local LegacyBubbleChatEnabledChanged = require(Actions.LegacyBubbleChatEnabledChanged)
local LegacyBubbleChatSettingsChanged = require(Actions.LegacyBubbleChatSettingsChanged)
local LocalTextChannelParticipantAdded = require(Actions.LocalTextChannelParticipantAdded)
local LocalTextChannelParticipantRemoved = ExpChatShared.Actions.LocalTextChannelParticipantRemoved
local UniverseChatChannelAdded = require(Actions.UniverseChatChannelAdded)
local UniverseChatChannelSelected = ExpChatShared.Actions.UniverseChatChannelSelected

local displaySystemMessage = require(ExpChat.displaySystemMessage)
local sanitizeForRichText = require(ExpChat.sanitizeForRichText)
local generateRichSystemMessageTextFormat = require(ExpChat.generateRichSystemMessageTextFormat)
local summaryMessageRichText = require(ExpChat.summaryMessageRichText)
local TextChatMessageChatActionType = require(ExpChat.TextChatMessageChatActionType)
local getExperienceChatVisualConfig = require(ExpChat.getExperienceChatVisualConfig)
local getOtherDisplayNameInWhisperChannel = require(ExpChat.getOtherDisplayNameInWhisperChannel)
local handleChannelWelcomeMessage = require(ExpChat.handleChannelWelcomeMessage)
local isPlayerVerified = require(ExpChat.isPlayerVerified)
local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local isUserChatEnabled = require(ExpChat.isUserChatEnabled)
local canOnlyChatInRegion = require(ExpChat.canOnlyChatInRegion)
local shouldSendHighFrequencyTelemetry = require(ExpChat.shouldSendHighFrequencyTelemetry)
local shouldShowFOMOUpsell = require(ExpChat.shouldShowFOMOUpsell)
local shouldShowCrossAgeChatActivity = require(ExpChat.shouldShowCrossAgeChatActivity)
local shouldSuppressUnreadForTabMetadata = require(ExpChat.shouldSuppressUnreadForTabMetadata)
local ExpChatPerfTracker = require(ExpChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker
local connectHistoryReplay = require(ExpChat.connectHistoryReplay)
local createHistoryReplayReporter = require(ExpChat.createHistoryReplayReporter)
local isHistoricalMessage = require(ExpChat.isHistoricalMessage)
local whenFirstTrue = require(ExpChat.whenFirstTrue)
local whenPresetAccessKnown = require(script.helpers.whenPresetAccessKnown)
local prefixWithPresetIcon = require(script.helpers.prefixWithPresetIcon)
local getChannelsWithKeptHistory = require(ExpChat.getChannelsWithKeptHistory)
local FFlagExpChatPerfTrackerTabName = require(ExpChatParent.ChatUIPrimitives).Flags.FFlagExpChatPerfTrackerTabName
local selectSelectedTabName = require(ExpChat.selectSelectedTabName)

local Flags = ExpChat.Flags

local getEngineFeatureFlagEnableDisplayBubble = require(Flags.getEngineFeatureFlagEnableDisplayBubble)
local getFFlagUnreduxLastInputTypeChanged = require(Flags.getFFlagUnreduxLastInputTypeChanged)
local getFFlagUseCharacterStore = ExpChatShared.Flags.getFFlagUseCharacterStore

local GetFFlagExpChatSuppressWelcomeMessageTabUnread = ExpChatShared.Flags.GetFFlagExpChatSuppressWelcomeMessageTabUnread
local getFFlagExpChatTelemetryEventTrigger = require(ExpChat.Flags.getFFlagExpChatTelemetryEventTrigger)
local FFlagExpChatWindowStatusEventFixes = require(Flags.FFlagExpChatWindowStatusEventFixes)
local throttlingPercentage = game:DefineFastInt("ExpChatMessageResponseThrottlePermyriad", 0)
local num2 = game:DefineFastInt("ExpChatMessageResponseUserSamplePermyriad", 0)

local num3 = game:DefineFastInt("ExpChatHiddenMessagesPromptThresholdLowerBound", 10)

local num4 = game:DefineFastInt("ExpChatHiddenMessagesPromptThresholdUpperBound", 45)
local FFlagExpChatEnableFOMOUpsell = require(Flags.FFlagExpChatEnableFOMOUpsell)
local FFlagExpChatClearHiddenMessagesPostAgeCheck = require(Flags.FFlagExpChatClearHiddenMessagesPostAgeCheck)
local FFlagEnableInExpChatSummaryOnLua = require(Flags.FFlagEnableInExpChatSummaryOnLua)
local FFlagExpChatEnableCrossAgeChatActivity = require(Flags.FFlagExpChatEnableCrossAgeChatActivity)
local FFlagExpChatUnreadTabIndicatorV2Window = require(Flags.FFlagExpChatUnreadTabIndicatorV2Window)
local bool1 = game:DefineFastFlag("ExpChatOnlyWakeTextForSelectedTab", false)
local FFlagExpChatFixOutgoingUniverseChatBubble = require(Flags.FFlagExpChatFixOutgoingUniverseChatBubble)
local FFlagExpChatHistoricalMessagesUnibarUnread = SharedFlags.FFlagExpChatHistoricalMessagesUnibarUnread
local FFlagExpChatRenderHistoricalMessages = SharedFlags.FFlagExpChatRenderHistoricalMessages
local FFlagExpChatReportHistoryReplayed = SharedFlags.FFlagExpChatReportHistoryReplayed
local FFlagExpChatUseAdorneeStore = SharedFlags.FFlagExpChatUseAdorneeStore
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagEnableModerateChatRemoteEvent = SharedFlags.FFlagEnableModerateChatRemoteEvent
local FFlagLuaSupportMicroGamepadPreferredInput = SharedFlags.FFlagLuaSupportMicroGamepadPreferredInput
local FFlagEnableClientSummarySystemMessageOnLua = SharedFlags.FFlagEnableClientSummarySystemMessageOnLua
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local bool2 = game:DefineFastFlag("ExpChatRemoveSpaceFromTeamPrefix", false)
local FFlagAIRephraseSettingEnabled = SharedFlags.FFlagAIRephraseSettingEnabled
local FFlagChatSummariesSettingEnabled = SharedFlags.FFlagChatSummariesSettingEnabled
local FFlagEnableGlobalChat3pSummaryLuaApps = require(Flags.FFlagEnableGlobalChat3pSummaryLuaApps)
local FFlagExpChatEnableGlobalChatSummarySystemMessage = require(Flags.FFlagExpChatEnableGlobalChatSummarySystemMessage)
local bool3 = game:DefineFastFlag("ExpChatSuppressGlobalSummaryTabUnread", false)
local FFlagExpChatRefactorEnabledMessageLogic = require(Flags.FFlagExpChatRefactorEnabledMessageLogic)
local FFlagExpChatMEUpdatedSystemMessage = require(Flags.FFlagExpChatMEUpdatedSystemMessage)
local FFlagExpChatVirtualizeSystemMessages = require(Flags.FFlagExpChatVirtualizeSystemMessages)
local FStringExpChatChatWithTFAmpFeatureName = require(Flags.FStringExpChatChatWithTFAmpFeatureName)
local FStringExpChatChatWithTFAmpNameSpace = require(Flags.FStringExpChatChatWithTFAmpNameSpace)

local ExpChatNewSystemMessagesExperimentation = require(ExpChatParent.SocialExperiments).ExpChatNewSystemMessagesExperimentation

local ExpChatGlobalTabDefaultExperimentation = require(ExpChatParent.SocialExperiments).ExpChatGlobalTabDefaultExperimentation
local isGlobalTabFirst = require(ExpChat.isGlobalTabFirst)
local getGlobalWelcomeMessageKey = require(ExpChat.getGlobalWelcomeMessageKey)
local FFlagExpChatGlobalTabDefault = require(Flags.FFlagExpChatGlobalTabDefault)
local FFlagExpChatStickyTabs = SharedFlags.FFlagExpChatStickyTabs
local StickyTabObserver = require(ExpChat.StickyTabs.StickyTabObserver)

function getChatTranslationEnabled()
    local success, result = pcall(function(): boolean
        return TextChatService.ChatTranslationEnabled
    end)

    return success and result
end

local tbl1 = {
    eventName = "MessageResponse",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 10, 8 },
    description = "When a client receives a text chat message through TextChatService.",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/message_response.proto"
}

local helpers = script.helpers
local setUpConfigurationObjects = require(helpers.setUpConfigurationObjects)
local setUpClientSettings = require(helpers.setUpClientSettings)
local waitForFirst = require(helpers.waitForFirst)
local shouldFilterGlobalMessage = require(helpers.shouldFilterGlobalMessage)
local hasUserSelectedTab = require(helpers.hasUserSelectedTab)
local writeVirtualSystemMessage = require(helpers.writeVirtualSystemMessage)
local shouldSkipHistoricalMessage = require(ExpChat.shouldSkipHistoricalMessage)

local context = ExpChatShared.context
local reportVersionLoaded = require(script.reportVersionLoaded)
local Version = ExpChatShared.Version
local AtomicBinding = require(ExpChat.AtomicBinding)
local ChatEnabledSystemMessage = require(script.SystemMessages.ChatEnabledSystemMessage)

local function watchPlayersService(arg1, arg2, arg3)
    var1:trace("Watching Players service")

    local tbl2 = {}
    local function onPlayerAdded(player: Player)
        var1:trace("Player added: {} {}", player.Name, tostring(player.UserId))

        local var2 = if isPlayerVerified(player) then true else nil
        arg2:dispatch(PlayerAdded(player.UserId, player.Name, player.DisplayName, var2))

        if player == Players.LocalPlayer then
            var1:trace("Found local player")

            player:GetPropertyChangedSignal("Team"):Connect(function()
                arg2:dispatch(LocalTeamChanged(player.Team))
            end)
        end

        local function getHumanoidBinding() -- Luacid: Inlined by compiler; 1 call site recovered
            return (AtomicBinding.new({
                humanoid = "Humanoid",
                humanoidRootPart = "HumanoidRootPart"
            }, function(arg4) -- name: dispatchBubbleChatAdornee
                local root = arg4.root
                local humanoid = arg4.humanoid
                local humanoidRootPart = arg4.humanoidRootPart

                if not (humanoid:IsA("Humanoid") and humanoidRootPart:IsA("BasePart")) then
                    return function() end
                end

                if root and humanoidRootPart and player.Character == root then
                    if FFlagExpChatUseAdorneeStore then
                        context.adorneeStore.handleAdorneeAdded(player.UserId, root, humanoid)
                    else
                        arg2:dispatch(AdorneeAdded(player.UserId, root, humanoid))
                    end
                end

                local connection = humanoid.Died:Connect(function()
                    if FFlagExpChatUseAdorneeStore then
                        context.adorneeStore.handleHumanoidDied(player.UserId)
                        return
                    end
                    arg2:dispatch(HumanoidDied(player.UserId))
                end)

                local function disconnectHumanoidDied()
                    if connection then
                        connection:Disconnect()
                    end
                end

                return disconnectHumanoidDied
            end))
        end

        local humanoidBinding = getHumanoidBinding()

        local function onCharacterAdded(character: Model)
            if not character.Parent then
                waitForFirst(character.AncestryChanged, player.CharacterAdded)
            end
            if player.Character ~= character or not character.Parent then
                var1:debug("Mismatched or unparented character in onCharacterAdded for {}", tostring(player.UserId))
                return
            end

            if player == Players.LocalPlayer then
                var1:debug("Local character loaded: {}", character.Name)
                arg2:dispatch(LocalCharacterLoaded(character))
            end

            if getFFlagUseCharacterStore() then
                context.characterStore.handleCharacterAdded(player.UserId, character)
            else
                arg2:dispatch(CharacterAdded(player.UserId, character))
            end
            humanoidBinding:bindRoot(character)
        end

        local function onCharacterRemoving(character: Model)
            humanoidBinding:unbindRoot(character)
        end

        if player.Character then
            onCharacterAdded(player.Character)
        end

        local connection = player.CharacterAdded:Connect(onCharacterAdded)
        local connection2 = player.CharacterRemoving:Connect(onCharacterRemoving)

        if not tbl2[player.UserId] then
            tbl2[player.UserId] = { connection, connection2 }
        end
    end

    local function onNewPlayerAdded(player: Player)
        onPlayerAdded(player)

        if not Players.LocalPlayer then
            return
        end

        Promise.try(function(): boolean
            return player:IsFriendsWithAsync(Players.LocalPlayer.UserId)
        end):andThen(function(arg4)
            if arg4 then
                displaySystemMessage(
                    "InGame.UnknownNamespace.GameChat.FriendChatNotifier.JoinMessage",
                    {
                        RBX_NAME = player.DisplayName
                    },
                    "Roblox.Notification.Friend.Joined",
                    arg1.translator,
                    arg1.defaultSystemTextChannel
                )
            end
        end):catch(function(arg4)
            var1:error("Could not fetch friendship status. Error: {}", tostring(arg4))
        end)
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player:IsA("Player") then
            onPlayerAdded(player)
        end
    end
    Players.PlayerAdded:Connect(onNewPlayerAdded)

    Players.PlayerRemoving:Connect(function(player: Player)
        var1:trace("Player removed: {} {}", player.Name, tostring(player.UserId))

        if FFlagExpChatWindowStatusEventFixes and player == Players.LocalPlayer then
            local var2, var3 = GetChatWindowStatusStore(false).flushFinalDuration(os.clock())
            if var3 then
                TextChatService:SendExpChatWindowStatusChange(
                    var2.closedDuration,
                    var2.openDuration,
                    var2.backgroundIdleDuration,
                    var2.textIdleDuration
                )
            end
        end

        arg2:dispatch(PlayerRemoved(player.UserId))

        arg3.handlePlayerRemoved(player.UserId)

        if FFlagExpChatUseAdorneeStore then
            context.adorneeStore.handlePlayerRemoved(player.UserId)
        end

        if getFFlagUseCharacterStore() then
            context.characterStore.handlePlayerRemoved(player.UserId)
        end

        local var2 = tbl2[player.UserId]
        if not var2 then
            return
        end

        for _, value in ipairs(var2) do
            value:Disconnect()
        end
        tbl2[player.UserId] = nil
    end)
end

local tbl2 = {
    canUserChatAsync = function(userId: number): boolean
        return Chat:CanUserChatAsync(userId)
    end
}

local function OnIncomingMessage(message: TextChatMessage): TextChatMessageProperties
    if getFFlagExpChatProtectedChatInternalAPIs() then
        var1:trace(
            "System OnIncomingMessage started: PrefixTextInternal: {} TextInternal: {}",
            message.PrefixTextInternal,
            message.TextInternal
        )
    else
        var1:trace("System OnIncomingMessage started: {} {}", message.PrefixText, message.Text)
    end
    local textChatMessageProperties = Instance.new("TextChatMessageProperties")
    local var2

    if FFlagEnableInExpChatSummaryOnLua then
        var2 = generateRichSystemMessageTextFormat(
            if getFFlagExpChatProtectedChatInternalAPIs() then message.TextInternal else message.Text,
            not not string.find(message.Metadata, "Error")
        )
    else
        var2 = string.format(
            "<font color=\"#%s\">%s</font>",
            if string.find(message.Metadata, "Error") then UIBlox.App.Style.Colors.Red:ToHex() else UIBlox.App.Style.Colors.LightGrey:ToHex(),
            if getFFlagExpChatProtectedChatInternalAPIs() then message.TextInternal else message.Text
        )
    end

    textChatMessageProperties.Text = var2

    var1:trace(
        "System OnIncomingMessage finished: {} {}",
        textChatMessageProperties.PrefixText,
        textChatMessageProperties.Text
    )
    return textChatMessageProperties
end

return function(tbl3)
    var1:trace("mountClientApp started")

    local var2 = Dictionary.join(tbl2, tbl3)
    local var3 = var2.textChatService or TextChatService

    local store = createStore()
    createDispatchBindableEvent(store)
    bindableEventQueue:flush()

    watchForErrors(game:GetService("ScriptContext"), var2.script, false)

    context.translator = var2.translator

    context.store = store

    if FFlagExpChatUseAdorneeStore then
        context.adorneeStore = GetAdorneeStore(false)
    end

    if FFlagExpChatUseProximityStore then
        context.proximityStore = GetProximityStore(false)
    end

    local messagesStore = GetMessagesStore(false)
    local channelTabsStore = if FFlagExpChatUseChannelTabsStore then GetChannelTabsStore(false) else nil
    local var4 = FFlagExpChatVirtualizeSystemMessages and messagesStore ~= nil
    local tbl4 = {
        messagesStore = messagesStore,
        channelTabsStore = channelTabsStore,
        store = store,
        suppressWelcomeMessageTabUnread = GetFFlagExpChatSuppressWelcomeMessageTabUnread(),
        resetTextTransparency = function(str1: string)
            if not bool1 or isMessageForOpenChannel(store:getState(), nil, str1) then
                GetTransparencyStore(false).resetTextTransparency()
            end
        end
    }
    local function showWelcomeSystemMessage(tbl5, textChannel)
        if not var4 then
            displaySystemMessage(tbl5.key, tbl5.args, tbl5.metadata, var2.translator, textChannel)
            return
        end

        if not textChannel then
            return
        end

        local success, result = pcall(function()
            return var2.translator:FormatByKey(tbl5.key, tbl5.args)
        end)
        if not success or type(result) ~= "string" or result == "" then
            return
        end
        writeVirtualSystemMessage(
            tbl4,
            {
                text = result,
                channelName = textChannel.Name,
                metadata = tbl5.metadata,
                textChannel = textChannel
            }
        )
    end

    local function showVirtualChatEnabledSystemMessage(str1: string, arg1, text: string)
        local defaultSystemTextChannel = var2.defaultSystemTextChannel
        if not defaultSystemTextChannel then
            return
        end
        local success, result = pcall(function()
            return var2.translator:FormatByKey(str1, arg1)
        end)
        if success and type(result) == "string" and result ~= "" then
            text = result
        end

        writeVirtualSystemMessage(tbl4, {
            text = text,
            channelName = "RBXGeneral",
            metadata = "Roblox.ChatEnabled.Info",
            textChannel = defaultSystemTextChannel
        })
    end

    local chatConfigurationStore = if FFlagExpChatUseChatConfigStore then GetChatConfigurationStore(false) else nil
    local chatStatusStore = GetChatStatusStore(false)

    context.messagesStore = messagesStore

    context.globalMutedUsersStore = GetGlobalMutedUsersStore(false)

    if getFFlagUseCharacterStore() then
        context.characterStore = GetCharacterStore(false)
    end

    if var2.analytics then
        Analytics.with(var2.analytics)
    end
    if not getFFlagUnreduxLastInputTypeChanged() then
        UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            store:dispatch(LastInputTypeChanged(lastInputType))
        end)
    end

    if var2.defaultSystemTextChannel then
        var2.defaultSystemTextChannel.OnIncomingMessage = OnIncomingMessage
    else
        Chat:GetPropertyChangedSignal("IsAutoMigrated"):Once(function()
            local rbxSystem = var3:FindFirstChild("RBXSystem", true)
            if rbxSystem and rbxSystem:IsA("TextChannel") then
                var2.defaultSystemTextChannel = rbxSystem
                rbxSystem.OnIncomingMessage = OnIncomingMessage
            end
        end)
    end

    setUpConfigurationObjects(store, var2)
    setUpClientSettings(store)
    if FFlagExpChatInitializeWindowFromGameSettings then
        store:dispatch(ChatTopBarButtonActivated(UserSettings().GameSettings.ChatVisible))
    end

    local localPlayer = Players.LocalPlayer
    if localPlayer then
        localPlayer:GetPropertyChangedSignal("Team"):Connect(function()
            local team = localPlayer.Team
            if team then
                displaySystemMessage(
                    "InGame.UnknownNamespace.GameChat_TeamChat_NowInTeam",
                    {
                        RBX_NAME = team.Name
                    },
                    "Roblox.Team.Success.NowInTeam",
                    var2.translator,
                    var2.defaultSystemTextChannel
                )
            end
        end)
    end

    local tbl5 = {
        [Enum.TextChatMessageStatus.Floodchecked] = {
            key = "CoreScripts.TextChat.MessageStatus.Warning.Floodchecked",
            metadata = "Roblox.MessageStatus.Warning.Floodchecked"
        },
        [Enum.TextChatMessageStatus.TextFilterFailed] = {
            key = "CoreScripts.TextChat.MessageStatus.Warning.TextFilterFailed",
            metadata = "Roblox.MessageStatus.Warning.TextFilterFailed"
        },
        [Enum.TextChatMessageStatus.InvalidPrivacySettings] = {
            key = "CoreScripts.TextChat.MessageStatus.Warning.InvalidPrivacySettings",
            metadata = "Roblox.MessageStatus.Warning.InvalidPrivacySettings"
        },
        [Enum.TextChatMessageStatus.MessageTooLong] = {
            key = "CoreScripts.TextChat.MessageStatus.Warning.MessageTooLong",
            metadata = "Roblox.MessageStatus.Warning.MessageTooLong"
        },
        [Enum.TextChatMessageStatus.ModerationTimeout] = {
            key = "CoreScripts.TextChat.MessageStatus.Warning.ModerationTimeout",
            metadata = "Roblox.MessageStatus.Warning.ModerationTimeout"
        },
        [Enum.TextChatMessageStatus.Unknown] = {
            key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
            metadata = "Roblox.MessageStatus.Warning.Unknown"
        }
    }

    local function processHistoricalMessage(arg1, str1: string?, bool4: boolean?) -- Luacid: Inlined by compiler; 2 call sites recovered
        local bool5 = not (localPlayer == nil or arg1.TextSource == nil) and arg1.TextSource.UserId == localPlayer.UserId
        messagesStore.handleIncomingOrOutgoingMessage(arg1, bool5, str1, bool4, true)
    end

    local function _processIncomingMessageCore(arg1, str1: string?, bool4: boolean?)
        if FFlagExpChatRenderHistoricalMessages and isHistoricalMessage(arg1) then
            processHistoricalMessage(arg1, str1, bool4)
            return
        end

        if shouldSkipHistoricalMessage(arg1) then
            return
        end

        if getFFlagExpChatProtectedChatInternalAPIs() then
            var1:debug("Incoming MessageReceived Status: {} TextInternal: {}", arg1.Status.Name, arg1.TextInternal)
        else
            var1:debug("Incoming MessageReceived Status: {} Text: {}", arg1.Status.Name, arg1.Text)
        end

        if (arg1.TextSource and arg1.TextSource.UserId or "UNKNOWN_TEXT_SOURCE_USER_ID") ~= (localPlayer and localPlayer.UserId or "UNKNOWN_LOCAL_USER_ID") then
            ExpChatPerfTracker.start(
                ExpChatPerfTracker.Events.MessageReceiveToWindowRenderInterval,
                {
                    messageId = arg1.MessageId
                },
                FFlagExpChatPerfTrackerTabName and {
                    tabName = selectSelectedTabName(store:getState())
                } or nil
            )
        end
        if localPlayer then
            reportMessageReceived(localPlayer.UserId, arg1)
        end

        if localPlayer and arg1.TextSource and arg1.TextSource.UserId ~= localPlayer.UserId then
            local var5 = handleChannelWelcomeMessage(arg1, localPlayer)
            if var5 then
                showWelcomeSystemMessage(var5, arg1.TextChannel)
            end
        end

        local var5 = localPlayer and arg1.TextSource and arg1.TextSource.UserId == localPlayer.UserId

        local var6 = not bool1 or isMessageForOpenChannel(store:getState(), arg1, str1)

        messagesStore.handleIncomingOrOutgoingMessage(arg1, var5, str1, bool4)

        if var6 then
            GetTransparencyStore(false).resetTextTransparency()
        end

        if FFlagExpChatUseChannelTabsStore and channelTabsStore then
            channelTabsStore.handleIncomingOrOutgoingMessage(arg1, var5, str1)
        elseif FFlagExpChatUnreadTabIndicatorV2Window then
            store:dispatch(MarkChannelUnreadForIncomingMessage(arg1, var5, str1, bool4))
        end

        local var7 = tbl5[arg1.Status]
        local var8 = nil
        if FFlagExpChatDictationStopOnRateLimit and DictationRateLimit.onIncomingMessage(arg1, localPlayer and localPlayer.UserId) then
            local stoppedMessage = DictationRateLimit.getStoppedMessage(var2.translator)
            if stoppedMessage ~= "" then
                var8 = stoppedMessage
            end
        end

        if var7 then
            local result, success

            if FFlagExpChatDictationStopOnRateLimit then
                if var8 then
                    result = var8
                    success = true
                else
                    success, result = pcall(function()
                        return var2.translator:FormatByKey(var7.key)
                    end)
                end
            else
                success, result = pcall(function()
                    return var2.translator:FormatByKey(var7.key)
                end)
            end
            if str1 and success and result and result ~= "" then
                messagesStore.addSystemMessage(
                    result,
                    str1,
                    if GetFFlagExpChatSuppressWelcomeMessageTabUnread() then var7.metadata else nil
                )

                if FFlagExpChatUseChannelTabsStore
                    and channelTabsStore
                    and not (GetFFlagExpChatSuppressWelcomeMessageTabUnread() and shouldSuppressUnreadForTabMetadata(var7.metadata))
                then
                    channelTabsStore.markChannelUnread(str1)
                elseif FFlagExpChatUnreadTabIndicatorV2Window then
                    local var9 = store
                    local var10 = MarkChannelUnreadForSystemMessage
                    local metadata = if GetFFlagExpChatSuppressWelcomeMessageTabUnread() then var7.metadata else nil
                    var9:dispatch(var10(result, str1, metadata))
                end
            else
                local defaultSystemTextChannel = var2.defaultSystemTextChannel
                if str1 then
                    local var9 = var3:FindFirstChild(str1)
                    if var9 and var9:IsA("TextChannel") then
                        defaultSystemTextChannel = var9
                    end
                end

                if FFlagExpChatDictationStopOnRateLimit then
                    if var8 and defaultSystemTextChannel then
                        defaultSystemTextChannel:DisplaySystemMessage(sanitizeForRichText(var8), var7.metadata)
                    else
                        displaySystemMessage(var7.key, nil, var7.metadata, var2.translator, defaultSystemTextChannel)
                    end
                else
                    displaySystemMessage(var7.key, nil, var7.metadata, var2.translator, defaultSystemTextChannel)
                end
            end
        end

        if not shouldSendHighFrequencyTelemetry(num2) then
            return
        end

        Analytics:TelemetryLogEvent(
            tbl1,
            {
                messageStatus = arg1.Status.Name
            },
            {
                "addOsInfo",
                "addSessionId",
                "addUniverseId",
                "addPlaceId"
            }
        )
    end

    local function processIncomingMessage(arg1, str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
        _processIncomingMessageCore(arg1, str1, nil)
    end

    local function processIncomingMessageWithOptions(textChatMessage: TextChatMessage, tbl6) -- Luacid: Inlined by compiler; 2 call sites recovered
        _processIncomingMessageCore(textChatMessage, tbl6 and tbl6.channelNameOverride, tbl6 and tbl6.isUniverseChat)
    end

    local function handleMessageReceived(arg1)
        store:dispatch(TextChannelCreated(arg1))

        local enabled = false
        local channelTabsConfiguration = var3:FindFirstChildOfClass("ChannelTabsConfiguration")
        if channelTabsConfiguration then
            enabled = channelTabsConfiguration.Enabled
        end

        if string.find(arg1.Name, "RBXGeneral") then
            function arg1.OnIncomingMessage(arg2): TextChatMessageProperties
                local textChatMessageProperties = Instance.new("TextChatMessageProperties")

                if arg2.TextSource then
                    local nameColor = GetNameColor(arg2.TextSource.UserId)
                    if not arg2.ChatWindowMessageProperties then
                        local var5 = if getFFlagExpChatProtectedChatInternalAPIs() then arg2.PrefixTextInternal else arg2.PrefixText
                        textChatMessageProperties.PrefixText = string.format("<font color=\"#%s\">%s</font>", nameColor:ToHex(), var5)
                    end
                end

                return textChatMessageProperties
            end
        elseif string.find(arg1.Name, "^RBXTeam") then
            function arg1.OnIncomingMessage(arg2): TextChatMessageProperties
                local var5 = if getFFlagExpChatProtectedChatInternalAPIs() then arg2.PrefixTextInternal else arg2.PrefixText

                if getFFlagExpChatProtectedChatInternalAPIs() then
                    var1:trace("Team OnIncomingMessage started: PrefixTextInternal: {} TextInternal: {}", var5, arg2.TextInternal)
                else
                    var1:trace("Team OnIncomingMessage started: {} {}", var5, arg2.Text)
                end
                local textChatMessageProperties = Instance.new("TextChatMessageProperties")

                if Players.LocalPlayer then
                    local teamColorColor = Players.LocalPlayer.TeamColor.Color

                    local str1 = not bool2 and (if enabled then "" else "[Team] ")
                        or (if enabled then "" elseif #(var5 or "") > 0 then "[Team] " else "[Team]")

                    textChatMessageProperties.PrefixText = string.format("<font color=\"#%s\">%s%s</font>", teamColorColor:ToHex(), str1, var5)
                end

                var1:trace(
                    "Team OnIncomingMessage finished: {} {}",
                    textChatMessageProperties.PrefixText,
                    textChatMessageProperties.Text
                )
                return textChatMessageProperties
            end
        elseif string.find(arg1.Name, "^RBXWhisper") and localPlayer then
            function arg1.OnIncomingMessage(arg2)
                local textSource = arg2.TextSource
                if textSource then
                    local rbxName = getOtherDisplayNameInWhisperChannel(arg1, localPlayer)
                    if rbxName then
                        local var5 = if enabled then nil elseif textSource.UserId == localPlayer.UserId then var2.translator:FormatByKey("CoreScripts.TextChat.WhisperChat.PrefixText.Outgoing", { RBX_NAME = rbxName }) else var2.translator:FormatByKey("CoreScripts.TextChat.WhisperChat.PrefixText.Incoming", { RBX_NAME = rbxName })
                        local textChatMessageProperties = Instance.new("TextChatMessageProperties")
                        local nameColor = GetNameColor(textSource.UserId)
                        textChatMessageProperties.PrefixText = string.format(
                            "%s<font color=\"#%s\">%s</font>",
                            if var5 then var5 .. " " else "",
                            nameColor:ToHex(),
                            if getFFlagExpChatProtectedChatInternalAPIs() then arg2.PrefixTextInternal else arg2.PrefixText
                        )

                        return textChatMessageProperties
                    end
                end
                return nil
            end
        end

        arg1.MessageReceived:Connect(function(arg2)
            if shouldSkipHistoricalMessage(arg2) then
                return
            end
            if FFlagExpChatDictationContinuousSafetyReminder then
                DictationSafetyReminder.onIncomingMessage(arg2)
            end
            if GetFFlagTextChatEnableUniverseChatTabs() then
                processIncomingMessage(arg2, nil)
                return
            end

            if getFFlagExpChatProtectedChatInternalAPIs() then
                var1:debug("Incoming MessageReceived Status: {} TextInternal: {}", arg2.Status.Name, arg2.TextInternal)
            else
                var1:debug("Incoming MessageReceived Status: {} Text: {}", arg2.Status.Name, arg2.Text)
            end

            if (arg2.TextSource and arg2.TextSource.UserId or "UNKNOWN_TEXT_SOURCE_USER_ID") ~= (localPlayer and localPlayer.UserId or "UNKNOWN_LOCAL_USER_ID") then
                ExpChatPerfTracker.start(
                    ExpChatPerfTracker.Events.MessageReceiveToWindowRenderInterval,
                    {
                        messageId = arg2.MessageId
                    },
                    FFlagExpChatPerfTrackerTabName and {
                        tabName = selectSelectedTabName(store:getState())
                    } or nil
                )
            end

            if localPlayer then
                reportMessageReceived(localPlayer.UserId, arg2)
            end

            if localPlayer and arg2.TextSource and arg2.TextSource.UserId ~= localPlayer.UserId then
                local var5 = handleChannelWelcomeMessage(arg2, localPlayer)
                if var5 then
                    showWelcomeSystemMessage(var5, arg2.TextChannel)
                end
            end

            local var5 = localPlayer and arg2.TextSource and arg2.TextSource.UserId == localPlayer.UserId

            messagesStore.handleIncomingOrOutgoingMessage(arg2, var5)
            GetTransparencyStore(false).resetTextTransparency()

            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                channelTabsStore.handleIncomingOrOutgoingMessage(arg2, var5)
            elseif FFlagExpChatUnreadTabIndicatorV2Window then
                store:dispatch(MarkChannelUnreadForIncomingMessage(arg2, var5))
            end

            if arg2.Status == Enum.TextChatMessageStatus.Floodchecked then
                if FFlagExpChatDictationStopOnRateLimit then
                    local var6 = nil
                    if DictationRateLimit.onIncomingMessage(arg2, localPlayer and localPlayer.UserId) then
                        local stoppedMessage = DictationRateLimit.getStoppedMessage(var2.translator)
                        if stoppedMessage ~= "" then
                            var6 = stoppedMessage
                        end
                    end

                    if var6 and var2.defaultSystemTextChannel then
                        var2.defaultSystemTextChannel:DisplaySystemMessage(
                            sanitizeForRichText(var6),
                            "Roblox.MessageStatus.Warning.Floodchecked"
                        )
                    else
                        displaySystemMessage(
                            "CoreScripts.TextChat.MessageStatus.Warning.Floodchecked",
                            nil,
                            "Roblox.MessageStatus.Warning.Floodchecked",
                            var2.translator,
                            var2.defaultSystemTextChannel
                        )
                    end
                else
                    displaySystemMessage(
                        "CoreScripts.TextChat.MessageStatus.Warning.Floodchecked",
                        nil,
                        "Roblox.MessageStatus.Warning.Floodchecked",
                        var2.translator,
                        var2.defaultSystemTextChannel
                    )
                end
            elseif arg2.Status == Enum.TextChatMessageStatus.TextFilterFailed then
                displaySystemMessage(
                    "CoreScripts.TextChat.MessageStatus.Warning.TextFilterFailed",
                    nil,
                    "Roblox.MessageStatus.Warning.TextFilterFailed",
                    var2.translator,
                    var2.defaultSystemTextChannel
                )
            elseif arg2.Status == Enum.TextChatMessageStatus.InvalidPrivacySettings then
                displaySystemMessage(
                    "CoreScripts.TextChat.MessageStatus.Warning.InvalidPrivacySettings",
                    nil,
                    "Roblox.MessageStatus.Warning.InvalidPrivacySettings",
                    var2.translator,
                    var2.defaultSystemTextChannel
                )
            elseif arg2.Status == Enum.TextChatMessageStatus.MessageTooLong then
                displaySystemMessage(
                    "CoreScripts.TextChat.MessageStatus.Warning.MessageTooLong",
                    nil,
                    "Roblox.MessageStatus.Warning.MessageTooLong",
                    var2.translator,
                    var2.defaultSystemTextChannel
                )
            elseif arg2.Status == Enum.TextChatMessageStatus.ModerationTimeout then
                displaySystemMessage(
                    "CoreScripts.TextChat.MessageStatus.Warning.ModerationTimeout",
                    nil,
                    "Roblox.MessageStatus.Warning.ModerationTimeout",
                    var2.translator,
                    var2.defaultSystemTextChannel
                )
            elseif arg2.Status == Enum.TextChatMessageStatus.Unknown then
                displaySystemMessage(
                    "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                    nil,
                    "Roblox.MessageStatus.Warning.Unknown",
                    var2.translator,
                    var2.defaultSystemTextChannel
                )
            end
            if not shouldSendHighFrequencyTelemetry(num2) then
                return
            end

            Analytics:TelemetryLogEvent(
                tbl1,
                {
                    messageStatus = arg2.Status.Name
                },
                {
                    "addOsInfo",
                    "addSessionId",
                    "addUniverseId",
                    "addPlaceId"
                }
            )
        end)
    end

    local function watchTextChatCommand(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        arg1.Triggered:Connect(function()
            Analytics.FireClientAnalyticsWithEventName("CommandSent", { commandName = arg1.Name })
        end)
    end

    for _, descendant in pairs(var3:GetDescendants()) do
        if descendant:IsA("TextChannel") then
            handleMessageReceived(descendant)
        elseif descendant:IsA("TextChatCommand") then
            watchTextChatCommand(descendant)
        end
    end

    local bool4 = false
    local bool5 = false
    local tbl6 = {}

    local bool6 = false
    local function tryLogExposureNewSystemMessages() -- Luacid: Inlined by compiler; 6 call sites recovered
        if not ExpChatNewSystemMessagesExperimentation.isExperimentEnabled or bool6 then
            return
        end

        bool6 = true
        ExpChatNewSystemMessagesExperimentation.logExposure()
    end

    local function postProcessSummarySystemMessage(str1: string)
        return summaryMessageRichText.wrapInSummaryMutedStyle(`{summaryMessageRichText.getSummaryIconPrefix()} {str1}`)
    end

    local function tryShowSummarySystemMessageOnChannel(textChannel)
        if not textChannel or not bool4 or tbl6[textChannel.Name] or textChannel.Name ~= "RBXGeneral" then
            return
        end

        tbl6[textChannel.Name] = true

        if ExpChatNewSystemMessagesExperimentation.isExperimentEnabled then
            tryLogExposureNewSystemMessages()
        end

        if not var4 then
            displaySystemMessage(
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "CoreScripts.TextChat.Description.RobloxSummarizesMessagesFromAllPlayers" else "CoreScripts.TextChat.ChatWindow.SummarySystemMessage",
                nil,
                "Roblox.Summary.Info",
                var2.translator,
                textChannel,
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "Roblox summarizes messages from players of all ages." else "Roblox auto-generates summaries of players' messages.",
                postProcessSummarySystemMessage
            )
            return
        end

        local newSystemMessagesEnabled = ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled()
        local str1 = if newSystemMessagesEnabled then "CoreScripts.TextChat.Description.RobloxSummarizesMessagesFromAllPlayers" else "CoreScripts.TextChat.ChatWindow.SummarySystemMessage"

        local success, result = pcall(function()
            return var2.translator:FormatByKey(str1)
        end)
        local text = (not success or type(result) ~= "string" or result == "")
            and (if newSystemMessagesEnabled then "Roblox summarizes messages from players of all ages." else "Roblox auto-generates summaries of players' messages.")
            or result

        writeVirtualSystemMessage(tbl4, {
            text = text,
            channelName = textChannel.Name,
            metadata = "Roblox.Summary.Info",
            postProcessMessage = postProcessSummarySystemMessage,
            textChannel = textChannel
        })
    end

    local function tryAddThirdPartySummaryGlobalSystemMessage()
        if bool5
            or not (bool4
                and FFlagExpChatEnableGlobalChatSummarySystemMessage
                and GetFFlagTextChatEnableUniverseChatTabs()
                and var3:HasAllocatedUniverseChatContext("global"))
        then
            return
        end

        local var5 = var2.translator:FormatByKey("CoreScripts.TextChat.ChatWindow.SummarySystemMessage")

        local var6 = if bool3 then "Roblox.Summary.GlobalChat" else nil

        bool5 = true
        messagesStore.addSystemMessage(var5, "RBXGlobal", var6, postProcessSummarySystemMessage)
    end

    var3.DescendantAdded:Connect(function(descendant: Instance)
        if descendant:IsA("TextChannel") then
            handleMessageReceived(descendant)
            if FFlagEnableInExpChatSummaryOnLua and FFlagEnableClientSummarySystemMessageOnLua then
                tryShowSummarySystemMessageOnChannel(descendant)
            end
        elseif descendant:IsA("TextChatCommand") then
            watchTextChatCommand(descendant)
        end
    end)

    var3.DescendantRemoving:Connect(function(descendant: Instance)
        if not descendant:IsA("TextChannel") then
            return
        end

        store:dispatch(TextChannelRemoved(descendant))

        if FFlagExpChatUseChannelTabsStore and channelTabsStore then
            channelTabsStore.handleChannelRemoved(descendant.Name)
        end
    end)

    if FFlagEnableInExpChatSummaryOnLua then
        var3.ChatActionReceived:Connect(function(chatActionMessage: TextChatMessage)
            if getFFlagExpChatProtectedChatInternalAPIs() then
                var1:debug(
                    "Incoming ChatActionReceived ChatActionType: {}, TextInternal: {}",
                    chatActionMessage.ChatActionType,
                    chatActionMessage.TextInternal
                )
            else
                var1:debug(
                    "Incoming ChatActionReceived ChatActionType: {}, Text: {}",
                    chatActionMessage.ChatActionType,
                    chatActionMessage.Text
                )
            end

            if chatActionMessage.ChatActionType ~= TextChatMessageChatActionType.Summary then
                var1:error("Unknown ChatActionType: {}", chatActionMessage.ChatActionType)

                return
            end

            if not FFlagEnableGlobalChat3pSummaryLuaApps then
                processIncomingMessage(chatActionMessage, nil)
                return
            end

            processIncomingMessageWithOptions(
                chatActionMessage,
                chatActionMessage.TextChannel == nil and {
                    channelNameOverride = "RBXGlobal",
                    isUniverseChat = true
                } or nil
            )
        end)
    end

    if FFlagEnableInExpChatSummaryOnLua or FFlagAIRephraseSettingEnabled or FFlagChatSummariesSettingEnabled then
        coroutine.wrap(function()
            local expChatFeatureValueChanged = RobloxReplicatedStorage:WaitForChild("ExpChatFeatureValueChanged", 10)
            if not expChatFeatureValueChanged then
                return
            end

            expChatFeatureValueChanged.OnClientEvent:Connect(function(userId: number, str1: string, str2: string)
                var1:debug("Incoming ExpChatFeatureValueChanged userId: {}, featureName: {}, featureValue: {}", userId, str1, str2)

                if not localPlayer or userId ~= localPlayer.UserId then
                    return
                end
                if FFlagEnableClientSummarySystemMessageOnLua
                    and str1 == "EligibleForThirdPartySummary"
                    and not FFlagChatSummariesSettingEnabled
                then
                    bool4 = str2 == "true"
                    if bool4 then
                        for _, descendant in var3:GetDescendants() do
                            if descendant:IsA("TextChannel") then
                                tryShowSummarySystemMessageOnChannel(descendant)
                            end
                        end
                        tryAddThirdPartySummaryGlobalSystemMessage()
                    end
                end
                if FFlagAIRephraseSettingEnabled and str1 == "AIRephraseSettingStatus" then
                    GetUserChatSettingsStore.updateExpChatFeatureValue(str1, str2)
                end
                if not FFlagChatSummariesSettingEnabled or str1 ~= "AllowThirdPartySummary" then
                    return
                end

                GetUserChatSettingsStore.updateExpChatFeatureValue(str1, str2)
                bool4 = str2 == "Enabled"
                if not bool4 then
                    return
                end

                for _, descendant in var3:GetDescendants() do
                    if descendant:IsA("TextChannel") then
                        tryShowSummarySystemMessageOnChannel(descendant)
                    end
                end
                tryAddThirdPartySummaryGlobalSystemMessage()
            end)
        end)()
    end

    local function markChannelsUnreadForKeptHistory(tbl7)
        local getHistoricalWindowMessageCount = messagesStore.getHistoricalWindowMessageCount

        for value, value2 in (getChannelsWithKeptHistory(tbl7, if getHistoricalWindowMessageCount then getHistoricalWindowMessageCount(false) else 0)) do
            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                channelTabsStore.markChannelUnread(value)
            elseif FFlagExpChatUnreadTabIndicatorV2Window then
                store:dispatch(MarkChannelUnreadForIncomingMessage(value2, false))
            end
        end
    end

    if FFlagExpChatRenderHistoricalMessages then
        whenFirstTrue(messagesStore.getCanLocalUserChat, function()
            local historyReplayReporter = if FFlagExpChatReportHistoryReplayed then createHistoryReplayReporter({
                getHistoricalCount = messagesStore.getHistoricalWindowMessageCount and function()
                    return messagesStore.getHistoricalWindowMessageCount(false)
                end or nil
            }) else nil

            connectHistoryReplay(function(tbl7)
                messagesStore.batchWrites(function()
                    for _, value in tbl7 do
                        processHistoricalMessage(value, nil, nil)
                    end
                end)

                if FFlagExpChatHistoricalMessagesUnibarUnread then
                    markChannelsUnreadForKeptHistory(tbl7)
                end

                if historyReplayReporter then
                    historyReplayReporter(#tbl7)
                end
            end)
        end)
    end

    var3.SendingMessage:Connect(function(textChatMessage: TextChatMessage)
        if FFlagExpChatDictationContinuousSafetyReminder then
            DictationSafetyReminder.onOutgoingMessage(textChatMessage)
        end
        ExpChatPerfTracker.start(
            ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval,
            {
                messageId = textChatMessage.MessageId
            },
            FFlagExpChatPerfTrackerTabName and {
                tabName = selectSelectedTabName(store:getState())
            } or nil
        )

        if getFFlagExpChatProtectedChatInternalAPIs() then
            var1:debug(
                "Outgoing SendingMessage Status: {} TextInternal: {}",
                textChatMessage.Status.Name,
                textChatMessage.TextInternal
            )
        else
            var1:debug("Outgoing SendingMessage Status: {} Text: {}", textChatMessage.Status.Name, textChatMessage.Text)
        end

        if localPlayer then
            local var5 = handleChannelWelcomeMessage(textChatMessage, localPlayer)
            if var5 and var5.key then
                showWelcomeSystemMessage(var5, textChatMessage.TextChannel)
            end
        end

        messagesStore.handleIncomingOrOutgoingMessage(textChatMessage, true)

        local textChannel = textChatMessage.TextChannel
        if textChannel then
            Analytics.FireClientAnalyticsWithEventName(
                "MessageSent",
                {
                    channelName = textChannel.Name,
                    totalParticipants = countParticipantsInTextChannel(textChannel)
                }
            )
        end
    end)

    local function connectSendingUniverseChatMessage()
        if not GetFFlagTextChatEnableUniverseChatTabs() then
            return
        end
        var3.SendingUniverseChatMessage:Connect(function(textChatMessage: TextChatMessage)
            if FFlagExpChatDictationContinuousSafetyReminder then
                DictationSafetyReminder.onOutgoingMessage(textChatMessage)
            end
            ExpChatPerfTracker.start(
                ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval,
                {
                    messageId = textChatMessage.MessageId
                },
                FFlagExpChatPerfTrackerTabName and {
                    tabName = selectSelectedTabName(store:getState())
                } or nil
            )

            if getFFlagExpChatProtectedChatInternalAPIs() then
                var1:debug(
                    "Outgoing SendingMessage Status: {} TextInternal: {}",
                    textChatMessage.Status.Name,
                    textChatMessage.TextInternal
                )
            else
                var1:debug("Outgoing SendingMessage Status: {} Text: {}", textChatMessage.Status.Name, textChatMessage.Text)
            end

            if localPlayer then
                local var5 = handleChannelWelcomeMessage(textChatMessage, localPlayer)
                if var5 and var5.key then
                    showWelcomeSystemMessage(var5, textChatMessage.TextChannel)
                end
            end

            local chatInputBarConfiguration = var3:FindFirstChildOfClass("ChatInputBarConfiguration")
            local var5 = if chatInputBarConfiguration and chatInputBarConfiguration.TargetTextChannel then nil else "RBXGlobal"

            local var6 = if FFlagExpChatGlobalTabDefault and selectSelectedTabName(store:getState()) == "RBXGlobal" then "RBXGlobal" else var5

            messagesStore.handleIncomingOrOutgoingMessage(
                textChatMessage,
                true,
                var6,
                if FFlagExpChatFixOutgoingUniverseChatBubble then true else nil
            )

            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                channelTabsStore.handleIncomingOrOutgoingMessage(textChatMessage, true, var6)
            end

            local textChannel = textChatMessage.TextChannel
            if textChannel then
                Analytics.FireClientAnalyticsWithEventName(
                    "MessageSent",
                    {
                        channelName = textChannel.Name,
                        totalParticipants = countParticipantsInTextChannel(textChannel)
                    }
                )
            end
        end)
    end

    connectSendingUniverseChatMessage()

    if FFlagExpChatStickyTabs then
        StickyTabObserver:start(store)
    end

    local function isInstanceALocalTextChannelParticipant(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        return arg1 and arg1:IsA("TextSource") and Players.LocalPlayer and Players.LocalPlayer.UserId == arg1.UserId
    end

    local function getChannelTabIndex(str1: string): number -- Luacid: Inlined by compiler; 1 call site recovered
        return if str1 == "RBXGeneral" then 1 elseif str1 == "RBXGlobal" then 2 else 3
    end

    for _, descendant in pairs(var3:GetDescendants()) do
        if descendant.Parent and descendant.Parent:IsA("TextChannel") and isInstanceALocalTextChannelParticipant(descendant) then
            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                channelTabsStore.handleLocalTextChannelParticipantAdded(descendant.Parent)
            else
                store:dispatch(LocalTextChannelParticipantAdded(descendant.Parent))
            end
        end

        if not descendant:IsA("TextChannel") then
            continue
        end

        descendant.DescendantRemoving:Connect(function(descendant2: Instance)
            if not isInstanceALocalTextChannelParticipant(descendant2) then
                return
            end

            store:dispatch(LocalTextChannelParticipantRemoved(descendant))

            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                local descendantName = descendant.Name
                channelTabsStore.handleChannelRemoved(descendantName)
            end
        end)
    end

    var3.DescendantAdded:Connect(function(descendant: Instance)
        if descendant.Parent and descendant.Parent:IsA("TextChannel") and isInstanceALocalTextChannelParticipant(descendant) then
            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                channelTabsStore.handleLocalTextChannelParticipantAdded(descendant.Parent)
            else
                store:dispatch(LocalTextChannelParticipantAdded(descendant.Parent))
            end
        end

        if not descendant:IsA("TextChannel") then
            return
        end

        descendant.DescendantRemoving:Connect(function(descendant2: Instance)
            if not isInstanceALocalTextChannelParticipant(descendant2) then
                return
            end

            store:dispatch(LocalTextChannelParticipantRemoved(descendant))

            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                local descendantName = descendant.Name
                channelTabsStore.handleChannelRemoved(descendantName)
            end
        end)
    end)

    if GetFFlagTextChatEnableUniverseChatTabs() then
        local tbl7 = ({})

        local function handleUniverseChatChannelAllocated(context: string)
            if tbl7[context] then
                return
            end
            tbl7[context] = true

            local chatWindowConfiguration = var3:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = var3:FindFirstChildOfClass("ChatInputBarConfiguration")
            local bool7 = not chatWindowConfiguration or chatWindowConfiguration.Enabled ~= false
            local bool8 = not chatInputBarConfiguration or chatInputBarConfiguration.Enabled ~= false

            if not (bool7 and bool8) then
                return
            end

            local str1

            if context == "global" then
                str1 = "RBXGlobal"
                if FFlagExpChatUseUnifiedTooltipStore then
                    GetChatTooltipStore(false).setIsGlobalChatAvailable(true)
                end

                if FFlagExpChatGlobalTabDefault then
                    ExpChatGlobalTabDefaultExperimentation.logExposure()
                end
            else
                str1 = ""
            end

            if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                channelTabsStore.addChannelTab({ type = "UniverseChat", name = str1 }, nil)
            else
                store:dispatch(UniverseChatChannelAdded(str1, (getChannelTabIndex(str1))))
            end

            if FFlagExpChatGlobalTabDefault and isGlobalTabFirst() and str1 == "RBXGlobal" and not hasUserSelectedTab(store) then
                store:dispatch(UniverseChatChannelSelected(str1))
                if FFlagExpChatUseChannelTabsStore and channelTabsStore then
                    channelTabsStore.setTargetChannel(str1, false)
                end
            end

            if str1 ~= "" then
                local success, result = pcall(function()
                    if FFlagExpChatGlobalTabDefault then
                        return var2.translator:FormatByKey(getGlobalWelcomeMessageKey())
                    end
                    return var2.translator:FormatByKey("CoreScripts.TextChat.ChatWindow.ChatEnabled.Global2")
                end)
                if success and result and result ~= "" then
                    if GetFFlagExpChatSuppressWelcomeMessageTabUnread() then
                        messagesStore.addSystemMessage(result, str1, "Roblox.Welcome.GlobalChat")
                    else
                        messagesStore.addSystemMessage(result, str1)
                    end

                    if FFlagExpChatUseChannelTabsStore and channelTabsStore and not GetFFlagExpChatSuppressWelcomeMessageTabUnread() then
                        channelTabsStore.markChannelUnread(str1)
                    elseif FFlagExpChatUnreadTabIndicatorV2Window then
                        store:dispatch(
                            MarkChannelUnreadForSystemMessage(
                                result,
                                str1,
                                if GetFFlagExpChatSuppressWelcomeMessageTabUnread() then "Roblox.Welcome.GlobalChat" else nil
                            )
                        )
                    end
                end
            end

            tryAddThirdPartySummaryGlobalSystemMessage()
        end

        if var3:HasAllocatedUniverseChatContext("global") then
            handleUniverseChatChannelAllocated("global")
        end

        var3.UniverseChatChannelAllocated:Connect(handleUniverseChatChannelAllocated)

        var3.UniverseChatMessageReceived:Connect(function(textChatMessage: TextChatMessage)
            if FFlagExpChatDictationContinuousSafetyReminder then
                DictationSafetyReminder.onIncomingMessage(textChatMessage)
            end

            if shouldFilterGlobalMessage(textChatMessage, GetGlobalMutedUsersStore(false), localPlayer and localPlayer.UserId) then
                return
            end

            processIncomingMessageWithOptions(textChatMessage, { channelNameOverride = "RBXGlobal", isUniverseChat = true })
        end)
    end

    local function runOnBubbleDisplayed(partOrModel, message: string, arg1)
        local playerFromCharacter = if partOrModel:IsA("Model") then Players:GetPlayerFromCharacter(partOrModel) else nil
        local str1 = HttpService:GenerateGUID(false)
        local bubbleChatMessageProperties, var5

        if arg1 then
            str1 = arg1.MessageId
            bubbleChatMessageProperties = arg1.BubbleChatMessageProperties
            if getFFlagExpChatProtectedChatInternalAPIs() then
                var5 = arg1.TranslationInternal
            else
                var5 = arg1.Translation
            end
        else
            var5 = nil
            bubbleChatMessageProperties = nil
        end

        local dateTime = DateTime.fromUnixTimestampMillis(workspace:GetServerTimeNow() * 1000)
        local tbl7 = {
            message = message,
            translation = var5,
            bubbleChatMessageId = str1,
            bubbleChatMessageUserId = playerFromCharacter and tostring(playerFromCharacter.UserId) or nil,
            partOrModel = partOrModel,
            timestamp = dateTime,
            bubbleChatMessageProperties = bubbleChatMessageProperties
        }
        messagesStore.handleIncomingBubbleChatMessage(tbl7)
    end

    Chat.Chatted:Connect(function(part: BasePart, message: string)
        if var3.ChatVersion ~= Enum.ChatVersion.LegacyChatService or Chat.BubbleChatEnabled then
            runOnBubbleDisplayed(part, message)
        end
    end)

    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        local bubbleChatEnabled = Chat.BubbleChatEnabled

        store:dispatch(LegacyBubbleChatEnabledChanged("Enabled", bubbleChatEnabled))
    end

    Chat:GetPropertyChangedSignal("BubbleChatEnabled"):Connect(func2)
    func2()

    Chat.BubbleChatSettingsChanged:Connect(function(settings)
        if not var2.validateLegacyBubbleChatSettings then
            return
        end

        local var5, var6 = var2.validateLegacyBubbleChatSettings(settings)
        assert(
            var5,
            "Bad settings object passed to Chat:SetBubbleChatSettings:\n inside consolidated BubbleChat " .. (var6 or "")
        )

        if chatConfigurationStore then
            chatConfigurationStore.setBubbleChatSettings(settings)
            return
        end
        store:dispatch(LegacyBubbleChatSettingsChanged(settings))
    end)

    if getEngineFeatureFlagEnableDisplayBubble() then
        var3.BubbleDisplayed:Connect(function(partOrCharacter: Instance, textChatMessage: TextChatMessage)
            local var5 = textChatMessage
                and (if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessage.TextInternal else textChatMessage.Text)
            runOnBubbleDisplayed(partOrCharacter, var5, textChatMessage)
        end)
    end

    local function findCommandInstance(name: string)
        for _, descendant in ipairs(var3:GetDescendants()) do
            if descendant.Name == name and descendant:IsA("TextChatCommand") then
                return descendant
            end
        end

        return nil
    end

    local tbl7 = ({})
    local function setupTextChatCommands()
        for _, enabledCommand in ipairs(Commands.enabledCommands) do
            if not enabledCommand.clientRun then
                continue
            end

            local commandInstance = findCommandInstance(enabledCommand.name)
            if not commandInstance or tbl7[commandInstance] then
                continue
            end

            tbl7[commandInstance] = true

            commandInstance.Triggered:Connect(function(arg1, ...)
                local var5 = enabledCommand.clientRun(store, arg1.UserId, ..., context)
                if var5 then
                    displaySystemMessage(var5.key, var5.args, var5.metadata, var2.translator, var2.defaultSystemTextChannel)
                end
            end)

            if not (string.find(commandInstance.Name, "RBXTeamCommand") or string.find(commandInstance.Name, "RBXWhisperCommand")) then
                continue
            end
            for _, value in { "PrimaryAlias", "SecondaryAlias" } do
                commandInstance:GetPropertyChangedSignal(value):Connect(function()
                    store:dispatch(CommandAliasChanged(commandInstance.Name, commandInstance.PrimaryAlias, commandInstance.SecondaryAlias))
                end)
            end
        end
    end

    setupTextChatCommands()
    Chat:GetPropertyChangedSignal("IsAutoMigrated"):Once(setupTextChatCommands)

    if var2.canUserChatAsync and Players.LocalPlayer then
        Promise.try(function()
            return var2.canUserChatAsync(Players.LocalPlayer.UserId)
        end):andThen(function(arg1)
            messagesStore.setCanLocalUserChat(arg1)
        end):catch(function()
            messagesStore.setCanLocalUserChat(false)
        end)
    end
    watchPlayersService(var2, store, messagesStore)

    local appStyleProvider = UIBlox.App.Style.AppStyleProvider
    local constants = UIBlox.App.Style.Constants
    local tbl8 = {
        Dark = {
            themeName = ColorMode.Dark,
            fontName = constants.FontName.Gotham
        }
    }

    local createElement = Roact.createElement
    local tbl9 = {
        style = tbl8.Dark
    }
    local tbl10 = {
        app = Roact.createElement(App, {
            store = store,
            translator = var2.translator,
            gameTranslator = var2.gameTranslator,
            isChatWindowVisible = true,
            isChatInputBarVisible = true,
            isChannelBarVisible = false,
            isDefaultChatEnabled = true,
            getIconVoiceIndicator = var2.getIconVoiceIndicator,
            onClickedVoiceIndicator = var2.onClickedVoiceIndicator,
            onClickedCameraIndicator = var2.onClickedCameraIndicator,
            selfViewListenerChanged = var2.selfViewListenerChanged,
            getPermissions = var2.getPermissions,
            displayCameraDeniedToast = var2.displayCameraDeniedToast,
            isCamEnabledForUserAndPlace = var2.isCamEnabledForUserAndPlace,
            isCameraOnlyUser = var2.isCameraOnlyUser,
            isVoiceServiceInitialized = var2.isVoiceServiceInitialized,
            isSpatialUIEnabled = var2.isSpatialUIEnabled,
            expChatLoadStartTime = if getFFlagExpChatTelemetryEventTrigger() then os.clock() else nil
        })
    }
    local element = createElement(appStyleProvider, tbl9, tbl10)

    store:dispatch(
        ClientAppLoaded({
            team = Players.LocalPlayer and Players.LocalPlayer.Team,
            isChatCoreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat),
            isTouchEnabled = UserInputService.TouchEnabled,
            isGamepadEnabled = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
                or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
        })
    )

    reportVersionLoaded(Analytics, Version[1])

    var1:trace("Roact.mount to {}", tostring(var2.parent))
    local roactInstance = Roact.mount(element, var2.parent, "ExperienceChat")

    local var6 = ChatEnabledSystemMessage({
        translator = var2.translator,
        defaultSystemTextChannel = var2.defaultSystemTextChannel,
        displayVirtualSystemMessage = if var4 then showVirtualChatEnabledSystemMessage else nil
    })

    local function displayRegionUnavailableMessage() -- Luacid: Inlined by compiler; 1 call site recovered
        displaySystemMessage(
            "CoreScripts.TextChat.ChatWindow.ChatDisabled.RegionUnavailable",
            nil,
            "Roblox.ChatDisabled.Info",
            var2.translator,
            var2.defaultSystemTextChannel,
            "You can only view system messages here. Chat is not available in your region."
        )
    end

    local var7 = FFlagExpChatMEUpdatedSystemMessage and FFlagExpChatPresetChatEnabled and FFlagEnableClientSummarySystemMessageOnLua

    local function displayQuickWordsMessageOr(str1: string, str2: string, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
        whenPresetAccessKnown(GetPresetChatStore(false), function(arg1)
            if arg1 then
                displaySystemMessage(
                    str1,
                    nil,
                    "Roblox.ChatDisabled.Info",
                    var2.translator,
                    var2.defaultSystemTextChannel,
                    str2,
                    prefixWithPresetIcon
                )
                return
            end

            callback()
        end)
    end

    local function updateChatStatus(arg1)
        chatStatusStore.setChatStatus(arg1)

        if var7 and arg1 == "GeoBlocked" then
            displayQuickWordsMessageOr(
                "CoreScripts.TextChat.Description.UseQuickWordsChatIsntAvailableInYourRegion",
                "Use Quick Words to coordinate gameplay. Chat isn’t available in your region.",
                displayRegionUnavailableMessage
            )
            return
        end

        if arg1 == "GeoBlocked" or arg1 ~= "Unknown" and isChatRegionLocked() then
            displayRegionUnavailableMessage()
            return
        end

        if arg1 == "AgeCheckGateExperiment" then
            displaySystemMessage(
                "CoreScripts.TextChat.ChatWindow.ChatDisabled.CheckAgeInAccountInfo",
                nil,
                "Roblox.ChatDisabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                "You can only view system messages here. Unlock chat with an age check at Settings > Account info."
            )
            return
        elseif arg1 == "SettingsDisabled" then
            if ExpChatNewSystemMessagesExperimentation.isExperimentEnabled then
                tryLogExposureNewSystemMessages()
            end

            displaySystemMessage(
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "CoreScripts.TextChat.Description.TurnOnChatInSettings" else "CoreScripts.TextChat.ChatWindow.ChatDisabled.SettingOff",
                nil,
                "Roblox.ChatDisabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "Chat with people of similar age groups and trusted friends." else "You can only view system messages here. Update your Communication settings to turn on chat."
            )
            return
        elseif arg1 == "SettingsDisabledVpc" then
            if ExpChatNewSystemMessagesExperimentation.isExperimentEnabled then
                tryLogExposureNewSystemMessages()
            end

            displaySystemMessage(
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "CoreScripts.TextChat.Description.AskYourParentForPermissionToChat" else "CoreScripts.TextChat.ChatWindow.ChatDisabled.AskForPermission",
                nil,
                "Roblox.ChatDisabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "Ask your parent for permission to chat in Privacy>Communication settings." else "You can only view system messages here. Ask your parent for permission to chat in Communication settings."
            )
            return
        elseif arg1 == "AgeCheckVpc" then
            if ExpChatNewSystemMessagesExperimentation.isExperimentEnabled then
                tryLogExposureNewSystemMessages()
            end

            displaySystemMessage(
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "CoreScripts.TextChat.Description.AskYourParentForPermissionToChat" else "CoreScripts.TextChat.ChatWindow.ChatDisabled.AskForPermissionToAgeCheck",
                nil,
                "Roblox.ChatDisabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "Ask your parent for permission to chat in Privacy>Communication settings." else "You can only view system messages here. Ask your parent for permission to age check in Communication settings."
            )
            return
        end

        if not canPlatformEnableChat() and arg1 == "AgeVerificationRequired" or arg1 == "IdVerificationRequired" then
            if ExpChatNewSystemMessagesExperimentation.isExperimentEnabled then
                tryLogExposureNewSystemMessages()
            end

            displaySystemMessage(
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "CoreScripts.TextChat.Description.UnlockChatPrivacyCommunications" else "CoreScripts.TextChat.ChatWindow.ChatDisabled.CheckAgeInSettings",
                nil,
                "Roblox.ChatDisabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "Unlock chat with an age check in Privacy>Communication settings." else "You can only view system messages here. To chat, get an age check in your Communication settings."
            )
            return
        end

        if arg1 == "AgeVerificationRequired" then
            if ExpChatNewSystemMessagesExperimentation.isExperimentEnabled then
                tryLogExposureNewSystemMessages()
            end

            displaySystemMessage(
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "CoreScripts.TextChat.Description.UnlockChatWithAnAgeCheck" else "CoreScripts.TextChat.ChatWindow.ChatDisabled.GetAnAgeCheck",
                nil,
                "Roblox.ChatDisabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                if ExpChatNewSystemMessagesExperimentation.getNewSystemMessagesEnabled() then "Unlock chat with an age check." else "You can only view system messages here. Get an age check to chat."
            )
            return
        end

        if not FFlagExpChatRefactorEnabledMessageLogic or arg1 ~= "Enabled" then
            if arg1 == "EnabledBubble" or arg1 == "Enabled" and canOnlyChatInRegion() then
                if var4 then
                    showVirtualChatEnabledSystemMessage(
                        "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatInRegion",
                        nil,
                        "You can view system messages and chat with users in your region only."
                    )
                    return
                end

                displaySystemMessage(
                    "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatInRegion",
                    nil,
                    "Roblox.ChatEnabled.Info",
                    var2.translator,
                    var2.defaultSystemTextChannel,
                    "You can view system messages and chat with users in your region only."
                )
            elseif arg1 == "Enabled" then
                var6()
            elseif arg1 == "AllUsers" or arg1 == "NoOne" then
                if getChatTranslationEnabled() then
                    displaySystemMessage(
                        "CoreScripts.TextChat.ChatTranslation.ChatWindow.SystemMessageNew",
                        nil,
                        "Roblox.ChatTranslation.ChatWindow.SystemMessage",
                        var2.translator,
                        var2.defaultSystemTextChannel,
                        "Roblox automatically translates supported languages in chat"
                    )
                end
            elseif arg1 == "Ineligible" or arg1 ~= "Unknown" then
                displaySystemMessage(
                    "CoreScripts.TextChat.ChatWindow.ChatDisabled.OnlyViewSystemMessages",
                    nil,
                    "Roblox.ChatDisabled.Info",
                    var2.translator,
                    var2.defaultSystemTextChannel,
                    "You can only view system messages here."
                )
            end

            return
        end

        coroutine.wrap(function()
            if FStringExpChatChatWithTFAmpFeatureName == "" or FStringExpChatChatWithTFAmpNameSpace == "" then
                var1:error("AMP feature name or namespace are not set")
                return
            end

            local featureAccess = AmpApiProvider.getFeatureAccess({ FStringExpChatChatWithTFAmpFeatureName }, FStringExpChatChatWithTFAmpNameSpace)

            if localPlayer.ChatAvailabilityStatus ~= "Enabled" then
                return
            end

            local bool7 = if featureAccess.featureAccessList and #featureAccess.featureAccessList > 0 and featureAccess.featureAccessList[1] then featureAccess.featureAccessList[1].access == AccessResponseEnum.Granted else nil

            if bool7 == nil then
                var1:error("No feature access list found after AMP call")

                return
            end

            if bool7 then
                if var4 then
                    showVirtualChatEnabledSystemMessage(
                        "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatWithTF",
                        nil,
                        "Only your trusted friends can chat with you."
                    )
                    return
                end

                displaySystemMessage(
                    "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatWithTF",
                    nil,
                    "Roblox.ChatEnabled.Info",
                    var2.translator,
                    var2.defaultSystemTextChannel,
                    "Only your trusted friends can chat with you."
                )
                return
            end

            if not canOnlyChatInRegion() then
                var6()
                return
            end

            if var4 then
                showVirtualChatEnabledSystemMessage(
                    "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatInRegion",
                    nil,
                    "You can view system messages and chat with users in your region only."
                )
                return
            end

            displaySystemMessage(
                "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatInRegion",
                nil,
                "Roblox.ChatEnabled.Info",
                var2.translator,
                var2.defaultSystemTextChannel,
                "You can view system messages and chat with users in your region only."
            )
        end)()
    end

    local num5 = 0
    local num6 = math.random(num3, num4)

    local function handleUserMessageIntentSent(userIntentMessage: TextChatMessage)
        var1:debug("Handling a message from UserMessageIntentSent")

        messagesStore.handleHiddenMessageReceived(userIntentMessage)

        if not isUserChatEnabled(localPlayer.ChatAvailabilityStatus) then
            num5 += 1
            if num5 == num6 then
                num6 += math.random(num3, num4)

                displaySystemMessage(
                    "CoreScripts.TextChat.ChatWindow.ChatDisabled.DontMissMessages",
                    nil,
                    "Roblox.ChatDisabled.Info",
                    var2.translator,
                    var2.defaultSystemTextChannel,
                    "Don’t miss messages. Unlock chat with an age check."
                )
            end
        end

        GetTransparencyStore(false).resetTextTransparency()
    end

    local function shouldConnectToUserMessageIntentSent() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var8 = FFlagExpChatEnableFOMOUpsell and shouldShowFOMOUpsell()
        local var9 = FFlagExpChatEnableCrossAgeChatActivity and shouldShowCrossAgeChatActivity()

        return var8 or var9
    end

    if localPlayer then
        if FFlagEnableModerateChatRemoteEvent then
            local experienceChatVisualConfig = getExperienceChatVisualConfig()
            local chatModerationStore = GetChatModerationStore(false)
            local bool7 = false

            var2.moderateChatStoreDisposeEffect = Signals.createEffect(function(arg1)
                local isSettingEnabled = chatModerationStore.getIsSettingEnabled(arg1)
                if isSettingEnabled == bool7 then
                    return
                end

                if isSettingEnabled then
                    displaySystemMessage(
                        "CoreScripts.TextChat.MessageStatus.Warning.ModerateChatOn",
                        nil,
                        "Roblox.MessageStatus.Warning.ModerateChatOn",
                        var2.translator,
                        var2.defaultSystemTextChannel
                    )
                    NotificationModalsManager.SetUIBloxToast({
                        iconImage = UIBlox.App.ImageSet.Images[experienceChatVisualConfig.icon.off],
                        toastSubtitle = var2.translator:FormatByKey("CoreScripts.TextChat.Toast.ModerateChatOn.Subtitle"),
                        toastTitle = var2.translator:FormatByKey("CoreScripts.TextChat.Toast.ModerateChatOn.Title")
                    })
                else
                    displaySystemMessage(
                        "CoreScripts.TextChat.MessageStatus.Warning.ModerateChatOff",
                        nil,
                        "Roblox.MessageStatus.Warning.ModerateChatOff",
                        var2.translator,
                        var2.defaultSystemTextChannel
                    )
                    NotificationModalsManager.SetUIBloxToast({
                        iconImage = UIBlox.App.ImageSet.Images[experienceChatVisualConfig.icon.off],
                        toastSubtitle = var2.translator:FormatByKey("CoreScripts.TextChat.Toast.ModerateChatOff.Subtitle.FriendsRename"),
                        toastTitle = var2.translator:FormatByKey("CoreScripts.TextChat.Toast.ModerateChatOff.Title")
                    })
                end

                bool7 = isSettingEnabled
            end)
        end

        local chatAvailabilityStatus = localPlayer.ChatAvailabilityStatus
        var1:debug("Local player's initial ChatAvailabilityStatus is {}", chatAvailabilityStatus)
        updateChatStatus(chatAvailabilityStatus)

        local connection = nil

        if shouldConnectToUserMessageIntentSent() then
            var1:debug("Connecting to UserMessageIntentSent")
            connection = var3.UserMessageIntentSent:Connect(handleUserMessageIntentSent)
        end

        localPlayer:GetPropertyChangedSignal("ChatAvailabilityStatus"):Connect(function()
            chatAvailabilityStatus = localPlayer.ChatAvailabilityStatus
            var1:debug("Local player's ChatAvailabilityStatus has changed to {}", chatAvailabilityStatus)

            updateChatStatus(chatAvailabilityStatus)

            if (FFlagExpChatPresetChatEnabled or FFlagExpChatPresetChatLoadTestEnabled) and isUserChatEnabled(chatAvailabilityStatus) then
                initializePresetChat(
                    GetPresetChatStore(false),
                    not FFlagExpChatPresetChatEnabled and FFlagExpChatPresetChatLoadTestEnabled
                )
            end

            if shouldConnectToUserMessageIntentSent() and not connection then
                var1:debug("Connecting to UserMessageIntentSent")
                connection = var3.UserMessageIntentSent:Connect(handleUserMessageIntentSent)
            end

            if FFlagExpChatEnableFOMOUpsell
                and isUserChatEnabled(chatAvailabilityStatus)
                and connection
                and not (FFlagExpChatEnableCrossAgeChatActivity and shouldShowCrossAgeChatActivity())
            then
                var1:debug("Disconnecting from UserMessageIntentSent")

                connection:Disconnect()

                if FFlagExpChatClearHiddenMessagesPostAgeCheck then
                    messagesStore.handleHiddenMessagesCleared()
                    GetTransparencyStore(false).resetTextTransparency()
                end
            end

            messagesStore.setCanLocalUserChat(isUserChatEnabled(chatAvailabilityStatus))
        end)
    elseif isChatRegionLocked() then
        displaySystemMessage(
            "CoreScripts.TextChat.ChatWindow.ChatDisabled.RegionUnavailable",
            nil,
            "Roblox.ChatDisabled.Info",
            var2.translator,
            var2.defaultSystemTextChannel,
            "You can only view system messages here. Chat is currently unavailable in your region."
        )
    end

    if FFlagExpChatPresetChatEnabled or FFlagExpChatPresetChatLoadTestEnabled then
        initializePresetChat(
            GetPresetChatStore(false),
            not FFlagExpChatPresetChatEnabled and FFlagExpChatPresetChatLoadTestEnabled
        )
    end

    return { roactInstance = roactInstance }
end
