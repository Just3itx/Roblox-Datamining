-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:50:58Z
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

local function subscribeGameInfo(tbl1)
    local gameInfoStore = DataHydration.Game.getGameInfoStore(false)
    local votesStore = DataHydration.Game.getVotesStore(false)

    local var1, var2 = Signals.createSignal((toId(tbl1.universeId)))
    local getCurrent = {}

    local dispose = Signals.createEffect(function(arg1)
        local var3 = var1(arg1)
        if var3 == nil then
            getCurrent = {}
        else
            getCurrent = {
                gameInfo = gameInfoStore.getGameInfo(var3).data(arg1),
                votes = votesStore.getVote(var3).data(arg1)
            }
        end

        tbl1.onChange(getCurrent)
    end)

    return {
        getCurrent = function()
            return getCurrent
        end,
        update = function(arg1)
            var2((toId(arg1)))
        end,
        dispose = dispose
    }
end

return subscribeGameInfo
