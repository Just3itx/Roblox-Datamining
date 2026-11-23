-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local MediaPlayback = require(BuildExperienceParent.MediaPlayback)
local Navigation = require(BuildExperienceParent.Navigation)
local React = require(BuildExperienceParent.React)
local RoactNavigation = require(BuildExperienceParent.RoactNavigation)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local _LibraryAudioPlayerView = require(script.Parent.LibraryAudioPlayerView)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local function useLibraryAudioPlayerViewModel(tbl1)
    local bool1 = tbl1.isActive ~= false
    local var1 = MediaPlayback.useAudioStore(tbl1.soundId, false)
    local var2 = Navigation.useNavigation()
    local var3, var4 = React.useState(var2 == nil or var2.isFocused())
    React.useEffect(function()
        var4(var2 == nil or var2.isFocused())
        if var2 == nil then
            return nil
        end
        local var5 = var2.addListener(RoactNavigation.Events.WillFocus, function()
            var4(true)
        end)
        local var6 = var2.addListener(RoactNavigation.Events.WillBlur, function()
            var4(false)
        end)
        return function()
            var5.remove()
            var6.remove()
        end
    end, { var2 or false })
    local isPlaying = SignalsReact.useSignalState(var1.getIsPlaying)
    local var6 = SignalsReact.useSignalState(var1.getIsLoaded)
    local duration = SignalsReact.useSignalState(var1.getDuration)
    local elapsed = SignalsReact.useSignalBinding(var1.getElapsed)
    local var9, var10 = React.useState(false)

    React.useEffect(function()
        var10(false)
        if var6 then
            return nil
        end
        local var11 = task.delay(15, function()
            var10(true)
            sendBuildExperienceEvent(
                "LIBRARY_FETCH_FAILED",
                {
                    universeId = game.GameId,
                    placeId = game.PlaceId
                },
                { surface = "Detail", kind = "Sound", reason = "audio_load_timeout" }
            )
        end)

        return function()
            task.cancel(var11)
        end
    end, { var1, var6 })

    local onTogglePlayback = React.useCallback(function()
        if not (var6 and var3 and bool1) then
            return
        end
        if isPlaying then
            var1.pause()
        else
            MediaPlayback.getAudioPlaybackStore(false).pauseAll()
            var1.play()
        end
        sendBuildExperienceEvent(
            "LIBRARY_ASSET_CLICK",
            {
                universeId = game.GameId,
                placeId = game.PlaceId
            },
            {
                surface = "Detail",
                kind = "Sound",
                action = if isPlaying then "pause" else "play"
            }
        )
    end, {
        var1,
        var6,
        isPlaying,
        var3,
        bool1
    })
    local var12 = React.useRef(false)
    local onSeekStarted = React.useCallback(function()
        var12.current = var6 and bool1 and var3 and isPlaying
        var1.pause()
    end, {
        var1,
        var6,
        bool1,
        var3,
        isPlaying
    })

    local onSeek = React.useCallback(function(num1: number)
        if var6 and bool1 and var3 then
            var1.seek(math.clamp(num1, 0, 1) * duration)
        end
    end, {
        var1,
        duration,
        var6,
        bool1,
        var3
    })

    local onSeekEnded = React.useCallback(function()
        if var12.current and bool1 and var3 then
            var1.play()
        end
        var12.current = false
    end, { var1, bool1, var3 })

    React.useEffect(function()
        if not var3 then
            var1.stop()
        elseif not bool1 then
            var1.pause()
        end
    end, { var1, var3, bool1 })

    React.useEffect(function()
        return function()
            var1.stop()
        end
    end, { var1 })

    return {
        isCompact = tbl1.isCompact,
        title = tbl1.title,
        artist = tbl1.soundLabel or "",
        isPlaying = isPlaying,
        elapsed = elapsed,
        duration = duration,
        onTogglePlayback = onTogglePlayback,
        onSeek = onSeek,
        onSeekStarted = onSeekStarted,
        onSeekEnded = onSeekEnded,
        unavailableText = tbl1.unavailableText,
        status = if var6 then "Ready" elseif var9 then "Failed" else "Loading"
    }
end

return useLibraryAudioPlayerViewModel
