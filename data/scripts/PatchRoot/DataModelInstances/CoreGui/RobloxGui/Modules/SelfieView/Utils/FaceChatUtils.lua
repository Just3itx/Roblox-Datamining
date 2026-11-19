-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarChatService = game:GetService("AvatarChatService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local getCamMicPermissions = require(RobloxGui.Modules.Settings.getCamMicPermissions)

local CorePackages = game:GetService("CorePackages")
local default = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled

local bool1 = game:DefineFastFlag("DisableCameraOnSelfieViewForLowspecDevices", false)

local function func1(): boolean
    return true
end

if bool1 then
    func1 = require(RobloxGui.Modules.Settings.isCamEnabledForUserAndPlace)
end

local FaceAnimatorService = game:GetService("FaceAnimatorService")

local var1 = nil
local function getPermissions()
    if var1 ~= nil then
        return var1
    end

    if not GetFFlagAvatarChatServiceEnabled() or _G.__TESTEZ_RUNNING_TEST__ then
        return {
            placeCamEnabled = false,
            placeMicEnabled = false,
            userCamEnabled = false,
            userCamEligible = false,
            userMicEnabled = false,
            userMicEligible = false
        }
    end

    local success, result = pcall(AvatarChatService.GetClientFeaturesAsync, AvatarChatService)

    if not success then
        warn("Unable to get Client Features from AvatarChatService")
        return {
            placeCamEnabled = false,
            placeMicEnabled = false,
            userCamEnabled = false,
            userCamEligible = false,
            userMicEnabled = false,
            userMicEligible = false
        }
    end

    local tbl1 = {
        placeMicEnabled = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.PlaceAudio),
        userMicEnabled = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserAudio),
        userMicEligible = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserAudioEligible),
        placeCamEnabled = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.PlaceVideo),
        userCamEnabled = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserVideo),
        userCamEligible = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserVideoEligible)
    }

    if bool1 and tbl1.placeCamEnabled and tbl1.userCamEligible and tbl1.userCamEnabled and not func1() then
        tbl1.userCamEnabled = false
    end

    var1 = tbl1
    return tbl1
end

local function getTrackerMode()
    if FaceAnimatorService.AudioAnimationEnabled and not FaceAnimatorService.VideoAnimationEnabled then
        return Enum.TrackerMode.Audio
    end

    if FaceAnimatorService.AudioAnimationEnabled
        or not (FaceAnimatorService.VideoAnimationEnabled and FaceAnimatorService:IsStarted())
    then
        if FaceAnimatorService.AudioAnimationEnabled
            and FaceAnimatorService.VideoAnimationEnabled
            and FaceAnimatorService:IsStarted()
        then
            return Enum.TrackerMode.AudioVideo
        end

        return Enum.TrackerMode.None
    end

    return Enum.TrackerMode.Video
end

return {
    getPermissions = getPermissions,
    toggleVideoAnimation = function()
        getCamMicPermissions(function()
            if not (FaceAnimatorService and FaceAnimatorService:IsStarted()) then
                return
            end

            if not bool1 or getPermissions().userCamEnabled then
                FaceAnimatorService.VideoAnimationEnabled = not FaceAnimatorService.VideoAnimationEnabled
            end
        end, { default.Permissions.CAMERA_ACCESS })
    end,
    getTrackerMode = getTrackerMode,
    isCameraOn = function(): boolean
        local trackerMode = getTrackerMode()
        return trackerMode == Enum.TrackerMode.AudioVideo or trackerMode == Enum.TrackerMode.Video
    end
}
