-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local React = require(MediaPlayback.Parent.React)

local _types = require(MediaPlayback.Stores.getAudioPlaybackStore.types)
local getAudioPlaybackStore = require(MediaPlayback.Stores.getAudioPlaybackStore)

local useEffect = React.useEffect
local useMemo = React.useMemo

local function useAudioStore(arg1, bool1: boolean?)
    local var1 = arg1 or "-1"

    local var2 = useMemo(function()
        return getAudioPlaybackStore(false).getOrCreateAudioStore(var1, bool1)
    end, { var1, bool1 })

    useEffect(function()
        return function()
            getAudioPlaybackStore(false).destroyAudioStore(var1, bool1)
        end
    end, { var1, bool1 })

    return var2
end

return useAudioStore
