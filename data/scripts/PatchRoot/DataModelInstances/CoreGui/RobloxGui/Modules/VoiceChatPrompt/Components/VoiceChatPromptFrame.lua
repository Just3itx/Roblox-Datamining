-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)

local FFlagVoiceChatBanDurationUseServerTime = require(script.Parent.Parent.Parent.VoiceChat.Flags.FFlagVoiceChatBanDurationUseServerTime)
local Cryo = require(CorePackages.Packages.Cryo)

local renderWithCoreScriptsStyleProvider = require(script.Parent.Parent.Parent.Common.renderWithCoreScriptsStyleProvider)
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local useLastInput = Responsive.useLastInput

local UIBlox = require(CorePackages.Packages.UIBlox)
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Toast = UIBlox.App.Dialog.Toast
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local validateStyle = UIBlox.Style.Validator.validateStyle

local PromptType = require(script.Parent.Parent.PromptType)
local InGameMenuPolicy = require(script.Parent.Parent.Parent.InGameMenu.InGameMenuPolicy)
local VoiceChatConsentModal = require(script.Parent.VoiceChatConsentModal)
local VoiceChatTooltip = require(script.Parent.VoiceChatTooltip)
local DevicePermissionsModal = require(script.Parent.DevicePermissionsModal)

local Assets = require(script.Parent.Parent.Parent.InGameMenu.Resources.Assets)

local VoiceChatCore = require(CorePackages.Workspace.Packages.VoiceChatCore)
local GetFFlagMicConsumerRegistry = VoiceChatCore.Flags and VoiceChatCore.Flags.GetFFlagMicConsumerRegistry
local Flags = require(CorePackages.Workspace.Packages.VoiceChat).Flags

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GetFFlagEnableVoicePromptReasonText = require(RobloxGui.Modules.Flags.GetFFlagEnableVoicePromptReasonText)
local GetFFlagSupportGamepadNavInVoiceModals = Flags.GetFFlagSupportGamepadNavInVoiceModals

local GetFIntVoiceToxicityToastDurationSeconds = require(RobloxGui.Modules.Flags.GetFIntVoiceToxicityToastDurationSeconds)
local bool1 = game:DefineFastFlag("VoiceChatOnlyReportVoiceBans", false)
local GetFFlagShowDevicePermissionsModal = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagShowDevicePermissionsModal

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")
local GetFIntVoiceJoinM3ToastDurationSeconds = require(RobloxGui.Modules.Flags.GetFIntVoiceJoinM3ToastDurationSeconds)

local GetFFlagEnableSeamlessVoiceDataConsentToast = require(RobloxGui.Modules.Flags.GetFFlagEnableSeamlessVoiceDataConsentToast)

local GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2 = require(script.Parent.Parent.Parent.VoiceChat.Flags.GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2)
local VoiceNudgeUseNewDACopy = require(script.Parent.Parent.Parent.VoiceChat.Helpers.VoiceNudgeUseNewDACopy)
local bool2 = game:DefineFastFlag("VoiceNudgeUseNewConfirmButton", false)

local FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast = require(script.Parent.Parent.Parent.VoiceChat.Flags.FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local LocalizationService = game:GetService("LocalizationService")
local var1 = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)

local white = Color3.fromRGB(255, 255, 255)
local quillGrey = Color3.fromRGB(220, 220, 220)

