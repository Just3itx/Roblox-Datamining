-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:20:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")
local VoiceChatService = game:GetService("VoiceChatService")
local HttpService = game:GetService("HttpService")
local FFlagUseAudioDeviceInputAddedSignal = require(scriptParentParent.SharedFlags).FFlagUseAudioDeviceInputAddedSignal
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local AppStorageService = game:GetService("AppStorageService")
local NotificationService = game:GetService("NotificationService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local IXPServiceWrapper = require(scriptParentParent.IXPServiceWrapper).IXPServiceWrapper
local Players2 = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")
local AdService = game:GetService("AdService")
local Chat = game:GetService("Chat")

local Constants = require(script.Parent.Constants)
local Utils = require(script.Parent.Utils)
local Flags = script.Parent.Flags
local Analytics = require(script.Parent.Analytics)
local Requests = script.Parent.Requests

local Promise = require(scriptParentParent.Promise)
local Cryo = require(scriptParentParent.Cryo)
local default = require(scriptParentParent.CallProtocol).CallProtocol.default
local Enums = require(scriptParentParent.CallProtocol).Enums
local PermissionsProtocol = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol
local BlockingUtility = require(scriptParentParent.BlockingUtility)

local CoreGui = game:GetService("CoreGui")

local log = require(scriptParentParent.CoreScriptsInitializer).CoreLogger:new(script.Name)

local bool1 = game:DefineFastFlag("StringKeyFixForParticipantsTable", false)
local bool2 = game:DefineFastFlag("ConsoleVoiceIXPEnabled", false)
local FFlagExpChatDictation = require(scriptParentParent.SharedFlags).FFlagExpChatDictation

local str1 = game:DefineFastString("ConsoleVoiceIXPLayerName", "User.Communication.ConsoleVoice")

local str2 = game:DefineFastString("ConsoleVoiceEnabledIXPLayerValue", "ConsoleVoiceEnabled")

local bool3 = game:DefineFastFlag("SendVoiceCapturedDuringVideoCaptureEvent", false)

game:DefineFastInt("VoiceRewarmReArmCount", 0)

local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = require(scriptParentParent.SharedFlags).GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice
local GetFFlagLuaConsumePlayerModerated = require(Flags.GetFFlagLuaConsumePlayerModerated)
local GetFFlagLocalMutedNilFix = require(scriptParentParent.SharedFlags).GetFFlagLocalMutedNilFix
local GetFFlagEnableVoiceReverseNudge = require(Flags.GetFFlagEnableVoiceReverseNudge)
local GetFFlagClearUserFromRecentVoiceDataOnLeave = require(Flags.GetFFlagClearUserFromRecentVoiceDataOnLeave)
local GetFIntVoiceUsersInteractionExpiryTimeSeconds = require(Flags.GetFIntVoiceUsersInteractionExpiryTimeSeconds)
local GetFFlagAvatarChatServiceEnabled = require(scriptParentParent.SharedFlags).GetFFlagAvatarChatServiceEnabled
local GetFFlagVoiceChatServiceManagerUseAvatarChat = require(Flags.GetFFlagVoiceChatServiceManagerUseAvatarChat)
local GetFFlagJoinWithoutMicPermissions = require(scriptParentParent.SharedFlags).GetFFlagJoinWithoutMicPermissions
local GetFFlagBatchVoiceParticipantsUpdates = require(Flags.GetFFlagBatchVoiceParticipantsUpdates)
local GetFIntThrottleParticipantsUpdateMs = require(Flags.GetFIntThrottleParticipantsUpdateMs)
local GetFFlagSeamlessVoiceFTUX = require(scriptParentParent.SharedFlags).GetFFlagSeamlessVoiceFTUX
local GetFFlagEnableFtuxExitOnMuteToggle = require(Flags.GetFFlagEnableFtuxExitOnMuteToggle)
local GetFFlagEnableSeamlessVoiceFeature = require(Flags.GetFFlagEnableSeamlessVoiceFeature)
local GetFFlagFixGetPlayerByUserIdStringCast = require(Flags.GetFFlagFixGetPlayerByUserIdStringCast)
local var2 = require(scriptParentParent.SharedFlags).GetFFlagDebugShowAudioDeviceInputDebugger()

local str3 = game:DefineFastString("VoicePerformanceThrottlingIXPLayerName", "Voice.Performance")

local str4 = game:DefineFastString("ThrottleParticipantsUpdateIXPLayerValue", "ThrottleParticipantsUpdate")
local var3 = require(Flags.GetFFlagUseAudioAnalyzerForLocalMetering2)()
local bool4 = game:DefineFastFlag("StopModerationConnectionOnLeave", false)

local engineFeature = game:GetEngineFeature("VoiceVolumeControlsApplyGameSettingsVoiceVolume")

local bool5 = game:DefineFastFlag("VoiceVolumeControlsEnableVoiceVolumeEligibilityTelemetry", false)

local var4 = require(Flags.GetFFlagVoiceVolumeControlsEnableVoiceVolumeImpressionsTelemetry)()
local VoiceVolumeControlsEligibility = require(scriptParent.VoiceVolumeControlsEligibility)

local engineFeature2 = game:GetEngineFeature("EnableMutedByLocalUser")
local bool6 = game:DefineFastFlag("VoiceChatMuteAllSyncMutedPlayers", false)

local engineFeature3 = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local GetFFlagEnableVoiceChatMuteForVideoCaptures = require(scriptParentParent.SharedFlags).GetFFlagEnableVoiceChatMuteForVideoCaptures
local fFlagEnableVoiceChatMuteForVideoCaptures = bool3 and GetFFlagEnableVoiceChatMuteForVideoCaptures()
local GetFFlagDebugVoiceChatMicPermissionCliBypass = require(Flags.GetFFlagDebugVoiceChatMicPermissionCliBypass)

local GetFFlagEnableVoiceSignal = require(scriptParentParent.SharedFlags).GetFFlagEnableVoiceSignal

local GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints = require(scriptParentParent.SharedFlags).GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints
local GetFFlagVoiceChatClientRewriteMasterLua = require(scriptParentParent.SharedFlags).GetFFlagVoiceChatClientRewriteMasterLua

local GetFFlagCheckUniversePlaceBeforeSuspending = require(scriptParentParent.SharedFlags).GetFFlagCheckUniversePlaceBeforeSuspending
local FFlagEnablePartyVoiceChangersInLua = require(scriptParentParent.SharedFlags).FFlagEnablePartyVoiceChangersInLua
local FFlagSkipVoiceInTeamCreateViewer = require(Flags.FFlagSkipVoiceInTeamCreateViewer)
local GetFFlagCoreMicManagerRefactor = require(Flags.GetFFlagCoreMicManagerRefactor)
local GetFFlagMicConsumerRegistry = require(Flags.GetFFlagMicConsumerRegistry)
local MicInputManager = if GetFFlagCoreMicManagerRefactor() then require(script.Parent.MicInputManager) else nil
local WATCHED_NAMESPACES = Constants.WATCHED_NAMESPACES
local WATCHED_MESSAGE_TYPES = Constants.WATCHED_MESSAGE_TYPES
local VOICE_CHAT_AVAILABILITY = Constants.VOICE_CHAT_AVAILABILITY
local MIN_VOICE_CHAT_API_VERSION_IS_CONTEXT_ENABLED = Constants.MIN_VOICE_CHAT_API_VERSION_IS_CONTEXT_ENABLED
local MIN_VOICE_CHAT_API_VERSION_LOCAL_MIC_ACTIVITY = Constants.MIN_VOICE_CHAT_API_VERSION_LOCAL_MIC_ACTIVITY
local PERMISSION_STATE = Constants.PERMISSION_STATE
local VOICE_JOIN_PROGRESS = Constants.VOICE_JOIN_PROGRESS
local FAE_ENABLED = Constants.FAE_ENABLED
local FAE_SETTINGS_TOAST = Constants.FAE_SETTINGS_TOAST

local GetShowAgeVerificationOverlay = require(Requests.GetShowAgeVerificationOverlay)
local GetShowPhoneVerificationUpsell = require(Requests.GetShowPhoneVerificationUpsell)

local tbl1 = {
    eventName = "VoiceCapturedDuringVideoCapture",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("VoiceCapturedDuringVideoCaptureThrottlingPercentage", 10000),
    lastUpdated = { 26, 1, 28 },
    description = "Event fired when a video capture has stopped logging if voice was captured",
    links = ""
}
local AvatarChatService = if GetFFlagAvatarChatServiceEnabled() then game:GetService("AvatarChatService") else nil
local CaptureService = if GetFFlagEnableVoiceChatMuteForVideoCaptures() then game:GetService("CaptureService") else nil
local TelemetryService = if fFlagEnableVoiceChatMuteForVideoCaptures then game:GetService("TelemetryService") else nil
local module = {
    available = nil,
    canUseServicePromise = nil,
    userEligible = false,
    participants = nil,
    localMuted = nil,
    isVoiceChangerActive = false,
    isVoiceChangerHearMyselfActive = false,
    currentVoicePack = nil,
    isTalking = false,
    previousGroupId = nil,
    muteAll = false,
    previousMutedState = nil,
    permissionPromise = nil,
    hasOptedToJoinVoiceOnAgeVerification = false,
    permissionState = if GetFFlagJoinWithoutMicPermissions() then PERMISSION_STATE.IDLE else nil,
    recentUsersInteractionData = nil,
    NotificationService = NotificationService,
    PermissionsService = PermissionsProtocol.default,
    ChatService = Chat,
    voiceEnabled = false,
    service = nil,
    SignalREventTable = {},
    isInCall = false,
    callMutedState = false,
    audioDeviceInputAdded = nil,
    muteChanged = Instance.new("BindableEvent"),
    voiceChangerChanged = Instance.new("BindableEvent"),
    voiceChangerHearMyselfChanged = Instance.new("BindableEvent"),
    muteAllChanged = Instance.new("BindableEvent"),
    participantLeft = Instance.new("BindableEvent"),
    participantJoined = Instance.new("BindableEvent"),
    participantsUpdate = Instance.new("BindableEvent"),
    talkingChanged = Instance.new("BindableEvent"),
    attemptVoiceRejoin = Instance.new("BindableEvent"),
    onPlayerMuteToggled = Instance.new("BindableEvent"),
    setVoiceUIVisibility = Instance.new("BindableEvent"),
    communicationPermissionsResult = nil,
    VoiceJoinProgress = VOICE_JOIN_PROGRESS.Idle,
    VoiceJoinProgressChanged = Instance.new("BindableEvent"),
    _voiceVolumeEligibilityReported = false,
    mutedPlayers = {},
    voiceChangerActivePlayers = {},
    BlockStatusChanged = nil,
    AvatarChatService = AvatarChatService,
    HttpRbxApiService = HttpRbxApiService,
    ThirdPartyUserService = ThirdPartyUserService,
    CaptureService = CaptureService,
    TelemetryService = TelemetryService,
    SendMuteEvent = nil,
    SetVoicePackEvent = nil,
    VoiceChangerWasToggledEvent = nil,
    InputToModifierWire = nil,
    PartyVoiceDeviceInput = nil,
    _mutedAnyone = false,
    canUseServiceResult = nil,
    signalRConnectionChanged = nil,
    signalRConnection = nil,
    AdService = AdService,
    isPlayerWatchingAd = false,
    options = {
        allowSeamlessVoice = true,
        passInitErrorInPromiseReject = false,
        forceVoiceEnabled = false
    },
    initializedPostSuspension = false,
    voiceCapturedDuringVideoCapture = false,
    _voiceJoinTimestampMs = nil,
    _voiceVolumeSliderEligibleAtJoin = false,
    _gameSettingsOpenedTimestampMs = nil
}

local tbl2 = { localMuted = true, isTalking = true, permissionState = true }

function module.__index(tbl3: {[string]: any}, arg1)
    if GetFFlagCoreMicManagerRefactor() then
        local var5 = rawget(tbl3, "micManager")
        if var5 and tbl2[arg1] then
            return var5[arg1]
        end
    end
    return module[arg1]
end

function module.__newindex<T, U>(tbl3: {[T]: U}, arg1: T, arg2: U)
    if GetFFlagCoreMicManagerRefactor() then
        local var5 = rawget(tbl3, "micManager")
        if var5 and tbl2[arg1] then
            var5[arg1] = arg2
            return
        end
    end
    rawset(tbl3, arg1, arg2)
end

function module.new(blockStatusChanged, PermissionsService, httpRbxApiService, service, arg1, notificationService, avatarChatService, appStorageService, thirdPartyUserService, captureService, adService)
    local var5 = setmetatable({
        previousSessionId = nil,
        HttpRbxApiService = httpRbxApiService,
        eventEmitter = Utils.EventEmitter.new(),
        service = service,
        PermissionsService = PermissionsService,
        NotificationService = notificationService,
        AvatarChatService = avatarChatService,
        Analytics = Analytics.new(arg1),
        SequenceNumbers = {},
        SignalREventTable = {},
        audioDevices = {},
        BlockStatusChanged = blockStatusChanged,
        AppStorageService = appStorageService or AppStorageService,
        ThirdPartyUserService = thirdPartyUserService,
        CaptureService = captureService,
        AdService = adService
    }, module)

    for _, value in WATCHED_MESSAGE_TYPES do
        var5.SignalREventTable[value] = Instance.new("BindableEvent")
    end

    var5.shouldThrottleParticipantUpdate = false
    var5.participantsStateThrottleTime = 0
    var5.lastParticipantsStateUpdate = 0
    var5.lastStateUpdateCounter = 0
    if GetFIntThrottleParticipantsUpdateMs() > 0 then
        task.spawn(function()
            local success, result = pcall(function()
                if Players2.LocalPlayer then
                    return service:IsVoiceEnabledForUserIdAsync(Players2.LocalPlayer.UserId)
                end
                return false
            end)
            if not success then
                log:debug("Unable to get voice enabled status: ", result)
            elseif result then
                IXPServiceWrapper:LogUserLayerExposure(str3)
            end
        end)

        var5.participantsStateThrottleTime = GetFIntThrottleParticipantsUpdateMs() / 1000
        local success, result = pcall(function()
            return IXPServiceWrapper:GetLayerData(str3)
        end)
        if success and result and result[str4] then
            var5.shouldThrottleParticipantUpdate = true
        end
    end

    if GetFFlagCoreMicManagerRefactor() then
        var5.micManager = MicInputManager.new({
            log = log,
            callbacks = {
                emitGetPermissions = function(arg2, arg3, arg4, arg5)
                    var5:emit("GetPermissions", arg2, arg3, arg4, arg5)
                end,
                emitOnPermissionRequested = function()
                    var5:emit("OnPermissionRequested")
                end,
                emitOnRequestMicPermissionResolved = function()
                    var5:emit("OnRequestMicPermissionResolved")
                end,
                emitOnRequestMicPermissionRejected = function()
                    var5:emit("OnRequestMicPermissionRejected")
                end,
                emitOnShowDataConsentToast = function()
                    var5:emit("OnShowDataConsentToast")
                end,
                emitOnMicPermissionDeniedToast = function()
                    var5:emit("OnMicPermissionDeniedToast")
                end,
                emitOnMicFirstUnmutePrivacy = function()
                    var5:emit("OnMicFirstUnmutePrivacy")
                end,
                getAudioDevices = function()
                    return var5.audioDevices
                end,
                getSendMuteEvent = function()
                    return var5:GetSendMuteEvent()
                end,
                isSignalActive = function(arg2)
                    return var5:IsSignalActive(arg2)
                end,
                reportVoiceMuteSelf = function(arg2)
                    var5.Analytics:reportVoiceMuteSelf(arg2)
                end,
                getJoinWithVoiceMuteData = function(arg2)
                    return var5:JoinWithVoiceMuteData(arg2)
                end,
                recordExperienceJoinMicPerm = function(arg2)
                    var5:RecordExperienceJoinMicPermissionStatus(arg2)
                end,
                reportJoinFailed = function(arg2, arg3)
                    var5:_reportJoinFailed(arg2, arg3 or Analytics.ERROR)
                end,
                requestPermissions = function(arg2)
                    return var5.PermissionsService:requestPermissions(arg2)
                end,
                getPassInitErrorInPromiseReject = function()
                    return var5.options.passInitErrorInPromiseReject
                end,
                onVoiceCapturedDuringVideoCapture = function(arg2)
                    if fFlagEnableVoiceChatMuteForVideoCaptures and var5.CaptureService:IsCapturingVideo() then
                        var5.voiceCapturedDuringVideoCapture = var5.voiceCapturedDuringVideoCapture or arg2
                    end
                end,
                getService = function()
                    return var5.service
                end
            }
        })
        var5.muteChanged = var5.micManager.muteChanged
        var5.talkingChanged = var5.micManager.talkingChanged

        if GetFFlagMicConsumerRegistry() then
            var5.hasConsumersChanged = var5.micManager.hasConsumersChanged
            var5.micManager:SetupDeveloperDeviceTracking()
        end
    end

    return var5
end

function module.emit(tbl3, str5: string, ...)
    tbl3.eventEmitter:emit(str5, ...)
end

function module.subscribe(tbl3, str5: string, arg1)
    tbl3.eventEmitter:addListener(str5, arg1)
end

function module.unsubscribe(tbl3, str5: string, arg1)
    tbl3.eventEmitter:removeListener(str5, arg1)
end

function module.unsubscribeAll(arg1)
    arg1.eventEmitter:removeAllListeners()
end

function module.CheckCallStateWithPromise(arg1)
    return default:getCallState():andThen(function(arg2)
        log:trace("Got user call state")

        if arg2.status ~= Enums.CallStatus.Idle.rawValue() and arg2.status ~= Enums.CallStatus.Ringing.rawValue() then
            arg1.isInCall = true
            arg1.callMutedState = arg2.muted
            log:trace("Changing call muted state to {}", arg2.muted)
        end
    end):catch(function(arg2)
        log:trace("User not in call {}", arg2)
    end)
end

function module.CheckCallState(arg1)
    log:trace("Checking user call state")
    local success, result = pcall(function()
        default:getCallState():andThen(function(arg2)
            log:trace("Got user call state")

            if arg2.status ~= Enums.CallStatus.Idle.rawValue() and arg2.status ~= Enums.CallStatus.Ringing.rawValue() then
                arg1.isInCall = true
                arg1.callMutedState = arg2.muted
                log:trace("Changing call muted state to {}", arg2.muted)
            end
        end):catch(function(arg2)
            log:trace("User not in call {}", arg2)
        end)
    end)
    if not success then
        log:debug("Error checking user call state {}", result)
    end
end

function module._GetShowAgeVerificationOverlay(arg1, arg2)
    return GetShowAgeVerificationOverlay(Utils.bind(arg1, "GetRequest"), tostring(game.GameId), tostring(game.PlaceId), arg2)
end

function module.FetchAgeVerificationOverlay(arg1, arg2)
    if not arg1._getShowAgeVerificationOverlayResult then
        if not arg1._getShowAgeVerificationOverlayPromise then
            arg1._getShowAgeVerificationOverlayPromise = Promise.new(function(callback, _)
                arg1._getShowAgeVerificationOverlayResult = arg1:_GetShowAgeVerificationOverlay(arg2)
                callback(arg1._getShowAgeVerificationOverlayResult)
            end)
        end
        arg1._getShowAgeVerificationOverlayPromise:await()
    end
    return arg1._getShowAgeVerificationOverlayResult
end

function module._GetShowPhoneVerificationUpsell(tbl3, str5: string, num1: number?)
    return (GetShowPhoneVerificationUpsell(Utils.bind(tbl3, "GetRequest"), tostring(game.GameId), str5, num1))
end

function module.FetchPhoneVerificationUpsell(tbl3, str5: string, num1: number?, bool7: boolean?)
    if not tbl3._getShowPhoneVerificationUpsellResult then
        tbl3._getShowPhoneVerificationUpsellResult = {}
        tbl3._getShowPhoneVerificationUpsellPromise = {}
    end
    if not tbl3._getShowPhoneVerificationUpsellResult[str5] or bool7 then
        if not tbl3._getShowPhoneVerificationUpsellPromise[str5] or bool7 then
            tbl3._getShowPhoneVerificationUpsellPromise[str5] = Promise.new(function(callback, _)
                local var5 = tbl3:_GetShowPhoneVerificationUpsell(str5, num1)
                local _getShowPhoneVerificationUpsellResult = tbl3._getShowPhoneVerificationUpsellResult
                local str6 = str5
                _getShowPhoneVerificationUpsellResult[str6] = if type(var5) == "table" and var5.valueProp ~= nil then var5.valueProp else Constants.PHONE_UPSELL_VOICE_CHAT_PROP.None

                callback()
            end)
        end
        tbl3._getShowPhoneVerificationUpsellPromise[str5]:await()
    end
    return tbl3._getShowPhoneVerificationUpsellResult[str5]
end

function module.DisablePhoneVerificationUpsell(arg1)
    arg1._getShowPhoneVerificationUpsellResult = Cryo.Dictionary.map(arg1._getShowPhoneVerificationUpsellResult, function()
        return Constants.PHONE_UPSELL_VOICE_CHAT_PROP.None
    end)
end

function module.GetNudgeAnalyticsData(arg1)
    return Players.LocalPlayer.UserId, arg1:GetSessionId()
end

function module.avatarChatUserAndPlaceSettingsValueOfClientFeatures(arg1, arg2)
    return {
        universePlaceVoiceEnabledSettings = {
            isUniverseEnabledForVoice = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UniverseAudio),
            isPlaceEnabledForVoice = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.PlaceAudio),
            isUniverseEnabledForAvatarVideo = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UniverseVideo),
            isPlaceEnabledForAvatarVideo = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.PlaceVideo)
        },
        voiceSettings = {
            isUserEligible = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UserAudioEligible),
            isVoiceEnabled = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UserAudio),
            isAvatarVideoEligible = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UserVideoEligible),
            isAvatarVideoEnabled = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UserVideo),
            isUserVerifiedForVoice = if GetFFlagEnableVoiceSignal() then arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UserVerifiedForVoice) else nil,
            isBanned = arg1.AvatarChatService:IsEnabled(arg2, Enum.AvatarChatServiceFeature.UserBanned),
            bannedUntil = nil
        }
    }
