-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarChatService = game:GetService("AvatarChatService")
local CoreGui = game:GetService("CoreGui")
local VideoCaptureService = game:GetService("VideoCaptureService")
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled
local getFFlagUseCameraDevicesListener = require(RobloxGui.Modules.Flags.getFFlagUseCameraDevicesListener)
local cameraDevicesHelper = require(RobloxGui.Modules.Settings.cameraDevicesHelper)

return function(): boolean
    if not GetFFlagAvatarChatServiceEnabled() then
        return false
    end
    local success, result = pcall(AvatarChatService.GetClientFeaturesAsync, AvatarChatService)

    if not success then
        warn("Unable to get Client Features from AvatarChatService")
        return false
    end

    local isEnabled = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.PlaceVideo)
    local isEnabled2 = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserVideo)
    local isEnabled3 = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserVideoEligible)
    local isEnabled4 = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.PlaceAudio)
    local isEnabled5 = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserAudio)
    local isEnabled6 = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UserAudioEligible)
    local var1 = if getFFlagUseCameraDevicesListener() then cameraDevicesHelper.GetDevices() else VideoCaptureService:GetCameraDevices()
    return not Cryo.isEmpty(var1)
        and (if isEnabled then not (isEnabled4 and isEnabled5 and isEnabled6) and not not (isEnabled2 and isEnabled3) else false)
end
