-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local VoiceChatService = game:GetService("VoiceChatService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)

local Modules = CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules")
local VoiceChat = Modules:WaitForChild("VoiceChat")
local Flags = Modules:WaitForChild("Flags")

local default = require(VoiceChat:WaitForChild("VoiceChatServiceManager")).default
local Constants = require(VoiceChat:WaitForChild("Constants"))
local VOICE_STATE = Constants.VOICE_STATE

local var1 = require(scriptParentParentParent.ExpChat).Stores.GetVoiceStore(false)

local var2 = require(scriptParentParentParent.CoreScriptsInitializer).CoreLogger:new(script.Name)

local GetFFlagVoiceChatUILogging = require(Flags:WaitForChild("GetFFlagVoiceChatUILogging"))
local GetFFlagNewPeoplePageIcons = require(scriptParentParent.Flags).GetFFlagNewPeoplePageIcons
local GetFFlagAddPeoplePageCardLayout = require(scriptParentParent.Flags).GetFFlagAddPeoplePageCardLayout

local FFlagVoiceVolumeControlsPerUserPlayerListButton = require(scriptParentParent.Flags).FFlagVoiceVolumeControlsPerUserPlayerListButton
local FFlagVoiceVolumeControlsPerUserPlayerGridMenu = require(scriptParentParent.Flags).FFlagVoiceVolumeControlsPerUserPlayerGridMenu
local FFlagVoiceChatVolumePerUserMuteVolumeSync = require(scriptParentParent.Flags).FFlagVoiceChatVolumePerUserMuteVolumeSync

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = require(scriptParentParent.Flags).FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry

local VoiceVolumeControlsEligibility = require(scriptParentParentParent.VoiceChatCore).VoiceVolumeControlsEligibility

local bool1 = game:DefineFastFlag("LuaFlagVoiceChatDisableSubscribeRetryForMultistream", true)

local engineFeature = game:GetEngineFeature("VoiceChatMultistreamSubscriptionsEnabled")

local Constants2 = require(scriptParentParent.Constants)
local FRAME_BUFFER = Constants2.VOICE_CHAT.MIC_ANIMATION.FRAME_BUFFER
local ICONS = Constants2.VOICE_CHAT.ICONS
local VOICE_VOLUME = Constants2.VOICE_CHAT.VOICE_VOLUME

local PlayerMuteStatusIcons = default.PlayerMuteStatusIcons

local function createPeopleVoiceChatStore()
    local voiceChatServiceConnected, var4 = Signals.createSignal(false)
    local voiceUiVisible, var6 = Signals.createSignal(false)
    local localMuted, var8 = Signals.createSignal(nil)
    local localTalking, var10 = Signals.createSignal(false)

    local var11 = nil
    local var12 = nil
    if FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu then
        local var13
        var11, var13 = Signals.createSignal(false)
        var12 = var13
    end
    local var13 = FFlagVoiceVolumeControlsPerUserPlayerListButton and {} or FFlagVoiceVolumeControlsPerUserPlayerGridMenu and {} or nil

    local var14 = nil

    local var15, var16 = Signals.createSignal(0)
    local var17, var18 = Signals.createSignal(0)

    local num1 = 0

    local connection = nil

    local function startMicAnimation() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection then
            return
        end

        connection = RunService.RenderStepped:Connect(function()
            if localTalking(false) then
                num1 += 1
                if FRAME_BUFFER < num1 then
                    local num2 = math.random()
                    var16(num2)
                    num1 = 0
                end
            else
                num1 += 1
                if FRAME_BUFFER < num1 then
                    local num2 = math.random()
                    var18(num2)
                    num1 = 0
                end
            end
        end)
    end

    local function stopMicAnimation() -- Luacid: Inlined by compiler; 3 call sites recovered
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end

    local function getMuteSelfIcon()
        return Signals.createComputed(function(arg1)
            local var19 = localMuted(arg1)
            local var20 = localTalking(arg1)

            if var19 == nil then
                return PlayerMuteStatusIcons.Loading
            end

            if var19 then
                return PlayerMuteStatusIcons.MicOff
            end

            if not var20 then
                return PlayerMuteStatusIcons.MicOn
            end

            local num2 = math.floor(0.5 + 5 * var15(arg1)) * 20
            return (default:GetIcon("Unmuted" .. tostring(num2), "MicLight"))
        end)
    end

    local allPlayersMuted = Signals.createComputed(function(arg1)
        if not (voiceChatServiceConnected(arg1) and default.voiceUIVisible) then
            return false
        end

        local voiceParticipants = var1.getVoiceParticipants(arg1)
        if not voiceParticipants then
            return false
        end

        local bool2 = true
        for k, voiceParticipant in pairs(voiceParticipants) do
            local var19 = tonumber(k)

            if var19 and Players.LocalPlayer and var19 ~= Players.LocalPlayer.UserId and voiceParticipant ~= VOICE_STATE.LOCAL_MUTED then
                return false
            end
        end

        return bool2
    end)

    local var19 = nil
    var19 = FFlagVoiceChatVolumePerUserMuteVolumeSync and function(num2: number, bool2: boolean)
        local var20 = tonumber(num2)
        if not var20 then
            return
        end

        local coreVoiceManager = default.coreVoiceManager
        if not bool2 and coreVoiceManager and coreVoiceManager.muteAll then
            coreVoiceManager.muteAll = false
            if coreVoiceManager.muteAllChanged then
                coreVoiceManager.muteAllChanged:Fire(false)
            end

            local tbl1 = {}
            local localPlayer = Players.LocalPlayer
            for _, player in Players:GetPlayers() do
                if localPlayer and player.UserId ~= localPlayer.UserId and player.UserId ~= var20 then
                    table.insert(tbl1, player.UserId)
                end
            end
            if #tbl1 > 0 then
                default:ToggleMuteSome(tbl1, true, Constants.VOICE_GROUP_TYPE.ALL, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)
            end
        end

        default:ToggleMuteSome({ var20 }, bool2, Constants.VOICE_GROUP_TYPE.ALL, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)

        if bool2 then
            return
        end

        local player = Players:GetPlayerByUserId(var20)
        if player and player.VoiceChatVolume == VOICE_VOLUME.MIN then
            player.VoiceChatVolume = VOICE_VOLUME.DEFAULT
        end
    end or var19

    local function toggleMuteAll()
        if not voiceChatServiceConnected(false) then
            return
        end

        local bool2 = not allPlayersMuted(false)
        default:MuteAll(bool2, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)

        if not FFlagVoiceChatVolumePerUserMuteVolumeSync or bool2 then
            return
        end

        local localPlayer = Players.LocalPlayer
        for _, player in Players:GetPlayers() do
            if localPlayer and player.UserId ~= localPlayer.UserId and player.VoiceChatVolume == VOICE_VOLUME.MIN then
                player.VoiceChatVolume = VOICE_VOLUME.DEFAULT
            end
        end
    end

    local function toggleMuteSelf()
        if not voiceChatServiceConnected(false) then
            return
        end

        default:ToggleMic("InGameMenuPlayers")
    end

    local function SubscribeRetry(num2: number)
        if not voiceChatServiceConnected(false) then
            return
        end

        default:SubscribeRetry(num2)
    end

    local function getPlayerMuteState(num2: number)
        return Signals.createComputed(function(arg1): boolean
            local var20 = var1.getOrCreateVoiceState(num2)(arg1)
            return if var20 then var20 == VOICE_STATE.LOCAL_MUTED or var20 == VOICE_STATE.MUTED else false
        end)
    end

    local function togglePlayerMute(num2: number)
        if not voiceChatServiceConnected(false) or not voiceUiVisible(false) then
            return
        end

        local participant = default.participants[tostring(num2)]
        if participant and participant.subscriptionCompleted then
            if FFlagVoiceChatVolumePerUserMuteVolumeSync and var19 then
                local bool2 = var1.getOrCreateVoiceState(num2)(false) == VOICE_STATE.LOCAL_MUTED
                var19(num2, not bool2)
                return
            end

            default:ToggleMutePlayer(tonumber(num2), Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)
            return
        end

        if participant and participant.subscriptionFailed then
            if not bool1 then
                default:SubscribeRetry(num2)
                return
            end

            if not engineFeature then
                default:SubscribeRetry(num2)
            end
        else
            if FFlagVoiceChatVolumePerUserMuteVolumeSync and var19 then
                local bool2 = var1.getOrCreateVoiceState(num2)(false) == VOICE_STATE.LOCAL_MUTED
                var19(num2, not bool2)
                return
            end
            default:ToggleMutePlayer(tonumber(num2), Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)
        end
    end

    local function getPlayerShouldShowMuteButton(userId: number)
        return Signals.createComputed(function(arg1): boolean
            return if voiceUiVisible(arg1) and (not Players.LocalPlayer or userId ~= Players.LocalPlayer.UserId) then var1.getOrCreateVoiceState(userId)(arg1) ~= nil else false
        end)
    end

    local function getPlayerAnimatedIcon(num2: number)
        return Signals.createComputed(function(arg1)
            local var20 = var1.getOrCreateVoiceState(num2)(arg1)
            if not var20 then
                return ICONS.DEFAULT_SPEAKER
            end

            if var20 == VOICE_STATE.LOCAL_MUTED or var20 == VOICE_STATE.MUTED then
                return if GetFFlagNewPeoplePageIcons() then ICONS.MUTED_SPEAKER else ICONS.SPEAKER_OFF
            end
            if var20 ~= VOICE_STATE.TALKING then
                return ICONS.DEFAULT_SPEAKER
            end

            local num3 = math.floor(0.5 + 5 * var17(arg1)) * 20
            return string.format(ICONS.ANIMATED_SPEAKER_FORMAT, num3)
        end)
    end

    local function getPlayerIsLocalMuted(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
        return Signals.createComputed(function(arg1): boolean
            return if num2 then var1.getOrCreateVoiceState(num2)(arg1) == VOICE_STATE.LOCAL_MUTED else false
        end)
    end

    local var20 = GetFFlagAddPeoplePageCardLayout() and function(num2: number)
        return Signals.createComputed(function(arg1): boolean
            return var1.getOrCreateVoiceState(num2)(arg1) == VOICE_STATE.TALKING
        end)
    end or nil

    local function updateVolumeControlEligibility(arg1)
        if not game:IsLoaded() then
            var12(false)
            return
        end

        local service = default:getService()
        local bool2 = (arg1 or service and service.VoiceChatState) == Enum.VoiceChatState.Joined
        var12(VoiceVolumeControlsEligibility.isVoiceChatVolumeSliderVisible(bool2, VoiceChatService.UseNewAudioApi))
    end

    local function getPlayerVoiceVolume(userId: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu then
            local player = Players:GetPlayerByUserId(userId)
            if player then
                return if FFlagVoiceChatVolumePerUserMuteVolumeSync and var1.getOrCreateVoiceState(userId)(false) == VOICE_STATE.LOCAL_MUTED then VOICE_VOLUME.MIN else player.VoiceChatVolume
            end
        end

        return VOICE_VOLUME.DEFAULT
    end

    local function subscribePlayerVoiceVolume(userId: number, callback: (...any) -> (...any))
        if not (FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu) then
            return function() end
        end
        local player = Players:GetPlayerByUserId(userId)
        if not player then
            return function() end
        end
        local connection2 = player:GetPropertyChangedSignal("VoiceChatVolume"):Connect(function()
            callback((getPlayerVoiceVolume(userId)))
        end)

        local effect = nil
        if FFlagVoiceChatVolumePerUserMuteVolumeSync then
            local playerIsLocalMuted = getPlayerIsLocalMuted(userId)

            effect = Signals.createEffect(function(arg1)
                playerIsLocalMuted(arg1)
                callback((getPlayerVoiceVolume(userId)))
            end)
        end

        return function()
            connection2:Disconnect()
            if effect then
                effect()
            end
        end
    end

    local function setPlayerVoiceVolume(userId: number, num2: number)
        if not FFlagVoiceVolumeControlsPerUserPlayerListButton and not FFlagVoiceVolumeControlsPerUserPlayerGridMenu then
            return
        end

        local player = Players:GetPlayerByUserId(userId)
        if not player then
            return
        end
        if not FFlagVoiceChatVolumePerUserMuteVolumeSync or not var19 then
            player.VoiceChatVolume = math.clamp(num2, VOICE_VOLUME.MIN, VOICE_VOLUME.MAX)
            return
        end

        local bool2 = var1.getOrCreateVoiceState(userId)(false) == VOICE_STATE.LOCAL_MUTED
        local voiceChatVolume = math.clamp(num2, VOICE_VOLUME.MIN, VOICE_VOLUME.MAX)
        if voiceChatVolume == VOICE_VOLUME.MIN then
            player.VoiceChatVolume = VOICE_VOLUME.MIN
            if not bool2 then
                var19(userId, true)
            end
        else
            player.VoiceChatVolume = voiceChatVolume
            if bool2 then
                var19(userId, false)
            end
        end
    end

    local function getVoiceSessionId()
        local sessionId = nil
        return if pcall(function()
            sessionId = default:GetSessionId()
        end) and sessionId ~= nil and sessionId ~= "" then sessionId else nil
    end

    local function cleanup()
        stopMicAnimation()

        if not FFlagVoiceVolumeControlsPerUserPlayerListButton and not FFlagVoiceVolumeControlsPerUserPlayerGridMenu then
            return
        end

        if var14 then
            default:unsubscribe("OnStateChanged", var14)
            var14 = nil
        end

        local var21 = var13
        for _, value in var21 do
            value:Disconnect()
        end
        table.clear(var21)
    end

    local function initializeVoiceChat()
        if not game:GetEngineFeature("VoiceChatSupported") then
            return
        end

        default:asyncInit():andThen(function()
            var4(true)
            default:SetupParticipantListeners()

            for k, _ in pairs(default.participants) do
                local localPlayer = Players.LocalPlayer
                if not localPlayer then
                    continue
                end

                local userId = localPlayer.UserId

                if k ~= tostring(userId) then
                    var1.handleVoiceParticipantAdded(k)
                end
            end

            if default.participants and next(default.participants) then
                var1.handleVoiceParticipantsChanged(default.participants)
            end

            default.muteChanged.Event:Connect(function(arg1)
                var8(arg1)
            end)

            default.talkingChanged.Event:Connect(function(arg1)
                var10(arg1)
            end)

            var8(default.localMuted)
            var10(default.isTalking)

            default.participantsUpdate.Event:Connect(function(arg1)
                var1.handleVoiceParticipantsChanged(arg1)
            end)

            default.participantJoined.Event:Connect(function(_, arg1)
                var1.handleVoiceParticipantAdded(tostring(arg1))
            end)

            default.participantLeft.Event:Connect(function(_, arg1)
                var1.handleVoiceParticipantRemoved(tostring(arg1))
            end)

            default.showVoiceUI.Event:Connect(function()
                var6(true)
                startMicAnimation()
            end)

            default.hideVoiceUI.Event:Connect(function()
                var6(false)
                stopMicAnimation()
            end)

            if default.voiceUIVisible then
                var6(true)
            end

            startMicAnimation()

            if not FFlagVoiceVolumeControlsPerUserPlayerListButton and not FFlagVoiceVolumeControlsPerUserPlayerGridMenu then
                return
            end

            local var21 = var13

            var14 = function(_, arg1)
                updateVolumeControlEligibility(arg1)
            end
            default:subscribe("OnStateChanged", var14)

            local function subscribeToEligibilityProperty(property: string) -- Luacid: Inlined by compiler; 2 call sites recovered
                local success, result = pcall(function(): RBXScriptConnection
                    return VoiceChatService:GetPropertyChangedSignal(property):Connect(function()
                        updateVolumeControlEligibility()
                    end)
                end)
                if success then
                    table.insert(var21, result)
                end
            end

            subscribeToEligibilityProperty("UseNewAudioApi")
            subscribeToEligibilityProperty("EnableVoiceVolumeControls")

            if game:IsLoaded() then
                updateVolumeControlEligibility()
                return
            end
            local loaded = game.Loaded
            table.insert(var21, loaded:Connect(updateVolumeControlEligibility))
        end):catch(function(_)
            if GetFFlagVoiceChatUILogging() then
                var2:warning("Failed to init VoiceChatServiceManager")
            end

            stopMicAnimation()
        end)
    end

    initializeVoiceChat()

    if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then
        require(scriptParentParent.Analytics.PerUserVoiceVolumeSessionLifecycle).ensureStarted()
    end

    local tbl1 = {
        voiceChatServiceConnected = voiceChatServiceConnected,
        voiceUIVisible = voiceUiVisible,
        allPlayersMuted = allPlayersMuted,
        voiceParticipants = var1.getVoiceParticipants,
        localMuted = localMuted,
        localTalking = localTalking,
        toggleMuteAll = toggleMuteAll,
        toggleMuteSelf = toggleMuteSelf,
        SubscribeRetry = SubscribeRetry,
        getPlayerMuteState = getPlayerMuteState,
        togglePlayerMute = togglePlayerMute,
        getPlayerShouldShowMuteButton = getPlayerShouldShowMuteButton,
        getPlayerAnimatedIcon = getPlayerAnimatedIcon,
        getPlayerIsLocalMuted = getPlayerIsLocalMuted,
        getPlayerIsTalking = 0,
        getMuteSelfIcon = 0,
        getShowVolumeControl = 0,
        getPlayerVoiceVolume = 0,
        subscribePlayerVoiceVolume = 0,
        setPlayerVoiceVolume = 0,
        getVoiceSessionId = 0,
        cleanup = 0
    }

    if not GetFFlagAddPeoplePageCardLayout() then
        var20 = nil
    end

    tbl1.getPlayerIsTalking = var20
    tbl1.getMuteSelfIcon = getMuteSelfIcon
    if not (FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu) then
        var11 = nil
    end

    tbl1.getShowVolumeControl = var11

    tbl1.getPlayerVoiceVolume = if FFlagVoiceVolumeControlsPerUserPlayerListButton then getPlayerVoiceVolume elseif FFlagVoiceVolumeControlsPerUserPlayerGridMenu then getPlayerVoiceVolume else nil

    if not (FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu) then
        subscribePlayerVoiceVolume = nil
    end

    tbl1.subscribePlayerVoiceVolume = subscribePlayerVoiceVolume

    if not (FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu) then
        setPlayerVoiceVolume = nil
    end

    tbl1.setPlayerVoiceVolume = setPlayerVoiceVolume

    if not (FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry
        and (FFlagVoiceVolumeControlsPerUserPlayerListButton or FFlagVoiceVolumeControlsPerUserPlayerGridMenu)) then
        getVoiceSessionId = nil
    end

    tbl1.getVoiceSessionId = getVoiceSessionId

    tbl1.cleanup = cleanup
    return tbl1
end

return (createPeopleVoiceChatStore())