end

function module.resolveAvatarChatUserAndPlaceSettings(arg1)
    local success, result = pcall(arg1.AvatarChatService.GetClientFeaturesAsync, arg1.AvatarChatService)

    if not success then
        return nil
    end

    return arg1:avatarChatUserAndPlaceSettingsValueOfClientFeatures(result)
end

function module.GetRequest(arg1, arg2, _)
    local success, result = pcall(function()
        local asyncFullUrl = arg1.HttpRbxApiService:GetAsyncFullUrl(arg2, Enum.ThrottlingPriority.Default, Enum.HttpRequestType.Players)
        return HttpService:JSONDecode(asyncFullUrl)
    end)
    return success and result
end

function module.PostUserVoiceConnectionStatus(arg1, isUserVoiceConnected): boolean
    local success, _result = pcall(function()
        local str5 = HttpService:JSONEncode({ IsUserVoiceConnected = isUserVoiceConnected })

        local input = arg1.HttpRbxApiService:PostAsyncFullUrl(Constants.VOICE_URL .. "/v1/user-voice-connection-state", str5)
        return HttpService:JSONDecode(input)
    end)
    return success
end

function module.GetVoiceAnalyticsData(arg1)
    return {
        universeId = game.GameId,
        placeId = game.PlaceId,
        playSessionId = if engineFeature3 then RbxAnalyticsService:GetPlaySessionId() else "",
        voiceSessionId = if arg1.service then arg1:GetSessionId() else "",
        micAvailability = ""
    }
end

function module.RecordExperienceJoinMicPermissionStatus(arg1, arg2)
    local voiceAnalyticsData = arg1:GetVoiceAnalyticsData()
    if arg2 ~= nil and typeof(arg2) == "table" then
        if arg2.status == PermissionsProtocol.Status.AUTHORIZED then
            voiceAnalyticsData.micAvailability = "Granted"
        else
            voiceAnalyticsData.micAvailability = "Denied"
        end
    elseif arg1.permissionState then
        if arg1.permissionState == PERMISSION_STATE.LISTEN_AND_TALK then
            voiceAnalyticsData.micAvailability = "Granted"
        else
            voiceAnalyticsData.micAvailability = "Denied"
        end
    end
    arg1.Analytics:reportVoiceEvents("experienceJoinDeviceMicPermissionEvent", voiceAnalyticsData)
end

function module.CheckCaptureMute(arg1)
    if GetFFlagEnableVoiceChatMuteForVideoCaptures() then
        return arg1.CaptureService:IsCapturingVideo()
    end
    return false
end

function module.ToggleMuteSome(tbl3, tbl4, bool7: boolean, groupType: string, context: string)
    tbl3:ensureInitialized("mute some players")
    tbl3._mutedAnyone = true
    local tbl5 = ({})
    bool7 = bool7 or tbl3:CheckCaptureMute()
    for _, value in tbl4 do
        if VoiceChatService.UseNewAudioApi then
            tbl5[value] = true
            tbl3.mutedPlayers[value] = bool7
        else
            tbl3.service:SubscribePause(value, bool7)
        end
        local participant = tbl3.participants[tostring(value)]
        if participant then
            participant.isMutedLocally = bool7
            tbl3.participantsUpdate:Fire(tbl3.participants)
        end
    end

    if VoiceChatService.UseNewAudioApi then
        for value in tbl3.audioDevices do
            if not (value.Player and tbl5[value.Player.UserId]) then
                continue
            end

            if engineFeature2 and value.Player ~= Players.LocalPlayer then
                value.MutedByLocalUser = bool7
            else
                value.Active = not bool7
            end
        end
    end

    if not groupType or not context then
        return
    end

    tbl3.Analytics:reportVoiceMuteGroup(
        (tbl3:JoinWithVoiceMuteData({ groupType = groupType, context = context, muted = bool7 }))
    )
