-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")
local Workspace = game:GetService("Workspace")
local LocalizationService = game:GetService("LocalizationService")
local Promise = require(CorePackages.Packages.Promise)
local Roact = require(CorePackages.Packages.Roact)
local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)
local PermissionsProtocol = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local NotificationService = game:GetService("NotificationService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AppStorageService = game:GetService("AppStorageService")
local SocialUpsell = require(CorePackages.Workspace.Packages.SocialUpsell)
local default = require(CorePackages.Workspace.Packages.LoggingProtocol).default
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local AppUserLayers = require(CorePackages.Workspace.Packages.ExperimentLayers).AppUserLayers
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper

local VoiceChatCore = require(CorePackages.Workspace.Packages.VoiceChatCore)
local default2 = require(CorePackages.Workspace.Packages.VoiceChat).GlobalVoiceManager.default
local createVoiceRestrictionController = require(CorePackages.Workspace.Packages.VoiceChat.createVoiceRestrictionController)

local createVoiceRestrictionController_DEPRECATED = require(CorePackages.Workspace.Packages.VoiceChat.createVoiceRestrictionController_DEPRECATED)
local showLegacyVoiceRestriction = require(script.Parent.Helpers.showLegacyVoiceRestriction)
local showUFRVoiceRestriction = require(script.Parent.Helpers.showUFRVoiceRestriction)
local getActiveInterventionTimeoutEnd = require(script.Parent.Helpers.getActiveInterventionTimeoutEnd)
local getServerNow = require(script.Parent.Helpers.getServerNow)

local voiceInterventionReceivedSignal = require(CorePackages.Workspace.Packages.InterventionShared).Signals.voiceInterventionReceivedSignal
local Constants = require(CorePackages.Workspace.Packages.InterventionShared).Utils.Constants

local FFlagVoiceChatBanDurationUseServerTime = require(script.Parent.Flags.FFlagVoiceChatBanDurationUseServerTime)

local FFlagProactiveVoiceRestrictionsUFR = require(CorePackages.Workspace.Packages.SharedFlags).FFlagProactiveVoiceRestrictionsUFR

local FFlagReactiveVoiceRestrictionsUFR = require(CorePackages.Workspace.Packages.SharedFlags).FFlagReactiveVoiceRestrictionsUFR

local FFlagProactiveVoiceRestrictionsUFRIXPExposure = require(script.Parent.Flags.FFlagProactiveVoiceRestrictionsUFRIXPExposure)

local GetFFlagDisableConsentModalForExistingUsers = require(script.Parent.Flags.GetFFlagDisableConsentModalForExistingUsers)

local _GetFFlagOnlyEnableJoinVoiceInVoiceEnabledUniverses = require(script.Parent.Flags.GetFFlagOnlyEnableJoinVoiceInVoiceEnabledUniverses)

local GetFFlagEnableUniveralVoiceToasts = require(RobloxGui.Modules.Flags.GetFFlagEnableUniveralVoiceToasts)
local GetFFlagEnableVoicePromptReasonText = require(RobloxGui.Modules.Flags.GetFFlagEnableVoicePromptReasonText)

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled
local GetFFlagVoiceChatServiceManagerUseAvatarChat = VoiceChatCore.Flags.GetFFlagVoiceChatServiceManagerUseAvatarChat
local GetFFlagNonVoiceFTUX = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagNonVoiceFTUX

local GetFFlagJoinWithoutMicPermissions = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagJoinWithoutMicPermissions

local GetFIntVoiceReverseNudgeUXDisplayTimeSeconds = require(RobloxGui.Modules.Flags.GetFIntVoiceReverseNudgeUXDisplayTimeSeconds)

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local GetFFlagEnableSeamlessVoiceDataConsentToast = require(RobloxGui.Modules.Flags.GetFFlagEnableSeamlessVoiceDataConsentToast)

local GetFFlagSeamlessVoiceConsentToastPolicy = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagSeamlessVoiceConsentToastPolicy
local GetFFlagEnableFtuxExitOnMuteToggle = VoiceChatCore.Flags.GetFFlagEnableFtuxExitOnMuteToggle
local GetFFlagMicConsumerRegistry = VoiceChatCore.Flags.GetFFlagMicConsumerRegistry

local GetFFlagEnableVoiceChatMuteForVideoCaptures = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableVoiceChatMuteForVideoCaptures

local GetFFlagEnableCrossExperienceVoiceCaptureMute = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableCrossExperienceVoiceCaptureMute

local GetFFlagExpChatUseVoiceParticipantsStore = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagExpChatUseVoiceParticipantsStore

local var2 = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagDebugShowAudioDeviceInputDebugger()
local GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2 = require(script.Parent.Flags.GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2)
local VoiceNudgeUseNewDACopy = require(script.Parent.Helpers.VoiceNudgeUseNewDACopy)

local bool1 = game:DefineFastFlag("DebugSkipVoicePermissionCheck", false)
local bool2 = game:DefineFastFlag("DebugSimulateConnectDisconnect", false)
local bool3 = game:DefineFastFlag("DebugSkipSeamlessVoiceAPICheck", false)
local bool4 = game:DefineFastFlag("FixSTUXShowingIncorrectly", false)
local num1 = game:DefineFastInt("DebugConnectDisconnectInterval", 15)
local bool5 = game:DefineFastFlag("DisablePermissionPromptDeeplink", false)
local bool6 = game:DefineFastFlag("VoiceEndedCheckDisregardIdleState", false)
local bool7 = game:DefineFastFlag("DisableLeaveToastInStudio", false)
local bool8 = game:DefineFastFlag("EnableVerifiedCheckViaOverlay", false)
local GetFIntThrottleParticipantsUpdateMs = VoiceChatCore.Flags.GetFIntThrottleParticipantsUpdateMs

local str1 = game:DefineFastString("VoiceUIImprovementsIXPLayerName", "Voice.Exposure")

local str2 = game:DefineFastString("ThrottleParticipantsUpdateIXPLayerValue", "ThrottleParticipantsUpdate")

local bool9 = game:DefineFastFlag("VoiceVolumeControlsGlobalVoiceVolumeSliderIxpExposure", false)

local str3 = game:DefineFastString("VoiceVolumeControlsGlobalVoiceVolumeSliderIxpLayer", "Voice.VolumeControls")
local num2 = game:DefineFastInt("SeamlessVoiceSTUXDisplayCount", 3)

local GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints

local GetFFlagShowDevicePermissionsModal = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagShowDevicePermissionsModal

local FFlagEnableRetryForLinkingProtocolFetch = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableRetryForLinkingProtocolFetch
local bool10 = game:DefineFastFlag("ShowJoinVoiceWhenDisconnectedV3", false)
local bool11 = game:DefineFastFlag("EnableVoiceRewarmReArmV2", false)
local FFlagVoiceRewarmGrafanaMetrics = require(script.Parent.Flags.FFlagVoiceRewarmGrafanaMetrics)
local bool12 = game:DefineFastFlag("VoiceConnectDisconnectGrafanaMetrics", false)

local FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider = require(RobloxGui.Modules.Settings.Flags.FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider)

local FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast = require(script.Parent.Flags.FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast)

local FFlagVoiceRewarmTelemetry = require(CorePackages.Workspace.Packages.SharedFlags).FFlagVoiceRewarmTelemetry
local bool13 = game:DefineFastFlag("GuardVoiceInExpUpsellVariant", false)
local bool14 = game:DefineFastFlag("AlwaysSetJoinVoiceButtonContext", false)

local GetFFlagIntegratePhoneUpsellJoinVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIntegratePhoneUpsellJoinVoice

local GetFFlagInExperiencePhoneUpsellNewCopy = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagInExperiencePhoneUpsellNewCopy

local GetFFlagCheckUniversePlaceBeforeSuspending = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagCheckUniversePlaceBeforeSuspending

local FIntLinkingProtocolFetchRetries = require(CorePackages.Workspace.Packages.SharedFlags).FIntLinkingProtocolFetchRetries

local FIntLinkingProtocolFetchTimeoutMS = require(CorePackages.Workspace.Packages.SharedFlags).FIntLinkingProtocolFetchTimeoutMS
local VoiceChat = require(CorePackages.Workspace.Packages.VoiceChat)
local Constants2 = VoiceChat.Constants
local PostRecordUserSeenGeneralModal = VoiceChat.AgeVerificationOverlay.PostRecordUserSeenGeneralModal
local Constants3 = require(RobloxGui.Modules.VoiceChat.Constants)
local VoiceChatPrompt = require(RobloxGui.Modules.VoiceChatPrompt.Components.VoiceChatPrompt)
local AudioDeviceInputDebugger = require(RobloxGui.Modules.VoiceChat.Components.AudioDeviceInputDebugger)
local PromptType = require(RobloxGui.Modules.VoiceChatPrompt.PromptType)
local GetUserSettings = VoiceChat.GetUserSettings
local GetInformedOfBan = VoiceChat.GetInformedOfBan
local PostInformedOfBan = VoiceChat.PostInformedOfBan
local getCamMicPermissions = require(RobloxGui.Modules.Settings.getCamMicPermissions)
local BAN_REASON = Constants3.BAN_REASON
local SeamlessVoiceStatus = require(RobloxGui.Modules.Settings.Enum.SeamlessVoiceStatus)
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)

local GetFFlagVoiceChatClientRewriteMasterLua = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagVoiceChatClientRewriteMasterLua

local Analytics = VoiceChatCore.Analytics

local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local MicrophoneDevicePermissionsLogging = require(RobloxGui.Modules.Settings.Resources.MicrophoneDevicePermissionsLogging)
local AvatarChatService = if GetFFlagAvatarChatServiceEnabled() then game:GetService("AvatarChatService") else nil
local CaptureService = if GetFFlagEnableVoiceChatMuteForVideoCaptures() then game:GetService("CaptureService") else nil
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)

local default3 = require(CorePackages.Workspace.Packages.LinkingProtocol).LinkingProtocol.default
local SettingsRoute = require(CorePackages.Workspace.Packages.LinkingProtocol).Enums.SettingsRoute
local PhoneUpsellController = if GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints() then require(CorePackages.Workspace.Packages.PhoneUpsell).PhoneUpsellController else nil
local PostPhoneUpsellDisplayed = if GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints() then require(CorePackages.Workspace.Packages.PhoneUpsell).Http.Requests.PostPhoneUpsellDisplayed else nil
local CoreVoiceManager = VoiceChatCore.CoreVoiceManager
local Constants4 = VoiceChatCore.Constants

local getOverlayStore = SocialUpsell.Overlay.getOverlayStore
local OverlayTypes = SocialUpsell.Overlay.OverlayTypes
local SocialUpsellType = SocialUpsell.Enum.SocialUpsellType
local enum = SocialUpsell.Analytics.Enum
local SocialExperiments = require(CorePackages.Workspace.Packages.SocialExperiments)
local FFlagTestDeviceForFAEUpsell = SocialExperiments.FFlagTestDeviceForFAEUpsell
local deviceMeetsRequirementsForFAE = SocialExperiments.deviceMeetsRequirementsForFAE

local engineFeature2 = game:GetEngineFeature("EnableMutedByLocalUser")

