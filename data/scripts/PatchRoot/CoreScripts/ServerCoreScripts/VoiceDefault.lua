-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local AvatarChatService = game:GetService("AvatarChatService")

local GetFFlagAvatarChatServiceEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAvatarChatServiceEnabled

local bool1 = game:DefineFastFlag("DebugLogVoiceDefault", false)

local FFlagUseAudioDeviceInputAddedSignal = require(CorePackages.Workspace.Packages.SharedFlags).FFlagUseAudioDeviceInputAddedSignal
local engineFeature = game:GetEngineFeature("AudioInstanceAddedApiEnabled")

local FFlagExpChatDictation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagExpChatDictation

local function log(...)
    if bool1 then
        print("[VoiceDefault]", ...)
    end
end

local curve = ({})

for i = 7, 80, 2 do
    curve[i] = (i - 7 - 73) ^ 2 / 5329
end
curve[80] = 0

if GetFFlagAvatarChatServiceEnabled() then
    local success, result = pcall(AvatarChatService.GetServerFeaturesAsync, AvatarChatService)

    if not success then
        log("Failed to get GetServerFeaturesAsync, returning early")
        return
    end

    local isEnabled = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.UniverseAudio)
    local isEnabled2 = AvatarChatService:IsEnabled(result, Enum.AvatarChatServiceFeature.PlaceAudio)

    if not (isEnabled and isEnabled2) then
        log("Universe or place not voice enabled, returning early")
        return
    end
end

local tbl1 = ({})
local tbl2 = ({})
local tbl3 = ({})

local function upsertDeviceList(tbl4, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl4 ~= nil then
        tbl4[arg1] = true
        return tbl4
    end

    local result = ({})
    result[arg1] = true
    return result
end

local function addEmitterToHead(character): AudioEmitter
    local audioEmitter = Instance.new("AudioEmitter")
    audioEmitter.Parent = character
    audioEmitter:AddTag("RbxDefaultVoiceEmitter")
    log("Adding emitter", audioEmitter, " to ", character)

    if VoiceChatService.DefaultDistanceAttenuation == Enum.VoiceChatDistanceAttenuationType.Legacy then
        audioEmitter:SetDistanceAttenuation(curve)
    end
    return audioEmitter
end

local function hookupDeviceInputToEmitter(character, audioDeviceInput: AudioDeviceInput) -- Luacid: Inlined by compiler; 2 call sites recovered
    local audioEmitter = addEmitterToHead(character)
    log("Hooking input device to emitter", character, audioDeviceInput, audioEmitter)
    local wire = Instance.new("Wire")
    wire.Parent = audioEmitter
    wire.SourceInstance = audioDeviceInput
    wire.TargetInstance = audioEmitter
end

local function untrackDeviceForPlayer(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg2 then
        local var1 = tbl1[arg2]
        if var1 then
            var1[arg1] = nil
        end
    end

    local var1 = tbl2[arg1]
    if not var1 then
        log("Attempting to remove connections from untracked AudioDeviceInput")
        return
    end
    var1.onPlayerChanged:Disconnect()
    tbl2[arg1] = nil
end

local function isIgnoredAudioInput(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    return arg1:IsDescendantOf(CoreGui)
end

local function trackDevice(arg1)
    if FFlagExpChatDictation and isIgnoredAudioInput(arg1) then
        return
    end

    local player = arg1.Player
    if player then
        tbl1[player] = upsertDeviceList(tbl1[player], arg1)
    end

    local tbl4 = {}
    local var1 = player
    tbl4.onPlayerChanged = arg1:GetPropertyChangedSignal("Player"):Connect(function()
        untrackDeviceForPlayer(arg1, var1)
        var1 = arg1.Player
        trackDevice(arg1)
    end)

    tbl2[arg1] = tbl4
    arg1.Destroying:Connect(function()
        untrackDeviceForPlayer(arg1, arg1.Player)
    end)
end

local function createAudioDevice(player)
    local success, result = pcall(function(): boolean
        return VoiceChatService:IsVoiceEnabledForUserIdAsync(player.UserId)
    end)
    if not success then
        log("Error getting voice enabled status: \"", result, "\"")
    end
    if not (success and result) then
        return
    end
    local audioDeviceInput = Instance.new("AudioDeviceInput")
    audioDeviceInput.Player = player
    audioDeviceInput.Parent = player
    audioDeviceInput.Active = false
    trackDevice(audioDeviceInput)

    if player.Character then
        hookupDeviceInputToEmitter(player.Character, audioDeviceInput)
    end

    tbl3[player] = player.CharacterAdded:Connect(function(character: Model)
        hookupDeviceInputToEmitter(character, audioDeviceInput)
    end)
    log("Creating device for ", player.Name)
end

if not VoiceChatService.UseNewAudioApi then
    return
end

log("Using new Audio API, EnableDefaultVoice: ", VoiceChatService.EnableDefaultVoice)
if VoiceChatService.EnableDefaultVoice then
    local Players = game:GetService("Players")
    Players.PlayerAdded:Connect(createAudioDevice)
    Players.PlayerRemoving:Connect(function(player: Player)
        local var1 = tbl1[player]
        local var2 = tbl3[player]
        log(player.Name, "removed. Deleting instance", var1)
        if var1 then
            tbl1[player] = nil
        end
        if var2 then
            var2:Disconnect()
        end
    end)

    for _, player in Players:GetPlayers() do
        createAudioDevice(player)
    end
end

local setUserActive = Instance.new("RemoteEvent")
setUserActive.Name = "SetUserActive"
setUserActive.Parent = RobloxReplicatedStorage

local function onAudioDeviceInputAdded(audioDeviceInput: AudioDeviceInput) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagExpChatDictation and isIgnoredAudioInput(audioDeviceInput) then
        return
    end
    audioDeviceInput.Active = false
    trackDevice(audioDeviceInput)
end

if FFlagUseAudioDeviceInputAddedSignal then
    SoundService.AudioDeviceInputAdded:Connect(onAudioDeviceInputAdded)
elseif engineFeature then
    SoundService.AudioInstanceAdded:Connect(function(instance: Instance)
        if instance:IsA("AudioDeviceInput") then
            onAudioDeviceInputAdded(instance)
        end
    end)
else
    game.DescendantAdded:Connect(function(descendant: Instance)
        if descendant:IsA("AudioDeviceInput") then
            onAudioDeviceInputAdded(descendant)
        end
    end)
end

for _, value in SoundService:GetAudioInstances() do
    if value:IsA("AudioDeviceInput") and not (FFlagExpChatDictation and isIgnoredAudioInput(value)) then
        value.Active = false
        trackDevice(value)
    end
end

setUserActive.OnServerEvent:Connect(function(player: Player, arguments)
    local var1 = tbl1[player]
    if not var1 then
        log("Attempting to set Active property for user", player, "without saved AudioDeviceInput")

        return
    end

    log("Setting", player, "to", arguments)
    for value, _ in var1 do
        value.Active = arguments
    end
end)
