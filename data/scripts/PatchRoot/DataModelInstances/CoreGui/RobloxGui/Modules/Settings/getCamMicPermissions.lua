-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RunService = game:GetService("RunService")
local VideoCaptureService = game:GetService("VideoCaptureService")

local Cryo = require(CorePackages.Packages.Cryo)
local default = require(CorePackages.Workspace.Packages.PermissionsProtocol).PermissionsProtocol.default

local cameraDevicePermissionGrantedSignal = require(CoreGui.RobloxGui.Modules.Settings.cameraDevicePermissionGrantedSignal)

local MicrophoneDevicePermissionsLogging = require(CoreGui.RobloxGui.Modules.Settings.Resources.MicrophoneDevicePermissionsLogging)

local Promise = require(CorePackages.Packages.Promise)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled

local getFFlagEnableAnalyticsForCameraDevicePermissions = require(RobloxGui.Modules.Flags.getFFlagEnableAnalyticsForCameraDevicePermissions)

local GetFFlagJoinWithoutMicPermissions = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagJoinWithoutMicPermissions

local bool1 = game:DefineFastFlag("CheckCameraAvailabilityBeforePermissions", false)
local bool2 = game:DefineFastFlag("DebugSkipVoicePermissionCheck", false)
local AvatarChatService = if GetFFlagAvatarChatServiceEnabled() then game:GetService("AvatarChatService") else nil
local var1 = nil
local bool3 = nil
local tbl1 = {}
local bool4 = false

local function removePermissionsBasedOnUserSetting(tbl2, tbl3, shouldNotRequestPerms: boolean?)
    if not tbl2.isCameraEnabled and Cryo.List.find(tbl3, default.Permissions.CAMERA_ACCESS) then
        tbl3 = Cryo.List.removeValue(tbl3, default.Permissions.CAMERA_ACCESS)
    end

    if GetFFlagJoinWithoutMicPermissions() then
        if not tbl2.isVoiceEnabled and Cryo.List.find(tbl3, default.Permissions.MICROPHONE_ACCESS) or shouldNotRequestPerms == nil then
            tbl3 = Cryo.List.removeValue(tbl3, default.Permissions.MICROPHONE_ACCESS)
        end
    elseif not tbl2.isVoiceEnabled and Cryo.List.find(tbl3, default.Permissions.MICROPHONE_ACCESS) then
        tbl3 = Cryo.List.removeValue(tbl3, default.Permissions.MICROPHONE_ACCESS)
    end

    if bool2 and Cryo.List.find(tbl3, default.Permissions.MICROPHONE_ACCESS) then
        tbl3 = Cryo.List.removeValue(tbl3, default.Permissions.MICROPHONE_ACCESS)
    end

    if bool1 and Cryo.List.find(tbl3, default.Permissions.CAMERA_ACCESS) then
        local cameraDevices = VideoCaptureService:GetCameraDevices()
        if Cryo.isEmpty(cameraDevices) then
            tbl3 = Cryo.List.removeValue(tbl3, default.Permissions.CAMERA_ACCESS)
        end
    end

    return tbl3
end

local function requestPermissions(tbl2, callback, callback2, arg1: {[any]: any} | {any}, shouldNotRequestPerms: boolean?, uiContext: string?)
    local bool5 = Cryo.List.find(arg1, default.Permissions.CAMERA_ACCESS) ~= nil
    local bool6 = Cryo.List.find(arg1, default.Permissions.MICROPHONE_ACCESS) ~= nil

    local var2 = removePermissionsBasedOnUserSetting(tbl2, arg1, shouldNotRequestPerms)
    local hasCameraPermissions = Cryo.List.find(var2, default.Permissions.CAMERA_ACCESS) ~= nil
    local hasMicPermissions = Cryo.List.find(var2, default.Permissions.MICROPHONE_ACCESS) ~= nil

    if not var2 or #var2 <= 0 then
        callback({ hasCameraPermissions = false, hasMicPermissions = false })
        bool4 = false
        callback2()
        return
    end

    if shouldNotRequestPerms == true then
        return Promise.new(function(callback3, _)
            local tbl3 = ({})

            for _, value in ipairs(var2) do
                local var3, var4 = default:hasPermissions({ value }):await()
                if var3 then
                    tbl3[value] = var4.status == default.Status.AUTHORIZED
                else
                    tbl3[value] = false
                end
            end

            local tbl4 = {
                hasCameraPermissions = tbl3[default.Permissions.CAMERA_ACCESS] or false,
                hasMicPermissions = tbl3[default.Permissions.MICROPHONE_ACCESS] or false
            }

            callback(tbl4)
            bool4 = false
            callback2()

            callback3(tbl3)
        end)
    else
        return default:hasPermissions(var2):andThen(function(arg2)
            if arg2.status == default.Status.AUTHORIZED then
                callback({ hasCameraPermissions = hasCameraPermissions, hasMicPermissions = hasMicPermissions })
                bool4 = false
                callback2()
                return arg2
            end
            if hasMicPermissions and uiContext then
                MicrophoneDevicePermissionsLogging:logPromptImpression({ didAuthorize = false, uiContext = uiContext })
            end

            return default:requestPermissions(var2):andThen(function(authorized)
                if typeof(authorized) == "table" then
                    local bool9 = hasCameraPermissions
                        and (authorized.status == default.Status.AUTHORIZED
                            or not Cryo.List.find(authorized.missingPermissions, default.Permissions.CAMERA_ACCESS))

                    local bool10 = hasMicPermissions
                        and (authorized.status == default.Status.AUTHORIZED
                            or not Cryo.List.find(authorized.missingPermissions, default.Permissions.MICROPHONE_ACCESS))

                    if not bool5 then
                        bool9 = nil
                    end

                    var1 = bool9
                    if not bool6 then
                        bool10 = nil
                    end

                    bool3 = bool10

                    if var1 then
                        cameraDevicePermissionGrantedSignal:fire()
                    end
                elseif authorized == default.Status.AUTHORIZED then
                    cameraDevicePermissionGrantedSignal:fire()
                    var1 = hasCameraPermissions
                    bool3 = hasMicPermissions
                else
                    var1 = false
                    bool3 = false
                end

                local tbl3 = {
                    hasCameraPermissions = var1 or false,
                    hasMicPermissions = bool3 or false
                }

                if getFFlagEnableAnalyticsForCameraDevicePermissions() and hasCameraPermissions then
                    local didAuthorize = var1 or false
                    local target = if RunService:IsStudio() then "studio" else "client"
                    RbxAnalyticsService:SendEventDeferred(
                        target,
                        "avatarChat",
                        "CameraDevicePermissionPrompted",
                        { didAuthorize = didAuthorize }
                    )
                end

                if hasMicPermissions and uiContext then
                    MicrophoneDevicePermissionsLogging:logPromptInteraction({ didAuthorize = bool3, uiContext = uiContext })
                end

                callback(tbl3)
                bool4 = false
                callback2()

                return authorized
            end)
        end)
    end
