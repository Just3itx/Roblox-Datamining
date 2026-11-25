-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreGui = game:GetService("CoreGui")

local PeopleService = script:FindFirstAncestor("PeopleService")
local PeopleServiceParent = PeopleService.Parent

local Flags = require(PeopleService.Flags)

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = Flags.FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry
local FFlagVoiceVolumeControlsPerUserPlayerListButton = Flags.FFlagVoiceVolumeControlsPerUserPlayerListButton
local FFlagVoiceVolumeControlsPerUserPlayerGridMenu = Flags.FFlagVoiceVolumeControlsPerUserPlayerGridMenu

local VoiceVolumeControlsEligibility = require(PeopleServiceParent.VoiceChatCore).VoiceVolumeControlsEligibility

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local bool1 = false
local bool2 = false
local bool3 = false
local var1 = nil
local var2 = nil
local connection = nil

local function getVoiceChatServiceManager() -- Luacid: Inlined by compiler; 1 call site recovered
    local robloxGui = CoreGui:WaitForChild("RobloxGui")
    return require(robloxGui:WaitForChild("Modules"):WaitForChild("VoiceChat"):WaitForChild("VoiceChatServiceManager")).default
end

local function getPlaySessionId() -- Luacid: Inlined by compiler; 3 call sites recovered
    if engineFeature then
        return RbxAnalyticsService:GetPlaySessionId()
    end
    return nil
end

local function getVoiceSessionId(arg1) -- Luacid: unused: defined but never referenced
    local sessionId = nil
    return if pcall(function()
        sessionId = arg1:GetSessionId()
    end) and sessionId ~= nil and sessionId ~= "" then sessionId else nil
end

local function beginSession(voiceChatServiceManager) -- Luacid: Inlined by compiler; 3 call sites recovered
    if bool2 then
        return
    end
    bool2 = true
    bool3 = VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(true, VoiceChatService.UseNewAudioApi)
    local sessionId = nil

    var1 = if pcall(function()
        sessionId = voiceChatServiceManager:GetSessionId()
    end) and sessionId ~= nil and sessionId ~= "" then sessionId else nil
    if bool3 then
        require(PeopleService.Analytics.PeopleAnalyticsManager):resetPerUserVoiceVolumeSession()
    end
end

local function flushSession() -- Luacid: Inlined by compiler; 2 call sites recovered
    if not bool2 then
        return
    end
    bool2 = false

    if not bool3 then
        bool3 = false
        var1 = nil
        return
    end

    require(PeopleService.Analytics.PeopleAnalyticsManager):flushPerUserVoiceVolumeSession(getPlaySessionId(), var1)

    bool3 = false
    var1 = nil
end

local function tryBeginIfJoined(voiceChatServiceManager) -- Luacid: Inlined by compiler; 1 call site recovered
    local service = voiceChatServiceManager:getService()
    if (service and service.VoiceChatState) == Enum.VoiceChatState.Joined then
        beginSession(voiceChatServiceManager)
    end
end

return {
    ensureStarted = function()
        if bool1
            or not FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry
            or not FFlagVoiceVolumeControlsPerUserPlayerListButton and not FFlagVoiceVolumeControlsPerUserPlayerGridMenu
            or not game:GetEngineFeature("VoiceChatSupported")
        then
            return
        end

        bool1 = true

        task.defer(function()
            local default = getVoiceChatServiceManager()
            local localPlayer = Players.LocalPlayer
            if localPlayer then
                connection = Players.PlayerRemoving:Connect(function(player: Player)
                    if player ~= localPlayer then
                        return
                    end

                    flushSession()
                end)
            end

            default:asyncInit():andThen(function()
                var2 = function(_, voiceChatState)
                    if voiceChatState == Enum.VoiceChatState.Joined then
                        beginSession(default)
                    elseif voiceChatState == Enum.VoiceChatState.Ended or voiceChatState == Enum.VoiceChatState.Failed then
                        flushSession()
                    end
                end

                default:subscribe("OnStateChanged", var2)

                tryBeginIfJoined(default)
            end):catch(function() end)
        end)
    end
}
