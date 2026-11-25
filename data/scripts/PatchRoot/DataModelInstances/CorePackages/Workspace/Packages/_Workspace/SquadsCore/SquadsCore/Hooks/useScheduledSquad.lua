-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local React = require(SquadsCoreParent.React)
local Signals = require(SquadsCoreParent.Signals)

local GetScheduledSquadsStore = require(SquadsCore.Stores.GetScheduledSquadsStore)
local _Types = require(SquadsCore.Types)

local function useScheduledSquad(num1: number)
    local scheduledSquadsStore = GetScheduledSquadsStore(false)

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return scheduledSquadsStore.getScheduledSquadsStatus(arg1)[num1]
        end)
    end, { scheduledSquadsStore, num1 })

    local var2, var3 = React.useState(function()
        return var1(false)
    end)

    React.useLayoutEffect(function()
        var3(var1(false))
        return Signals.createEffect(function(arg1)
            var3(var1(arg1))
        end)
    end, { var1 })

    return var2
end

return useScheduledSquad
