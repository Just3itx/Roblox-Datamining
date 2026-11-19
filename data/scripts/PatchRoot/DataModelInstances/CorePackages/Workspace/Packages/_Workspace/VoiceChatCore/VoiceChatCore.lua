-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreVoiceManager = require(script.CoreVoiceManager)
local MicInputManager = require(script.MicInputManager)
local Analytics = require(script.Analytics)
local Constants = require(script.Constants)
local VoiceVolumeControlsEligibility = require(script.VoiceVolumeControlsEligibility)
local Requests = script.Requests
local Flags = script.Flags

return {
    CoreVoiceManager = CoreVoiceManager,
    MicInputManager = MicInputManager,
    Constants = Constants,
    Analytics = Analytics,
    VoiceVolumeControlsEligibility = VoiceVolumeControlsEligibility,
    Flags = {
        GetFFlagVoiceChatServiceManagerUseAvatarChat = require(Flags.GetFFlagVoiceChatServiceManagerUseAvatarChat),
        GetFFlagBatchVoiceParticipantsUpdates = require(Flags.GetFFlagBatchVoiceParticipantsUpdates),
        GetFIntThrottleParticipantsUpdateMs = require(Flags.GetFIntThrottleParticipantsUpdateMs),
        GetFFlagEnableFtuxExitOnMuteToggle = require(Flags.GetFFlagEnableFtuxExitOnMuteToggle),
        GetFFlagEnableSeamlessVoiceFeature = require(Flags.GetFFlagEnableSeamlessVoiceFeature),
        GetFFlagFixGetPlayerByUserIdStringCast = require(Flags.GetFFlagFixGetPlayerByUserIdStringCast),
        GetFFlagVoiceVolumeControlsEnableVoiceVolumeImpressionsTelemetry = require(Flags.GetFFlagVoiceVolumeControlsEnableVoiceVolumeImpressionsTelemetry),
        GetFFlagMicConsumerRegistry = require(Flags.GetFFlagMicConsumerRegistry),
        GetFFlagCoreMicManagerRefactor = require(Flags.GetFFlagCoreMicManagerRefactor),
        FFlagMicSyncVoiceDeviceAcrossRejoin = require(Flags.FFlagMicSyncVoiceDeviceAcrossRejoin)
    },
    Requests = {
        GetShowAgeVerificationOverlay = require(Requests.GetShowAgeVerificationOverlay)
    },
    ["jest.config"] = script["jest.config"]
}
