-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:11:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Promise = require(CorePackages.Packages.Promise)
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local CrossExperience = require(CorePackages.Workspace.Packages.CrossExperience)

local FStringTimeoutLoadingLocalPlayerInBackgroundDM = require(CorePackages.Workspace.Packages.SharedFlags).FStringTimeoutLoadingLocalPlayerInBackgroundDM

local getMemStorageKey = CrossExperience.Utils.getMemStorageKey
local CEV_JOIN_ATTEMPT_ID_KEY = CrossExperience.Constants.CEV_JOIN_ATTEMPT_ID_KEY
local LOCAL_PLAYER_LOADING_TIMEOUT_ENUM = CrossExperience.Constants.LOCAL_PLAYER_LOADING_TIMEOUT_ENUM

local timeoutSeconds = game:DefineFastInt("BackgroundDMLocalPlayerLoadingTimeoutSeconds", 12)
local bool1 = game:DefineFastFlag("DelayAudioFocusReplication", false)

local timeOut = game:DefineFastInt("PlayerAudioFocusReplicationTimeoutSeconds", 10)

local UserId = if FStringTimeoutLoadingLocalPlayerInBackgroundDM == LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable then Players.LocalPlayer and Players.LocalPlayer.UserId or -1 else nil

local function sendAnalyticsEvent(eventName: string, tbl1)
    local additionalArgs = tbl1 or {}

    additionalArgs.cevJoinAttemptId = getMemStorageKey(CEV_JOIN_ATTEMPT_ID_KEY)
    additionalArgs.clientTimeStamp = os.time()
    additionalArgs.userId = if FStringTimeoutLoadingLocalPlayerInBackgroundDM == LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable then UserId else nil

    RbxAnalyticsService:SendEventDeferred("client", "partyVoice", eventName, additionalArgs)
end

if FStringTimeoutLoadingLocalPlayerInBackgroundDM ~= LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable then
    sendAnalyticsEvent("partyVoiceCEVChannelFileLoaded")
end

local eventManager = CrossExperience.EventManager.new(CrossExperience.Constants.EXPERIENCE_TYPE_VOICE, true)

local function notifyVoiceStatusChange(status, detail: string?) -- Luacid: Inlined by compiler; 14 call sites recovered
    eventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_STATUS_CHANGED, { status = status, detail = detail })
end

local function ensureLocalPlayerWithTimeout(): number
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        local promise = Promise.new(function(callback)
            if Players.LocalPlayer then
                callback("loaded")
                return
            end
            local connection = nil
            connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
                if Players.LocalPlayer then
                    connection:Disconnect()
                    callback("loaded")
                end
            end)
        end)

        local var1 = Promise.delay(timeoutSeconds):andThen(function(): string
            return "timeout"
        end)

        Promise.race({ promise, var1 }):andThen(function(arg1)
            if arg1 == "loaded" then
                localPlayer = Players.LocalPlayer

                sendAnalyticsEvent("cevDefaultChannelBackgroundDMLocalPlayerLoaded", { timeoutSeconds = timeoutSeconds })
                return
            end

            sendAnalyticsEvent("backgroundDMLocalPlayerLoadingTimeout", { timeoutSeconds = timeoutSeconds })

            notifyVoiceStatusChange(
                CrossExperience.Constants.VOICE_STATUS.ERROR_BACKGROUND_DM_LOAD_LOCALPLAYER_TIMEOUT,
                "LocalPlayer loading timed out after " .. timeoutSeconds .. " seconds"
            )

            localPlayer = nil
        end):await()
    end

    if not localPlayer then
        Promise.new(function() end):await()
    end

    return localPlayer.UserId
end

UserId = if FStringTimeoutLoadingLocalPlayerInBackgroundDM ~= LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable then -1 else UserId

if FStringTimeoutLoadingLocalPlayerInBackgroundDM == LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable then
    sendAnalyticsEvent("partyVoiceCEVChannelFileLoaded")
end

local PlayerAudioFocusChanged = nil
if not bool1 then
    PlayerAudioFocusChanged = ReplicatedStorage:WaitForChild("PlayerAudioFocusChanged")

    sendAnalyticsEvent("partyVoicePlayerAudioFocusChangedLoaded")
end