local FFlagEnablePartyVoiceChangersInLua = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnablePartyVoiceChangersInLua

local VoiceVolumeControlsEligibility = VoiceChatCore.VoiceVolumeControlsEligibility

local VOICE_STATE = Constants2.VOICE_STATE
local VOICE_CHAT_DEVICE_TYPE = Constants2.VOICE_CHAT_DEVICE_TYPE
local VOICE_CHAT_AVAILABILITY = Constants2.VOICE_CHAT_AVAILABILITY
local MIN_VOICE_CHAT_API_VERSION = Constants2.MIN_VOICE_CHAT_API_VERSION
local WATCHED_MESSAGE_TYPES = Constants2.WATCHED_MESSAGE_TYPES
local PERMISSION_STATE = Constants2.PERMISSION_STATE

local VOICE_JOIN_PROGRESS = Constants4.VOICE_JOIN_PROGRESS

local module = {
    available = nil,
    version = nil,
    participants = nil,
    recentUsersInteractionData = nil,
    permissionPromise = nil,
    canUseServicePromise = nil,
    localMuted = nil,
    isTalking = false,
    previousGroupId = nil,
    previousMutedState = nil,
    pendingDisconnectReason = nil,
    userEligible = false,
    HttpRbxApiService = HttpRbxApiService,
    NotificationService = NotificationService,
    runService = RunService,
    PermissionsService = PermissionsProtocol.default,
    communicationPermissionsResult = nil,
    VoiceJoinProgress = VOICE_JOIN_PROGRESS.Idle,
    VoiceJoinProgressChanged = Instance.new("BindableEvent"),
    participantJoined = Instance.new("BindableEvent"),
    participantLeft = Instance.new("BindableEvent"),
    participantsUpdate = Instance.new("BindableEvent"),
    muteChanged = Instance.new("BindableEvent"),
    muteAllChanged = Instance.new("BindableEvent"),
    attemptVoiceRejoin = Instance.new("BindableEvent"),
    showVoiceUI = Instance.new("BindableEvent"),
    hideVoiceUI = Instance.new("BindableEvent"),
    voiceUIVisible = false,
    mutedNonFriends = Instance.new("BindableEvent"),
    userAgencySelected = Instance.new("BindableEvent"),
    sendMuteEvent = nil,
    muteAll = false,
    mutedPlayers = {},
    talkingChanged = Instance.new("BindableEvent"),
    SignalREventTable = {},
    audioDevices = {},
    service = nil,
    previousSessionId = nil,
    voiceEnabled = false,
    VOICE_STATE = VOICE_STATE,
    permissionState = if GetFFlagJoinWithoutMicPermissions() then PERMISSION_STATE.IDLE else nil,
    isBanned = false,
    bannedUntil = nil,
    errorText = nil,
    BlockStatusChanged = nil,
    isInCall = false,
    callMutedState = false,
    banReason = nil,
    _mutedAnyone = false,
    VOICE_CHAT_DEVICE_TYPE = VOICE_CHAT_DEVICE_TYPE,
    getPermissionsFunction = getCamMicPermissions,
    AvatarChatService = AvatarChatService,
    inExpUpsellEntrypoint = nil,
    seamlessVoiceStatus = nil,
    isShowingFTUX = false,
    hideFTUXSignal = Instance.new("BindableEvent"),
    settingsAppAvailable = nil,
    hasLeftFTUX = false,
    deniedMicPermissions = nil,
    isInitialJoin = false,
    joinVoiceButtonContext = nil,
    hasReportedRewarmShown = false,
    pendingConnectionSource = nil,
    joinVoiceButtonConsequence = nil,
    CaptureService = CaptureService
}

local set = LuauPolyfill.Set.new({
    "available",
    "participants",
    "recentUsersInteractionData",
    "permissionPromise",
    "canUseServicePromise",
    "localMuted",
    "isTalking",
    "previousGroupId",
    "previousMutedState",
    "userEligible",
    "sendMuteEvent",
    "mutedPlayers",
    "SignalREventTable",
    "audioDevices",
    "service",
    "previousSessionId",
    "voiceEnabled",
    "permissionState",
    "BlockStatusChanged",
    "isInCall",
    "callMutedState",
    "attemptVoiceRejoin",
    "VoiceJoinProgressChanged",
    "participantJoined",
    "participantLeft",
    "participantsUpdate",
    "muteChanged",
    "audioDeviceInputAdded",
    "talkingChanged",
    "canUseServiceResult"
})

set:add("_mutedAnyone")
set:add("muteAllChanged")

local tbl1 = {}
local tbl2 = {
    [Constants3.IN_EXP_UPSELL_VARIANT.VARIANT1] = PromptType.VoiceConsentModalV1,
    [Constants3.IN_EXP_UPSELL_VARIANT.VARIANT2] = PromptType.VoiceConsentModalV2,
    [Constants3.IN_EXP_UPSELL_VARIANT.VARIANT3] = PromptType.VoiceConsentModalV3
}

function getIconSrc(arg1, arg2)
    return "rbxasset://textures/ui/VoiceChat/" .. (arg2 and arg2 .. "/" or "") .. arg1 .. ".png"
end

function getIcon(arg1, arg2, arg3)
    if arg1 == VOICE_STATE.MUTED then
        return getIconSrc("Muted", arg3)
    end

    if arg1 == VOICE_STATE.CONNECTING then
        return getIconSrc("Connecting", arg3)
    end

    if arg1 == VOICE_STATE.INACTIVE then
        return getIconSrc("Blank", arg3)
    end

    if arg1 ~= VOICE_STATE.TALKING then
        return getIconSrc("Error", arg3)
    end

    local num3 = math.floor(0.5 + 5 * (arg2 or math.random())) * 20
    return arg2 and getIconSrc("Unmuted" .. tostring(num3), arg3) or getIconSrc("Blank", arg3)
end

module.__index = module

function module.__index(arg1, arg2)
    if set:has(arg2) then
        return arg1.coreVoiceManager[arg2]
    end
    return rawget(module, arg2)
end

function module:__newindex(arg1, arg2)
    if set:has(arg1) then
        self.coreVoiceManager[arg1] = arg2
        return
    end
    rawset(module, arg1, arg2)
end

local function bind(arg1, arg2) -- Luacid: Inlined by compiler; 8 call sites recovered
    return function(...)
        return arg1[arg2](arg1, ...)
    end
end

local function getEnumName(tbl3, num3: number?) -- Luacid: Inlined by compiler; 5 call sites recovered
    for value, value2 in tbl3 do
        if value2 == num3 then
            return value
        end
    end
    return nil
end

