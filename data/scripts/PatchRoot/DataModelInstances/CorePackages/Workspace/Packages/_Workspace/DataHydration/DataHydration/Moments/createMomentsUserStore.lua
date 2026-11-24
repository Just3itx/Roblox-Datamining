-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")

local Promise = require(DataHydrationParent.Promise)
local HttpClient = require(DataHydrationParent.HttpClient)
local Signals = require(DataHydrationParent.Signals)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local fetchUserMoments = require(script.Parent.Requests.fetchUserMoments)

local function paramsKey(targetUserId: number, cursor: string?): string -- Luacid: Inlined by compiler; 5 call sites recovered
    return HttpService:JSONEncode({ targetUserId = targetUserId, hasCursor = cursor ~= nil, cursor = cursor or "" })
end

local function createMomentsUserStore(arg1)
    local var1 = arg1 or {}
    local tbl1 = ({})

    local tbl2 = ({})

    local tbl3 = ({})
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            local var2 = tbl1[str1]
            if var2 == nil then
                return Promise.reject(`Missing user moments request params for {str1}`)
            end
            return HttpClient.asPromise(fetchUserMoments(var2.targetUserId, var2.cursor, var1.network))
        end
    })

    local function setParams(targetUserId: number, cursor: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local str1 = paramsKey(targetUserId, cursor)
        tbl1[str1] = { targetUserId = targetUserId, cursor = cursor }

        return str1
    end

    local function getCachedUserMoments(targetUserId: number, cursor: string?)
        return dataResolver.getCachedItem((setParams(targetUserId, cursor)))
    end

    local function fetchUserMomentsItem(targetUserId: number, cursor: string?)
        return dataResolver.fetchItem((setParams(targetUserId, cursor)))
    end

    local function getAndFetchUserMoments(targetUserId: number, cursor: string?)
        return dataResolver.getAndFetchItem((setParams(targetUserId, cursor)))
    end

    local function getUserMoments(targetUserId: number, cursor: string?)
        local str1 = paramsKey(targetUserId, cursor)
        local var2 = tbl2[str1]
        if var2 ~= nil then
            return var2
        end
        local var3 = HttpClient.asPromise(fetchUserMoments(targetUserId, cursor, var1.network))
        tbl2[str1] = var3
        tbl3[str1] = targetUserId
        var3:catch(function()
            tbl2[str1] = nil
            tbl3[str1] = nil
        end)
        return var3
    end

    local function getFreshUserMoments(num1: number, str1: string?)
        return HttpClient.asPromise(fetchUserMoments(num1, str1, var1.network))
    end

    local getUserMomentsVersion, var3 = Signals.createSignal(0)

    local getPendingUserMoments, var5 = Signals.createSignal({})

    local function evictUserMoments(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
        for value, value2 in tbl3 do
            if value2 == num1 then
                tbl2[value] = nil
                tbl3[value] = nil
            end
        end
    end

    return {
        getUserMoments = getUserMoments,
        getFreshUserMoments = getFreshUserMoments,
        getCachedUserMoments = getCachedUserMoments,
        fetchUserMoments = fetchUserMomentsItem,
        getAndFetchUserMoments = getAndFetchUserMoments,
        evictUserMoments = evictUserMoments,
        invalidateUser = function(num1: number)
            evictUserMoments(num1)
            var3(getUserMomentsVersion(false) + 1)
        end,
        getUserMomentsVersion = getUserMomentsVersion,
        getPendingUserMoments = getPendingUserMoments,
        prependPendingUserMoment = function(num1: number, moment, startedAtClock: number?)
            local var6 = table.clone(getPendingUserMoments(false))
            local var7 = table.clone(var6[num1] or {})
            table.insert(var7, 1, { moment = moment, startedAtClock = startedAtClock })
            var6[num1] = var7
            var5(var6)
        end,
        removePendingUserMoment = function(num1: number, momentId: string)
            local var6 = table.clone(getPendingUserMoments(false))
            local var7 = var6[num1]
            if var7 == nil then
                return
            end
            local tbl4 = {}
            for _, value in var7 do
                if value.moment.momentId ~= momentId then
                    table.insert(tbl4, value)
                end
            end
            if not (#tbl4 > 0) then
                tbl4 = nil
            end

            var6[num1] = tbl4
            var5(var6)
        end,
        resolvePendingUserMoment = function(num1: number, momentId: string, publishedMoment)
            local var6 = table.clone(getPendingUserMoments(false))
            local var7 = var6[num1] or {}
            local var8 = nil
            local feedItemId = publishedMoment.recommendationMetadata.feedItemId
            for value, value2 in var7 do
                if value2.moment.momentId == momentId then
                    var8 = value
                elseif value2.publishedMoment ~= nil then
                    local publishedMoment2 = value2.publishedMoment

                    if publishedMoment2.momentId == publishedMoment.momentId
                        or feedItemId ~= nil and feedItemId ~= "" and publishedMoment2.recommendationMetadata.feedItemId == feedItemId
                    then
                        return false
                    end
                end
            end
            if var8 == nil or var7[var8].status == "Moderated" then
                return false
            end
            local var9 = table.clone(var7)
            local var10 = table.clone(var7[var8])
            var10.publishedMoment = publishedMoment
            var9[var8] = var10
            var6[num1] = var9
            var5(var6)
            return true
        end,
        setPendingUserMomentStatus = function(num1: number, momentId: string, status)
            local var6 = getPendingUserMoments(false)[num1]
            if var6 == nil then
                return false
            end
            for value, value2 in var6 do
                if value2.moment.momentId ~= momentId then
                    continue
                end
                if value2.publishedMoment ~= nil or value2.status == "Moderated" then
                    return false
                end
                local var7 = table.clone(getPendingUserMoments(false))
                local var8 = table.clone(var6)
                local var9 = table.clone(value2)
                var9.status = status
                var8[value] = var9
                var7[num1] = var8
                var5(var7)
                return true
            end

            return false
        end,
        clear = function()
            var5({})
            tbl1 = {}
            tbl2 = {}
            tbl3 = {}
            dataResolver.clear()
        end,
        dispose = function()
            var5({})
            tbl1 = {}
            tbl2 = {}
            tbl3 = {}
            dataResolver.dispose()
        end
    }
end
return createMomentsUserStore
