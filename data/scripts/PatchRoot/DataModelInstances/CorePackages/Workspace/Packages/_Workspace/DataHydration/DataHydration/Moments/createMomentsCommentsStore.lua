-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local Signals = require(DataHydrationParent.Signals)
local LocalUserIdStore = require(DataHydrationParent.LocalUserIdStore).LocalUserIdStore
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)

local function createMomentsCommentsStore(_)
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_: string, _)
            return Promise.reject("Moments comments V1 has no get-comment-by-id API")
        end
    })
    local dataCache2 = createDataCache()
    local getOwnerGeneration, var2 = Signals.createSignal(0)

    local function normalizeOwnerId(arg1): string -- Luacid: Inlined by compiler; 5 call sites recovered
        if arg1 == nil or arg1 == "" then
            return ""
        end
        local str1 = tostring(arg1)
        local var3 = tonumber(str1)
        return if var3 == nil or not (var3 <= 0) then str1 else ""
    end

    local function getGenerationAwareResult(arg1, num1: number)
        return {
            data = function(arg2)
                if getOwnerGeneration(arg2) ~= num1 then
                    return nil
                end
                return arg1.data(arg2)
            end,
            status = function(arg2)
                if getOwnerGeneration(arg2) ~= num1 then
                    return DataHydrationTypes.DataStatus.NotReady
                end
                return arg1.status(arg2)
            end
        }
    end

    local function clearCaches() -- Luacid: Inlined by compiler; 4 call sites recovered
        dataResolver.clear()
        dataCache2.clear()
    end

    local function invalidate() -- Luacid: Inlined by compiler; 3 call sites recovered
        clearCaches()
        var2(getOwnerGeneration(false) + 1)
    end

    local str1 = normalizeOwnerId((LocalUserIdStore.getCurrentUserId(false)))
    local str2 = normalizeOwnerId((DataHydrationUtils.getLocalPlayerUserId()))
    local str3 = if str1 ~= "" then str1 else str2

    local function handleOwnerChange(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local str4 = normalizeOwnerId(arg1)

        if str4 == str3 then
            return
        end
        str3 = str4
        invalidate()
    end

    local var3 = DataHydrationUtils.observeLocalPlayerUserId(handleOwnerChange)
    local str4 = str1
    local effect = Signals.createEffect(function(arg1)
        local str5 = normalizeOwnerId((LocalUserIdStore.getCurrentUserId(arg1)))
        if str5 == str4 then
            return
        end
        str4 = str5
        handleOwnerChange(str5)
    end)

    local bool1 = false

    return {
        getCachedComment = function(str5: string)
            local var4 = getOwnerGeneration(false)
            local cachedItem = dataResolver.getCachedItem(str5)
            return (getGenerationAwareResult(cachedItem, var4))
        end,
        getCachedMomentComments = function(str5: string)
            local var4 = getOwnerGeneration(false)
            local item = dataCache2.getItem(str5)
            return (getGenerationAwareResult(item, var4))
        end,
        upsertComments = function(tbl1, num1: number?)
            if num1 ~= nil and num1 ~= getOwnerGeneration(false) then
                return
            end
            local tbl2 = {}
            for _, value in tbl1 do
                tbl2[value.commentId] = value
            end
            cache.replaceItems(tbl2)
        end,
        upsertMomentComments = function(arg1, num1: number?)
            if num1 ~= nil and num1 ~= getOwnerGeneration(false) then
                return
            end
            dataCache2.replaceItems(arg1)
        end,
        getOwnerGeneration = getOwnerGeneration,
        clear = function()
            invalidate()
        end,
        dispose = function()
            if bool1 then
                return
            end
            bool1 = true
            var3()
            effect()
            var2(getOwnerGeneration(false) + 1)
            dataResolver.dispose()
            dataCache2.dispose()
        end
    }
end
return createMomentsCommentsStore