local VoiceChatCore = require(CorePackages.Workspace.Packages.VoiceChatCore)
local default = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default
local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)
local default2 = VoiceChatCore.CoreVoiceManager.default
local createPersistenceMiddleware = CrossExperience.Middlewares.createPersistenceMiddleware

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local CaptureService = if SharedFlags.GetFFlagEnableVoiceChatMuteForVideoCaptures() then game:GetService("CaptureService") else nil
local _LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)
local FFlagPartyVoiceBlockSync = SharedFlags.FFlagPartyVoiceBlockSync
local GetFFlagVoiceChatClientRewriteMasterLua = SharedFlags.GetFFlagVoiceChatClientRewriteMasterLua

local bool2 = game:DefineFastFlag("UseNotificationServiceIsConnected", false)
local bool3 = game:DefineFastFlag("DefaultChannelEnableDefaultVoice", true)
local bool4 = game:DefineFastFlag("EnableCrossExpVoiceDebug", false)

local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice

local GetFFlagEnableCrossExperienceVoiceCaptureMute = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableCrossExperienceVoiceCaptureMute
local bool5 = game:DefineFastFlag("PartyVoiceFixCaptureVideoCheck", false)
local FIntPartyVoiceUndeafenDelayMS = SharedFlags.FIntPartyVoiceUndeafenDelayMS
local timeout = game:DefineFastInt("VoiceJoinTimeoutInSeconds", 15)

local engineFeature = game:GetEngineFeature("VoiceServiceEnableDefaultVoiceAvailable")
local engineFeature2 = game:GetEngineFeature("NotificationServiceIsConnectedAvailable")
local engineFeature3 = game:GetEngineFeature("AudioFocusManagement")
local engineFeature4 = game:GetEngineFeature("CevReadinessSync")

local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)
local analytics = VoiceChatCore.Analytics.new()
local observeCurrentContextId = CrossExperience.Utils.observeCurrentContextId

local VoiceChatService = game:GetService("VoiceChatService")

local Constants = CrossExperience.Constants
local VOICE_STATUS = Constants.VOICE_STATUS

local fFlagFixPartyVoiceGetPermissions = SharedFlags.GetFFlagFixPartyVoiceGetPermissions()
local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua
local bool6 = game:DefineFastFlag("EnableCEVPersistMuteStateForAFM", false)

local var2 = nil

if GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() then
    default2:setOptions({ allowSeamlessVoice = false, passInitErrorInPromiseReject = true, forceVoiceEnabled = true })
end

local persistenceMiddleware = createPersistenceMiddleware({ storeKey = CrossExperience.Constants.STORAGE_CEV_STORE_KEY })

sendAnalyticsEvent("partyVoicePersistenceMiddlewareCreated")

local default3 = CrossExperience.PartyAudioPlayer.default

local function func1()
    return Rodux.combineReducers({ Squad = Rodux.combineReducers({ CrossExperienceVoice = CrossExperience.installReducer() }) })
end

sendAnalyticsEvent("partyVoiceCrossExperienceReducerLoaded")

local function func2(callback)
    default2:asyncInit():andThen(function()
        callback()
    end):catch(function(arg1)
        var1:info("CoreVoiceManager did not initialize {}", arg1)
    end)
end

local tbl1 = { previousGroupId = nil, previousMutedState = false }

local bindableEvent = Instance.new("BindableEvent")
local bool7 = false
local var3 = nil

if engineFeature4 then
    var1:info("Registering early observer for foreground readiness signal.")
    var3 = eventManager:addObserver(CrossExperience.Constants.EVENTS.FOREGROUND_UI_READY, function()
        if not bool7 then
            var1:info("Received foreground UI readiness signal.")
            bool7 = true
            bindableEvent:Fire()
        end
    end)
end

local store = Rodux.Store.new(func1(), nil, { Rodux.thunkMiddleware, persistenceMiddleware.getMiddleware() })

sendAnalyticsEvent("partyVoicePersistenceMiddlewareReducerLoaded")

eventManager:subscribe(store)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

sendAnalyticsEvent("partyVoiceGameLoaded")

notifyVoiceStatusChange(Constants.VOICE_STATUS.RCC_CONNECTED, nil)

sendAnalyticsEvent("partyVoiceRCCConnectedSignalFired")

