-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local Cryo = require(MediaPlayback.Parent.Cryo)
local Signals = require(MediaPlayback.Parent.Signals)

local function createConsumerCounterStore()
    local getConsumerCounts, var2 = Signals.createSignal({})

    return {
        subscribe = function(str1: string)
            var2(function(arg1)
                local var3 = arg1[str1] or 0
                return Cryo.Dictionary.join(arg1, { [str1] = var3 + 1 })
            end)
        end,
        unsubscribe = function(str1: string)
            local var3 = nil

            var2(function(arg1)
                var3 = math.max(0, (arg1[str1] or 0) - 1)

                local join = Cryo.Dictionary.join
                local tbl1 = {}
                local str2 = str1
                tbl1[str2] = if var3 > 0 then var3 else Cryo.None
                return join(arg1, tbl1)
            end)

            return var3
        end,
        getConsumerCounts = getConsumerCounts
    }
end

return createConsumerCounterStore
