-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)

local function toAssetUri(assetId): string -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(assetId) == "string" and string.find(assetId, "://") ~= nil then
        return assetId
    end
    return `rbxassetid://{assetId}`
end

return {
    kind = "music",
    create = function(arg1, arg2) -- name: createMusicNode
        local parent = arg1.parent
        assert(parent ~= nil, "createMusicNode: spec.parent (the item media folder) is required")

        local uri = toAssetUri(arg1.assetId)
        local content = Content.fromUri(uri)
        local startTime = arg1.startTime or 0
        local trimmedLen = arg1.trimmedLen
        local getRegion = {
            startTime = startTime,
            endTime = if trimmedLen == nil then nil else startTime + trimmedLen
        }
        local volume = arg1.volume or 1

        local audioPlayer = Instance.new("AudioPlayer")
        audioPlayer.Name = `Music_{arg1.id}`

        audioPlayer.AudioContent = content

        audioPlayer.PlaybackSpeed = 0
        audioPlayer.TimePosition = startTime
        audioPlayer.Parent = parent

        local bool1 = false

        return {
            id = arg1.id,
            kind = "music",
            assets = function()
                return { content }
            end,
            download = function()
                if bool1 then
                    return
                end

                arg2.contentProvider:PreloadAsync({ content.Uri })
            end,
            usesDecoder = false,
            getAudioSource = function()
                return audioPlayer
            end,
            audioStem = {
                stemId = arg1.id,
                defaultVolume = volume
            },
            play = function()
                if bool1 then
                    return
                end
                audioPlayer.PlaybackSpeed = 1
                if not audioPlayer.IsPlaying then
                    audioPlayer:Play()
                end
            end,
            pause = function()
                if bool1 then
                    return
                end
                audioPlayer.PlaybackSpeed = 0
            end,
            seek = function(num1: number)
                if bool1 then
                    return
                end
                local var1 = startTime + num1
                local timeLength = audioPlayer.TimeLength
                if timeLength > 0 then
                    var1 = math.clamp(var1, 0, timeLength)
                end
                audioPlayer.TimePosition = var1
            end,
            realignToRegionStart = function()
                if bool1 then
                    return
                end
                audioPlayer.TimePosition = startTime
            end,
            getRegion = function()
                return getRegion
            end,
            dispose = function()
                if bool1 then
                    return
                end
                bool1 = true
                audioPlayer:Destroy()
            end
        }
    end
}
