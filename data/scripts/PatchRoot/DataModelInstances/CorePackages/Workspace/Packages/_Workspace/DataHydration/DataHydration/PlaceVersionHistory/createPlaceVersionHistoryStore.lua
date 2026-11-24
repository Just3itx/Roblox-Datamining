-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local _HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local Signals = require(DataHydrationParent.Signals)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchPlaceVersionHistory = require(script.Parent.fetchPlaceVersionHistory)
local _PlaceVersionHistoryStoreTypes = require(script.Parent.PlaceVersionHistoryStoreTypes)

local function createPlaceVersionHistoryStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl,
        developBaseUrl = tbl2.developBaseUrl
    }

    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchPlaceVersionHistory.fetchHistory(num1, tbl3)
    end)

    local singleEntityResolver2 = createSingleEntityResolver(function(num1: number)
        return fetchPlaceVersionHistory.fetchHistory(num1, tbl3, { isPublished = true, pageSize = 1 }):andThen(function(arg1)
            return {
                placeVersion = arg1.placeVersions[1]
            }
        end)
    end, {
        resolver = { replaceItems = true }
    })

    local function fetchPageHistory(num1: number, arg1)
        return fetchPlaceVersionHistory.fetchHistory(num1, tbl3, arg1):andThen(function<T>(arg2: T): T
            singleEntityResolver.update(num1, arg2)
            return arg2
        end)
    end

    local tbl4 = ({})

    local var1 = Promise.resolve()

    local function getFetchingMoreHistorySignal(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl5 = tbl4[num1]
        if tbl5 == nil then
            local getIsFetching, setIsFetching = Signals.createSignal(false)
            tbl5 = { getIsFetching = getIsFetching, setIsFetching = setIsFetching }

            tbl4[num1] = tbl5
        end
        return tbl5
    end

    return {
        getHistory = singleEntityResolver.get,
        fetchHistory = singleEntityResolver.fetch,
        getAndFetchHistory = singleEntityResolver.getAndFetch,
        updateHistory = singleEntityResolver.update,
        fetchPageHistory = fetchPageHistory,
        fetchMoreHistory = function(num1: number, cursor: string)
            local var2 = singleEntityResolver.get(num1).data(false)
            local fetchingMoreHistorySignal = getFetchingMoreHistorySignal(num1)

            if var2 == nil
                or not var2.hasMore
                or var2.nextCursor ~= cursor
                or cursor == ""
                or fetchingMoreHistorySignal.getIsFetching(false)
            then
                return var1
            end
            fetchingMoreHistorySignal.setIsFetching(true)
            local var3 = fetchPlaceVersionHistory.fetchHistory(
                num1,
                tbl3,
                {
                    cursor = cursor,
                    pageSize = fetchPlaceVersionHistory.DEFAULT_HISTORY_PAGE_SIZE
                }
            ):andThen(
                function(arg1)
                    if singleEntityResolver.get(num1).data(false) ~= var2 then
                        return
                    end

                    singleEntityResolver.cache.replaceItem(tostring(num1), {
                        hasMore = arg1.hasMore and arg1.nextCursor ~= cursor,
                        nextCursor = arg1.nextCursor,
                        placeVersions = Cryo.List.join(var2.placeVersions or {}, arg1.placeVersions or {})
                    })
                end
            )

            var3:finally(function()
                fetchingMoreHistorySignal.setIsFetching(false)
            end)
            return var3
        end,
        getIsFetchingMoreHistory = function(num1: number)
            return getFetchingMoreHistorySignal(num1).getIsFetching
        end,
        getLiveVersion = singleEntityResolver2.get,
        fetchLiveVersion = singleEntityResolver2.fetch,
        getAndFetchLiveVersion = singleEntityResolver2.getAndFetch,
        revertVersion = function(num1: number, assetId: number, assetVersionNumber: number)
            return fetchPlaceVersionHistory.revertVersion(assetId, assetVersionNumber, tbl3):andThen(function(_)
                local tbl5 = { assetId = assetId, assetVersionNumber = assetVersionNumber }

                singleEntityResolver.fetch(num1)
                return tbl5
            end):catch(function(arg1)
                error(arg1)
            end)
        end,
        rollbackPlace = function(num1: number, num2: number, str1: string?, bool1: boolean?)
            return fetchPlaceVersionHistory.rollbackPlace(num1, num2, str1, bool1, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver.fetch(num1)
                return arg1
            end):catch(function(arg1)
                error(arg1)
            end)
        end,
        addVersionNote = function(num1: number, version: string, arg1)
            return fetchPlaceVersionHistory.addVersionNote(num1, version, arg1, tbl3):andThen(function(arg2)
                local var2 = singleEntityResolver.get(num1).data(false)
                if var2 == nil or typeof(var2.placeVersions) ~= "table" then
                    return arg2
                end
                local placeVersions = ({})
                for k, placeVersion in var2.placeVersions do
                    if placeVersion.version == version then
                        local tbl6 = ({})
                        for value, value2 in placeVersion do
                            tbl6[value] = value2
                        end
                        tbl6.title = arg1.title
                        tbl6.description = arg1.description
                        placeVersions[k] = tbl6
                    else
                        placeVersions[k] = placeVersion
                    end
                end
                singleEntityResolver.cache.replaceItem(
                    tostring(num1),
                    {
                        hasMore = var2.hasMore,
                        nextCursor = var2.nextCursor,
                        placeVersions = placeVersions
                    }
                )
                return arg2
            end)
        end,
        clear = function()
            singleEntityResolver.clear()
            singleEntityResolver2.clear()
        end,
        dispose = function()
            singleEntityResolver.dispose()
            singleEntityResolver2.dispose()
        end
    }
end
return createPlaceVersionHistoryStore
