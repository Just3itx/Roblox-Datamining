-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local _PrivatePlaytestersStoreTypes = require(script.Parent.PrivatePlaytestersStoreTypes)

local function createPlayersGetterCache()
    local tbl1 = ({})

    return {
        getFor = function(arg1)
            local var1 = tbl1[arg1]
            if var1 ~= nil then
                return var1
            end
            local computed = Signals.createComputed(function(arg2)
                return arg1(arg2) or {}
            end)
            tbl1[arg1] = computed
            return computed
        end,
        clear = function()
            table.clear(tbl1)
        end
    }
end
return createPlayersGetterCache
