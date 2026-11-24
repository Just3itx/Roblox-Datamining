-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Signals = require(DataHydrationParent.Signals)
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _BadgesTypes = require(script.Parent.BadgesTypes)
local requestRemoveBadge = require(script.Parent.requestRemoveBadge)
local BadgesUrlBuilder = require(script.Parent.BadgesUrlBuilder)

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local function createBadgeInfoStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getBadgeInfo = dataResolver.getCachedItem,
        getBadgeInfos = dataResolver.getCachedItems,
        updateBadges = cache.updateItems,
        removeBadge = function(badgeId: string)
            local var1, var2 = Signals.createSignal(nil)

            local var3 = cache.getItem(badgeId).data(false)
            local isEarnedByUser = if var3 then var3.isEarnedByUser else nil

            if isEarnedByUser == true then
                cache.updateItem(badgeId, { isEarnedByUser = false })
            end

            requestRemoveBadge(badgeId):andThen(function()
                var2({ type = "success" })
            end):catch(function(arg1)
                if var3 then
                    cache.updateItem(badgeId, { isEarnedByUser = isEarnedByUser })
                end

                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil

                if type(arg1) == "table" and arg1.StatusMessage then
                    arg1 = arg1.StatusMessage
                elseif type(arg1) ~= "string" then
                    arg1 = nil
                end
                var2({ type = "error", errorType = "NetworkError", statusCode = statusCode, statusMessage = arg1 })

                logResponseError(BadgesUrlBuilder.BADGE_REMOVE_URL, { StatusCode = statusCode })

                DiscoveryEventErrorLogger.reportError(
                    "removeBadge",
                    "Error removing badge",
                    {
                        badgeId = badgeId,
                        statusCode = statusCode,
                        method = "DELETE",
                        statusMessage = arg1
                    }
                )
            end)
            return var1
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createBadgeInfoStore
