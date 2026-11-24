-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local Promise = require(DataHydration.Parent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local playtestersRequests = require(script.Parent.playtestersRequests)
local _PrivatePlaytestersStoreTypes = require(script.Parent.PrivatePlaytestersStoreTypes)
local createPlayersGetterCache = require(script.Parent.createPlayersGetterCache)

local function createPrivatePlaytestersStore(arg1)
    local var1 = arg1 or {}
    local tbl1 = {
        network = var1.network,
        baseUrl = var1.baseUrl
    }
    local cache = createDataCache()

    local playersGetterCache = createPlayersGetterCache()

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            local var2 = tonumber(str1)
            return playtestersRequests.fetchPlaytesters(var2, tbl1)
        end,
        onClear = playersGetterCache.clear
    })

    return {
        MAX_INVITES = 10,
        getAndFetchInvitedPlayers = function(num1: number)
            local andFetchItem = dataResolver.getAndFetchItem(tostring(num1))
            return {
                players = playersGetterCache.getFor(andFetchItem.data),
                status = andFetchItem.status
            }
        end,
        sendInvites = function(num1: number, tbl2, _: string?)
            return playtestersRequests.fetchPlaytesters(num1, tbl1):andThen(function(tbl3)
                local num2 = math.max(0, 10 - #tbl3)
                local tbl4 = {}
                for _, value in tbl2 do
                    if num2 <= #tbl4 then
                        break
                    end

                    if table.find(tbl3, value) == nil then
                        table.insert(tbl4, value)
                    end
                end

                if #tbl4 == 0 then
                    cache.replaceItem(tostring(num1), tbl3)
                    return Promise.resolve({ added = {}, rejected = {} })
                end

                return playtestersRequests.addPlaytester(num1, tbl4, tbl1):andThen(function(tbl5)
                    cache.replaceItem(tostring(num1), tbl5)
                    local added = {}
                    local rejected = {}
                    for _, value in tbl4 do
                        if table.find(tbl5, value) ~= nil then
                            table.insert(added, value)
                        else
                            table.insert(rejected, value)
                        end
                    end
                    return { added = added, rejected = rejected }
                end)
            end)
        end,
        removeInvite = function(num1: number, num2: number)
            return playtestersRequests.removePlaytester(num1, num2, tbl1):andThen(function<T>(tbl2): T
                cache.replaceItem(tostring(num1), tbl2)
                return tbl2
            end)
        end
    }
end

return createPrivatePlaytestersStore
