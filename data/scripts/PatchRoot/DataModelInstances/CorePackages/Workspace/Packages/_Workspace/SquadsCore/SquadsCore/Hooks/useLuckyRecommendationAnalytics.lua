-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local React = require(SquadsCoreParent.React)
local Cryo = require(SquadsCoreParent.Cryo)

local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local GetLuckyRecommendationStore = require(SquadsCore.Stores.GetLuckyRecommendationStore)

local function useLuckyRecommendationAnalytics(luckyRecommendationSessionId: string)
    local luckyRecommendationStore = GetLuckyRecommendationStore(false)
    local var1 = React.useContext(SquadExternalContractContext)
    local localUserId = tonumber(useLocalUserId()) or 0

    return (React.useMemo(function()
        return {
            fire = function(str2: string, tbl1)
                local analyticsContext = luckyRecommendationStore.getAnalyticsContext()
                local tbl2 = {
                    luckyRecommendationSessionId = luckyRecommendationSessionId,
                    localUserId = localUserId,
                    pickRequestId = analyticsContext.pickRequestId,
                    revealType = analyticsContext.revealType,
                    clientTimestamp = os.time()
                }
                if tbl1 then
                    tbl2 = Cryo.Dictionary.join(tbl2, tbl1)
                end
                var1.fireSquadAnalytics(str2, tbl2)
            end,
            getContext = function()
                return luckyRecommendationStore.getAnalyticsContext()
            end
        }
    end, {
        luckyRecommendationSessionId,
        localUserId,
        luckyRecommendationStore.getAnalyticsContext,
        var1.fireSquadAnalytics
    }))
end
return useLuckyRecommendationAnalytics
