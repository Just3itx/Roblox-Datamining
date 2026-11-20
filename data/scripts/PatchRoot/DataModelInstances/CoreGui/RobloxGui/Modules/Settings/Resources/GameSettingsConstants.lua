-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Modules = game:GetService("CoreGui"):WaitForChild("RobloxGui").Modules
local CorePackages = game:GetService("CorePackages")

local GetFFlagEnablePlayerNamesEnabledSetting = require(Modules.Settings.Flags.GetFFlagEnablePlayerNamesEnabledSetting)
local FFlagBadgeVisibilitySettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBadgeVisibilitySettingEnabled
local engineFeature = game:GetEngineFeature("RUUserScalePreferenceAPI")
local FFlagUIScaleEngineOptions = require(CorePackages.Workspace.Packages.SharedFlags).FFlagUIScaleEngineOptions
local FFlagAIRephraseSettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAIRephraseSettingEnabled
local FFlagChatSummariesSettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagChatSummariesSettingEnabled

local FFlagExpChatDictationVoiceTypingModeSetting = require(CorePackages.Workspace.Packages.SharedFlags).FFlagExpChatDictationVoiceTypingModeSetting

local FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider = require(Modules.Settings.Flags.FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider)
local FFlagFriendsCallingCallVolumeSlider = require(Modules.Settings.Flags.FFlagFriendsCallingCallVolumeSlider)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local var1 = require(CorePackages.Packages.ReactUtils).createNextOrder()

local SETTINGS_MENU_LAYOUT_ORDER = {
    MoreSettingsBanner = var1(),
    AudioHeader = var1(),
    VolumeFrame = var1(),
    VoiceChatVolumeFrame = if FFlagVoiceVolumeControlsEnableVoiceChatVolumeSlider then var1() else nil,
    PartyVoiceVolumeFrame = var1(),
    CallVolumeFrame = if FFlagFriendsCallingCallVolumeSlider then var1() else nil,
    DeviceFrameInput = var1(),
    DeviceFrameOutput = var1(),
    AudioDivider = var1(),
    LanguageHeader = var1(),
    VoiceTypingModeFrame = if FFlagExpChatDictationVoiceTypingModeSetting then var1() else nil,
    ChatModerationFrame = var1(),
    VoiceConnectDisconnectSelector = var1(),
    VoiceConnectFrame = var1(),
    VoiceDisconnectFrame = var1(),
    ChatSummariesFrame = if FFlagChatSummariesSettingEnabled then var1() else nil,
    AIRephraseFrame = if FFlagAIRephraseSettingEnabled then var1() else nil,
    PlayerChoiceTranslationFrame = if game:GetEngineFeature("InExperiencePlayerChoiceToggle") then var1() else nil,
    LanguageSelectorFrame = var1(),
    FeedbackModeButton = var1(),
    ChatTranslationFrame = var1(),
    ChatLanguageSelectorFrame = var1(),
    ChatTranslationToggleFrame = var1(),
    ChatNotificationsFrame = var1(),
    LanguageDivider = var1(),
    DisplayHeader = var1(),
    OverscanAdjustButton = var1(),
    FullScreenFrame = var1(),
    UIScaleEngineModeFrame = if FFlagUIScaleEngineOptions then var1() else nil,
    UIScaleEngineFrame = if FFlagUIScaleEngineOptions then var1() else nil,
    PreferredTransparencyFrame = var1(),
    PreferredTextSizeFrame = var1(),
    UIScaleModeFrame = if engineFeature then var1() else nil,
    UIScaleFrame = if engineFeature then var1() else nil,
    VRComfortSettingFrame = if isInExperienceUIVREnabled then var1() else nil,
    VRVignetteEnabledFrame = if isInExperienceUIVREnabled then var1() else nil,
    VRSteppedRotationEnabledFrame = if isInExperienceUIVREnabled then var1() else nil,
    VRThirdPersonFixedCamEnabledFrame = if isInExperienceUIVREnabled then var1() else nil,
    VRSafetyBubbleModeFrame = if isInExperienceUIVREnabled then var1() else nil,
    PerformanceStatsFrame = var1(),
    MicroProfilerFrame = var1(),
    GraphicsEnablerFrame = var1(),
    GraphicsQualityFrame = var1(),
    HapticsFrame = var1(),
    ReducedMotionFrame = var1(),
    FramerateCap = var1(),
    VREnabledFrame = var1(),
    DisplayDivider = var1(),
    ViewAndControlsHeader = var1(),
    CameraModeFrame = var1(),
    CameraInvertedFrame = var1(),
    CameraSensitivityFrame = var1(),
    MouseAdvancedFrame = var1(),
    GamepadSensitivityFrame = var1(),
    MovementModeFrame = var1(),
    ShiftLockFrame = var1(),
    CameraDeviceFrame = var1(),
    UiNavigationKeyBindEnabledFrame = var1(),
    DeveloperConsoleButton = var1(),
    PlayerNamesEnabledFrame = if GetFFlagEnablePlayerNamesEnabledSetting() then var1() else nil,
    BadgeVisibilityFrame = if FFlagBadgeVisibilitySettingEnabled then var1() else nil,
    UiToggleRow = var1(),
    UiToggleRowCustom = var1(),
    UiToggleRowBillboards = var1(),
    UiToggleRowNameplates = var1(),
    FreecamToggleRow = var1(),
    InformationFrame = var1()
}
if FFlagUIScaleEngineOptions then
    local preferredTransparencyFrame = SETTINGS_MENU_LAYOUT_ORDER.PreferredTransparencyFrame
    local preferredTextSizeFrame = SETTINGS_MENU_LAYOUT_ORDER.PreferredTextSizeFrame
    SETTINGS_MENU_LAYOUT_ORDER.PreferredTextSizeFrame = preferredTransparencyFrame
    SETTINGS_MENU_LAYOUT_ORDER.PreferredTransparencyFrame = preferredTextSizeFrame
end

return { SETTINGS_MENU_LAYOUT_ORDER = SETTINGS_MENU_LAYOUT_ORDER }