local PARTY_VOICE_EXPERIENCE_JOINED = CrossExperience.Constants.EVENTS.PARTY_VOICE_EXPERIENCE_JOINED
local tbl2 = {
    jobId = if game.JobId == "" or game.JobId == nil then HttpService:GenerateGUID(true) else game.JobId,
    placeId = game.PlaceId,
    gameId = game.GameId
}
eventManager:notify(PARTY_VOICE_EXPERIENCE_JOINED, tbl2)

if bool1 then
    local var4 = nil
    local bool8 = false

    observeCurrentContextId(function(arg1)
        var4 = arg1

        print("CurrentContextId changed to", arg1, "isReplicationReady:", bool8)

        if bool8 and PlayerAudioFocusChanged then
            PlayerAudioFocusChanged:FireServer(arg1)
            print("Fired PlayerAudioFocusChanged with contextId:", arg1)
        end
    end)

    print("Waiting for PlayerAudioFocusChanged to replicate...")

    PlayerAudioFocusChanged = ReplicatedStorage:WaitForChild("PlayerAudioFocusChanged", timeOut)

    if PlayerAudioFocusChanged then
        print("PlayerAudioFocusChanged replicated successfully.")
        sendAnalyticsEvent("partyVoicePlayerAudioFocusChangedLoaded")

        PlayerAudioFocusChanged.OnClientEvent:Connect(function(userId, contextId, contextIds)
            print("Received PlayerAudioFocusChanged OnClientEvent:", userId, contextId)
            eventManager:notify(
                CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_AUDIO_FOCUS_CHANGED,
                { userId = userId, contextId = contextId, contextIds = contextIds }
            )
        end)

        bool8 = true
        if var4 then
            PlayerAudioFocusChanged:FireServer(var4)
            print("Fired PlayerAudioFocusChanged with latestContextId:", var4)
        end
    else
        print("PlayerAudioFocusChanged did not replicate within timeout of ", timeOut, " seconds.")

        sendAnalyticsEvent("partyVoicePlayerAudioFocusChangedReplicationTimeout", { timeoutSeconds = timeOut })
    end
else
    observeCurrentContextId(function(arg1)
        PlayerAudioFocusChanged:FireServer(arg1)
    end)

    PlayerAudioFocusChanged.OnClientEvent:Connect(function(userId, contextId, contextIds)
        eventManager:notify(
            CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_AUDIO_FOCUS_CHANGED,
            { userId = userId, contextId = contextId, contextIds = contextIds }
        )
    end)
end

local function func3(player: Player)
    eventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_ADDED, {
        userId = player.UserId,
        isLocalUser = player.UserId == UserId,
        username = player.Name,
        displayname = player.DisplayName,
        isVoiceChangerActive = not FFlagEnablePartyVoiceChangersInLua and nil,
        isVoiceChangerHearMyselfActive = not FFlagEnablePartyVoiceChangersInLua and nil,
        selectedVoicePack = if FFlagEnablePartyVoiceChangersInLua then "None" else nil
    })
end

local function func4(player: Player)
    eventManager:notify(
        CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_REMOVED,
        {
            userId = player.UserId,
            isLocalUser = player.UserId == UserId
        }
    )
    default3:playSound("leave")
end

local function func5(arg1)
    local var4 = if arg1.isActive then CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_IS_ACTIVE else CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_IS_INACTIVE
    eventManager:notify(var4, { userId = UserId, isLocalUser = true })
end

local function func6(previousMutedState)
    if not bool6 then
        tbl1.previousMutedState = previousMutedState
    end

    local var4 = if previousMutedState then CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_WAS_MUTED else CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_WAS_UNMUTED

    func2(function()
        eventManager:notify(var4, { userId = UserId, isLocalUser = true })
    end)
end

local function onLocalVoiceChangerChanged(arg1)
    local var4 = if arg1 then CrossExperience.Constants.EVENTS.PARTY_VOICE_CHANGER_WAS_ENABLED else CrossExperience.Constants.EVENTS.PARTY_VOICE_CHANGER_WAS_DISABLED
    eventManager:notify(var4, { userId = UserId, isLocalUser = true })
end

