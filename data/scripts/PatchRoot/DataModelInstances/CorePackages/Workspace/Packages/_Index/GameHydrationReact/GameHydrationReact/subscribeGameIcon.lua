-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReactParent = script:FindFirstAncestor("GameHydrationReact").Parent

local Signals = require(GameHydrationReactParent.Signals)
local DataHydration = require(GameHydrationReactParent.DataHydration)

local function toId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 ~= nil then
        return tostring(arg1)
    end

    return nil
end

local function subscribeGameIcon(tbl1)
    local gameIconStore = DataHydration.Game.getGameIconStore(false)

    local var1 = toId(tbl1.universeId)
    local var2, var3 = Signals.createSignal(var1)
    local getCurrent = nil

    local bool1 = true
    local dispose = Signals.createEffect(function(arg1)
        local var5 = var2(arg1)
        if var5 == nil then
            getCurrent = nil
        else
            getCurrent = gameIconStore.getGameIcon(var5, tbl1.size).data(arg1)
        end

        if bool1 then
            bool1 = false
            return
        end
        tbl1.onChange(getCurrent)
    end)

    return {
        getCurrent = function()
            return getCurrent
        end,
        update = function(arg1)
            var3((toId(arg1)))
        end,
        dispose = dispose
    }
end

return subscribeGameIcon
