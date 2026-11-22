-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local Signals = require(MediaPlayback.Parent.Signals)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createVolumeStore()
    local getVolume, var2 = createSignal(1)
    local var3, var4 = createSignal(getVolume(false))

    local getIsMuted = createComputed(function(arg1): boolean
        return getVolume(arg1) <= 0
    end)

    return {
        getVolume = getVolume,
        setVolume = function(num1: number) -- name: setClampedVolume
            var2(math.clamp(num1, 0, 1))
        end,
        getIsMuted = getIsMuted,
        mute = function()
            if not getIsMuted(false) then
                var4(getVolume(false))
                var2(0)
            end
        end,
        unmute = function()
            if getIsMuted(false) then
                var2(var3(false))
            end
        end
    }
end

return createVolumeStore
