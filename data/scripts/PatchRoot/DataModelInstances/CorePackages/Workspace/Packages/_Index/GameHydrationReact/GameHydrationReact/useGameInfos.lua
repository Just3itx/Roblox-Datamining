-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReactParent = script:FindFirstAncestor("GameHydrationReact").Parent

local React = require(GameHydrationReactParent.React)
local Signals = require(GameHydrationReactParent.Signals)
local SignalsReact = require(GameHydrationReactParent.SignalsReact)
local DataHydration = require(GameHydrationReactParent.DataHydration)

local signal = Signals.createSignal(false)
local tbl1 = {}

local function useGameInfos(tbl2)
    local tbl3 = {}
    for _, value in tbl2 do
        table.insert(tbl3, tostring(value))
    end
    table.sort(tbl3)

    local str1 = table.concat(tbl3, ",")

    local var1 = React.useMemo(function()
        if str1 == "" then
            return {}
        end

        return string.split(str1, ",")
    end, { str1 })

    local var2 = React.useMemo(function()
        local var2 = DataHydration.Game.getGameInfoStore(false).getGameInfos(var1)
        return function(arg1)
            if next(var2) == nil then
                signal(arg1)
                return tbl1
            end

            local result = ({})
            for value, value2 in var2 do
                local var3 = value2.data(arg1)
                if var3 then
                    result[value] = var3
                end
            end
            return result
        end
    end, { var1 })

    return SignalsReact.useSignalState(var2)
end

return useGameInfos
