-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local useAudioPlayback = require(MomentsCreation.Hooks.useAudioPlayback)
local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)
local getTtsDuckScalar = require(MomentsCreation.Audio.getTtsDuckScalar)

local function useCreationMusicSync(arg1, num1: number, arg2)
    local playback = arg1.playback

    local music, var2 = React.useState((playback.getMusic(false)))
    local userMuted, var4 = React.useState(playback.getIsMuted(false))
    local var5, var6 = React.useState(playback.getIsPlaying(false))

    local useState = React.useState
    local bool1 = GetFFlagMomentsTTSAudioOverlay

    if bool1 then
        if arg2 == nil then
            bool1 = false
        else
            bool1 = arg2.getState(false) == "playing"
        end
    end

    local var7, var8 = useState(bool1)

    React.useEffect(function()
        return Signals.createEffect(function(arg3)
            var2(playback.getMusic(arg3))
            var4(playback.getIsMuted(arg3))
            var6(playback.getIsPlaying(arg3))
            if GetFFlagMomentsTTSAudioOverlay then
                var8(not (arg2 == nil) and arg2.getState(arg3) == "playing")
            end
        end)
    end, { playback })

    local isDucking = GetFFlagMomentsTTSAudioOverlay and var7
    local duckScalar = if isDucking then getTtsDuckScalar() else 1

    local playbackRegion = React.useMemo(function()
        if music == nil then
            return nil
        end
        return NumberRange.new(music.startTime, music.startTime + math.max(0, num1))
    end, { music, num1 })

    local audio = useAudioPlayback(music ~= nil, if music == nil then nil else music.assetId, {
        autoplay = true,
        looping = true,
        playbackRegion = playbackRegion or NumberRange.new(0, math.huge),
        duckScalar = duckScalar
    })

    React.useEffect(function()
        if music == nil then
            return
        end

        if var5 then
            audio.playback.play()
        else
            audio.playback.pause()
        end
    end, { music, var5 })

    React.useEffect(function()
        if music == nil then
            return
        end
        audio.volume.unmute()
    end, { music, userMuted })

    return { audio = audio, music = music, userMuted = userMuted, isDucking = isDucking }
end

return useCreationMusicSync
