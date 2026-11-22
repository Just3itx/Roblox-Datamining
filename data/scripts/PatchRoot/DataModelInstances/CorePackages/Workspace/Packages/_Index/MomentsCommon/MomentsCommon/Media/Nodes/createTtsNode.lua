-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local HttpService = game:GetService("HttpService")

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)
local audioDuckingFastInts = require(MomentsCommon.Media.audioDuckingFastInts)
local FFlagMomentsVideoPermissionContextFix = require(MomentsCommon.Flags.FFlagMomentsVideoPermissionContextFix)

local function toAssetUri(assetId, input: string?, bool1: boolean?): string
    if typeof(assetId) == "string" and string.find(assetId, "://") ~= nil then
        return assetId
    end
    local str1 = `rbxassetid://{assetId}`
    if input == nil or input == "" then
        return str1
    end

    local str2 = `{str1}&accessContext={HttpService:UrlEncode(input)}`
    if bool1 then
        return str2
    end

    return `{str2}&permissionContext=ignoreUniverse`
end

local function hasAudioRemaining(num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return num2 <= 0 or num1 < num2
end

local function defaultLoadSpeech(arg1)
    if not game:GetEngineFeature("TextToSpeechPlatformPreview") then
        return Enum.AssetFetchStatus.Failure
    end
    return arg1:LoadPlatformAsync()
end

return {
    kind = "tts",
    create = function(arg1, arg2) -- name: createTtsNode
        local parent = arg1.parent
        assert(parent ~= nil, "createTtsNode: spec.parent (the item media folder) is required")

        local assetId = arg1.assetId
        local assetAccessContext = arg1.assetAccessContext
        local startTime = arg1.startTime or 0
        local getRegion = { startTime = startTime, endTime = nil }

        local defaultVolume = arg1.volume or audioDuckingFastInts.getTtsVolume()
        local uri = if assetId == nil then nil else Content.fromUri((toAssetUri(assetId, assetAccessContext)))
        local audioContent = if FFlagMomentsVideoPermissionContextFix and game.GameId == 0 and assetId ~= nil then Content.fromUri((toAssetUri(assetId, assetAccessContext, true))) else uri
        local getAudioSource = nil
        if audioContent ~= nil then
            local audioPlayer = Instance.new("AudioPlayer")
            audioPlayer.Name = `Tts_{arg1.id}`
            audioPlayer.AudioContent = audioContent

            audioPlayer.PlaybackSpeed = 0
            audioPlayer.TimePosition = 0
            audioPlayer.Parent = parent
            getAudioSource = audioPlayer
        end

        local text = arg1.text
        local var4 = nil
        if getAudioSource == nil and text ~= nil and text ~= "" then
            local audioTextToSpeech = Instance.new("AudioTextToSpeech")
            audioTextToSpeech.Name = `Tts_{arg1.id}`
            audioTextToSpeech.Text = text
            audioTextToSpeech.VoiceId = tostring(arg1.voiceId)
            audioTextToSpeech.PlaybackSpeed = 0
            audioTextToSpeech.TimePosition = 0
            audioTextToSpeech.Parent = parent
            var4 = audioTextToSpeech

            getAudioSource = audioTextToSpeech
        end
        local var5 = arg2.loadSpeech or defaultLoadSpeech

        local bool1 = var4 == nil
        local bool2 = false

        local bool3 = false

        local function download()
            if bool3 then
                return
            end
            if var4 ~= nil and not bool2 then
                bool2 = true

                task.spawn(function()
                    local success, result = pcall(var5, var4)

                    if bool3 or not success or result ~= Enum.AssetFetchStatus.Success then
                        return
                    end
                    bool1 = true
                end)
            end
            if uri == nil then
                return
            end

            arg2.contentProvider:PreloadAsync({ uri.Uri })
        end

        local bool4 = false
        local bool5 = false

        local var6 = nil

        local tbl2 = {
            id = arg1.id,
            kind = "tts",
            assets = function(): {[any]: any} | {Content}
                return if uri == nil then {} else { uri }
            end,
            download = download,
            usesDecoder = false,
            play = function()
                if bool3 or getAudioSource == nil then
                    return
                end

                bool4 = true
            end,
            pause = function()
                if bool3 or getAudioSource == nil then
                    return
                end
                bool4 = false
                bool5 = false
                getAudioSource.PlaybackSpeed = 0
            end,
            seek = function(num1: number)
                if bool3 or getAudioSource == nil then
                    return
                end
                local num2 = math.max(0, num1 - startTime)
                local timeLength = getAudioSource.TimeLength
                if timeLength > 0 then
                    num2 = math.clamp(num2, 0, timeLength)
                end
                getAudioSource.TimePosition = num2
            end,
            realignToRegionStart = function()
                if bool3 or getAudioSource == nil then
                    return
                end
                getAudioSource.PlaybackSpeed = 0
                getAudioSource.TimePosition = 0
                bool5 = false
            end,
            syncToClock = function(num1: number)
                if bool3 or getAudioSource == nil or not (bool4 and bool1) then
                    return
                end

                local var7 = var6
                var6 = num1
                local bool6 = not (var7 == nil) and var7 < num1

                if not (startTime <= num1) then
                    if bool5 then
                        getAudioSource.PlaybackSpeed = 0
                        getAudioSource.TimePosition = 0
                        bool5 = false
                    end

                    return
                end

                local timePosition = math.max(0, num1 - startTime)
                if not bool5 then
                    if not (bool6 and hasAudioRemaining(timePosition, getAudioSource.TimeLength)) then
                        return
                    else
                        getAudioSource.TimePosition = timePosition
                        getAudioSource.PlaybackSpeed = 1
                        if not getAudioSource.IsPlaying then
                            getAudioSource:Play()
                        end
                        bool5 = true
                        return
                    end
                end

                if not hasAudioRemaining(timePosition, getAudioSource.TimeLength) then
                    return
                end
                local var8 = timePosition - getAudioSource.TimePosition
                if var8 > 0.1 or var8 < -0.5 then
                    getAudioSource.TimePosition = timePosition
                end
            end,
            getRegion = function()
                return getRegion
            end,
            dispose = function()
                if bool3 then
                    return
                end
                bool3 = true
                if getAudioSource ~= nil then
                    getAudioSource:Destroy()
                end
            end
        }

        if getAudioSource ~= nil then
            function tbl2.getAudioSource()
                return getAudioSource
            end
            tbl2.audioStem = {
                stemId = arg1.id,
                defaultVolume = defaultVolume,
                role = "sidechain"
            }
        end

        return tbl2
    end,
    hasAudioRemaining = hasAudioRemaining
}