end

function module.GetMutedAnyone(arg1)
    return arg1._mutedAnyone
end

function module.RecordGameSettingsOpened(arg1)
    if var4 and engineFeature and arg1._voiceJoinTimestampMs and not arg1._gameSettingsOpenedTimestampMs then
        arg1._gameSettingsOpenedTimestampMs = DateTime.now().UnixTimestampMillis
    end
end

function module.ResetVoiceVolumeImpressionsSession(arg1)
    if var4 and engineFeature then
        arg1._voiceJoinTimestampMs = nil
        arg1._voiceVolumeSliderEligibleAtJoin = false
        arg1._gameSettingsOpenedTimestampMs = nil
    end
end

function module.ReportVoiceVolumeImpressionsIfNeeded(arg1)
    if not (var4 and engineFeature and arg1._voiceJoinTimestampMs and arg1._voiceVolumeSliderEligibleAtJoin) then
        return
    end

    local sliderSeen = arg1._gameSettingsOpenedTimestampMs ~= nil
    local voiceAnalyticsData = arg1:GetVoiceAnalyticsData()
    arg1.Analytics:reportVoiceVolumeImpressions({
        playSessionId = voiceAnalyticsData.playSessionId,
        voiceSessionId = voiceAnalyticsData.voiceSessionId,
        sliderSeen = sliderSeen,
        voiceJoinTimestampMs = arg1._voiceJoinTimestampMs,
        sliderSeenTimestampMs = arg1._gameSettingsOpenedTimestampMs
    })
    arg1:ResetVoiceVolumeImpressionsSession()
end

function module.ToggleMutePlayer(tbl3, userId: number, context: string)
    tbl3:ensureInitialized("mute player " .. userId)
    tbl3._mutedAnyone = true

    local var5 = (if VoiceChatService.UseNewAudioApi then not tbl3.mutedPlayers[userId] else not tbl3.service:IsSubscribePaused(userId))
        or tbl3:CheckCaptureMute()
    log:trace("Setting mute for {} to {}", Utils.shorten(userId), var5)
    if GetFFlagEnableFtuxExitOnMuteToggle() then
        tbl3.onPlayerMuteToggled:Fire()
    end

    if VoiceChatService.UseNewAudioApi then
        tbl3.mutedPlayers[userId] = var5
        for value in tbl3.audioDevices do
            if not value.Player or value.Player.UserId ~= userId then
                continue
            end

            if engineFeature2 and value.Player ~= Players.LocalPlayer then
                value.MutedByLocalUser = var5
            else
                local participant = tbl3.participants[tostring(userId)]
                local var6 = participant and not participant.isMuted

                if var5 then
                    var6 = false
                end

                value.Active = var6
            end
        end

        tbl3:emit("OnPlayerMuted")
    else
        tbl3.service:SubscribePause(userId, var5)
    end

    for _, participant in pairs(tbl3.participants) do
        if participant.userId == userId then
            participant.isMutedLocally = var5
            tbl3.participantsUpdate:Fire(tbl3.participants)
        end
    end

    if not context then
        return
    end

    tbl3.Analytics:reportVoiceMuteIndividual(
        (tbl3:JoinWithVoiceMuteData({ targetUserId = tonumber(userId), context = context, muted = var5 }))
    )
end

function module.MuteAll(tbl3, bool7: boolean, context: string)
    tbl3:ensureInitialized("mute all")
    tbl3._mutedAnyone = true
    bool7 = bool7 or tbl3:CheckCaptureMute()
    if VoiceChatService.UseNewAudioApi then
        tbl3.muteAll = bool7
        log:trace("Setting self mute all to {} context: {}", bool7, context)
        if bool6 and not bool7 then
            table.clear(tbl3.mutedPlayers)
        end

        for value in tbl3.audioDevices do
            if not value.Player or value.Player == Players.LocalPlayer then
                continue
            end

            log:debug("Local muting {} to '{} = {}'", value.Player.Name, value.Active, bool7)
            if engineFeature2 then
                value.MutedByLocalUser = bool7
                if bool6 then
                    tbl3.mutedPlayers[value.Player.UserId] = bool7
                end
            else
                local userId = value.Player.UserId
                tbl3.mutedPlayers[userId] = bool7
                local participant = tbl3.participants[tostring(userId)]
                local var5 = participant and not participant.isMuted
                if bool7 then
                    var5 = false
                end

                value.Active = var5
            end
        end
    else
        tbl3.service:SubscribePauseAll(bool7)
    end

    for _, participant in pairs(tbl3.participants) do
        participant.isMutedLocally = bool7
        tbl3.participantsUpdate:Fire(tbl3.participants)
    end
    tbl3.muteAllChanged:Fire(bool7)

    if not context then
        return
    end

    tbl3.Analytics:reportVoiceMuteGroup(
        (tbl3:JoinWithVoiceMuteData({ groupType = Constants.VOICE_GROUP_TYPE.ALL, context = context, muted = bool7 }))
    )
end

function module.FetchVoicePermissions(arg1)
    if not arg1.communicationPermissionsResult then
        arg1.communicationPermissionsResult = arg1:resolveAvatarChatUserAndPlaceSettings()
    end
    return arg1.communicationPermissionsResult
end

function module.verifyUniverseAndPlaceCanUseVoice(arg1)
    local var5 = if GetFFlagAvatarChatServiceEnabled() and GetFFlagVoiceChatServiceManagerUseAvatarChat() then arg1:resolveAvatarChatUserAndPlaceSettings() else arg1:FetchAgeVerificationOverlay()

    if not var5 then
        arg1:_reportJoinFailed("invalidResponse", Analytics.ERROR)
        return false
    end

    local universePlaceVoiceEnabledSettings = var5.universePlaceVoiceEnabledSettings

    return universePlaceVoiceEnabledSettings
        and universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice
        and universePlaceVoiceEnabledSettings.isUniverseEnabledForVoice
end

function module.IsUserInFTUX(arg1): boolean
    if not GetFFlagSeamlessVoiceFTUX() then
        return false
    end
    if GetFFlagCheckUniversePlaceBeforeSuspending() and not arg1:verifyUniverseAndPlaceCanUseVoice() then
        return false
    end

    local AppStorageService2 = game:GetService("AppStorageService")
    local var5 = nil
    if not pcall(function()
        var5 = AppStorageService2:GetItem("SeamlessVoiceFTUX") == "true"
    end) then
        log:warning("Failed to read FTUX/STUX from AppStorage")
        return false
    end

    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()

    if type(ageVerificationOverlayResult) ~= "table"
        or not ageVerificationOverlayResult.voiceSettings
        or ageVerificationOverlayResult.voiceSettings.seamlessVoiceStatus == 3
    then
        return not var5
    end

    log:debug("User not eligible for FTUX/STUX")
    return false
end

function module.isEnableDefaultVoiceOnForPlace(_): boolean
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    return VoiceChatService.UseNewAudioApi or VoiceChatService.EnableDefaultVoice
end

function module.verifyPlaceCanUseVoice(arg1, arg2, arg3): boolean
    if not (arg2 and arg3) then
        arg1:_reportJoinFailed("invalidResponse", Analytics.ERROR)
        return false
    end

    if not arg2.isUniverseEnabledForVoice then
        arg1:_reportJoinFailed("universeNotEnabled")
        return false
    end

    arg1:emit("OnUserAndPlaceCanUseVoiceResolved", arg3, arg2)

    if arg2.isPlaceEnabledForVoice then
        return not not arg1:isEnableDefaultVoiceOnForPlace()
    end

    arg1:_reportJoinFailed("placeNotEnabled")
    return false
end

function module.EligibleForFaeUpsell(arg1)
    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
    if not ageVerificationOverlayResult or type(ageVerificationOverlayResult) ~= "table" then
        return false
    end
    local bool7 = ageVerificationOverlayResult.inExperienceFaeUpsell == FAE_ENABLED
    local isPlaceEnabledForVoice = ageVerificationOverlayResult.universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice
    return bool7 and isPlaceEnabledForVoice
end

function module.OptUserToJoinVoice(arg1)
    log:debug("Opting user to join voice on age verification")
    arg1.hasOptedToJoinVoiceOnAgeVerification = true
end

function module.SetupFAECompleteListener(arg1)
    log:debug("Setting up FAE complete listener")
    if not game:GetEngineFeature("ChatReconcileAccess") then
        return
    end

    log:debug("Using ChatService ReconcileCommunicationAccessCompleted event")
    arg1.ChatService.ReconcileCommunicationAccessCompleted:Connect(function()
        log:debug("FAE complete listener triggered, re-fetching voice permissions")

        arg1.communicationPermissionsResult = nil
        arg1:FetchVoicePermissions()
        arg1._getShowAgeVerificationOverlayResult = arg1:_GetShowAgeVerificationOverlay()

        if not arg1.hasOptedToJoinVoiceOnAgeVerification then
            return
        end

        log:debug("FAE complete listener triggered, attempting voice rejoin")
        if arg1:IsSeamlessVoice() then
            log:debug("Opting-in user to voice")
            arg1.AvatarChatService:EnableVoice()
            arg1.attemptVoiceRejoin:Fire()
        end
    end)
end

function module.EligibleForAgeCheckToast(arg1)
    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
    if not ageVerificationOverlayResult or type(ageVerificationOverlayResult) ~= "table" then
        return false
    end
    local isPlaceEnabledForVoice = ageVerificationOverlayResult.universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice
    local bool7 = ageVerificationOverlayResult.inExperienceFaeUpsell == FAE_SETTINGS_TOAST
    return isPlaceEnabledForVoice and arg1:isEnableDefaultVoiceOnForPlace() and bool7
end

function module.userAndPlaceCanUseVoice(arg1)
    if arg1.ThirdPartyUserService ~= nil
        and arg1.ThirdPartyUserService:IsChatRestrictionSupported()
        and arg1.ThirdPartyUserService:GetVoiceChatRestrictionStatus() ~= Enum.ChatRestrictionStatus.NotRestricted
    then
        return false
    end

    local showAgeVerificationOverlay = if GetFFlagAvatarChatServiceEnabled() and GetFFlagVoiceChatServiceManagerUseAvatarChat() then arg1:resolveAvatarChatUserAndPlaceSettings() else GetShowAgeVerificationOverlay(Utils.bind(arg1, "GetRequest"), tostring(game.GameId), tostring(game.PlaceId))

    if not showAgeVerificationOverlay then
        arg1:_reportJoinFailed("invalidResponse", Analytics.ERROR)
        return false
    end

    if arg1.options.forceVoiceEnabled then
        showAgeVerificationOverlay.voiceSettings.isVoiceEnabled = true
        log:debug("bypassing voice permissions check")
    end

    local universePlaceVoiceEnabledSettings = showAgeVerificationOverlay.universePlaceVoiceEnabledSettings
    local voiceSettings = showAgeVerificationOverlay.voiceSettings
    log:trace("Voice settings endpoint returned {}", showAgeVerificationOverlay)

    if not arg1:verifyPlaceCanUseVoice(universePlaceVoiceEnabledSettings, voiceSettings) then
        return false
    end

    if GetFFlagEnableVoiceSignal() then
        arg1.communicationPermissionsResult = showAgeVerificationOverlay
        local var5 = GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints() and os.time()

        local var6 = GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints()
            and not arg1:UserVoiceEnabled()
            and not voiceSettings.isUserVerifiedForVoice
            and (arg1:FetchPhoneVerificationUpsell(Constants.IN_EXP_PHONE_UPSELL_IXP_LAYER) == Constants.PHONE_UPSELL_VOICE_CHAT_PROP.VoiceChat
                or var5
                    and arg1:FetchPhoneVerificationUpsell(Constants.EXIT_CONFIRMATION_PHONE_UPSELL_IXP_LAYER, var5) == Constants.PHONE_UPSELL_VOICE_CHAT_PROP.VoiceChat)

        if arg1:UserEligibleForInExperienceUpsell() or var6 then
            arg1:ChangeVoiceJoinProgress(VOICE_JOIN_PROGRESS.Suspended)
        end
        local voiceConnectCookie = arg1:GetVoiceConnectCookie()
        local var7 = arg1:HasSeamlessVoiceFeature(Constants.SeamlessVoiceFeatures.DeferConnection) and voiceConnectCookie == ""

        local var8 = arg1:IsSeamlessVoice() and voiceConnectCookie == "false"

        if var7 or var8 then
            arg1:ChangeVoiceJoinProgress(VOICE_JOIN_PROGRESS.Suspended)
        elseif arg1:EligibleForFaeUpsell() then
            log:debug("Suspending voice join for FAE Eligible user")
            arg1:ChangeVoiceJoinProgress(VOICE_JOIN_PROGRESS.Suspended)
            arg1:SetupFAECompleteListener()
        end

        task.spawn(function()
            arg1:FetchAgeVerificationOverlay()
        end)
    end

    if not voiceSettings.isVoiceEnabled then
        arg1:_reportJoinFailed("userNotEnabled")
    end
    return voiceSettings.isVoiceEnabled
