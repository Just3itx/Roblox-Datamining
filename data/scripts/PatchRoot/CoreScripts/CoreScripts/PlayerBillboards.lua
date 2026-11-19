-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local RobloxGui = CoreGui.RobloxGui

local VoiceChatCore = require(CorePackages.Workspace.Packages.VoiceChatCore)

local Rodux = require(CorePackages.Packages.Rodux)
local chatReducer = require(RobloxGui.Modules.InGameChat.BubbleChat.Reducers.chatReducer)
local SetMessageText = require(RobloxGui.Modules.InGameChat.BubbleChat.Actions.SetMessageText)
local AddMessageFromEvent = require(RobloxGui.Modules.InGameChat.BubbleChat.Actions.AddMessageFromEvent)
local AddMessageWithTimeout = require(RobloxGui.Modules.InGameChat.BubbleChat.Actions.AddMessageWithTimeout)
local UpdateChatSettings = require(RobloxGui.Modules.InGameChat.BubbleChat.Actions.UpdateChatSettings)
local BubbleChatEnabledChanged = require(RobloxGui.Modules.InGameChat.BubbleChat.Actions.BubbleChatEnabledChanged)
local VoiceEnabledChanged = require(RobloxGui.Modules.VoiceChat.Actions.VoiceEnabledChanged)
local ParticipantsChanged = require(RobloxGui.Modules.VoiceChat.Actions.ParticipantsChanged)
local VoiceStateChanged = require(RobloxGui.Modules.VoiceChat.Actions.VoiceStateChanged)
local ParticipantAdded = require(RobloxGui.Modules.VoiceChat.Actions.ParticipantAdded)
local ParticipantRemoved = require(RobloxGui.Modules.VoiceChat.Actions.ParticipantRemoved)
local PlayerRemoved = require(RobloxGui.Modules.VoiceChat.Actions.PlayerRemoved)
local getPlayerFromPart = require(RobloxGui.Modules.InGameChat.BubbleChat.Helpers.getPlayerFromPart)
local validateMessage = require(RobloxGui.Modules.InGameChat.BubbleChat.Helpers.validateMessage)
local Constants = require(RobloxGui.Modules.InGameChat.BubbleChat.Constants)
local Types = require(RobloxGui.Modules.InGameChat.BubbleChat.Types)
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local initVoiceChatStore = require(RobloxGui.Modules.VoiceChat.initVoiceChatStore)
local GetFFlagEnableVoiceChatVoiceUISync = require(RobloxGui.Modules.Flags.GetFFlagEnableVoiceChatVoiceUISync)
local GetFFlagLocalMutedNilFix = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagLocalMutedNilFix
local GetFFlagBatchVoiceParticipantsUpdates = VoiceChatCore.Flags.GetFFlagBatchVoiceParticipantsUpdates
local getFFlagExpChatAlwaysRunTCS = require(CorePackages.Workspace.Packages.SharedFlags).getFFlagExpChatAlwaysRunTCS

local GetFFlagExpChatUseVoiceParticipantsStore = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagExpChatUseVoiceParticipantsStore

local FFlagExpChatUseChatConfigStore = require(CorePackages.Workspace.Packages.SharedFlags).FFlagExpChatUseChatConfigStore

local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)
local var1 = require(RobloxGui.Modules.InGameChat.BubbleChat.Logger)(script.Name)
local voiceStore = if GetFFlagExpChatUseVoiceParticipantsStore() then ExpChat.Stores.GetVoiceStore(false) else nil
local tbl1 = {}
tbl1[VoiceEnabledChanged.name] = function(arg1)
    ExpChat.Events.VoiceEnabledChanged(arg1.enabled)
end

tbl1[VoiceStateChanged.name] = function(arg1)
    if GetFFlagExpChatUseVoiceParticipantsStore() then
        voiceStore.handleVoiceStateChanged(arg1.userId, arg1.newState)
        return
    end
    ExpChat.Events.VoiceStateChanged(arg1.userId, arg1.newState)
