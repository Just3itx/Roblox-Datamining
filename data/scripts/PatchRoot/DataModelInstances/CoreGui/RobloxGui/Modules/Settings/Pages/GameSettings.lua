-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local SoundService = game:GetService("SoundService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local var1 = UserSettings()
local GameSettings = var1.GameSettings
local VideoCaptureService = game:GetService("VideoCaptureService")
local UserGameSettings = var1:GetService("UserGameSettings")
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local TextChatService = game:GetService("TextChatService")
local SafetyService = game:GetService("SafetyService")
local ExperienceStateCaptureService = if game:GetEngineFeature("CaptureModeEnabled") then game:GetService("ExperienceStateCaptureService") else nil

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local LocalizationService = game:GetService("LocalizationService")
local var2 = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)

local getCamMicPermissions = require(RobloxGui.Modules.Settings.getCamMicPermissions)
local isCamEnabledForUserAndPlace = require(RobloxGui.Modules.Settings.isCamEnabledForUserAndPlace)
local renderSettingsHeader = require(RobloxGui.Modules.Settings.Components.renderSettingsHeader)
local renderSettingsDivider = require(RobloxGui.Modules.Settings.Components.renderSettingsDivider)

local renderMoreSettingsBanner = if require(RobloxGui.Modules.Settings.Flags.FFlagEnablePioneerIGMSettingsBanner)
    and require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch() then require(RobloxGui.Modules.Settings.Components.renderMoreSettingsBanner) else nil

local default = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default
local isVoiceFocused = require(CorePackages.Workspace.Packages.CrossExperience).Utils.isVoiceFocused
local observeIsVoiceFocused = require(CorePackages.Workspace.Packages.CrossExperience).Utils.observeIsVoiceFocused

local cameraDevicePermissionGrantedSignal = require(CoreGui.RobloxGui.Modules.Settings.cameraDevicePermissionGrantedSignal)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local GetFFlagEnablePartyVoiceVolumeOnlyWhenInEligibleParty = SharedFlags.GetFFlagEnablePartyVoiceVolumeOnlyWhenInEligibleParty
local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local GetFFlagSelfViewCameraSettings = SharedFlags.GetFFlagSelfViewCameraSettings
local GetFFlagAlwaysShowVRToggle = require(RobloxGui.Modules.Flags.GetFFlagAlwaysShowVRToggle)

local GetFIntDebounceDisconnectButtonDelay = require(RobloxGui.Modules.Flags.GetFIntDebounceDisconnectButtonDelay)
local GetFIntDebounceAIRephraseSettingDelay = require(RobloxGui.Modules.Flags.GetFIntDebounceAIRephraseSettingDelay)
local GetFIntDebounceChatSummariesSettingDelay = require(RobloxGui.Modules.Flags.GetFIntDebounceChatSummariesSettingDelay)
local TouchEnabled = UserInputService.TouchEnabled
local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = SharedFlags.GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice
local FFlagIEMTabFocusNav = SharedFlags.FFlagIEMTabFocusNav
local bool1 = game:DefineFastFlag("ShowAntiHarassmentSettings", false)
local GetFFlagEnablePlayerNamesEnabledSetting = require(RobloxGui.Modules.Settings.Flags.GetFFlagEnablePlayerNamesEnabledSetting)
local FFlagUpdatePeopleNamesSettingCopy = require(RobloxGui.Modules.Settings.Flags.FFlagUpdatePeopleNamesSettingCopy)
local FFlagBadgeVisibilitySettingEnabled = SharedFlags.FFlagBadgeVisibilitySettingEnabled
local bool2 = game:DefineFastFlag("HideVoiceChatSelectorForFae_AEGIS2", false)
local bool3 = game:DefineFastFlag("CenterShiftLockOverride", true)
local bool4 = game:DefineFastFlag("VoiceChatSelectorReconnectFocus2_AEGIS2", false)
local bool5 = game:DefineFastFlag("MicroProfilerReadOnlyInformationLabel", false)
local FFlagEnableModerateChatRemoteEvent = SharedFlags.FFlagEnableModerateChatRemoteEvent
local bool6 = game:DefineFastFlag("VoiceSelectorAvailableAfterFae", false)
local bool7 = game:DefineFastFlag("InGameGraphicsFollowsSavedQuality", false)
local bool8 = game:DefineFastFlag("DifferentiateVoiceSelectorSystemAndUser", false)
local bool9 = game:DefineFastFlag("DeferProgrammaticChange", false)
local FFlagRenameVolumeToMainVolume = require(RobloxGui.Modules.Flags.FFlagRenameVolumeToMainVolume)
local FFlagAIRephraseSettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAIRephraseSettingEnabled
local FFlagChatSummariesSettingEnabled = SharedFlags.FFlagChatSummariesSettingEnabled

local var3 = SharedFlags.FFlagExpChatDictationVoiceTypingModeSetting
    and (SharedFlags.FFlagExpChatDictation or SharedFlags.FFlagExpChatContinuousDictation)
local FFlagVoiceRewarmTelemetry = SharedFlags.FFlagVoiceRewarmTelemetry
local bool10 = game:DefineFastFlag("DebounceVoiceSelectorIndexChange", false)
local bool11 = game:DefineFastFlag("VoiceSelectorIgnoreFailedStateDisconnect", false)

local FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider = require(RobloxGui.Modules.Settings.Flags.FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider)

local FFlagFriendsCallingCallVolumeSlider = require(RobloxGui.Modules.Settings.Flags.FFlagFriendsCallingCallVolumeSlider)
local FriendsCallingService = nil
local GetFriendsCallingStore = nil
if FFlagFriendsCallingCallVolumeSlider then
    FriendsCallingService = game:GetService("FriendsCallingService")
    GetFriendsCallingStore = require(CorePackages.Workspace.Packages.FriendsCalling.GetFriendsCallingStore)
end

local bool12 = game:DefineFastFlag("VoiceVolumeControlsFixSliderVisibilityOnEligibleGames", false)

local bool13 = game:DefineFastFlag("VoiceVolumeControlsDisableInteractionWhenNoMasterVolume", false)

local var4 = require(CorePackages.Workspace.Packages.VoiceChatCore).Flags.GetFFlagVoiceVolumeControlsEnableVoiceVolumeImpressionsTelemetry()

local FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast = require(RobloxGui.Modules.VoiceChat.Flags.FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast)

local bool14 = game:DefineFastFlag("VoiceVolumeControlsSuppressInExperienceUiForPartyVoice", false)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local default2 = require(CorePackages.Workspace.Packages.CrossExperienceVoice).IXPManager.default
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local GameSettingsConstants = require(RobloxGui.Modules.Settings.Resources.GameSettingsConstants)

local hasPartyVoiceVolume = default2 and default2.getHasPartyVoiceVolume()

local Constants = require(
    RobloxGui:WaitForChild("Modules"):WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants")
)

local tbl1 = {
    ["Enum.SavedQualitySetting.Automatic"] = 0,
    ["Enum.SavedQualitySetting.QualityLevel1"] = 1,
    ["Enum.SavedQualitySetting.QualityLevel2"] = 2,
    ["Enum.SavedQualitySetting.QualityLevel3"] = 3,
    ["Enum.SavedQualitySetting.QualityLevel4"] = 4,
    ["Enum.SavedQualitySetting.QualityLevel5"] = 5,
    ["Enum.SavedQualitySetting.QualityLevel6"] = 6,
    ["Enum.SavedQualitySetting.QualityLevel7"] = 7,
    ["Enum.SavedQualitySetting.QualityLevel8"] = 8,
    ["Enum.SavedQualitySetting.QualityLevel9"] = 9,
    ["Enum.SavedQualitySetting.QualityLevel10"] = 10
}

local function voiceChatVolumeToSlider(voiceChatVolume: number): number -- Luacid: Inlined by compiler; 4 call sites recovered
    return math.floor(voiceChatVolume * 5 + 0.5)
end

local function voiceChatVolumeFromSlider(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 / 5
end

local tbl2 = {
    DevComputerMovementMode = true,
    DevComputerCameraMode = true,
    DevEnableMouseLock = true
}

local tbl3 = { DevTouchMovementMode = true, DevTouchCameraMode = true }

local tbl4 = { DEFAULT_FOLLOW = "Default (Follow)", DEFAULT_CLASSIC = "Default (Classic)" }

local tbl5 = { Input = "Input", Output = "Output" }

local tbl6 = {
    DEFAULT_THUMBSTICK = "Default (Dynamic Thumbstick)",
    DEFAULT_KEYBOARD = "Default (Keyboard)",
    TAP_TO_MOVE = "Tap to Move",
    CLICK_TO_MOVE = "Click to Move"
}

local var5 = RobloxTranslator:FormatByKey("Feature.SettingsHub.TouchMovementMode.ClassicThumbstick")

local var6 = RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.Unavailable")
local var7 = RobloxTranslator:FormatByKey("CoreScripts.Feedback.EntryPoint.ButtonText")

local tbl7 = { On = 1, Off = 2 }

local function getDefaultCameraMode(): string -- Luacid: unused: defined but never referenced
    return if UserInputService.PreferredInput == Enum.PreferredInput.Touch then "Default (Follow)" else "Default (Classic)"
end

local function getDefaultMovementMode() -- Luacid: unused: defined but never referenced
    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        return RobloxTranslator:FormatByKey(Constants.MovementModeDynamicThumbstickKey)
    end
    return "Default (Keyboard)"
end

local function getDefaultSelectToMove(): string -- Luacid: unused: defined but never referenced
    return if UserInputService.PreferredInput == Enum.PreferredInput.Touch then "Tap to Move" else "Click to Move"
end

local SETTINGS_MENU_LAYOUT_ORDER = GameSettingsConstants.SETTINGS_MENU_LAYOUT_ORDER

local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper

local GetFFlagChatTranslationSettingEnabled = require(RobloxGui.Modules.Flags.GetFFlagChatTranslationSettingEnabled)
local GetFStringChatTranslationLayerName = require(RobloxGui.Modules.Flags.GetFStringChatTranslationLayerName)
local GetFFlagChatTranslationHoldoutEnabled = require(RobloxGui.Modules.Flags.GetFFlagChatTranslationHoldoutEnabled)
local GetFFlagChatTranslationWaitForIXP = require(RobloxGui.Modules.Flags.GetFFlagChatTranslationWaitForIXP)
local GetFFlagChatTranslationForceSetting = require(RobloxGui.Modules.Flags.GetFFlagChatTranslationForceSetting)
local GetFFlagChatTranslationNewDefaults = require(RobloxGui.Modules.Flags.GetFFlagChatTranslationNewDefaults)

local engineFeature = game:GetEngineFeature("TextChatServiceSettingsSaved")
local ChatTranslationOptionsWithChatLanguageSwitcherInitializer = require(
    RobloxGui.Modules.Settings.Pages.GameSettingsRowInitializers.ChatTranslationOptionsWithChatLanguageSwitcherInitializer
)

local engineFeature2 = game:GetEngineFeature("GameBasicSettingsFramerateCap")
local engineFeature3 = game:GetEngineFeature("RUUserScalePreferenceAPI")
local FFlagUIScaleEngineOptions = SharedFlags.FFlagUIScaleEngineOptions
local UIScaleOptions = require(CorePackages.Workspace.Packages.Responsive).UIScaleOptions

local bool15 = game:DefineFastFlag("FramerateCapIOSOptions", false)

local Utility = require(RobloxGui.Modules.Settings.Utility)

local CoreUtility = require(RobloxGui.Modules.CoreUtility)

local PlayerPermissionsModule = require(RobloxGui.Modules.PlayerPermissionsModule)
local GetHasGuiHidingPermission = require(RobloxGui.Modules.Common.GetHasGuiHidingPermission)
local Theme = require(RobloxGui.Modules.Settings.Theme)
local Cryo = require(CorePackages.Packages.Cryo)
local GfxReset = require(script.Parent.Parent.GfxReset)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local ThrottleFunctionCall = require(CoreGui.RobloxGui.Modules.Settings.Pages.ShareGame.ThrottleFunctionCall)
local SavedQualityFollower = require(RobloxGui.Modules.Settings.Pages.SavedQualityFollower)
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local Signals = require(CorePackages.Packages.Signals)
local Migration = BuilderIcons.Migration

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
RobloxGui:WaitForChild("Modules"):WaitForChild("Settings"):WaitForChild("SettingsHub")
local isEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

local LocalPlayer = Players.LocalPlayer
local platform = UserInputService:GetPlatform()
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)
local default3 = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local VoiceVolumeControlsEligibility = require(CorePackages.Workspace.Packages.VoiceChatCore).VoiceVolumeControlsEligibility
local default4 = require(CorePackages.Workspace.Packages.CrossExperienceVoice).CrossExperienceVoiceManager.default

local getAppFeaturePolicies = require(CorePackages.Workspace.Packages.UniversalAppPolicy).getAppFeaturePolicies

local var8 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Video.SystemDefault")
local var9 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Video.VideoCamera")

local var10 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)
game:DefineFastInt("RomarkStartWithGraphicQualityLevel", -1)
local fastInt = game:GetFastInt("RomarkStartWithGraphicQualityLevel")

local bool16 = not CachedPolicyService:IsSubjectToChinaPolicies()

local bool17 = platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.UWP
local bool18 = platform == Enum.Platform.IOS or platform == Enum.Platform.Android
if isInExperienceUIVREnabled then
    if not (bool18 or bool17) then
        bool16 = isSpatial() and bool16
    end
elseif not bool18 then
    bool16 = bool17 and bool16
end

local GetFIntVoiceChatDeviceChangeDebounceDelay = require(RobloxGui.Modules.Flags.GetFIntVoiceChatDeviceChangeDebounceDelay)
local GetFFlagVoiceChatUILogging = require(RobloxGui.Modules.Flags.GetFFlagVoiceChatUILogging)
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)
local GetFFlagEnableUniveralVoiceToasts = require(RobloxGui.Modules.Flags.GetFFlagEnableUniveralVoiceToasts)

local GetFFlagEnableExplicitSettingsChangeAnalytics = require(RobloxGui.Modules.Settings.Flags.GetFFlagEnableExplicitSettingsChangeAnalytics)

local GetFFlagFixCyclicFullscreenIndexEvent = require(RobloxGui.Modules.Settings.Flags.GetFFlagFixCyclicFullscreenIndexEvent)
local bool19 = game:DefineFastFlag("DisableFeedbackSoothsayerCheck", false)
local bool20 = game:DefineFastFlag("UserShowGuiHideToggles", false)
local bool21 = game:DefineFastFlag("UserFreecamGuiDestabilization", false)

local bool22 = game:DefineFastFlag("FixDeveloperConsoleButtonSizeAndPositioning", false)
local bool23 = game:DefineFastFlag("EnableTFFeedbackModeEntryCheck", false)

local bool24 = game:DefineFastFlag("FeedbackEntryPointButtonSizeAdjustment2", false)

local bool25 = game:DefineFastFlag("FeedbackEntryPointImprovedStrictnessCheck", false)
local GetFFlagEnableLocalesForExperienceLanguageSwitcher = require(RobloxGui.Modules.Settings.Flags.GetFFlagEnableLocalesForExperienceLanguageSwitcher)
local GetFFlagLazyInitiateExperienceLanguageSwitcher = require(RobloxGui.Modules.Settings.Flags.GetFFlagLazyInitiateExperienceLanguageSwitcher)
local ExperienceLanguageSwitcherInitializer = require(RobloxGui.Modules.Settings.Pages.GameSettingsRowInitializers.ExperienceLanguageSwitcherInitializer)

local PlayerChoiceTranslationSettingInitializer = require(RobloxGui.Modules.Settings.Pages.GameSettingsRowInitializers.PlayerChoiceTranslationSettingInitializer)

local bool26 = game:DefineFastFlag("UpdateVisibilitySettingsCopy", false)
local bool27 = game:DefineFastFlag("ExpChatDebounceRephraseIndexSelection", false)
local bool28 = game:DefineFastFlag("EraseFPSFromDefaultSetting", false)

local function reportSettingsChangeForAnalytics(name, arg2, arg3, arg4)
    if not GetFFlagEnableExplicitSettingsChangeAnalytics() or arg2 == arg3 or arg2 == nil or arg3 == nil then
        return
    end

    local additionalArgs = {
        universe_id = 0,
        name = 0,
        old_value = 0,
        new_value = 0,
        has_touch = 0,
        has_mouse = 0,
        has_gamepad = 0
    }
    local gameId = game.GameId
    additionalArgs.universe_id = tostring(gameId)
    additionalArgs.name = name
    additionalArgs.old_value = tostring(arg2)
    additionalArgs.new_value = tostring(arg3)
    additionalArgs.has_touch = UserInputService.TouchEnabled
    additionalArgs.has_mouse = UserInputService.MouseEnabled
    additionalArgs.has_gamepad = UserInputService.GamepadEnabled

    if arg4 then
        additionalArgs = Cryo.Dictionary.join(additionalArgs, arg4)
    end

    RbxAnalyticsService:SetRBXEventStream(
        Constants.AnalyticsTargetName,
        Constants.AnalyticsInGameMenuName,
        Constants.AnalyticsExplicitSettingsChangeName,
        additionalArgs
    )
end

local function reportSettingsForAnalytics()
    local additionalArgs = ({})
    local bool29 = UserInputService.PreferredInput == Enum.PreferredInput.Touch
    if bool29 then
        additionalArgs.camera_mode_touch = tostring(GameSettings.TouchCameraMovementMode)
    else
        additionalArgs.camera_mode_desktop = tostring(GameSettings.ComputerCameraMovementMode)
    end

    if bool29 then
        additionalArgs.movement_mode_touch = tostring(GameSettings.TouchMovementMode)
    else
        additionalArgs.movement_mode_desktop = tostring(GameSettings.ComputerMovementMode)
    end

    if UserInputService.MouseEnabled then
        additionalArgs.shift_lock_enabled = tostring(GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch)
    end

    if UserInputService.GamepadEnabled and GameSettings.IsUsingGamepadCameraSensitivity then
        local gamepadCameraSensitivity = GameSettings.GamepadCameraSensitivity
        additionalArgs.camera_sensitivity_gamepad = tostring(tonumber(string.format("%.2f", gamepadCameraSensitivity)))
    end
    if UserInputService.MouseEnabled then
        local mouseSensitivityFirstPersonX = GameSettings.MouseSensitivityFirstPerson.X
        additionalArgs.camera_sensitivity_mouse = tostring(tonumber(string.format("%.2f", mouseSensitivityFirstPersonX)))
    end

    additionalArgs.camera_y_inverted = tostring(GameSettings.CameraYInverted)
    additionalArgs.show_performance_stats = tostring(GameSettings.PerformanceStatsVisible)
    additionalArgs.volume = tostring(math.floor(GameSettings.MasterVolume * 10 + 0.5))
    if FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider then
        additionalArgs.voice_chat_volume = tostring((voiceChatVolumeToSlider(GameSettings.VoiceChatVolume)))
    end
    additionalArgs.gfx_quality_level = tostring(settings().Rendering.QualityLevel)
    if engineFeature2 then
        additionalArgs.framerate_cap = tostring(GameSettings.FramerateCap)
    end

    additionalArgs.fullscreen_enabled = tostring(GameSettings:InFullScreen())
    additionalArgs.microprofiler_enabled = tostring(GameSettings.OnScreenProfilerEnabled)
    additionalArgs.microprofiler_webserver_enabled = tostring(GameSettings.MicroProfilerWebServerEnabled)

    additionalArgs.reduced_motion = tostring(GameSettings.ReducedMotion)
    additionalArgs.preferred_transparency = tostring(GameSettings.PreferredTransparency)
    additionalArgs.preferred_text_size = tostring(GameSettings.PreferredTextSize)
    additionalArgs.ui_navigation_key_bind_enabled = tostring(GameSettings.UiNavigationKeyBindEnabled)

    additionalArgs.universeid = tostring(game.GameId)
    if GetFFlagEnablePlayerNamesEnabledSetting() then
        additionalArgs.player_names_enabled = tostring(GameSettings.PlayerNamesEnabled)
    end
    RbxAnalyticsService:SetRBXEventStream(
        Constants.AnalyticsTargetName,
        Constants.AnalyticsInGameMenuName,
        Constants.AnalyticsSettingsChangeName,
        additionalArgs
    )
end

game:DefineFastInt("V1MenuLanguageSelectionFeaturePerMillageRollout", 0)
game:DefineFastString("V1MenuLanguageSelectionFeatureForcedUserIds", "")
local bool29 = game:DefineFastFlag("IGMEnableGFXReset", false)

local function getLastValueChangerFrame(arg1)
    local layoutOrder = nil
    local valueChangerFrame = nil
    for _, row in pairs(arg1:GetRows()) do
        local selectionFrame = row.SelectionFrame

        if not layoutOrder or layoutOrder <= selectionFrame.LayoutOrder then
            layoutOrder = selectionFrame.LayoutOrder
            valueChangerFrame = arg1:getValueChangerFrame(row.ValueChanger)
        end
    end

    return valueChangerFrame
end

local function getFirstValueChangerFrame(arg1)
    if not FFlagIEMTabFocusNav then
        return
    end

    local layoutOrder = nil
    local valueChangerFrame = nil
    for _, row in pairs(arg1:GetRows()) do
        local selectionFrame = row.SelectionFrame

        if not layoutOrder or selectionFrame.LayoutOrder < layoutOrder then
            layoutOrder = selectionFrame.LayoutOrder
            valueChangerFrame = arg1:getValueChangerFrame(row.ValueChanger)
        end
    end

    return valueChangerFrame
end

