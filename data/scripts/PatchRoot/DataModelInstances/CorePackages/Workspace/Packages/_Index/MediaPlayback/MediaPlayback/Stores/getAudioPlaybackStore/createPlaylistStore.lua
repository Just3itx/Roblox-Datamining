-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local Signals = require(MediaPlayback.Parent.Signals)

local _types = require(MediaPlayback.Stores.getAudioPlaybackStore.types)

local createSignal = Signals.createSignal

local function createPlaylistStore()
    local get, var2 = createSignal({})
    local var3, var4 = createSignal({})

    local function getRelativeIndex(arg1, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var5 = var3(false)[tostring(arg1)]

        if var5 then
            return get(false)[var5 + num1]
        end

        return nil
    end

    return {
        get = get,
        set = function(tbl1)
            var2(tbl1)

            local tbl2 = {}
            for value, value2 in tbl1 do
                tbl2[tostring(value2)] = value
            end
            var4(tbl2)
        end,
        getNext = function(arg1)
            return getRelativeIndex(arg1, 1)
        end,
        getPrev = function(arg1)
            return getRelativeIndex(arg1, -1)
        end
    }
end
return createPlaylistStore
