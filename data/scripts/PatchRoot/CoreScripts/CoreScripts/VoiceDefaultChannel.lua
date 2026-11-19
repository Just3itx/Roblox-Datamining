-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")

local RobloxGui = CoreGui.RobloxGui
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local default2 = require(CorePackages.Workspace.Packages.CallProtocol).CallProtocol.default
local Enums = require(CorePackages.Workspace.Packages.CallProtocol).Enums

local bool1 = game:DefineFastFlag("DebugDefaultChannelStartMuted", true)
local bool2 = game:DefineFastFlag("UseNotificationServiceIsConnected", false)
local bool3 = game:DefineFastFlag("DefaultChannelEnableDefaultVoice", true)
local GetFFlagSeamlessVoiceFTUX = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagSeamlessVoiceFTUX

local _engineFeature = game:GetEngineFeature("VoiceServiceGenerateDefaultChannelAvailable")
local engineFeature = game:GetEngineFeature("VoiceServiceEnableDefaultVoiceAvailable")
local engineFeature2 = game:GetEngineFeature("NotificationServiceIsConnectedAvailable")

local var1 = require(RobloxGui.Modules.VoiceChat.Logger)(script.Name)
local var2 = require(RobloxGui.Modules.VoiceChat.Analytics).new()

local VoiceChatService = game:GetService("VoiceChatService")

local function initializeDefaultChannel(arg1)
    local service = default:getService()

    if not service then
        return nil
    end

    var1:info("Joining default channel")

    local var3 = service:JoinByGroupIdToken("default", arg1)
    if var3 then
        var2:reportVoiceChatJoinResult(true, "defaultJoinSuccess")
    else
        var2:reportVoiceChatJoinResult(false, "defaultJoinFailed", "error")
    end

    return var3
end

if engineFeature2 and bool2 then
    if not NotificationService.IsConnected then
        var1:debug("NotificationService is not yet connected")
        NotificationService:GetPropertyChangedSignal("IsConnected"):Wait()
    end
    var1:debug("NotificationService connected")
end

if not VoiceChatService.UseNewAudioApi then
    if not Players.LocalPlayer.Character then
        Players.LocalPlayer.CharacterAdded:Wait()
        var1:debug("Player character loaded")
    else
        var1:debug("Player character already loaded")
    end
end

if engineFeature and bool3 then
    local var3 = game:FindService("VoiceChatService")
    if not var3 then
        var1:info("VoiceChatService not found. Assuming default values.")
    elseif not (var3.EnableDefaultVoice or var3.UseNewAudioApi) then
        var1:debug("Default channel is disabled.")
        var2:reportVoiceChatJoinResult(false, "defaultDisabled")
        return
    end
end

default2:getCallState():andThen(function(arg1)
    local var3 = if arg1.status ~= Enums.CallStatus.Idle.rawValue() and arg1.status ~= Enums.CallStatus.Ringing.rawValue() then arg1.muted else bool1

    default:asyncInit():andThen(function()
        if initializeDefaultChannel(var3) == false then
            default:InitialJoinFailedPrompt()
        end
    end):catch(function()
        var1:info("VoiceChatServiceManager did not initialize")
    end)
end)

if GetFFlagSeamlessVoiceFTUX() then
    task.spawn(function()
        default:VoiceChatFirstTimeUX(game:GetService("AppStorageService"))
    end)
end
