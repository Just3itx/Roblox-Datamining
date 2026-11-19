-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _VRService = game:GetService("VRService")

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AppStorageService = game:GetService("AppStorageService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local _RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local RobloxGui = CoreGui.RobloxGui
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper

local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local default = require(CorePackages.Workspace.Packages.CallProtocol).CallProtocol.default
local Enums = require(CorePackages.Workspace.Packages.CallProtocol).Enums

local engineFeature = game:GetEngineFeature("LoadStreamAnimationReplaceErrorsWithTelemetryFeature")

local engineFeature2 = game:GetEngineFeature("FaceAnimatorNotifyLODRecommendCameraInputDisable")

local bool1 = game:DefineFastFlag("FacialAnimationStreamingClearTrackImprovementsV2", false)
game:DefineFastFlag("FacialAnimationStreamingValidateAnimatorBeforeRemoving", false)
game:DefineFastFlag("FacialAnimationStreamingSearchForReplacementWhenRemovingAnimator", false)
game:DefineFastFlag("StopStreamTrackOnDeath", false)
game:DefineFastFlag("FacialAnimationStreamingClearAllConnectionsFix2", false)
game:DefineFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C", false)

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled
local AvatarChatService = if GetFFlagAvatarChatServiceEnabled() then game:GetService("AvatarChatService") else nil
local FaceAnimatorService = game:GetService("FaceAnimatorService")
local bool2 = game:DefineFastFlag("UXForCameraPerformanceEnabled", false)
local bool3 = game:DefineFastFlag("DisableCameraOnLowspecAndroidCalls", false)

local num1 = game:DefineFastInt("UXForCameraPerformanceSessionDelay", 300)
local num2 = game:DefineFastInt("UXForCameraPerformanceDeviceDelay", 43200)

local GetFFlagUXForCameraPerformanceIXPEnabled = require(RobloxGui.Modules.Flags.GetFFlagUXForCameraPerformanceIXPEnabled)

local GetFStringUXForCameraPerformanceIXPLayerName = require(RobloxGui.Modules.Flags.GetFStringUXForCameraPerformanceIXPLayerName)

local function func1(): boolean
    return true
end

if bool3 then
    func1 = require(RobloxGui.Modules.Settings.isCamEnabledForUserAndPlace)
end

local FacialAnimationStreamingHeartbeatStats = require(RobloxGui.Modules.FacialAnimationStreaming.FacialAnimationStreamingHeartbeatStats)

if not (FaceAnimatorService and AvatarChatService) then
    return
end

FaceAnimatorService.FlipHeadOrientation = true

local EmoteHelper = require(RobloxGui.Modules.Emote.EmoteHelper)
local TrackerMenu = require(RobloxGui.Modules.Tracker.TrackerMenu)
local TrackerPromptType = require(RobloxGui.Modules.Tracker.TrackerPromptType)
local default2 = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local tbl1 = {
    CharacterAdded = "CharacterAdded",
    CharacterRemoving = "CharacterRemoving",
    CharacterDescendantAdded = "CharacterDescendantAdded",
    CharacterDescendantRemoving = "CharacterDescendantRemoving",
    AnimatorDataModelReady = "AnimatorDataModelReady",
    PlayerEmoted = "PlayerEmoted",
    PlayerChatted = "PlayerChatted",
    EmoteFinished = "EmoteFinished",
    PlayerDied = "PlayerDied"
}
RobloxTranslator:FormatByKey("Feature.FaceChat.Message.PlaceUnavailable")
local bool4 = false

local startTime = os.time()

local tbl2 = {}

local tbl3 = {}

local tbl4 = {}
local tbl5 = {}
local tbl6 = {}
local tbl7 = {}

local connection = nil
local connection2 = nil
local connection3 = nil

local connection4 = nil
local connection5 = nil

local function playerTrace(str1: string, player: Player) -- Luacid: Inlined by compiler; 30 call sites recovered
    local id = ""
    local name = ""
    if player then
        if player.UserId then
            id = tostring(player.UserId)
        end
        if player.Name then
            name = player.Name
        end
    end
    var1:trace(string.format("%s {id: %s, name: %s}.", str1, id, name))
end

local function clearConnection(player: Player, arg1) -- Luacid: Inlined by compiler; 16 call sites recovered
    if tbl5[player.UserId] and tbl5[player.UserId][arg1] then
        tbl5[player.UserId][arg1]:Disconnect()
        tbl5[player.UserId][arg1] = nil
    end
end

local function clearAllConnections(player: Player)
    if game:GetFastFlag("FacialAnimationStreamingClearAllConnectionsFix2") then
        for _, value in pairs(tbl1) do
            clearConnection(player, value)
        end
    else
        for _, value in ipairs(tbl1) do
            clearConnection(player, value)
        end
    end

    tbl5[player.UserId] = {}
end

local function clearCharacterAnimations(player: Player)
    playerTrace("clearCharacterAnimations", player)

    if not tbl4[player.UserId] then
        return
    end

    if bool1 then
        if tbl4[player.UserId].animationTrack then
            tbl4[player.UserId].animationTrack:Stop(0)
            tbl4[player.UserId].animationTrack = nil
        end
        if tbl4[player.UserId].animation then
            tbl4[player.UserId].animation = nil
        end
    else
        if tbl4[player.UserId].animation then
            tbl4[player.UserId].animation:Destroy()
            tbl4[player.UserId].animation = nil
        end
        if tbl4[player.UserId].animationTrack then
            tbl4[player.UserId].animationTrack:Stop(0)
            tbl4[player.UserId].animationTrack:Destroy()
            tbl4[player.UserId].animationTrack = nil
        end
    end

    tbl4[player.UserId] = nil
end

local function getPlayerFaceControls(player: Player) -- Luacid: Inlined by compiler; 2 call sites recovered
    if player and player.Character then
        return player.Character:FindFirstChildWhichIsA("FaceControls", true)
    end

    return nil
end

local function getPlayerHumanoid(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1.Character then
        return arg1.Character:FindFirstChildOfClass("Humanoid")
    end

    return nil
end

local function getPlayerAnimator(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
    local playerHumanoid = getPlayerHumanoid(player)

    if playerHumanoid then
        return playerHumanoid:FindFirstChildOfClass("Animator")
    end

    return nil
end

local function pauseStreamingAnimationForPlayer(player: Player) -- Luacid: Inlined by compiler; 6 call sites recovered
    if tbl4[player.UserId] and tbl4[player.UserId].animationTrack then
        playerTrace("Pausing facial streaming animations...", player)
        tbl4[player.UserId].animationTrack:AdjustWeight(0.1, 0.5)
    end
end

local function resumeStreamingAnimationForPlayer(player: Player) -- Luacid: Inlined by compiler; 4 call sites recovered
    if tbl4[player.UserId] and tbl4[player.UserId].animationTrack then
        playerTrace("Resuming facial streaming animations...", player)
        tbl4[player.UserId].animationTrack:AdjustWeight(1, 0.5)
    end
end

local function updateStreamTrackStatus() -- Luacid: Inlined by compiler; 2 call sites recovered
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end

    if FaceAnimatorService.AudioAnimationEnabled or FaceAnimatorService.VideoAnimationEnabled then
        resumeStreamingAnimationForPlayer(localPlayer)
    else
        pauseStreamingAnimationForPlayer(localPlayer)
    end
end

local function handleEmote(player: Player, arg1, bool5: boolean)
    playerTrace(string.format("handleEmote {isChatTriggered:%s}", tostring(bool5)), player)
    if not arg1 then
        return
    end
    clearConnection(player, tbl1.EmoteFinished)
    pauseStreamingAnimationForPlayer(player)

    tbl5[player.UserId][tbl1.EmoteFinished] = EmoteHelper.createEmoteFinishEvent(player, arg1, bool5):Connect(function()
        clearConnection(player, tbl1.EmoteFinished)

        if FaceAnimatorService.AudioAnimationEnabled or FaceAnimatorService.VideoAnimationEnabled then
            resumeStreamingAnimationForPlayer(player)

            return
        end

        pauseStreamingAnimationForPlayer(player)
    end)
end

local function onPlayerChatted(player: Player, message: string)
    if not getPlayerHumanoid(player) then
        return
    end

    local var2 = nil
    if string.sub(message, 1, 3) == "/e " then
        var2 = string.sub(message, 4)
    elseif string.sub(message, 1, 7) == "/emote " then
        var2 = string.sub(message, 8)
    end

    if not var2 or not EmoteHelper.LegacyDefaultEmotes[var2] then
        return
    end
    wait(EmoteHelper.EMOTE_LOOP_TRANSITION_WAIT_TIME)
    local anyActiveDefaultChatTriggeredEmoteTrack = EmoteHelper.getAnyActiveDefaultChatTriggeredEmoteTrack(player)
    if anyActiveDefaultChatTriggeredEmoteTrack then
        handleEmote(player, anyActiveDefaultChatTriggeredEmoteTrack, true)
    end
end

local function onAnimatorAdded(player: Player, animator)
    if not animator then
        return
    end

    if not (animator.Parent and animator.Parent:IsA("Humanoid")) then
        return
    end

    if tbl4[player.UserId] then
        playerTrace("onAnimatorAdded already done; skipping", player)
        return
    end

    clearConnection(player, tbl1.AnimatorDataModelReady)

    local function func2()
        local tbl8 = {
            animation = Instance.new("TrackerStreamAnimation")
        }

        if game:GetEngineFeature("UseNewLoadStreamAnimationAPI") then
            tbl8.animationTrack = animator:LoadStreamAnimationV2(tbl8.animation, player)
        else
            tbl8.animationTrack = animator:LoadStreamAnimation(tbl8.animation)
        end

        if engineFeature and not tbl8.animationTrack then
            return
        end

        tbl8.animationTrack.Priority = Enum.AnimationPriority.Idle
        tbl8.animationTrack:Play(0.1, 1)

        tbl4[player.UserId] = tbl8
        local bool5 = FaceAnimatorService.AudioAnimationEnabled or FaceAnimatorService.VideoAnimationEnabled
        if player == Players.LocalPlayer and not bool5 then
            pauseStreamingAnimationForPlayer(player)
        end

        if game:GetFastFlag("FacialAnimationStreamingValidateAnimatorBeforeRemoving") then
            tbl6[player.UserId] = animator
        end
    end

    if animator:IsDescendantOf(game) then
        func2()
        return
    end

    tbl5[player.UserId][tbl1.AnimatorDataModelReady] = animator.AncestryChanged:Connect(function(_: Instance, _: Instance)
        if animator:IsDescendantOf(game) then
            clearConnection(player, tbl1.AnimatorDataModelReady)
            func2()
        end
    end)
end

local function onHumanoidAdded(player: Player, arg1)
    if not arg1 then
        return
    end

    clearConnection(player, tbl1.PlayerEmoted)
    tbl5[player.UserId][tbl1.PlayerEmoted] = arg1.EmoteTriggered:Connect(function(success: boolean, animationTrack: AnimationTrack)
        if success then
            handleEmote(player, animationTrack, false)
        end
    end)

    if game:GetFastFlag("StopStreamTrackOnDeath") then
        clearConnection(player, tbl1.PlayerDied)
        tbl5[player.UserId][tbl1.PlayerDied] = arg1.Died:Connect(function()
            clearCharacterAnimations(player)
        end)
    end
end

local function onFaceControlsAdded(player: Player, arg1)
    assert(game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C"))

    if player ~= Players.LocalPlayer or tbl7[player.UserId] ~= nil and arg1 == tbl7[player.UserId] then
        return
    end

    tbl7[player.UserId] = arg1

    if tbl7[player.UserId] then
        if default2 and default2.localMuted == false then
            playerTrace("FaceControls found -> enabling A2C (Mic is ON)...", player)
            FaceAnimatorService.AudioAnimationEnabled = true
            return
        end

        playerTrace("FaceControls found -> won't enable A2C (Mic is MUTED)...", player)
    elseif FaceAnimatorService.AudioAnimationEnabled then
        playerTrace("FaceControls NOT found -> disabling A2C...", player)
        FaceAnimatorService.AudioAnimationEnabled = false
    else
        playerTrace("FaceControls NOT found -> won't disable A2C (already is disabled)...", player)
    end
end

local function onCharacterDescendantAdded(player: Player, arg1: Instance)
    if not arg1:IsDescendantOf(game) then
        return
    end

    if arg1:IsA("Animator") then
        onAnimatorAdded(player, arg1)
        return
    end

    if arg1:IsA("Humanoid") then
        onHumanoidAdded(player, arg1)
        return
    end
    if game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C") and arg1:IsA("MeshPart") and arg1.Name == "Head" then
        onFaceControlsAdded(player, getPlayerFaceControls(player))
        return
    end
    if game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C") and arg1:IsA("FaceControls") then
        onFaceControlsAdded(player, arg1)
    end
end

local function onCharacterDescendantRemoving(player: Player, arg1: Instance)
    if not arg1:IsA("Animator") then
        if arg1:IsA("Humanoid") then
            clearConnection(player, tbl1.PlayerEmoted)
            if game:GetFastFlag("StopStreamTrackOnDeath") then
                clearConnection(player, tbl1.PlayerDied)
            end
        elseif game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C")
            and (arg1:IsA("MeshPart") and arg1.Name == "Head" or arg1:IsA("FaceControls"))
        then
            onFaceControlsAdded(player, getPlayerFaceControls(player))
        end

        return
    end

    if not game:GetFastFlag("FacialAnimationStreamingValidateAnimatorBeforeRemoving") then
        clearConnection(player, tbl1.AnimatorDataModelReady)
        clearCharacterAnimations(player)
        return
    end

    if arg1 ~= tbl6[player.UserId] then
        return
    end

    clearConnection(player, tbl1.AnimatorDataModelReady)
    clearCharacterAnimations(player)
    tbl6[player.UserId] = nil

    if not game:GetFastFlag("FacialAnimationStreamingSearchForReplacementWhenRemovingAnimator") then
        return
    end

    local playerAnimator = getPlayerAnimator(player)

    if playerAnimator then
        onAnimatorAdded(player, playerAnimator)
    end
end

local function onCharacterAdded(player: Player, model: Model)
    playerTrace("Player character added", player)
    clearConnection(player, tbl1.CharacterDescendantAdded)
    clearConnection(player, tbl1.CharacterDescendantRemoving)

    tbl5[player.UserId][tbl1.CharacterDescendantAdded] = model.DescendantAdded:Connect(function(descendant: Instance)
        onCharacterDescendantAdded(player, descendant)
    end)

    tbl5[player.UserId][tbl1.CharacterDescendantRemoving] = model.DescendantRemoving:Connect(function(descendant: Instance)
        onCharacterDescendantRemoving(player, descendant)
    end)

    if game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C") then
        onFaceControlsAdded(player, getPlayerFaceControls(player))
    end

    onHumanoidAdded(player, getPlayerHumanoid(player))

    onAnimatorAdded(player, getPlayerAnimator(player))
end

local function onCharacterRemoving(player: Player, _model: Model)
    playerTrace("Player character removing", player)

    if game:GetFastFlag("FacialAnimationStreamingClearAllConnectionsFix2") then
        clearConnection(player, tbl1.CharacterDescendantAdded)
        clearConnection(player, tbl1.CharacterDescendantRemoving)
    else
        clearAllConnections(player)
    end

    clearCharacterAnimations(player)
end

local function playerUpdate(player: Player)
    playerTrace("Player update", player)
    local var2 = tbl3[player.UserId]

    if game:GetFastFlag("FacialAnimationStreamingClearAllConnectionsFix2") and var2 and tbl4[player.UserId] then
        playerTrace("Player already setup", player)
        return
    end

    clearAllConnections(player)

    if not var2 then
        playerTrace("Player update - left", player)
        clearCharacterAnimations(player)

        return
    end

    if not game:GetFastFlag("FacialAnimationStreamingClearAllConnectionsFix2") and tbl4[player.UserId] then
        playerTrace("Player already setup", player)
        return
    end

    playerTrace("Player update - joined", player)

    if player.Character then
        onCharacterAdded(player, player.Character)
    end

    tbl5[player.UserId][tbl1.CharacterAdded] = player.CharacterAdded:Connect(function(character: Model)
        onCharacterAdded(player, character)
    end)
    tbl5[player.UserId][tbl1.CharacterRemoving] = player.CharacterRemoving:Connect(function(character: Model)
        onCharacterRemoving(player, character)
    end)

    tbl5[player.UserId][tbl1.PlayerChatted] = player.Chatted:Connect(function(message: string)
        onPlayerChatted(player, message)
    end)
end

local function toggleMute(num3: number?, isMutedLocally) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl4[num3] and tbl4[num3].animationTrack then
        tbl4[num3].animationTrack:TogglePause(isMutedLocally)
    end
end

local function JoinAllExistingPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        tbl3[player.UserId] = true
        playerUpdate(player)
    end

    Players.PlayerRemoving:Connect(function(player: Player)
        playerTrace("Player leaving game", player)
        tbl3[player.UserId] = nil
        playerUpdate(player)
    end)

    Players.PlayerAdded:Connect(function(player: Player)
        playerTrace("Player joining game", player)
        tbl3[player.UserId] = true
        playerUpdate(player)
    end)
end

local function ConnectStateChangeCallback()
    local service = default2:getService()

    local userId = Players.LocalPlayer.UserId
    default2.participantsUpdate.Event:Connect(function(arg1)
        for k, value in pairs(arg1) do
            local var2 = tonumber(k)
            if var2 ~= userId then
                toggleMute(var2, value.isMutedLocally)
            end
        end
    end)

    if not service then
        var1:trace("Could not find VoiceChatService")

        return
    end

    service.ParticipantsStateChanged:Connect(function(arg1, arg2, _)
        for _, value in ipairs(arg1) do
            local player = Players:GetPlayerByUserId(value)
            if player then
                playerTrace("Player leaving chat", player)
                tbl2[player.UserId] = nil
                playerUpdate(player)
            end
        end
        for _, value in ipairs(arg2) do
            local player = Players:GetPlayerByUserId(value)
            if player then
                playerTrace("Player joining chat", player)
                tbl2[player.UserId] = true
                playerUpdate(player)
            end
        end
    end)
end

local function AttemptToShowCameraPerformanceToast(arg1)
    if GetFFlagUXForCameraPerformanceIXPEnabled() then
        local success, result = pcall(function()
            return IXPServiceWrapper:GetLayerData(GetFStringUXForCameraPerformanceIXPLayerName())
        end)

        if not success then
            return
        end

        if not result then
            return
        end
        if not result.UXForCameraPerformanceEnabled then
            return
        end
    end

    local num3 = os.time() - startTime
    if not arg1 and num3 < num1 then
        task.delay(num1 - num3, function()
            AttemptToShowCameraPerformanceToast(true)
        end)
        return
    end

    local success, result = pcall(function(): string
        return AppStorageService:GetItem("CameraPerformanceUXUnixTimestamp")
    end)
    if not success then
        return
    end

    local var2 = tonumber(result)

    if os.time() - var2 < num2 then
        return
    end

    pcall(function()
        AppStorageService:SetItem("CameraPerformanceUXUnixTimestamp", tostring(var2))
        AppStorageService:Flush()

        TrackerMenu:showPrompt(TrackerPromptType.LODCameraRecommendDisable)

        RbxAnalyticsService:SendEventDeferred(
            "client",
            "avatarChat",
            "UXForCameraPerformanceShown",
            {
                userId = Players.LocalPlayer.UserId,
                pid = tostring(game.PlaceId)
            }
        )
    end)
end

function InitializeVoiceChat()
    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        ConnectStateChangeCallback()
    end

    if not default2 then
        func2()
        return
    end

    default2:asyncInit():catch(function(_)
        var1:trace("VoiceChat:asyncInit failed (possibly denied mic permission)")
    end):finally(func2)

    connection3 = default2.muteChanged.Event:connect(function(arg1)
        if game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C") then
            local playerFaceControls = getPlayerFaceControls(Players.LocalPlayer)
            var1:trace(
                "Syncing audio processing with VoiceChat mute changed: muted=" .. tostring(arg1) .. " hasFaceControls=" .. tostring(playerFaceControls ~= nil)
            )
            FaceAnimatorService.AudioAnimationEnabled = not arg1 and playerFaceControls ~= nil
            return
        end
        var1:trace("Syncing audio processing with VoiceChat mute changed: muted=" .. tostring(arg1))
        FaceAnimatorService.AudioAnimationEnabled = not arg1
    end)

    local bool5

    if default2.localMuted == nil then
        bool5 = false
    else
        var1:trace("Syncing audio processing with VoiceChat mute status: muted=" .. tostring(default2.localMuted))

        bool5 = not default2.localMuted
    end
    if game:GetFastFlag("FacialAnimationStreamingIfNoDynamicHeadDisableA2C") then
        local playerFaceControls = getPlayerFaceControls(Players.LocalPlayer)
        var1:trace("Syncing audio processing with Dynamic Head status: hasFaceControls=" .. tostring(playerFaceControls ~= nil))
        bool5 = bool5 and playerFaceControls ~= nil
    end

    FaceAnimatorService.AudioAnimationEnabled = bool5
end

function CleanupVoiceChat()
    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end
end

function InitializeFacialAnimationStreaming(mask: number)
    if bool4 then
        return
    end

    bool4 = true

    connection = FaceAnimatorService.TrackerError:Connect(function(error: Enum.TrackerError)
        local str1 = string.format("TrackerError: %s", tostring(error))
        var1:trace(string.format("%s {id: %s, name: %s}.", str1, "", ""))

        if error == Enum.TrackerError.VideoNoPermission then
            TrackerMenu:showPrompt(TrackerPromptType.VideoNoPermission)
        elseif error == Enum.TrackerError.VideoUnsupported then
            TrackerMenu:showPrompt(TrackerPromptType.VideoUnsupported)
        elseif error == Enum.TrackerError.UnsupportedDevice then
            TrackerMenu:showPrompt(TrackerPromptType.UnsupportedDevice)
        else
            TrackerMenu:showPrompt(TrackerPromptType.NotAvailable)
        end
    end)

    if bool3 and not func1() then
        var1:trace("Camera is disabled for user and place")
        return
    end

    if GetFFlagAvatarChatServiceEnabled() then
        FaceAnimatorService:Init(
            AvatarChatService:IsEnabled(mask, Enum.AvatarChatServiceFeature.UserVideo),
            AvatarChatService:IsEnabled(mask, Enum.AvatarChatServiceFeature.UserAudio)
        )
    end

    if engineFeature2 then
        connection2 = FaceAnimatorService.TrackerPrompt:Connect(function(prompt: Enum.TrackerPromptEvent)
            local str1 = string.format("TrackerPrompt: %s", tostring(prompt))
            var1:trace(string.format("%s {id: %s, name: %s}.", str1, "", ""))

            if prompt ~= Enum.TrackerPromptEvent.LODCameraRecommendDisable then
                return
            end

            if bool2 then
                AttemptToShowCameraPerformanceToast()
                return
            end
            TrackerMenu:showPrompt(TrackerPromptType.LODCameraRecommendDisable)
        end)
    end

    default:getCallState():andThen(function(arg1)
        if not bool4 then
            return
        end

        if arg1.status ~= Enums.CallStatus.Idle.rawValue() and arg1.status ~= Enums.CallStatus.Ringing.rawValue() then
            FaceAnimatorService.VideoAnimationEnabled = arg1.camEnabled
        else
            FaceAnimatorService.VideoAnimationEnabled = false
        end

        InitializeVoiceChat()

        JoinAllExistingPlayers()
        FacialAnimationStreamingHeartbeatStats.Initialize()
    end)
end

function CleanupFacialAnimationStreaming()
    if not bool4 then
        return
    end

    bool4 = false

    CleanupVoiceChat()
    FacialAnimationStreamingHeartbeatStats.Cleanup()

    for _, player in ipairs(Players:GetPlayers()) do
        tbl3[player.UserId] = nil
        playerUpdate(player)
    end

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if connection4 then
        connection4:Disconnect()
        connection4 = nil
    end
    if connection5 then
        connection5:Disconnect()
        connection5 = nil
    end

    if engineFeature2 and connection2 then
        connection2:Disconnect()
        connection2 = nil
    end
end

local function updateWithServiceState(state: number)
    var1:trace(string.format("[updateWithServiceState] state: %s", tostring(state)))

    if not GetFFlagAvatarChatServiceEnabled() then
        CleanupFacialAnimationStreaming()

        return
    end

    if (AvatarChatService:IsEnabled(state, Enum.AvatarChatServiceFeature.UserAudioEligible)
        or AvatarChatService:IsEnabled(state, Enum.AvatarChatServiceFeature.UserVideoEligible))
        and AvatarChatService:IsPlaceEnabled()
    then
        InitializeFacialAnimationStreaming(state)
        return
    end
    CleanupFacialAnimationStreaming()
end
connection4 = FaceAnimatorService:GetPropertyChangedSignal("AudioAnimationEnabled"):Connect(function()
    updateStreamTrackStatus()
end)

connection5 = FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"):Connect(function()
    updateStreamTrackStatus()
end)

if not GetFFlagAvatarChatServiceEnabled() then
    return
end

if AvatarChatService.ClientFeaturesInitialized then
    updateWithServiceState(AvatarChatService.ClientFeatures)
    return
end
local connection6 = nil
connection6 = AvatarChatService:GetPropertyChangedSignal("ClientFeatures"):Connect(function()
    updateWithServiceState(AvatarChatService.ClientFeatures)
    connection6:Disconnect()
end)
