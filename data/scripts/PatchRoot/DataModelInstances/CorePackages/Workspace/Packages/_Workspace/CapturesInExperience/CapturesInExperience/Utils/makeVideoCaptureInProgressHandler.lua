-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local default = require(scriptParentParentParent.VoiceChatCore).CoreVoiceManager.default
local default2 = require(scriptParentParentParent.VoiceChat).GlobalVoiceManager.default

local EventNames = require(scriptParentParent.Analytics.EventNames)
local VideoCaptureStarted = require(scriptParentParent.Actions.VideoCaptureStarted)
local VideoCaptureStopped = require(scriptParentParent.Actions.VideoCaptureStopped)
local _Types = require(scriptParentParent.Types)

local CaptureTriggerType = require(scriptParentParent.Enums.CaptureTriggerType)
local Constants = require(scriptParentParent.Constants)

local GetFFlagEnableVoiceChatMuteForVideoCaptures = require(scriptParentParentParent.SharedFlags).GetFFlagEnableVoiceChatMuteForVideoCaptures

local GetFFlagEnableCrossExperienceVoiceCaptureMute = require(scriptParentParentParent.SharedFlags).GetFFlagEnableCrossExperienceVoiceCaptureMute

local function maybeMuteVoiceChat(bool1: boolean)
    if game:GetEngineFeature("ReenableMomentsVoice") then
        return
    end
    if GetFFlagEnableCrossExperienceVoiceCaptureMute() then
        if bool1 then
            default2:MuteAll("Capture")
        else
            default2:UnmuteAll("Capture")
        end
    end
    if not default:UserVoiceEnabled() or not default:IsInitialized() then
        return
    end

    if not GetFFlagEnableCrossExperienceVoiceCaptureMute() then
        default:MuteAll(bool1, "Capture")
    end
    if not GetFFlagEnableVoiceChatMuteForVideoCaptures then
        return
    end

    if bool1 then
        default:RequestHidePublicVoiceUI()
        return
    end
    default:RequestShowPublicVoiceUI()
end

local function makeVideoCaptureInProgressHandler(arg1, _, callback: (...any) -> (...any))
    local function videoCaptureInProgressHandler(bool1: boolean, triggerType)
        local status = arg1:getState()[Constants.RoduxKey].IsVideoCaptureActive.status

        if bool1 and not status then
            arg1:dispatch(VideoCaptureStarted(triggerType))

            if triggerType == CaptureTriggerType.UserCapture or triggerType == CaptureTriggerType.DeveloperCapture then
                maybeMuteVoiceChat(true)
            end

            if triggerType == CaptureTriggerType.DeveloperCapture then
                callback(EventNames.CapturesVideoCaptureDevApiStarted)
            end

            callback(EventNames.CapturesVideoCaptureStarted, { triggerType = triggerType })
            return
        end
        if bool1 or not status then
            return
        end

        arg1:dispatch(VideoCaptureStopped(triggerType))

        if triggerType == CaptureTriggerType.UserCapture or triggerType == CaptureTriggerType.DeveloperCapture then
            maybeMuteVoiceChat(false)
        end

        if triggerType == CaptureTriggerType.DeveloperCapture then
            callback(EventNames.CapturesVideoCaptureDevApiEnded)
        end

        callback(EventNames.CapturesVideoCaptureStopped, { triggerType = triggerType })
    end

    return videoCaptureInProgressHandler
end

return makeVideoCaptureInProgressHandler