local function onLocalVoiceChangerHearMyselfChanged(arg1)
    local var4 = if arg1 then CrossExperience.Constants.EVENTS.PARTY_VOICE_CHANGER_FEEDBACK_WAS_ENABLED else CrossExperience.Constants.EVENTS.PARTY_VOICE_CHANGER_FEEDBACK_WAS_DISABLED
    eventManager:notify(var4, { userId = UserId, isLocalUser = true })
end

local function func7(arg1)
    for userId, value in pairs(arg1) do
        local isSignalActive = value.isSignalActive
        local isMuted = value.isMuted
        local isVoiceChangerActive = if FFlagEnablePartyVoiceChangersInLua then value.isVoiceChangerActive else nil
        local var4 = if isSignalActive then CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_IS_ACTIVE else CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_IS_INACTIVE
        local var5 = if isMuted then CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_WAS_MUTED else CrossExperience.Constants.EVENTS.PARTY_VOICE_PARTICIPANT_WAS_UNMUTED
        local var6 = if FFlagEnablePartyVoiceChangersInLua then if isVoiceChangerActive then CrossExperience.Constants.EVENTS.PARTY_VOICE_CHANGER_WAS_ENABLED else CrossExperience.Constants.EVENTS.PARTY_VOICE_CHANGER_WAS_DISABLED else nil
        local tbl3 = {
            userId = userId,
            isLocalUser = userId == UserId
        }

        eventManager:notify(var5, tbl3)
        eventManager:notify(var4, tbl3)
        if FFlagEnablePartyVoiceChangersInLua then
            eventManager:notify(var6, tbl3)
        end
    end
end

local function func8(arg1)
    local var4 = tonumber(arg1.userId)
    local bool8 = UserId == var4
    func2(function()
        if not bool8 then
            default2:ToggleMutePlayer(var4)

            return
        end

        if bool6 then
            tbl1.previousMutedState = not default2.localMuted
        end
        default2:ToggleMic("Squads")
    end)
end

local function setVoicePack(arg1)
    local voicePackName = arg1.voicePackName
    default2:SetVoicePack(voicePackName)
    eventManager:notify(
        CrossExperience.Constants.EVENTS.PARTY_VOICE_PACK_WAS_SET,
        { userId = UserId, isLocalUser = true, voicePackName = voicePackName }
    )
end

local function toggleVoiceChanger(arg1)
    local var4 = tonumber(arg1.userId)
    if UserId == var4 then
        default2:ToggleVoiceChanger("Squads")
        return
    end
    default2:ToggleVoiceChanger(var4)
end

local function toggleVoiceChangerHearMyself(arg1)
    local var4 = tonumber(arg1.userId)
    if UserId == var4 then
        default2:ToggleVoiceChangerHearMyself("Squads")
        return
    end
    default2:ToggleVoiceChangerHearMyself(var4)
end

function handleParticipants()
    Players.PlayerAdded:Connect(function(player: Player)
        func3(player)
        default3:playSound("join")
    end)
    Players.PlayerRemoving:Connect(func4)

    for _, player in pairs(Players:GetPlayers()) do
        if not player:IsA("Player") then
            continue
        end

        func3(player)
        if player.UserId == UserId then
            default3:playSound("join")
        end
    end
end

function handleMicrophone()
    default2.muteChanged.Event:Connect(func6)
    eventManager:addObserver(CrossExperience.Constants.EVENTS.MUTE_PARTY_VOICE_PARTICIPANT, func8)
    eventManager:addObserver(CrossExperience.Constants.EVENTS.UNMUTE_PARTY_VOICE_PARTICIPANT, func8)
end

function handleVoiceChanger()
    default2.voiceChangerChanged.Event:Connect(onLocalVoiceChangerChanged)
    eventManager:addObserver(CrossExperience.Constants.EVENTS.ENABLE_PARTY_VOICE_CHANGER, toggleVoiceChanger)
    eventManager:addObserver(CrossExperience.Constants.EVENTS.DISABLE_PARTY_VOICE_CHANGER, toggleVoiceChanger)
    eventManager:addObserver(CrossExperience.Constants.EVENTS.SET_PARTY_VOICE_PACK, setVoicePack)
    default2.voiceChangerHearMyselfChanged.Event:Connect(onLocalVoiceChangerHearMyselfChanged)
    eventManager:addObserver(
        CrossExperience.Constants.EVENTS.ENABLE_PARTY_VOICE_CHANGER_FEEDBACK,
        toggleVoiceChangerHearMyself
    )
    eventManager:addObserver(
        CrossExperience.Constants.EVENTS.DISABLE_PARTY_VOICE_CHANGER_FEEDBACK,
        toggleVoiceChangerHearMyself
    )
