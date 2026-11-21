-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReactParent = script:FindFirstAncestor("GameHydrationReact").Parent

local React = require(GameHydrationReactParent.React)
local Signals = require(GameHydrationReactParent.Signals)
local SignalsReact = require(GameHydrationReactParent.SignalsReact)
local DataHydration = require(GameHydrationReactParent.DataHydration)

local signal = Signals.createSignal(false)
local tbl1 = {}

local function useGameIconsForSize(tbl2, arg1, bool1: boolean?)
    local tbl3 = {}
    for _, value in tbl2 do
        table.insert(tbl3, tostring(value))
    end
    table.sort(tbl3)

    local str1 = table.concat(tbl3, ",")

    local var1 = React.useMemo(function()
        local gameIconStore = DataHydration.Game.getGameIconStore(false)
        local var1 = if bool1 then gameIconStore.getAndFetchGameIcons(tbl3, arg1) else gameIconStore.getGameIcons(tbl3, arg1)

        return function(arg2)
            if next(var1) == nil then
                signal(arg2)
                return tbl1
            end

            local result = ({})
            for value, value2 in var1 do
                local var2 = value2.data(arg2)
                if var2 and var2.url then
                    result[value] = var2.url
                end
            end
            return result
        end
    end, { str1, arg1, bool1 })

    return SignalsReact.useSignalState(var1)
end

return useGameIconsForSize
