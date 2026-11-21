-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FetchStatusRodux = script:FindFirstAncestor("FetchStatusRodux")
local SetFetchStatus = require(FetchStatusRodux.SetFetchStatus)
local FetchStatusNamespace = require(FetchStatusRodux.FetchStatusNamespace)

local FetchStatusRoduxParent = FetchStatusRodux.Parent
local RetrievalStatus = require(FetchStatusRoduxParent.Http).Enum.RetrievalStatus
local _DiscoveryTypes = require(FetchStatusRoduxParent.DiscoveryTypes)

local FFlagLuaAppSortDeeplinkFix = require(FetchStatusRoduxParent.SharedFlags).FFlagLuaAppSortDeeplinkFix

local function initializeFetchStatus()
    return {
        [FetchStatusNamespace.GameSortToken] = {
            Games = RetrievalStatus.NotStarted,
            HomeGames = RetrievalStatus.NotStarted,
            GamesSeeAll = RetrievalStatus.NotStarted,
            GamesList = if FFlagLuaAppSortDeeplinkFix then RetrievalStatus.NotStarted else nil
        },
        [FetchStatusNamespace.GameSorts] = {},
        [FetchStatusNamespace.OmniRecommendations] = {},
        [FetchStatusNamespace.SearchLandingPage] = {}
    }
end

return {
    key = "FetchStatusKey",
    reducer = function(arg1, arg2)
        arg1 = arg1 or initializeFetchStatus()

        if arg2.type ~= SetFetchStatus.name then
            return arg1
        end

        assert(arg1, "state should always exist, assert for linter")
        local fetchNamespace = arg2.fetchNamespace
        local fetchKey = arg2.fetchKey
        assert(fetchNamespace, "SetFetchStatus does not have a valid fetch namespace")
        assert(fetchKey, `SetFetchStatus does not have a valid fetch key for namespace {fetchNamespace}`)

        local var1 = arg1[fetchNamespace]
        if not var1 then
            warn(`No namespace {fetchNamespace} defined in FetchStatusReducer for action`)
            return arg1
        end
        assert(var1, "namespaceState should always exist, assert for linter")

        local var2 = table.clone(var1)
        var2[fetchKey] = arg2.fetchStatus

        local var3 = table.clone(arg1)
        var3[fetchNamespace] = var2
        return var3
    end
}
