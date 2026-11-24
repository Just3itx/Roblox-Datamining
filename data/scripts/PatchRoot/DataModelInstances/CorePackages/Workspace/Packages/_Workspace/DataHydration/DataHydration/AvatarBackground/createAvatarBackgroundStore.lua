-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Signals = require(DataHydrationParent.Signals)
local Promise = require(DataHydrationParent.Promise)
local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)
local DataStatus = require(DataHydration.DataHydrationTypes).DataStatus

local fetchAvatarBackground = require(script.Parent.fetchAvatarBackground)
local getAvatarBackgroundImageUrl = require(script.Parent.getAvatarBackgroundImageUrl)
local _AvatarBackgroundStoreTypes = require(script.Parent.AvatarBackgroundStoreTypes)

local function createAvatarBackgroundStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local tbl4 = ({})

    local function rejectPending() -- Luacid: Inlined by compiler; 1 call site recovered
        local tbl5 = tbl4
        tbl4 = {}
        for _, value in tbl5 do
            value("avatar background store was cleared")
        end
    end

    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchAvatarBackground(num1, tbl3)
    end, {
        cache = {
            ttlSeconds = tbl2.ttlSeconds
        },
        resolver = { replaceItems = true, onClear = rejectPending }
    })

    local function getAndFetchAvatarBackground(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return (singleEntityResolver.getAndFetch(tonumber(arg1)))
    end

    return {
        getAndFetchAvatarBackground = getAndFetchAvatarBackground,
        getAndFetchAvatarBackgroundImageUrl = function(arg1, arg2)
            local var1 = getAndFetchAvatarBackground(arg1).data(arg2)
            local assetId = var1 and var1.assetId
            if assetId then
                return (getAvatarBackgroundImageUrl(assetId))
            end

            return nil
        end,
        awaitAvatarBackground = function(arg1)
            local andFetchAvatarBackground = getAndFetchAvatarBackground(arg1)

            return Promise.new(function(callback, callback2, callback3)
                local bool1 = false
                local effect = nil
                local tbl5 = {}
                local function settle() -- Luacid: Inlined by compiler; 2 call sites recovered
                    bool1 = true
                    tbl4[tbl5] = nil
                    if effect then
                        effect()
                    end
                end
                tbl4[tbl5] = function(arg2)
                    if bool1 then
                        return
                    end
                    bool1 = true
                    callback2(arg2)
                    task.defer(settle)
                end
                effect = Signals.createEffect(function(arg2)
                    local var1 = andFetchAvatarBackground.status(arg2)
                    if bool1 or var1 == DataStatus.NotReady then
                        return
                    end
                    if var1 == DataStatus.Ready then
                        callback(andFetchAvatarBackground.data(false) or {})
                    else
                        callback2("Avatar background lookup failed")
                    end

                    settle()
                end)

                if bool1 then
                    settle()
                end

                callback3(settle)
            end)
        end,
        clear = singleEntityResolver.clear,
        dispose = function()
            rejectPending()
            singleEntityResolver.dispose()
        end
    }
end

return createAvatarBackgroundStore
