-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:21:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local engineFeature = game:GetEngineFeature("PartyVoiceVolume")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CrossExperience = script:FindFirstAncestor("CrossExperience")
local _Types = require(CrossExperience.Types)

local num1 = game:DefineFastInt("PartyVoiceAudioFaderVolumePerc", 100)
local engineFeature2 = game:GetEngineFeature("AudioPlayerUpdateAssetAPI")

local module = {}
module.__index = module

function module.new()
    local tbl1 = {
        audioPlayers = {},
        isInitialized = false,
        sfxAudioFader = nil,
        onPartyVoiceVolumeChangedSignal = nil
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:addSound(arg1, str1: string)
    local audioPlayer = Instance.new("AudioPlayer")
    audioPlayer.Parent = workspace
    if engineFeature2 then
        audioPlayer.Asset = str1
    else
        audioPlayer.AssetId = str1
    end

    local wire = Instance.new("Wire")
    wire.Parent = workspace

    wire.SourceInstance = audioPlayer
    wire.TargetInstance = self.sfxAudioFader

    self.audioPlayers[arg1] = audioPlayer
end

function module:initialize()
    if num1 ~= 100 then
        ReplicatedStorage:WaitForChild("AudioFader").Volume = num1 / 100
    end

    local audioDeviceOutput = Instance.new("AudioDeviceOutput")
    audioDeviceOutput.Parent = workspace

    local audioFader = Instance.new("AudioFader")
    audioFader.Parent = workspace
    if num1 ~= 100 then
        audioFader.Volume = num1 / 100
    end

    local wire = Instance.new("Wire")
    wire.Parent = workspace
    wire.SourceInstance = audioFader
    wire.TargetInstance = audioDeviceOutput

    self.sfxAudioFader = audioFader

    self:addSound("join", "rbxassetid://87296803139875")
    self:addSound("leave", "rbxassetid://108128059974752")

    self.isInitialized = true

    if engineFeature then
        self.onPartyVoiceVolumeChangedSignal = UserGameSettings:GetPropertyChangedSignal("PartyVoiceVolume"):Connect(function()
            self:playSound("join")
        end)
    end
end

function module:playSound(arg1)
    if not self.isInitialized then
        self:initialize()
    end

    if not (self.isInitialized and self.audioPlayers[arg1]) then
        return
    end

    self.audioPlayers[arg1].TimePosition = 0
    self.audioPlayers[arg1]:Play()
end

function module:disconnect()
    if self.onPartyVoiceVolumeChangedSignal then
        self.onPartyVoiceVolumeChangedSignal:Disconnect()
    end
end

module.default = module.new()

return module