local function Initialize()
    if bool29 then
        GfxReset.RunGfxReset()
    end

    local var11 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()
    if GetFFlagLazyInitiateExperienceLanguageSwitcher() then
        var11.LanguageSwitcherInitialized = false
    end

    local bool30 = false
    local tbl8 = {}
    local function onVRSettingsReady() -- Luacid: Inlined by compiler; 3 call sites recovered
        local vrEnabled = VRService.VREnabled
        for k, _ in pairs(tbl8) do
            k.Visible = not vrEnabled
        end
    end

    local function onVREnabled() -- Luacid: Inlined by compiler; 1 call site recovered
        if VRService.VREnabled and bool30 then
            onVRSettingsReady()
        end
    end

    VRService:GetPropertyChangedSignal("VREnabled"):connect(onVREnabled)
    onVREnabled()

    local function createGraphicsOptions()
        local num1 = if GameSettings:InFullScreen() then 1 else 2

        local var12 = var11
        local var13 = var11
        local var14 = var11
        local fullscreenFrame, fullscreenLabel, fullscreenEnabler = Utility:AddNewRow(var11, "Fullscreen", "Selector", { "On", "Off" }, num1)
        var12.FullscreenFrame = fullscreenFrame
        var13.FullscreenLabel = fullscreenLabel
        var14.FullscreenEnabler = fullscreenEnabler

        var11.FullscreenFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.FullScreenFrame

        tbl8[var11.FullscreenFrame] = true

        var11.FullscreenEnabler.IndexChanged:connect(function(arg1)
            local var18 = GameSettings:InFullScreen()
            if arg1 == 1 then
                if not GameSettings:InFullScreen() then
                    GuiService:ToggleFullscreen()
                    if not GetFFlagFixCyclicFullscreenIndexEvent() or var11.FullscreenEnabler.GetSelectedIndex() ~= 1 then
                        var11.FullscreenEnabler:SetSelectionIndex(1)
                    end
                end
            elseif arg1 == 2 and GameSettings:InFullScreen() then
                GuiService:ToggleFullscreen()
                if not GetFFlagFixCyclicFullscreenIndexEvent() or var11.FullscreenEnabler.GetSelectedIndex() ~= 2 then
                    var11.FullscreenEnabler:SetSelectionIndex(2)
                end
            end

            spawn(function()
                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    reportSettingsChangeForAnalytics("fullscreen_enabled", var18, GameSettings:InFullScreen())
                end
                reportSettingsForAnalytics()
            end)
        end)

        GameSettings.FullscreenChanged:connect(function(isFullscreen: boolean)
            if isFullscreen then
                if var11.FullscreenEnabler:GetSelectedIndex() ~= 1 then
                    var11.FullscreenEnabler:SetSelectionIndex(1)
                end
            elseif var11.FullscreenEnabler:GetSelectedIndex() ~= 2 then
                var11.FullscreenEnabler:SetSelectionIndex(2)
            end

            RbxAnalyticsService:SetRBXEventStream(
                Constants.AnalyticsTargetName,
                Constants.AnalyticsInGameMenuName,
                Constants.AnalyticsFullscreenModeName,
                { enabled = isFullscreen }
            )
        end)

        local num2 = if GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then 1 else 2

        local var18 = var11
        local var19 = var11
        local var20 = var11
        local graphicsEnablerFrame, graphicsEnablerLabel, graphicsQualityEnabler = Utility:AddNewRow(var11, "Graphics Mode", "Selector", { "Automatic", "Manual" }, num2)
        var18.GraphicsEnablerFrame = graphicsEnablerFrame
        var19.GraphicsEnablerLabel = graphicsEnablerLabel
        var20.GraphicsQualityEnabler = graphicsQualityEnabler

        var11.GraphicsEnablerFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.GraphicsEnablerFrame

        local var24 = var11
        local var25 = var11
        local var26 = var11
        local graphicsQualityFrame, graphicsQualityLabel, graphicsQualitySlider = Utility:AddNewRow(var11, "Graphics Quality", "Slider", 10, 1)
        var24.GraphicsQualityFrame = graphicsQualityFrame
        var25.GraphicsQualityLabel = graphicsQualityLabel
        var26.GraphicsQualitySlider = graphicsQualitySlider

        var11.GraphicsQualityFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.GraphicsQualityFrame
        var11.GraphicsQualitySlider:SetMinStep(1)

        if engineFeature2 and not VRService.VREnabled then
            local framerateCaps = Constants.FramerateCaps
            if bool15 and platform == Enum.Platform.IOS then
                framerateCaps = Constants.FramerateCapsIOS
            end

            local var30 = table.clone(framerateCaps)
            local tbl9 = { if bool28 then RobloxTranslator:FormatByKey("CoreScripts.InGameMenu.GameSettings.Default") else RobloxTranslator:FormatByKey(
                    "Feature.SettingsHub.GameSettings.FramerateCapDefaultEntry",
                    {
                        Frames = GameSettings:GetDefaultFramerateCap()
                    }
                ) }

            for _, frames in var30 do
                table.insert(tbl9, RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.FramerateEntry", { Frames = frames }))
            end

            table.insert(var30, 1, -1)

            task.defer(function()
                local var31 = var11
                local var32 = var11
                local var33 = var11
                local framerateCapFrame, framerateCapLabel, framerateCapMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.MaximumFramerate"),
                    "DropDown",
                    tbl9,
                    if bool15 then table.find(var30, GameSettings.FramerateCap) or 1 else table.find(var30, GameSettings.FramerateCap),
                    nil,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.MaximumFramerate.Description")
                )
                var31.FramerateCapFrame = framerateCapFrame
                var32.FramerateCapLabel = framerateCapLabel
                var33.FramerateCapMode = framerateCapMode

                var11.FramerateCapFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.FramerateCap

                var11.FramerateCapMode.IndexChanged:Connect(function(arg1)
                    local framerateCap = GameSettings.FramerateCap
                    GameSettings.FramerateCap = var30[arg1]

                    if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                        reportSettingsChangeForAnalytics("framerate_cap", framerateCap, GameSettings.FramerateCap)
                    end

                    reportSettingsForAnalytics()
                end)
            end)
        end

        settings().Rendering.EnableFRM = true
        local savedQualityFollower = if bool7 then SavedQualityFollower.new(var11.GraphicsQualityEnabler, var11.GraphicsQualitySlider) else nil

        function SetGraphicsQuality(savedQualityLevel, arg2)
            if bool7 and savedQualityFollower:isShowing() then
                return
            end
            if bool29 then
                local var30, qualityLevel = GfxReset.TemporaryOverride(savedQualityLevel)
                if var30 then
                    settings().Rendering.QualityLevel = qualityLevel
                    return
                end
            end

            local var30 = savedQualityLevel / 10
            local num3 = math.floor((settings().Rendering:GetMaxQualityLevel() - 1) * var30)
            if num3 == 20 then
                num3 = 21
            elseif savedQualityLevel == 1 then
                num3 = 1
            elseif savedQualityLevel < 1 and not arg2 then
                savedQualityLevel = 1
                num3 = 1
            elseif settings().Rendering:GetMaxQualityLevel() < num3 then
                num3 = settings().Rendering:GetMaxQualityLevel() - 1
            end

            GameSettings.SavedQualityLevel = savedQualityLevel
            settings().Rendering.QualityLevel = num3
        end

        local function setGraphicsToAuto() -- Luacid: Inlined by compiler; 3 call sites recovered
            var11.GraphicsQualitySlider:SetZIndex(1)
            var11.GraphicsQualityLabel.ZIndex = 1
            var11.GraphicsQualitySlider:SetInteractable(false)

            SetGraphicsQuality(Enum.QualityLevel.Automatic.Value, true)
        end

        local function setGraphicsToManual(arg1)
            var11.GraphicsQualitySlider:SetZIndex(2)
            var11.GraphicsQualityLabel.ZIndex = 2
            var11.GraphicsQualitySlider:SetInteractable(true)

            if var11.GraphicsQualitySlider:GetValue() == arg1 then
                SetGraphicsQuality(arg1)
                return
            end
            var11.GraphicsQualitySlider:SetValue(arg1)
        end

        local bool31 = false
        var11.GraphicsQualitySlider.ValueChanged:connect(function(arg1)
            SetGraphicsQuality(arg1)
            if bool31 == true and not (bool7 and savedQualityFollower:isShowing()) then
                reportSettingsForAnalytics()
            end
            bool31 = true
        end)

        var11.GraphicsQualityEnabler.IndexChanged:connect(function(arg1)
            local tbl9 = {
                Automatic = { Name = "Automatic", Value = 1 },
                Manual = { Name = "Manual", Value = 2 }
            }
            local automaticName = tbl9.Automatic.Name
            local manualName = tbl9.Manual.Name
            if arg1 == tbl9.Automatic.Value then
                automaticName = tbl9.Manual.Name
                manualName = tbl9.Automatic.Name
                setGraphicsToAuto()
            elseif arg1 == tbl9.Manual.Value then
                setGraphicsToManual(var11.GraphicsQualitySlider:GetValue())
            end
            if not (bool7 and savedQualityFollower:isShowing()) then
                reportSettingsForAnalytics()
                reportSettingsChangeForAnalytics("gfx_mode", automaticName, manualName)
            end
        end)

        game.GraphicsQualityChangeRequest:Connect(function(betterQuality: boolean)
            if GameSettings.SavedQualityLevel ~= Enum.SavedQualitySetting.Automatic then
                local value = var11.GraphicsQualitySlider:GetValue()
                local var30 = if betterQuality then value + 1 else value - 1
                var11.GraphicsQualitySlider:SetValue(var30)
            end
        end)

        if fastInt >= 0 then
            if fastInt == 0 then
                var11.GraphicsQualityEnabler:SetSelectionIndex(1)
                setGraphicsToAuto()
            else
                var11.GraphicsQualityEnabler:SetSelectionIndex(2)
                setGraphicsToManual(fastInt)
            end
        elseif GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
            var11.GraphicsQualitySlider:SetValue(5)
            setGraphicsToAuto()
        else
            local str1 = tostring(GameSettings.SavedQualityLevel)
            local var30 = if tbl1[str1] then tbl1[str1] else 10

            SetGraphicsQuality(var30)
            spawn(function()
                var11.GraphicsQualitySlider:SetValue(var30)
            end)
        end

        if bool7 then
            GameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function()
                savedQualityFollower:show(GameSettings.SavedQualityLevel)
            end)
        end
    end

    local function createReducedMotionOptions()
        local num1 = if GameSettings.ReducedMotion then 1 else 2

        local var12 = RobloxTranslator:FormatByKey("Feature.Accessibility.Heading.ReducedMotion")
        local var13 = RobloxTranslator:FormatByKey("Feature.Accessibility.Description.ReducedMotion")
        local var14 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var15 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")

        local var16 = var11
        local var17 = var11
        local var18 = var11
        local reducedMotionFrame, reducedMotionLabel, reducedMotionMode = Utility:AddNewRow(var11, var12, "Selector", { var14, var15 }, num1, nil, var13)
        var16.ReducedMotionFrame = reducedMotionFrame
        var17.ReducedMotionLabel = reducedMotionLabel
        var18.ReducedMotionMode = reducedMotionMode

        var11.ReducedMotionFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.ReducedMotionFrame

        var11.ReducedMotionMode.IndexChanged:connect(function(arg1)
            local reducedMotion = GameSettings.ReducedMotion
            GameSettings.ReducedMotion = arg1 == 1

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("reduced_motion", reducedMotion, GameSettings.ReducedMotion)
            end
            reportSettingsForAnalytics()
        end)
    end

    local function createPlayerNamesEnabledOptions()
        local var12 = if bool26 then RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.PeoplesNames") elseif FFlagUpdatePeopleNamesSettingCopy then RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.PeopleNames") else RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.PlayerNames")
        local var13 = if FFlagUpdatePeopleNamesSettingCopy then RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.PeopleNames.Description") else nil

        local function GetPlayerNamesEnabledStartIndex(): number -- Luacid: unused: defined but never referenced
            return if GameSettings.PlayerNamesEnabled then 1 else 2
        end

        local num1 = if GameSettings.PlayerNamesEnabled then tbl7.On else tbl7.Off
        local var14 = if bool26 then RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Show") else RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var15 = if bool26 then RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Hide") else RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")
        local var16 = var11
        local var17 = var11
        local var18 = var11
        local playerNamesEnabledFrame, playerNamesEnabledLabel, playerNamesEnabledMode = Utility:AddNewRow(var11, var12, "Selector", { var14, var15 }, num1, nil, var13)
        var16.PlayerNamesEnabledFrame = playerNamesEnabledFrame
        var17.playerNamesEnabledLabel = playerNamesEnabledLabel
        var18.playerNamesEnabledMode = playerNamesEnabledMode

        var11.PlayerNamesEnabledFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.PlayerNamesEnabledFrame

        var11.playerNamesEnabledMode.IndexChanged:connect(function(arg1)
            local playerNamesEnabled = GameSettings.PlayerNamesEnabled
            GameSettings.PlayerNamesEnabled = arg1 == 1

            reportSettingsChangeForAnalytics("player_names_enabled", playerNamesEnabled, GameSettings.PlayerNamesEnabled)
            reportSettingsForAnalytics()
        end)
    end

    local function createPreferredTransparencyOptions()
        local num1 = 10 - math.clamp(math.floor(GameSettings.PreferredTransparency * 10 + 0.5), 0, 10)

        local var12 = RobloxTranslator:FormatByKey("Feature.Accessibility.Heading.PreferredTransparency")

        local var13 = RobloxTranslator:FormatByKey("Feature.Accessibility.Description.PreferredTransparency")

        local var14 = RobloxTranslator:FormatByKey("Feature.Accessibility.PreferredTransparency.Transparent")

        local var15 = RobloxTranslator:FormatByKey("Feature.Accessibility.PreferredTransparency.Opaque")

        local var16 = var11
        local var17 = var11
        local var18 = var11
        local preferredTransparencyFrame, preferredTransparencyLabel, preferredTransparencySlider = Utility:AddNewRow(var11, var12, "Slider", 10, num1, nil, var13, var14, var15)
        var16.PreferredTransparencyFrame = preferredTransparencyFrame
        var17.PreferredTransparencyLabel = preferredTransparencyLabel
        var18.PreferredTransparencySlider = preferredTransparencySlider

        var11.PreferredTransparencyFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.PreferredTransparencyFrame

        var11.PreferredTransparencySlider.ValueChanged:connect(function(arg1)
            arg1 = (10 - math.clamp(math.floor(arg1), 0, 10)) / 10
            local preferredTransparency = GameSettings.PreferredTransparency
            GameSettings.PreferredTransparency = arg1

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("preferred_transparency", preferredTransparency, GameSettings.PreferredTransparency)
            end
            reportSettingsForAnalytics()
        end)
    end

    local function createPreferredTextSizeOptions()
        local enumItems = Enum.PreferredTextSize:GetEnumItems()
        local var12 = GameSettings.PreferredTextSize.Value - 1

        local var13 = RobloxTranslator:FormatByKey("Feature.Accessibility.Heading.PreferredTextSize")

        local var14 = RobloxTranslator:FormatByKey("Feature.Accessibility.Description.PreferredTextSize")

        local var15 = RobloxTranslator:FormatByKey("Feature.Accessibility.PreferredTextSize.Default")

        local var16 = RobloxTranslator:FormatByKey("Feature.Accessibility.PreferredTextSize.Largest")

        local var17 = var11
        local var18 = var11
        local var19 = var11
        local preferredTextSizeFrame, preferredTextSizeLabel, preferredTextSizeSlider = Utility:AddNewRow(var11, var13, "Slider", 3, var12, nil, var14, var15, var16)
        var17.PreferredTextSizeFrame = preferredTextSizeFrame
        var18.PreferredTextSizeLabel = preferredTextSizeLabel
        var19.PreferredTextSizeSlider = preferredTextSizeSlider

        var11.PreferredTextSizeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.PreferredTextSizeFrame

        var11.PreferredTextSizeSlider.ValueChanged:connect(function(arg1)
            local preferredTextSize = GameSettings.PreferredTextSize
            GameSettings.PreferredTextSize = enumItems[arg1 + 1]
            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("preferred_text_size", preferredTextSize, GameSettings.PreferredTextSize)
            end
            reportSettingsForAnalytics()
        end)
    end

    local var12 = nil
    local var13 = nil

    local function createUIScaleOptionsImpl()
        local autoUiScaleHundredths = GuiService:GetAutoUIScaleHundredths()
        local rawScreenScale = GuiService:GetRawScreenScale()
        local currentCamera = workspace.CurrentCamera
        if not currentCamera then
            return
        end
        local num1 = currentCamera.ViewportSize.Y * rawScreenScale * GuiService:GetEffectiveUIScaleHundredths() / 100

        local num2 = math.ceil(100 / rawScreenScale / 25) * 25
        local num3 = math.floor(num1 / (540 * rawScreenScale) * 4) / 4 * 100
        local num4 = math.round((num3 - num2) / 25)

        if num4 <= 0 then
            var12 = nil
            var13 = nil
            if var11.UIScaleModeFrame then
                var11.UIScaleModeFrame:Destroy()
                var11.UIScaleModeFrame = nil
            end
            if var11.UIScaleFrame then
                var11.UIScaleFrame:Destroy()
                var11.UIScaleFrame = nil
            end

            return
        end

        if var11.UIScaleModeFrame and num2 == var12 and num3 == var13 then
            return
        end

        var12 = num2
        var13 = num3

        if var11.UIScaleModeFrame then
            var11.UIScaleModeFrame:Destroy()
            var11.UIScaleModeFrame = nil
        end
        if var11.UIScaleFrame then
            var11.UIScaleFrame:Destroy()
            var11.UIScaleFrame = nil
        end

        local function indexToHundredths(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
            return num2 + arg1 * 25
        end

        local function hundredthsToIndex(arg1): number -- Luacid: Inlined by compiler; 2 call sites recovered
            return math.clamp(math.round((arg1 - num2) / 25), 0, num4)
        end

        local uiScaleMultiplierHundredths = UserGameSettings.UIScaleMultiplierHundredths
        local bool31 = uiScaleMultiplierHundredths ~= 0

        local num5 = if bool31 then hundredthsToIndex(uiScaleMultiplierHundredths) else 0

        local var14 = var11
        local var15 = var11
        local var16 = var11
        local uiScaleModeFrame, uiScaleModeLabel, uiScaleModeSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleMode"),
            "Selector",
            { var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleModeAuto"), var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleModeManual") },
            if bool31 then 2 else 1
        )
        var14.UIScaleModeFrame = uiScaleModeFrame
        var15.UIScaleModeLabel = uiScaleModeLabel
        var16.UIScaleModeSelector = uiScaleModeSelector

        var11.UIScaleModeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.UIScaleModeFrame

        local var20 = var11
        local var21 = var11
        local var22 = var11
        local uiScaleFrame, uiScaleLabel, uiScaleSlider = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScale"),
            "Slider",
            num4,
            num5,
            nil,
            nil,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleSmallest"),
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleLargest")
        )
        var20.UIScaleFrame = uiScaleFrame
        var21.UIScaleLabel = uiScaleLabel
        var22.UIScaleSlider = uiScaleSlider

        var11.UIScaleFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.UIScaleFrame
        var11.UIScaleFrame.Visible = bool31

        var11.UIScaleModeSelector.IndexChanged:connect(function(arg1)
            local bool32 = arg1 == 2
            var11.UIScaleFrame.Visible = bool32
            if bool32 then
                local multiplierHundredths = math.clamp(math.round(autoUiScaleHundredths / 25) * 25, num2, (indexToHundredths(num4)))
                var11.UIScaleSlider:SetValue((hundredthsToIndex(multiplierHundredths)))
                GuiService:SetUIScaleMultiplier(multiplierHundredths)
                reportSettingsChangeForAnalytics("ui_scale_mode", "auto", "manual")
            else
                GuiService:SetUIScaleMultiplier(0)
                reportSettingsChangeForAnalytics("ui_scale_mode", "manual", "auto")
            end
            reportSettingsForAnalytics()
        end)

        var11.UIScaleSlider.ValueChanged:connect(function(arg1)
            local uiScaleMultiplierHundredths2 = UserGameSettings.UIScaleMultiplierHundredths
            local multiplierHundredths = indexToHundredths(arg1)
            GuiService:SetUIScaleMultiplier(multiplierHundredths)
            reportSettingsChangeForAnalytics("ui_scale_value", uiScaleMultiplierHundredths2, multiplierHundredths)
            reportSettingsForAnalytics()
        end)
    end

    local function createUIScaleOptions() -- Luacid: Inlined by compiler; 3 call sites recovered
        local success, result = pcall(createUIScaleOptionsImpl)
        if not success then
            warn("createUIScaleOptions failed: " .. tostring(result))
        end
    end

    local var14 = nil
    local bool31 = false

    local function getUIScaleModeIndex(arg1): number -- Luacid: Inlined by compiler; 2 call sites recovered
        return if arg1.savedHundredths == 0 then 1 else 2
    end

    local function refreshUIScaleRows()
        local var15 = UIScaleOptions.get(GuiService)

        if not var11.UIScaleModeFrame or not var15 or var14 and UIScaleOptions.equal(var15, var14) then
            return
        end

        var14 = var15
        local uIScaleModeIndex = getUIScaleModeIndex(var15)
        local selectedIndex = var15.selectedIndex
        bool31 = true
        var11.UIScaleFrame.Visible = uIScaleModeIndex == 2
        if var11.UIScaleModeSelector:GetSelectedIndex() ~= uIScaleModeIndex then
            var11.UIScaleModeSelector:SetSelectionIndex(uIScaleModeIndex)
        end
        var11.UIScaleSlider:SetEnabledSteps(var15.enabled)
        var11.UIScaleSlider:SetValue(selectedIndex)
        bool31 = false
    end

    local function onUIScaleModeChanged(arg1)
        if bool31 or arg1 ~= var11.UIScaleModeSelector:GetSelectedIndex() then
            return
        end
        local bool32 = arg1 == 2
        local var15 = UIScaleOptions.get(GuiService)
        local multiplierHundredths = if var15 then UIScaleOptions.valueForMode(var15, bool32) else nil

        if multiplierHundredths == nil then
            return
        end
        GuiService:SetUIScaleMultiplier(multiplierHundredths)
        reportSettingsChangeForAnalytics(
            "ui_scale_mode",
            if bool32 then "auto" else "manual",
            if bool32 then "manual" else "auto"
        )
        refreshUIScaleRows()
    end

    local function onUIScaleSliderChanged(arg1)
        if bool31 then
            return
        end
        local var15 = UIScaleOptions.get(GuiService)
        if not var15 then
            return
        end
        local multiplierHundredths = UIScaleOptions.valueFromSlider(arg1, var11.UIScaleSlider:GetValue(), var14, var15)

        if multiplierHundredths then
            GuiService:SetUIScaleMultiplier(multiplierHundredths)
            reportSettingsChangeForAnalytics("ui_scale_value", var15.savedHundredths, multiplierHundredths)
        end

        refreshUIScaleRows()
    end

    local function createUIScaleRows()
        local var15 = UIScaleOptions.get(GuiService)
        if not var15 then
            return
        end
        local var16 = var11
        local var17 = var11
        local var18 = var11
        local uiScaleModeFrame, uiScaleModeLabel, uiScaleModeSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleMode"),
            "Selector",
            { var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleModeAuto"), var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleModeManual") },
            getUIScaleModeIndex(var15),
            nil,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleModeDescription")
        )
        var16.UIScaleModeFrame = uiScaleModeFrame
        var17.UIScaleModeLabel = uiScaleModeLabel
        var18.UIScaleModeSelector = uiScaleModeSelector

        var11.UIScaleModeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.UIScaleEngineModeFrame
        local var22 = var11
        local var23 = var11
        local var24 = var11
        local uiScaleFrame, uiScaleLabel, uiScaleSlider = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScale"),
            "Slider",
            #var15.values,
            var15.selectedIndex,
            nil,
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleDescription"),
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleSmallest"),
            var2:Format("CoreScripts.InGameMenu.GameSettings.UIScaleLargest")
        )
        var22.UIScaleFrame = uiScaleFrame
        var23.UIScaleLabel = uiScaleLabel
        var24.UIScaleSlider = uiScaleSlider

        var11.UIScaleFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.UIScaleEngineFrame
        var11.UIScaleSlider:SetMinStep(1)

        var11.UIScaleModeSelector.IndexChanged:Connect(onUIScaleModeChanged)
        var11.UIScaleSlider.ValueChanged:connect(onUIScaleSliderChanged)

        refreshUIScaleRows()
    end

    local function createUiNavigationKeyBindOptions()
        local tbl9 = { On = 1, Off = 2 }

        local num1 = if GameSettings.UiNavigationKeyBindEnabled then 1 else 2

        local var15 = RobloxTranslator:FormatByKey("Feature.Accessibility.Heading.UiNavigationKeyBind")

        local var16 = RobloxTranslator:FormatByKey(
            "Feature.Accessibility.Description.UiNavigationKeyBind",
            {
                uiNavigationKey = UserInputService:GetStringForKeyCode(Enum.KeyCode.BackSlash)
            }
        )
        local var17 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var18 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")

        local var19 = var11
        local var20 = var11
        local var21 = var11
        local uiNavigationKeyBindEnabledFrame, uiNavigationKeyBindEnabledLabel, uiNavigationKeyBindEnabledMode = Utility:AddNewRow(var11, var15, "Selector", { var17, var18 }, num1, nil, var16)
        var19.UiNavigationKeyBindEnabledFrame = uiNavigationKeyBindEnabledFrame
        var20.UiNavigationKeyBindEnabledLabel = uiNavigationKeyBindEnabledLabel
        var21.UiNavigationKeyBindEnabledMode = uiNavigationKeyBindEnabledMode

        var11.UiNavigationKeyBindEnabledFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.UiNavigationKeyBindEnabledFrame

        var11.UiNavigationKeyBindEnabledMode.IndexChanged:connect(function(arg1)
            local uiNavigationKeyBindEnabled = GameSettings.UiNavigationKeyBindEnabled
            GameSettings.UiNavigationKeyBindEnabled = arg1 == 1

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics(
                    "ui_navigation_key_bind_enabled",
                    uiNavigationKeyBindEnabled,
                    GameSettings.UiNavigationKeyBindEnabled
                )
            end
            reportSettingsForAnalytics()
        end)
        local function updateUiNavigationKeyBindVisibility() -- Luacid: unused: defined but never referenced
            local keyboardEnabled = UserInputService.KeyboardEnabled
            if not var11.UiNavigationKeyBindEnabledFrame then
                return
            end

            var11.UiNavigationKeyBindEnabledFrame.Visible = keyboardEnabled
            if keyboardEnabled then
                var11.UiNavigationKeyBindEnabledMode:SetSelectionIndex(if GameSettings.UiNavigationKeyBindEnabled then 1 else 2)
                return
            end
            var11.UiNavigationKeyBindEnabledMode:SetSelectionIndex(2)
            GameSettings.UiNavigationKeyBindEnabled = false
        end

        local keyboardEnabled = UserInputService.KeyboardEnabled
        if var11.UiNavigationKeyBindEnabledFrame then
            var11.UiNavigationKeyBindEnabledFrame.Visible = keyboardEnabled
            if keyboardEnabled then
                var11.UiNavigationKeyBindEnabledMode:SetSelectionIndex(
                    if GameSettings.UiNavigationKeyBindEnabled then tbl9.On or tbl9.Off else tbl9.Off
                )
            else
                var11.UiNavigationKeyBindEnabledMode:SetSelectionIndex(tbl9.Off)
                GameSettings.UiNavigationKeyBindEnabled = false
            end
        end

        UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(function()
            local keyboardEnabled2 = UserInputService.KeyboardEnabled
            if not var11.UiNavigationKeyBindEnabledFrame then
                return
            end

            var11.UiNavigationKeyBindEnabledFrame.Visible = keyboardEnabled2
            if keyboardEnabled2 then
                var11.UiNavigationKeyBindEnabledMode:SetSelectionIndex(GameSettings.UiNavigationKeyBindEnabled and tbl9.On or tbl9.Off)
                return
            end
            var11.UiNavigationKeyBindEnabledMode:SetSelectionIndex(tbl9.Off)
            GameSettings.UiNavigationKeyBindEnabled = false
        end)
    end

    local function createPerformanceStatsOptions()
        local var15 = var11
        local var16 = var11
        local var17 = var11
        var11.PerformanceStatsFrame = nil
        var15.PerformanceStatsLabel = nil
        var16.PerformanceStatsMode = nil
        var17.PerformanceStatsOverrideText = nil

        function GetDesiredPerformanceStatsIndex(): number
            return if GameSettings.PerformanceStatsVisible then 1 else 2
        end

        local desiredPerformanceStatsIndex = GetDesiredPerformanceStatsIndex()

        local var18 = var11
        local var19 = var11
        local var20 = var11
        local performanceStatsFrame, performanceStatsLabel, performanceStatsMode = Utility:AddNewRow(var11, "Performance Stats", "Selector", { "On", "Off" }, desiredPerformanceStatsIndex)
        var18.PerformanceStatsFrame = performanceStatsFrame
        var19.PerformanceStatsLabel = performanceStatsLabel
        var20.PerformanceStatsMode = performanceStatsMode

        var11.PerformanceStatsFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.PerformanceStatsFrame

        local var24 = var11
        var24.PerformanceStatsOverrideText = Create("TextLabel")({
            Name = "PerformanceStatsLabel",
            Text = "Set by Developer",
            TextColor3 = Color3.new(1, 1, 1),
            Font = Theme.font(Enum.Font.SourceSans, "GameSettings"),
            FontSize = Theme.fontSize(Enum.FontSize.Size24, "GameSettings"),
            BackgroundTransparency = 1,
            Size = if bool3 then UDim2.new(0.6, 0, 1, 0) else UDim2.new(0, 200, 1, 0),
            Position = if bool3 then UDim2.new(1, 0, 0.5, 0) else UDim2.new(1, -350, 0, 0),
            AnchorPoint = if bool3 then Vector2.new(1, 0.5) else nil,
            Visible = false,
            ZIndex = 2,
            Parent = var11.PerformanceStatsFrame
        })

        var11.PerformanceStatsMode.IndexChanged:connect(function(arg1)
            local performanceStatsVisible = if GetFFlagEnableExplicitSettingsChangeAnalytics() then GameSettings.PerformanceStatsVisible else nil

            if arg1 == 1 then
                GameSettings.PerformanceStatsVisible = true
            else
                GameSettings.PerformanceStatsVisible = false
            end

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics(
                    "show_performance_stats",
                    performanceStatsVisible,
                    GameSettings.PerformanceStatsVisible
                )
            end
            reportSettingsForAnalytics()
        end)

        GameSettings.PerformanceStatsVisibleChanged:connect(function()
            local desiredPerformanceStatsIndex2 = GetDesiredPerformanceStatsIndex()
            if desiredPerformanceStatsIndex2 ~= var11.PerformanceStatsMode.CurrentIndex then
                var11.PerformanceStatsMode:SetSelectionIndex(desiredPerformanceStatsIndex2)
            end
        end)
    end

    local function createWebServerInformationRow()
        local var15 = var11
        local var16 = var11
        local var17 = var11
        local informationFrame, informationLabel, informationTextBox = Utility:AddNewRow(var11, "MicroProfiler Information", "TextBox", nil, nil, 5, nil, nil, nil, not bool5 and nil)
        var15.InformationFrame = informationFrame
        var16.InformationLabel = informationLabel
        var17.InformationTextBox = informationTextBox

        var11.InformationFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.InformationFrame

        var11.InformationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

        if TouchEnabled then
            var11.InformationText = Create("TextLabel")({
                Name = "InformationLabel",
                Text = "Information Loading",
                Font = Theme.font(Enum.Font.SourceSans),
                FontSize = Theme.fontSize(Enum.FontSize.Size18),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 800, 1, 0),
                Position = UDim2.new(0, 5, 0, 0),
                Visible = true,
                ZIndex = 2,
                Parent = var11.InformationFrame
            })
        else
            var11.InformationText = Create("TextLabel")({
                Name = "InformationLabel",
                Text = "Information Loading",
                Font = Theme.font(Enum.Font.SourceSans),
                FontSize = Theme.fontSize(Enum.FontSize.Size14),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 800, 1, 0),
                Position = UDim2.new(1, -650, 0, 20),
                Visible = true,
                ZIndex = 2,
                Parent = var11.InformationFrame
            })
        end

        return var11.InformationFrame, var11.InformationText
    end

    local function createMicroProfilerOptions()
        local var15 = var11
        local var16 = var11
        local var17 = var11
        var11.MicroProfilerFrame = nil
        var15.MicroProfilerLabel = nil
        var16.MicroProfilerMode = nil
        var17.MicroProfilerOverrideText = nil

        local function tryContentLabel(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            local microProfilerWebServerPort = GameSettings.MicroProfilerWebServerPort
            if microProfilerWebServerPort == 0 then
                return false
            end

            local var18 = var11
            local var19 = var11
            local informationFrame, informationText = createWebServerInformationRow()
            var18.InformationFrame = informationFrame
            var19.InformationText = informationText
            var11.InformationText.Text = GameSettings.MicroProfilerWebServerIP .. microProfilerWebServerPort
            return true
        end

        local function setMicroProfilerIndex(arg1)
            local function hideContentLabel() -- Luacid: Inlined by compiler; 2 call sites recovered
                GameSettings.MicroProfilerWebServerEnabled = false

                if not var11.InformationFrame and not var11.InformationText then
                    return
                end

                var11.InformationFrame.Visible = false
                var11.InformationFrame.Parent = nil
                var11.InformationText.Parent = nil
                var11.InformationFrame = nil
                var11.InformationText = nil
            end

            local var18 = nil
            local var19 = nil
            local var20 = nil

            if bool18 then
                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    var19 = GameSettings.MicroProfilerWebServerEnabled
                    var18 = "webserver"
                end

                if arg1 == 1 then
                    GameSettings.MicroProfilerWebServerEnabled = true
                    local num1 = 30

                    while num1 >= 1 and not tryContentLabel() do
                        num1 -= 1
                        wait(0.1)
                    end

                    if num1 <= 0 then
                        var11.MicroProfilerMode:SetSelectionIndex(2)
                        hideContentLabel()
                    end
                else
                    hideContentLabel()
                end

                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    var20 = GameSettings.MicroProfilerWebServerEnabled
                end
            elseif bool17 or isInExperienceUIVREnabled and isSpatial() then
                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    var19 = GameSettings.OnScreenProfilerEnabled
                    var18 = "regular"
                end

                GameSettings.OnScreenProfilerEnabled = arg1 == 1

                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    var20 = GameSettings.OnScreenProfilerEnabled
                end
            end

            RbxAnalyticsService:ReportCounter("MicroprofilerSettingsPressed")

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("microprofiler_enabled", var19, var20, { microprofiler_type = var18 })
            end

            reportSettingsForAnalytics()
        end

        local function GetDesiredWebServerIndex(): number -- Luacid: Inlined by compiler; 1 call site recovered
            if bool18 then
                if GameSettings.MicroProfilerWebServerEnabled then
                    return 1
                end

                return 2
            end

            if bool17 or isInExperienceUIVREnabled and isSpatial() then
                if GameSettings.OnScreenProfilerEnabled then
                    return 1
                end

                return 2
            end

            return 2
        end

        local desiredWebServerIndex = GetDesiredWebServerIndex()

        local var18 = RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.MicroProfiler")
        local var19 = var11
        local var20 = var11
        local var21 = var11
        local microProfilerFrame, microProfilerLabel, microProfilerMode = Utility:AddNewRow(var11, var18, "Selector", { "On", "Off" }, desiredWebServerIndex)
        var19.MicroProfilerFrame = microProfilerFrame
        var20.MicroProfilerLabel = microProfilerLabel
        var21.MicroProfilerMode = microProfilerMode

        var11.MicroProfilerFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.MicroProfilerFrame
        tryContentLabel()
        local bool32 = false

        GameSettings:GetPropertyChangedSignal("OnScreenProfilerEnabled"):Connect(function()
            bool32 = true

            if GameSettings.OnScreenProfilerEnabled then
                var11.MicroProfilerMode:SetSelectionIndex(1)
                return
            end
            var11.MicroProfilerMode:SetSelectionIndex(2)
        end)

        var11.MicroProfilerMode.IndexChanged:connect(function(...) -- name: onIndexChanged
            if bool32 then
                bool32 = false
                return
            end
            setMicroProfilerIndex(...)
        end)
    end
    local function createCameraModeOptions(arg1)
        local var15 = var11
        local var16 = var11
        local var17 = var11
        var11.ShiftLockFrame = nil
        var15.ShiftLockLabel = nil
        var16.ShiftLockMode = nil
        var17.ShiftLockOverrideText = nil

        local num1 = if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then 1 else 2

        local var18 = var11
        local var19 = var11
        local var20 = var11
        local shiftLockFrame, shiftLockLabel, shiftLockMode = Utility:AddNewRow(var11, "Shift Lock Switch", "Selector", { "On", "Off" }, num1)
        var18.ShiftLockFrame = shiftLockFrame
        var19.ShiftLockLabel = shiftLockLabel
        var20.ShiftLockMode = shiftLockMode

        var11.ShiftLockFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.ShiftLockFrame

        tbl8[var11.ShiftLockFrame] = true

        local var24 = var11
        var24.ShiftLockOverrideText = Create("TextLabel")({
            Name = "ShiftLockOverrideLabel",
            Text = "Set by Developer",
            TextColor3 = Color3.new(1, 1, 1),
            Font = Theme.font(Enum.Font.SourceSans, "GameSettings"),
            FontSize = Theme.fontSize(Enum.FontSize.Size24, "GameSettings"),
            BackgroundTransparency = 1,
            Size = if bool3 then UDim2.new(0.6, 0, 1, 0) else UDim2.new(0, 200, 1, 0),
            Position = if bool3 then UDim2.new(1, 0, 0.5, 0) else UDim2.new(1, -350, 0, 0),
            AnchorPoint = if bool3 then Vector2.new(1, 0.5) else nil,
            Visible = false,
            ZIndex = 2,
            Parent = var11.ShiftLockFrame
        })

        var11.ShiftLockMode.IndexChanged:connect(function(arg2)
            local bool32 = if GetFFlagEnableExplicitSettingsChangeAnalytics() then GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch else nil

            if arg2 == 1 then
                GameSettings.ControlMode = Enum.ControlMode.MouseLockSwitch
            else
                GameSettings.ControlMode = Enum.ControlMode.Classic
            end

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics(
                    "shift_lock_enabled",
                    bool32,
                    GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
                )
            end
            reportSettingsForAnalytics()
        end)

        local function setShiftLockSelectorVisible(bool32: boolean) -- Luacid: Inlined by compiler; 7 call sites recovered
            local devEnableMouseLock = bool32 and LocalPlayer.DevEnableMouseLock
            if var11.ShiftLockMode then
                var11.ShiftLockMode.SelectorFrame.Visible = devEnableMouseLock
                var11.ShiftLockMode:SetInteractable(devEnableMouseLock)
            end
        end

        local function applyDevOverrideShiftLockSelector() -- Luacid: Inlined by compiler; 6 call sites recovered
            local bool32 = not LocalPlayer.DevEnableMouseLock
            if var11.ShiftLockOverrideText then
                var11.ShiftLockOverrideText.Visible = bool32
                setShiftLockSelectorVisible(not bool32)
            end
        end

        local function updateShiftLockVisibility() -- Luacid: Inlined by compiler; 3 call sites recovered
            local keyboardEnabled = UserInputService.MouseEnabled and UserInputService.KeyboardEnabled
            if var11.ShiftLockFrame then
                var11.ShiftLockFrame.Visible = keyboardEnabled
            end

            applyDevOverrideShiftLockSelector()
        end

        updateShiftLockVisibility()

        UserInputService:GetPropertyChangedSignal("MouseEnabled"):Connect(function()
            updateShiftLockVisibility()
        end)

        UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(function()
            updateShiftLockVisibility()
        end)

        function cameraModeIsUserChoice(): boolean
            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                return LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice
            end

            return LocalPlayer.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice
        end

        function setCameraModeVisible(visible)
            if var11.CameraMode then
                var11.CameraMode.SelectorFrame.Visible = visible
                var11.CameraMode:SetInteractable(visible)
                var11.CameraModeOverrideText.Visible = not visible
            end
        end

        local var25 = CoreUtility.waitForChildOfClass(LocalPlayer, "PlayerScripts")

        local tbl9 = {}
        local tbl10 = ({})

        local function updateCurrentCameraMovementIndex(arg2): boolean
            local var26 = nil
            if not pcall(function()
                var26 = tbl10[tbl9[arg2]]
            end) or var26 == nil then
                return false
            end

            local var27 = nil
            local bool32

            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    var27 = GameSettings.TouchCameraMovementMode.Value
                end

                bool32 = GameSettings.TouchCameraMovementMode.Value ~= var26
                GameSettings.TouchCameraMovementMode = var26
            else
                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    var27 = GameSettings.ComputerCameraMovementMode.Value
                end

                bool32 = GameSettings.ComputerCameraMovementMode.Value ~= var26
                GameSettings.ComputerCameraMovementMode = var26
            end

            if GetFFlagEnableExplicitSettingsChangeAnalytics() and bool32 then
                reportSettingsChangeForAnalytics("camera_mode", var27, var26)
            end

            return bool32
        end

        local function updateCameraMovementModes()
            local var26 = if var25 then if UserInputService.PreferredInput == Enum.PreferredInput.Touch then var25:GetRegisteredTouchCameraMovementModes() else var25:GetRegisteredComputerCameraMovementModes() else {}
            tbl9 = {}
            tbl10 = {}

            if #var26 <= 0 then
                setCameraModeVisible(false)
                return
            end

            for i = 1, #var26 do
                local var27 = var26[i]
                local name = var27.Name
                if name == "Default" then
                    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                        name = tbl4.DEFAULT_FOLLOW
                    else
                        name = tbl4.DEFAULT_CLASSIC
                    end
                end

                tbl9[#tbl9 + 1] = name
                tbl10[name] = var27.Value
            end

            if var11.CameraMode then
                var11.CameraMode:UpdateOptions(tbl9)
            end

            local bool32 = UserInputService.PreferredInput == Enum.PreferredInput.Touch
            local value = if bool32 then GameSettings.TouchCameraMovementMode.Value else GameSettings.ComputerCameraMovementMode.Value

            if value > -1 then
                if bool32 or GameSettings.ComputerCameraMovementMode ~= Enum.ComputerCameraMovementMode.CameraToggle then
                    value += 1
                end
                updateCurrentCameraMovementIndex(value)
                var11.CameraMode:SetSelectionIndex(value)
            end
            setCameraModeVisible(cameraModeIsUserChoice())
        end

        local var26 = var11
        local var27 = var11
        local var28 = var11
        local cameraModeFrame, cameraModeLabel, cameraMode = Utility:AddNewRow(var11, "Camera Mode", "Selector", tbl9, 1)
        var26.CameraModeFrame = cameraModeFrame
        var27.CameraModeLabel = cameraModeLabel
        var28.CameraMode = cameraMode

        var11.CameraModeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.CameraModeFrame

        tbl8[var11.CameraMode] = true

        var11.CameraModeOverrideText = Create("TextLabel")({
            Name = "CameraDevOverrideLabel",
            Text = "Set by Developer",
            TextColor3 = Color3.new(1, 1, 1),
            Font = Theme.font(Enum.Font.SourceSans, "GameSettings"),
            FontSize = Theme.fontSize(Enum.FontSize.Size24, "GameSettings"),
            BackgroundTransparency = 1,
            Size = UDim2.new(0.6, 0, 1, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            Visible = false,
            ZIndex = 2,
            Parent = var11.CameraModeFrame
        })

        if var25 then
            var25.TouchCameraMovementModeRegistered:connect(function(_)
                if UserInputService.TouchEnabled then
                    updateCameraMovementModes()
                end
            end)

            var25.ComputerCameraMovementModeRegistered:connect(function(_)
                if UserInputService.MouseEnabled then
                    updateCameraMovementModes()
                end
            end)
        end

        UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
            updateCameraMovementModes()
        end)

        local bool32 = false
        var11.CameraMode.IndexChanged:connect(function(arg2)
            if not updateCurrentCameraMovementIndex(arg2) then
                return
            end

            if bool32 then
                reportSettingsForAnalytics()
            end
            bool32 = true
        end)

        updateCameraMovementModes()

        local bool33 = false
        local function createVROption()
            if bool33 then
                return
            end

            bool33 = true

            local tbl11 = GameSettings.VREnabled and { "On", "Off (restart pending)" } or { "On (restart pending)", "Off" }

            local var32 = var11
            local var33 = var11
            local var34 = var11
            local vrEnabledFrame, vrEnabledLabel, vrEnabledSelector = Utility:AddNewRow(var11, "VR", "Selector", tbl11, if GameSettings.VREnabled then 1 else 2)
            var32.VREnabledFrame = vrEnabledFrame
            var33.VREnabledLabel = vrEnabledLabel
            var34.VREnabledSelector = vrEnabledSelector

            var11.VREnabledFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VREnabledFrame

            var11.VREnabledSelector.IndexChanged:connect(function(arg2)
                local tbl12 = {
                    On = { Name = "On", Value = 1 },
                    Off = { Name = "Off", Value = 2 }
                }
                local vrEnabled = arg2 == tbl12.On.Value
                if GameSettings.VREnabled == vrEnabled then
                    return
                end

                GameSettings.VREnabled = vrEnabled
                local var38 = tbl11[tbl12.On.Value]
                local var39 = tbl11[arg2]
                if var39 == tbl11[tbl12.On.Value] then
                    var38 = tbl11[tbl12.Off.Value]
                end
                reportSettingsChangeForAnalytics("vr_mode", var38, var39)
            end)
        end

        local function onVREnabledChanged() -- Luacid: Inlined by compiler; 1 call site recovered
            if VRService.VREnabled then
                GameSettings.HasEverUsedVR = true
                createVROption()
            elseif GameSettings.HasEverUsedVR then
                createVROption()
            end
        end

        if GetFFlagAlwaysShowVRToggle() and getAppFeaturePolicies().getIsLinkedVRModeAvailable() then
            createVROption()
        else
            onVREnabledChanged()
            VRService:GetPropertyChangedSignal("VREnabled"):connect(onVREnabledChanged)
        end

        local tbl11 = {}
        local tbl12 = ({})
        local tbl13 = ({})
        local tbl14 = ({})

        local function func1(_: boolean) end

        local function setMovementModeVisible(bool34: boolean) -- Luacid: Inlined by compiler; 5 call sites recovered
            if var11.MovementMode then
                local bool35 = bool34 and #tbl11 > 0
                var11.MovementMode.SelectorFrame.Visible = bool35
                var11.MovementMode:SetInteractable(bool35)
                var11.MovementModeOverrideText.Visible = not bool35
            end
        end

        if arg1 then
            local var32 = CoreUtility.waitForChildOfClass(LocalPlayer, "PlayerScripts")

            local function getDisplayName(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
                if arg2 == "Default" then
                    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                        return (RobloxTranslator:FormatByKey(Constants.MovementModeDynamicThumbstickKey))
                    end
                    return tbl6.DEFAULT_KEYBOARD
                elseif arg2 == "KeyboardMouse" then
                    return "Keyboard + Mouse"
                elseif arg2 == "ClickToMove" then
                    return if UserInputService.PreferredInput == Enum.PreferredInput.Touch then tbl6.TAP_TO_MOVE else tbl6.CLICK_TO_MOVE
                elseif arg2 == "DynamicThumbstick" then
                    return "Dynamic Thumbstick"
                end

                if arg2 == "Thumbstick" then
                    arg2 = var5
                end

                return arg2
            end

            local var33 = var11
            local var34 = var11
            local var35 = var11
            local movementModeFrame, movementModeLabel, movementMode = Utility:AddNewRow(var11, "Movement Mode", "Selector", {}, 1)
            var33.MovementModeFrame = movementModeFrame
            var34.MovementModeLabel = movementModeLabel
            var35.MovementMode = movementMode

            var11.MovementModeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.MovementModeFrame

            tbl8[var11.MovementMode] = true

            var11.MovementModeOverrideText = Create("TextLabel")({
                Name = "MovementDevOverrideLabel",
                Text = "Set by Developer",
                TextColor3 = Color3.new(1, 1, 1),
                Font = Theme.font(Enum.Font.SourceSans, "GameSettings"),
                FontSize = Theme.fontSize(Enum.FontSize.Size24, "GameSettings"),
                BackgroundTransparency = 1,
                Size = UDim2.new(0.6, 0, 1, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                Visible = false,
                ZIndex = 2,
                Parent = var11.MovementModeFrame
            })

            local function setMovementMode(enumItem)
                local var39 = nil
                if enumItem.EnumType == Enum.TouchMovementMode then
                    if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                        var39 = GameSettings.TouchMovementMode
                    end
                    GameSettings.TouchMovementMode = enumItem
                else
                    if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                        var39 = GameSettings.ComputerMovementMode
                    end
                    GameSettings.ComputerMovementMode = enumItem
                end
                if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                    reportSettingsChangeForAnalytics("movement_mode", var39, enumItem)
                end
            end
            func1 = function(bool34: boolean)
                local bool35 = if bool34 then LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice else LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice
                setMovementModeVisible(bool35)

                if var11.MovementModeOverrideText then
                    var11.MovementModeOverrideText.Visible = not bool35
                end
            end
            local function updateMovementModes()
                local bool34 = UserInputService.PreferredInput == Enum.PreferredInput.Touch
                if var32 then
                    if bool34 then
                        tbl11 = var32:GetRegisteredTouchMovementModes()
                    else
                        tbl11 = var32:GetRegisteredComputerMovementModes()
                    end
                end
                tbl12 = {}
                tbl13 = {}
                tbl14 = {}
                if #tbl11 <= 0 then
                    if var11.MovementMode then
                        var11.MovementMode.SelectorFrame.Visible = false
                        var11.MovementMode:SetInteractable(false)
                        var11.MovementModeOverrideText.Visible = true
                    end

                    return
                end

                setMovementModeVisible(true)

                for value, value2 in tbl11 do
                    tbl13[value] = value2
                    tbl14[value] = getDisplayName(value2.Name)
                    tbl12[value2] = value
                end

                if var11.MovementMode then
                    var11.MovementMode:UpdateOptions(tbl14)
                end

                local enumItem = if bool34 then GameSettings.TouchMovementMode else GameSettings.ComputerMovementMode

                if enumItem then
                    setMovementMode(enumItem)
                    var11.MovementMode:SetSelectionIndex(tbl12[enumItem])
                end
                func1(bool34)
            end

            updateMovementModes()

            if var32 then
                var32.TouchMovementModeRegistered:connect(function(_)
                    if UserInputService.TouchEnabled then
                        updateMovementModes()
                    end
                end)

                var32.ComputerMovementModeRegistered:connect(function(_)
                    if UserInputService.MouseEnabled then
                        updateMovementModes()
                    end
                end)
            end

            UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
                updateMovementModes()
            end)

            var11.MovementMode.IndexChanged:connect(function(arg2)
                setMovementMode(tbl13[arg2])
                reportSettingsForAnalytics()
            end)
        end

        local bool34 = UserInputService.PreferredInput == Enum.PreferredInput.Touch

        if not (if bool34 then LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice else LocalPlayer.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice) then
            var11.CameraModeOverrideText.Visible = true
            setCameraModeVisible(false)
        else
            var11.CameraModeOverrideText.Visible = false
            setCameraModeVisible(true)
        end

        local bool35 = if bool34 then LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice else LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice

        if var11.MovementModeOverrideText then
            if not bool35 then
                var11.MovementModeOverrideText.Visible = true

                if var11.MovementMode then
                    var11.MovementMode.SelectorFrame.Visible = false
                    var11.MovementMode:SetInteractable(false)
                    var11.MovementModeOverrideText.Visible = true
                end
            else
                var11.MovementModeOverrideText.Visible = false
                setMovementModeVisible(true)
            end
        end

        applyDevOverrideShiftLockSelector()

        local function updateUserSettingsMenu(property: string)
            if property == "DevEnableMouseLock" then
                applyDevOverrideShiftLockSelector()
                return
            elseif property == "DevComputerCameraMode" then
                local bool36 = LocalPlayer.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice
                setCameraModeVisible(bool36)
                var11.CameraModeOverrideText.Visible = not bool36
                return
            elseif property == "DevComputerMovementMode" then
                if func1 ~= nil then
                    func1(false)
                    return
                end

                local bool36 = LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice
                setMovementModeVisible(bool36)

                if var11.MovementModeOverrideText then
                    var11.MovementModeOverrideText.Visible = not bool36
                end

                return
            end

            if property ~= "DevTouchMovementMode" then
                if property == "DevTouchCameraMode" then
                    local bool36 = LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice
                    setCameraModeVisible(bool36)
                    var11.CameraModeOverrideText.Visible = not bool36
                end

                return
            end

            if func1 ~= nil then
                func1(true)
                return
            end
            local bool36 = LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice
            setMovementModeVisible(bool36)

            if var11.MovementModeOverrideText then
                var11.MovementModeOverrideText.Visible = not bool36
            end
        end

        LocalPlayer.Changed:connect(function(property: string)
            if tbl3[property] then
                updateUserSettingsMenu(property)
            end
            if tbl2[property] then
                updateUserSettingsMenu(property)
            end
        end)
    end

    local function createFeedbackModeOptions()
        local url = Url.ROLES_URL .. "v1/users/authenticated/roles"
        local var16 = HttpService:RequestInternal({ Url = url, Method = "GET" })

        local function rolesCheckCallback(bool32: boolean)
            if not bool32 then
                return
            end
            if not bool25 and game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") and not var11.FeedbackEntryPointEnabled then
                return
            end

            local function onToggleFeedbackMode()
                if bool25 and game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") and not var11.FeedbackEntryPointEnabled then
                    return
                end

                var11.HubRef:PopMenu(false, true)
                if game:GetEngineFeature("SafetyServiceCaptureModeReportProp") then
                    SafetyService.IsCaptureModeForReport = false
                end
                if ExperienceStateCaptureService ~= nil then
                    ExperienceStateCaptureService:ToggleCaptureMode()
                end
                reportSettingsChangeForAnalytics("translation_feedback", "", "pressed")
            end

            local var17, var18

            if bool24 then
                var17, var18 = Utility:MakeStyledButton("toggleFeedbackModeButton", var7, UDim2.new(1, 0, 1, -20), onToggleFeedbackMode, var11)

                var17.Size = UDim2.new(0.6, 0, 0, 40)
                var17.Position = UDim2.new(0.4, 0, 0.5, 0)
                var17.AnchorPoint = Vector2.new(0, 0.5)
            else
                var17, var18 = Utility:MakeStyledButton("toggleFeedbackModeButton", var7, UDim2.new(0, 300, 1, -20), onToggleFeedbackMode, var11)

                var17.Size = UDim2.new(0, 300, 0, 30)
                var17.Position = UDim2.new(0.4, 0, 0.5, 0)
                var17.AnchorPoint = Vector2.new(0, 0.5)
            end

            var17.ZIndex = 2
            var17.Selectable = true
            var18.ZIndex = 2

            if game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") then
                var11.toggleFeedbackModeButton = var17
                var11.toggleFeedbackModeText = var18
            end

            if bool24 then
                Utility:AddNewRowObject(
                    var11,
                    RobloxTranslator:FormatByKey("CoreScripts.Feedback.EntryPoint.OptionText"),
                    var17,
                    nil,
                    true
                ).LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.FeedbackModeButton
                return
            end
            Utility:AddNewRowObject(var11, RobloxTranslator:FormatByKey("CoreScripts.Feedback.EntryPoint.OptionText"), var17).LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.FeedbackModeButton
        end

        if bool19 then
            rolesCheckCallback(true)
            return
        end
        var16:Start(function(arg1, arg2)
            local bool32 = false
            local success = false
            local result

            if arg1 then
                if arg2.StatusCode == 401 then
                    result = "Roles Api Request: Unauthorized"
                elseif arg2.StatusCode < 200 or arg2.StatusCode >= 400 then
                    result = "Roles Api Status code: " .. arg2.StatusCode
                else
                    success, result = pcall(function()
                        local var17 = HttpService:JSONDecode(arg2.Body)

                        for _, value in pairs(var17.roles) do
                            if value == "Soothsayer" then
                                bool32 = true
                            end
                        end
                    end)
                end
            else
                result = "Roles Api Request: Connection error"
            end

            if not success then
                var10:warning("Feedback Mode initialization api call failed with url: " .. url .. " and with error message: " .. result)
            end

            rolesCheckCallback(bool32)
        end)
    end

    local function createTranslationOptions()
        local num1 = 1
        local num2 = 1
        local bool32 = false

        local languageCode = nil
        local localeCode = nil
        local localeId = Players.LocalPlayer.LocaleId
        local languageCode2 = nil

        local var15 = nil
        local tbl9 = ({})
        local tbl10 = ({})
        local tbl11 = ({})
        local tbl12 = ({})

        local tbl13 = {}

        local url = Url.LOCALE_URL .. string.format("v1/locales?displayValueLocale=%s", Players.LocalPlayer.LocaleId:gsub("-", "_"))
        local var17 = HttpService:RequestInternal({ Url = url, Method = "GET" })

        local var16 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/source-language/games/%d", game.GameId)
        local var19 = HttpService:RequestInternal({ Url = var16, Method = "GET" })

        local var18 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/supported-languages/games/%d/in-experience-language-selection", game.GameId)
        local var21 = HttpService:RequestInternal({ Url = var18, Method = "GET" })

        local var20 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/user-localization-settings/universe/%d", game.GameId)
        local var23 = HttpService:RequestInternal({ Url = var20, Method = "GET" })

        local function userExperienceLanguageSettingsCallback(bool33: boolean, arg1)
            if not bool33 then
                var10:warning(
                    "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                        .. (if arg1 == nil then "Execution path did not set earliest error to non-nil value." else arg1)
                )

                local var24 = var11
                local var25 = var11
                local var26 = var11
                local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                    "DropDown",
                    { var6 },
                    1
                )
                var24.LanguageSelectorFrame = languageSelectorFrame
                var25.LanguageSelectorLabel = languageSelectorLabel
                var26.LanguageSelectorMode = languageSelectorMode

                var11.LanguageSelectorMode:SetInteractable(false)
                var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                return
            end

            local bool34 = false

            table.insert(tbl13, tbl11[languageCode].languageName .. " (Original)")

            for _, value in pairs(tbl9) do
                if value == var15 then
                    bool34 = true
                end

                if value ~= languageCode then
                    table.insert(tbl13, tbl11[value].languageName)
                end
            end

            if bool34 == true then
                for k, value in pairs(tbl13) do
                    if k ~= 1 and tbl10[value] == var15 then
                        num1 = k
                        num2 = k
                    end
                end
            end

            local var24 = var11
            local var25 = var11
            local var26 = var11
            local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                var11,
                RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                "DropDown",
                tbl13,
                num1
            )
            var24.LanguageSelectorFrame = languageSelectorFrame
            var25.LanguageSelectorLabel = languageSelectorLabel
            var26.LanguageSelectorMode = languageSelectorMode

            var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame

            if num1 == 1 then
                LocalPlayer:SetExperienceSettingsLocaleId(localeCode)
            else
                local var30 = tbl10[tbl13[num1]]
                LocalPlayer:SetExperienceSettingsLocaleId(tbl11[var30].localeCode)
            end

            var11.LanguageSelectorMode.CurrentLanguage = var11.LanguageSelectorMode.DropDownFrame.DropDownFrameTextLabel.Text

            var11.LanguageSelectorMode.IndexChanged:connect(function(arg2) -- name: toggleTranslation
                var11.LanguageSelectorMode:SetInteractable(false)
                local id = if arg2 == 1 then tbl11[languageCode].id else tbl11[tbl10[tbl13[arg2]]].id
                local currentLanguage = var11.LanguageSelectorMode.CurrentLanguage
                local var22 = tbl13[arg2]
                if currentLanguage ~= var22 then
                    var11.LanguageSelectorMode.CurrentLanguage = var22
                    reportSettingsChangeForAnalytics("experience_language", currentLanguage, var22)
                end

                local var27 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/user-localization-settings/universe/%d", game.GameId)
                local var32 = HttpService:RequestInternal({
                    Url = var27,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = HttpService:JSONEncode({ settingValue = { settingType = "LanguageFamily", settingTargetId = id } })
                })

                local function callback(bool35: boolean, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
                    if bool35 then
                        num2 = arg2
                        if arg2 == 1 then
                            LocalPlayer:SetExperienceSettingsLocaleId(localeCode)
                        else
                            local var33 = tbl10[tbl13[arg2]]
                            LocalPlayer:SetExperienceSettingsLocaleId(tbl11[var33].localeCode)
                        end
                    else
                        var10:warning(
                            "Request to update user experience language status failed, keeping language toggle disabled for the remainder of the session. Error: " .. arg3
                        )

                        bool32 = true
                        var11.LanguageSelectorMode:SetSelectionIndex(num2)
                    end

                    var11.LanguageSelectorMode:SetInteractable(true)
                end

                if RunService:IsStudio() then
                    callback(true, nil)
                    return
                end

                if bool32 then
                    bool32 = false
                    callback(true, nil)
                    return
                end

                var32:Start(function(arg3, arg4)
                    local bool35 = false
                    local var33 = nil
                    if arg3 then
                        if arg4.StatusCode == 401 then
                            var33 = "User Experience Language Settings Update Request: Unauthorized"
                        elseif arg4.StatusCode < 200 or arg4.StatusCode >= 400 then
                            var33 = "User Experience Language Settings Update Request Status Code: " .. arg4.StatusCode
                        else
                            var10:info("User Experience Language Settings Update Request succeeded with code: " .. arg4.StatusCode)
                            bool35 = true
                        end
                    else
                        var33 = "User Experience Language Settings Update Request: Connection error"
                    end

                    if not bool35 then
                        var10:warning(
                            "GameSettings language selector toggle: Failed to update user experience language status from GameInternationalization API for " .. var27 .. " with error message: " .. var33
                        )
                    end
                    callback(bool35, var33)
                end)
            end)
        end
        local function experienceSupportedLanguagesCallback(bool33: boolean, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
            if not bool33 then
                var10:warning(
                    "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                        .. (if arg1 == nil then "Execution path did not set earliest error to non-nil value." else arg1)
                )

                local var24 = var11
                local var25 = var11
                local var26 = var11
                local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                    "DropDown",
                    { var6 },
                    1
                )
                var24.LanguageSelectorFrame = languageSelectorFrame
                var25.LanguageSelectorLabel = languageSelectorLabel
                var26.LanguageSelectorMode = languageSelectorMode

                var11.LanguageSelectorMode:SetInteractable(false)
                var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame

                return
            end

            var23:Start(function(arg2, arg3)
                local success = false
                local result

                if arg2 then
                    if arg3.StatusCode == 401 then
                        result = "User Experience Language Setting Request: Unauthorized"
                    elseif arg3.StatusCode < 200 or arg3.StatusCode >= 400 then
                        result = "User Experience Language Setting Request Status code: " .. arg3.StatusCode
                    else
                        success, result = pcall(function()
                            local userUniverseLocalizationSettingValue = HttpService:JSONDecode(arg3.Body).userUniverseLocalizationSettingValue
                            if userUniverseLocalizationSettingValue == nil then
                                var15 = languageCode2
                                return
                            end

                            if userUniverseLocalizationSettingValue.settingType == "SourceOrTranslation" then
                                if userUniverseLocalizationSettingValue.settingTargetId == 1 then
                                    var15 = languageCode
                                else
                                    var15 = languageCode2
                                end
                            end

                            if userUniverseLocalizationSettingValue.settingType ~= "LanguageFamily" then
                                return
                            end

                            if tbl12[userUniverseLocalizationSettingValue.settingTargetId] == nil then
                                var15 = languageCode2
                                return
                            end
                            var15 = tbl12[userUniverseLocalizationSettingValue.settingTargetId]
                        end)
                    end
                else
                    result = "User Experience Language Setting Request: Connection error"
                end

                if not success then
                    var10:warning(
                        "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var20 .. " with error message: " .. result
                    )
                end
                userExperienceLanguageSettingsCallback(success, result)
            end)
        end

        local function experienceSourceLanguageCallback(arg1, arg2) -- Luacid: unused: defined but never referenced
            if not arg1 then
                local var24 = arg2
                var10:warning(
                    "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                        .. (if var24 == nil then "Execution path did not set earliest error to non-nil value." else var24)
                )

                local var25 = var11
                local var26 = var11
                local var27 = var11
                local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                    "DropDown",
                    { var6 },
                    1
                )
                var25.LanguageSelectorFrame = languageSelectorFrame
                var26.LanguageSelectorLabel = languageSelectorLabel
                var27.LanguageSelectorMode = languageSelectorMode

                var11.LanguageSelectorMode:SetInteractable(false)
                var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                return
            end

            var21:Start(function(arg3, arg4)
                local success = false
                local result

                if arg3 then
                    if arg4.StatusCode == 401 then
                        result = "Experience Supported Language Request: Unauthorized"
                    elseif arg4.StatusCode < 200 or arg4.StatusCode >= 400 then
                        result = "Experience Supported Language Request Status code: " .. arg4.StatusCode
                    else
                        success, result = pcall(function()
                            local var24 = HttpService:JSONDecode(arg4.Body)

                            for k, value in pairs(var24.data) do
                                tbl9[k] = value.languageCode
                            end
                        end)
                    end
                else
                    result = "Experience Supported Language Request: Connection error"
                end

                if not success then
                    var10:warning(
                        "GameSettings language selector initialization: Failed to get response from Localization API for " .. var18 .. " with error message: " .. result
                    )
                end

                if arg2 == nil then
                    arg2 = result
                end

                local var24 = arg2

                if success and arg1 then
                    experienceSupportedLanguagesCallback(true, nil)
                    return
                end

                var10:warning(
                    "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                        .. (if var24 == nil then "Execution path did not set earliest error to non-nil value." else var24)
                )

                local var25 = var11
                local var26 = var11
                local var27 = var11
                local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                    "DropDown",
                    { var6 },
                    1
                )
                var25.LanguageSelectorFrame = languageSelectorFrame
                var26.LanguageSelectorLabel = languageSelectorLabel
                var27.LanguageSelectorMode = languageSelectorMode

                var11.LanguageSelectorMode:SetInteractable(false)
                var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
            end)
        end

        local function localeCodeToLanguageCodeMappingCallback(arg1, arg2) -- Luacid: unused: defined but never referenced
            if not arg1 then
                local var24 = arg2
                var10:warning(
                    "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                        .. (if var24 == nil then "Execution path did not set earliest error to non-nil value." else var24)
                )

                local var25 = var11
                local var26 = var11
                local var27 = var11
                local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                    "DropDown",
                    { var6 },
                    1
                )
                var25.LanguageSelectorFrame = languageSelectorFrame
                var26.LanguageSelectorLabel = languageSelectorLabel
                var27.LanguageSelectorMode = languageSelectorMode

                var11.LanguageSelectorMode:SetInteractable(false)
                var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                return
            end

            var19:Start(function(arg3, arg4)
                local success = false
                local result

                if arg3 then
                    if arg4.StatusCode == 401 then
                        result = "Experience Source Language Request: Unauthorized"
                    elseif arg4.StatusCode < 200 or arg4.StatusCode >= 400 then
                        result = "Experience Source Language Status code: " .. arg4.StatusCode
                    else
                        success, result = pcall(function()
                            languageCode = HttpService:JSONDecode(arg4.Body).languageCode
                            localeCode = tbl11[languageCode].localeCode
                        end)
                    end
                else
                    result = "Experience Source Language Request: Connection error"
                end

                if not success then
                    var10:warning(
                        "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var16 .. " with error message: " .. result
                    )
                end

                if arg2 == nil then
                    arg2 = result
                end

                local var24 = success and arg1
                local var25 = arg2

                if not var24 then
                    local var26 = var25
                    var10:warning(
                        "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                            .. (if var26 == nil then "Execution path did not set earliest error to non-nil value." else var26)
                    )

                    local var27 = var11
                    local var28 = var11
                    local var29 = var11
                    local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                        var11,
                        RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                        "DropDown",
                        { var6 },
                        1
                    )
                    var27.LanguageSelectorFrame = languageSelectorFrame
                    var28.LanguageSelectorLabel = languageSelectorLabel
                    var29.LanguageSelectorMode = languageSelectorMode

                    var11.LanguageSelectorMode:SetInteractable(false)
                    var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                    return
                end

                var21:Start(function(arg5, arg6)
                    local success2 = false
                    local result2

                    if arg5 then
                        if arg6.StatusCode == 401 then
                            result2 = "Experience Supported Language Request: Unauthorized"
                        elseif arg6.StatusCode < 200 or arg6.StatusCode >= 400 then
                            result2 = "Experience Supported Language Request Status code: " .. arg6.StatusCode
                        else
                            success2, result2 = pcall(function()
                                local var26 = HttpService:JSONDecode(arg6.Body)

                                for k, value in pairs(var26.data) do
                                    tbl9[k] = value.languageCode
                                end
                            end)
                        end
                    else
                        result2 = "Experience Supported Language Request: Connection error"
                    end

                    if not success2 then
                        var10:warning(
                            "GameSettings language selector initialization: Failed to get response from Localization API for " .. var18 .. " with error message: " .. result2
                        )
                    end

                    if var25 == nil then
                        var25 = result2
                    end

                    local var26 = var25

                    if success2 and var24 then
                        experienceSupportedLanguagesCallback(true, nil)
                        return
                    end

                    var10:warning(
                        "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                            .. (if var26 == nil then "Execution path did not set earliest error to non-nil value." else var26)
                    )

                    local var27 = var11
                    local var28 = var11
                    local var29 = var11
                    local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                        var11,
                        RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                        "DropDown",
                        { var6 },
                        1
                    )
                    var27.LanguageSelectorFrame = languageSelectorFrame
                    var28.LanguageSelectorLabel = languageSelectorLabel
                    var29.LanguageSelectorMode = languageSelectorMode

                    var11.LanguageSelectorMode:SetInteractable(false)
                    var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                end)
            end)
        end
        var17:Start(function(arg1, arg2)
            local success = false
            local result

            if arg1 then
                if arg2.StatusCode == 401 then
                    result = "Locale Code to Language Code Mapping Request: Unauthorized"
                elseif arg2.StatusCode < 200 or arg2.StatusCode >= 400 then
                    result = "Locale Code to Language Code Mapping Request Status code: " .. arg2.StatusCode
                else
                    success, result = pcall(function()
                        local var24 = HttpService:JSONDecode(arg2.Body)

                        for _, value in pairs(var24.data) do
                            local languageCode3 = value.locale.language.languageCode
                            local locale = value.locale.locale
                            local name = value.locale.language.name
                            local id = value.locale.language.id
                            tbl11[languageCode3] = {
                                localeCode = locale,
                                languageName = name,
                                id = id
                            }

                            tbl12[id] = languageCode3
                            tbl10[name] = languageCode3

                            if value.locale.locale == localeId:gsub("-", "_") then
                                languageCode2 = value.locale.language.languageCode
                            end
                        end
                    end)
                end
            else
                result = "Locale Code to Language Code Mapping Request: Connection error"
            end

            if not success then
                var10:warning(
                    "GameSettings language selector initialization: Failed to get response from Localization API for " .. url .. " with error message: " .. result
                )
            end

            if not success then
                local var24 = result
                var10:warning(
                    "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                        .. (if var24 == nil then "Execution path did not set earliest error to non-nil value." else var24)
                )

                local var25 = var11
                local var26 = var11
                local var27 = var11
                local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                    var11,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                    "DropDown",
                    { var6 },
                    1
                )
                var25.LanguageSelectorFrame = languageSelectorFrame
                var26.LanguageSelectorLabel = languageSelectorLabel
                var27.LanguageSelectorMode = languageSelectorMode

                var11.LanguageSelectorMode:SetInteractable(false)
                var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                return
            end

            var19:Start(function(arg3, arg4)
                local success2 = false
                local result2

                if arg3 then
                    if arg4.StatusCode == 401 then
                        result2 = "Experience Source Language Request: Unauthorized"
                    elseif arg4.StatusCode < 200 or arg4.StatusCode >= 400 then
                        result2 = "Experience Source Language Status code: " .. arg4.StatusCode
                    else
                        success2, result2 = pcall(function()
                            languageCode = HttpService:JSONDecode(arg4.Body).languageCode
                            localeCode = tbl11[languageCode].localeCode
                        end)
                    end
                else
                    result2 = "Experience Source Language Request: Connection error"
                end

                if not success2 then
                    var10:warning(
                        "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var16 .. " with error message: " .. result2
                    )
                end

                if result == nil then
                    result = result2
                end

                local bool33 = success2 and success
                local var24 = result

                if not bool33 then
                    local var25 = var24
                    var10:warning(
                        "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                            .. (if var25 == nil then "Execution path did not set earliest error to non-nil value." else var25)
                    )

                    local var26 = var11
                    local var27 = var11
                    local var28 = var11
                    local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                        var11,
                        RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                        "DropDown",
                        { var6 },
                        1
                    )
                    var26.LanguageSelectorFrame = languageSelectorFrame
                    var27.LanguageSelectorLabel = languageSelectorLabel
                    var28.LanguageSelectorMode = languageSelectorMode

                    var11.LanguageSelectorMode:SetInteractable(false)
                    var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                    return
                end

                var21:Start(function(arg5, arg6)
                    local success3 = false
                    local result3

                    if arg5 then
                        if arg6.StatusCode == 401 then
                            result3 = "Experience Supported Language Request: Unauthorized"
                        elseif arg6.StatusCode < 200 or arg6.StatusCode >= 400 then
                            result3 = "Experience Supported Language Request Status code: " .. arg6.StatusCode
                        else
                            success3, result3 = pcall(function()
                                local var25 = HttpService:JSONDecode(arg6.Body)

                                for k, value in pairs(var25.data) do
                                    tbl9[k] = value.languageCode
                                end
                            end)
                        end
                    else
                        result3 = "Experience Supported Language Request: Connection error"
                    end

                    if not success3 then
                        var10:warning(
                            "GameSettings language selector initialization: Failed to get response from Localization API for " .. var18 .. " with error message: " .. result3
                        )
                    end

                    if var24 == nil then
                        var24 = result3
                    end

                    local var25 = var24

                    if success3 and bool33 then
                        experienceSupportedLanguagesCallback(true, nil)
                        return
                    end

                    var10:warning(
                        "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                            .. (if var25 == nil then "Execution path did not set earliest error to non-nil value." else var25)
                    )

                    local var26 = var11
                    local var27 = var11
                    local var28 = var11
                    local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
                        var11,
                        RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
                        "DropDown",
                        { var6 },
                        1
                    )
                    var26.LanguageSelectorFrame = languageSelectorFrame
                    var27.LanguageSelectorLabel = languageSelectorLabel
                    var28.LanguageSelectorMode = languageSelectorMode

                    var11.LanguageSelectorMode:SetInteractable(false)
                    var11.LanguageSelectorFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageSelectorFrame
                end)
            end)
        end)
    end

    local function getChatTranslationLayerData(arg1)
        local tbl9 = { ChatTranslationEnabled = false, ChatTranslationToggleEnabled = false }

        if not arg1 or arg1 == "" then
            return tbl9
        end

        if arg1 == "override" then
            tbl9.ChatTranslationEnabled = true
            return tbl9
        end

        if GetFFlagChatTranslationWaitForIXP() then
            IXPServiceWrapper:WaitForInitialization()
        end

        local success, result = pcall(function()
            return IXPServiceWrapper:GetLayerData(arg1)
        end)

        if success then
            if GetFFlagChatTranslationNewDefaults() then
                tbl9.ChatTranslationEnabled = result.ChatTranslationEnabled or true
                tbl9.ChatTranslationToggleEnabled = result.ChatTranslationToggleEnabled or false
                return tbl9
            end
            tbl9.ChatTranslationEnabled = result.chatTranslationEnabled or false
            tbl9.ChatTranslationToggleEnabled = result.chatTranslationToggleEnabled or false
        end

        return tbl9
    end

    local function createVolumeOptions()
        local num1 = math.floor(GameSettings.MasterVolume * 10)
        local var15 = var11
        local var16 = var11
        local var17 = var11
        local volumeFrame, volumeLabel, volumeSlider = Utility:AddNewRow(
            var11,
            if FFlagRenameVolumeToMainVolume then RobloxTranslator:FormatByKey("CoreScripts.InGameMenu.GameSettings.MainVolume") else "Volume",
            "Slider",
            10,
            num1
        )
        var15.VolumeFrame = volumeFrame
        var16.VolumeLabel = volumeLabel
        var17.VolumeSlider = volumeSlider

        var11.VolumeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VolumeFrame

        local volumeChangeSound = Instance.new("Sound", game:GetService("CoreGui").RobloxGui.Sounds)
        volumeChangeSound.Name = "VolumeChangeSound"
        volumeChangeSound.SoundId = "rbxasset://sounds/uuhhh.mp3"

        var11.VolumeSlider.ValueChanged:connect(function(arg1)
            local var21 = if GetFFlagEnableExplicitSettingsChangeAnalytics() then math.floor(GameSettings.MasterVolume * 10 + 0.5) else nil
            local var22 = arg1 / 10
            volumeChangeSound.Volume = var22
            volumeChangeSound:Play()
            GameSettings.MasterVolume = var22

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("volume", var21, math.floor(GameSettings.MasterVolume * 10 + 0.5))
            end
            reportSettingsForAnalytics()
        end)
    end

    local function createPartyVoiceVolumeOptions()
        local num1 = math.floor(GameSettings.PartyVoiceVolume * 10)

        local var15 = var11
        local var16 = var11
        local var17 = var11
        local partyVoiceVolumeFrame, partyVoiceVolumeLabel, partyVoiceVolumeSlider = Utility:AddNewRow(var11, "Party Voice Volume", "Slider", 10, num1)
        var15.PartyVoiceVolumeFrame = partyVoiceVolumeFrame
        var16.PartyVoiceVolumeLabel = partyVoiceVolumeLabel
        var17.PartyVoiceVolumeSlider = partyVoiceVolumeSlider

        var11.PartyVoiceVolumeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.PartyVoiceVolumeFrame

        if GetFFlagEnablePartyVoiceVolumeOnlyWhenInEligibleParty() then
            var11.PartyVoiceVolumeFrame.Visible = default4.hasExperienceStarted
            default4.ExperienceJoined.Event:Connect(function()
                var11.PartyVoiceVolumeFrame.Visible = true
            end)
            default4.ExperienceLeft.Event:Connect(function()
                var11.PartyVoiceVolumeFrame.Visible = false
            end)
        end

        var11.PartyVoiceVolumeSlider.ValueChanged:connect(function(arg1)
            local var21 = if GetFFlagEnableExplicitSettingsChangeAnalytics() then if num1 == nil then 0 else math.floor(num1 * 10 + 0.5) else nil
            GameSettings.PartyVoiceVolume = arg1 / 10

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("party_voice_volume", var21, math.floor(arg1 * 10 + 0.5))
            end
            reportSettingsForAnalytics()
        end)
    end

    local function createCallVolumeOptions()
        if FriendsCallingService == nil or GetFriendsCallingStore == nil then
            return
        end
        local friendsCallingStore = GetFriendsCallingStore(false)

        local num1 = 10
        local var15 = var11
        local var16 = var11
        local callVolumeFrame, var18, callVolumeSlider = Utility:AddNewRow(var11, "Call Volume", "Slider", 10, num1)
        var15.CallVolumeFrame = callVolumeFrame
        _ = var18
        var16.CallVolumeSlider = callVolumeSlider

        var11.CallVolumeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.CallVolumeFrame
        var11.CallVolumeFrame.Visible = false

        local callId = nil
        var11.CallVolumeDisposeEffect = Signals.createEffect(function(arg1)
            local call = friendsCallingStore.getCall(arg1)
            local var20 = call and call.phase == Enum.FriendsCallingPhase.Active and call or nil
            var11.CallVolumeFrame.Visible = var20 ~= nil

            if var20 and var20.callId ~= callId then
                callId = var20.callId
                num1 = math.floor(var20.volume * 10 + 0.5)
                var11.CallVolumeSlider:SetValue(num1)
            end
        end)

        var11.CallVolumeSlider.ValueChanged:connect(function(arg1)
            if arg1 == num1 then
                return
            end
            local var20 = num1
            num1 = arg1
            FriendsCallingService:SetVolume(arg1 / 10)

            reportSettingsChangeForAnalytics("call_volume", var20, arg1)
            reportSettingsForAnalytics()
        end)
    end

    local function createVoiceChatVolumeOptions()
        local num1 = voiceChatVolumeToSlider(GameSettings.VoiceChatVolume)
        local success, result = pcall(function()
            return var2:Format("CoreScripts.InGameMenu.GameSettings.VoiceChatVolume")
        end)
        if not success then
            var10:debug(
                "[GameSettings] createVoiceChatVolumeOptions failed to get translation for Voice Chat Volume label, using placeholder text instead"
            )
            result = "Voice Chat Volume"
        end

        local var15 = var11
        local var16 = var11
        local var17 = var11
        local voiceChatVolumeFrame, voiceChatVolumeLabel, voiceChatVolumeSlider = Utility:AddNewRow(var11, result, "Slider", 10, num1)
        var15.VoiceChatVolumeFrame = voiceChatVolumeFrame
        var16.VoiceChatVolumeLabel = voiceChatVolumeLabel
        var17.VoiceChatVolumeSlider = voiceChatVolumeSlider

        var11.VoiceChatVolumeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VoiceChatVolumeFrame
        var11.VoiceChatVolumeFrame.Visible = false

        if bool13 then
            local function updateVoiceChatVolumeSliderInteractable(num2: number?)
                if if num2 == nil then GameSettings.MasterVolume == 0 else num2 == 0 then
                    var11.VoiceChatVolumeSlider:SetZIndex(1)
                    var11.VoiceChatVolumeLabel.ZIndex = 1
                    var11.VoiceChatVolumeSlider:SetInteractable(false)
                    return
                end
                var11.VoiceChatVolumeSlider:SetZIndex(2)
                var11.VoiceChatVolumeLabel.ZIndex = 2
                var11.VoiceChatVolumeSlider:SetInteractable(true)
            end

            updateVoiceChatVolumeSliderInteractable()
            var11.VolumeSlider.ValueChanged:connect(updateVoiceChatVolumeSliderInteractable)
        end

        var11.VoiceChatVolumeSlider.ValueChanged:connect(function(arg1)
            local var21 = if GetFFlagEnableExplicitSettingsChangeAnalytics() then voiceChatVolumeToSlider(GameSettings.VoiceChatVolume) else nil
            GameSettings.VoiceChatVolume = voiceChatVolumeFromSlider(arg1)
            if FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast and var11.maxVoiceChatVolumeDuringSession ~= nil then
                local var22 = var11
                var22.maxVoiceChatVolumeDuringSession = math.max(var11.maxVoiceChatVolumeDuringSession, GameSettings.VoiceChatVolume)
            end

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("voice_chat_volume", var21, (voiceChatVolumeToSlider(GameSettings.VoiceChatVolume)))
            end

            reportSettingsForAnalytics()
        end)
    end

    local function createHapticsToggle()
        local num1 = if GameSettings.HapticStrength == 0 then 1 else 2

        local var15 = if getAppFeaturePolicies().getShouldUseVibrationInsteadOfHaptics() then var2:Format("CoreScripts.InGameMenu.Vibration") else "Haptics"

        local var16 = var11
        local var17 = var11
        local hapticsFrame, var19, hapticsSelector = Utility:AddNewRow(var11, var15, "Selector", { "Off", "On" }, num1)
        var16.HapticsFrame = hapticsFrame
        _ = var19
        var17.HapticsSelector = hapticsSelector

        var11.HapticsFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.HapticsFrame

        var11.HapticsSelector.IndexChanged:connect(function(arg1)
            local hapticStrength = GameSettings.HapticStrength

            if arg1 == 2 then
                GameSettings.HapticStrength = 1
            else
                GameSettings.HapticStrength = 0
            end

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("haptics_toggle", hapticStrength, GameSettings.HapticStrength)
            end
            reportSettingsForAnalytics()
        end)
    end

    local function createCameraInvertedOptions()
        local num1 = 1
        if pcall(function()
            if GameSettings.CameraYInverted == true then
                num1 = 2
            end
        end) == false then
            return
        end

        local var15 = var11
        local var16 = var11
        local cameraInvertedFrame, var18, cameraInvertedSelector = Utility:AddNewRow(var11, "Camera Inverted", "Selector", { "Off", "On" }, num1)
        var15.CameraInvertedFrame = cameraInvertedFrame
        _ = var18
        var16.CameraInvertedSelector = cameraInvertedSelector

        var11.CameraInvertedFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.CameraInvertedFrame
        tbl8[var11.CameraInvertedFrame] = true

        var11.CameraInvertedSelector.IndexChanged:connect(function(arg1)
            local cameraYInverted = if GetFFlagEnableExplicitSettingsChangeAnalytics() then GameSettings.CameraYInverted else nil

            if arg1 == 2 then
                GameSettings.CameraYInverted = true
            else
                GameSettings.CameraYInverted = false
            end

            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                reportSettingsChangeForAnalytics("camera_y_inverted", cameraYInverted, GameSettings.CameraYInverted)
            end
            reportSettingsForAnalytics()
        end)
    end

    local function setCameraSensitivity(gamepadCameraSensitivity: number?)
        local var15 = nil
        local var16 = nil
        if UserInputService.GamepadEnabled and GameSettings.IsUsingGamepadCameraSensitivity then
            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                var16 = GameSettings.GamepadCameraSensitivity
                var15 = "gamepad"
            end
            GameSettings.GamepadCameraSensitivity = gamepadCameraSensitivity
        end
        if UserInputService.MouseEnabled then
            if GetFFlagEnableExplicitSettingsChangeAnalytics() then
                var16 = GameSettings.MouseSensitivityFirstPerson.X
                var15 = "mouse"
            end

            local vector2 = Vector2.new(gamepadCameraSensitivity, gamepadCameraSensitivity)
            GameSettings.MouseSensitivityFirstPerson = vector2
            GameSettings.MouseSensitivityThirdPerson = vector2
        end

        if GetFFlagEnableExplicitSettingsChangeAnalytics()
            and typeof(var16) == "number"
            and typeof(gamepadCameraSensitivity) == "number"
        then
            reportSettingsChangeForAnalytics(
                "camera_sensitivity",
                tonumber(string.format("%.2f", var16)),
                tonumber(string.format("%.2f", gamepadCameraSensitivity)),
                { sensitivity_type = var15 }
            )
        end

        reportSettingsForAnalytics()
    end

    local function createMouseOptions()
        local function translateEngineMouseSensitivityToGui(arg1): boolean | number -- Luacid: Inlined by compiler; 3 call sites recovered
            local var15 = arg1 <= 1 and math.floor((arg1 - 0.2) / 0.16 + 0.5) or math.floor((arg1 + 2) / 0.6 + 0.5)

            return if arg1 <= 0.2 then 0 else var15
        end

        local function translateGuiMouseSensitivityToEngine(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            local var15 = arg1 <= 5 and 0.16 * arg1 + 0.2 or 0.6 * arg1 - 2
            return if var15 <= 0.2 then 0.2 else var15
        end

        local var15 = translateEngineMouseSensitivityToGui(GameSettings.MouseSensitivity)

        local bool32 = true
        tostring(GameSettings.MouseSensitivityFirstPerson.X)

        local var16 = var11
        local var17 = var11
        local var18 = var11
        local mouseAdvancedFrame, mouseAdvancedLabel, mouseAdvancedEntry = Utility:AddNewRow(var11, "Camera Sensitivity", "Slider", 10, var15)
        var16.MouseAdvancedFrame = mouseAdvancedFrame
        var17.MouseAdvancedLabel = mouseAdvancedLabel
        var18.MouseAdvancedEntry = mouseAdvancedEntry

        var11.MouseAdvancedFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.MouseAdvancedFrame
        tbl8[var11.MouseAdvancedFrame] = true

        var11.MouseAdvancedEntry.SliderFrame.Size = UDim2.new(
            var11.MouseAdvancedEntry.SliderFrame.Size.X.Scale,
            var11.MouseAdvancedEntry.SliderFrame.Size.X.Offset - 60 - 20,
            var11.MouseAdvancedEntry.SliderFrame.Size.Y.Scale,
            var11.MouseAdvancedEntry.SliderFrame.Size.Y.Offset - 6
        )
        var11.MouseAdvancedEntry.SliderFrame.Position = UDim2.new(
            var11.MouseAdvancedEntry.SliderFrame.Position.X.Scale,
            var11.MouseAdvancedEntry.SliderFrame.Position.X.Offset - 60 - 20,
            var11.MouseAdvancedEntry.SliderFrame.Position.Y.Scale,
            var11.MouseAdvancedEntry.SliderFrame.Position.Y.Offset
        )
        var11.MouseAdvancedLabel.ZIndex = 2
        var11.MouseAdvancedEntry:SetInteractable(true)

        local var22 = Create("TextBox")({
            Name = "CameraSensitivityTextBox",
            TextColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0.8, 0.8, 0.8),
            BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
            Font = Theme.font(Enum.Font.SourceSans),
            TextSize = Theme.textSize(18),
            Size = UDim2.new(0, 60, 0.8, 0),
            Position = UDim2.new(1, 10, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            ZIndex = 3,
            Selectable = false,
            Parent = var11.MouseAdvancedEntry.SliderFrame,
            BorderSizePixel = 0
        })

        Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = var22 })

        local function setMouseSensitivityText(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
            arg1 = math.floor(arg1 * 1000 + 0.5) / 1000
            local str1 = string.format("%.3f", arg1)

            local var23 = var22
            var23.Text = tostring(tonumber(str1))
        end

        setMouseSensitivityText(GameSettings.MouseSensitivityFirstPerson.X)

        var11.MouseAdvancedEntry:SetValue((translateEngineMouseSensitivityToGui(GameSettings.MouseSensitivityFirstPerson.X)))

        function clampMouseSensitivity(arg1)
            if arg1 < 0 then
                arg1 = -arg1
            end

            if arg1 > 100 then
                return 100
            end

            return if arg1 < 0.001 then 0.001 else arg1
        end

        function setMouseSensitivity(gamepadCameraSensitivity, mouseAdvancedEntry)
            if not bool32 then
                return
            end

            setCameraSensitivity(gamepadCameraSensitivity)

            bool32 = false

            if mouseAdvancedEntry ~= var11.MouseAdvancedEntry then
                var11.MouseAdvancedEntry:SetValue((translateEngineMouseSensitivityToGui(gamepadCameraSensitivity)))
            end

            setMouseSensitivityText(gamepadCameraSensitivity)
            bool32 = true
        end

        var22.FocusLost:connect(function()
            var11.MouseAdvancedEntry:SetInteractable(true)

            local var23 = tonumber((string.match(var22.Text, "([%d%.]+)")))

            if var23 then
                setMouseSensitivity(clampMouseSensitivity(var23), var22)
                return
            end
            setMouseSensitivity(GameSettings.MouseSensitivityFirstPerson.X, var22)
        end)

        var22.Focused:connect(function()
            var11.MouseAdvancedEntry:SetInteractable(false)
        end)

        var11.MouseAdvancedEntry.ValueChanged:connect(function(arg1)
            arg1 = translateGuiMouseSensitivityToEngine((clampMouseSensitivity(arg1)))

            setMouseSensitivity(arg1, var11.MouseAdvancedEntry)
        end)
    end

    local function createGamepadOptions()
        local function translateEngineGamepadSensitivityToGui(gamepadCameraSensitivity): boolean | number -- Luacid: Inlined by compiler; 1 call site recovered
            local var15 = gamepadCameraSensitivity <= 1 and math.floor((gamepadCameraSensitivity - 0.2) / 0.16 + 0.5)
                or math.floor((gamepadCameraSensitivity + 2) / 0.6 + 0.5)

            return if gamepadCameraSensitivity <= 0.2 then 0 else var15
        end
        local function translateGuiGamepadSensitivityToEngine(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            local var15 = arg1 <= 5 and 0.16 * arg1 + 0.2 or 0.6 * arg1 - 2
            return if var15 <= 0.2 then 0.2 else var15
        end
        local var15 = translateEngineGamepadSensitivityToGui(GameSettings.GamepadCameraSensitivity)

        local var16 = var11
        local var17 = var11
        local var18 = var11
        local gamepadSensitivityFrame, gamepadSensitivityLabel, gamepadSensitivitySlider = Utility:AddNewRow(var11, "Camera Sensitivity", "Slider", 10, var15)
        var16.GamepadSensitivityFrame = gamepadSensitivityFrame
        var17.GamepadSensitivityLabel = gamepadSensitivityLabel
        var18.GamepadSensitivitySlider = gamepadSensitivitySlider

        var11.GamepadSensitivityFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.GamepadSensitivityFrame
        var11.GamepadSensitivitySlider.ValueChanged:connect(function(arg1)
            setCameraSensitivity((translateGuiGamepadSensitivityToEngine(arg1)))
        end)
    end

    local function createOverscanOption()
        local function func1()
            local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)

            local overscan = require(RobloxGui.Modules.Shell.Components.Overscan10ft.Overscan)
            local var15 = require(RobloxGui.Modules.Settings.Components.OverscanWrapper)(overscan)

            local roact = require(CorePackages.Packages.Roact)
            local var16 = nil

            local tbl9 = {
                onUnmount = function()
                    if var16 then
                        roact.unmount(var16)

                        ContextActionService:UnbindCoreAction("RbxStopOverscanMovement")
                        settingsHub:SetVisibility(true, true)
                    end
                end,
                ImageVisible = false,
                BackgroundTransparency = 0.2
            }

            settingsHub:SetVisibility(false, true)

            ContextActionService:BindCoreAction("RbxStopOverscanMovement", function() end, false, Enum.UserInputType.Gamepad1, Enum.UserInputType.Gamepad2, Enum.UserInputType.Gamepad3, Enum.UserInputType.Gamepad4)

            local element = roact.createElement(var15, tbl9)
            var16 = roact.mount(element, RobloxGui, tostring(var15))
        end

        local var15, var16, var17 = Utility:MakeStyledButton("AdjustButton", "Adjust", UDim2.new(0, 300, 1, -20), func1, var11)
        var16.Font = Theme.font(Enum.Font.SourceSans)
        var15.Position = UDim2.new(1, -400, 0, 12)
        var15.Size = UDim2.new(0, 300, 0, 40)
        var15.Position = UDim2.new(1, -400, 0.5, 0)
        var15.AnchorPoint = Vector2.new(0, 0.5)

        if RunService:IsStudio() then
            var15.Selectable = false
            var15.Active = false
            var15.Enabled.Value = false
            var16.TextColor3 = Color3.fromRGB(100, 100, 100)
        end

        local var18 = Utility:AddNewRowObject(var11, "Safe Zone", var15)
        var18.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.OverscanAdjustButton
        var17(var18)
    end

    local function createDeveloperConsoleOption()
        local function makeDevConsoleOption()
            local function onOpenDevConsole()
                local devConsoleMaster = require(script.Parent.Parent.Parent.DevConsoleMaster)
                if not devConsoleMaster then
                    return
                end

                devConsoleMaster:SetVisibility(true)

                local settingsHub = require(script.Parent.Parent.SettingsHub)
                if settingsHub then
                    settingsHub:SetVisibility(false)
                end
                reportSettingsChangeForAnalytics("dev_console", "", "pressed")
            end

            if bool22 then
                local var15, var16, var17 = Utility:MakeStyledButton("DevConsoleButton", "Open", UDim2.new(1, 0, 1, -20), onOpenDevConsole, var11)

                var16.Font = Theme.font(Enum.Font.SourceSans)
                var15.Size = UDim2.new(0.6, -10, 0, 35)
                var15.Position = UDim2.new(0.4, 10, 0.5, 0)
                var15.AnchorPoint = Vector2.new(0, 0.5)

                local var18 = Utility:AddNewRowObject(var11, "Developer Console", var15, nil, true)
                var18.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.DeveloperConsoleButton
                var17(var18)
                return
            end
            local var15, var16, var17 = Utility:MakeStyledButton("DevConsoleButton", "Open", UDim2.new(0, 300, 1, -20), onOpenDevConsole, var11)

            var16.Font = Theme.font(Enum.Font.SourceSans)
            var15.Size = UDim2.new(0.6, -10, 0, 35)
            var15.Position = UDim2.new(1, -400, 0.5, 0)
            var15.AnchorPoint = Vector2.new(0, 0.5)

            local var18 = Utility:AddNewRowObject(var11, "Developer Console", var15)
            var18.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.DeveloperConsoleButton
            var17(var18)
        end

        if RunService:IsStudio() then
            makeDevConsoleOption()
            return
        end
        spawn(function()
            if PlayerPermissionsModule.CanPlayerManagePlaceAsync(Players.LocalPlayer) then
                makeDevConsoleOption()
            end
        end)
    end

    local function createUiToggleOptions()
        if not (bool21 or bool20) then
            local var15 = var11
            local var16 = var11
            local var17 = var11
            local uiToggleRow, uiToggleFrame, uiToggleSelector = Utility:AddNewRow(var11, "BillboardGui Visibility", "Selector", { "All visible", "Hide nameplates/bubble chat" }, 1)
            var15.uiToggleRow = uiToggleRow
            var16.uiToggleFrame = uiToggleFrame
            var17.uiToggleSelector = uiToggleSelector

            var11.uiToggleRow.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.UiToggleRow

            var11.uiToggleSelector.IndexChanged:connect(function(_)
                GuiService:ToggleGuiIsVisibleIfAllowed(Enum.GuiType.PlayerNameplates)
            end)

            return
        end

        local tbl9 = {
            {
                label = "Custom",
                type = Enum.GuiType.Custom,
                layoutOrderKey = "UiToggleRowCustom"
            },
            {
                label = "CustomBillboards",
                type = Enum.GuiType.CustomBillboards,
                layoutOrderKey = "UiToggleRowBillboards"
            },
            {
                label = "PlayerNameplates",
                type = Enum.GuiType.PlayerNameplates,
                layoutOrderKey = "UiToggleRowNameplates"
            }
        }

        local var15 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var16 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")

        var11.uiToggleSelectors = {}

        for _, value in tbl9 do
            local var17 = RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.GuiVisibility.ShowGuiType", { GuiType = value.label })

            local row, frame, selector = Utility:AddNewRow(var11, var17, "Selector", { var15, var16 }, 1)
            row.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER[value.layoutOrderKey]

            selector.IndexChanged:Connect(function(arg1)
                if (if GuiService:GetGuiIsVisible(value.type) then 1 else 2) ~= arg1 then
                    GuiService:ToggleGuiIsVisibleIfAllowed(value.type)
                end
            end)

            local uiToggleSelectors = var11.uiToggleSelectors
            local label = value.label
            uiToggleSelectors[label] = {
                label = var17,
                type = value.type,
                row = row,
                frame = frame,
                selector = selector
            }
        end

        local var17 = RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.GuiVisibility.Freecam")
        local var18 = var11
        local var19 = var11
        local var20 = var11
        local freecamRow, freecamFrame, freecamSelector = Utility:AddNewRow(var11, var17, "Selector", { var16, var15 }, 1)
        var18.freecamRow = freecamRow
        var19.freecamFrame = freecamFrame
        var20.freecamSelector = freecamSelector

        var11.freecamRow.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.FreecamToggleRow

        var11.freecamSelector.IndexChanged:Connect(function(arg1)
            local bool32 = arg1 == 2
            local freecamScript = LocalPlayer:FindFirstChild("FreecamScript", true)
            if not freecamScript then
                warn("Freecam not present")
                return
            end

            freecamScript:SetAttribute("FreecamEnabled", bool32)
        end)
    end

    local function updateUiToggleSelection()
        if not bool21 and not bool20 then
            if not var11.uiToggleSelector then
                return
            end

            local num1 = if GuiService:GetGuiIsVisible(Enum.GuiType.PlayerNameplates) then 1 else 2

            if num1 == var11.uiToggleSelector:GetSelectedIndex() then
                return
            end

            var11.uiToggleSelector:SetSelectionIndex(num1)
            return
        end

        if not var11.uiToggleSelectors then
            return
        end

        for _, uiToggleSelector in var11.uiToggleSelectors do
            local num1 = if GuiService:GetGuiIsVisible(uiToggleSelector.type) then 1 else 2

            if num1 ~= uiToggleSelector.selector:GetSelectedIndex() then
                uiToggleSelector.selector:SetSelectionIndex(num1)
            end
        end

        local freecamScript = LocalPlayer:FindFirstChild("FreecamScript", true)
        if freecamScript then
            local num1 = if freecamScript:GetAttribute("FreecamEnabled") then 2 else 1
            var11.freecamSelector:SetSelectionIndex(num1)
        end
    end

    local function isValidDeviceList(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg1 and arg2 and arg3 and #arg1 > 0 and arg3 > 0 and arg3 <= #arg1 and #arg1 == #arg2
    end

    local function SwitchOutputDevice(name: string, guid: string) -- Luacid: Inlined by compiler; 1 call site recovered
        SoundService:SetOutputDevice(name, guid)
        var10:info("[SwitchOutputDevice] Setting SS Speaker Device To {} {}", name, guid)
    end

    local function createDeviceOptions(str1: string)
        local var15 = var11[str1 .. "DeviceIndex"] or 0
        local var16 = var11[str1 .. "DeviceNames"] or {}
        local var17 = var11[str1 .. "DeviceGuids"] or {}

        local var18 = str1 == "Input" and RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.InputDevice")
            or RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.OutputDevice")
        local var19 = var11
        local var20 = str1 .. "DeviceFrame"
        local var21 = var11
        local var22 = str1 .. "DeviceSelector"
        local var23, var24, var25 = Utility:AddNewRow(var11, var18, "Selector", var16, var15)
        var19[var20] = var23
        _ = var24
        var21[var22] = var25

        var11[str1 .. "DeviceFrame"].LayoutOrder = str1 == "Input" and SETTINGS_MENU_LAYOUT_ORDER.DeviceFrameInput or SETTINGS_MENU_LAYOUT_ORDER.DeviceFrameOutput

        local var26 = var11
        local var27 = str1 .. "DeviceInfo"
        var26[var27] = {
            Name = if var15 > 0 then var16[var15] or nil else nil,
            Guid = if var15 > 0 then var17[var15] or nil else nil
        }

        var11[str1 .. "PrevDeviceName"] = var11[str1 .. "DeviceInfo"].Name

        local num1 = 0
        local fIntVoiceChatDeviceChangeDebounceDelay = GetFIntVoiceChatDeviceChangeDebounceDelay()
        var11[str1 .. "DeviceSelector"].IndexChanged:connect(function(arg1)
            if var11[str1 .. "DeviceInfo"].Name == var11[str1 .. "DeviceNames"][arg1]
                and var11[str1 .. "DeviceInfo"].Guid == var11[str1 .. "DeviceGuids"][arg1]
            then
                return
            end

            local var28 = num1 + 1
            num1 = var28
            wait(fIntVoiceChatDeviceChangeDebounceDelay)
            if var28 ~= num1 then
                return
            end

            num1 = 0
            var11[str1 .. "DeviceInfo"] = {
                Name = var11[str1 .. "DeviceNames"][arg1],
                Guid = var11[str1 .. "DeviceGuids"][arg1]
            }

            local name = var11[str1 .. "DeviceInfo"].Name
            local guid = var11[str1 .. "DeviceInfo"].Guid

            if var11.VoiceChatOptionsEnabled then
                default3:SwitchDevice(str1, name, guid)
            else
                SwitchOutputDevice(name, guid)
            end

            if GetFFlagEnableCrossExpVoice() then
                var10:debug("[GameSettings] Changing {} device to {} {} ", str1, name, guid)
                if str1 == "Input" then
                    default4:changeInputDevice(name, guid)
                else
                    default4:changeOutputDevice(name, guid)
                end
            end
            reportSettingsChangeForAnalytics(str1, var11[str1 .. "PrevDeviceName"], name)
            var11[str1 .. "PrevDeviceName"] = name
        end)
    end

    local function createBadgeVisibilityOptions() -- Luacid: Inlined by compiler; 1 call site recovered
        spawn(function()
            local num1 = if PlayerPermissionsModule.IsPlayerInExperienceNameEnabledAsync(LocalPlayer) then 1 else 2

            local var15 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Show")
            local var16 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Hide")
            local var17 = if bool26 then RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.MyBadges") else RobloxTranslator:FormatByKey("Feature.SettingsHub.GameSettings.DisplayBadges")
            local var18 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Description.PeoplesNames")
            local var19 = var11
            local var20 = var11
            local var21 = var11
            local badgeVisibleRow, badgeVisibleFrame, badgeVisibleSelector = Utility:AddNewRow(var11, var17, "Selector", { var16, var15 }, num1, nil, var18)
            var19.badgeVisibleRow = badgeVisibleRow
            var20.badgeVisibleFrame = badgeVisibleFrame
            var21.badgeVisibleSelector = badgeVisibleSelector

            var11.badgeVisibleRow.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.BadgeVisibilityFrame

            var11.badgeVisibleSelector.IndexChanged:connect(function(arg1)
                GameSettings.BadgeVisible = arg1 == 2
                PlayerPermissionsModule.SetPlayerInExperienceNameEnabled(LocalPlayer, arg1 == 1)
            end)
        end)
    end

    local function createChatModerationOptions()
        local var15 = var11
        local var16 = var11
        local chatModerationFrame, var18, chatModerationSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.ReadOnlyView"),
            "Selector",
            { var2:Format("InGame.CommonUI.Label.Off"), var2:Format("InGame.CommonUI.Label.On") },
            1,
            nil,
            var2:Format("CoreScripts.InGameMenu.GameSettings.ReadOnlyViewDescription")
        )
        var15.ChatModerationFrame = chatModerationFrame
        _ = var18
        var16.ChatModerationSelector = chatModerationSelector

        var11.ChatModerationFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.ChatModerationFrame
        var11.ChatModerationFrame.Visible = false

        local var20 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetChatModerationStore(false)

        var11.ChatModerationDisposeEffect = Signals.createEffect(function(arg1)
            var11.ChatModerationFrame.Visible = var20.getIsSettingVisible(arg1)

            local num1 = if var20.getIsSettingEnabled(arg1) then 2 else 1
            if var11.ChatModerationSelector:GetSelectedIndex() ~= num1 then
                var11.ChatModerationSelector:SetSelectionIndex(num1)
            end
        end)
        var11.ChatModerationSelector.IndexChanged:connect(function(arg1)
            local bool32 = arg1 == 2
            var20.setIsSettingEnabled(bool32)
            reportSettingsChangeForAnalytics("moderate_chat", not bool32, bool32)
        end)

        var20.initialize()
    end

    local function createAIRephraseSettingOptions()
        local var15 = RobloxTranslator:FormatByKey("CoreScripts.InGameMenu.GameSettings.AIRephraseMessages")
        local var16 = RobloxTranslator:FormatByKey("CoreScripts.InGameMenu.GameSettings.AIRephraseMessagesDescription")
        local var17 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var18 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")

        local var19 = var11
        local var20 = var11
        local aiRephraseFrame, var22, aiRephraseSelector = Utility:AddNewRow(var11, var15, "Selector", { var18, var17 }, 1, nil, var16)
        var19.AIRephraseFrame = aiRephraseFrame
        _ = var22
        var20.AIRephraseSelector = aiRephraseSelector

        var11.AIRephraseFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.AIRephraseFrame
        var11.AIRephraseFrame.Visible = false

        local var24 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetUserChatSettingsStore.getAIRephraseSettingStore(false)
        local fIntDebounceAiRephraseSettingDelay = GetFIntDebounceAIRephraseSettingDelay()
        local bool32 = fIntDebounceAiRephraseSettingDelay > 0
        local num1 = if var24.getIsSettingEnabled(false) then 2 else 1

        var11.AIRephraseDisposeEffect = Signals.createEffect(function(arg1)
            var11.AIRephraseFrame.Visible = var24.getIsSettingVisible(arg1)

            local num2 = if var24.getIsSettingEnabled(arg1) then 2 else 1
            if var11.AIRephraseSelector:GetSelectedIndex() ~= num2 then
                num1 = num2
                var11.AIRephraseSelector:SetSelectionIndex(num2)
            end
        end)

        local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            if arg1 == num1 then
                return
            end
            local bool33 = arg1 == 2

            task.spawn(function()
                if TextChatService:OnUserChatSettingUpdateAsync("allowAIRephrase", if bool33 then "Enabled" else "Disabled") then
                    var24.setIsSettingEnabled(bool33)
                    num1 = arg1
                    reportSettingsChangeForAnalytics("ai_rephrase", not bool33, bool33)
                    return
                end
                var11.AIRephraseSelector:SetSelectionIndex(num1)
            end)
        end

        if not bool27 then
            var11.AIRephraseSelector.IndexChanged:connect(
                if bool32 then ThrottleFunctionCall(fIntDebounceAiRephraseSettingDelay, func1) else func1
            )
            return
        end

        if not bool32 then
            var11.AIRephraseSelector.IndexChanged:connect(func1)
            return
        end

        local var25 = nil
        var11.AIRephraseSelector.IndexChanged:connect(function(arg1)
            if var25 then
                task.cancel(var25)
            end
            var25 = task.delay(fIntDebounceAiRephraseSettingDelay, function()
                var25 = nil
                func1(arg1)
            end)
        end)
    end
    local function createChatSummariesSettingOptions()
        local var15 = RobloxTranslator:FormatByKey("CoreScripts.InGameMenu.GameSettings.ChatSummaries")
        local var16 = RobloxTranslator:FormatByKey("CoreScripts.InGameMenu.GameSettings.ChatSummariesDescription")
        local var17 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var18 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")

        local var19 = var11
        local var20 = var11
        local chatSummariesFrame, var22, chatSummariesSelector = Utility:AddNewRow(var11, var15, "Selector", { var18, var17 }, 1, nil, var16)
        var19.ChatSummariesFrame = chatSummariesFrame
        _ = var22
        var20.ChatSummariesSelector = chatSummariesSelector

        var11.ChatSummariesFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.ChatSummariesFrame
        var11.ChatSummariesFrame.Visible = false

        local var24 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetUserChatSettingsStore.getChatSummariesSettingStore(false)
        local fIntDebounceChatSummariesSettingDelay = GetFIntDebounceChatSummariesSettingDelay()
        local bool32 = fIntDebounceChatSummariesSettingDelay > 0
        local num1 = if var24.getIsSettingEnabled(false) then 2 else 1

        var11.ChatSummariesDisposeEffect = Signals.createEffect(function(arg1)
            var11.ChatSummariesFrame.Visible = var24.getIsSettingVisible(arg1)

            local num2 = if var24.getIsSettingEnabled(arg1) then 2 else 1
            if var11.ChatSummariesSelector:GetSelectedIndex() ~= num2 then
                num1 = num2
                var11.ChatSummariesSelector:SetSelectionIndex(num2)
            end
        end)

        local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            if arg1 == num1 then
                return
            end
            local bool33 = arg1 == 2

            task.spawn(function()
                if TextChatService:OnUserChatSettingUpdateAsync("AllowThirdPartySummary", if bool33 then "Enabled" else "Disabled") then
                    var24.setIsSettingEnabled(bool33)
                    num1 = arg1
                    reportSettingsChangeForAnalytics("chat_summaries", not bool33, bool33)
                    return
                end
                var11.ChatSummariesSelector:SetSelectionIndex(num1)
            end)
        end

        if not bool32 then
            var11.ChatSummariesSelector.IndexChanged:connect(func1)
            return
        end

        local var25 = nil
        var11.ChatSummariesSelector.IndexChanged:connect(function(arg1)
            if var25 then
                task.cancel(var25)
            end
            var25 = task.delay(fIntDebounceChatSummariesSettingDelay, function()
                var25 = nil
                func1(arg1)
            end)
        end)
    end
    local function createVoiceTypingModeSettingOptions()
        local tbl9 = { "standard", "continuous" }

        local function formatWithFallback(str1: string, str2: string) -- Luacid: unused: defined but never referenced
            local success, result = pcall(function()
                return var2:Format(str1)
            end)
            if success then
                return result
            end

            var10:debug("[GameSettings] createVoiceTypingModeSettingOptions missing translation for {}", str1)
            return str2
        end

        local var15 = var11
        local var16 = var11
        local var17 = Utility
        local var18 = var11
        local str1 = "CoreScripts.InGameMenu.GameSettings.VoiceTypingMode"

        local success, result = pcall(function()
            return var2:Format(str1)
        end)
        if not success then
            var10:debug(
                "[GameSettings] createVoiceTypingModeSettingOptions missing translation for {}",
                "CoreScripts.InGameMenu.GameSettings.VoiceTypingMode"
            )
            result = "Voice typing mode"
        end

        local str2 = "Selector"
        local str3 = "CoreScripts.InGameMenu.GameSettings.VoiceTypingModeStandard"

        local success2, result2 = pcall(function()
            return var2:Format(str3)
        end)
        if not success2 then
            var10:debug(
                "[GameSettings] createVoiceTypingModeSettingOptions missing translation for {}",
                "CoreScripts.InGameMenu.GameSettings.VoiceTypingModeStandard"
            )
            result2 = "Manual Send"
        end

        local str4 = "CoreScripts.InGameMenu.GameSettings.VoiceTypingModeContinuous"

        local success3, result3 = pcall(function()
            return var2:Format(str4)
        end)
        if not success3 then
            var10:debug(
                "[GameSettings] createVoiceTypingModeSettingOptions missing translation for {}",
                "CoreScripts.InGameMenu.GameSettings.VoiceTypingModeContinuous"
            )
            result3 = "Auto Send"
        end

        local tbl10 = { result2, result3 }
        local voiceTypingModeFrame, var20, voiceTypingModeSelector = var17:AddNewRow(var18, result, str2, tbl10, 1)
        var15.VoiceTypingModeFrame = voiceTypingModeFrame
        _ = var20
        var16.VoiceTypingModeSelector = voiceTypingModeSelector

        var11.VoiceTypingModeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VoiceTypingModeFrame

        local var22 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetDictationModeSettingStore(false)

        var11.VoiceTypingModeDisposeEffect = Signals.createEffect(function(arg1)
            local num1 = table.find(tbl9, var22.getMode(arg1)) or 1
            if var11.VoiceTypingModeSelector:GetSelectedIndex() ~= num1 then
                var11.VoiceTypingModeSelector:SetSelectionIndex(num1)
            end
        end)

        var11.VoiceTypingModeSelector.IndexChanged:connect(function(arg1)
            local mode = var22.getMode(false)
            local var23 = tbl9[arg1]
            if var23 == nil or var23 == mode then
                return
            end
            var22.setMode(var23)
            reportSettingsChangeForAnalytics("voice_typing_mode", mode, var23)
        end)
    end

    local function createChatNotificationsSettingOptions()
        local toastNotification = require(CorePackages.Workspace.Packages.ToastNotification)
        local default5 = toastNotification.ToastNotificationSnoozeManager.default
        local notificationGroups = toastNotification.NotificationGroups
        local toastNotificationTypeModule = toastNotification.ToastNotificationTypeModule
        local notificationSnoozedSignal = toastNotification.Signals.NotificationSnoozedSignal
        local notificationTypeEnum = toastNotificationTypeModule.NotificationTypeEnum
        local snoozeActionEnum = toastNotificationTypeModule.SnoozeActionEnum

        local tbl9 = { Off = 1, On = 2 }

        local var15 = RobloxTranslator:FormatByKey("Feature.Chat.Label.InGameFriendsChatNotifications")
        local var16 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.On")
        local var17 = RobloxTranslator:FormatByKey("InGame.CommonUI.Label.Off")

        local function getSelectorIndex(): number -- Luacid: unused: defined but never referenced
            return if default5:isSnoozedNotificationType(notificationTypeEnum.ChatNewMessage) then 1 else 2
        end

        local num1 = if default5:isSnoozedNotificationType(notificationTypeEnum.ChatNewMessage) then tbl9.Off else tbl9.On
        local var18 = var11
        local var19 = var11
        local chatNotificationsFrame, var21, chatNotificationsSelector = Utility:AddNewRow(var11, var15, "Selector", { var17, var16 }, num1)
        var18.ChatNotificationsFrame = chatNotificationsFrame
        _ = var21
        var19.ChatNotificationsSelector = chatNotificationsSelector

        var11.ChatNotificationsFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.ChatNotificationsFrame

        var11.ChatNotificationsSelector.IndexChanged:connect(function(arg1)
            if arg1 == num1 then
                return
            end

            local bool32 = num1 == 2
            local bool33 = arg1 == 2
            num1 = arg1

            if bool33 then
                default5:unmuteNotification(
                    {
                        notificationType = notificationGroups.ChatLandingNotificationsGroup,
                        context = "InGameSettings"
                    }
                )
            else
                default5:snoozeNotification({
                    notificationType = notificationGroups.ChatLandingNotificationsGroup,
                    durationMinutes = -1,
                    context = "InGameSettings"
                })
            end

            reportSettingsChangeForAnalytics("chat_notifications", bool32, bool33)
        end)

        notificationSnoozedSignal:connect(function(arg1)
            if arg1.notificationType ~= notificationTypeEnum.ChatNewMessage then
                return
            end

            local num2 = if arg1.actionType == snoozeActionEnum.Mute then 1 else 2

            if var11.ChatNotificationsSelector:GetSelectedIndex() ~= num2 then
                num1 = num2
                var11.ChatNotificationsSelector:SetSelectionIndex(num2)
            end
        end)

        var11.Displayed.Event:Connect(function()
            local num2 = if default5:isSnoozedNotificationType(notificationTypeEnum.ChatNewMessage) then tbl9.Off else tbl9.On

            if var11.ChatNotificationsSelector:GetSelectedIndex() ~= num2 then
                num1 = num2
                var11.ChatNotificationsSelector:SetSelectionIndex(num2)
            end
        end)
    end

    local function createCameraDeviceOptions()
        local cameraDeviceIndex = var11.CameraDeviceIndex or 1
        local cameraDeviceNames = var11.CameraDeviceNames or {}
        local var15 = var11.CameraDeviceGuids or {}

        local var16 = var11
        local var17 = var11
        local cameraDeviceFrame, var19, cameraDeviceSelector = Utility:AddNewRow(var11, var9, "Selector", cameraDeviceNames, cameraDeviceIndex)
        var16.CameraDeviceFrame = cameraDeviceFrame
        _ = var19
        var17.CameraDeviceSelector = cameraDeviceSelector

        var11.CameraDeviceFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.CameraDeviceFrame

        local var21 = var11
        var21.CameraDeviceInfo = {
            Name = if cameraDeviceIndex > 0 then cameraDeviceNames[cameraDeviceIndex] or nil else nil,
            Guid = cameraDeviceIndex > 0 and var15[cameraDeviceIndex] or nil
        }

        var11.prevCameraDeviceName = var11.CameraDeviceInfo.Name

        var11.CameraDeviceSelector.IndexChanged:connect(function(arg1)
            if var11.CameraDeviceInfo.Name == var11.CameraDeviceNames[arg1]
                and var11.CameraDeviceInfo.Guid == var11.CameraDeviceGuids[arg1]
            then
                return
            end

            var11.CameraDeviceInfo = {
                Name = var11.CameraDeviceNames[arg1],
                Guid = var11.CameraDeviceGuids[arg1]
            }

            local guid = var11.CameraDeviceInfo.Guid
            var10:info("Changed webcam to: {}", guid)
            UserGameSettings.DefaultCameraID = guid
            reportSettingsChangeForAnalytics("video_camera", var11.prevCameraDeviceName or "None", var11.CameraDeviceInfo.Name)

            var11.prevCameraDeviceName = var11.CameraDeviceInfo.Name
        end)
    end

    local function updateAudioDevices(str1: string)
        local success, result, result2, result3 = pcall(function()
            if str1 == "Input" then
                return SoundService:GetInputDevices()
            end
            return SoundService:GetOutputDevices()
        end)

        if success and isValidDeviceList(result, result2, result3) then
            if result2[1] == "" then
                result[1] = var2:Format("CoreScripts.InGameMenu.GameSettings.Default") .. " (" .. result[1] .. ")"
            end

            var11[str1 .. "DeviceNames"] = result
            var11[str1 .. "DeviceGuids"] = result2
            var11[str1 .. "DeviceIndex"] = result3
        else
            if GetFFlagVoiceChatUILogging() then
                var10:warning("Errors in get {} device info", str1)
            end
            var11[str1 .. "DeviceNames"] = {}
            var11[str1 .. "DeviceGuids"] = {}
            var11[str1 .. "DeviceIndex"] = 0
        end

        if not var11[str1 .. "DeviceSelector"] then
            createDeviceOptions(str1)
            return
        end
        var11[str1 .. "DeviceSelector"]:UpdateOptions(result)
        var11[str1 .. "DeviceSelector"]:SetSelectionIndex(result3)
    end

    local function updateVoiceChatDevices(str1: string)
        if str1 ~= "Input" and str1 ~= "Output" and GetFFlagVoiceChatUILogging() then
            var10:warning("{} is not supported in VoiceChat devices", str1)
        end

        local success, result, result2, result3 = pcall(function()
            if str1 == "Input" then
                return SoundService:GetInputDevices()
            end
            return SoundService:GetOutputDevices()
        end)

        if success and isValidDeviceList(result, result2, result3) then
            if result2[1] == "" then
                result[1] = var2:Format("CoreScripts.InGameMenu.GameSettings.Default") .. " (" .. result[1] .. ")"
            end

            var11[str1 .. "DeviceNames"] = result
            var11[str1 .. "DeviceGuids"] = result2
            var11[str1 .. "DeviceIndex"] = result3
        else
            if GetFFlagVoiceChatUILogging() then
                if #result > 0 then
                    var10:warning("Errors in get {} device info success: {}", str1, success)
                else
                    var10:warning("Empty deviceNames list for {}", str1)
                end
            end
            var11[str1 .. "DeviceNames"] = {}
            var11[str1 .. "DeviceGuids"] = {}
            var11[str1 .. "DeviceIndex"] = 0
        end

        if not var11[str1 .. "DeviceSelector"] then
            createDeviceOptions(str1)
        else
            var11[str1 .. "DeviceSelector"]:UpdateOptions(result)
            var11[str1 .. "DeviceSelector"]:SetSelectionIndex(result3)
        end

        if not var11[str1 .. "DeviceFrame"] then
            return
        end

        if #result > 0 then
            var11[str1 .. "DeviceFrame"].Visible = true
            return
        end
        var11[str1 .. "DeviceFrame"].Visible = false
    end

    local function updateCameraDevices()
        local cameraDevices = VideoCaptureService:GetCameraDevices()
        local cameraDeviceNames = {}
        local cameraDeviceGuids = {}
        local num1 = 1
        table.insert(cameraDeviceNames, var8)
        table.insert(cameraDeviceGuids, "{DefaultDeviceGuid}")
        for k, value in pairs(cameraDevices) do
            if k == UserGameSettings.DefaultCameraID then
                num1 = #cameraDeviceNames + 1
            end
            table.insert(cameraDeviceNames, value)
            table.insert(cameraDeviceGuids, k)
        end

        var11.CameraDeviceNames = cameraDeviceNames
        var11.CameraDeviceGuids = cameraDeviceGuids
        var11.CameraDeviceIndex = 0

        if not var11.CameraDeviceSelector then
            createCameraDeviceOptions()
        else
            var11.CameraDeviceSelector:UpdateOptions(cameraDeviceNames)
        end
        var11.CameraDeviceSelector:SetSelectionIndex(num1)
    end

    local connection = nil
    local connection2 = nil

    local function updateAudioOptions()
        if var11.VoiceChatOptionsEnabled then
            updateVoiceChatDevices("Input")
            updateVoiceChatDevices("Output")
            return
        end
        if GetFFlagEnableCrossExpVoice() and default4:getIsConnected() then
            updateAudioDevices("Input")
        end
        updateAudioDevices("Output")
    end

    local function setupDeviceChangedListener() -- Luacid: Inlined by compiler; 1 call site recovered
        if not SoundService.DeviceListChanged then
            return
        end

        connection = SoundService.DeviceListChanged:Connect(function()
            if var11.PageOpen then
                updateAudioOptions()
            end
        end)
    end

    local function setupVideoCameraDeviceChangedListener() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not VideoCaptureService.DevicesChanged then
            return
        end

        connection2 = VideoCaptureService.DevicesChanged:Connect(function()
            if var11.PageOpen then
                updateCameraDevices()
            end
        end)
    end

    local function teardownDeviceChangedListener() -- Luacid: Inlined by compiler; 1 call site recovered
        if SoundService.DeviceListChanged and connection then
            connection:Disconnect()
        end
    end

    local function teardownVideoCameraDeviceChangedListener() -- Luacid: Inlined by compiler; 1 call site recovered
        if VideoCaptureService.DevicesChanged and connection2 then
            connection2:Disconnect()
            connection2 = nil
        end
    end

    local connection3 = nil
    local connection4 = nil
    local connection5 = nil

    local function setupUIScaleViewportChangedListener()
        if not engineFeature3 then
            return
        end

        if FFlagUIScaleEngineOptions and not connection3 then
            local num1 = 0
            connection3 = RunService.Heartbeat:Connect(function(deltaTime: number)
                num1 += deltaTime
                if num1 >= 0.1 and var11.PageOpen then
                    num1 = 0
                    refreshUIScaleRows()
                end
            end)
        end

        local function rebindToCurrentCamera()
            if connection4 then
                connection4:Disconnect()
                connection4 = nil
            end
            local currentCamera = workspace.CurrentCamera
            if not currentCamera then
                return
            end
            connection4 = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                if not var11.PageOpen then
                    return
                end

                if FFlagUIScaleEngineOptions then
                    refreshUIScaleRows()
                    return
                end

                createUIScaleOptions()
            end)
        end
        rebindToCurrentCamera()

        connection5 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(rebindToCurrentCamera)
    end

    local function teardownUIScaleViewportChangedListener() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end
        if connection4 then
            connection4:Disconnect()
            connection4 = nil
        end
        if connection5 then
            connection5:Disconnect()
            connection5 = nil
        end

        var12 = nil
        var13 = nil
    end

    local function checkVoiceChatOptions() -- Luacid: Inlined by compiler; 1 call site recovered
        if default3:VoiceChatAvailable() then
            var11.VoiceChatOptionsEnabled = true
        end
    end

    local function updateInputDeviceVisibility() -- Luacid: unused: defined but never referenced
        local var15 = var11.VoiceChatOptionsEnabled or GetFFlagEnableCrossExpVoice() and default4:getIsConnected()
        if var11.InputDeviceFrame then
            var11.InputDeviceFrame.Visible = var15
        end
    end

    local bool32 = false
    local bool33 = not bool8 and nil

    local function createVoiceChatSelector()
        if bool6 and var11.VoiceConnectDisconnectFrame and var11.VoiceConnectDisconnectSelector then
            return
        end

        local var15 = var2:Format("Feature.GameDetails.Label.VoiceChat")
        local var16 = var2:Format("Feature.SettingsHub.Label.Disconnected")
        local var17 = var2:Format("Feature.SettingsHub.Label.Connected")

        local num1 = if default3:VoiceChatEnded() then 1 else 2
        local var18 = var11
        local var19 = var11
        local voiceConnectDisconnectFrame, var21, voiceConnectDisconnectSelector = Utility:AddNewRow(var11, var15, "Selector", { var16, var17 }, num1)
        var18.VoiceConnectDisconnectFrame = voiceConnectDisconnectFrame
        _ = var21
        var19.VoiceConnectDisconnectSelector = voiceConnectDisconnectSelector

        var11.VoiceConnectDisconnectFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VoiceConnectDisconnectSelector

        local service = default3:getService()
        if service and not bool8 then
            service.StateChanged:Connect(function(arg1, arg2)
                if bool6 then
                    if arg1 == arg2 then
                        return
                    end

                    if arg2 == Enum.VoiceChatState.Joined and var11.VoiceConnectDisconnectSelector:GetSelectedIndex() ~= 2 then
                        var11.VoiceConnectDisconnectSelector:SetSelectionIndex(2)
                        return
                    end

                    if (arg2 == Enum.VoiceChatState.Ended or arg2 == Enum.VoiceChatState.Failed or arg2 == Enum.VoiceChatState.Idle)
                        and var11.VoiceConnectDisconnectSelector:GetSelectedIndex() ~= 1
                    then
                        var11.VoiceConnectDisconnectSelector:SetSelectionIndex(1)
                    end
                else
                    if arg1 == arg2 then
                        return
                    end

                    if arg2 == Enum.VoiceChatState.Joined then
                        var11.VoiceConnectDisconnectSelector:SetSelectionIndex(2)
                        return
                    end

                    if default3:VoiceChatEnded() then
                        var11.VoiceConnectDisconnectSelector:SetSelectionIndex(1)
                    end
                end
            end)
        end

        local num2 = num1

        local fIntDebounceDisconnectButtonDelay = GetFIntDebounceDisconnectButtonDelay()
        local bool34 = fIntDebounceDisconnectButtonDelay > 0

        local function func1(arg1)
            if arg1 == num2 then
                return
            end

            num2 = arg1

            if bool8 and bool33 then
                return
            end

            if FFlagVoiceRewarmTelemetry then
                local var23, var24, var25, var26 = default3:GetConnectDisconnectButtonAnalyticsData(arg1 == 2)
                default3.Analytics:reportJoinVoiceButtonEventWithVoiceSessionId(
                    "clicked",
                    var23,
                    var24,
                    var25,
                    var26,
                    default3.joinVoiceButtonContext
                )
            else
                default3.Analytics:reportJoinVoiceButtonEventWithVoiceSessionId(
                    "clicked",
                    default3:GetConnectDisconnectButtonAnalyticsData(arg1 == 2)
                )
            end

            if arg1 == 2 then
                default3.pendingConnectionSource = Constants2.VOICE_CONNECTION_SOURCE.SETTINGS_TOGGLE_ON
                default3:JoinVoice()
            elseif bool11 then
                local service2 = default3:getService()
                local bool35 = not (service2 == nil) and service2.VoiceChatState == Enum.VoiceChatState.Failed

                if not (default3:VoiceChatEnded() or bool35) then
                    default3.pendingDisconnectReason = Constants2.VOICE_DISCONNECT_REASON.USER_DISCONNECT
                    default3:Leave()
                end
            elseif not default3:VoiceChatEnded() then
                default3.pendingDisconnectReason = Constants2.VOICE_DISCONNECT_REASON.USER_DISCONNECT
                default3:Leave()
            end

            if not bool32 then
                return
            end

            task.spawn(function()
                task.wait(0.5)
                if arg1 ~= 1 then
                    var11.VoiceConnectDisconnectSelector:SetSelectionIndex(1)
                end
            end)
        end

        local indexChanged = var11.VoiceConnectDisconnectSelector.IndexChanged
        if bool34 then
            func1 = ThrottleFunctionCall(fIntDebounceDisconnectButtonDelay, func1)
        end

        indexChanged:connect(func1)

        if bool4 then
            var11.VoiceConnectDisconnectFrame.SelectionChanged:Connect(function(_, selectedCoreObject, arg1)
                if arg1
                    and selectedCoreObject
                    and selectedCoreObject.Parent
                    and selectedCoreObject.Parent.Name == var15 .. "Frame"
                    and arg1.Name == "ImageButton"
                    and var11.Active
                then
                    GuiService.SelectedCoreObject = selectedCoreObject
                end
            end)
        end

        default3:subscribe("OnStateChanged", function(_, voiceChatState)
            if bool8 then
                bool33 = true
                if bool10 then
                    if voiceChatState == Enum.VoiceChatState.Joined and var11.VoiceConnectDisconnectSelector:GetSelectedIndex() ~= 2 then
                        var11.VoiceConnectDisconnectSelector:SetSelectionIndex(2)
                    end
                elseif voiceChatState == Enum.VoiceChatState.Joined then
                    var11.VoiceConnectDisconnectSelector:SetSelectionIndex(2)
                end
            end

            if bool10 then
                if voiceChatState == Enum.VoiceChatState.Failed and var11.VoiceConnectDisconnectSelector:GetSelectedIndex() ~= 1 then
                    var11.VoiceConnectDisconnectSelector:SetSelectionIndex(1)
                end
            elseif voiceChatState == Enum.VoiceChatState.Failed then
                var11.VoiceConnectDisconnectSelector:SetSelectionIndex(1)
            end

            if not bool8 then
                return
            end

            if bool9 then
                task.defer(function()
                    bool33 = false
                end)

                return
            end

            bool33 = false
        end)

        default3:subscribe("OnRequestMicPermissionRejected", function()
            task.spawn(function()
                task.wait(0.5)
                bool32 = true
                if bool8 then
                    bool33 = true
                end
                var11.VoiceConnectDisconnectSelector:SetSelectionIndex(1)
                if not bool8 then
                    return
                end

                if bool9 then
                    task.defer(function()
                        bool33 = false
                    end)

                    return
                end

                bool33 = false
            end)
        end)
    end

    local function createVRComfortSettingOptions()
        local enumItems = Enum.VRComfortSetting:GetEnumItems()
        local tbl9 = {
            title = "CoreScripts.InGameMenu.PageTitle.VRComfortSettings",
            description = "CoreScripts.InGameMenu.GameSettings.ComfortSettingsDescription",
            ["Enum.VRComfortSetting.Comfort"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingComfort",
            ["Enum.VRComfortSetting.Normal"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingNormal",
            ["Enum.VRComfortSetting.Expert"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingExpert",
            ["Enum.VRComfortSetting.Custom"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingCustom",
            vignetteEnabled = "CoreScripts.InGameMenu.GameSettings.VignetteEnabled",
            steppedRotationEnabled = "CoreScripts.InGameMenu.GameSettings.VRSteppedRotationEnabled",
            thirdPersonFixedCamEnabled = "CoreScripts.InGameMenu.GameSettings.VRThirdPersonFixedCamEnabled",
            on = "InGame.CommonUI.Label.On",
            off = "InGame.CommonUI.Label.Off"
        }

        local tbl10 = ({})
        for i, enumItem in ipairs(enumItems) do
            tbl10[i] = var2:Format(tbl9[tostring(enumItem)])
        end

        local var15 = table.find(enumItems, GameSettings.VRComfortSetting)
        local var16 = var11
        local var17 = var11
        local var18 = var11
        local vrComfortSettingFrame, vrComfortSettingLabel, vrComfortSettingSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.PageTitle.VRComfortSettings"),
            "Selector",
            tbl10,
            var15,
            nil,
            var2:Format("CoreScripts.InGameMenu.GameSettings.ComfortSettingsDescription")
        )
        var16.VRComfortSettingFrame = vrComfortSettingFrame
        var17.VRComfortSettingLabel = vrComfortSettingLabel
        var18.VRComfortSettingSelector = vrComfortSettingSelector

        var11.VRComfortSettingFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VRComfortSettingFrame

        local num1 = if GameSettings.VignetteEnabled then 1 else 2
        local var22 = var11
        local var23 = var11
        local var24 = var11
        local vrVignetteEnabledFrame, vrVignetteEnabledLabel, vrVignetteEnabledSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.VignetteEnabled"),
            "Selector",
            { var2:Format("InGame.CommonUI.Label.On"), var2:Format("InGame.CommonUI.Label.Off") },
            num1
        )
        var22.VRVignetteEnabledFrame = vrVignetteEnabledFrame
        var23.VRVignetteEnabledLabel = vrVignetteEnabledLabel
        var24.VRVignetteEnabledSelector = vrVignetteEnabledSelector

        var11.VRVignetteEnabledFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VRVignetteEnabledFrame

        local num2 = if GameSettings.VRSmoothRotationEnabled then 2 else 1
        local var28 = var11
        local var29 = var11
        local var30 = var11
        local vrSteppedRotationEnabledFrame, vrSteppedRotationEnabledLabel, vrSteppedRotationEnabledSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.VRSteppedRotationEnabled"),
            "Selector",
            { var2:Format("InGame.CommonUI.Label.On"), var2:Format("InGame.CommonUI.Label.Off") },
            num2
        )
        var28.VRSteppedRotationEnabledFrame = vrSteppedRotationEnabledFrame
        var29.VRSteppedRotationEnabledLabel = vrSteppedRotationEnabledLabel
        var30.VRSteppedRotationEnabledSelector = vrSteppedRotationEnabledSelector

        var11.VRSteppedRotationEnabledFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VRSteppedRotationEnabledFrame

        local num3 = if GameSettings.VRThirdPersonFollowCamEnabled then 2 else 1
        local var34 = var11
        local var35 = var11
        local var36 = var11
        local vrThirdPersonFixedCamEnabledFrame, vrThirdPersonFixedCamEnabledLabel, vrThirdPersonFixedCamEnabledSelector = Utility:AddNewRow(
            var11,
            var2:Format("CoreScripts.InGameMenu.GameSettings.VRThirdPersonFixedCamEnabled"),
            "Selector",
            { var2:Format("InGame.CommonUI.Label.On"), var2:Format("InGame.CommonUI.Label.Off") },
            num3
        )
        var34.VRThirdPersonFixedCamEnabledFrame = vrThirdPersonFixedCamEnabledFrame
        var35.VRThirdPersonFixedCamEnabledLabel = vrThirdPersonFixedCamEnabledLabel
        var36.VRThirdPersonFixedCamEnabledSelector = vrThirdPersonFixedCamEnabledSelector

        var11.VRThirdPersonFixedCamEnabledFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VRThirdPersonFixedCamEnabledFrame

        local function func1(vrComfortSetting)
            if vrComfortSetting == Enum.VRComfortSetting.Custom then
                var11.VRVignetteEnabledSelector:SetZIndex(2)
                var11.VRVignetteEnabledLabel.ZIndex = 2
                var11.VRVignetteEnabledSelector:SetInteractable(true)
                var11.VRSteppedRotationEnabledSelector:SetZIndex(2)
                var11.VRSteppedRotationEnabledLabel.ZIndex = 2
                var11.VRSteppedRotationEnabledSelector:SetInteractable(true)
                var11.VRThirdPersonFixedCamEnabledSelector:SetZIndex(2)
                var11.VRThirdPersonFixedCamEnabledLabel.ZIndex = 2
                var11.VRThirdPersonFixedCamEnabledSelector:SetInteractable(true)
                return
            end
            var11.VRVignetteEnabledSelector:SetZIndex(1)
            var11.VRVignetteEnabledLabel.ZIndex = 1
            var11.VRVignetteEnabledSelector:SetInteractable(false)
            var11.VRSteppedRotationEnabledSelector:SetZIndex(1)
            var11.VRSteppedRotationEnabledLabel.ZIndex = 1
            var11.VRSteppedRotationEnabledSelector:SetInteractable(false)
            var11.VRThirdPersonFixedCamEnabledSelector:SetZIndex(1)
            var11.VRThirdPersonFixedCamEnabledLabel.ZIndex = 1
            var11.VRThirdPersonFixedCamEnabledSelector:SetInteractable(false)
        end

        var11.VRComfortSettingSelector.IndexChanged:connect(function(arg1)
            local vrComfortSetting = enumItems[arg1]
            GameSettings.VRComfortSetting = vrComfortSetting
            func1(vrComfortSetting)
        end)
        func1(GameSettings.VRComfortSetting)

        var11.VRVignetteEnabledSelector.IndexChanged:connect(function(arg1)
            if GameSettings.VRComfortSetting == Enum.VRComfortSetting.Custom then
                GameSettings.VignetteEnabledCustomOption = arg1 == 1
            end
        end)

        var11.VRSteppedRotationEnabledSelector.IndexChanged:connect(function(arg1)
            if GameSettings.VRComfortSetting == Enum.VRComfortSetting.Custom then
                GameSettings.VRSmoothRotationEnabledCustomOption = arg1 == 2
            end
        end)

        var11.VRThirdPersonFixedCamEnabledSelector.IndexChanged:connect(function(arg1)
            if GameSettings.VRComfortSetting == Enum.VRComfortSetting.Custom then
                GameSettings.VRThirdPersonFollowCamEnabledCustomOption = arg1 == 2
            end
        end)

        GameSettings:GetPropertyChangedSignal("VRComfortSetting"):Connect(function()
            local var40 = table.find(enumItems, GameSettings.VRComfortSetting)
            if var11.VRComfortSettingSelector:GetSelectedIndex() ~= var40 then
                var11.VRComfortSettingSelector:SetSelectionIndex(var40)
            end
        end)

        GameSettings:GetPropertyChangedSignal("VignetteEnabled"):Connect(function()
            local num4 = if GameSettings.VignetteEnabled then 1 else 2
            if var11.VRVignetteEnabledSelector:GetSelectedIndex() ~= num4 then
                var11.VRVignetteEnabledSelector:SetSelectionIndex(num4)
            end
        end)

        GameSettings:GetPropertyChangedSignal("VRSmoothRotationEnabled"):Connect(function()
            local num4 = if GameSettings.VRSmoothRotationEnabled then 2 else 1
            if var11.VRSteppedRotationEnabledSelector:GetSelectedIndex() ~= num4 then
                var11.VRSteppedRotationEnabledSelector:SetSelectionIndex(num4)
            end
        end)

        GameSettings:GetPropertyChangedSignal("VRThirdPersonFollowCamEnabled"):Connect(function()
            local num4 = if GameSettings.VRThirdPersonFollowCamEnabled then 2 else 1
            if var11.VRThirdPersonFixedCamEnabledSelector:GetSelectedIndex() ~= num4 then
                var11.VRThirdPersonFixedCamEnabledSelector:SetSelectionIndex(num4)
            end
        end)
    end

    local function createVRSafetyBubbleModeOptions()
        local enumItems = Enum.VRSafetyBubbleMode:GetEnumItems()
        local tbl9 = {
            title = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeTitle",
            description = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeDescription",
            ["Enum.VRSafetyBubbleMode.NoOne"] = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeNoOne",
            ["Enum.VRSafetyBubbleMode.OnlyFriends"] = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeOnlyFriends",
            ["Enum.VRSafetyBubbleMode.Anyone"] = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeAnyone"
        }

        local tbl10 = ({})
        for i, enumItem in ipairs(enumItems) do
            tbl10[i] = var2:Format(tbl9[tostring(enumItem)])
        end

        local var15 = table.find(enumItems, GameSettings.VRSafetyBubbleMode)
        task.defer(function()
            local var16 = var11
            local var17 = var11
            local var18 = var11
            local vrSafetyBubbleModeFrame, vrSafetyBubbleModeLabel, vrSafetyBubbleModeSelector = Utility:AddNewRow(
                var11,
                var2:Format("CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeTitle"),
                "DropDown",
                tbl10,
                var15,
                nil,
                var2:Format("CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeDescription")
            )
            var16.VRSafetyBubbleModeFrame = vrSafetyBubbleModeFrame
            var17.VRSafetyBubbleModeLabel = vrSafetyBubbleModeLabel
            var18.VRSafetyBubbleModeSelector = vrSafetyBubbleModeSelector

            var11.VRSafetyBubbleModeFrame.LayoutOrder = SETTINGS_MENU_LAYOUT_ORDER.VRSafetyBubbleModeFrame

            var11.VRSafetyBubbleModeSelector.IndexChanged:connect(function(arg1)
                GameSettings.VRSafetyBubbleMode = enumItems[arg1]
            end)

            GameSettings:GetPropertyChangedSignal("VRSafetyBubbleMode"):Connect(function()
                local var22 = table.find(enumItems, GameSettings.VRSafetyBubbleMode)
                if var11.VRSafetyBubbleModeSelector:GetSelectedIndex() ~= var22 then
                    var11.VRSafetyBubbleModeSelector:SetSelectionIndex(var22)
                end
            end)
        end)
    end

    var11.VoiceChatOptionsEnabled = false
    local connection6 = nil
    local connection7 = nil
    local var15 = nil
    if game:GetEngineFeature("VoiceChatSupported") then
        spawn(function()
            if (not bool2 and default3:EligibleForFaeUpsell() or default3:IsSeamlessVoice())
                and default3:verifyUniverseAndPlaceCanUseVoice()
            then
                createVoiceChatSelector()

                if isVoiceFocused() and var11.VoiceConnectDisconnectFrame then
                    var11.VoiceConnectDisconnectFrame.Visible = false
                end
                observeIsVoiceFocused(function(arg1)
                    if arg1 then
                        if var11.VoiceConnectDisconnectFrame then
                            var11.VoiceConnectDisconnectFrame.Visible = false
                        end
                    elseif var11.VoiceConnectDisconnectFrame then
                        var11.VoiceConnectDisconnectFrame.Visible = true
                    end
                end)
            end

            default3:asyncInit():andThen(function()
                VoiceChatService = default3:getService()
                checkVoiceChatOptions()

                if FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider and var11.VoiceChatVolumeFrame then
                    local function updateVoiceChatVolumeVisibility(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
                        local success, result = pcall(function()
                            local VoiceChatService = game:GetService("VoiceChatService")
                            local service = default3:getService()

                            local bool34 = (if bool12 then arg1 or service and service.VoiceChatState else service and service.VoiceChatState) == Enum.VoiceChatState.Joined
                            local useNewAudioApi = VoiceChatService and VoiceChatService.UseNewAudioApi
                            local var16 = bool14 and GetFFlagEnableCrossExpVoice() and GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() and isVoiceFocused()
                            var11.VoiceChatVolumeFrame.Visible = VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(bool34, useNewAudioApi) and not var16
                        end)

                        if not success then
                            var10:debug("[GameSettings] updateVoiceChatVolumeVisibility ERROR:", result)
                        end
                    end

                    updateVoiceChatVolumeVisibility(nil)

                    if bool14 and GetFFlagEnableCrossExpVoice() and GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() then
                        observeIsVoiceFocused(function()
                            updateVoiceChatVolumeVisibility(nil)
                        end)
                    end

                    if bool12 then
                        default3:subscribe("OnStateChanged", function(_, arg1)
                            updateVoiceChatVolumeVisibility(arg1)
                        end)
                    else
                        local service = default3:getService()
                        if service then
                            service.StateChanged:Connect(function()
                                updateVoiceChatVolumeVisibility(nil)
                            end)
                        end
                    end
                end

                if bool6 and default3:UserVoiceEnabled() and default3:verifyUniverseAndPlaceCanUseVoice() then
                    createVoiceChatSelector()
                end

                if not GetFFlagEnableUniveralVoiceToasts() then
                    default3:CheckAndShowNotAudiblePrompt()

                    local var16 = bool14 and GetFFlagEnableCrossExpVoice() and GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() and isVoiceFocused()

                    if FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast and not var16 then
                        default3:ShowNotAudiblePromptVoiceChatVolume()
                    end
                end

                if not (bool8 and bool9) then
                    var11.VoiceConnectDisconnectSelector:SetSelectionIndex(2)

                    return
                end

                bool33 = true

                var11.VoiceConnectDisconnectSelector:SetSelectionIndex(2)

                task.defer(function()
                    bool33 = false
                end)
            end):catch(function()
                if GetFFlagVoiceChatUILogging() then
                    var10:warning("Failed to init VoiceChatServiceManager")
                end

                if not GetFFlagEnableUniveralVoiceToasts() then
                    default3:CheckAndShowPermissionPrompt()
                end
            end)
        end)
    end
    if GetFFlagEnableCrossExpVoice() and not (isInExperienceUIVREnabled and isSpatial()) then
        local event = default4.ExperienceJoined.Event

        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            local var16 = var11.VoiceChatOptionsEnabled or GetFFlagEnableCrossExpVoice() and default4:getIsConnected()
            if var11[tbl5.Input .. "DeviceFrame"] then
                var11[tbl5.Input .. "DeviceFrame"].Visible = var16
            end
        end

        connection6 = event:Connect(func1)

        connection7 = default4.ExperienceLeft.Event:Connect(function()
            func1()
        end)

        var15 = function()
            if connection6 then
                connection6:Disconnect()
                connection6 = nil
            end
            if connection7 then
                connection7:Disconnect()
                connection7 = nil
            end
        end
    end

    var11.VideoOptionsEnabled = false
    local connection8 = nil
    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection8 then
            connection8:disconnect()
            connection8 = nil
        end
    end
    if GetFFlagSelfViewCameraSettings() and not (isInExperienceUIVREnabled and isSpatial()) then
        local function func2(arg1)
            var11.VideoOptionsEnabled = arg1.hasCameraPermissions
        end

        if isCamEnabledForUserAndPlace() then
            getCamMicPermissions(func2, { default.Permissions.CAMERA_ACCESS }, true)

            if connection8 then
                connection8:disconnect()
            end
            connection8 = cameraDevicePermissionGrantedSignal:connect(function()
                var11.VideoOptionsEnabled = true
                updateCameraDevices()
                setupVideoCameraDeviceChangedListener()
            end)
        end
    end

    if not isInExperienceUIVREnabled then
        createCameraModeOptions(
            not isEnabled and (UserInputService.TouchEnabled or UserInputService.MouseEnabled or UserInputService.KeyboardEnabled)
        )
    end

    local function func2() -- Luacid: Inlined by compiler; 2 call sites recovered
        if GameSettings.IsUsingGamepadCameraSensitivity then
            createGamepadOptions()
            return
        end
        local connection9 = nil
        connection9 = GameSettings:GetPropertyChangedSignal("IsUsingGamepadCameraSensitivity"):connect(function()
            if not GameSettings.IsUsingGamepadCameraSensitivity then
                return
            end

            if connection9 then
                connection9:disconnect()
            end
            createGamepadOptions()
        end)
    end

    if UserInputService.MouseEnabled then
        createMouseOptions()
    elseif UserInputService.GamepadEnabled then
        func2()
    else
        local connection9 = nil
        connection9 = UserInputService.GamepadConnected:connect(function()
            if connection9 then
                connection9:disconnect()
            end

            func2()
        end)
    end

    if not isInExperienceUIVREnabled then
        if GameSettings.IsUsingCameraYInverted then
            createCameraInvertedOptions()
        else
            local connection9 = nil
            connection9 = GameSettings.Changed:connect(function(arg1)
                if arg1 == "IsUsingCameraYInverted" and GameSettings.IsUsingCameraYInverted then
                    connection9:disconnect()
                    createCameraInvertedOptions()
                end
            end)
        end
    end

    if isInExperienceUIVREnabled then
        if isSpatial() then
            createVRComfortSettingOptions()
            createVRSafetyBubbleModeOptions()
        else
            createCameraModeOptions(
                not isEnabled and (UserInputService.TouchEnabled or UserInputService.MouseEnabled or UserInputService.KeyboardEnabled)
            )

            if GameSettings.IsUsingCameraYInverted then
                createCameraInvertedOptions()
            else
                local connection9 = nil
                connection9 = GameSettings.Changed:connect(function(arg1)
                    if arg1 == "IsUsingCameraYInverted" and GameSettings.IsUsingCameraYInverted then
                        connection9:disconnect()
                        createCameraInvertedOptions()
                    end
                end)
            end

            createReducedMotionOptions()
            createPreferredTransparencyOptions()
        end
    end

    createVolumeOptions()
    if FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider then
        createVoiceChatVolumeOptions()
    end

    if var4 and FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider then
        local bool34 = false

        var11.Displayed.Event:Connect(function()
            bool34 = true
            if var11.VoiceChatVolumeFrame and var11.VoiceChatVolumeFrame.Visible then
                default3:RecordGameSettingsOpened()
            end
        end)

        var11.Hidden.Event:Connect(function()
            bool34 = false
        end)

        var11.VoiceChatVolumeFrame:GetPropertyChangedSignal("Visible"):Connect(function()
            if var11.VoiceChatVolumeFrame.Visible and bool34 then
                default3:RecordGameSettingsOpened()
            end
        end)
    end
    if hasPartyVoiceVolume then
        createPartyVoiceVolumeOptions()
    end
    if FFlagFriendsCallingCallVolumeSlider then
        createCallVolumeOptions()
    end

    createHapticsToggle()
    createGraphicsOptions()
    if bool1 and GetFFlagEnablePlayerNamesEnabledSetting() then
        createPlayerNamesEnabledOptions()
    end

    if game:GetEngineFeature("InExperiencePlayerChoiceToggle") then
        PlayerChoiceTranslationSettingInitializer(var11, SETTINGS_MENU_LAYOUT_ORDER, reportSettingsChangeForAnalytics)
    end

    if not isInExperienceUIVREnabled then
        createReducedMotionOptions()
        createPreferredTransparencyOptions()
    end
    createPreferredTextSizeOptions()
    if FFlagUIScaleEngineOptions then
        createUIScaleRows()
    elseif engineFeature3 then
        createUIScaleOptions()
    end

    createUiNavigationKeyBindOptions()

    if not CachedPolicyService:IsSubjectToChinaPolicies() then
        createPerformanceStatsOptions()
    end

    if bool16 then
        createMicroProfilerOptions()
    end

    if isEnabled and getAppFeaturePolicies().getSupportsOverscan() then
        createOverscanOption()
    end

    if bool1 and FFlagBadgeVisibilitySettingEnabled then
        createBadgeVisibilityOptions()
    end

    if FFlagEnableModerateChatRemoteEvent then
        createChatModerationOptions()
    end

    if FFlagAIRephraseSettingEnabled then
        createAIRephraseSettingOptions()
    end

    if FFlagChatSummariesSettingEnabled then
        createChatSummariesSettingOptions()
    end

    if var3 then
        createVoiceTypingModeSettingOptions()
    end
    createChatNotificationsSettingOptions()

    createDeveloperConsoleOption()

    GetHasGuiHidingPermission(RunService:IsStudio(), LocalPlayer, PlayerPermissionsModule):andThen(function(arg1)
        if arg1 then
            createUiToggleOptions()
        end
    end):catch(function(arg1)
        warn(arg1)
    end)

    bool30 = true
    if VRService.VREnabled then
        onVRSettingsReady()
    end

    if renderMoreSettingsBanner then
        var11.MoreSettingsBanner = renderMoreSettingsBanner({ layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.MoreSettingsBanner, parent = var11.Page })
    end

    var11.AudioHeader = renderSettingsHeader({
        headerText = "CoreScripts.InGameMenu.GameSettings.AudioHeader",
        layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.AudioHeader,
        parent = var11.Page
    })
    var11.AudioDivider = renderSettingsDivider({ layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.AudioDivider, parent = var11.Page })

    var11.DisplayHeader = renderSettingsHeader({
        headerText = "CoreScripts.InGameMenu.GameSettings.DisplayHeader",
        layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.DisplayHeader,
        parent = var11.Page
    })
    var11.DisplayDivider = renderSettingsDivider({ layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.DisplayDivider, parent = var11.Page })

    if not isSpatial() then
        var11.LanguageHeader = renderSettingsHeader({
            headerText = "CoreScripts.InGameMenu.GameSettings.LanguageHeader",
            layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageHeader,
            parent = var11.Page
        })
        var11.LanguageDivider = renderSettingsDivider({ layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.LanguageDivider, parent = var11.Page })
    end

    var11.ViewAndControlsHeader = renderSettingsHeader({
        headerText = "CoreScripts.InGameMenu.GameSettings.ViewandControlsHeader",
        layoutOrder = SETTINGS_MENU_LAYOUT_ORDER.ViewAndControlsHeader,
        parent = var11.Page
    })

    var11.TabHeader.Name = "GameSettingsTab"
    local iconsCommonSettings = Migration.uiblox["icons/common/settings"]
    var11.TabHeader.TabLabel.Icon.Text = iconsCommonSettings.name
    var11.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[iconsCommonSettings.variant]
    var11.TabHeader.TabLabel.Title.Text = "Settings"

    var11.Page.ZIndex = 5

    if var11.PageListLayout then
        var11.PageListLayout.Padding = UDim.new(0, 0)
    end

    var11.PageOpen = false

    if game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") then
        var11.FeedbackEntryPointEnabled = true
    end

    local function staticFeedbackEntryPointChecksPassed(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return not RunService:IsStudio() and not (game:GetEngineFeature("CaptureModeEnabled") == false) and not (bool23 and isEnabled)
    end

    function var11.OpenSettingsPage()
        var11.PageOpen = true

        if isInExperienceUIVREnabled and isSpatial() then
            return
        end

        if FFlagUIScaleEngineOptions then
            refreshUIScaleRows()
        elseif engineFeature3 then
            createUIScaleOptions()
        end

        if GetFFlagLazyInitiateExperienceLanguageSwitcher()
            and not var11.LanguageSwitcherInitialized
            and isLangaugeSelectionDropdownEnabled()
            and GetFFlagEnableLocalesForExperienceLanguageSwitcher()
        then
            var11.LanguageSwitcherInitialized = true
            ExperienceLanguageSwitcherInitializer(var11, SETTINGS_MENU_LAYOUT_ORDER, reportSettingsChangeForAnalytics)
        end

        updateAudioOptions()
        setupDeviceChangedListener()

        if engineFeature3 then
            setupUIScaleViewportChangedListener()
        end
        var11.startVolume = GameSettings.MasterVolume
        if FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast and FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider then
            var11.maxVoiceChatVolumeDuringSession = GameSettings.VoiceChatVolume
        end

        if GetFFlagSelfViewCameraSettings() and var11.VideoOptionsEnabled and game:GetEngineFeature("VideoCaptureService") then
            updateCameraDevices()
            setupVideoCameraDeviceChangedListener()
        end

        updateUiToggleSelection()

        if game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled")
            and var11.toggleFeedbackModeButton
            and var11.toggleFeedbackModeText
        then
            local var16 = var11
            var16.FeedbackEntryPointEnabled = not (ExperienceStateCaptureService == nil) and ExperienceStateCaptureService:CanEnterCaptureMode()

            if var11.FeedbackEntryPointEnabled then
                var11.toggleFeedbackModeButton.Active = true
                var11.toggleFeedbackModeButton.Enabled.Value = true
                var11.toggleFeedbackModeText.Text = var7
            else
                var11.toggleFeedbackModeButton.Active = false
                var11.toggleFeedbackModeButton.Enabled.Value = false
                var11.toggleFeedbackModeText.TextColor3 = Theme.color("ButtonNonInteractable", Color3.fromRGB(100, 100, 100))
                var11.toggleFeedbackModeText.Text = var6
            end
        end
        table.insert(var11.LastSelectableObjects, (getLastValueChangerFrame(var11)))
        if FFlagIEMTabFocusNav then
            table.insert(var11.FirstSelectableObjects, getFirstValueChangerFrame(var11))
            var11.FirstSelectableObjectsUpdated:fire()
        end
    end

    function var11.CloseSettingsPage()
        var11.PageOpen = false

        if isInExperienceUIVREnabled and isSpatial() then
            return
        end

        teardownDeviceChangedListener()

        if engineFeature3 then
            teardownUIScaleViewportChangedListener()
        end

        if GetFFlagEnableCrossExpVoice() and var15 then
            var15()
        end
        if GetFFlagSelfViewCameraSettings() then
            if game:GetEngineFeature("VideoCaptureService") then
                teardownVideoCameraDeviceChangedListener()
            end

            func1()
        end

        if game:GetEngineFeature("VoiceChatSupported")
            and var11.VoiceChatOptionsEnabled
            and var11.startVolume ~= nil
            and var11.startVolume > 0
        then
            default3:CheckAndShowNotAudiblePrompt()
        end

        if game:GetEngineFeature("VoiceChatSupported")
            and var11.VoiceChatOptionsEnabled
            and FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast
            and FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider
            and var11.maxVoiceChatVolumeDuringSession ~= nil
            and var11.maxVoiceChatVolumeDuringSession > 0
        then
            default3:ShowNotAudiblePromptVoiceChatVolume()
        end
    end

    function isLangaugeSelectionDropdownEnabled(): boolean
        if game:GetEngineFeature("EnableSetExperienceSettingsLocaleIdApi") ~= true then
            return false
        end

        if LocalPlayer.UserId % 1000 + 1 <= game:GetFastInt("V1MenuLanguageSelectionFeaturePerMillageRollout") then
            return true
        end

        for value in game:GetFastString("V1MenuLanguageSelectionFeatureForcedUserIds"):gmatch("%d+") do
            if tonumber(value) == LocalPlayer.UserId then
                return true
            end
        end

        return false
    end

    function var11.SetHub(_, hubRef)
        var11.HubRef = hubRef

        if isInExperienceUIVREnabled and isSpatial() then
            return
        end

        if isLangaugeSelectionDropdownEnabled() then
            if GetFFlagEnableLocalesForExperienceLanguageSwitcher() then
                if not GetFFlagLazyInitiateExperienceLanguageSwitcher() then
                    ExperienceLanguageSwitcherInitializer(var11, SETTINGS_MENU_LAYOUT_ORDER, reportSettingsChangeForAnalytics)
                end
            else
                createTranslationOptions()
            end
        end

        if game:GetEngineFeature("EnableTCSChatTranslation") and GetFFlagChatTranslationSettingEnabled() then
            if GetFFlagChatTranslationHoldoutEnabled() then
                local fStringChatTranslationLayerName = GetFStringChatTranslationLayerName()
                if not getChatTranslationLayerData(fStringChatTranslationLayerName).ChatTranslationEnabled then
                    if engineFeature then
                        if GetFFlagChatTranslationNewDefaults() then
                            if GameSettings.ChatTranslationLocale == "" then
                                GameSettings.ChatTranslationEnabled = false
                                GameSettings.ChatTranslationLocale = "en_us"
                            end
                        else
                            GameSettings.ChatTranslationEnabled = false
                        end
                    else
                        pcall(function()
                            TextChatService.ChatTranslationEnabled = false
                        end)
                    end
                elseif GetFFlagChatTranslationForceSetting() then
                    GameSettings.ChatTranslationEnabled = true
                end
            end

            ChatTranslationOptionsWithChatLanguageSwitcherInitializer(
                var11,
                SETTINGS_MENU_LAYOUT_ORDER,
                reportSettingsChangeForAnalytics
            )
        end

        if staticFeedbackEntryPointChecksPassed() then
            createFeedbackModeOptions()
        end
    end
    return var11
end

return (Initialize())
