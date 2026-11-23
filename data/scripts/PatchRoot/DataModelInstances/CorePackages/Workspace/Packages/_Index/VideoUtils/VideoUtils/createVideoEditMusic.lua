-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createVideoEditMusic(str1: string, func1: (...any) -> (...any))
    local videoEditMusic = Instance.new("Folder")
    videoEditMusic.Name = "VideoEditMusic"
    videoEditMusic.Parent = game:GetService("CoreGui")
    local audioPlayer = Instance.new("AudioPlayer")
    audioPlayer.Asset = `rbxassetid://{str1}`
    audioPlayer.PlaybackSpeed = 0
    audioPlayer.Parent = videoEditMusic
    local audioDeviceOutput = Instance.new("AudioDeviceOutput")
    audioDeviceOutput.Parent = videoEditMusic
    local wire = Instance.new("Wire")
    wire.SourceInstance = audioPlayer
    wire.TargetInstance = audioDeviceOutput
    wire.Parent = videoEditMusic
    local bool1 = false
    local connection = audioPlayer:GetPropertyChangedSignal("IsReady"):Connect(function()
        if not audioPlayer.IsReady then
            return
        end

        if bool1 and not audioPlayer.IsPlaying then
            audioPlayer:Play()
        end
        audioPlayer.TimePosition = func1()
    end)

    audioPlayer:Play()

    return {
        setPosition = function(timePosition: number)
            audioPlayer.TimePosition = timePosition
        end,
        setPlaying = function(bool2: boolean)
            bool1 = bool2
            if bool2 and audioPlayer.IsReady and not audioPlayer.IsPlaying then
                audioPlayer:Play()
                audioPlayer.TimePosition = func1()
            end

            audioPlayer.PlaybackSpeed = if bool2 then 1 else 0
        end,
        destroy = function()
            connection:Disconnect()
            videoEditMusic:Destroy()
        end
    }
end

return createVideoEditMusic