end

local function func9(tbl3)
    local num3 = tonumber(tbl3.userId) or 0
    local player = Players:GetPlayerByUserId(num3)
    if not player then
        return
    end

    coroutine.wrap(function()
        if BlockingUtility:AddPlayerToBlockList(player) then
            var1:info("Participant {} was blocked from party voice", player.DisplayName)
        end
    end)()
end

local function func10(tbl3)
    local num3 = tonumber(tbl3.userId) or 0
    local player = Players:GetPlayerByUserId(num3)
    if not player then
        return
    end

    coroutine.wrap(function()
        if BlockingUtility:RemovePlayerFromBlockList(player) then
            var1:info("Participant {} was unblocked from party voice", player.DisplayName)
        end
    end)()
end

local function func11() -- Luacid: Inlined by compiler; 4 call sites recovered
    return GetFFlagEnableCrossExperienceVoiceCaptureMute() and CaptureService and CaptureService:IsCapturingVideo()
end

local function isAuthorizedPermission(arg1, microphoneAccess): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return if arg1.missingPermissions then not Cryo.List.find(arg1.missingPermissions, microphoneAccess) else false
end

local function requestPermissions(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = { hasMicPermissions = false }

    return Promise.new(function(callback, _)
        default:requestPermissions(arg1):andThen(function(arg2)
            tbl3.hasMicPermissions = isAuthorizedPermission(arg2, default.Permissions.MICROPHONE_ACCESS)
            callback(tbl3)
        end):catch(function()
            callback(tbl3)
        end)
    end)
end

local function initializeParticipantBlockListener() -- Luacid: Inlined by compiler; 1 call site recovered
    eventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_BLOCK_PARTICIPANT, func9)

    eventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_UNBLOCK_PARTICIPANT, func10)
end

function onCoreVoiceManagerInitialized()
    default2:getService().PlayerMicActivitySignalChange:Connect(func5)
    default2.participantsUpdate.Event:Connect(func7)
end

local function unmuteMicrophoneOnce() -- Luacid: Inlined by compiler; 1 call site recovered
    default2.muteChanged.Event:Once(function(arg1)
        if arg1 ~= nil then
            func2(function()
                default2:ToggleMic("BackgroundDM")
            end)
        end
    end)
end

local function initializeDefaultChannel(bool8: boolean)
    local service = default2:getService()

    if not service then
        return nil
    end

    var1:info("Joining default channel")

    local var4 = service:JoinByGroupIdToken("default", bool8)
    if var4 then
        analytics:reportVoiceChatJoinResult(true, "defaultJoinSuccess")
    else
        analytics:reportVoiceChatJoinResult(false, "defaultJoinFailed", "error")
    end

    return var4
end

local function validateSetup()
    if engineFeature2 and bool2 then
        if not NotificationService.IsConnected then
            var1:debug("NotificationService is not yet connected")
            NotificationService:GetPropertyChangedSignal("IsConnected"):Wait()
        end
        var1:debug("NotificationService connected")
    end

    if not VoiceChatService.UseNewAudioApi then
        if not Players.LocalPlayer.Character then
            Players.LocalPlayer.CharacterAdded:Wait()
            var1:debug("Player character loaded")
        else
            var1:debug("Player character already loaded")
        end
    end

    if engineFeature and bool3 then
        local var4 = game:FindService("VoiceChatService")
        if not var4 then
            var1:info("VoiceChatService not found. Assuming default values.")
        elseif not (var4.EnableDefaultVoice or var4.UseNewAudioApi) then
            var1:debug("Default channel is disabled.")
            analytics:reportVoiceChatJoinResult(false, "defaultDisabled")
            notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_SETUP, "Default channel disabled")
            return false
        end
    end
    return true
end

local function getPlayerUsersIds(): string
    local tbl3 = {}
    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(tbl3, player.UserId)
    end
    return table.concat(tbl3, ", ")
end

