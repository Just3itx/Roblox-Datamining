-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local React = require(SquadsCoreParent.React)
local Signals = require(SquadsCoreParent.Signals)

local GetLuckyRecommendationStore = require(SquadsCore.Stores.GetLuckyRecommendationStore)

local function useLuckyRecommendation()
    local luckyRecommendationStore = GetLuckyRecommendationStore(false)

    local state, var2 = React.useState(function()
        return luckyRecommendationStore.getState(false)
    end)

    React.useLayoutEffect(function()
        return Signals.createEffect(function(arg1)
            var2(luckyRecommendationStore.getState(arg1))
        end)
    end, { luckyRecommendationStore.getState })

    return {
        state = state,
        actions = React.useMemo(function()
            return {
                startRoll = luckyRecommendationStore.startRoll,
                endRoll = luckyRecommendationStore.endRoll,
                cancelFetch = luckyRecommendationStore.cancelFetch
            }
        end, { luckyRecommendationStore.startRoll, luckyRecommendationStore.endRoll, luckyRecommendationStore.cancelFetch })
    }
end

return useLuckyRecommendation
