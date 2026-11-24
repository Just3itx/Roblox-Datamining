-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local Signals = require(DataHydrationParent.Signals)
local Url = require(DataHydrationParent.Http).Url

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _CommunityUserMembershipStoreTypes = require(script.Parent.CommunityUserMembershipStoreTypes)
local requestJoinCommunity = require(script.Parent.requestJoinCommunity)

local str1 = `{Url.GROUPS_URL}v1/groups/`

local function createCommunityUserMembershipStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end,
        supportsMutations = true
    })

    local function applyOptimisticMembership(communityId: string)
        local var1, var2 = Signals.createSignal(nil)

        dataResolver.setMutation(communityId, { canJoin = false })

        return var1, function(arg1)
            if arg1 and arg1.type == "error" then
                dataResolver.clearMutation(communityId)
            else
                dataResolver.commitMutation(communityId)
            end
            var2(arg1)
        end
    end

    return {
        getMembership = dataResolver.getOptimisticCachedItem,
        getMemberships = dataResolver.getOptimisticCachedItems,
        updateMembership = cache.updateItem,
        updateMemberships = cache.updateItems,
        joinCommunity = function(communityId: string)
            local var1, func1 = applyOptimisticMembership(communityId)

            requestJoinCommunity(communityId):andThen(function()
                func1({ type = "success" })
            end):catch(function(arg1)
                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil

                if type(arg1) == "table" and arg1.StatusMessage then
                    arg1 = arg1.StatusMessage
                elseif type(arg1) ~= "string" then
                    arg1 = nil
                end

                func1({ type = "error", statusCode = statusCode, statusMessage = arg1 })

                logResponseError(str1, { StatusCode = statusCode })
                DiscoveryEventErrorLogger.reportError(
                    "joinCommunity",
                    "Error joining community",
                    {
                        communityId = communityId,
                        statusCode = statusCode,
                        method = "POST",
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

return createCommunityUserMembershipStore
