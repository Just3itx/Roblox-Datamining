-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local React = require(MediaPlayback.Parent.React)

local enableAudioPlaybackInApp = require(MediaPlayback.Common.enableAudioPlaybackInApp)

local useEffect = React.useEffect

local num1 = game:DefineFastInt("InitializeFmodMsDelay", 0)

local function useLazyFmod()
    useEffect(function()
        task.delay(num1 / 1000, function()
            enableAudioPlaybackInApp()
        end)
    end, {})
end

return useLazyFmod