end

tbl1[ParticipantsChanged.name] = function(arg1)
    if GetFFlagExpChatUseVoiceParticipantsStore() then
        voiceStore.handleVoiceParticipantsChanged(arg1.newParticipants)
        return
    end
    ExpChat.Events.VoiceParticipantsChanged(arg1.newParticipants)
end

tbl1[ParticipantAdded.name] = not GetFFlagExpChatUseVoiceParticipantsStore() and function(arg1)
    ExpChat.Events.VoiceParticipantAdded(arg1.userId)
end or nil

tbl1[ParticipantRemoved.name] = not GetFFlagExpChatUseVoiceParticipantsStore() and function(arg1)
    ExpChat.Events.VoiceParticipantRemoved(arg1.userId)
end or nil

local store = Rodux.Store.new(chatReducer, nil, {
    Rodux.thunkMiddleware,
    function(callback)
        return function(arg1)
            local var2 = tbl1[arg1.type]
            if var2 then
                var2(arg1)
            end

            callback(arg1)
        end
    end
})

local connection = nil
local function isTextChatServiceOn(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if getFFlagExpChatAlwaysRunTCS() then true else TextChatService.ChatVersion == Enum.ChatVersion.TextChatService
end

if game:IsLoaded() and isTextChatServiceOn() then
    return
end
connection = game.Loaded:Connect(function()
    if game:IsLoaded() then
        connection:Disconnect()
    end
end)

local function validateMessageWithWarning(str1: string, message)
    local var2, var3 = validateMessage(message)

    if not var2 then
        if var3 then
            warn(
                ("Message text %q is too long for chat event %q (expected a message of length %i, got %i)"):format(
                    message,
                    str1,
                    Constants.MAX_MESSAGE_LENGTH,
                    var3
                )
            )
            return var2
        end
        warn(("Message text %q sent to chat event %q is not a valid UTF-8 characters sequence"):format(message, str1))
    end

    return var2
end

local function validateMessageData(str1: string, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2, var3 = Types.IMessageData(arg1)

    if not var2 then
        warn(
            ("Malformed message data sent to chat event %q. If you have modified the chat system, check what you are firing to this event"):format(
                str1
            )
        )
        warn(var3)
    end

    return var2
end

local connection2 = nil
local connection3 = nil
local connection4 = nil
local var2 = nil
local var3 = nil
local num1 = 0
local num2 = 0
local tbl2 = ({})
local function initBubbleChat()
    coroutine.resume(coroutine.create(function()
        local defaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents", math.huge)

        connection2 = defaultChatSystemChatEvents:WaitForChild("OnNewMessage", math.huge).OnClientEvent:Connect(function(arg1)
            if not validateMessageData("OnNewMessage", arg1) then
                return
            end

            if arg1.FromSpeaker ~= Players.LocalPlayer.Name then
                return
            end

            if not validateMessageWithWarning("OnNewMessage", arg1.Message) then
                return
            end

            local var4 = table.clone(arg1)
            var4.Time = workspace:GetServerTimeNow() * 1000
            store:dispatch(AddMessageFromEvent(var4))
        end)

        connection3 = defaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering", math.huge).OnClientEvent:Connect(function(arg1)
            if not (validateMessageData("OnMessageDoneFiltering", arg1)
                and validateMessageWithWarning("OnMessageDoneFiltering", arg1.Message)) then
                return
            end

            local str1 = tostring(arg1.ID)
            if store:getState().messages[str1] then
                store:dispatch(SetMessageText(str1, arg1.Message))
                return
            end
            local var4 = table.clone(arg1)
            var4.Time = workspace:GetServerTimeNow() * 1000
            store:dispatch(AddMessageFromEvent(var4))
        end)
    end))

    local function addMessageWithId(basePart: BasePart, message: string, num3: number)
        local var4 = if basePart:IsA("Model") then if basePart.PrimaryPart then basePart.PrimaryPart else basePart:FindFirstChildWhichIsA("BasePart", true) else basePart
        local playerFromPart = if var4 then getPlayerFromPart(var4) else nil
        local var5

        if playerFromPart then
            var5 = tostring(playerFromPart.UserId)
        else
            var5 = tbl2[basePart]
            if not var5 then
                num1 += 1
                var5 = "adornee_" .. num1
                tbl2[basePart] = var5
            end
        end

        local tbl3 = {
            id = "chatted_" .. num3,
            userId = var5,
            name = basePart.Name,
            text = GameTranslator:TranslateGameText(CoreGui, message),
            timestamp = os.time(),
            adornee = basePart
        }

        store:dispatch(AddMessageWithTimeout(tbl3))
    end

    connection4 = Chat.Chatted:Connect(function(part: BasePart, message: string) -- name: addMessage
        num2 += 1
        addMessageWithId(part, message, num2)
    end)
end

local function destroyBubbleChat()
    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end
    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end
    if connection4 then
        connection4:Disconnect()
        connection4 = nil
    end

    if var3 then
        var3:Disconnect()
        var3 = nil
    end
    if var2 then
        var2:Disconnect()
        var2 = nil
    end
end

local function onBubbleChatEnabledChanged() -- Luacid: Inlined by compiler; 1 call site recovered
    destroyBubbleChat()
    local bool1 = not game:GetEngineFeature("EnableBubbleChatFromChatService") or Chat.BubbleChatEnabled
    if bool1 then
        initBubbleChat()
    end
    store:dispatch(BubbleChatEnabledChanged(bool1))
end

local tbl3 = {}

local function setVoiceEnabled(voiceChatState)
    local str1 = tostring(Players.LocalPlayer.UserId)
    local bool1 = voiceChatState ~= Enum.VoiceChatState.Ended
    store:dispatch(VoiceEnabledChanged(bool1))

    if not tbl3[voiceChatState] then
        var1:warning("LOCAL_STATE_MAP does not exist for {} state", voiceChatState)
        store:dispatch(VoiceStateChanged(str1, Constants.VOICE_STATE.MUTED))
    else
        store:dispatch(VoiceStateChanged(str1, tbl3[voiceChatState]))
    end

    if voiceChatState ~= Enum.VoiceChatState.Failed then
        if voiceChatState == Enum.VoiceChatState.Joined
            and (if GetFFlagLocalMutedNilFix then default.localMuted == false else not default.localMuted)
        then
            store:dispatch(VoiceStateChanged(str1, Constants.VOICE_STATE.INACTIVE))
        end

        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        local str2 = tostring(player.UserId)
        if player ~= Players.LocalPlayer then
            store:dispatch(VoiceStateChanged(str2, Constants.VOICE_STATE.HIDDEN))
        end
    end
end

local function shorten(arg1): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return "..." .. string.sub(tostring(arg1), -4)
end

local function initVoiceChat()
    if GetFFlagEnableVoiceChatVoiceUISync() then
        initVoiceChatStore(store)
        return
    end
    var1:debug("Initializing VoiceChatService connections")
    local service = default:getService()
    if not service then
        var1:debug("VoiceChatService is not available")
        return
    end

    if not Enum.VoiceChatState then
        var1:error("Enum.VoiceChatState does not exist but voice is enabled")
        return
    end

    tbl3 = {
        [Enum.VoiceChatState.Idle] = Constants.VOICE_STATE.HIDDEN,
        [Enum.VoiceChatState.Joining] = Constants.VOICE_STATE.CONNECTING,
        [Enum.VoiceChatState.JoiningRetry] = Constants.VOICE_STATE.CONNECTING,
        [Enum.VoiceChatState.Joined] = Constants.VOICE_STATE.MUTED,
        [Enum.VoiceChatState.Leaving] = Constants.VOICE_STATE.MUTED,
        [Enum.VoiceChatState.Ended] = Constants.VOICE_STATE.HIDDEN,
        [Enum.VoiceChatState.Failed] = Constants.VOICE_STATE.ERROR
    }

    local userId = Players.LocalPlayer.UserId

    for _, player in pairs(Players:GetPlayers()) do
        var1:trace("Adding existing player {}", (shorten(player.UserId)))
        store:dispatch(ParticipantAdded(tostring(player.UserId)))
    end
    Players.PlayerAdded:Connect(function(player: Player)
        var1:trace("Adding joining player {}", (shorten(player.UserId)))
        store:dispatch(ParticipantAdded(tostring(player.userId)))
    end)

    Players.PlayerRemoving:Connect(function(player: Player)
        var1:trace("Removing player {}", (shorten(player.UserId)))

        store:dispatch(PlayerRemoved(tostring(player.userId)))
        store:dispatch(ParticipantRemoved(tostring(player.userId)))
    end)

    store:dispatch(VoiceStateChanged(userId, Constants.VOICE_STATE.HIDDEN))
    default.muteChanged.Event:connect(function(arg1)
        var1:debug("Mute changed to {}", arg1)
        local var4 = arg1 and Constants.VOICE_STATE.MUTED or Constants.VOICE_STATE.INACTIVE
        store:dispatch(VoiceStateChanged(userId, var4))
    end)

    default.participantsUpdate.Event:Connect(function(arg1)
        if GetFFlagBatchVoiceParticipantsUpdates() then
            store:dispatch(ParticipantsChanged(arg1))
            return
        end
        for k, value in pairs(arg1) do
            local inactive = Constants.VOICE_STATE.INACTIVE
            if not value.subscriptionCompleted then
                inactive = Constants.VOICE_STATE.CONNECTING
            elseif value.isMutedLocally then
                inactive = Constants.VOICE_STATE.LOCAL_MUTED
            elseif value.isMuted then
                inactive = Constants.VOICE_STATE.MUTED
            elseif value.isSignalActive then
                inactive = Constants.VOICE_STATE.TALKING
            end
            var1:trace("Participant update for {}, voice state {}", shorten(k), inactive)
            store:dispatch(VoiceStateChanged(k, inactive))
        end
    end)

    default.talkingChanged.Event:Connect(function(arg1)
        if arg1 then
            store:dispatch(VoiceStateChanged(userId, Constants.VOICE_STATE.TALKING))
            return
        end
        store:dispatch(VoiceStateChanged(userId, Constants.VOICE_STATE.INACTIVE))
    end)

    BlockingUtility:GetBlockedStatusChangedEvent():Connect(function(arg1, arg2)
        if arg2 then
            store:dispatch(ParticipantRemoved(tostring(arg1)))
            return
        end
        store:dispatch(ParticipantAdded(tostring(arg1)))
    end)

    var1:debug("Initial voice state is {}", service.VoiceChatState)
    setVoiceEnabled(service.VoiceChatState)
    service.StateChanged:Connect(function(_, arg1)
        var1:debug("Voice state changed to {}", arg1)
        setVoiceEnabled(arg1)
    end)
end

if game:GetEngineFeature("EnableBubbleChatFromChatService") then
    Chat:GetPropertyChangedSignal("BubbleChatEnabled"):Connect(onBubbleChatEnabledChanged)
end

onBubbleChatEnabledChanged()

if game:GetEngineFeature("BubbleChatSettingsApi") then
    Chat.BubbleChatSettingsChanged:Connect(function(settings)
        local var4, var5 = Types.IChatSettings(settings)
        assert(var4, "Bad settings object passed to Chat:SetBubbleChatSettings:\n" .. (var5 or ""))

        if FFlagExpChatUseChatConfigStore then
            ExpChat.Stores.GetChatConfigurationStore(false).setBubbleChatSettings(settings)
            return
        end
        store:dispatch(UpdateChatSettings(settings))
    end)
end

default:asyncInit():andThen(initVoiceChat):catch(function()
    var1:debug("VoiceChatServiceManager failed to initialize")
end)