end

function module.voicePermissionGranted(_, authorized): boolean
    if typeof(authorized) == "table" then
        return authorized.status == PermissionsProtocol.Status.AUTHORIZED
            or not Cryo.List.find(authorized.missingPermissions, PermissionsProtocol.Permissions.MICROPHONE_ACCESS)
    end

    return authorized == PermissionsProtocol.Status.AUTHORIZED
end

function module.RawGetPermissions(arg1, arg2)
    return Promise.new(function(callback, _)
        arg1:emit("GetPermissions", function(arg3)
            callback(arg3)
        end, arg2, true, true)
    end)
end

function module.requestMicPermission(arg1)
    if GetFFlagCoreMicManagerRefactor() then
        return arg1.micManager:RequestMicPermission()
    end

    if GetFFlagDebugVoiceChatMicPermissionCliBypass() then
        arg1.permissionState = PERMISSION_STATE.LISTEN_AND_TALK
        return Promise.resolve()
    end
    if arg1.permissionPromise then
        log:trace("PermissionProtocol already invoked")

        return arg1.permissionPromise
    end
    local tbl3 = { PermissionsProtocol.Permissions.MICROPHONE_ACCESS }

    arg1.permissionPromise = arg1.PermissionsService:requestPermissions(tbl3):andThen(function(arg2)
        arg1:RecordExperienceJoinMicPermissionStatus(arg2)
        if not (arg2 or arg2.status) then
            log:debug("No permission response, rejecting access")
            arg1:_reportJoinFailed("noPermissionResponse", Analytics.ERROR)
            if arg1.options.passInitErrorInPromiseReject then
                return Promise.reject({ code = "INIT_ERROR_NO_PERM_RESPONSE" })
            end
            return Promise.reject()
        end
        log:debug("Permission status {}", arg2.status)

        local bool7 = arg2.status == PermissionsProtocol.Status.AUTHORIZED
        if arg1.options.passInitErrorInPromiseReject and not bool7 then
            return Promise.reject({ code = "INIT_ERROR_PERM_NOT_GRANTED" })
        end
        return bool7 and Promise.resolve() or Promise.reject()
    end):andThen(function()
        arg1:emit("OnRequestMicPermissionResolved")
        return Promise.resolve()
    end):catch(function()
        arg1:emit("OnRequestMicPermissionRejected")
        if arg1.options.passInitErrorInPromiseReject then
            return Promise.reject({ code = "INIT_ERROR_MIC_PERM_REJECTED" })
        end
        return Promise.reject()
    end)
    return arg1.permissionPromise
end

function module.JoinByGroupIdToken(arg1, previousGroupId, previousMutedState)
    arg1.previousGroupId = previousGroupId
    arg1.previousMutedState = previousMutedState
    return arg1.service:JoinByGroupIdToken(previousGroupId, previousMutedState)
end

function module.EnableVoice(arg1)
    log:trace("Enabling voice")

    arg1.AvatarChatService:GetPropertyChangedSignal("ClientFeatures"):Once(function()
        arg1.attemptVoiceRejoin:Fire()
    end)
    arg1.AvatarChatService:EnableVoice()
end

function module.ChangeVoiceJoinProgress(arg1, voiceJoinProgress)
    arg1.VoiceJoinProgress = voiceJoinProgress
    arg1.VoiceJoinProgressChanged:Fire(arg1.VoiceJoinProgress)
end

function module.setOptions(tbl3, options)
    tbl3.options = options
end

function module.ShouldShowJoinVoiceOnDisconnect(arg1)
    return arg1:IsSeamlessVoice() and arg1.VoiceJoinProgress == VOICE_JOIN_PROGRESS.Suspended
end

function module.IsSeamlessVoice(arg1): boolean
    if GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() and not arg1.options.allowSeamlessVoice then
        return false
    end
    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()

    if type(ageVerificationOverlayResult) ~= "table"
        or not (ageVerificationOverlayResult and ageVerificationOverlayResult.voiceSettings)
    then
        return false
    end

    if GetFFlagCheckUniversePlaceBeforeSuspending() and not arg1:verifyUniverseAndPlaceCanUseVoice() then
        return false
    end

    local seamlessVoiceStatus = ageVerificationOverlayResult.voiceSettings.seamlessVoiceStatus
    return seamlessVoiceStatus == Constants.SeamlessVoiceStatus.EnabledExistingUser
        or seamlessVoiceStatus == Constants.SeamlessVoiceStatus.EnabledNewUser
end

function module.HasSeamlessVoiceFeature(arg1, arg2)
    if not (arg1.options.allowSeamlessVoice and arg1:verifyUniverseAndPlaceCanUseVoice()) then
        return false
    end

    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
    if not arg1:_isValidAgeVerificationOverlayData(ageVerificationOverlayResult) then
        return false
    end

    local seamlessVoiceVariant = ageVerificationOverlayResult.voiceSettings.seamlessVoiceVariant
    if not seamlessVoiceVariant then
        return false
    end

    if GetFFlagEnableSeamlessVoiceFeature() then
        arg2 = type(arg2) == "string" and { arg2 } or arg2

        if GetFFlagEnableSeamlessVoiceFeature(arg2) then
            local var5 = Utils.jsonDecode(seamlessVoiceVariant)
            local tbl3 = ({})
            for _, value in pairs(var5) do
                tbl3[value] = true
            end

            if #arg2 == 1
                and arg2[1] == Constants.SeamlessVoiceFeatures.ConnectDisconnect
                and seamlessVoiceVariant == Constants.SeamlessVoiceVariants.OnlyConnectDisconnect
            then
                return true
            end

            for _, value in pairs(arg2) do
                if not tbl3[value] then
                    return false
                end
            end
            return true
        end
    else
        local tbl3 = {}
        tbl3[Constants.SeamlessVoiceFeatures.ConnectDisconnect] = function(control): boolean
            return control ~= Constants.SeamlessVoiceVariants.Control
        end
        tbl3[Constants.SeamlessVoiceFeatures.HearingWithoutMicPermissions] = function(hearingWithoutMicPermissions): boolean
            return hearingWithoutMicPermissions == Constants.SeamlessVoiceVariants.HearingWithoutMicPermissions
        end

        local var5 = tbl3[arg2]
        if var5 then
            return var5(seamlessVoiceVariant)
        end
    end

    return false
end

function module.IsNewSeamlessVoiceUserDisconnect(arg1): boolean
    if not (arg1.options.allowSeamlessVoice and arg1:verifyUniverseAndPlaceCanUseVoice()) then
        return false
    end

    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
    if not arg1:_isValidAgeVerificationOverlayData(ageVerificationOverlayResult) then
        return false
    end

    if ageVerificationOverlayResult.voiceSettings.seamlessVoiceStatus ~= Constants.SeamlessVoiceStatus.EnabledNewUser then
        return false
    end

    local success, result = pcall(function()
        return arg1.AppStorageService:GetItem(Constants.SEAMLESS_VOICE_FTUX_KEY)
    end)

    return success and result == "false"
end

function module._isValidAgeVerificationOverlayData(_, tbl3)
    return type(tbl3) == "table" and tbl3 and tbl3.voiceSettings
end

function module.UserInInExperienceUpsellTreatment(arg1): boolean
    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
    if not ageVerificationOverlayResult then
        return false
    end

    local showVoiceInExperienceUpsellVariant = ageVerificationOverlayResult.showVoiceInExperienceUpsellVariant
    return showVoiceInExperienceUpsellVariant == Constants.IN_EXP_UPSELL_VARIANT.VARIANT1
        or showVoiceInExperienceUpsellVariant == Constants.IN_EXP_UPSELL_VARIANT.VARIANT2
        or showVoiceInExperienceUpsellVariant == Constants.IN_EXP_UPSELL_VARIANT.VARIANT3
end

function module.UserOnlyEligibleForVoice(arg1)
    local communicationPermissionsResult = arg1.communicationPermissionsResult
    if not (communicationPermissionsResult
        and communicationPermissionsResult.voiceSettings
        and communicationPermissionsResult.universePlaceVoiceEnabledSettings) then
        arg1:FetchVoicePermissions()
        communicationPermissionsResult = arg1.communicationPermissionsResult
    end
    return communicationPermissionsResult.voiceSettings.isUserVerifiedForVoice
        and not communicationPermissionsResult.voiceSettings.isVoiceEnabled
        and communicationPermissionsResult.universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice
end

function module.UserOnlyEligibleForVoiceViaOverlay(arg1)
    local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
    return if arg1:_isValidAgeVerificationOverlayData(ageVerificationOverlayResult) then ageVerificationOverlayResult.voiceSettings.isVerifiedForVoice
        and not ageVerificationOverlayResult.voiceSettings.isVoiceEnabled
        and ageVerificationOverlayResult.universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice else false
end

function module.UserVoiceEnabled(arg1)
    local communicationPermissionsResult = arg1.communicationPermissionsResult
    return if communicationPermissionsResult
        and communicationPermissionsResult.voiceSettings
        and communicationPermissionsResult.universePlaceVoiceEnabledSettings then communicationPermissionsResult.voiceSettings.isVoiceEnabled
        and communicationPermissionsResult.universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice else false
end

function module.UserEligibleForInExperienceUpsell(arg1)
    local var5 = arg1:UserOnlyEligibleForVoice()

    if not var5 then
        return false
    elseif GetFFlagEnableVoiceSignal() then
        local var6 = arg1:UserInInExperienceUpsellTreatment()
        return var5 and var6
    else
        local ageVerificationOverlayResult = arg1:FetchAgeVerificationOverlay()
        return var5 and ageVerificationOverlayResult and ageVerificationOverlayResult.showVoiceInExperienceUpsell
    end
end

function module.canUseServiceAsync(arg1)
    if FFlagSkipVoiceInTeamCreateViewer and RunService:IsTeamCreateViewer() then
        if arg1.options.passInitErrorInPromiseReject then
            return Promise.reject({ code = "INIT_ERROR_CONTEXT_NOT_ENABLED" })
        end
        return Promise.reject()
    elseif arg1.available ~= nil or not game:GetEngineFeature("VoiceChatSupported") then
        log:debug("Voice Chat is not Available, rejecting canUseService promise")
        if arg1.options.passInitErrorInPromiseReject then
            return Promise.reject({ code = "INIT_ERROR_VOICE_NOT_SUPPORTED" })
        end
        return Promise.reject()
    else
        if not arg1.canUseServicePromise then
            arg1.canUseServicePromise = Promise.defer(function(callback, callback2)
                local canUseServiceResult = arg1:userAndPlaceCanUseVoice()
                if GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() then
                    arg1.canUseServiceResult = canUseServiceResult
                    arg1:emit("OnCanUseServiceResult", canUseServiceResult)
                end
                if GetFFlagEnableVoiceSignal() and arg1.VoiceJoinProgress == VOICE_JOIN_PROGRESS.Suspended then
                    log:debug("Place is voice enabled but user is not, delaying voice rejection")
                    arg1.attemptVoiceRejoin.Event:Wait()
                    log:debug("Attempting voice rejoin")

                    arg1.communicationPermissionsResult.voiceSettings.isVoiceEnabled = true
                    arg1.userEligible = true
                    arg1.initializedPostSuspension = true
                    callback()
                    arg1:ChangeVoiceJoinProgress(VOICE_JOIN_PROGRESS.Joining)
                    return
                end
                if not canUseServiceResult then
                    log:info("Voice access denied")

                    arg1.available = VOICE_CHAT_AVAILABILITY.UserNotAvailable
                    if arg1.options.passInitErrorInPromiseReject then
                        callback2({ code = "INIT_ERROR_USER_NOT_AVAILABLE" })
                        return
                    end
                    callback2()
                    return
                end

                if game:GetEngineFeature("VoiceChatEnabledRccProperties")
                    and not (VoiceChatService.VoiceChatEnabledForUniverseOnRcc and VoiceChatService.VoiceChatEnabledForPlaceOnRcc)
                then
                    log:debug(
                        "Disabling voice chat due to RCC Response. Universe: {}, Place: {}",
                        VoiceChatService.VoiceChatEnabledForUniverseOnRcc,
                        VoiceChatService.VoiceChatEnabledForPlaceOnRcc
                    )

                    if not VoiceChatService.VoiceChatEnabledForUniverseOnRcc then
                        arg1:_reportJoinFailed("universeNotEnabled")
                    elseif not VoiceChatService.VoiceChatEnabledForPlaceOnRcc then
                        arg1:_reportJoinFailed("placeNotEnabled")
                    end

                    arg1.available = VOICE_CHAT_AVAILABILITY.PlaceNotAvailable
                    if arg1.options.passInitErrorInPromiseReject then
                        callback2({ code = "INIT_ERROR_PLACE_NOT_AVAILABLE" })
                        return
                    end
                    callback2()
                    return
                end

                if not bool2 then
                    arg1.userEligible = true
                    callback()
                    return
                end

                IXPServiceWrapper:WaitForInitialization()
                local success, result = pcall(function()
                    return IXPServiceWrapper:GetLayerData(str1)
                end)
                if success and result and result[str2] ~= nil then
                    arg1.userEligible = result[str2]
                    IXPServiceWrapper:LogUserLayerExposure(str1)
                end

                if arg1.userEligible then
                    callback()
                elseif arg1.options.passInitErrorInPromiseReject then
                    callback2({ code = "INIT_ERROR_IXP_NOT_ELIGIBLE" })
                else
                    callback2()
                end
            end):andThen(function()
                return arg1:requestMicPermission()
            end)
        end
        return arg1.canUseServicePromise
    end