end

local function tryGetCachedResults(arg1: {[any]: any} | {any})
    if bool2 then
        bool3 = true
    end

    if var1 == nil or bool3 == nil then
        return nil
    end

    local bool5 = false
    for _, value in arg1 do
        if value ~= default.Permissions.MICROPHONE_ACCESS and value ~= default.Permissions.CAMERA_ACCESS then
            bool5 = true
        end
    end

    return if bool5 then nil else {
        hasCameraPermissions = var1 or false,
        hasMicPermissions = bool3 or false
    }
end

local function getCamMicPermissions(callback, permissionsToRequest, shouldNotRequestPerms: boolean?, context: string?, getRawPermission: boolean?)
    local var2 = permissionsToRequest or { default.Permissions.MICROPHONE_ACCESS, default.Permissions.CAMERA_ACCESS }

    local function invokeNextRequest() -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl1[1] then
            local var3 = tbl1[1]
            table.remove(tbl1, 1)
            getCamMicPermissions(
                var3.callback,
                var3.permissionsToRequest,
                var3.shouldNotRequestPerms,
                var3.context,
                var3.getRawPermission
            )
        end
    end

    if not getRawPermission then
        local var3 = tryGetCachedResults(var2)
        if var3 then
            callback(var3)
            invokeNextRequest()
            return
        end
    end

    if bool4 then
        table.insert(tbl1, {
            callback = callback,
            permissionsToRequest = permissionsToRequest,
            shouldNotRequestPerms = shouldNotRequestPerms,
            context = context,
            getRawPermission = getRawPermission
        })

        return
    end

    bool4 = true

    if getRawPermission then
        return default:hasPermissions(var2):andThen(function(arg1)
            callback(arg1)
            bool4 = false
            invokeNextRequest()
        end)
    elseif GetFFlagAvatarChatServiceEnabled() then
        return Promise.new(function(callback2, _)
            if AvatarChatService.ClientFeaturesInitialized then
                callback2({
                    isVoiceEnabled = AvatarChatService:IsEnabled(AvatarChatService.ClientFeatures, Enum.AvatarChatServiceFeature.UserAudio),
                    isCameraEnabled = AvatarChatService:IsEnabled(AvatarChatService.ClientFeatures, Enum.AvatarChatServiceFeature.UserVideo)
                })
                return
            end
            local connection = nil
            connection = AvatarChatService:GetPropertyChangedSignal("ClientFeatures"):Connect(function()
                connection:Disconnect()
                local tbl2 = {
                    isVoiceEnabled = AvatarChatService:IsEnabled(AvatarChatService.ClientFeatures, Enum.AvatarChatServiceFeature.UserAudio),
                    isCameraEnabled = AvatarChatService:IsEnabled(AvatarChatService.ClientFeatures, Enum.AvatarChatServiceFeature.UserVideo)
                }

                callback2(tbl2)
            end)
        end):andThen(function(arg1)
            requestPermissions(arg1, callback, invokeNextRequest, var2, shouldNotRequestPerms, context)
        end)
    end

    return Promise.new(function(callback2, _)
        callback2({ isVoiceEnabled = false, isCameraEnabled = false })
    end)
end

return getCamMicPermissions
