-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarChatService = game:GetService("AvatarChatService")
local AppStorageService = game:GetService("AppStorageService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local VideoCaptureService = game:GetService("VideoCaptureService")
local Cryo = require(CorePackages.Packages.Cryo)
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local IXPService = game:GetService("IXPService")
local MemStorageService = game:GetService("MemStorageService")

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled
local getFFlagUseCameraDevicesListener = require(RobloxGui.Modules.Flags.getFFlagUseCameraDevicesListener)
local cameraDevicesHelper = require(RobloxGui.Modules.Settings.cameraDevicesHelper)

local TrackerMenu = require(RobloxGui.Modules.Tracker.TrackerMenu)
local TrackerPromptType = require(RobloxGui.Modules.Tracker.TrackerPromptType)

local bool1 = game:DefineFastFlag("DisableCameraOnLowSpecDevices2", false)
local layerName = game:DefineFastString("DisableCameraOnLowSpecDevicesIXPLayer", "AvatarChat.DisableOnLowSpecAndroid")
local str1 = game:DefineFastString("DisableCameraOnLowSpecDevicesIXPField", "DisableOnAndroid")
local bool2 = game:DefineFastFlag("OnlyShowToastOnce2", false)
local bool3 = game:DefineFastFlag("DebugAlwaysShowDisableCameraToast", false)
local bool4 = game:DefineFastFlag("OnlyShowToastOnceInLifetime2", false)
local engineFeature = game:GetEngineFeature("DisableCameraToastShownStorageKey")

local function ShouldCheckDeviceSpecs()
    if not bool1 then
        return false
    end

    local success, result = pcall(function()
        return IXPService:GetUserLayerVariables(layerName)
    end)

    if not success or not result or result[str1] == nil then
        return false
    end

    IXPService:LogUserLayerExposure(layerName)
    return result[str1]
end

return function()
    if not GetFFlagAvatarChatServiceEnabled() or _G.__TESTEZ_RUNNING_TEST__ then
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

    if not bool1
        or not isEnabled
        or not isEnabled2
        or not isEnabled3
        or AvatarChatService:deviceMeetsRequirementsForFeature(Enum.DeviceFeatureType.DeviceCapture)
        or not ShouldCheckDeviceSpecs()
    then
        local var1 = if getFFlagUseCameraDevicesListener() then cameraDevicesHelper.GetDevices() else VideoCaptureService:GetCameraDevices()
        local bool5 = not Cryo.isEmpty(var1)
        return isEnabled and isEnabled3 and isEnabled2 and bool5
    end

    if bool4 and engineFeature then
        local success2, result2 = pcall(function(): string
            return AppStorageService:GetItem("DisableCameraToastShown")
        end)

        if not success2 or result2 ~= "true" or bool3 then
            TrackerMenu:showPrompt(TrackerPromptType.CameraUnavailable)
            pcall(function()
                AppStorageService:SetItem("DisableCameraToastShown", "true")
                AppStorageService:Flush()
            end)
        end
    elseif bool2 then
        if MemStorageService:GetItem("DisableCameraToastShown") ~= "true" or bool3 then
            TrackerMenu:showPrompt(TrackerPromptType.CameraUnavailable)
            MemStorageService:SetItem("DisableCameraToastShown", "true")
        end
    else
        TrackerMenu:showPrompt(TrackerPromptType.CameraUnavailable)
    end
    return false
end
