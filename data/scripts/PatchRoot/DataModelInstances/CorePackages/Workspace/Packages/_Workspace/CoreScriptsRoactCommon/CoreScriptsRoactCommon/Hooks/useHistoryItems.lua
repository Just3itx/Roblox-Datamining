-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommon = script:FindFirstAncestor("CoreScriptsRoactCommon")
local CoreScriptsRoactCommonParent = CoreScriptsRoactCommon.Parent

local DataHydration = require(CoreScriptsRoactCommonParent.DataHydration)
local Signals = require(CoreScriptsRoactCommonParent.Signals)
local SignalsReact = require(CoreScriptsRoactCommonParent.SignalsReact)
local React = require(CoreScriptsRoactCommonParent.React)

local Traversal = CoreScriptsRoactCommon.Traversal
local default = require(Traversal.LocalTraversalHistory).default

local getGameInfoStore = DataHydration.Game.getGameInfoStore
local getVotesStore = DataHydration.Game.getVotesStore

local function getNMostRecentUniqueUniverseIds(tbl1, _: number?)
    local nMostRecentUniqueUniverseIds = {}

    local tbl2 = ({})
    for _, value in tbl1 do
        if not tbl2[value] then
            tbl2[value] = true
            table.insert(nMostRecentUniqueUniverseIds, value)
        end
    end
    return nMostRecentUniqueUniverseIds
end

local function getHistoryInfo(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        name = arg1.name,
        placeId = tonumber(arg1.rootPlaceId),
        universeId = tonumber(arg1.universeId),
        rating = arg2.rating
    }
end

local function useHistoryItems(num1: number?)
    local num2 = num1 or 2
    local var1 = React.useMemo(function()
        return (Signals.createComputed(function(arg1)
            local result = {}

            local var1 = default:getUniverseHistorySignal(num2)(arg1)
            local nMostRecentUniqueUniverseIds = getNMostRecentUniqueUniverseIds(var1, num2)
            local var2 = getGameInfoStore(arg1).getAndFetchGameInfos(nMostRecentUniqueUniverseIds)
            local var3 = getVotesStore(arg1).getAndFetchVotes(nMostRecentUniqueUniverseIds)
            for _, nMostRecentUniqueUniverseId in nMostRecentUniqueUniverseIds do
                local var4 = if var2[nMostRecentUniqueUniverseId] and var2[nMostRecentUniqueUniverseId].data then var2[nMostRecentUniqueUniverseId].data(arg1) else nil
                local var5 = if var3[nMostRecentUniqueUniverseId] and var3[nMostRecentUniqueUniverseId].data then var3[nMostRecentUniqueUniverseId].data(arg1) else nil

                if var4 and var5 then
                    table.insert(result, getHistoryInfo(var4, var5))
                end
            end
            return result
        end))
    end, { num2, getGameInfoStore, getVotesStore })

    return (SignalsReact.useSignalState(var1))
end

return useHistoryItems