function module.new(coreVoiceManager, service, httpRbxApiService, PermissionsService, blockStatusChanged, arg1, notificationService, getPermissionsFunction, avatarChatService, captureService)
    local self = setmetatable({
        service = service,
        HttpRbxApiService = httpRbxApiService,
        NotificationService = notificationService,
        PermissionsService = PermissionsService,
        BlockStatusChanged = blockStatusChanged,
        Analytics = Analytics.new(arg1),
        getPermissionsFunction = getPermissionsFunction or getCamMicPermissions,
        AvatarChatService = avatarChatService,
        SequenceNumbers = {},
        SignalREventTable = {},
        coreVoiceManager = coreVoiceManager,
        _mutedAnyone = false,
        CaptureService = captureService,
        voiceConnectEventReportedForActiveSession = false
    }, module)

    if FFlagProactiveVoiceRestrictionsUFR then
        local var3 = if FFlagReactiveVoiceRestrictionsUFR then createVoiceRestrictionController else createVoiceRestrictionController_DEPRECATED
        local str4 = "voiceRestrictionController"

        local tbl3 = {
            getSettings = function()
                local func1 = bind(self, "GetRequest")
                return GetUserSettings(func1) or nil
            end,
            getInformedOfBan = function()
                local func1 = bind(self, "GetRequest")
                local informedOfBan = GetInformedOfBan(func1)
                return if informedOfBan then informedOfBan.informedOfBan else nil
            end,
            showLegacyRestriction = function(settings, trigger, isCurrent)
                self.bannedUntil = settings.bannedUntil
                self.banReason = settings.banReason
                showLegacyVoiceRestriction({ manager = self, settings = settings, trigger = trigger, isCurrent = isCurrent })
            end,
            onError = function(arg2)
                self:_reportJoinFailed(arg2, Analytics.ERROR)
            end,
            showUFRRestriction = function(settings, _, onAcknowledgementSuccess)
                showUFRVoiceRestriction({ manager = self, settings = settings, onAcknowledgementSuccess = onAcknowledgementSuccess })
            end,
            getNow = if FFlagReactiveVoiceRestrictionsUFR then getServerNow else nil
        }

        rawset(self, str4, var3(tbl3))
    end

    if FFlagProactiveVoiceRestrictionsUFR and FFlagReactiveVoiceRestrictionsUFR then
        rawset(self, "voiceInterventionConnection", voiceInterventionReceivedSignal:connect(function(arg2)
            self:_onUFRInterventionReceived(arg2)
        end))
    end

    for _, value in WATCHED_MESSAGE_TYPES do
        self.SignalREventTable[value] = Instance.new("BindableEvent")
    end

    self.shouldThrottleParticipantUpdate = false
    self.participantsStateThrottleTime = 0
    self.lastParticipantsStateUpdate = 0
    self.lastStateUpdateCounter = 0
    self.reverseNudgeToxicUserRemovalCallbacks = {}
    if GetFIntThrottleParticipantsUpdateMs() > 0 then
        self.participantsStateThrottleTime = GetFIntThrottleParticipantsUpdateMs() / 1000
        local success, result = pcall(function()
            return IXPServiceWrapper:GetLayerData(str1)
        end)
        if success and result and result[str2] then
            self.shouldThrottleParticipantUpdate = true
        end
    end

    self.MuteStatusIcons = {
        MicOn = self:GetIcon("Unmuted0", "SpeakerLight"),
        MicOff = self:GetIcon("Muted", "SpeakerLight"),
        MicDisabled = self:GetIcon("Muted", "SpeakerLight"),
        Loading = self:GetIcon("Connecting", "SpeakerLight"),
        Error = self:GetIcon("Error", "SpeakerLight")
    }

    self.PlayerMuteStatusIcons = {
        MicOn = self:GetIcon("Unmuted0", "MicLight"),
        MicOff = self:GetIcon("Muted", "MicLight"),
        MicDisabled = self:GetIcon("Muted", "MicLight"),
        Loading = self:GetIcon("Connecting", "MicLight"),
        Error = self:GetIcon("Error", "MicLight")
    }

    local bool15 = false
    local connection = self.attemptVoiceRejoin.Event:Connect(function()
        bool15 = true
    end)

    local voiceStore = if GetFFlagExpChatUseVoiceParticipantsStore() then ExpChat.Stores.GetVoiceStore(false) else nil

    self.coreVoiceManager:subscribe("GetPermissions", function(arg2, arg3, arg4, arg5)
        local var3 = if self.inExpUpsellEntrypoint == nil then "VoiceChatServiceManager.requestMicPermission" else self.inExpUpsellEntrypoint

        self.getPermissionsFunction(arg2, arg3, arg4, var3, arg5)
    end)
    self.coreVoiceManager:subscribe("OnVoiceParticipantRemoved", function(arg2)
        if GetFFlagExpChatUseVoiceParticipantsStore() then
            voiceStore.handleVoiceParticipantRemoved(arg2)
        elseif ExpChat.Events.VoiceParticipantRemoved then
            ExpChat.Events.VoiceParticipantRemoved(tostring(arg2))
        end
    end)
    self.coreVoiceManager:subscribe("OnVoiceParticipantAdded", function(arg2)
        if GetFFlagExpChatUseVoiceParticipantsStore() then
            voiceStore.handleVoiceParticipantAdded(arg2)
        elseif ExpChat.Events.VoiceParticipantAdded then
            ExpChat.Events.VoiceParticipantAdded(tostring(arg2))
        end
    end)
    self.coreVoiceManager:subscribe("OnVoiceParticipantToggleMuted", function(arg2, arg3)
        if ExpChat.Events.VoiceParticipantToggleMuted then
            ExpChat.Events.VoiceParticipantToggleMuted(tostring(arg2), arg3)
        end
    end)
    self.coreVoiceManager:subscribe("OnUserAndPlaceCanUseVoiceResolved", function(arg2, arg3)
        self:_onUserAndPlaceCanUseVoiceResolved(arg2, arg3)
    end)
    if FFlagReactiveVoiceRestrictionsUFR then
        self.coreVoiceManager:subscribe("OnJoinAgeVerificationOverlayFetched", function(arg2)
            self:_onJoinAgeVerificationOverlayFetched(arg2)
        end)
    end
    self.coreVoiceManager:subscribe("OnRequestMicPermissionResolved", function()
        if not GetFFlagEnableUniveralVoiceToasts() then
            return
        end

        if FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast and FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider then
            return self:CheckAndShowNotAudiblePrompt():andThen(function()
                return self:ShowNotAudiblePromptVoiceChatVolume()
            end)
        end
        return self:CheckAndShowNotAudiblePrompt()
    end)

    self.coreVoiceManager:subscribe("OnRequestMicPermissionRejected", function()
        if self:IsSeamlessVoice() then
            self.deniedMicPermissions = true
        end
        if GetFFlagEnableUniveralVoiceToasts() and not bool1 then
            return self:CheckAndShowPermissionPrompt()
        end
    end)

    if GetFFlagMicConsumerRegistry() then
        self.coreVoiceManager:subscribe("OnMicPermissionDeniedToast", function()
            self:showPrompt("MicPermissionDenied")
        end)

        self.coreVoiceManager:subscribe("OnMicFirstUnmutePrivacy", function()
            self:showPrompt("MicFirstUnmutePrivacy")
        end)
    end

    if var2 then
        self.coreVoiceManager:subscribe("OnDevicePlayerChanged", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
        self.coreVoiceManager:subscribe("OnDeviceActiveChanged", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
        self.coreVoiceManager:subscribe("OnDeviceMuteChanged", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
        if FFlagEnablePartyVoiceChangersInLua then
            self.coreVoiceManager:subscribe("OnVoiceChangerChanged", function()
                self:UpdateAudioDeviceInputDebugger()
            end)
        end
        self.coreVoiceManager:subscribe("OnPlayerMuted", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
        self.coreVoiceManager:subscribe("OnAudioDeviceInputAdded", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
        self.coreVoiceManager:subscribe("OnAudioDeviceInputRemoved", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
        self.coreVoiceManager:subscribe("OnDeviceMutedByLocalUserChanged", function()
            self:UpdateAudioDeviceInputDebugger()
        end)
    end
    self.coreVoiceManager:subscribe("OnStateChanged", function(_, voiceChatState)
        MicrophoneDevicePermissionsLogging:setClientSessionId(self.coreVoiceManager:GetSessionId())

        if voiceChatState == Enum.VoiceChatState.Ended or voiceChatState == Enum.VoiceChatState.Failed then
            self.voiceConnectEventReportedForActiveSession = false
        end

        if voiceChatState == Enum.VoiceChatState.Joined
            and bool9
            and VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(true, game:GetService("VoiceChatService").UseNewAudioApi)
        then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str3)
        end

        if bool10 and bool11 and voiceChatState == Enum.VoiceChatState.Joined and self:ShouldRewarmUser() then
            self:ConsumeVoiceRewarm()
        end

        if voiceChatState == Enum.VoiceChatState.Joined
            and self:GetVoiceJoinProgress() == VOICE_JOIN_PROGRESS.Idle
            and not self.voiceConnectEventReportedForActiveSession
        then
            local connectDisconnectAnalyticsData = self:GetConnectDisconnectAnalyticsData()
            connectDisconnectAnalyticsData.connectionSource = Constants3.VOICE_CONNECTION_SOURCE.AUTO_CONNECT
            self.pendingConnectionSource = nil
            self.Analytics:reportConnectDisconnectEvents("voiceConnectEvent", connectDisconnectAnalyticsData)
            if bool12 then
                self.Analytics:reportVoiceConnected(
                    (getEnumName(Constants3.VOICE_CONNECTION_SOURCE, connectDisconnectAnalyticsData.connectionSource))
                )
            end
            self.voiceConnectEventReportedForActiveSession = true
            bool15 = false
            connection:Disconnect()
        end
        local bool16 = voiceChatState == Enum.VoiceChatState.Ended
        if bool16 then
            local connectDisconnectAnalyticsData = self:GetConnectDisconnectAnalyticsData()
            connectDisconnectAnalyticsData.disconnectReason = self.pendingDisconnectReason or Constants3.VOICE_DISCONNECT_REASON.SYSTEM
            self.Analytics:reportConnectDisconnectEvents("voiceDisconnectReasonEvent", connectDisconnectAnalyticsData)
            if bool12 then
                self.Analytics:reportVoiceDisconnected(
                    (getEnumName(Constants3.VOICE_DISCONNECT_REASON, connectDisconnectAnalyticsData.disconnectReason))
                )
            end
            self.pendingDisconnectReason = nil
        end

        if not bool16
            or self.bannedUntil ~= nil
            or FFlagProactiveVoiceRestrictionsUFR and self:GetVoiceRestrictionState(false) ~= "normal"
        then
            return
        end
        if bool7 and self.runService:IsStudio() then
            return
        end
        self:showPrompt(PromptType.LeaveVoice)
    end)

    self.coreVoiceManager:subscribe("OnVoiceChatServiceInitialized", function()
        self:ShowVoiceUI()
        if bool2 then
            var1:debug("Simulating join voice")
            self:simulateVoiceConnectDisconnect()
        end

        if self.coreVoiceManager.initializedPostSuspension then
            return
        end

        local success, result = pcall(function(): boolean
            return AppStorageService:GetItem(Constants3.VOICE_WITH_TC_TOAST_KEY) == "true"
        end)
        if not success or result then
            return
        end

        self:showPrompt(PromptType.UpdateOnAutoJoinToast)
        pcall(function()
            AppStorageService:SetItem(Constants3.VOICE_WITH_TC_TOAST_KEY, "true")
            AppStorageService:Flush()
        end)
    end)

    self.coreVoiceManager:subscribe("OnInitialJoinFailed", function()
        self:InitialJoinFailedPrompt()
    end)
    self.coreVoiceManager:subscribe("OnPlayerModerated", function()
        self.pendingDisconnectReason = Constants3.VOICE_DISCONNECT_REASON.MODERATED
        self:ShowPlayerModeratedMessage()
    end)

    self.coreVoiceManager:subscribe("OnRetryRequested", function()
        self:showPrompt(PromptType.Retry)
    end)
    self.coreVoiceManager:subscribe("OnVoiceToxicityModal", function()
        var1:debug("Showing Voice Toxicity Modal")

        if FFlagProactiveVoiceRestrictionsUFRIXPExposure then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.VoiceUserIDLayer)
        end
        if FFlagProactiveVoiceRestrictionsUFR then
            showLegacyVoiceRestriction({
                manager = self,
                settings = nil,
                trigger = "toxicityModal",
                isCurrent = function(): boolean
                    return true
                end
            })
        elseif GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and VoiceNudgeUseNewDACopy() then
            self:showPrompt(PromptType.VoiceToxicityModalV2)
        else
            self:showPrompt(PromptType.VoiceToxicityModal)
        end
    end)
    self.coreVoiceManager:subscribe("OnVoiceToxicityToast", function()
        var1:debug("Showing Voice Toxicity Toast")
        if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and VoiceNudgeUseNewDACopy() then
            self:showPrompt(PromptType.VoiceToxicityToastV2)
            return
        end
        self:showPrompt(PromptType.VoiceToxicityToast)
    end)

    self.coreVoiceManager:subscribe("OnPermissionRequested", function()
        if GetFFlagShowDevicePermissionsModal() then
            self:showPrompt(PromptType.DevicePermissionsModal)
            return
        end
        self:showPrompt(PromptType.Permission)
    end)

    self.coreVoiceManager:subscribe("OnShowDataConsentToast", function()
        if GetFFlagEnableSeamlessVoiceDataConsentToast() then
            self:showDataConsentToast()
        end
    end)
    self.coreVoiceManager:subscribe("OnVoiceReverseNudgeIconColorChange", function(arg2)
        var1:debug("Showing Reverse Nudge Icon Color Change")
        if ExpChat.Events.AddReverseNudgeToxicUser and ExpChat.Events.RemoveReverseNudgeToxicUser then
            self:AddReverseNudgeToxicUser(
                arg2.toxicUserId,
                ExpChat.Events.AddReverseNudgeToxicUser,
                ExpChat.Events.RemoveReverseNudgeToxicUser
            )
        end
    end)
    self.coreVoiceManager.setVoiceUIVisibility.Event:Connect(function(bool16: boolean)
        if bool16 then
            self:ShowVoiceUI()
            return
        end
        self:HideVoiceUI()
    end)

    self.coreVoiceManager:subscribe("OnVoiceJoin", function()
        if GetFFlagNonVoiceFTUX() and self.hasLeftFTUX then
            self.hasLeftFTUX = false
            self:showJoinVoicePrompt()

            self.Analytics:reportConnectDisconnectEvents("voiceConnectFtuxLeaveEvent", self:GetConnectDisconnectAnalyticsData())
        elseif self:IsSeamlessVoice() then
            self:showJoinVoicePrompt()
            self:SetVoiceConnectCookieValue(true)
        else
            self:showPrompt(PromptType.VoiceConsentAcceptedToast)
        end

        if GetFFlagEnableVoiceChatMuteForVideoCaptures() and self.CaptureService:IsCapturingVideo() then
            if GetFFlagEnableCrossExperienceVoiceCaptureMute() then
                default2:MuteAll("Capture")
                self:HideVoiceUI()
            else
                self:MuteAll(true, "Capture")
                self:HideVoiceUI()
            end
        end

        if not bool15 then
            return
        end

        local connectDisconnectAnalyticsData = self:GetConnectDisconnectAnalyticsData()
        connectDisconnectAnalyticsData.connectionSource = self.pendingConnectionSource
        self.pendingConnectionSource = nil
        self.Analytics:reportConnectDisconnectEvents("voiceConnectEvent", connectDisconnectAnalyticsData)
        if bool12 then
            self.Analytics:reportVoiceConnected(
                (getEnumName(Constants3.VOICE_CONNECTION_SOURCE, connectDisconnectAnalyticsData.connectionSource))
            )
        end
        self.voiceConnectEventReportedForActiveSession = true
        bool15 = false
        connection:Disconnect()
    end)

    return self
end

local function shorten(num3: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return "..." .. string.sub(tostring(num3), -4)
end

function module:subscribe(arg1, arg2)
    return self.coreVoiceManager:subscribe(arg1, arg2)
end

function module:unsubscribe(arg1, arg2)
    self.coreVoiceManager:unsubscribe(arg1, arg2)
end

function module:_reportJoinFailed(arg1, arg2)
    return self.coreVoiceManager:_reportJoinFailed(arg1, arg2)
end

function module:_asyncInit()
    return self.coreVoiceManager:_asyncInit()
end

function module:asyncInit()
    return self.coreVoiceManager:asyncInit()
end

function module:CheckAudioInputExists()
    return self.coreVoiceManager:CheckAudioInputExists()
end

function module:getService()
    return self.service
end

function module:GetMicManager()
    return self.coreVoiceManager and self.coreVoiceManager.micManager or nil
end

function module:GetMutedAnyone()
    return self.coreVoiceManager:GetMutedAnyone()
end

function module:RecordGameSettingsOpened()
    self.coreVoiceManager:RecordGameSettingsOpened()
end

function module:ReportVoiceVolumeImpressionsIfNeeded()
    self.coreVoiceManager:ReportVoiceVolumeImpressionsIfNeeded()
end

function module:GetRequest(arg1, arg2)
    return self.coreVoiceManager:GetRequest(arg1, arg2)
end

function module.PostRequest(arg1, arg2, _, arg3)
    local success, result = pcall(function()
        local input = arg1.HttpRbxApiService:PostAsyncFullUrl(
            arg2,
            arg3,
            Enum.ThrottlingPriority.Default,
            Enum.HttpContentType.ApplicationJson,
            Enum.HttpRequestType.Players
        )
        return HttpService:JSONDecode(input)
    end)
    return success and result
end

function module:_GetShowAgeVerificationOverlay(arg1)
    return self.coreVoiceManager:_GetShowAgeVerificationOverlay(arg1)
end

function module:simulateVoiceConnectDisconnect()
    task.spawn(function()
        while true do
            task.wait(num1)
            if self.voiceUIVisible then
                var1:debug("Hiding Voice")
                self:HideVoiceUI()
                continue
            end
            var1:debug("Showing Voice")
            self:ShowVoiceUI()
        end
    end)
end

function module:FetchAgeVerificationOverlay(arg1)
    return self.coreVoiceManager:FetchAgeVerificationOverlay(arg1)
end

function module:FetchPhoneVerificationUpsell(str4: string, num3: number?, bool15: boolean?)
    return self.coreVoiceManager:FetchPhoneVerificationUpsell(str4, num3, bool15)
end

function module:RecordUserSeenModal(str4: string)
    local func1 = bind(self, "PostRequest")

    return PostRecordUserSeenGeneralModal(func1, str4)
end

function module:checkAndUpdateSequence(str4: string, num3: number)
    return self.coreVoiceManager:checkAndUpdateSequence(str4, num3)
end

function module:onMissedSequence(arg1)
    return self.coreVoiceManager:onMissedSequence(arg1)
end

function module:watchSignalR()
    return self.coreVoiceManager:watchSignalR()
end

function module:voicePermissionGranted(arg1)
    return self.coreVoiceManager:voicePermissionGranted(arg1)
end

function module:GetSignalREvent(arg1)
    return self.coreVoiceManager:GetSignalREvent(arg1)
end

function module:avatarChatUserAndPlaceSettingsValueOfClientFeatures(arg1)
    return self.coreVoiceManager:avatarChatUserAndPlaceSettingsValueOfClientFeatures(arg1)
end

function module:resolveAvatarChatUserAndPlaceSettings()
    return self.coreVoiceManager:resolveAvatarChatUserAndPlaceSettings()
end

function module:EnableVoice()
    return self.coreVoiceManager:EnableVoice()
end

function module:_VoiceChatFirstTimeUX(arg1)
    local var3 = nil
    local var4 = nil
    if not pcall(function()
        local item = arg1:GetItem(Constants3.SEAMLESS_VOICE_FTUX_KEY)
        local item2 = arg1:GetItem(Constants3.SEAMLESS_VOICE_STUX_KEY)
        var3 = item == "true"
        var4 = if item2 == nil then 0 else tonumber(item2)
    end) then
        var1:warning("Failed to read FTUX/STUX from AppStorage")
        return
    end

    var1:trace("hasShownFTUX: {}. STUXCount: {}", var3, var4)

    if var3 then
        if var4 < num2 and (not bool4 or self:GetVoiceConnectCookieValue()) then
            var1:debug("Showing STUX")
            self:showPrompt(PromptType.JoinVoiceSTUX)
            pcall(function()
                arg1:SetItem(Constants3.SEAMLESS_VOICE_STUX_KEY, tostring(var4 + 1))
                arg1:Flush()
            end)
        end

        return
    end

    var1:debug("Showing FTUX")
    self.isShowingFTUX = true
    self.Analytics:reportConnectDisconnectEvents("voiceConnectFtuxJoinEvent", self:GetConnectDisconnectAnalyticsData())

    if GetFFlagNonVoiceFTUX() then
        ExpChat.Events.VoiceUIVisibilityChanged(true)
        return
    end
    self:MuteAll(true, "FTUX")
    self.muteAllChanged.Event:Once(function()
        self:HideFTUX(arg1)
        self.Analytics:reportConnectDisconnectEvents("voiceConnectFtuxLeaveEvent", self:GetConnectDisconnectAnalyticsData())
    end)

    self.talkingChanged.Event:Once(function()
        self:HideFTUX(arg1)
    end)
    if GetFFlagEnableFtuxExitOnMuteToggle() then
        self.coreVoiceManager.onPlayerMuteToggled.Event:Once(function()
            self:HideFTUX(arg1)
        end)
    end
end

function module.VoiceChatFirstTimeUX(tbl3, arg1)
    if bool4 and not tbl3:verifyUniverseAndPlaceCanUseVoice() then
        var1:debug("Universe/place is not voice enabled, do not run FTUX/STUX")
        return
    end

    if not bool3 then
        local ageVerificationOverlayResult = tbl3:FetchAgeVerificationOverlay()

        if type(ageVerificationOverlayResult) == "table"
            and ageVerificationOverlayResult.voiceSettings
            and ageVerificationOverlayResult.voiceSettings.seamlessVoiceStatus ~= Constants3.SEAMLESS_VOICE_STATUS_ENABLED_NEW_USER
        then
            var1:debug("User not eligible for FTUX/STUX")
            return
        end
    end
    local function startFTUX() -- Luacid: Inlined by compiler; 3 call sites recovered
        var1:debug("Starting FTUX")
        tbl3:_VoiceChatFirstTimeUX(arg1)
    end
    if GetFFlagNonVoiceFTUX() then
        startFTUX()
        return
    end

    tbl3:asyncInit():andThen(function()
        local connection = nil

        if tbl3.service.VoiceChatState and tbl3.service.VoiceChatState == Enum.VoiceChatState.Joined then
            startFTUX()
        end

        connection = tbl3.service.StateChanged:Connect(function(_, voiceChatState)
            if voiceChatState == Enum.VoiceChatState.Joined then
                startFTUX()
                connection:Disconnect()
            end
        end)
    end):catch(function(arg2)
        var1:trace("Failed to start FTUX: {}", arg2)
    end)
end

function module:HideFTUX(arg1)
    self.isShowingFTUX = false
    self.hideFTUXSignal:Fire()
    pcall(function()
        arg1:SetItem(Constants3.SEAMLESS_VOICE_FTUX_KEY, "true")
        arg1:Flush()
    end)
    if GetFFlagNonVoiceFTUX() then
        self.hasLeftFTUX = true
        self.attemptVoiceRejoin:Fire()
    end
    if not GetFFlagNonVoiceFTUX() then
        self:MuteAll(false, "FTUX")
        self:showPrompt(PromptType.JoinedVoiceToast)
    end
end

function module:_onUserAndPlaceCanUseVoiceResolved(arg1, arg2)
    self.bannedUntil = nil
    if not arg1 or not arg1.isBanned then
        if self.runService:IsStudio() and arg1 and not arg1.isVoiceEnabled then
            self:showPrompt(PromptType.User)
            return
        end
        if self.runService:IsStudio() and arg2 and not arg2.isPlaceEnabledForVoice then
            local place = PromptType.Place
            local var3 = if GetFFlagEnableVoicePromptReasonText() then table.concat(arg2.reasons or {}, "") or nil else nil
            self:showPrompt(place, var3)
        end

        return
    end

    if FFlagProactiveVoiceRestrictionsUFRIXPExposure then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.VoiceUserIDLayer)
    end
    if FFlagProactiveVoiceRestrictionsUFR then
        self.voiceRestrictionController.check("gameJoin", arg1)
        return
    end

    local func1 = bind(self, "GetRequest")

    local informedOfBan = GetInformedOfBan(func1)
    if informedOfBan and not informedOfBan.informedOfBan then
        if GetFFlagAvatarChatServiceEnabled() and GetFFlagVoiceChatServiceManagerUseAvatarChat() and arg1.bannedUntil == nil then
            self:ShowPlayerModeratedMessage()
        elseif arg1.bannedUntil == nil then
            self:showPrompt(PromptType.VoiceChatSuspendedPermanent)
        else
            self.bannedUntil = arg1.bannedUntil
            if arg1.banReason ~= BAN_REASON.NUDGE_V3 then
                self:showPrompt(PromptType.VoiceChatSuspendedTemporary)
            elseif GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and VoiceNudgeUseNewDACopy() then
                self:showPrompt(PromptType.VoiceChatSuspendedTemporaryBV2)
            else
                self:showPrompt(PromptType.VoiceChatSuspendedTemporaryB)
            end
        end
    end

    if informedOfBan and informedOfBan.informedOfBan then
        self:ShowPlayerModeratedMessage(true)
    end
end

function module:_onJoinAgeVerificationOverlayFetched(arg1)
    local voiceSettings = if type(arg1) == "table" then arg1.voiceSettings else nil

    if not voiceSettings or voiceSettings.isBanned or voiceSettings.banReason ~= BAN_REASON.UFR_UNACKNOWLEDGED_EXPIRED then
        return
    end

    if FFlagProactiveVoiceRestrictionsUFRIXPExposure then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.VoiceUserIDLayer)
    end
    if FFlagProactiveVoiceRestrictionsUFR then
        self.voiceRestrictionController.showPendingAcknowledgement(voiceSettings)
    end
end

function module:ChangeVoiceJoinProgress(arg1)
    return self.coreVoiceManager:ChangeVoiceJoinProgress(arg1)
end

function module:GetVoiceJoinProgress()
    return self.coreVoiceManager.VoiceJoinProgress
end

function module:UserOnlyEligibleForVoice()
    return self.coreVoiceManager:UserOnlyEligibleForVoice()
end

function module:UserOnlyEligibleForVoiceViaOverlay()
    return self.coreVoiceManager:UserOnlyEligibleForVoiceViaOverlay()
end

function module:UserVoiceEnabled()
    return self.coreVoiceManager:UserVoiceEnabled()
end

function module:UserInInExperienceUpsellTreatment()
    return self.coreVoiceManager:UserInInExperienceUpsellTreatment()
end

function module:UserEligibleForInExperienceUpsell()
    return self.coreVoiceManager:UserEligibleForInExperienceUpsell()
end

function module.ShowInExperienceVoiceUpsell(tbl3, str4: string)
    local ageVerificationOverlayResult = tbl3:FetchAgeVerificationOverlay()
    if bool13 and type(ageVerificationOverlayResult) ~= "table" then
        return
    end

    local showVoiceInExperienceUpsellVariant = ageVerificationOverlayResult.showVoiceInExperienceUpsellVariant

    tbl3:SetInExpUpsellEntrypoint(str4)

    tbl3:showPrompt((tbl3:GetInExpUpsellPromptFromEnum(showVoiceInExperienceUpsellVariant)))
end

function module:ShowInExperiencePhoneVoiceUpsell(joinVoice: string, str4: string)
    self:SetInExpUpsellEntrypoint(joinVoice)

    PhoneUpsellController.openPhoneUpsell({
        origin = "inExperience",
        eventContext = "verificationUpsell",
        entryConfig = {
            titleKey = "Feature.VerificationUpsell.Heading.UnlockVoiceChat",
            descriptionKey = "Feature.VerificationUpsell.Description.UnlockVoiceChatBody",
            buttonKey = if GetFFlagInExperiencePhoneUpsellNewCopy() then "Feature.AccountSettings.Action.Verify" else "Feature.VerificationUpsell.Action.AddPhoneNumber",
            extraButtonConfig = { extraButtonKey = "Feature.VerificationUpsell.Action.NotNow" },
            legalTextKey = "Feature.VerificationUpsell.Description.VoiceLegalDisclaimer2"
        },
        onSuccessBeforeToast = function()
            self.coreVoiceManager:DisablePhoneVerificationUpsell()
            local func1 = bind(self, "PostRequest")
            PostPhoneUpsellDisplayed(func1, str4, os.time(), false)
        end,
        onSuccess = function()
            if self.pendingConnectionSource == nil then
                self.pendingConnectionSource = Constants3.VOICE_CONNECTION_SOURCE.IN_EXPERIENCE
            end
            self:EnableVoice()
        end,
        closeUpsell = function()
            if joinVoice ~= Constants3.IN_EXP_UPSELL_ENTRYPOINTS.JOIN_VOICE then
                self:showPrompt(PromptType.VoiceConsentDeclinedToast)
            end

            local func1 = bind(self, "PostRequest")
            PostPhoneUpsellDisplayed(func1, str4, os.time(), true)
        end
    })
end

function module:DisablePhoneVerificationUpsell()
    self.coreVoiceManager:DisablePhoneVerificationUpsell()
end

function module:SetInExpUpsellEntrypoint(inExpUpsellEntrypoint: string)
    self.inExpUpsellEntrypoint = inExpUpsellEntrypoint
end

function module:userAndPlaceCanUseVoice()
    return self.coreVoiceManager:userAndPlaceCanUseVoice()
end

function module:verifyUniverseAndPlaceCanUseVoice()
    return self.coreVoiceManager:verifyUniverseAndPlaceCanUseVoice()
end

function module:GetVoiceConnectCookieValue()
    return self.coreVoiceManager:GetVoiceConnectCookieValue()
end

function module:GetVoiceConnectCookie()
    return self.coreVoiceManager:GetVoiceConnectCookie()
end

function module:SetVoiceConnectCookieValue(bool15: boolean)
    return self.coreVoiceManager:SetVoiceConnectCookieValue(bool15)
end

function module:GetVoiceRewarmCookie()
    return self.coreVoiceManager:GetVoiceRewarmCookie()
end

function module:SetVoiceRewarmCookie(str4: string)
    self.coreVoiceManager:SetVoiceRewarmCookie(str4)
end

function module:ShouldRewarmUser()
    return self.coreVoiceManager:ShouldRewarmUser()
end

function module:ConsumeVoiceRewarm()
    self.coreVoiceManager:ConsumeVoiceRewarm()
end

function module:SetNewUserFTUXCookieValue(bool15: boolean)
    return self.coreVoiceManager:SetNewUserFTUXCookieValue(bool15)
end

function module:ShowPlayerModeratedMessage(bool15: boolean?)
    if FFlagProactiveVoiceRestrictionsUFRIXPExposure then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.VoiceUserIDLayer)
    end
    if FFlagProactiveVoiceRestrictionsUFR then
        self.voiceRestrictionController.check("removedFromVoice")
        return
    end

    local func1 = bind(self, "GetRequest")

    local userSettings = GetUserSettings(func1)
    if not (userSettings and userSettings.isBanned) then
        self:_reportJoinFailed("PlayerModeratedBadState", Analytics.ERROR)
        return
    end
    self.banReason = userSettings.banReason
    if userSettings.bannedUntil == nil then
        self:showPrompt(PromptType.VoiceChatSuspendedPermanent)
        return
    end
    self.bannedUntil = userSettings.bannedUntil

    if bool15 then
        self:showPrompt(PromptType.VoiceChatSuspendedTemporaryToast)
        return
    end
    if self.banReason ~= BAN_REASON.NUDGE_V3 then
        self:showPrompt(PromptType.VoiceChatSuspendedTemporary)
        return
    end

    if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and VoiceNudgeUseNewDACopy() then
        self:showPrompt(PromptType.VoiceChatSuspendedTemporaryBV2)
        return
    end
    self:showPrompt(PromptType.VoiceChatSuspendedTemporaryB)
end

function module:GetVoiceRestrictionState(arg1)
    return self.voiceRestrictionController.getPresentationState(arg1)
end

function module.ShowVoiceRestriction(arg1)
    arg1.voiceRestrictionController.check("micTap")
end

function module:_onUFRInterventionReceived(arg1)
    if arg1.type ~= Constants.NotificationDialogType.ChatTimeout then
        return
    end

    local var3, var4 = getActiveInterventionTimeoutEnd(arg1, getServerNow())
    if not var3 then
        return
    end

    self.pendingDisconnectReason = Constants3.VOICE_DISCONNECT_REASON.MODERATED
    self.voiceRestrictionController.applyUFRTimeout(var4)
    self.coreVoiceManager:LeaveVoiceForRestriction()
end

function module:CheckCallState()
    return self.coreVoiceManager:CheckCallState()
end

function module.ShowVoiceChatLoadingMessage(arg1)
    arg1:showPrompt(PromptType.VoiceLoading)
end

function module:requestMicPermission()
    return self.coreVoiceManager:requestMicPermission()
end

function module:canUseServiceAsync()
    return self.coreVoiceManager:canUseServiceAsync()
end

function module.canUseService(arg1): boolean
    if arg1.available ~= nil or not game:GetEngineFeature("VoiceChatSupported") then
        return false
    end
    local success, result = pcall(function()
        local asyncFullUrl = HttpRbxApiService:GetAsyncFullUrl(
            "https://voice.roblox.com/v1/settings",
            Enum.ThrottlingPriority.Default,
            Enum.HttpRequestType.Players
        )
        return HttpService:JSONDecode(asyncFullUrl)
    end)
    local isVoiceEnabled = success and result.isVoiceEnabled

    if not isVoiceEnabled then
        arg1.available = VOICE_CHAT_AVAILABILITY.UserNotAvailable
    end
    return isVoiceEnabled
end

function module:ensureInitialized(arg1)
    return self.coreVoiceManager:ensureInitialized(arg1)
end

function module:GetSessionId()
    return self.coreVoiceManager:GetSessionId()
end

function module:GetChannelId()
    return self.coreVoiceManager:GetChannelId()
end

function module:JoinWithVoiceMuteData(arg1)
    return self.coreVoiceManager:JoinWithVoiceMuteData(arg1)
end

function module:calculateBanDuration(num3: number, num4: number): number
    return math.ceil((num4 - num3) / 60)
end

function module:getBanEnd(num3: number, absoluteSeconds: number)
    return {
        minutes = self:calculateBanDuration(num3, absoluteSeconds),
        absoluteSeconds = absoluteSeconds
    }
end

function module:ShowVoiceUI()
    self.voiceUIVisible = true
    self.showVoiceUI:Fire()

    if ExpChat.Events.VoiceUIVisibilityChanged then
        ExpChat.Events.VoiceUIVisibilityChanged(true)
    end
end

function module:HideVoiceUI()
    self.voiceUIVisible = false
    self.hideVoiceUI:Fire()

    if ExpChat.Events.VoiceUIVisibilityChanged then
        ExpChat.Events.VoiceUIVisibilityChanged(false)
    end
end

function module:createPromptInstance(onReadyForSignal, arg1)
    if self.promptSignal then
        self.promptSignal:Destroy()
        self.promptSignal = nil
    end
    self.promptSignal = Instance.new("BindableEvent")
    local errorText = if GetFFlagEnableVoicePromptReasonText() then self.errorText else nil
    local bool15 = arg1 == PromptType.VoiceChatSuspendedTemporaryB
    if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then
        bool15 = bool15 or arg1 == PromptType.VoiceChatSuspendedTemporaryBV2
    end
    local var3 = if FFlagVoiceChatBanDurationUseServerTime then nil else ""
    if self.bannedUntil ~= nil then
        if FFlagVoiceChatBanDurationUseServerTime then
            var3 = self:getBanEnd(Workspace:GetServerTimeNow(), self.bannedUntil.Seconds)
        elseif bool15 then
            var3 = tostring((self:calculateBanDuration(DateTime.now().UnixTimestamp, self.bannedUntil.Seconds)))
        else
            var3 = DateTime.fromUnixTimestamp(self.bannedUntil.Seconds):FormatLocalTime("l LT", LocalizationService.RobloxLocaleId)
        end
    end

    local var4 = arg1 == PromptType.VoiceToxicityModal
        or arg1 == PromptType.VoiceToxicityToast
        or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2()
            and (arg1 == PromptType.VoiceToxicityModalV2 or arg1 == PromptType.VoiceToxicityToastV2)

    local bool16 = arg1 == PromptType.VoiceConsentModalV1
        or arg1 == PromptType.VoiceConsentModalV2
        or arg1 == PromptType.VoiceConsentModalV3

    local bool17 = false
    local var5 = nil
    if GetFFlagShowDevicePermissionsModal() and arg1 == PromptType.DevicePermissionsModal and self.settingsAppAvailable == nil then
        if FFlagEnableRetryForLinkingProtocolFetch then
            for _ = 0, FIntLinkingProtocolFetchRetries do
                local var6 = task.spawn(function()
                    bool17, var5 = default3:supportsSwitchToSettingsApp(SettingsRoute.Microphone):await()
                end)
                task.wait(FIntLinkingProtocolFetchTimeoutMS / 1000)
                task.cancel(var6)

                if var5 ~= nil then
                    break
                end
            end
        else
            bool17, var5 = default3:supportsSwitchToSettingsApp(SettingsRoute.Microphone):await()
        end

        self.settingsAppAvailable = bool17 and var5
    end

    local mount = Roact.mount
    local createElement = Roact.createElement
    local var6 = VoiceChatPrompt

    local tbl3 = {
        Analytics = Analytics.new(),
        promptSignal = self.promptSignal.Event,
        bannedUntil = var3,
        policyMapper = self.policyMapper,
        errorText = errorText,
        onReadyForSignal = onReadyForSignal,
        VoiceChatServiceManager = self,
        settingsAppAvailable = not (self.settingsAppAvailable == nil) and self.settingsAppAvailable,
        onContinueFunc = (arg1 == PromptType.VoiceChatSuspendedTemporary or bool15) and function()
            local func1 = bind(self, "PostRequest")
            PostInformedOfBan(func1, true)
        end or var4 and function()
            self.Analytics:reportClosedNudge(self:GetNudgeAnalyticsData())
        end or bool16 and function()
            self:RecordUserSeenModal(Constants3.MODAL_IDS.IN_EXP_UPSELL)
        end or nil,
        onPrimaryActivated = var4 and function()
            self.Analytics:reportAcknowledgedNudge(self:GetNudgeAnalyticsData())
        end or not bool5 and GetFFlagJoinWithoutMicPermissions() and arg1 == PromptType.Permission and function()
            local microphone = SettingsRoute.Microphone

            local var7 = default3:supportsSwitchToSettingsApp(microphone):await()
            var1:debug("Settings app available: {}", var7)
            if not var7 then
                var1:debug("Current platform does not support switching to settings app")

                return
            end

            var1:debug("Switching to settings app")
            default3:switchToSettingsApp(microphone):andThen(function()
                var1:debug("Successfully switched to settings app")
            end):catch(function()
                var1:error("Error switching to settings app")
            end)
        end or GetFFlagJoinWithoutMicPermissions()
            and GetFFlagShowDevicePermissionsModal()
            and arg1 == PromptType.DevicePermissionsModal
            and function()
                var1:debug("Settings app available: {}", self.settingsAppAvailable)
                self.Analytics:reportDevicePermissionsModalEvent(
                    if self.settingsAppAvailable then "OpenedSettings" else "Acknowledged",
                    self:GetSessionId(),
                    self:GetInExpUpsellAnalyticsData()
                )

                if not self.settingsAppAvailable then
                    var1:debug("Current platform does not support switching to settings app")

                    return
                end

                var1:debug("Switching to settings app")
                default3:switchToSettingsApp(SettingsRoute.Microphone):andThen(function()
                    var1:debug("Successfully switched to settings app")
                end):catch(function()
                    var1:error("Error switching to settings app")
                end)
            end
            or bool15 and function()
                self:reportBanMessage("Understood")
                self.Analytics:reportBanMessageEvent("Understood")
            end
            or bool16 and function()
                self.Analytics:reportInExpConsent("accepted", self.inExpUpsellEntrypoint, self:GetInExpUpsellAnalyticsData())

                if self.pendingConnectionSource == nil then
                    self.pendingConnectionSource = Constants3.VOICE_CONNECTION_SOURCE.IN_EXPERIENCE
                end
                self:EnableVoice()
            end
            or nil,
        onSecondaryActivated = (arg1 == PromptType.VoiceToxicityModal
            or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and arg1 == PromptType.VoiceToxicityModalV2)
            and function()
                self:ShowVoiceToxicityFeedbackToast()
                self.Analytics:reportDeniedNudge(self:GetNudgeAnalyticsData())
            end
            or var4 and function()
                self.Analytics:reportDeniedNudge(self:GetNudgeAnalyticsData())
            end
            or bool15 and function()
                self:ShowVoiceToxicityFeedbackToast()
                self:reportBanMessage("Denied")
                self.Analytics:reportBanMessageEvent("Denied")
            end
            or bool16 and function()
                self.Analytics:reportInExpConsent("denied", self.inExpUpsellEntrypoint, self:GetInExpUpsellAnalyticsData())

                if self.inExpUpsellEntrypoint ~= Constants3.IN_EXP_UPSELL_ENTRYPOINTS.JOIN_VOICE then
                    self:showPrompt(PromptType.VoiceConsentDeclinedToast)
                end
            end
            or arg1 == PromptType.DevicePermissionsModal and function()
                self.Analytics:reportDevicePermissionsModalEvent("Denied", self:GetSessionId(), self:GetInExpUpsellAnalyticsData())
            end
            or nil
    }

    self.voiceChatPromptInstance = mount(createElement(var6, tbl3), CoreGui, "RobloxVoiceChatPromptGui")
end

function module:showPrompt(arg1, errorText)
    if GetFFlagEnableVoicePromptReasonText() then
        self.errorText = errorText or nil
    end
    self:createPromptInstance(function()
        var1:debug("Show Prompt: {}", arg1)
        self.promptSignal:fire(arg1)
    end, arg1)
end

function module:showJoinVoicePrompt()
    self:showPrompt(PromptType.UnifiedJoinVoiceToast)
    pcall(function()
        AppStorageService:SetItem(Constants3.VOICE_WITH_TC_TOAST_KEY, "true")
        AppStorageService:Flush()
    end)
end

function module:CheckAndShowPermissionPrompt()
    local function showPrompt()
        local userEligible = self.userEligible
        if not (self.voiceEnabled or userEligible) then
            return Promise.resolve()
        end

        return self.PermissionsService:hasPermissions({ PermissionsProtocol.Permissions.MICROPHONE_ACCESS }):andThen(function(arg1)
            if arg1 and arg1.status == PermissionsProtocol.Status.DENIED then
                self:showPrompt(PromptType.Permission)
            end
        end)
    end

    if GetFFlagEnableUniveralVoiceToasts() then
        return showPrompt()
    end
    return self:asyncInit():andThen(function() end):catch(function()
        return showPrompt()
    end)
end

function module:showDataConsentToast()
    local ageVerificationOverlayResult = self:FetchAgeVerificationOverlay()
    local var3 = if GetFFlagSeamlessVoiceConsentToastPolicy() then UniversalAppPolicy.getAppFeaturePolicies().getDisplayCheckboxInVoiceConsent() or false else false
    local var4, showDataConsentToast2

    if type(ageVerificationOverlayResult) == "table" then
        if ageVerificationOverlayResult.voiceSettings then
            var4 = ageVerificationOverlayResult.voiceSettings.seamlessVoiceStatus
        else
            var4 = SeamlessVoiceStatus.Invalid
        end

        showDataConsentToast2 = ageVerificationOverlayResult.showDataConsentToast
    else
        var4 = SeamlessVoiceStatus.Invalid
        showDataConsentToast2 = false
    end

    if showDataConsentToast2 and var3 then
        if type(self:_GetShowAgeVerificationOverlay()) == "table" then
            showDataConsentToast2 = self:_GetShowAgeVerificationOverlay().showDataConsentToast
        else
            showDataConsentToast2 = false
        end
    end
    if var4 == SeamlessVoiceStatus.EnabledExistingUser and showDataConsentToast2 and var3 then
        self:RecordUserSeenModal(Constants3.MODAL_IDS.DATA_CONSENT_TOAST)
        return self:showPrompt(PromptType.VoiceDataConsentOptOutToast)
    end
end

function module:CheckAndShowNotAudiblePrompt()
    if not game:GetEngineFeature("VoiceChatSupported") then
        return Promise.resolve()
    end

    return self:asyncInit():andThen(function()
        if UserSettings().GameSettings.MasterVolume == 0 then
            self:showPrompt(PromptType.NotAudible)
        end
    end):catch(function() end)
end

function module:ShowNotAudiblePromptVoiceChatVolume()
    if not (FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast and FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider) then
        return Promise.resolve()
    elseif game:GetEngineFeature("VoiceChatSupported") then
        return self:asyncInit():andThen(function()
            if UserSettings().GameSettings.MasterVolume > 0
                and VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(true, VoiceChatService.UseNewAudioApi)
                and UserSettings().GameSettings.VoiceChatVolume == 0
            then
                self:showPrompt(PromptType.NotAudibleVoiceChatVolume)
            end
        end):catch(function() end)
    end
    return Promise.resolve()
end

function module:InitialJoinFailedPrompt()
    var1:debug("JoinByGroupIdToken returns false")
    if not GetFFlagVoiceChatClientRewriteMasterLua then
        self:showPrompt(PromptType.Retry)
    end
end

function module:ShowVoiceToxicityFeedbackToast()
    var1:debug("Sending feedback toast")
    self:showPrompt(PromptType.VoiceToxicityFeedbackToast)
end

function module:GetNudgeAnalyticsData()
    return Players.LocalPlayer.UserId, self:GetSessionId()
end

function module:GetInExpUpsellAnalyticsData()
    local str4 = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else ""

    return game.GameId, game.PlaceId, str4
end

function module:reportBanMessage(str4: string)
    self.Analytics:reportBanMessageEventV2(
        str4,
        self.banReason,
        Players.LocalPlayer.UserId,
        if self.service then self.previousSessionId else ""
    )
end

function module:reportJoinVoiceUpsellEvent(str4: string, str5: string?, str6: string?)
    local playSessionId = RbxAnalyticsService:GetPlaySessionId()
    if FFlagVoiceRewarmTelemetry then
        self.Analytics:reportJoinVoiceUpsellEvent(str4, playSessionId, self:UserVoiceEnabled(), str5, str6)
        return
    end

    self.Analytics:reportJoinVoiceUpsellEvent(str4, playSessionId, self:UserVoiceEnabled())
end

function module:reportVoiceRewarmShown()
    if self.joinVoiceButtonContext ~= "Rewarm" or self.hasReportedRewarmShown then
        return
    end
    self.hasReportedRewarmShown = true
    self.Analytics:reportVoiceRewarmShown(self:GetVoiceRewarmCookie() ~= "")
end

function module:SetAndSyncActive(arg1, bool15: boolean)
    self.coreVoiceManager:SetAndSyncActive(arg1, bool15)
end

function module:CreateAudioDeviceData(arg1)
    return self.coreVoiceManager:CreateAudioDeviceData(arg1)
end

function module:onInstanceAdded(arg1)
    return self.coreVoiceManager:onInstanceAdded(arg1)
end

function module:UpdateAudioDeviceInputDebugger()
    if not var2 then
        return
    end

    if not self.voiceDebuggerInstance then
        var1:debug("Mounting AudioDeviceInput Debugger")
        self.voiceDebuggerInstance = Roact.mount(
            Roact.createElement(AudioDeviceInputDebugger, { instances = self.audioDevices, mutedPlayers = self.mutedPlayers }),
            CoreGui,
            "RobloxVoiceChatPromptGui"
        )
        return
    end

    Roact.update(
        self.voiceDebuggerInstance,
        Roact.createElement(AudioDeviceInputDebugger, { instances = self.audioDevices, mutedPlayers = self.mutedPlayers })
    )
end

function module:AddReverseNudgeToxicUser(str4: string, callback, callback2)
    callback(str4, "iconColorChange")

    local reverseNudgeToxicUserRemovalCallback = self.reverseNudgeToxicUserRemovalCallbacks[str4]
    if reverseNudgeToxicUserRemovalCallback ~= nil then
        task.cancel(reverseNudgeToxicUserRemovalCallback)
    end

    local var3 = task.delay(GetFIntVoiceReverseNudgeUXDisplayTimeSeconds(), function()
        callback2(str4)
        self.reverseNudgeToxicUserRemovalCallbacks[str4] = nil
    end)
    self.reverseNudgeToxicUserRemovalCallbacks[str4] = var3
end

function module:onInstanceRemove(arg1)
    return self.coreVoiceManager:onInstanceRemove(arg1)
end

function module:hookupAudioDeviceInputListener()
    return self.coreVoiceManager:hookupAudioDeviceInputListener()
end

function module:ToggleMutePlayer(num3: number, str4: string)
    return self.coreVoiceManager:ToggleMutePlayer(num3, str4)
end

function module:MuteAll(bool15: boolean, str4: string)
    return self.coreVoiceManager:MuteAll(bool15, str4)
end

function module:ToggleMuteSome(tbl3, bool15: boolean, str4: string, str5: string)
    return self.coreVoiceManager:ToggleMuteSome(tbl3, bool15, str4, str5)
end

function module.FireMuteNonFriendsEvent(arg1)
    arg1.mutedNonFriends:Fire()
end

function module:EnsureCorrectMuteState(tbl3, isMutedLocally: boolean)
    local tbl4 = ({})
    for _, value in tbl3 do
        local participant = self.participants[tostring(value)]
        if not participant or participant.isMutedLocally == isMutedLocally then
            continue
        end

        if VoiceChatService.UseNewAudioApi then
            tbl4[value] = true
            self.mutedPlayers[value] = isMutedLocally
        else
            self.service:SubscribePause(value, isMutedLocally)
        end

        participant.isMutedLocally = isMutedLocally
        self.participantsUpdate:Fire(self.participants)
    end

    if not VoiceChatService.UseNewAudioApi then
        return
    end

    for value in self.audioDevices do
        if not (value.Player and tbl4[value.Player.UserId]) then
            continue
        end

        if engineFeature2 and value.Player ~= Players.LocalPlayer then
            value.MutedByLocalUser = isMutedLocally
        else
            value.Active = not isMutedLocally
        end
    end
end

function module.FireUserAgencySelectedEvent(tbl3, bool15: boolean)
    tbl3.userAgencySelected:Fire(bool15)
end

function module.ParticipantStateToIcon(_, arg1, arg2)
    local inactive = VOICE_STATE.INACTIVE
    if not arg1.subscriptionCompleted then
        inactive = VOICE_STATE.CONNECTING
    elseif arg1.isMutedLocally then
        inactive = VOICE_STATE.LOCAL_MUTED
    elseif arg1.isMuted then
        inactive = VOICE_STATE.MUTED
    elseif arg1.isSignalActive then
        inactive = VOICE_STATE.TALKING
    end

    return getIcon(inactive, arg2)
end

function module.VoiceStateToIcon(_, arg1, arg2, arg3)
    return getIcon(arg1, arg2, arg3)
end

function module:GetIcon(arg1, arg2)
    return getIconSrc(arg1, arg2)
end

function module:JoinVoice(arg1)
    local var3 = nil
    local joinVoiceButtonContext

    if FFlagVoiceRewarmTelemetry then
        joinVoiceButtonContext = self.joinVoiceButtonContext
        self.joinVoiceButtonContext = nil
    else
        joinVoiceButtonContext = nil
    end

    local bool15 = if FFlagVoiceRewarmGrafanaMetrics and joinVoiceButtonContext == "Rewarm" then self:GetVoiceRewarmCookie() ~= "" else nil

    if bool10 and not bool11 then
        var1:debug("Consuming voice re-warm cookie on JoinVoice")
        self:SetVoiceRewarmCookie("true")
    end
    local ageVerificationOverlayResult = self:FetchAgeVerificationOverlay()

    local var4 = (if bool13 then if type(ageVerificationOverlayResult) == "table" then ageVerificationOverlayResult.showVoiceInExperienceUpsellVariant else nil else ageVerificationOverlayResult.showVoiceInExperienceUpsellVariant)
        or Constants3.IN_EXP_UPSELL_VARIANT.VARIANT3
    if not FFlagVoiceRewarmTelemetry then
        self.Analytics:reportJoinVoiceButtonEvent("clicked", self:GetInExpUpsellAnalyticsData())
    end

    if self.previousGroupId then
        if FFlagVoiceRewarmTelemetry then
            var3 = "RejoinPreviousChannel"
        end

        self:RejoinPreviousChannel()
        self:showJoinVoicePrompt()
        self:ShowVoiceUI()
        self:SetVoiceConnectCookieValue(true)
    elseif GetFFlagNonVoiceFTUX() and self.isShowingFTUX then
        if FFlagVoiceRewarmTelemetry then
            var3 = "ExitFtux"
        end

        self:HideFTUX(AppStorageService)
    elseif self.deniedMicPermissions then
        if FFlagVoiceRewarmTelemetry then
            var3 = "MicPermissionPrompt"
        end

        self:CheckAndShowPermissionPrompt()
    elseif self:UserVoiceEnabled() then
        if FFlagVoiceRewarmTelemetry then
            var3 = "FirstJoinSession"
        end

        self.isInitialJoin = true
        self.attemptVoiceRejoin:Fire()
        if self:IsNewSeamlessVoiceUserDisconnect() then
            self:SetVoiceConnectCookieValue(true)
            self:SetNewUserFTUXCookieValue(true)
        end
    elseif bool8 and self:UserOnlyEligibleForVoiceViaOverlay() or self:UserOnlyEligibleForVoice() then
        if FFlagVoiceRewarmTelemetry then
            var3 = "ConsentModal"
        end

        if GetFFlagDisableConsentModalForExistingUsers() and self:IsSeamlessVoice() then
            self:EnableVoice()
        else
            self:SetInExpUpsellEntrypoint(Constants3.IN_EXP_UPSELL_ENTRYPOINTS.JOIN_VOICE)

            self:showPrompt((self:GetInExpUpsellPromptFromEnum(var4)))
        end
    elseif self:EligibleForAgeCheckToast() then
        if FFlagVoiceRewarmTelemetry then
            var3 = "AgeCheckToast"
        end

        self:showPrompt(PromptType.AgeCheckForVoiceToast)
    elseif GetFFlagIntegratePhoneUpsellJoinVoice()
        and GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints()
        and not self:UserVoiceEnabled()
        and self:FetchPhoneVerificationUpsell(Constants3.IN_EXP_PHONE_UPSELL_IXP_LAYER) == Constants3.PHONE_UPSELL_VALUE_PROP.VoiceChat
    then
        if FFlagVoiceRewarmTelemetry then
            var3 = "PhoneUpsell"
        end

        if arg1 then
            arg1:SetVisibility(false, true)
        end
        self:ShowInExperiencePhoneVoiceUpsell(
            Constants3.IN_EXP_UPSELL_ENTRYPOINTS.JOIN_VOICE,
            Constants3.IN_EXP_PHONE_UPSELL_IXP_LAYER
        )
    elseif self:EligibleForFaeUpsell() then
        if FFlagVoiceRewarmTelemetry then
            var3 = "FaeUpsell"
        end

        if self.pendingConnectionSource == nil then
            self.pendingConnectionSource = Constants3.VOICE_CONNECTION_SOURCE.IN_EXPERIENCE
        end
        self.coreVoiceManager:OptUserToJoinVoice()
        local overlayStore = getOverlayStore(false)
        if not FFlagVoiceRewarmTelemetry then
            self:reportJoinVoiceUpsellEvent("Click")
        end
        overlayStore.setCurrentOverlay(OverlayTypes.SocialUpsell, {
            upsellType = SocialUpsellType.FacialAgeEstimation,
            data = {
                isInExperience = true,
                countDownBadgeText = nil,
                isPhase2 = true,
                upsellEntrySurface = enum.UpsellEntrySurfaceType.InExperienceVoiceChatIcon,
                upsellEntryComponent = enum.UpsellComponent.Modal,
                upsellPurpose = enum.UpsellStage.Fae
            }
        })
    end

    if FFlagVoiceRewarmTelemetry then
        local var5, var6, var7 = self:GetInExpUpsellAnalyticsData()
        self.Analytics:reportJoinVoiceButtonEvent("clicked", var5, var6, var7, joinVoiceButtonContext, var3)
        self:reportJoinVoiceUpsellEvent("Click", joinVoiceButtonContext, var3)
    end

    if FFlagVoiceRewarmGrafanaMetrics and bool15 ~= nil then
        self.Analytics:reportVoiceRewarmClicked(bool15, var3)
    end

    if self:IsSeamlessVoice() then
        task.spawn(function()
            self.coreVoiceManager:PostUserVoiceConnectionStatus(true)
        end)
    end
end

function module:EligibleForFaeUpsell()
    local var3 = self.coreVoiceManager:EligibleForFaeUpsell()
        and self.AvatarChatService:deviceMeetsRequirementsForFeature(Enum.DeviceFeatureType.InExperienceFAE)

    if var3 then
        if FFlagTestDeviceForFAEUpsell then
            return (deviceMeetsRequirementsForFAE())
        end

        var3 = true
    end

    return var3
end

function module:EligibleForAgeCheckToast()
    return self.coreVoiceManager:EligibleForAgeCheckToast()
end

function module.ShouldShowJoinVoice(arg1)
    local var3, var4

    if not FFlagVoiceRewarmTelemetry then
        if not arg1:EligibleForFaeUpsell()
            and (not arg1:HasSeamlessVoiceFeature(VoiceChatCore.Constants.SeamlessVoiceFeatures.InitialJoinVoice)
                or arg1:GetVoiceConnectCookie() ~= "")
            and not (bool10 and (if bool11 then arg1:ShouldRewarmUser() else arg1:GetVoiceRewarmCookie() == "") and arg1:VoiceChatEnded())
        then
            if arg1:EligibleForAgeCheckToast() then
                if bool14 then
                    arg1.joinVoiceButtonContext = "AgeCheckToast"
                end
                return true
            end

            var3 = arg1:UserInInExperienceUpsellTreatment()
            var4 = arg1:UserOnlyEligibleForVoice() or arg1:UserVoiceEnabled()

            if GetFFlagIntegratePhoneUpsellJoinVoice()
                and GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints()
                and not var4
                and not arg1:UserVoiceEnabled()
                and arg1:FetchPhoneVerificationUpsell(Constants3.IN_EXP_PHONE_UPSELL_IXP_LAYER) == Constants3.PHONE_UPSELL_VALUE_PROP.VoiceChat
            then
                if bool14 then
                    arg1.joinVoiceButtonContext = "PhoneUpsell"
                end
                return true
            end

            if bool14 and var3 and var4 then
                arg1.joinVoiceButtonContext = "InExpUpsell"
            end

            return var3 and var4
        end

        return true
    end

    if arg1:EligibleForFaeUpsell() then
        arg1.joinVoiceButtonContext = "FaeUpsell"
        return true
    end

    if arg1:HasSeamlessVoiceFeature(VoiceChatCore.Constants.SeamlessVoiceFeatures.InitialJoinVoice)
        and arg1:GetVoiceConnectCookie() == ""
    then
        arg1.joinVoiceButtonContext = "VoiceFtux"
        return true
    end

    if bool10 then
        local bool15 = if bool11 then arg1:ShouldRewarmUser() else arg1:GetVoiceRewarmCookie() == ""

        if bool15 and arg1:GetVoiceConnectCookie() == "false" and arg1:UserVoiceEnabled() then
            arg1.joinVoiceButtonContext = "Rewarm"
            return true
        end
    end

    if arg1:EligibleForAgeCheckToast() then
        if bool14 then
            arg1.joinVoiceButtonContext = "AgeCheckToast"
        end
        return true
    end

    var3 = arg1:UserInInExperienceUpsellTreatment()
    var4 = arg1:UserOnlyEligibleForVoice() or arg1:UserVoiceEnabled()

    if GetFFlagIntegratePhoneUpsellJoinVoice()
        and GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints()
        and not var4
        and not arg1:UserVoiceEnabled()
        and arg1:FetchPhoneVerificationUpsell(Constants3.IN_EXP_PHONE_UPSELL_IXP_LAYER) == Constants3.PHONE_UPSELL_VALUE_PROP.VoiceChat
    then
        if bool14 then
            arg1.joinVoiceButtonContext = "PhoneUpsell"
        end
        return true
    end

    if bool14 and var3 and var4 then
        arg1.joinVoiceButtonContext = "InExpUpsell"
    end

    return var3 and var4
end

function module:ShouldShowJoinVoiceOnDisconnect()
    return self.coreVoiceManager:ShouldShowJoinVoiceOnDisconnect()
end

function module:IsSeamlessVoice()
    if GetFFlagCheckUniversePlaceBeforeSuspending() then
        return self.coreVoiceManager:IsSeamlessVoice()
    end
    local ageVerificationOverlayResult = self:FetchAgeVerificationOverlay()
    if not (ageVerificationOverlayResult and ageVerificationOverlayResult.voiceSettings) then
        var1:error("VoiceChatServiceManager:IsSeamlessVoice() - ageVerificationOverlayData or voiceSettings is nil")
        return false
    end

    local seamlessVoiceStatus = ageVerificationOverlayResult.voiceSettings.seamlessVoiceStatus
    return seamlessVoiceStatus == SeamlessVoiceStatus.EnabledExistingUser
        or seamlessVoiceStatus == SeamlessVoiceStatus.EnabledNewUser
end

function module:HasSeamlessVoiceFeature(arg1)
    return self.coreVoiceManager:HasSeamlessVoiceFeature(arg1)
end

function module:IsNewSeamlessVoiceUserDisconnect()
    return self.coreVoiceManager:IsNewSeamlessVoiceUserDisconnect()
end

function module.GetConnectDisconnectButtonAnalyticsData(tbl3, bool15: boolean)
    local str4 = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else ""

    local tbl4 = { game.GameId, game.PlaceId, str4 }
    if bool15 and tbl3:getService() then
        table.insert(tbl4, tbl3:GetSessionId())
    end
    return unpack(tbl4)
end

function module:GetConnectDisconnectAnalyticsData()
    local connectDisconnectAnalyticsData = {}

    local playSessionId = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else ""

    connectDisconnectAnalyticsData.universeId = game.GameId
    connectDisconnectAnalyticsData.placeId = game.PlaceId
    connectDisconnectAnalyticsData.playSessionId = playSessionId
    if GetFFlagNonVoiceFTUX() then
        connectDisconnectAnalyticsData.voiceSessionId = if self.service then self:GetSessionId() else ""
    else
        connectDisconnectAnalyticsData.voiceSessionId = self:GetSessionId()
    end
    connectDisconnectAnalyticsData.durationTimestamp = default:getTimestamp()

    return connectDisconnectAnalyticsData
end

function module:Leave()
    self:ensureInitialized("leave")
    self:SetVoiceConnectCookieValue(false)
    self.Analytics:reportConnectDisconnectEvents("voiceDisconnectEvent", self:GetConnectDisconnectAnalyticsData())
    local previousGroupId = self.service:GetGroupId()
    local previousMutedState = self.service:IsPublishPaused()
    if GetFFlagVoiceChatClientRewriteMasterLua() then
        local VoiceChatService2 = game:GetService("VoiceChatService")
        if VoiceChatService2 then
            VoiceChatService2:leaveVoice()
        end
    else
        self.service:Leave()
    end
    self:HideVoiceUI()
    self.previousGroupId = previousGroupId
    self.previousMutedState = previousMutedState
    if self:IsSeamlessVoice() then
        task.spawn(function()
            self.coreVoiceManager:PostUserVoiceConnectionStatus(false)
        end)
    end
end

function module.GetVoiceStateFromEnum(_, arg1)
    if not tbl1[arg1] then
        tbl1 = {
            [Enum.VoiceChatState.Idle] = VOICE_STATE.HIDDEN,
            [Enum.VoiceChatState.Joining] = VOICE_STATE.CONNECTING,
            [Enum.VoiceChatState.JoiningRetry] = VOICE_STATE.CONNECTING,
            [Enum.VoiceChatState.Joined] = VOICE_STATE.MUTED,
            [Enum.VoiceChatState.Leaving] = VOICE_STATE.MUTED,
            [Enum.VoiceChatState.Ended] = VOICE_STATE.HIDDEN,
            [Enum.VoiceChatState.Failed] = VOICE_STATE.ERROR
        }
    end
    return tbl1[arg1]
end

function module:GetInExpUpsellPromptFromEnum(str4: string)
    return tbl2[str4]
end

function module:getRecentUsersInteractionData()
    return self.coreVoiceManager:getRecentUsersInteractionData()
end

function module:_setRecentUserState(arg1, arg2)
    return self.coreVoiceManager:_setRecentUserState(arg1, arg2)
end

function module:_updateRecentUsersInteractionData()
    return self.coreVoiceManager:_updateRecentUsersInteractionData()
end

function module:SetupParticipantListeners()
    return self.coreVoiceManager:SetupParticipantListeners()
end

function module:Disconnect()
    if FFlagProactiveVoiceRestrictionsUFR then
        self.voiceRestrictionController.dispose()
    end
    if FFlagProactiveVoiceRestrictionsUFR and FFlagReactiveVoiceRestrictionsUFR then
        self.voiceInterventionConnection:disconnect()
    end
    self.coreVoiceManager:Disconnect()
    self.coreVoiceManager:unsubscribeAll()
end

function module:GetSendMuteEvent()
    return self.coreVoiceManager:GetSendMuteEvent()
end

function module:ToggleMic(str4: string?)
    return self.coreVoiceManager:ToggleMic(str4)
end

function module:SubscribeRetry(num3: number)
    self:ensureInitialized("subscribe retry")
    var1:debug("Attempting to retry connection to user: {}", (shorten(num3)))
    self.service:SubscribeRetry(num3)
end

function module:JoinByGroupIdToken(arg1, arg2)
    return self.coreVoiceManager:JoinByGroupIdToken(arg1, arg2)
end

function module:RejoinPreviousChannel()
    local previousGroupId = self.previousGroupId
    local previousMutedState = self.previousMutedState
    var1:debug("Rejoining previous channel {} with mute status {}", previousGroupId, previousMutedState)

    pcall(function()
        if GetFFlagVoiceChatClientRewriteMasterLua() then
            self.coreVoiceManager:RejoinVoice()
            local connectDisconnectAnalyticsData = self:GetConnectDisconnectAnalyticsData()
            connectDisconnectAnalyticsData.connectionSource = self.pendingConnectionSource
            self.pendingConnectionSource = nil
            self.Analytics:reportConnectDisconnectEvents("voiceConnectEvent", connectDisconnectAnalyticsData)
            if bool12 then
                self.Analytics:reportVoiceConnected(
                    (getEnumName(Constants3.VOICE_CONNECTION_SOURCE, connectDisconnectAnalyticsData.connectionSource))
                )
            end
            self.voiceConnectEventReportedForActiveSession = true
            return
        end
        if not previousGroupId or previousGroupId == "" then
            return
        end

        self.service:Leave()
        if not self.service:JoinByGroupIdToken(previousGroupId, previousMutedState, true) then
            self:InitialJoinFailedPrompt()
            return
        end
        local connectDisconnectAnalyticsData = self:GetConnectDisconnectAnalyticsData()
        connectDisconnectAnalyticsData.connectionSource = self.pendingConnectionSource
        self.pendingConnectionSource = nil
        self.Analytics:reportConnectDisconnectEvents("voiceConnectEvent", connectDisconnectAnalyticsData)
        if bool12 then
            self.Analytics:reportVoiceConnected(
                (getEnumName(Constants3.VOICE_CONNECTION_SOURCE, connectDisconnectAnalyticsData.connectionSource))
            )
        end
        self.voiceConnectEventReportedForActiveSession = true
    end)
end

function module.SwitchDevice(_, input, str4: string, str5: string)
    if input == VOICE_CHAT_DEVICE_TYPE.Input then
        SoundService:SetInputDevice(str4, str5)
        var1:info("[InputDeviceSelection] Setting SS Mic Device To {} {}", str4, str5)
        return
    end
    SoundService:SetOutputDevice(str4, str5)
    var1:info("[OutputDeviceSelection] Setting SS Speaker Device To {} {}", str4, str5)
end

function module.GetDevices(_, input)
    local success, result, result2, result3 = pcall(function()
        if input == VOICE_CHAT_DEVICE_TYPE.Input then
            return SoundService:GetInputDevices()
        end
        return SoundService:GetOutputDevices()
    end)

    return success, result, result2, result3
end

function module:VoiceChatAvailable(): boolean
    local service = self.service
    if self.available == nil and service then
        self.version = service:GetVoiceChatApiVersion()
        if self.version >= MIN_VOICE_CHAT_API_VERSION then
            self.available = service:GetVoiceChatAvailable()
            while self.available == VOICE_CHAT_AVAILABILITY.Checking do
                wait(1)
                self.available = service:GetVoiceChatAvailable()
            end
        end
    end

    if not service then
        return false
    end

    local version = self.version
    return MIN_VOICE_CHAT_API_VERSION <= version and self.available == VOICE_CHAT_AVAILABILITY.Available
end

function module:VoiceChatEnded(): boolean
    if not self.service then
        return true
    end

    local voiceChatState = self.service.VoiceChatState

    if bool6 then
        return voiceChatState == Enum.VoiceChatState.Ended
    end

    return voiceChatState == Enum.VoiceChatState.Ended or voiceChatState == Enum.VoiceChatState.Idle
end

function module.UnmountPrompt(arg1)
    if arg1.voiceChatPromptInstance ~= nil then
        Roact.unmount(arg1.voiceChatPromptInstance)
        arg1.voiceChatPromptInstance = nil
    end
end

module.default = module.new(
    CoreVoiceManager.default,
    nil,
    HttpRbxApiService,
    PermissionsProtocol.default,
    BlockingUtility:GetAfterBlockedStatusChangedEvent()
)

return module
