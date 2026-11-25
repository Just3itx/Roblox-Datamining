-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local SignalsReact = require(Songbird.Parent.SignalsReact)
local MediaPlayback = require(Songbird.Parent.MediaPlayback)
local React = require(Songbird.Parent.React)

local getAudioPlaybackStore = MediaPlayback.getAudioPlaybackStore
local useEffect = React.useEffect
local useCallback = React.useCallback

local function useStopSongOnPageNavigation(bool1: boolean, callback: ((...any) -> (...any))?)
    local var1 = SignalsReact.useSignalState(getAudioPlaybackStore)

    local var2 = useCallback(function()
        for _, value in var1.getPlayingAudioStores(false) do
            value.stop()
        end
        if callback then
            callback()
        end
    end, { var1, callback })

    useEffect(function()
        if not bool1 then
            var2()
        end
    end, { bool1, var2 })

    useEffect(function()
        return var2
    end, { var2 })
end

return useStopSongOnPageNavigation
