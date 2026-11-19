-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SoundService = game:GetService("SoundService")
local VoiceChatService = game:GetService("VoiceChatService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function ShouldUseDefaultVoice() -- Luacid: Inlined by compiler; 3 call sites recovered
    return SoundService.DefaultListenerLocation == Enum.ListenerLocation.Default
        and VoiceChatService.UseAudioApi == Enum.AudioApiRollout.Enabled
        and VoiceChatService.EnableDefaultVoice
end

local function ShouldUseCamera(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return SoundService.DefaultListenerLocation == Enum.ListenerLocation.Camera
end

local function ShouldUseCharacter(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return SoundService.DefaultListenerLocation == Enum.ListenerLocation.Character
end

local function ShouldSpawnListener(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (SoundService.DefaultListenerLocation == Enum.ListenerLocation.None)
        and (not not ShouldUseCamera() or not not ShouldUseCharacter() or ShouldUseDefaultVoice())
end

local function WireUp(audioListener: AudioListener, targetInstance: Instance): Wire -- Luacid: Inlined by compiler; 2 call sites recovered
    local wire = Instance.new("Wire")
    wire.SourceInstance = audioListener
    wire.TargetInstance = targetInstance
    wire.Parent = audioListener
    return wire
end

local function GetMainOut(): Instance -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = SoundService:FindFirstChildWhichIsA("AudioDeviceOutput", true)
    if not var1 then
        var1 = Instance.new("AudioDeviceOutput")
        var1.Parent = SoundService
    end

    return var1
end

local function SpawnCharacterListener(character: Model)
    local primaryPart = character.PrimaryPart
    if not primaryPart then
        character:GetPropertyChangedSignal("PrimaryPart"):Once(function()
            SpawnCharacterListener(character)
        end)
        return
    end

    local attachment = Instance.new("Attachment")
    local function UpdateCFrame() -- Luacid: Inlined by compiler; 1 call site recovered
        local currentCamera = workspace.CurrentCamera
        if not currentCamera then
            return
        end
        local rotation = currentCamera.CFrame.Rotation
        attachment.WorldAxis = rotation.XVector
        attachment.WorldSecondaryAxis = rotation.YVector
    end

    UpdateCFrame()
    local audioListener = Instance.new("AudioListener")
    audioListener.Parent = attachment
    attachment.Parent = primaryPart
    local _wire = WireUp(audioListener, (GetMainOut()))
    local connection = RunService.Heartbeat:Connect(UpdateCFrame)

    local connection2 = nil
    connection2 = attachment.AncestryChanged:Connect(function()
        if not attachment:IsDescendantOf(game) then
            connection:Disconnect()
            connection2:Disconnect()
        end
    end)
end

local bool1 = false
local function Initialize()
    if not ShouldSpawnListener() or bool1 then
        return
    end

    if ShouldUseCharacter() then
        local character = LocalPlayer.Character
        if character then
            SpawnCharacterListener(character)
        end
        LocalPlayer.CharacterAdded:Connect(SpawnCharacterListener)
    elseif ShouldUseCamera() then
        local mainOut = GetMainOut()
        local audioListener = Instance.new("AudioListener")
        audioListener.Parent = workspace.CurrentCamera
        local _wire = WireUp(audioListener, mainOut)
    elseif ShouldUseDefaultVoice() then
        local audioListener = Instance.new("AudioListener")
        audioListener.Parent = workspace.CurrentCamera
        local wire = Instance.new("Wire")
        wire.Parent = audioListener
        local audioDeviceOutput = Instance.new("AudioDeviceOutput")
        audioDeviceOutput.Parent = wire
        wire.SourceInstance = audioListener
        wire.TargetInstance = audioDeviceOutput
    end
    bool1 = true
end

Initialize()
SoundService:GetPropertyChangedSignal("DefaultListenerLocation"):Connect(Initialize)
VoiceChatService:GetPropertyChangedSignal("UseAudioApi"):Connect(Initialize)
VoiceChatService:GetPropertyChangedSignal("EnableDefaultVoice"):Connect(Initialize)

return {}
