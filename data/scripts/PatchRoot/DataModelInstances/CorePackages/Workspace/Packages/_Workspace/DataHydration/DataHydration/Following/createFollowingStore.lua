-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local Cryo = require(DataHydrationParent.Cryo)
local Promise = require(DataHydrationParent.Promise)

local Requests = require(script.Parent.Requests)
local _FollowingStoreTypes = require(script.Parent.FollowingStoreTypes)
local classifyFollowingError = require(script.Parent.classifyFollowingError)

game:DefineFastInt("FollowingStoreProcessDelaySec", 1)
local function getFIntFollowingStoreProcessDelaySec(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetFastInt("FollowingStoreProcessDelaySec")
end

local function normalizeId(userId) -- Luacid: Inlined by compiler; 3 call sites recovered
    if userId == nil then
        return nil
    end
    return tostring(userId)
end

local function createFollowingStore()
    local cache = createDataCache()
    local dataCache = createDataCache()

    local function fetchFollowingExists(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return Requests.GetFollowingExists(tbl1):andThen(function(arg1)
            local isFollowing = ({})
            local isFollowed = ({})

            for _, value in not arg1 and {} or not arg1.followings and {} or arg1.followings do
                local var1 = normalizeId(value.userId)
                if var1 then
                    isFollowing[var1] = value.isFollowing == true
                    isFollowed[var1] = value.isFollowed == true
                end
            end

            for _, value in tbl1 do
                if isFollowing[value] == nil then
                    isFollowing[value] = false
                end
                if isFollowed[value] == nil then
                    isFollowed[value] = false
                end
            end

            return { isFollowing = isFollowing, isFollowed = isFollowed }
        end)
    end

    local dataResolver = createDataResolver({
        cache = cache,
        queueProcessDelaySec = getFIntFollowingStoreProcessDelaySec(),
        requestBatchSize = 100,
        fetchFn = function(tbl1)
            return fetchFollowingExists((Cryo.Dictionary.keys(tbl1))):andThen(function(tbl2)
                dataCache.replaceItems(tbl2.isFollowed)
                return tbl2.isFollowing
            end)
        end,
        supportsMutations = true
    })

    local dataResolver2 = createDataResolver({
        cache = dataCache,
        queueProcessDelaySec = getFIntFollowingStoreProcessDelaySec(),
        requestBatchSize = 100,
        fetchFn = function(tbl1)
            return fetchFollowingExists((Cryo.Dictionary.keys(tbl1))):andThen(function(tbl2)
                cache.replaceItems(tbl2.isFollowing)
                return tbl2.isFollowed
            end)
        end,
        supportsMutations = true
    })

    local getOptimisticCachedItem = dataResolver.getOptimisticCachedItem
    local getOptimisticAndFetchItem = dataResolver.getOptimisticAndFetchItem
    local getOptimisticCachedItem2 = dataResolver2.getOptimisticCachedItem
    local getOptimisticAndFetchItem2 = dataResolver2.getOptimisticAndFetchItem

    local function writeFollowing(arg1, isFollowing: boolean, func1: (...any) -> (...any), arg2)
        dataResolver.setMutation(arg1, isFollowing)

        return func1(arg1, arg2):andThen(function()
            dataResolver.commitMutation(arg1)
            return { type = "success", isFollowing = isFollowing }
        end, function(arg3)
            dataResolver.clearMutation(arg1)
            return Promise.reject(classifyFollowingError(arg3))
        end)
    end

    return {
        GetIsFollowing = function(arg1, tbl1)
            if tbl1 and tbl1.skipFetch or dataResolver2.isRequestInQueueOrInFlight(arg1) then
                return getOptimisticCachedItem(arg1)
            end

            return getOptimisticAndFetchItem(arg1)
        end,
        GetIsFollowed = function(arg1, tbl1)
            if tbl1 and tbl1.skipFetch or dataResolver.isRequestInQueueOrInFlight(arg1) then
                return getOptimisticCachedItem2(arg1)
            end

            return getOptimisticAndFetchItem2(arg1)
        end,
        Follow = function(arg1, arg2)
            return writeFollowing(arg1, true, Requests.FollowUser, arg2)
        end,
        Unfollow = function(arg1, arg2)
            return writeFollowing(arg1, false, Requests.UnfollowUser, arg2)
        end,
        clear = function()
            dataResolver.clear()
            dataResolver2.clear()
        end,
        dispose = function()
            dataResolver.dispose()
            dataResolver2.dispose()
        end
    }
end
return createFollowingStore