end

function module._setRecentUserState(arg1, arg2, arg3)
    local var5 = arg1.recentUsersInteractionData[tostring(arg2)] or {}
    local var6 = Cryo.Dictionary.join(var5, arg3)

    arg1.recentUsersInteractionData = Cryo.Dictionary.join(arg1.recentUsersInteractionData, { [tostring(arg2)] = var6 })
end

function module.getRecentUsersInteractionData(arg1)
    arg1:_updateRecentUsersInteractionData()
    return arg1.recentUsersInteractionData
end

function module.GetSignalREvent(arg1, arg2)
    return arg1.SignalREventTable[arg2].Event
end

function module.StartModerationSignal(arg1)
    if arg1.playerModeratedConnection then
        return
    end

    arg1.playerModeratedConnection = arg1:GetSignalREvent("ParticipantModeratedFromVoice"):Connect(function()
        log:debug("User Moderated")
        arg1.previousSessionId = arg1.service:GetSessionId()
        arg1:emit("OnPlayerModerated")
        if GetFFlagVoiceChatClientRewriteMasterLua() then
            VoiceChatService:notifyServerACSCleanup()
            VoiceChatService:leaveVoice()
            return
        end
        VoiceChatService:notifyServerACSCleanup()
        arg1.service:Leave()
    end)
end

function module.LeaveVoiceForRestriction(arg1)
    if not arg1.service then
        return
    end
    arg1.previousSessionId = arg1.service:GetSessionId()
    VoiceChatService:notifyServerACSCleanup()
    if GetFFlagVoiceChatClientRewriteMasterLua() then
        VoiceChatService:leaveVoice()
        return
    end
    arg1.service:Leave()
end

function module.StopModerationSignal(arg1)
    if arg1.playerModeratedConnection then
        arg1.playerModeratedConnection:Disconnect()
        arg1.playerModeratedConnection = nil
    end
end

function module._updateRecentUsersInteractionData(arg1)
    local now = os.time()
    local tbl3 = ({})

    if not arg1.recentUsersInteractionData then
        return
    end

    for k, value in pairs(arg1.recentUsersInteractionData) do
        local participant = if bool1 then arg1.participants[tostring(k)] else arg1.participants[k]
        local var5 = GetFFlagClearUserFromRecentVoiceDataOnLeave() and not Players:GetPlayerByUserId(tonumber(k))
        local bool7 = now - value.lastHeardTime >= GetFIntVoiceUsersInteractionExpiryTimeSeconds()
        local var6 = not participant or participant.isMuted

        if bool7 and var6 or var5 then
            tbl3[k] = Cryo.None
        end
    end

    arg1.recentUsersInteractionData = Cryo.Dictionary.join(arg1.recentUsersInteractionData, tbl3)
end