local function formatMicPromptText(str1: string, str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    if not GetFFlagMicConsumerRegistry() then
        return nil
    end

    local success, result = pcall(function()
        return var1:Format(str1)
    end)
    return if success then result else str2
end

local function getMicPermissionDeniedTitle()
    return formatMicPromptText("Feature.SettingsHub.Prompt.MicPermissionDenied", "Can't access microphone")
end

local function getMicFirstUnmutePrivacyTitle()
    return formatMicPromptText("Feature.SettingsHub.Prompt.MicFirstUnmutePrivacy", "Microphone is active")
end

local function getMicPermissionDeniedSubtitle()
    return formatMicPromptText(
        "Feature.SettingsHub.Prompt.Subtitle.MicPermissionDenied",
        "To use your microphone, tap here to update your device settings."
    )
end

local function getMicFirstUnmutePrivacySubtitle()
    return formatMicPromptText(
        "Feature.SettingsHub.Prompt.Subtitle.MicFirstUnmutePrivacy",
        "We process and then delete your audio. Tap to view our privacy policy."
    )
end

Roact.PureComponent:extend("VoiceChatPromptFrame")
local tbl1 = {
    [PromptType.None] = "",
    [PromptType.NotAudible] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.NotAudible"),
    [PromptType.NotAudibleVoiceChatVolume] = if FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast then var1:Format("Feature.SettingsHub.Prompt.NotAudible") else nil,
    [PromptType.Permission] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.MicrophonePermission"),
    [PromptType.Retry] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.MicrophonePermission"),
    [PromptType.Place] = "Exceeds Max Players",
    [PromptType.User] = "Not Eligible for Voice",
    [PromptType.VoiceChatSuspendedTemporaryAvatarChat] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.MicAndCameraUseSuspended"),
    [PromptType.VoiceChatSuspendedTemporary] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.MicUseSuspended"),
    [PromptType.VoiceChatSuspendedTemporaryB] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceChatSuspended"),
    [PromptType.VoiceChatSuspendedPermanent] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceChatSuspended"),
    [PromptType.VoiceLoading] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Connecting"),
    [PromptType.VoiceToxicityModal] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.RememberRules"),
    [PromptType.VoiceToxicityToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.RememberRules"),
    [PromptType.VoiceToxicityFeedbackToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.ThankYouForFeedback"),
    [PromptType.VoiceChatSuspendedTemporaryToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.MicUseSuspended"),
    [PromptType.VoiceConsentDeclinedToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.ChangeYourMind"),
    [PromptType.VoiceConsentAcceptedToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.JoinedVoiceChat"),
    [PromptType.VoiceConsentModalV1] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.GetVoiceChat"),
    [PromptType.VoiceConsentModalV2] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceChatWithOthers"),
    [PromptType.VoiceConsentModalV3] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.GetVoiceChat"),
    [PromptType.JoinedVoiceToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.JoinedVoiceChat"),
    [PromptType.JoinVoiceSTUX] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.JoinedVoiceChat"),
    [PromptType.LeaveVoice] = var1:Format("Feature.SettingsHub.Prompt.LeaveVoiceChatV2"),
    [PromptType.JoinVoice] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.JoinedVoiceChatV2"),
    [PromptType.DevicePermissionsModal] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.NeedMicrophoneAccess"),
    [PromptType.VoiceDataConsentOptOutToast] = if GetFFlagEnableSeamlessVoiceDataConsentToast() then var1:Format("Feature.SettingsHub.Prompt.Title.ImproveVoiceChat") else nil,
    [PromptType.UnifiedJoinVoiceToast] = var1:Format("Feature.SettingsHub.Prompt.JoinedVoiceChatV3"),
    [PromptType.AgeCheckForVoiceToast] = var1:Format("Feature.SettingsHub.Prompt.Title.AgeCheckForVoiceToast"),
    [PromptType.UpdateOnAutoJoinToast] = var1:Format("Feature.SettingsHub.Prompt.UpdateToVoiceChat"),
    [PromptType.VoiceChatSuspendedTemporaryBV2] = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.VoiceChatSuspendedV2") else nil,
    [PromptType.VoiceToxicityModalV2] = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.RememberRulesVoiceChat") else nil,
    [PromptType.VoiceToxicityToastV2] = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.RememberRulesVoiceChat") else nil,
    [PromptType.MicPermissionDenied] = getMicPermissionDeniedTitle,
    [PromptType.MicFirstUnmutePrivacy] = getMicFirstUnmutePrivacyTitle
}

local tbl2 = {
    [PromptType.None] = "",
    [PromptType.NotAudible] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.NotAudible"),
    [PromptType.NotAudibleVoiceChatVolume] = if FFlagVoiceVolumeControlsEnableNotAudibleVoiceChatVolumeToast then var1:Format("Feature.SettingsHub.Prompt.Subtitle.NotAudibleVoiceChatVolume") else nil,
    [PromptType.Permission] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.MicrophonePermission"),
    [PromptType.Retry] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.Retry"),
    [PromptType.Place] = "Spatial voice is only available for places with Max Players of 30 or less.",
    [PromptType.User] = "This account is not eligible to use Spatial Voice.",
    [PromptType.VoiceChatSuspendedTemporary] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.Microphone"),
    [PromptType.VoiceChatSuspendedTemporaryAvatarChat] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.MicAndCamera"),
    [PromptType.VoiceChatSuspendedTemporaryB] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.TemporaryVoiceBan1"),
    [PromptType.VoiceChatSuspendedPermanent] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.Revoked"),
    [PromptType.VoiceLoading] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.Connecting"),
    [PromptType.VoiceToxicityModal] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.VoiceToxicityModal"),
    [PromptType.VoiceToxicityToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.VoiceToxicityToast"),
    [PromptType.VoiceToxicityFeedbackToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.ThanksForLettingUsKnow")
}
tbl2[PromptType.VoiceChatSuspendedTemporaryToast] = function(dateTime)
    return RobloxTranslator:FormatByKey("Feature.SettingsHub.Description.ChatWithVoiceDisabledUntil", { dateTime = dateTime })
end

tbl2[PromptType.VoiceConsentDeclinedToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.JoinVoiceLater")

tbl2[PromptType.VoiceConsentAcceptedToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.MuteAnyoneAnytime")

tbl2[PromptType.VoiceConsentModalV1] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.InExpVoiceUpsell1")

tbl2[PromptType.VoiceConsentModalV2] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.InExpVoiceUpsell2")

tbl2[PromptType.VoiceConsentModalV3] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.InExpVoiceUpsell2")

tbl2[PromptType.JoinedVoiceToast] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.DisconnectOrMute")

tbl2[PromptType.JoinVoiceSTUX] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.DisconnectOrMuteHere")

tbl2[PromptType.DevicePermissionsModal] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.AllowMicrophoneAccess")

local VoiceDataConsentOptOutToast = PromptType.VoiceDataConsentOptOutToast
tbl2[VoiceDataConsentOptOutToast] = if GetFFlagEnableSeamlessVoiceDataConsentToast() then var1:Format("Feature.SettingsHub.Prompt.Subtitle.ThanksForVoiceData") else nil

tbl2[PromptType.UnifiedJoinVoiceToast] = RobloxTranslator:FormatByKey("Feature.Captures.Prompt.Subtitle.VoiceChatRecordingTrustedFriendsAgeGroup")

tbl2[PromptType.AgeCheckForVoiceToast] = var1:Format("Feature.SettingsHub.Prompt.Subtitle.GoToAccountInfo")
tbl2[PromptType.UpdateOnAutoJoinToast] = var1:Format("Feature.SettingsHub.Prompt.Subtitle.TalkAgeGroupTrustedFriendsUpdate")
local VoiceChatSuspendedTemporaryBV2 = PromptType.VoiceChatSuspendedTemporaryBV2
tbl2[VoiceChatSuspendedTemporaryBV2] = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.TemporaryVoiceBan1V2") else nil

local VoiceToxicityModalV2 = PromptType.VoiceToxicityModalV2
tbl2[VoiceToxicityModalV2] = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.VoiceToxicityModalV2") else nil

local VoiceToxicityToastV2 = PromptType.VoiceToxicityToastV2
tbl2[VoiceToxicityToastV2] = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.VoiceToxicityToastV2") else nil

tbl2[PromptType.MicPermissionDenied] = getMicPermissionDeniedSubtitle
tbl2[PromptType.MicFirstUnmutePrivacy] = getMicFirstUnmutePrivacySubtitle

if RunService:IsStudio() then
    tbl1[PromptType.Place] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Place")
    tbl1[PromptType.User] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.User")
    tbl2[PromptType.Place] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.Place")
    tbl2[PromptType.User] = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.User")
end

RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.Respect")
local var2 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.FutureViolations")
local var3 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.EffectiveUntil")
local var4 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Understand")
local var5 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.GotIt")
local var6 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.IncorrectNudge")
local var7 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.TemporaryVoiceBan2")
local var8 = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.Ok") else nil
local var9 = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.TemporaryVoiceBan2V2") else nil
local var10 = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.IncorrectNudgeV2") else nil

local function formatBannedUntilDate(unixTimestamp: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return DateTime.fromUnixTimestamp(unixTimestamp):FormatLocalTime("l LT", LocalizationService.RobloxLocaleId)
end

local function PromptTypeIsBan(promptType) -- Luacid: Inlined by compiler; 4 call sites recovered
    return promptType == PromptType.VoiceChatSuspendedPermanent
        or promptType == PromptType.VoiceChatSuspendedTemporary
        or promptType == PromptType.VoiceChatSuspendedTemporaryAvatarChat
        or promptType == PromptType.VoiceChatSuspendedTemporaryB
        or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and promptType == PromptType.VoiceChatSuspendedTemporaryBV2
end

local function IsModalNudge(promptType) -- Luacid: Inlined by compiler; 5 call sites recovered
    return promptType == PromptType.VoiceToxicityModal
        or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and promptType == PromptType.VoiceToxicityModalV2
end

local function IsVoiceConsentModal(promptType): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return promptType == PromptType.VoiceConsentModalV1
        or promptType == PromptType.VoiceConsentModalV2
        or promptType == PromptType.VoiceConsentModalV3
end

local function IsDevicePermissionsModal(devicePermissionsModal): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return devicePermissionsModal == PromptType.DevicePermissionsModal
end

local function PromptTypeIsModal(promptType) -- Luacid: Inlined by compiler; 1 call site recovered
    return PromptTypeIsBan(promptType)
        or IsModalNudge(promptType)
        or IsVoiceConsentModal(promptType)
        or not not IsDevicePermissionsModal(promptType)
end

local function PromptTypeIsVoiceConsent(promptType): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return promptType == PromptType.VoiceConsentDeclinedToast or promptType == PromptType.VoiceConsentAcceptedToast
end

local function PromptTypeIsVoiceDataConsent(voiceDataConsentOptOutToast): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return voiceDataConsentOptOutToast == PromptType.VoiceDataConsentOptOutToast
end

local function PromptTypeIsConnectDisconnectToast(promptType): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return promptType == PromptType.JoinVoice
        or promptType == PromptType.LeaveVoice
        or promptType == PromptType.UnifiedJoinVoiceToast
end

local function ShouldShowBannedUntil(promptType) -- Luacid: Inlined by compiler; 1 call site recovered
    return promptType == PromptType.VoiceChatSuspendedTemporary
        or promptType == PromptType.VoiceChatSuspendedTemporaryAvatarChat
        or promptType == PromptType.VoiceChatSuspendedTemporaryToast
        or promptType == PromptType.VoiceChatSuspendedTemporaryB
        or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and promptType == PromptType.VoiceChatSuspendedTemporaryBV2
end

local function ShouldShowSecondaryButton(promptType) -- Luacid: Inlined by compiler; 1 call site recovered
    return if promptType == PromptType.VoiceChatSuspendedTemporaryB
        or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and promptType == PromptType.VoiceChatSuspendedTemporaryBV2 then true else IsModalNudge(promptType)
end

local function promptSignalCallback(arg1, promptType)
    if PromptTypeIsBan(promptType) then
        if arg1.props.Analytics then
            arg1.props.Analytics:reportBanMessageEvent("Shown")
        end
        if arg1.props.VoiceChatServiceManager then
            arg1.props.VoiceChatServiceManager:reportBanMessage("Shown")
        end
    end

    if IsVoiceConsentModal(promptType) and arg1.props.Analytics then
        local str1 = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else ""

        arg1.props.Analytics:reportInExpConsent(
            "shown",
            arg1.props.VoiceChatServiceManager.inExpUpsellEntrypoint,
            game.GameId,
            game.PlaceId,
            str1
        )
    end

    if IsDevicePermissionsModal(promptType) and arg1.props.Analytics and arg1.props.VoiceChatServiceManager then
        arg1.props.Analytics:reportDevicePermissionsModalEvent(
            "Shown",
            arg1.props.VoiceChatServiceManager:GetSessionId(),
            arg1.props.VoiceChatServiceManager:GetInExpUpsellAnalyticsData()
        )
    end

    if not promptType or promptType == PromptType.None then
        arg1:setState({ promptType = PromptType.None, toastContent = Roact.None })
        return
    end

    local var11 = tbl1[promptType]
    local var12 = tbl2[promptType]

    if PromptTypeIsConnectDisconnectToast(promptType)
        and arg1.props.VoiceChatServiceManager
        and arg1.props.VoiceChatServiceManager:HasSeamlessVoiceFeature("HideJoinToastSubtitle")
    then
        var12 = nil
    end

    local bannedUntil = arg1.props.bannedUntil
    if FFlagVoiceChatBanDurationUseServerTime then
        bannedUntil = arg1.props.bannedUntil and formatBannedUntilDate(arg1.props.bannedUntil.absoluteSeconds)
    end

    if typeof(var11) == "function" then
        var11 = var11(bannedUntil)
    end

    if typeof(var12) == "function" then
        var12 = var12(bannedUntil)
    end

    local var13 = nil
    local var14

    if GetFFlagMicConsumerRegistry() and promptType == PromptType.MicPermissionDenied then
        var14 = Images["icons/status/alert"]
        var13 = function()
            local linkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol)
            local default = linkingProtocol.LinkingProtocol.default
            local settingsRoute = linkingProtocol.Enums.SettingsRoute
            local microphone = if settingsRoute then settingsRoute.Microphone else nil
            local var15, var16 = default:supportsSwitchToSettingsApp(microphone):await()
            if var15 and var16 then
                default:switchToSettingsApp(microphone):catch(function() end)
            end
        end
    elseif GetFFlagMicConsumerRegistry() and promptType == PromptType.MicFirstUnmutePrivacy then
        var14 = Images["icons/controls/microphone"]
        var13 = function()
            require(CorePackages.Workspace.Packages.LinkingProtocol).LinkingProtocol.default:openURL(
                "https://en.help.roblox.com/hc/articles/115004630823"
            ):catch(
                function() end
            )
        end
    elseif promptType == PromptType.UpdateOnAutoJoinToast then
        var14 = Images["icons/controls/microphone"]
    elseif PromptTypeIsVoiceConsent(promptType)
        or promptType == PromptType.JoinedVoiceToast
        or promptType == PromptType.UnifiedJoinVoiceToast
    then
        var14 = Images["icons/controls/publicAudioJoin"]
    elseif PromptTypeIsConnectDisconnectToast(promptType) then
        var14 = Images["icons/actions/info"]
    elseif PromptTypeIsVoiceDataConsent(promptType) and GetFFlagEnableSeamlessVoiceDataConsentToast() then
        var14 = nil
    else
        var14 = Images["icons/status/alert"]
    end
    arg1:setState({
        showPrompt = true,
        promptType = promptType,
        toastContent = {
            iconImage = var14,
            toastTitle = var11,
            toastSubtitle = var12,
            onActivated = var13 or function()
                if arg1.props.onPrimaryActivated then
                    arg1.props.onPrimaryActivated()
                end
            end,
            onDismissed = function() end
        }
    })

    if not ShouldShowBannedUntil(promptType) then
        return
    end

    local var15

    if FFlagVoiceChatBanDurationUseServerTime then
        local var16 = GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and promptType == PromptType.VoiceChatSuspendedTemporaryBV2

        local bool3 = promptType == PromptType.VoiceChatSuspendedTemporaryB or var16
        local minutes = arg1.props.bannedUntil.minutes
        if bool3 then
            if minutes >= 1 then
                bool3 = minutes <= 60
            else
                bool3 = false
            end
        end

        if bool3 and var16 then
            var15 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.XMinuteSuspensionV2", { banDurationInMinutes = minutes })
        elseif bool3 then
            var15 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.XMinuteSuspension", { banDurationInMinutes = minutes })
        else
            local str1 = formatBannedUntilDate(arg1.props.bannedUntil.absoluteSeconds)
            var15 = var3 .. " " .. str1 .. "."
        end
    else
        local var16 = RobloxTranslator:FormatByKey(
            "Feature.SettingsHub.Prompt.XMinuteSuspension",
            {
                banDurationInMinutes = arg1.props.bannedUntil
            }
        )

        if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() then
            var15 = RobloxTranslator:FormatByKey(
                "Feature.SettingsHub.Prompt.XMinuteSuspensionV2",
                {
                    banDurationInMinutes = arg1.props.bannedUntil
                }
            )
        else
            var15 = nil
        end

        if promptType == PromptType.VoiceChatSuspendedTemporaryB then
            var15 = var16
        elseif not GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() or promptType ~= PromptType.VoiceChatSuspendedTemporaryBV2 then
            var15 = " " .. arg1.props.bannedUntil .. "."
        end
    end

    arg1:setState({ banEnd = var15 })
end

local var11 = Roact.PureComponent:extend("VoiceChatPromptFrame")
var11.validateProps = t.strictInterface({
    promptSignal = t.optional(t.RBXScriptSignal),
    errorText = t.optional(t.string),
    bannedUntil = t.optional(
        if FFlagVoiceChatBanDurationUseServerTime then t.interface({ minutes = t.number, absoluteSeconds = t.number }) else t.string
    ),
    onContinueFunc = t.optional(t.callback),
    onPrimaryActivated = t.optional(t.callback),
    onSecondaryActivated = t.optional(t.callback),
    onReadyForSignal = t.optional(t.callback),
    Analytics = t.optional(t.table),
    VoiceChatServiceManager = t.optional(t.table),
    showNewContent = t.optional(t.boolean),
    showCheckbox = t.optional(t.boolean),
    showDataConsentToast = t.optional(t.boolean),
    policyMapper = t.optional(t.callback),
    appStyle = validateStyle,
    settingsAppAvailable = t.optional(t.boolean),
    UserInputService = t.optional(t.table),
    lastInput = t.optional(t.string)
})

function var11.init(arg1)
    arg1.promptStyle = {
        Theme = arg1.props.appStyle.Theme,
        Font = arg1.props.appStyle.Font
    }

    arg1.state = {
        screenSize = Vector2.new(0, 0),
        promptType = PromptType.None,
        toastContent = nil,
        banEnd = "",
        showPrompt = true
    }

    arg1.ref = if GetFFlagSupportGamepadNavInVoiceModals() then Roact.createRef() else nil

    if arg1.props.showNewContent then
        local var12 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.MicUseSuspended")
        local var13 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.Subtitle.TemporarySuspension2")
        tbl1[PromptType.VoiceChatSuspendedTemporary] = var12
        tbl1[PromptType.VoiceChatSuspendedPermanent] = var12
        tbl2[PromptType.VoiceChatSuspendedTemporary] = var13
    end

    function arg1.onScreenSizeChanged(arg2)
        if arg1.state.screenSize ~= arg2.AbsoluteSize then
            arg1:setState({ screenSize = arg2.AbsoluteSize })
        end
    end

    function arg1.promptSignalCallback(arg2)
        promptSignalCallback(arg1, arg2)
    end

    function arg1.closeVoiceBanPrompt()
        arg1:setState({ showPrompt = false })

        if arg1.props.onContinueFunc then
            arg1.props.onContinueFunc()
        end
        ContextActionService:UnbindCoreAction("CloseVoiceBanPrompt")
        local bool3 = arg1.state.promptType == PromptType.VoiceChatSuspendedTemporaryB
        local var12 = GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2()
            and VoiceNudgeUseNewDACopy()
            and arg1.state.promptType == PromptType.VoiceChatSuspendedTemporaryBV2
        if bool1 then
            if PromptTypeIsBan(arg1.state.promptType) and not (bool3 or var12) then
                if arg1.props.Analytics then
                    arg1.props.Analytics:reportBanMessageEvent("Acknowledged")
                end
                if arg1.props.VoiceChatServiceManager then
                    arg1.props.VoiceChatServiceManager:reportBanMessage("Acknowledged")
                end
            end
        elseif not (bool3 or var12) then
            if arg1.props.Analytics then
                arg1.props.Analytics:reportBanMessageEvent("Acknowledged")
            end
            if arg1.props.VoiceChatServiceManager then
                arg1.props.VoiceChatServiceManager:reportBanMessage("Acknowledged")
            end
        end
    end

    function arg1.checkInputStateForClosePrompt(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            arg1.closeVoiceBanPrompt()
        end
    end

    function arg1.handlePrimayActivated()
        arg1.closeVoiceBanPrompt()
        if arg1.props.onPrimaryActivated then
            arg1.props.onPrimaryActivated()
        end
    end

    function arg1.handleSecondaryActivated()
        arg1.closeVoiceBanPrompt()
        if arg1.props.onSecondaryActivated then
            arg1.props.onSecondaryActivated()
        end
    end
end

function var11.render(arg1)
    local errorText = if GetFFlagEnableVoicePromptReasonText() then arg1.props.errorText or nil else nil
    local var12 = IsModalNudge(arg1.state.promptType)
    local var13 = arg1.state.promptType == PromptType.VoiceToxicityToast
        or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and arg1.state.promptType == PromptType.VoiceToxicityToastV2

    local bool3 = arg1.state.promptType == PromptType.VoiceChatSuspendedTemporaryB
    local var14 = GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2()
        and VoiceNudgeUseNewDACopy()
        and arg1.state.promptType == PromptType.VoiceChatSuspendedTemporaryBV2
    local var15 = GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2()
        and VoiceNudgeUseNewDACopy()
        and (arg1.state.promptType == PromptType.VoiceToxicityModalV2
            or arg1.state.promptType == PromptType.VoiceChatSuspendedTemporaryBV2)

    local bool4 = IsVoiceConsentModal(arg1.state.promptType)
    local var16 = GetFFlagShowDevicePermissionsModal() and not not IsDevicePermissionsModal(arg1.state.promptType)
    local automaticSizeY = Enum.AutomaticSize.Y

    if not PromptTypeIsModal(arg1.state.promptType) then
        if arg1.state.promptType == PromptType.JoinVoiceSTUX then
            return (Roact.createElement(VoiceChatTooltip, {
                titleText = tbl1[arg1.state.promptType],
                subtitleText = tbl2[arg1.state.promptType],
                promptStyle = arg1.promptStyle,
                showPrompt = arg1.state.showPrompt,
                onClose = function()
                    arg1:setState({ showPrompt = false })
                end,
                onMenuOpen = arg1.hideOnMenuOpen
            }))
        end

        local var17 = if var13 then GetFIntVoiceToxicityToastDurationSeconds() elseif arg1.state.promptType ~= PromptType.JoinedVoiceToast then 3 else GetFIntVoiceJoinM3ToastDurationSeconds()
        local showPrompt = arg1.state.showPrompt

        if arg1.state.promptType == PromptType.VoiceDataConsentOptOutToast and GetFFlagEnableSeamlessVoiceDataConsentToast() then
            if arg1.props.showDataConsentToast then
                showPrompt = arg1.props.showDataConsentToast
            else
                showPrompt = false
            end
        end
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            [Roact.Change.AbsoluteSize] = arg1.onScreenSizeChanged
        }
        local tbl4 = { Toast = 0, EventConnection = 0 }
        local var18

        if arg1.state.promptType == PromptType.None then
            var18 = false
        else
            local createElement2 = Roact.createElement
            local var19 = Toast
            local tbl5 = { duration = 0, toastContent = 0, show = 0 }
            if var13 then
                var17 = GetFIntVoiceToxicityToastDurationSeconds()
            end

            tbl5.duration = var17
            tbl5.toastContent = arg1.state.toastContent
            tbl5.show = showPrompt
            var18 = createElement2(var19, tbl5)
        end

        tbl4.Toast = var18

        tbl4.EventConnection = arg1.props.promptSignal
            and Roact.createElement(ExternalEventConnection, { event = arg1.props.promptSignal, callback = arg1.promptSignalCallback })
        return (createElement(str1, tbl3, tbl4))
    end

    local toastTitle = arg1.state.toastContent.toastTitle
    local font = arg1.promptStyle.Font.Header1.Font
    local var17 = arg1.promptStyle.Font.Header1.RelativeSize * arg1.promptStyle.Font.BaseSize
    local yOffset = 20 + GetTextSize(toastTitle, var17, font, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y
    local var18 = if FFlagVoiceChatBanDurationUseServerTime or bool3 or GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and var14 then arg1.state.banEnd else var3 .. arg1.state.banEnd
    local var19 = if arg1.state.banEnd ~= "" then "<b>" .. var18 .. "</b><br />" .. arg1.state.toastContent.toastSubtitle else arg1.state.toastContent.toastSubtitle .. arg1.state.banEnd
    local text = errorText or var19
    local font2 = arg1.promptStyle.Font.Body.Font
    local var21 = arg1.promptStyle.Font.Body.RelativeSize * arg1.promptStyle.Font.BaseSize
    local yOffset2 = 20 + GetTextSize(text, var21, font2, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y
    if bool3 or var14 then
        yOffset2 += 20
    end

    local var20 = if bool3 then var7 elseif GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and var14 then var9 else var2
    local yOffset3 = 20 + GetTextSize(var20, var21, font2, Vector2.new(325, math.huge), { addTemporaryPadding = false }).Y

    local var23 = ShouldShowSecondaryButton(arg1.state.promptType)
    local stop = if GetFFlagSupportGamepadNavInVoiceModals() then Enum.SelectionBehavior.Stop else nil
    local var24 = if GetFFlagSupportGamepadNavInVoiceModals() then true else nil
    local element

    if bool2 then
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl3 = {
            Size = nil,
            Size = nil,
            Size = nil,
            Size = nil,
            Size = nil,
            Size = UDim2.new(1, -5, 0, 48),
            LayoutOrder = 1,
            Text = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and VoiceNudgeUseNewDACopy() and var14 then var8 elseif GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2()
                and var12
                and VoiceNudgeUseNewDACopy()
                and arg1.state.promptType == PromptType.VoiceToxicityModalV2 then var8 elseif var12 then var5 else var4,
            [Roact.Event.Activated] = arg1.handlePrimayActivated
        }

        tbl3[Roact.Event.MouseEnter] = function(arg2)
            arg2.BackgroundColor3 = quillGrey
        end
        tbl3[Roact.Event.MouseLeave] = function(arg2)
            arg2.BackgroundColor3 = white
        end
        tbl3.Selectable = var24
        tbl3.BackgroundColor3 = white
        tbl3.BackgroundTransparency = 0
        tbl3.TextColor3 = Color3.fromRGB(0, 0, 0)
        tbl3.BorderSizePixel = 0
        tbl3.AutoButtonColor = false

        tbl3.Font = Enum.Font.BuilderSansBold
        tbl3.TextSize = 20
        element = createElement(str1, tbl3, { Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }) })
    else
        element = Roact.createElement(Button, {
            buttonType = ButtonType.PrimarySystem,
            layoutOrder = 1,
            size = UDim2.new(1, -5, 0, 48),
            text = if GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2() and VoiceNudgeUseNewDACopy() and var14 then var8 elseif GetFFlagVoiceChatDisruptiveVoiceNudgeEnableVariant2()
                and var12
                and VoiceNudgeUseNewDACopy()
                and arg1.state.promptType == PromptType.VoiceToxicityModalV2 then var8 elseif var12 then var5 else var4,
            onActivated = arg1.handlePrimayActivated,
            Selectable = var24
        })
    end

    local createElement = Roact.createElement
    local str1 = "ScreenGui"
    local tbl3 = {
        DisplayOrder = 8,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        Enabled = arg1.state.showPrompt,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl4 = {
        Overlay = Roact.createElement("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = arg1.promptStyle.Theme.Overlay.Color,
            BackgroundTransparency = arg1.promptStyle.Theme.Overlay.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Text = ""
        }),
        DialogMainFrame = 0
    }

    local createElement2 = Roact.createElement
    local imageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
    local tbl5 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Assets.Images.RoundedRect.Image,
        ImageColor3 = arg1.promptStyle.Theme.BackgroundUIDefault.Color,
        ImageTransparency = arg1.promptStyle.Theme.BackgroundUIDefault.Transparency,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        ScaleType = Assets.Images.RoundedRect.ScaleType,
        Size = UDim2.new(0, 365, 0, 55 + yOffset + 1 + yOffset2 + 14 + yOffset3 + 36 + 40),
        AutomaticSize = automaticSizeY,
        SliceCenter = Assets.Images.RoundedRect.SliceCenter,
        SelectionBehaviorDown = stop,
        SelectionBehaviorLeft = stop,
        SelectionBehaviorRight = stop,
        SelectionBehaviorUp = stop,
        SelectionGroup = var24,
        ref = if GetFFlagSupportGamepadNavInVoiceModals() then arg1.ref else nil
    }
    local tbl6 = {
        Padding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 20),
            PaddingBottom = UDim.new(0, 20),
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20)
        }),
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Icon = Roact.createElement(UIBlox.Core.ImageSet.ImageSetLabel, {
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = arg1.state.toastContent.iconImage,
            Size = UDim2.new(0, 55, 0, 55),
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }),
        TitleTextContainer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, yOffset),
                AutomaticSize = automaticSizeY
            },
            {
                TitleText = Roact.createElement(UIBlox.App.Text.StyledTextLabel, {
                    fontStyle = arg1.promptStyle.Font.Header1,
                    colorStyle = arg1.promptStyle.Theme.SystemPrimaryDefault,
                    textXAlignment = Enum.TextXAlignment.Center,
                    size = UDim2.new(1, 0, 1, 0),
                    text = toastTitle
                })
            }
        ),
        Divider = Roact.createElement("Frame", {
            BackgroundColor3 = arg1.promptStyle.Theme.Divider.Color,
            BackgroundTransparency = arg1.promptStyle.Theme.Divider.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = 3,
            Size = UDim2.new(0.8, 0, 0, 1)
        }),
        DividerSpaceContainer = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 7) }),
        BodyTextContainer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 5,
                Size = UDim2.new(1, 0, 0, yOffset2)
            },
            {
                BodyText = Roact.createElement(UIBlox.App.Text.StyledTextLabel, {
                    fontStyle = arg1.promptStyle.Font.Body,
                    colorStyle = arg1.promptStyle.Theme.TextDefault,
                    textXAlignment = Enum.TextXAlignment.Center,
                    size = UDim2.new(1, 0, 1, 0),
                    text = text
                })
            }
        ),
        TextSpaceContainer = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 7) }),
        SubBodyTextContainer = not var12
            and Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 7,
                    Size = UDim2.new(1, 0, 0, yOffset3),
                    AutomaticSize = automaticSizeY
                },
                {
                    BodyText = Roact.createElement(UIBlox.App.Text.StyledTextLabel, {
                        fontStyle = arg1.promptStyle.Font.Body,
                        colorStyle = arg1.promptStyle.Theme.TextDefault,
                        textXAlignment = Enum.TextXAlignment.Center,
                        size = UDim2.new(1, 0, 1, 0),
                        text = var20
                    })
                }
            ),
        SpaceContainer2 = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 8, Size = UDim2.new(1, 0, 0, 10) }),
        ButtonContainer = 0
    }
    local createElement3 = Roact.createElement
    local str2 = "Frame"
    local tbl7 = {
        BackgroundTransparency = 1,
        LayoutOrder = 9,
        Size = UDim2.new(1, 0, 0, 36),
        AutomaticSize = automaticSizeY
    }
    local tbl8 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 20),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        ConfirmButton = element,
        SecondaryButton = 0
    }
    var23 = var23
        and Roact.createElement(UIBlox.App.Button.LinkButton, {
            layoutOrder = if bool2 then 2 else 1,
            size = UDim2.new(1, -5, 0, 36),
            text = if var15 then var10 else var6,
            colorStyleDefault = "TextMuted",
            colorStyleHover = "TextMuted",
            onActivated = arg1.handleSecondaryActivated
        })
    tbl8.SecondaryButton = var23
    tbl6.ButtonContainer = createElement3(str2, tbl7, tbl8)
    tbl4.DialogMainFrame = createElement2(imageSetLabel, tbl5, tbl6)
    local element2 = createElement(str1, tbl3, tbl4)

    if var16 then
        element2 = Roact.createElement(DevicePermissionsModal, {
            titleText = tbl1[arg1.state.promptType],
            bodyText = tbl2[arg1.state.promptType],
            handlePrimaryActivated = arg1.handlePrimayActivated,
            handleSecondaryActivated = arg1.handleSecondaryActivated,
            Analytics = arg1.props.Analytics,
            promptStyle = arg1.promptStyle,
            showPrompt = arg1.state.showPrompt,
            settingsAppAvailable = arg1.props.settingsAppAvailable,
            UserInputService = if arg1.props.UserInputService ~= nil then arg1.props.UserInputService else UserInputService,
            ref = if GetFFlagSupportGamepadNavInVoiceModals() then arg1.ref else nil
        })
    end

    if bool4 then
        element2 = Roact.createElement(VoiceChatConsentModal, {
            titleText = tbl1[arg1.state.promptType],
            bodyText = tbl2[arg1.state.promptType],
            handlePrimaryActivated = arg1.handlePrimayActivated,
            handleSecondaryActivated = arg1.handleSecondaryActivated,
            Analytics = arg1.props.Analytics,
            showCheckbox = arg1.props.showCheckbox,
            promptStyle = arg1.promptStyle,
            showPrompt = arg1.state.showPrompt,
            ref = if GetFFlagSupportGamepadNavInVoiceModals() then arg1.ref else nil
        })
    end

    return (Roact.createElement(Roact.Portal, { target = CoreGui }, { InGameMenuInformationalDialog = element2 }))
