-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local SignalsReact = require(MediaPlayback.Parent.SignalsReact)

local _types = require(MediaPlayback.Stores.getAudioPlaybackStore.types)
local getAudioPlaybackStore = require(MediaPlayback.Stores.getAudioPlaybackStore)
local useAudioStore = require(MediaPlayback.Hooks.useAudioStore)

local useSignalState = SignalsReact.useSignalState

local function useLastPlayedAudioStore()
    local var1 = useSignalState(getAudioPlaybackStore)
    local var2 = useSignalState(var1.getLastPlayedAudioStore)

    return useAudioStore(if var2 then var2.assetId else nil, if var2 then var2.usePreview else nil)
end

return useLastPlayedAudioStore
