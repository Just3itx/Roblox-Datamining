-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local CoreGui = game:GetService("CoreGui")

local assetIdAsContent = require(MediaPlayback.Common.assetIdAsContent)
local getFFlagAudioPreviewLua = require(MediaPlayback.Flags.getFFlagAudioPreviewLua)

local function getOrCreateInstances(coreGui: CoreGui)
    local audioPlayback = coreGui:FindFirstChild("AudioPlayback")
    local audioOutput = if audioPlayback then audioPlayback:FindFirstChildWhichIsA("AudioDeviceOutput") else nil

    if audioPlayback and audioOutput then
        return { container = audioPlayback, audioOutput = audioOutput }
    end

    local audioPlayback2 = Instance.new("Folder")
    audioPlayback2.Name = "AudioPlayback"

    local audioDeviceOutput = Instance.new("AudioDeviceOutput")

    audioDeviceOutput.Parent = audioPlayback2

    audioPlayback2.Parent = coreGui

    return { container = audioPlayback2, audioOutput = audioDeviceOutput }
end

local function createAudioSystem(arg1, bool1: boolean?)
    local orCreateInstances = getOrCreateInstances(CoreGui)

    local audioPlayer = Instance.new("AudioPlayer")

    audioPlayer.Asset = assetIdAsContent(arg1)
    audioPlayer.Name = `AudioPlayer_{audioPlayer.Asset}`

    if getFFlagAudioPreviewLua() and bool1 then
        audioPlayer.AssetRepresentation = Enum.AssetRepresentation.ShortPreview
    end

    audioPlayer.Parent = orCreateInstances.container

    audioPlayer.PlaybackSpeed = 0
    audioPlayer:Play()

    local wire = Instance.new("Wire")
    wire.SourceInstance = audioPlayer
    wire.TargetInstance = orCreateInstances.audioOutput
    wire.Parent = audioPlayer

    return {
        audioPlayer = audioPlayer,
        destroy = function()
            audioPlayer:Destroy()

            if not orCreateInstances.container:FindFirstChildWhichIsA("AudioPlayer") then
                orCreateInstances.container:Destroy()
            end
        end
    }
end

return createAudioSystem
