-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local Cryo = require(DataHydrationParent.Cryo)
local Signals = require(DataHydrationParent.Signals)

local Requests = require(DataHydration.Presence.Requests)
local _MultiGetPresenceByUserIds = require(script.Parent.Requests.MultiGetPresenceByUserIds)
local normalizePresenceRawData = require(script.Parent.normalizePresenceRawData)

local FFlagProfileCTAHydratePresenceFromMetadata = require(DataHydration.Flags.FFlagProfileCTAHydratePresenceFromMetadata)

local num1 = game:DefineFastInt("PresenceStorePollingTtlSec", 60)
local num2 = game:DefineFastInt("RTEPresenceStorePollingTtlSec", 0)

game:DefineFastInt("PresenceStoreProcessDelaySec", 1)
local function getFIntPresenceStoreProcessDelaySec(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastInt("PresenceStoreProcessDelaySec")
end

local function createPresenceStore()
    local cache = createDataCache(num1)

    local dataCache2 = createDataCache(not (num2 > 0) and math.huge or num2)
    local tbl1 = ({})
    local tbl2 = ({})

    local dataResolver = createDataResolver({
        cache = cache,
        queueProcessDelaySec = getFIntPresenceStoreProcessDelaySec(),
        fetchFn = function(tbl3)
            local var1 = Cryo.Dictionary.keys(tbl3)
            return Requests.MultiGetPresenceByUserIds(var1):andThen(function(arg1)
                local result = {}

                for _, value in arg1 and arg1.responseBody and arg1.responseBody.userPresences or {} do
                    local var2 = normalizePresenceRawData(value)
                    if var2 then
                        result[var2.id] = var2
                    end
                end

                return result
            end)
        end
    })

    local function disposeLockAwarePresenceEffects() -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, value in tbl2 do
            value()
        end
        table.clear(tbl2)
    end

    return {
        GetPresenceByUserId = function(str1: string, tbl3)
            if tbl3 and tbl3.skipFetch == true then
                return dataResolver.getCachedItem(str1)
            end

            if tbl2[str1] == nil then
                tbl2[str1] = Signals.createEffect(function(arg1)
                    local var1, _ = dataCache2.getItem(str1)
                    local cachedItem = dataResolver.getCachedItem(str1)

                    if var1.data(arg1) == true and cachedItem ~= nil then
                        return
                    end

                    dataResolver.getAndFetchItem(str1)
                end)
            end

            return dataResolver.getCachedItem(str1)
        end,
        UpdateUserPresence = function(str1: string, arg1, tbl3)
            if FFlagProfileCTAHydratePresenceFromMetadata and tbl3 and tbl3.isRealtimeUnknown then
                cache.replaceItem(str1, arg1)
                return
            end

            cache.replaceItem(str1, arg1)

            local bool1 = not not (tbl3 and tbl3.isUpdatedRealtime == true)
            dataCache2.replaceItem(str1, bool1)
            tbl1[str1] = bool1
        end,
        RefreshPresenceByUserId = function(str1: string)
            dataResolver.fetchItem(str1)
        end,
        clear = function()
            disposeLockAwarePresenceEffects()
            dataCache2.clear()
            dataResolver.clear()
        end,
        dispose = function()
            disposeLockAwarePresenceEffects()
            dataCache2.dispose()
            dataResolver.dispose()
        end
    }
end
return createPresenceStore