end

function var11.didUpdate(arg1)
    if not GetFFlagSupportGamepadNavInVoiceModals() then
        return
    end

    if arg1.props.lastInput ~= Responsive.Input.Directional then
        if GuiService.SelectedCoreObject then
            GuiService.SelectedCoreObject = nil
        end

        return
    end

    local value = arg1.ref:getValue()

    if arg1.state.showPrompt and value then
        GuiService:Select(value)
    end

    if not arg1.state.showPrompt and value then
        GuiService.SelectedCoreObject = nil
    end
end

function var11.didMount(arg1)
    if arg1.props.onReadyForSignal then
        arg1.props.onReadyForSignal()
    end
    ContextActionService:BindCoreAction(
        "CloseVoiceBanPrompt",
        arg1.checkInputStateForClosePrompt,
        false,
        Enum.KeyCode.ButtonA
    )
    ContextActionService:BindCoreAction(
        "CloseVoiceBanPrompt",
        arg1.checkInputStateForClosePrompt,
        false,
        Enum.KeyCode.ButtonB
    )
end

local var12 = InGameMenuPolicy.connect(function(arg1, _)
    return {
        showNewContent = arg1.getGameInfoShowChatFeatures(),
        showCheckbox = arg1.getDisplayCheckboxInVoiceConsent(),
        showDataConsentToast = not (arg1.getDisplayCheckboxInVoiceConsent() == nil) and arg1.getDisplayCheckboxInVoiceConsent()
    }
end)(var11)

local function WrappedVoiceChatPromptFrame(arg1)
    local appStyle = useStyle()
    local var14 = if GetFFlagSupportGamepadNavInVoiceModals() then useLastInput() else nil
    local createElement = Roact.createElement
    local var15 = var12
    local join = Cryo.Dictionary.join
    local tbl3 = { appStyle = appStyle, lastInput = 0 }
    if not GetFFlagSupportGamepadNavInVoiceModals() then
        var14 = nil
    end

    tbl3.lastInput = var14
    return createElement(var15, join(arg1, tbl3))
end

return function(arg1)
    return renderWithCoreScriptsStyleProvider({ Roact.createElement(WrappedVoiceChatPromptFrame, arg1) })
end
