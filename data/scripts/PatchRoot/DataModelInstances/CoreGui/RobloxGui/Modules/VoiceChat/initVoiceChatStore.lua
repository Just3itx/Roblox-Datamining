-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Players = game:GetService("Players")

local FFlagEnableVoiceChatStorybookFix = require(RobloxGui.Modules.Flags.FFlagEnableVoiceChatStorybookFix)
local GetFFlagLocalMutedNilFix = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagLocalMutedNilFix

local VoiceEnabledChanged = require(script.Parent.Actions.VoiceEnabledChanged)
local VoiceStateChanged = require(script.Parent.Actions.VoiceStateChanged)
local ParticipantAdded = require(script.Parent.Actions.ParticipantAdded)
local ParticipantRemoved = require(script.Parent.Actions.ParticipantRemoved)
local PlayerRemoved = require(script.Parent.Actions.PlayerRemoved)

local default = require(script.Parent.VoiceChatServiceManager).default
local Constants = require(CorePackages.Workspace.Packages.VoiceChat).Constants
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local var1 = require(RobloxGui.Modules.VoiceChat.Logger)(script.Name)
local VOICE_STATE = if FFlagEnableVoiceChatStorybookFix() then Constants.VOICE_STATE else default.VOICE_STATE

local function shorten(userId: number): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return "..." .. string.sub(tostring(userId), -4)
end

local var2 = nil

local function setVoiceEnabled(voiceChatState, arg1)
    local str1 = tostring(Players.LocalPlayer.UserId)
    local bool1 = voiceChatState ~= Enum.VoiceChatState.Ended
    arg1:dispatch(VoiceEnabledChanged(bool1))

    if not var2[voiceChatState] then
        var1:warning("LOCAL_STATE_MAP does not exist for {} state", voiceChatState)
        arg1:dispatch(VoiceStateChanged(str1, VOICE_STATE.MUTED))
    else
        arg1:dispatch(VoiceStateChanged(str1, var2[voiceChatState]))
    end

    if voiceChatState ~= Enum.VoiceChatState.Failed then
        if voiceChatState == Enum.VoiceChatState.Joined
            and (if GetFFlagLocalMutedNilFix then default.localMuted == false else not default.localMuted)
        then
            arg1:dispatch(VoiceStateChanged(str1, VOICE_STATE.INACTIVE))
        end

        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        local str2 = tostring(player.UserId)
        if player ~= Players.LocalPlayer then
            arg1:dispatch(VoiceStateChanged(str2, VOICE_STATE.HIDDEN))
        end
    end
end

local function func1(arg1)
    var2 = {
        [Enum.VoiceChatState.Idle] = VOICE_STATE.HIDDEN,
        [Enum.VoiceChatState.Joining] = VOICE_STATE.CONNECTING,
        [Enum.VoiceChatState.JoiningRetry] = VOICE_STATE.CONNECTING,
        [Enum.VoiceChatState.Joined] = VOICE_STATE.MUTED,
        [Enum.VoiceChatState.Leaving] = VOICE_STATE.MUTED,
        [Enum.VoiceChatState.Ended] = VOICE_STATE.HIDDEN,
        [Enum.VoiceChatState.Failed] = VOICE_STATE.ERROR
    }

    local service = default:getService()
    if not service then
        var1:debug("VoiceChatService is not available")
        return
    end

    local userId = Players.LocalPlayer.UserId

    for _, player in pairs(Players:GetPlayers()) do
        var1:trace("Adding existing player {}", (shorten(player.UserId)))
        local var3 = ParticipantAdded
        local userId2 = player.UserId
        arg1:dispatch(var3(tostring(userId2)))
    end
    Players.PlayerAdded:Connect(function(player: Player)
        var1:trace("Adding joining player {}", (shorten(player.UserId)))
        arg1:dispatch(ParticipantAdded(tostring(player.userId)))
    end)

    Players.PlayerRemoving:Connect(function(player: Player)
        var1:trace("Removing player {}", (shorten(player.UserId)))

        arg1:dispatch(PlayerRemoved(tostring(player.userId)))
        arg1:dispatch(ParticipantRemoved(tostring(player.userId)))
    end)

    arg1:dispatch(VoiceStateChanged(userId, VOICE_STATE.HIDDEN))
    default.muteChanged.Event:Connect(function(arg2)
        var1:debug("Mute changed to {}", arg2)
        local var3 = arg2 and VOICE_STATE.MUTED or VOICE_STATE.INACTIVE
        arg1:dispatch(VoiceStateChanged(userId, var3))
    end)

    default.participantsUpdate.Event:Connect(function(arg2)
        for k, value in pairs(arg2) do
            local inactive = VOICE_STATE.INACTIVE
            if value.subscriptionFailed then
                inactive = VOICE_STATE.ERROR
            elseif not value.subscriptionCompleted then
                inactive = VOICE_STATE.CONNECTING
            elseif value.isMutedLocally then
                inactive = VOICE_STATE.LOCAL_MUTED
            elseif value.isMuted then
                inactive = VOICE_STATE.MUTED
            elseif value.isSignalActive then
                inactive = VOICE_STATE.TALKING
            end
            var1:trace("Participant update for {}, voice state {}", k, inactive)
            arg1:dispatch(VoiceStateChanged(k, inactive))
        end
    end)

    default.talkingChanged.Event:Connect(function(arg2)
        if arg2 then
            arg1:dispatch(VoiceStateChanged(userId, VOICE_STATE.TALKING))
            return
        end
        arg1:dispatch(VoiceStateChanged(userId, VOICE_STATE.INACTIVE))
    end)

    BlockingUtility:GetBlockedStatusChangedEvent():Connect(function(arg2, arg3)
        if arg3 then
            arg1:dispatch(ParticipantRemoved(tostring(arg2)))
            return
        end
        arg1:dispatch(ParticipantAdded(tostring(arg2)))
    end)

    var1:debug("Initial voice state is {}", service.VoiceChatState)
    setVoiceEnabled(service.VoiceChatState, arg1)
    service.StateChanged:Connect(function(_, arg2)
        var1:debug("Voice state changed to {}", arg2)
        setVoiceEnabled(arg2, arg1)
    end)
end

return function(arg1)
    if not game:GetEngineFeature("VoiceChatSupported") then
        return
    end

    default:asyncInit():andThen(function()
        default:SetupParticipantListeners()
        func1(arg1)
    end):catch(function()
        var1:warning("Failed to init VoiceChatServiceManager")
    end)
end