local function getPermissions(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl3 = { hasMicPermissions = false }

    return Promise.new(function(callback, _)
        default:hasPermissions(arg1):andThen(function(arg2)
            tbl3.hasMicPermissions = isAuthorizedPermission(arg2, default.Permissions.MICROPHONE_ACCESS)
            if not tbl3.hasMicPermissions then
                requestPermissions(arg1):andThen(callback)
                return
            end
            callback(tbl3)
        end):catch(function()
            callback(tbl3)
        end)
    end)
end

local bool8 = false

local function setupListeners()
    if bool8 then
        var1:debug("listeners already registered, skipping duplicate setup")
        return
    end

    bool8 = true

    var1:debug("setting up listeners for the first time")
    default2:subscribe("GetPermissions", function(callback, arg1)
        if fFlagFixPartyVoiceGetPermissions then
            getPermissions(arg1):andThen(callback)
            return
        end

        callback({ hasMicPermissions = true })
    end)

    handleParticipants()
    handleMicrophone()

    if FFlagEnablePartyVoiceChangersInLua then
        handleVoiceChanger()
    end

    if FFlagPartyVoiceBlockSync then
        initializeParticipantBlockListener()
    end

    if GetFFlagEnableCrossExperienceVoiceCaptureMute() then
        eventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_MUTE_ALL, function(arg1)
            func2(function()
                default2:MuteAll(true, arg1.context)
            end)
        end)
        eventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_UNMUTE_ALL, function(arg1)
            func2(function()
                default2:MuteAll(false, arg1.context)
            end)
        end)
    end

    if bool4 then
        eventManager:addObserver(CrossExperience.Constants.EVENTS.DEBUG_COMMAND, function(arg1)
            if arg1.name ~= "dump_session" then
                return
            end

            print("----------- CEV BACKGROUND -----------")
            print("Store State", HttpService:JSONEncode(store:getState()))
            print("--------------------------------------")
            print("CoreVoiceManager State:")
            print("Participants", HttpService:JSONEncode(default2.participants))
            print("Local Muted", HttpService:JSONEncode({ value = default2.localMuted }))
            print("Mute All", HttpService:JSONEncode({ value = default2.muteAll }))
            print("Muted Anyone", HttpService:JSONEncode({ value = default2._mutedAnyone }))
            print("Is Talking", HttpService:JSONEncode({ value = default2.isTalking }))
            print("Muted Players", HttpService:JSONEncode(default2.mutedPlayers))
            for value in default2.audioDevices do
                if value.Player then
                    print("Audio Device ", value.Player.UserId, " Active:", value.Active, " MutedByLocalPlayer:", value.MutedByLocalUser)
                end
            end

            print("Voice Enabled", HttpService:JSONEncode({ value = default2.voiceEnabled }))
            print("Permissions Result", HttpService:JSONEncode(default2.communicationPermissionsResult))
            print("Voice Join Progress", HttpService:JSONEncode({ value = default2.VoiceJoinProgress }))
            print("-----------------------------")
        end)
    end

    default2:subscribe("OnRequestMicPermissionRejected", function()
        notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_MIC_REJECTED, nil)
    end)

    default2:subscribe("OnPlayerModerated", function()
        notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_MODERATED, "On Player Moderated")
    end)

    default2:subscribe("OnInitialJoinFailed", function()
        notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_JOIN, "Initial Join failed")
    end)

    default2:subscribe("OnRetryRequested", function()
        notifyVoiceStatusChange(Constants.VOICE_STATUS.VOICE_RECONNECTING, "Retry requested")
    end)

    default2:subscribe("OnStateChanged", function(_, voiceChatState)
        if voiceChatState ~= Enum.VoiceChatState.Joined then
            if voiceChatState == Enum.VoiceChatState.Failed then
                notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_FAILED, nil)
            elseif voiceChatState == Enum.VoiceChatState.Ended then
                notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_DISCONNECTED, nil)
            end

            return
        end

        local voiceChannelId = default2:GetChannelId()
        local voiceSessionId = default2:GetSessionId()

        local participants = getPlayerUsersIds()
        eventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_STATUS_CHANGED, {
            userId = UserId,
            status = Constants.VOICE_STATUS.VOICE_CONNECTED,
            voiceChannelId = voiceChannelId,
            voiceSessionId = voiceSessionId,
            voicePlaySessionId = RbxAnalyticsService:GetPlaySessionId(),
            participants = participants,
            numberActive = #Players:GetPlayers(),
            cevJoinAttemptId = getMemStorageKey(CEV_JOIN_ATTEMPT_ID_KEY)
        })
        tbl1.previousGroupId = default2.service:GetGroupId()
    end)

    default2:subscribe("OnReportJoinFailed", function(detail)
        var1:error("CEV OnReportJoinFailed " .. detail)

        notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_JOIN, detail)
    end)