function module.SetupParticipantListeners(arg1)
    arg1:ensureInitialized("setup participant listeners")
    if arg1.participants then
        return
    end

    arg1.participants = {}
    arg1.recentUsersInteractionData = {}
    arg1.updatedParticipants = {}

    arg1.participantConnection = arg1.service.ParticipantsStateChanged:Connect(function(arg2, arg3, arg4)
        log:trace("Participants state changed")

        for _, value in ipairs(arg2) do
            if not (GetFFlagClearUserFromRecentVoiceDataOnLeave() or arg1.participants[tostring(value)].isMuted) then
                arg1:_setRecentUserState(value, { lastHeardTime = os.time() })
            end

            arg1.participants[tostring(value)] = nil
            arg1.participantLeft:Fire(arg1.participants, value)
            arg1:emit("OnVoiceParticipantRemoved", value)
        end
        for _, value in ipairs(arg3) do
            arg1.participantJoined:Fire(arg1.participants, value)
            arg1:emit("OnVoiceParticipantAdded", value)
        end
        for _, value in pairs(arg4) do
            local userId = value.userId
            local participant = if bool1 then arg1.participants[tostring(userId)] else arg1.participants[userId]

            if not value.isMuted or participant and not participant.isMuted then
                arg1:_setRecentUserState(userId, {
                    lastHeardTime = os.time(),
                    player = if GetFFlagFixGetPlayerByUserIdStringCast() then Players:GetPlayerByUserId(tonumber(userId)) else Players:GetPlayerByUserId(userId)
                })
            end

            if not participant or participant.isMuted ~= value.isMuted then
                arg1:emit("OnVoiceParticipantToggleMuted", userId, value.isMuted)
            end

            if VoiceChatService.UseNewAudioApi then
                value.isMutedLocally = not not arg1.mutedPlayers[userId]
            end

            if VoiceChatService.UseNewAudioApi then
                local isMutedLocally = if arg1.mutedPlayers[userId] then not not arg1.mutedPlayers[userId] else value.isMutedLocally
                value.isMutedLocally = isMutedLocally
            end

            if FFlagEnablePartyVoiceChangersInLua and VoiceChatService.UseNewAudioApi then
                local isVoiceChangerActive = if arg1.voiceChangerActivePlayers[userId] then arg1.voiceChangerActivePlayers[userId] else value.isVoiceChangerActive
                value.isVoiceChangerActive = isVoiceChangerActive
            end

            if arg1.muteAll then
                value.isMutedLocally = true
            end

            arg1.participants[tostring(userId)] = value
            if GetFFlagBatchVoiceParticipantsUpdates() then
                arg1.updatedParticipants[tostring(userId)] = value
            end

            if fFlagEnableVoiceChatMuteForVideoCaptures and arg1.CaptureService:IsCapturingVideo() then
                arg1.voiceCapturedDuringVideoCapture = arg1.voiceCapturedDuringVideoCapture or value.isSignalActive
            end
        end

        arg1:_updateRecentUsersInteractionData()

        if not arg1.shouldThrottleParticipantUpdate then
            if #arg4 > 0 then
                arg1.participantsUpdate:Fire(
                    if GetFFlagBatchVoiceParticipantsUpdates() then arg1.updatedParticipants else arg1.participants
                )

                arg1.updatedParticipants = {}
            end

            return
        end

        local lastParticipantsStateUpdate = tick()

        if lastParticipantsStateUpdate - arg1.lastParticipantsStateUpdate >= arg1.participantsStateThrottleTime and #arg4 > 0 then
            arg1.lastParticipantsStateUpdate = lastParticipantsStateUpdate
            arg1.participantsUpdate:Fire(
                if GetFFlagBatchVoiceParticipantsUpdates() then arg1.updatedParticipants else arg1.participants
            )

            arg1.updatedParticipants = {}
            return
        end

        if not (#arg4 > 0) then
            return
        end
        local var5 = arg1.participantsStateThrottleTime - (lastParticipantsStateUpdate - arg1.lastParticipantsStateUpdate)
        arg1.lastStateUpdateCounter = (arg1.lastStateUpdateCounter + 1) % 100
        local lastStateUpdateCounter = arg1.lastStateUpdateCounter
        task.wait(var5)
        if lastStateUpdateCounter == arg1.lastStateUpdateCounter then
            arg1.participantsUpdate:Fire(
                if GetFFlagBatchVoiceParticipantsUpdates() then arg1.updatedParticipants else arg1.participants
            )

            arg1.updatedParticipants = {}
        end
    end)

    local fFlagCoreMicManagerRefactor = GetFFlagMicConsumerRegistry() and GetFFlagCoreMicManagerRefactor()

    local function onStateChanged(voiceChatState, voiceChatState2)
        arg1:emit("OnStateChanged", voiceChatState, voiceChatState2)

        local bool7 = voiceChatState2 == Enum.VoiceChatState.Failed
        local bool8 = voiceChatState2 == Enum.VoiceChatState.Joining
        local bool9 = voiceChatState2 == Enum.VoiceChatState.Leaving
        local bool10 = voiceChatState2 == Enum.VoiceChatState.Ended
        local localMuted = arg1.service:IsPublishPaused()

        if localMuted ~= arg1.localMuted and not (bool7 or bool8 or bool9 or bool10) then
            arg1.localMuted = localMuted
            arg1.muteChanged:Fire(localMuted)
        elseif bool8 or bool9 or bool10 then
            arg1.localMuted = nil
        end

        if GetFFlagVoiceChatClientRewriteMasterLua()
            and voiceChatState2 == Enum.VoiceChatState.Joined
            and arg1.isInCall
            and localMuted ~= arg1.callMutedState
        then
            log:debug("In call, setting local muted to call muted state {}", arg1.callMutedState)
            arg1:ToggleMic("InitInCall")
        end

        if bool4 and voiceChatState2 == Enum.VoiceChatState.Joined then
            arg1:StartModerationSignal()
        end

        if voiceChatState2 == Enum.VoiceChatState.Joined then
            arg1:_syncLocalAudioDeviceActive()
        end

        if voiceChatState2 == Enum.VoiceChatState.Leaving then
            if not arg1.previousGroupId then
                arg1.previousGroupId = arg1.service:GetGroupId()
            end
            arg1.previousMutedState = arg1.service:IsPublishPaused()
        end
        if voiceChatState2 == Enum.VoiceChatState.Ended or bool7 then
            arg1.participants = {}
            arg1.localMuted = nil
            if fFlagCoreMicManagerRefactor then
                arg1.micManager:UnregisterConsumer("voice_chat")
            end
            if bool5 then
                arg1._voiceVolumeEligibilityReported = false
            end
            arg1.participantsUpdate:Fire(arg1.participants)
            if bool4 then
                arg1:StopModerationSignal()
            end
            arg1:_syncLocalAudioDeviceActive()
            if bool7 then
                log:debug("State Changed to Failed. Reason: {}", arg1.service:GetAndClearCallFailureMessage())
            end

            if voiceChatState == Enum.VoiceChatState.Joining
                or voiceChatState == Enum.VoiceChatState.JoiningRetry
                or voiceChatState == Enum.VoiceChatState.Joined
            then
                if voiceChatState2 == Enum.VoiceChatState.Ended then
                    log:debug("State Changed to Ended from {}", voiceChatState)
                end
                if not arg1:IsSeamlessVoice() or arg1:GetVoiceConnectCookieValue() then
                    arg1:emit("OnRetryRequested")
                end
            end

            if var4 and engineFeature then
                arg1:ReportVoiceVolumeImpressionsIfNeeded()
            end
        end

        if GetFFlagEnableVoiceSignal()
            and arg1.VoiceJoinProgress == VOICE_JOIN_PROGRESS.Joining
            and voiceChatState2 == Enum.VoiceChatState.Joined
        then
            arg1:ChangeVoiceJoinProgress(VOICE_JOIN_PROGRESS.Joined)
            arg1:emit("OnVoiceJoin")
        end

        if var4 and engineFeature and voiceChatState2 == Enum.VoiceChatState.Joined then
            arg1._voiceJoinTimestampMs = DateTime.now().UnixTimestampMillis
            arg1._voiceVolumeSliderEligibleAtJoin = VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(true, VoiceChatService.UseNewAudioApi)
        end

        if not bool5 or not engineFeature or voiceChatState2 ~= Enum.VoiceChatState.Joined or arg1._voiceVolumeEligibilityReported then
            return
        end
        local success, result = pcall(function()
            return UserSettings():GetService("UserGameSettings").VoiceChatVolume
        end)
        local useNewAudioApi = VoiceChatService.UseNewAudioApi
        local enablesVoiceVolumeControls = VoiceVolumeControlsEligibility.isCreatorVoiceVolumeControlsEnabled()
        local voiceAnalyticsData = arg1:GetVoiceAnalyticsData()
        local analytics = arg1.Analytics
        local tbl3 = {
            playSessionId = voiceAnalyticsData.playSessionId,
            voiceSessionId = voiceAnalyticsData.voiceSessionId,
            voiceChatVolume = 0,
            usesNewAudioApi = 0,
            enablesVoiceVolumeControls = 0,
            isEligible = 0
        }

        if not success then
            result = nil
        end

        tbl3.voiceChatVolume = result
        tbl3.usesNewAudioApi = useNewAudioApi
        tbl3.enablesVoiceVolumeControls = enablesVoiceVolumeControls
        tbl3.isEligible = VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(true, useNewAudioApi)
        analytics:reportVoiceVolumeEligibility(tbl3)

        arg1._voiceVolumeEligibilityReported = true
    end

    if arg1.service.VoiceChatState and arg1.service.VoiceChatState == Enum.VoiceChatState.Joined then
        log:debug("Joined voice chat {}", arg1.service.VoiceChatState)
        onStateChanged(nil, Enum.VoiceChatState.Joined)
    end
    arg1.stateConnection = arg1.service.StateChanged:Connect(onStateChanged)

    if GetFFlagCoreMicManagerRefactor() then
        arg1.micManager:SetupMicActivityListener(arg1.service)

        if GetFFlagMicConsumerRegistry() then
            local localPlayer = Players.LocalPlayer
            local device = if localPlayer then localPlayer:FindFirstChildOfClass("AudioDeviceInput") else nil
            arg1.micManager:RegisterConsumer({ id = "voice_chat", consumerType = "VoiceChat", device = device })
        end
    elseif var3 and VoiceChatService.UseNewAudioApi then
        if not arg1.localMeteringTask then
            arg1.localMeteringTask = task.spawn(function()
                while true do
                    arg1:UpdateLocalMetering()
                    task.wait()
                end
            end)
        end
    elseif arg1.service:GetVoiceChatApiVersion() >= MIN_VOICE_CHAT_API_VERSION_LOCAL_MIC_ACTIVITY then
        arg1.micConnection = arg1.service.PlayerMicActivitySignalChange:Connect(function(arg2)
            if fFlagEnableVoiceChatMuteForVideoCaptures and arg1.CaptureService:IsCapturingVideo() then
                arg1.voiceCapturedDuringVideoCapture = arg1.voiceCapturedDuringVideoCapture or arg2.isActive
            end

            arg1.isTalking = arg2.isActive
            if GetFFlagLocalMutedNilFix() then
                if arg1.localMuted == false then
                    arg1.talkingChanged:Fire(arg1.isTalking)
                end
            elseif not arg1.localMuted then
                arg1.talkingChanged:Fire(arg1.isTalking)
            end
        end)
    end

    if GetFFlagLuaConsumePlayerModerated() then
        arg1:StartModerationSignal()
    elseif game:GetEngineFeature("VoiceChatServicePlayerModeratedEvent") then
        arg1.playerModeratedConnection = arg1.service.LocalPlayerModerated:connect(function()
            log:debug("User Moderated old")
            arg1.previousSessionId = arg1.service:GetSessionId()
            arg1:emit("OnPlayerModerated")
            if GetFFlagVoiceChatClientRewriteMasterLua() then
                VoiceChatService:leaveVoice()
                return
            end
            arg1.service:Leave()
        end)
    end

    log:trace("Setting up voice nudge handlers")
    arg1.voiceToxicityModalConnection = arg1:GetSignalREvent("VoiceToxicityModal"):Connect(function(arg2)
        arg1.Analytics:reportReceivedNudge(arg2, arg1:GetNudgeAnalyticsData())
        arg1:emit("OnVoiceToxicityModal")
    end)

    arg1.VoiceToxicityToastConnection = arg1:GetSignalREvent("VoiceToxicityToast"):Connect(function(arg2)
        arg1.Analytics:reportReceivedNudge(arg2, arg1:GetNudgeAnalyticsData())
        arg1:emit("OnVoiceToxicityToast")
    end)
    if GetFFlagEnableVoiceReverseNudge() then
        log:trace("Setting up voice reverse nudge handlers")
        arg1.voiceReverseNudgeConnection = arg1:GetSignalREvent("VoiceReverseNudgeIconColorChange"):Connect(function(arg2)
            arg1:emit("OnVoiceReverseNudgeIconColorChange", arg2)
        end)
    end

    arg1.blockConnection = arg1.BlockStatusChanged:Connect(function(num1: number, bool7: boolean)
        if bool7 then
            if arg1.participants[tostring(num1)] then
                log:debug("Blocking {}", Utils.shorten(num1))
                arg1.service:SubscribeBlock(num1)
            end
        else
            log:debug("UnBlocking {}", Utils.shorten(num1))
            arg1.service:SubscribeUnblock(num1)
        end
    end)

    if VoiceChatService.UseNewAudioApi then
        arg1:hookupAudioDeviceInputListener()
    end

    if arg1.service.TempSetMicMutedToggleMic then
        arg1.tempSetMicMutedToggleMicConnection = arg1.service.TempSetMicMutedToggleMic:connect(function()
            arg1:ToggleMic("TempSetMicMutedToggleMic")
        end)
    end

    if not fFlagEnableVoiceChatMuteForVideoCaptures then
        return
    end

    arg1.videoCaptureInProgressConnection = arg1.CaptureService.VideoCaptureInProgress:connect(function(isInProgress: boolean)
        if isInProgress then
            arg1.voiceCapturedDuringVideoCapture = false
            return
        end
        arg1.TelemetryService:LogEvent(tbl1, { customFields = { voiceCaptured = arg1.voiceCapturedDuringVideoCapture } })
    end)
end

local var5 = nil
function module.CheckAudioInputExists(arg1)
    log:trace("Checking for AudioDeviceInput")

    var5 = var5 or Promise.new(function(callback, _)
        if #Cryo.Dictionary.keys(arg1.audioDevices) > 0 then
            log:trace("Found existing AudioDeviceInput")
            callback()
            return
        end
        arg1.audioDeviceInputAdded.Event:Connect(function()
            log:trace("Found new AudioDeviceInput")
            callback()
        end)
    end)

    return var5
end

function module.checkAndUpdateSequence(tbl3, str5: string, num1: number): number
    if not num1 then
        return 0
    end

    if not tbl3.SequenceNumbers[str5] then
        tbl3.SequenceNumbers[str5] = num1
        return 0
    end

    local var6 = num1 - tbl3.SequenceNumbers[str5]
    if var6 > 0 then
        tbl3.SequenceNumbers[str5] = num1
    end

    return var6 - 1
end

local function isIgnoredAudioInput(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return arg1:IsDescendantOf(CoreGui)
end

function module._onAudioDeviceInputAdded(tbl3, arg1)
    if FFlagExpChatDictation and isIgnoredAudioInput(arg1) then
        return
    end
    log:debug("Found new audio device instance for {}", arg1.Player and arg1.Player.Name)
    tbl3.audioDevices[arg1] = tbl3:CreateAudioDeviceData(arg1)
    tbl3:emit("OnAudioDeviceInputAdded")
    tbl3:StartAnalysis(arg1)
end

function module.onInstanceAdded(tbl3, arg1)
    if arg1:IsA("AudioDeviceInput") then
        tbl3:_onAudioDeviceInputAdded(arg1)
    end
end

function module.GetSendMuteEvent(arg1)
    if not arg1.SendMuteEvent then
        arg1.SendMuteEvent = RobloxReplicatedStorage:WaitForChild("SetUserActive", 10)
    end
    return arg1.SendMuteEvent
end

function module.GetToggleVoiceChangerEvent(arg1)
    if not arg1.SendVoiceChangerEvent then
        arg1.SendVoiceChangerEvent = ReplicatedStorage:WaitForChild("ToggleUserVoiceChanger", 10)
    end
    return arg1.SendVoiceChangerEvent
end

function module.GetInputToModifierWire(arg1)
    if not arg1.InputToModifierWire then
        arg1.InputToModifierWire = Players.LocalPlayer:FindFirstChild("InputToModifier")
    end
    return arg1.InputToModifierWire
end

function module.GetPartyVoiceDeviceInput(arg1)
    if not arg1.PartyVoiceDeviceInput then
        arg1.PartyVoiceDeviceInput = Players.LocalPlayer:FindFirstChild("PartyVoiceDeviceInput")
    end
    return arg1.PartyVoiceDeviceInput
end

function module.GetSetVoicePackEvent(arg1)
    if not arg1.SetVoicePackEvent then
        arg1.SetVoicePackEvent = ReplicatedStorage:WaitForChild("SetVoicePack", 10)
    end
    return arg1.SetVoicePackEvent
end

function module.GetVoiceChangerWasToggledEvent(arg1)
    if not arg1.VoiceChangerWasToggledEvent then
        arg1.VoiceChangerWasToggledEvent = ReplicatedStorage:WaitForChild("VoiceChangerWasToggled", 3)
    end
    return arg1.VoiceChangerWasToggledEvent
end

local function WireUp(sourceInstance, targetInstance): Wire -- Luacid: Inlined by compiler; 1 call site recovered
    local wire = Instance.new("Wire")
    wire.SourceInstance = sourceInstance
    wire.TargetInstance = targetInstance
    wire.Parent = targetInstance
    return wire
end

local function GetAnalysisHost() -- Luacid: Inlined by compiler; 2 call sites recovered
    return RobloxReplicatedStorage
end

function module.GetAnalyzer(_, arg1): Instance
    local name = arg1.Name .. "_Analyzer"
    local robloxReplicatedStorage = GetAnalysisHost()
    local var6 = robloxReplicatedStorage:FindFirstChild(name)
    if not var6 then
        var6 = Instance.new("AudioAnalyzer")
        var6.SpectrumEnabled = false
        var6.Name = name
        var6.Parent = robloxReplicatedStorage
    end
    return var6
end

local function toDecibels(peakLevel: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.log10(peakLevel) * 20
end

function module.IsSignalActive(tbl3, userId: number): boolean
    if not var3 then
        return false
    end

    local player = Players:GetPlayerByUserId(userId)
    return if player then toDecibels(tbl3:GetAnalyzer(player).PeakLevel) > -36 else false
end

function module.StopAnalysis(_, arg1)
    if not var3 then
        return
    end

    for _, value in arg1:GetConnectedWires("Output") do
        local targetInstance = value.TargetInstance
        if targetInstance and targetInstance:IsDescendantOf((GetAnalysisHost())) then
            value:Destroy()
        end
    end
end

function module.StartAnalysis(tbl3, sourceInstance)
    if not var3 then
        return
    end

    tbl3:StopAnalysis(sourceInstance)

    local player = sourceInstance.Player
    if not player then
        return
    end
    local _wire = WireUp(sourceInstance, (tbl3:GetAnalyzer(player)))
end

function module.GetVoiceConnectCookie(arg1)
    local success, result = pcall(function()
        return arg1.AppStorageService:GetItem(Constants.VOICE_CONNECT_DISCONNECT_KEY_V3)
    end)

    return success and result or ""
end

function module.GetVoiceConnectCookieValue(arg1): boolean
    local success, result = pcall(function()
        return arg1.AppStorageService:GetItem(Constants.VOICE_CONNECT_DISCONNECT_KEY_V3)
    end)

    return not success or result == "true"
end

function module.SetVoiceConnectCookieValue(tbl3, bool7: boolean): boolean
    return (pcall(function()
        tbl3.AppStorageService:SetItem(Constants.VOICE_CONNECT_DISCONNECT_KEY_V3, tostring(bool7))
        tbl3.AppStorageService:Flush()
    end))
end

function module.GetVoiceRewarmCookie(arg1)
    local success, result = pcall(function()
        return arg1.AppStorageService:GetItem(Constants.VOICE_REWARM_KEY)
    end)

    if success and result then
        log:debug("Got voice re-warm cookie: {}", result)
        return result
    end

    log:debug("Voice re-warm cookie not set, returning empty string")
    return ""
end

function module.SetVoiceRewarmCookie(tbl3, str5: string)
    log:debug("Setting voice re-warm cookie to {}", str5)
    pcall(function()
        tbl3.AppStorageService:SetItem(Constants.VOICE_REWARM_KEY, tostring(str5))
        tbl3.AppStorageService:Flush()
    end)
end

function module.ShouldRewarmUser(arg1): boolean
    local voiceRewarmCookie = arg1:GetVoiceRewarmCookie()
    return voiceRewarmCookie == "" or (tonumber(voiceRewarmCookie) or 0) < game:GetFastInt("VoiceRewarmReArmCount")
end

function module.ConsumeVoiceRewarm(arg1)
    local game = game
    arg1:SetVoiceRewarmCookie(tostring(game:GetFastInt("VoiceRewarmReArmCount")))
end

function module.SetNewUserFTUXCookieValue(tbl3, bool7: boolean): boolean
    return (pcall(function()
        tbl3.AppStorageService:SetItem(Constants.SEAMLESS_VOICE_FTUX_KEY, tostring(bool7))
        tbl3.AppStorageService:Flush()
    end))
end

function module.SetAndSyncActive(tbl3, arg1, active: boolean)
    if GetFFlagCoreMicManagerRefactor() then
        return tbl3.micManager:SetAndSyncActive(arg1, active)
    end

    arg1.Active = active
    local sendMuteEvent = tbl3:GetSendMuteEvent()
    if sendMuteEvent and arg1.Player == Players.LocalPlayer then
        sendMuteEvent:FireServer(active)
    end
end

function module.CreateAudioDeviceData(tbl3, arg1)
    local audioDeviceData = {}
    local bool7 = arg1.Player == Players.LocalPlayer

    if engineFeature2 then
        if not arg1.MutedByLocalUser then
            if tbl3.muteAll and not bool7 then
                arg1.MutedByLocalUser = true
            end
            if arg1.Player and tbl3.mutedPlayers[arg1.Player.UserId] then
                arg1.MutedByLocalUser = true
            end
        end
    elseif arg1.Active then
        if tbl3.muteAll and not bool7 then
            arg1.Active = false
        end

        if arg1.Player and tbl3.mutedPlayers[arg1.Player.UserId] then
            arg1.Active = false
        end
    end

    if arg1.Active and bool7 and tbl3.localMuted == nil then
        tbl3:SetAndSyncActive(arg1, false)
    end

    if bool7 and tbl3.localMuted ~= nil and tbl3.localMuted ~= not arg1.Active and not tbl3.isInCall then
        log:debug("Mismatch between LocalMuted and device.Active")
        local active = not tbl3.localMuted
        arg1.Active = active
        local sendMuteEvent = tbl3:GetSendMuteEvent()
        if sendMuteEvent then
            sendMuteEvent:FireServer(active)
        end
    elseif tbl3.isInCall and bool7 then
        local active = not tbl3.callMutedState
        log:debug("Overwriting Active State to match Iris call. .Active = {}", active)
        arg1.Active = active
        local sendMuteEvent = tbl3:GetSendMuteEvent()
        if sendMuteEvent then
            sendMuteEvent:FireServer(active)
        end
    end

    audioDeviceData.onPlayerChanged = arg1:GetPropertyChangedSignal("Player"):Connect(function()
        bool7 = arg1.Player == Players.LocalPlayer
        if bool7 then
            if arg1.Active and tbl3.localMuted == nil then
                log:debug("Player is still in connecting state, setting Active to false")
                tbl3:SetAndSyncActive(arg1, false)
            elseif tbl3.localMuted ~= nil and tbl3.localMuted ~= not arg1.Active then
                log:debug("Mismatch between LocalMuted and device.Active")
                tbl3:SetAndSyncActive(arg1, not tbl3.localMuted)
            end
        elseif tbl3.muteAll or arg1.Player and tbl3.mutedPlayers[arg1.Player.UserId] then
            if engineFeature2 then
                arg1.MutedByLocalUser = true
            else
                arg1.Active = false
            end
        end

        tbl3:emit("OnDevicePlayerChanged")
        tbl3:StartAnalysis(arg1)
    end)

    audioDeviceData.onMutedChanged = arg1:GetPropertyChangedSignal("Muted"):Connect(function()
        tbl3:emit("OnDeviceMuteChanged")
    end)

    if not engineFeature2 then
        audioDeviceData.onActiveChanged = arg1:GetPropertyChangedSignal("Active"):Connect(function()
            tbl3:emit("OnDeviceActiveChanged")
            if tbl3.muteAll and not bool7 then
                arg1.Active = false
            end
            if arg1.Player and tbl3.mutedPlayers[arg1.Player.UserId] then
                arg1.Active = false
            end
        end)
    elseif var2 then
        audioDeviceData.onActiveChanged = arg1:GetPropertyChangedSignal("Active"):Connect(function()
            tbl3:emit("OnDeviceActiveChanged")
        end)
        audioDeviceData.onMutedByLocalUserChanged = arg1:GetPropertyChangedSignal("MutedByLocalUser"):Connect(function()
            tbl3:emit("OnDeviceMutedByLocalUserChanged")
        end)
    end

    if VoiceChatService.UseNewAudioApi then
        audioDeviceData.onActiveChangedDisconnectGuard = arg1:GetPropertyChangedSignal("Active"):Connect(function()
            if arg1.Active and arg1.Player == Players.LocalPlayer and tbl3.localMuted == nil then
                tbl3:SetAndSyncActive(arg1, false)
            end
        end)
    end

    return audioDeviceData
end

function module.onInstanceRemove(tbl3, arg1)
    if not arg1:IsA("AudioDeviceInput") then
        return
    end

    if FFlagExpChatDictation and isIgnoredAudioInput(arg1) then
        return
    end

    tbl3:StopAnalysis(arg1)
    log:trace("Removing AudioDeviceInput {} {} {}", arg1, "for user", arg1.Player and arg1.Player.UserId)
    local var6 = tbl3.audioDevices[arg1]
    if var6 then
        if not engineFeature2 then
            var6.onActiveChanged:Disconnect()
        elseif var2 then
            if var6.onActiveChanged then
                var6.onActiveChanged:Disconnect()
            end
            if var6.onMutedByLocalUserChanged then
                var6.onMutedByLocalUserChanged:Disconnect()
            end
        end
        var6.onMutedChanged:Disconnect()
        var6.onPlayerChanged:Disconnect()
        if var6.onActiveChangedDisconnectGuard then
            var6.onActiveChangedDisconnectGuard:Disconnect()
        end
    end
    tbl3.audioDevices[arg1] = nil
    tbl3:emit("OnAudioDeviceInputRemoved")
    if var3 and arg1.Player then
        tbl3:GetAnalyzer(arg1.Player):Destroy()
    end
end

function module.hookupAudioDeviceInputListener(arg1)
    log:debug("Hooking up audio device listeners")
    local localPlayer = Players.LocalPlayer
    if FFlagUseAudioDeviceInputAddedSignal then
        SoundService.AudioDeviceInputAdded:Connect(function(audioDeviceInput: AudioDeviceInput)
            arg1:_onAudioDeviceInputAdded(audioDeviceInput)
        end)
    else
        SoundService.AudioInstanceAdded:Connect(function(instance: Instance)
            arg1:onInstanceAdded(instance)
        end)
    end

    local audioDeviceInput = localPlayer:FindFirstChildOfClass("AudioDeviceInput")
    log:debug("Found local user audio device {}", audioDeviceInput)
    if audioDeviceInput then
        arg1:onInstanceAdded(audioDeviceInput)
    end
    if VoiceChatService.EnableDefaultVoice then
        log:debug("Creating default voice listener")
        if not game:GetEngineFeature("SoundServiceControlsDefaultListenerLocation") then
            local audioListener = Instance.new("AudioListener")

            audioListener.Parent = workspace.CurrentCamera
            local wire = Instance.new("Wire")
            wire.Parent = audioListener
            local audioDeviceOutput = Instance.new("AudioDeviceOutput")
            audioDeviceOutput.Parent = wire
            wire.SourceInstance = audioListener
            wire.TargetInstance = audioDeviceOutput
        end

        for _, value in CollectionService:GetTagged("RbxDefaultVoiceEmitter") do
            Utils.destroyDefaultEmitter(value)
        end
        CollectionService:GetInstanceAddedSignal("RbxDefaultVoiceEmitter"):Connect(Utils.destroyDefaultEmitter)

        localPlayer.CharacterAdded:Connect(Utils.avoidEmitting)
        if localPlayer.Character then
            Utils.avoidEmitting(localPlayer.Character)
        end
    end

    game.DescendantRemoving:Connect(function(descendant: Instance)
        arg1:onInstanceRemove(descendant)
    end)

    for _, descendant in game:GetDescendants() do
        arg1:onInstanceAdded(descendant)
    end

    Players.PlayerRemoving:Connect(function(player: Player)
        for value in arg1.audioDevices do
            if value.Player and value.Player == player then
                arg1:onInstanceRemove(value)
            end
        end
    end)
end

function module.RejoinCurrentChannel(arg1)
    pcall(function()
        local groupId = arg1.service:GetGroupId()
        if not groupId or groupId == "" then
            return
        end

        local isPublishPaused = arg1.service:IsPublishPaused()
        arg1.service:Leave()
        log:debug("Rejoining current channel {}", groupId)
        arg1.participants = {}
        arg1.participantsUpdate:Fire(arg1.participants)
        if not arg1.service:JoinByGroupIdToken(groupId, isPublishPaused, true) then
            arg1:emit("OnInitialJoinFailed")
        end
    end)
end

function module.RejoinChannel(arg1, arg2, arg3)
    log:debug("Rejoining previous channel {} with mute status {}", arg2, arg3)

    if not arg2 or arg2 == "" then
        return
    end

    pcall(function()
        arg1.service:Leave()
        arg1.participants = {}
        arg1.participantsUpdate:Fire(arg1.participants)
        if not arg1.service:JoinByGroupIdToken(arg2, arg3, true) then
            arg1:emit("OnInitialJoinFailed")
        end
    end)
end

function module.RejoinVoice(arg1)
    if not GetFFlagVoiceChatClientRewriteMasterLua() then
        return
    end

    log:debug("Rejoining voice")

    arg1.participants = {}
    arg1.participantsUpdate:Fire(arg1.participants)
    VoiceChatService:rejoinVoice()
end

function module.watchSignalR(arg1)
    arg1.signalRConnection = arg1.NotificationService.RobloxEventReceived:Connect(function(tbl3)
        local namespace = tbl3.namespace
        if not WATCHED_NAMESPACES[namespace] then
            return
        end

        local var6 = Utils.jsonDecode(tbl3.detail)

        local var7 = arg1.SignalREventTable[var6.type]
        if var7 then
            var7:Fire(var6)
        end
        local sequenceNumber = var6.SequenceNumber
        log:trace("SignalR message {}: {}", namespace, sequenceNumber)

        local var8 = arg1:checkAndUpdateSequence(namespace, sequenceNumber)
        if var8 > 0 then
            arg1.Analytics:reportReconnectDueToMissedSequence()
        elseif var8 < -1 then
            arg1.Analytics:reportOutOfOrderSequence()
        end
    end)

    arg1.signalRConnectionChanged = arg1.NotificationService.RobloxConnectionChanged:Connect(function(connectionName: string, connectionState: Enum.ConnectionState, _: string, namespaceSequenceNumbers: string)
        if connectionName ~= "signalR" then
            return
        end

        if connectionState ~= Enum.ConnectionState.Connected then
            log:info("SignalR disconnected")
            return
        end

        for k, value in pairs(Utils.jsonDecode(namespaceSequenceNumbers)) do
            if not WATCHED_NAMESPACES[k] then
                continue
            end

            log:trace("SignalR message {}: {}", k, value)

            local var6 = arg1:checkAndUpdateSequence(k, value)
            if var6 > 0 then
                arg1.Analytics:reportReconnectDueToMissedSequence()
            elseif var6 < -1 then
                arg1.Analytics:reportOutOfOrderSequence()
            end
        end
    end)
end

function module.StopSignalRConnection(arg1)
    if arg1.signalRConnectionChanged then
        arg1.signalRConnectionChanged:Disconnect()
        arg1.signalRConnectionChanged = nil
    end
    if arg1.signalRConnection then
        arg1.signalRConnection:Disconnect()
        arg1.signalRConnection = nil
    end
end

function module.getService(arg1)
    return arg1.service
end

function module.ToggleMic(tbl3, context: string?)
    tbl3:ensureInitialized("toggle mic")
    if GetFFlagCoreMicManagerRefactor() then
        return tbl3.micManager:SetMicActive(tbl3.micManager.localMuted, context)
    elseif tbl3.localMuted == nil then
        log:trace("ToggleMic context: {} - Voice not connected yet", context)
    else
        log:trace("ToggleMic context: {}", context)

        if GetFFlagJoinWithoutMicPermissions() then
            if tbl3.permissionState == PERMISSION_STATE.PENDING_MIC then
                log:debug("In pending mic mode, requesting permission")
                tbl3:emit("GetPermissions", function(arg1)
                    local tbl4 = tbl3
                    tbl4.permissionState = if arg1.hasMicPermissions then PERMISSION_STATE.LISTEN_AND_TALK else PERMISSION_STATE.LISTEN_ONLY

                    log:debug("Got permissions, setting state to {}", tbl3.permissionState)
                    tbl3:ToggleMic(context)
                end, { PermissionsProtocol.Permissions.MICROPHONE_ACCESS }, false)
                return
            end

            if tbl3.permissionState == PERMISSION_STATE.LISTEN_ONLY then
                log:debug("User tried to unmute despite being in listen only mode")
                tbl3:emit("OnPermissionRequested")
                return
            end
        end

        if tbl3.isPlayerWatchingAd then
            log:trace("User is watching an ad, skipping toggling mic")
            return
        end

        if VoiceChatService.UseNewAudioApi then
            tbl3.localMuted = not tbl3.localMuted
            local active = not tbl3.localMuted
            log:trace("Setting self mute to {} context: {}", active, context)
            local sendMuteEvent = tbl3:GetSendMuteEvent()
            if sendMuteEvent then
                sendMuteEvent:FireServer(active)
                for value in tbl3.audioDevices do
                    if value.Player and value.Player == Players.LocalPlayer then
                        value.Active = active
                    end
                end
                tbl3.muteChanged:Fire(tbl3.localMuted)
            else
                log:error("Could not find SendMuteEvent")
            end
        else
            local localMuted = not tbl3.service:IsPublishPaused()
            log:trace("Setting self mute to {} context: {}", localMuted, context)

            tbl3.service:PublishPause(localMuted)
            tbl3.localMuted = localMuted
            tbl3.muteChanged:Fire(localMuted)
        end

        if not tbl3.localMuted then
            tbl3.talkingChanged:Fire(tbl3.isTalking)
            tbl3:emit("OnShowDataConsentToast")
        end

        if context then
            tbl3.Analytics:reportVoiceMuteSelf((tbl3:JoinWithVoiceMuteData({ context = context, muted = tbl3.localMuted })))
        end
    end
end

function module.ToggleVoiceChanger(tbl3, _: string?)
    tbl3:ensureInitialized("toggle voice changer")
    if tbl3.localMuted == nil then
        return
    end

    if VoiceChatService.UseNewAudioApi then
        tbl3.isVoiceChangerActive = not tbl3.isVoiceChangerActive
        log:trace("setting voice changer active to {}", tbl3.isVoiceChangerActive)
        local toggleVoiceChangerEvent = tbl3:GetToggleVoiceChangerEvent()
        if toggleVoiceChangerEvent then
            toggleVoiceChangerEvent:FireServer(tbl3.isVoiceChangerActive)
            tbl3.voiceChangerChanged:Fire(tbl3.isVoiceChangerActive)
            return
        end
        log:error("Could not find ToggleVoiceChangerEvent")
    else
        tbl3.isVoiceChangerActive = false
        log:trace("forcibly disabling voice changer since using old audio api", tbl3.isVoiceChangerActive)
        local toggleVoiceChangerEvent = tbl3:GetToggleVoiceChangerEvent()
        if toggleVoiceChangerEvent then
            toggleVoiceChangerEvent:FireServer(tbl3.isVoiceChangerActive)
            tbl3.voiceChangerChanged:Fire(tbl3.isVoiceChangerActive)
            return
        end
        log:error("Could not find ToggleVoiceChangerEvent")
    end
end

function module.ToggleVoiceChangerHearMyself(tbl3, _: string?)
    if tbl3.localMuted == nil then
        return
    end

    if not VoiceChatService.UseNewAudioApi then
        return
    end

    tbl3.isVoiceChangerHearMyselfActive = not tbl3.isVoiceChangerHearMyselfActive
    local inputToModifierWire = tbl3:GetInputToModifierWire()
    local sourceInstance = tbl3:GetPartyVoiceDeviceInput()

    if not inputToModifierWire or not sourceInstance then
        log:error("Could not find InputToModifierWire or PartyVoiceDeviceInput")
        return
    end

    log:trace("setting voice changer hear myself active to {}", tbl3.isVoiceChangerHearMyselfActive)
    if tbl3.isVoiceChangerHearMyselfActive then
        inputToModifierWire.SourceInstance = sourceInstance
    else
        inputToModifierWire.SourceInstance = nil
    end
    tbl3.voiceChangerHearMyselfChanged:Fire(tbl3.isVoiceChangerHearMyselfActive)
end

function module.SetVoicePack(tbl3, currentVoicePack: string)
    tbl3:ensureInitialized("set voice pack")
    if tbl3.localMuted == nil then
        return
    end

    if not VoiceChatService.UseNewAudioApi then
        return
    end

    tbl3.currentVoicePack = currentVoicePack
    log:trace("setting current voice pack to {}", tbl3.currentVoicePack)
    local setVoicePackEvent = tbl3:GetSetVoicePackEvent()
    if setVoicePackEvent then
        setVoicePackEvent:FireServer("VoicePack_" .. tbl3.currentVoicePack)
        return
    end
    log:error("Could not find SetVoicePackEvent")
end

function module.JoinWithVoiceMuteData(arg1, arg2)
    local localPlayer = Players.LocalPlayer
    return Cryo.Dictionary.join(
        {
            userId = localPlayer.UserId,
            clientSessionId = arg1:GetSessionId(),
            channelId = arg1:GetChannelId()
        },
        arg2
    )
end

function module._reportJoinFailed(arg1, arg2, arg3)
    arg1.Analytics:reportVoiceChatJoinResult(false, arg2, arg3)
    arg1:emit("OnReportJoinFailed", arg2)
end

function module._syncLocalAudioDeviceActive(arg1)
    if GetFFlagCoreMicManagerRefactor() then
        return arg1.micManager:SyncLocalAudioDeviceActive()
    elseif VoiceChatService.UseNewAudioApi then
        local active = not (arg1.localMuted == nil) and not arg1.localMuted

        for value in arg1.audioDevices do
            if value.Player and value.Player == Players.LocalPlayer then
                value.Active = active
            end
        end
    end
end

function module._setupEarlyAudioDeviceGuard(arg1)
    if GetFFlagCoreMicManagerRefactor() then
        return arg1.micManager:SetupEarlyAudioDeviceGuard()
    end
    local function shouldDeactivate(arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
        local bool7 = VoiceChatService.UseNewAudioApi and not (FFlagExpChatDictation and isIgnoredAudioInput(arg2))
        return bool7 and arg2.Player == Players.LocalPlayer and arg2.Active and arg1.localMuted == nil
    end

    local function guardDevice(arg2)
        if shouldDeactivate(arg2) then
            arg2.Active = false
        end

        arg2:GetPropertyChangedSignal("Player"):Connect(function()
            if shouldDeactivate(arg2) then
                arg2.Active = false
            end
        end)

        arg2:GetPropertyChangedSignal("Active"):Connect(function()
            if shouldDeactivate(arg2) then
                arg2.Active = false
            end
        end)
    end

    if FFlagUseAudioDeviceInputAddedSignal then
        SoundService.AudioDeviceInputAdded:Connect(function(audioDeviceInput: AudioDeviceInput)
            guardDevice(audioDeviceInput)
        end)
    else
        SoundService.AudioInstanceAdded:Connect(function(instance: Instance)
            if instance:IsA("AudioDeviceInput") then
                guardDevice(instance)
            end
        end)
    end

    for _, descendant in game:GetDescendants() do
        if descendant:IsA("AudioDeviceInput") then
            guardDevice(descendant)
        end
    end
end

function module._asyncInit(arg1)
    arg1:CheckCallState()
    arg1:_setupEarlyAudioDeviceGuard()

    return arg1:canUseServiceAsync():andThen(function(_)
        local className = "VoiceChatService"
        if game:GetEngineFeature("UseNewVoiceChatService") then
            className = "VoiceChatInternal"
            log:debug("Using VoiceChatInternal")
        end
        local success, result = pcall(function()
            local service = game:GetService(className)
            if service
                and (service:GetVoiceChatApiVersion() < MIN_VOICE_CHAT_API_VERSION_IS_CONTEXT_ENABLED or service:IsContextVoiceEnabled())
            then
                arg1.voiceEnabled = true
                arg1.service = service

                arg1:SetupParticipantListeners()
            end
        end)

        if GetFFlagVoiceChatClientRewriteMasterLua() then
            VoiceChatService:joinVoice()
            log:debug("Starting Voice Chat Client Join Operation")
        else
            local VoiceChatService2 = game:GetService("VoiceChatService")
            if VoiceChatService2 then
                VoiceChatService2:joinVoice()
                log:debug("Starting Voice Chat Client Join Operation")
            end
        end

        if not success then
            log:warning("EnableVoiceChat flag is enabled but GetService panicked {}", result)
            arg1:_reportJoinFailed("getServiceFailed", Analytics.ERROR)
            if arg1.options.passInitErrorInPromiseReject then
                return Promise.reject({ code = "INIT_ERROR_GET_SERVICE_FAILED" })
            end
            return Promise.reject()
        elseif not arg1.service then
            log:debug("VoiceChatService is not set after init")
            arg1:_reportJoinFailed("contextNotEnabled")
            if arg1.options.passInitErrorInPromiseReject then
                return Promise.reject({ code = "INIT_ERROR_CONTEXT_NOT_ENABLED" })
            end
            return Promise.reject()
        else
            arg1:emit("OnVoiceChatServiceInitialized")
            arg1:watchSignalR()
            return Promise.resolve()
        end
    end)
end

function module.UpdateLocalMetering(arg1)
    if GetFFlagCoreMicManagerRefactor() then
        return arg1.micManager:UpdateLocalMetering()
    end
    arg1.isTalking = arg1:IsSignalActive(Players.LocalPlayer.UserId)
    if arg1.localMuted == false then
        arg1.talkingChanged:Fire(arg1.isTalking)
    end
end

function module.asyncInit(arg1)
    if arg1.service then
        log:trace("Manager already initialized")
        return Promise.resolve()
    end

    if not arg1.initPromise then
        arg1.initPromise = arg1:_asyncInit()

        if arg1.AdService then
            local function setupRewardedAdMuting(arg2)
                local localMuted = false
                arg2.AdService.RewardedVideoAdStarted:Connect(function()
                    if arg2.localMuted == nil then
                        return
                    end

                    localMuted = arg2.localMuted

                    if not arg2.localMuted then
                        arg2:ToggleMic(Constants.REWARDED_VIDEO_AD_STARTED)
                    end

                    arg2.isPlayerWatchingAd = true
                    if GetFFlagCoreMicManagerRefactor() then
                        arg2.micManager:SetAdMuteBlocked(true)
                    end
                end)

                arg2.AdService.RewardedVideoAdEnded:Connect(function()
                    if arg2.localMuted == nil then
                        return
                    end

                    arg2.isPlayerWatchingAd = false
                    if GetFFlagCoreMicManagerRefactor() then
                        arg2.micManager:SetAdMuteBlocked(false)
                    end

                    if localMuted ~= arg2.localMuted then
                        arg2:ToggleMic(Constants.REWARDED_VIDEO_AD_ENDED)
                    end
                end)
            end

            setupRewardedAdMuting(arg1)
        end

        if FFlagEnablePartyVoiceChangersInLua and not arg1.voiceChangerWasToggledEvent then
            task.spawn(function()
                local voiceChangerWasToggledEvent = arg1:GetVoiceChangerWasToggledEvent()
                if not voiceChangerWasToggledEvent then
                    return
                end

                voiceChangerWasToggledEvent.OnClientEvent:Connect(function(num1: number, isVoiceChangerActive: boolean)
                    local participant = if bool1 then arg1.participants[tostring(num1)] else arg1.participants[num1]

                    if participant then
                        participant.isVoiceChangerActive = isVoiceChangerActive
                        arg1.voiceChangerActivePlayers[num1] = isVoiceChangerActive
                        arg1.participantsUpdate:Fire(arg1.participants)
                    end
                end)
            end)
        end
    end

    return arg1.initPromise
end

function module.IsInitialized(arg1): boolean
    return not not arg1.service
end

function module.ensureInitialized(arg1, arg2)
    if not arg1.service then
        error("[corescripts VCS Manager] " .. "Attempting to " .. arg2 .. " before calling init")
    end
end

function module.GetSessionId(arg1)
    arg1:ensureInitialized("get session id")
    return arg1.service:GetSessionId()
end

function module.GetChannelId(arg1)
    arg1:ensureInitialized("get channel id")
    return arg1.service:GetChannelId()
end

function module.Disconnect(arg1)
    if GetFFlagCoreMicManagerRefactor() then
        if GetFFlagMicConsumerRegistry() then
            arg1.micManager:UnregisterConsumer("voice_chat")
        end
        arg1.micManager:Disconnect()
    end
    if arg1.participantConnection then
        arg1.participantConnection:Disconnect()
        arg1.participantConnection = nil
    end
    if arg1.stateConnection then
        arg1.stateConnection:Disconnect()
        arg1.stateConnection = nil
    end
    if arg1.micConnection then
        arg1.micConnection:Disconnect()
        arg1.micConnection = nil
    end
    if arg1.blockConnection then
        arg1.blockConnection:Disconnect()
        arg1.blockConnection = nil
    end

    if arg1.playerModeratedConnection then
        arg1.playerModeratedConnection:Disconnect()
        arg1.playerModeratedConnection = nil
    end

    if arg1.voiceToxicityModalConnection then
        arg1.voiceToxicityModalConnection:Disconnect()
        arg1.voiceToxicityModalConnection = nil
    end

    if arg1.VoiceToxicityToastConnection then
        arg1.VoiceToxicityToastConnection:Disconnect()
        arg1.VoiceToxicityToastConnection = nil
    end

    if arg1.voiceReverseNudgeConnection then
        arg1.voiceReverseNudgeConnection:Disconnect()
        arg1.voiceReverseNudgeConnection = nil
    end

    if arg1.tempSetMicMutedToggleMicConnection then
        arg1.tempSetMicMutedToggleMicConnection:Disconnect()
        arg1.tempSetMicMutedToggleMicConnection = nil
    end

    if fFlagEnableVoiceChatMuteForVideoCaptures and arg1.videoCaptureInProgressConnection then
        arg1.videoCaptureInProgressConnection:Disconnect()
        arg1.videoCaptureInProgressConnection = nil
    end
end

function module.RequestHidePublicVoiceUI(arg1)
    task.defer(function()
        arg1.setVoiceUIVisibility:Fire(false)
    end)
end

function module.RequestShowPublicVoiceUI(arg1)
    task.defer(function()
        arg1.setVoiceUIVisibility:Fire(true)
    end)
end

module.default = module.new(
    BlockingUtility:GetAfterBlockedStatusChangedEvent(),
    PermissionsProtocol.default,
    HttpRbxApiService,
    nil,
    nil,
    nil,
    nil,
    nil,
    ThirdPartyUserService,
    nil,
    AdService
)

if var4 and engineFeature then
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        localPlayer.AncestryChanged:Connect(function(_: Instance, parent: Instance)
            if parent == nil then
                module.default:ReportVoiceVolumeImpressionsIfNeeded()
            end
        end)
    end
end

return module
