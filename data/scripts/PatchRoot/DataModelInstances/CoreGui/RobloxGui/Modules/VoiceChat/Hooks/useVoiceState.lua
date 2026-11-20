-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local blockedStatusChangedEvent = require(CorePackages.Workspace.Packages.BlockingUtility):GetBlockedStatusChangedEvent()
local default = require(script.Parent.Parent.VoiceChatServiceManager).default
local VoiceStateContext = require(RobloxGui.Modules.VoiceChat.VoiceStateContext)
local VOICE_STATE = require(CorePackages.Workspace.Packages.VoiceChat).Constants.VOICE_STATE

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end
local UserId = LocalPlayer and LocalPlayer.UserId or 0

local var1 = not game:GetEngineFeature("VoiceChatSupported")
    and { Idle = 1, Joining = 2, JoiningRetry = 3, Joined = 4, Leaving = 5, Ended = 6, Failed = 7 }
    or Enum.VoiceChatState

local tbl1 = {
    [var1.Idle] = VOICE_STATE.HIDDEN,
    [var1.Joining] = VOICE_STATE.CONNECTING,
    [var1.JoiningRetry] = VOICE_STATE.CONNECTING,
    [var1.Joined] = VOICE_STATE.MUTED,
    [var1.Leaving] = VOICE_STATE.MUTED,
    [var1.Ended] = VOICE_STATE.HIDDEN,
    [var1.Failed] = VOICE_STATE.ERROR
}

local function mapVoiceChatStateToVoiceState(voiceState) -- Luacid: Inlined by compiler; 1 call site recovered
    return if tbl1[voiceState] then tbl1[voiceState] else VOICE_STATE.MUTED
end

local function mapParticipantStateToVoiceState(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local inactive = VOICE_STATE.INACTIVE
    if arg1.subscriptionFailed then
        return VOICE_STATE.ERROR
    end

    if not arg1.subscriptionCompleted then
        return VOICE_STATE.CONNECTING
    end

    if arg1.isMutedLocally then
        return VOICE_STATE.LOCAL_MUTED
    end

    if arg1.isMuted then
        return VOICE_STATE.MUTED
    end

    if arg1.isSignalActive then
        inactive = VOICE_STATE.TALKING
    end
    return inactive
end

local function useVoiceState(bool1: boolean, bool2: boolean?, arg1)
    local var2 = arg1 and arg1.voiceChatServiceManager or default
    local var3 = React.useContext(VoiceStateContext.Context)
    local var4, var5 = React.useState(VOICE_STATE.HIDDEN)

    React.useEffect(function()
        if not var3.voiceEnabled or not bool1 or bool2 then
            var5(VOICE_STATE.HIDDEN)
            return function() end
        end

        local var6 = tonumber(bool1)
        local str1 = tostring(bool1)

        local bool3 = UserId == var6
        local var7 = nil
        local tbl2 = {}
        local bool4 = false

        local function updateVoiceState(arg2) -- Luacid: Inlined by compiler; 10 call sites recovered
            if not bool4 then
                var5(arg2)
            end
        end

        local function setVoiceEnabled(voiceState)
            local var8 = var4

            if bool3 then
                var8 = mapVoiceChatStateToVoiceState(voiceState)
            else
                local participant = var2.participants[str1]
                if participant and not var7 then
                    var8 = mapParticipantStateToVoiceState(participant)
                end
            end

            if voiceState == var1.Failed then
                if not bool3 then
                    var8 = VOICE_STATE.HIDDEN
                end
            elseif voiceState == var1.Joined and not var2.localMuted and bool3 then
                if var2.isTalking then
                    var8 = VOICE_STATE.TALKING
                elseif var2.localMuted then
                    var8 = VOICE_STATE.MUTED
                else
                    var8 = VOICE_STATE.INACTIVE
                end
            end

            updateVoiceState(var8)
        end

        setVoiceEnabled(var3.voiceState)

        delay(0, function()
            if bool4 then
                return
            end
            setVoiceEnabled(var3.voiceState)

            if bool3 then
                local tbl3 = tbl2
                local event = var2.talkingChanged.Event

                table.insert(tbl3, event:Connect(function(arg2)
                    local var8 = if arg2 then VOICE_STATE.TALKING else VOICE_STATE.INACTIVE
                    updateVoiceState(var8)
                end))

                local tbl4 = tbl2
                local event2 = var2.muteChanged.Event

                table.insert(tbl4, event2:Connect(function(arg2)
                    local var8 = if arg2 then VOICE_STATE.MUTED else VOICE_STATE.INACTIVE
                    updateVoiceState(var8)
                end))

                return
            end

            local tbl3 = tbl2
            local event = var2.participantsUpdate.Event

            table.insert(tbl3, event:Connect(function(arg2)
                local var8 = arg2[str1]
                if var8 and not var7 then
                    updateVoiceState((mapParticipantStateToVoiceState(var8)))
                    return
                end

                updateVoiceState(VOICE_STATE.HIDDEN)
            end))

            local tbl4 = tbl2
            local event2 = var2.participantLeft.Event

            table.insert(tbl4, event2:Connect(function(_, arg2)
                if arg2 == var6 then
                    updateVoiceState(VOICE_STATE.HIDDEN)
                end
            end))

            local tbl5 = tbl2
            local event3 = var2.participantJoined.Event

            table.insert(tbl5, event3:Connect(function(_, arg2)
                if arg2 == var6 then
                    updateVoiceState(VOICE_STATE.HIDDEN)
                end
            end))

            table.insert(tbl2, blockedStatusChangedEvent:Connect(function(arg2, arg3)
                if var6 ~= arg2 then
                    return
                end

                if arg3 then
                    var7 = true
                    updateVoiceState(VOICE_STATE.HIDDEN)
                    return
                end
                var7 = nil
                local participant = var2.participants[str1]
                if participant then
                    updateVoiceState((mapParticipantStateToVoiceState(participant)))
                    return
                end

                updateVoiceState(VOICE_STATE.HIDDEN)
            end))
        end)

        return function()
            bool4 = true

            delay(0, function()
                for _, value in tbl2 do
                    value:disconnect()
                end
            end)
        end
    end, { bool1, var3.voiceState, bool2 == true })

    return var4
end

return useVoiceState