end

function initializeAFM()
    if not engineFeature3 then
        return
    end

    local success, result = pcall(function(): AudioFocusService
        return game:GetService("AudioFocusService")
    end)
    if not success or not result then
        var1:info("AudioFocusService did not initialize")
        return
    end

    local contextId = CrossExperience.Constants.AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID
    local focusPriority = CrossExperience.Constants.AUDIO_FOCUS_MANAGEMENT.CEV.FOCUS_PRIORITY
    result:RegisterContextIdFromLua(contextId)

    local function func12()
        if FIntPartyVoiceUndeafenDelayMS > 0 and var2 then
            task.cancel(var2)
            var2 = nil
        end

        if bool5 and not func11() or not func11 then
            default2:MuteAll(true, "AudioFocusManagement - CEV deafenAll")
        end

        if not default2.localMuted and (not bool6 or tbl1.previousMutedState == default2.localMuted) then
            default2:ToggleMic("AudioFocusManagement - CEV deafenAll")
        end
    end

    local function func13()
        if FIntPartyVoiceUndeafenDelayMS > 0 and var2 then
            task.cancel(var2)
            var2 = nil
        end

        if bool5 and not func11() or not func11 then
            default2:MuteAll(false, "AudioFocusManagement - CEV Mute All")
        end

        if default2.localMuted == nil then
            var1:info("CEV undeafenAll - Voice not connected yet - calling unmuteMicrophoneOnce")
            unmuteMicrophoneOnce()
            return
        end

        if default2.localMuted and (not bool6 or tbl1.previousMutedState ~= default2.localMuted) then
            var1:info("CEV undeafenAll - Voice connected and muted - unmuting immediately")
            default2:ToggleMic("AudioFocusManagement - CEV undeafenAll")
        end
    end

    result.OnDeafenVoiceAudio:Connect(function(contextId2: number)
        if contextId2 ~= contextId then
            return
        end

        if FIntPartyVoiceUndeafenDelayMS > 0 and var2 then
            task.cancel(var2)
            var2 = nil
        end
        var1:info("CEV OnDeafenVoiceAudio fired" .. contextId2)
        func12()
    end)

    result.OnUndeafenVoiceAudio:Connect(function(contextId2: number)
        if contextId2 ~= contextId then
            return
        end

        var1:info("CEV OnUndeafenVoiceAudio fired for context: {} - expected: {}", contextId2, contextId)

        if not (FIntPartyVoiceUndeafenDelayMS > 0) then
            var1:info("CEV OnUndeafenVoiceAudio fired" .. contextId2)
            func13()
            return
        end

        if var2 then
            task.cancel(var2)
        end
        var2 = task.delay(FIntPartyVoiceUndeafenDelayMS / 1000, function()
            var2 = nil
            var1:info("CEV OnUndeafenVoiceAudio fired delayed" .. contextId2)
            func13()
        end)
    end)

    local function func14(contextId2, focusPriority2) -- Luacid: Inlined by compiler; 1 call site recovered
        var1:info("CEV requestAudioFocusWithPromise - id: {} - priority: {}", contextId2, focusPriority2)
        return Promise.new(function(callback, callback2)
            local success2, result2 = pcall(result.RequestFocus, result, contextId2, focusPriority2)
            if success2 then
                var1:info("CEV requestAudioFocusWithPromise - focusGranted: {}", result2)
                callback(result2)
                return
            end
            var1:info("CEV requestAudioFocusWithPromise - rejected")
            callback2("Failed to call RequestFocus due to an error")
        end)
    end

    func14(contextId, focusPriority):andThen(function(arg1)
        if arg1 then
            var1:info("CEV audio focus request granted, preparing to undeafen.")
            default2.muteChanged.Event:Once(function(arg2)
                if arg2 ~= nil and bool5 and not func11() or not func11 then
                    default2:MuteAll(false, "AudioFocusManagement CEV")
                end
            end)

            return
        end

        var1:info("CEV audio focus request denied, preparing to deafen.")
        default2.muteChanged.Event:Once(function(arg2)
            if arg2 ~= nil and bool5 and not func11() or not func11 then
                default2:MuteAll(true, "AudioFocusManagement CEV")
            end
        end)
    end):catch(function()
        var1:info("[CEV] Error requesting focus inside CEV")
    end)
end

function initializeVoice()
    notifyVoiceStatusChange(Constants.VOICE_STATUS.VOICE_CONNECTING, nil)
    default2:asyncInit():andThen(function()
        if initializeDefaultChannel(false) == false then
            notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_JOIN, "Initial Join failed")
        else
            onCoreVoiceManagerInitialized()
        end
        initializeAFM()
    end):catch(function(arg1)
        var1:info("CoreVoiceManager did not initialize {}", arg1)

        local var4 = if arg1 then arg1.code or arg1 else "INIT_ERROR_UNKNOWN"

        notifyVoiceStatusChange(Constants.VOICE_STATUS.ERROR_VOICE_INIT, var4)
    end)
end

function rejoinVoice()
    notifyVoiceStatusChange(Constants.VOICE_STATUS.VOICE_CONNECTING, nil)
    if GetFFlagVoiceChatClientRewriteMasterLua() then
        default2:RejoinVoice()
    else
        default2:RejoinChannel(tbl1.previousGroupId, tbl1.previousMutedState)
    end
    tbl1 = { previousGroupId = nil, previousMutedState = nil }
end

function startVoice()
    if not validateSetup() then
        return
    end
    if FStringTimeoutLoadingLocalPlayerInBackgroundDM ~= LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable then
        UserId = ensureLocalPlayerWithTimeout()
        var1:info("Delayed loading of LocalPlayer loaded with UserId: {}", UserId)
    end
    setupListeners()
    initializeVoice()
end

eventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_RECONNECT_REQUESTED, function()
    local voiceStatus = store:getState().Squad.CrossExperienceVoice.Experience.voiceStatus
    if voiceStatus == VOICE_STATUS.ERROR_VOICE_SETUP then
        startVoice()
    elseif voiceStatus == VOICE_STATUS.ERROR_VOICE_INIT
        or fFlagFixPartyVoiceGetPermissions and voiceStatus == VOICE_STATUS.ERROR_VOICE_MIC_REJECTED
    then
        initializeVoice()
    elseif voiceStatus == VOICE_STATUS.ERROR_VOICE_JOIN
        or not fFlagFixPartyVoiceGetPermissions and voiceStatus == VOICE_STATUS.ERROR_VOICE_MIC_REJECTED
        or voiceStatus == VOICE_STATUS.ERROR_VOICE_MODERATED
        or voiceStatus == VOICE_STATUS.ERROR_VOICE_FAILED
        or voiceStatus == VOICE_STATUS.ERROR_VOICE_DISCONNECTED
    then
        rejoinVoice()
    end
end)
local bool9 = false
local function doStartVoice() -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool9 then
        return
    end
    bool9 = true

    if var3 then
        eventManager:removeObserver(var3, CrossExperience.Constants.EVENTS.FOREGROUND_UI_READY)
        var3 = nil
    end

    var1:info("Proceeding to start voice connection.")
    startVoice()
end

sendAnalyticsEvent("startingVoiceFromCEVDefaultChannel")

if not engineFeature4 then
    var1:info("Foreground UI not using readiness sync. Starting voice connection immediately.")
    startVoice()
    return
end

if bool7 then
    var1:info("Foreground was ready before setup finished. Starting voice now.")
    doStartVoice()
    return
end

var1:info("Waiting for foreground UI readiness signal (with promise race)...")

local promise = Promise.new(function(callback)
    bindableEvent.Event:Once(function()
        callback("signal")
    end)
end)

local var4 = Promise.delay(timeout):andThen(function(): string
    return "timeout"
end)

Promise.race({ promise, var4 }):andThen(function(arg1)
    if arg1 == "signal" then
        var1:info("Readiness signal received within timeout.")
    else
        var1:info("Timed out waiting for readiness signal. Starting voice anyway.")
        sendAnalyticsEvent("partyVoiceInitTimedOut", { timeout = timeout })
    end

    doStartVoice()
end)
