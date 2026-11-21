-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local DataHydration = require(GiftingParent.DataHydration)
local Promise = require(GiftingParent.Promise)
local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver

local _CanGiftResponseModel = require(Gifting.Models.CanGiftResponseModel)
local _FindRecipientsResponseModel = require(Gifting.Models.FindRecipientsResponseModel)
local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local postCanGift = require(Gifting.WebApi.postCanGift)
local postFindRecipients = require(Gifting.WebApi.postFindRecipients)
local itemGiftabilityCacheKey = require(Gifting.Stores.itemGiftabilityCacheKey)
local _Types = require(Gifting.Types)

local DataStatus = DataHydration.DataStatus
local buildItemGiftabilityKey = itemGiftabilityCacheKey.buildItemGiftabilityKey
local parseItemGiftabilityKey = itemGiftabilityCacheKey.parseItemGiftabilityKey

local function buildRecipientsKey(tbl1): string
    local tbl2 = {}
    for _, item in tbl1.items do
        table.insert(tbl2, buildItemGiftabilityKey(item))
    end
    local input = { tbl2, tbl1.searchTerm or "", tbl1.cursor or "" }
    return HttpService:JSONEncode(input)
end

local function createCanGiftStore(tbl1)
    local var1 = if tbl1 and tbl1.postCanGift then tbl1.postCanGift else postCanGift
    local var2 = if tbl1 and tbl1.postFindRecipients then tbl1.postFindRecipients else postFindRecipients
    local network = if tbl1 then tbl1.network else nil
    local dataCache = createDataCache(45)

    local cache = createDataCache(45)
    local dataResolver = createDataResolver({
        cache = cache,
        replaceItems = true,
        requestBatchSize = 20,
        queueProcessDelaySec = 0,
        fetchFn = function(tbl2)
            local items = {}
            for value in tbl2 do
                local var3 = parseItemGiftabilityKey(value)
                if var3 ~= nil then
                    table.insert(items, var3)
                end
            end

            return var1({ items = items }, network):andThen(function(arg1)
                dataCache.replaceItem("sender", { eligibility = arg1.eligibility, requiredActions = arg1.requiredActions })

                local result = {}
                for _, item in arg1.items do
                    result[buildItemGiftabilityKey(item.item)] = item
                end
                return result
            end):catch(function(arg1)
                if dataCache.getItem("sender").status(false) ~= DataStatus.Ready then
                    dataCache.markItemsAsFailed({ "sender" })
                end
                return Promise.reject(arg1)
            end)
        end
    })

    local function isValidItem(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return not (arg1 == nil) and GiftModelUtils.nonEmptyString(arg1.itemId)
    end

    local function invalidItemResult() -- Luacid: Inlined by compiler; 2 call sites recovered
        local item = cache.getItem("invalid")
        cache.markItemsAsFailed({ "invalid" })
        return item
    end

    local tbl2 = ({})

    local dataCache2 = createDataCache(45, 0)
    local dataResolver2 = createDataResolver({
        cache = dataCache2,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string)
            local var3 = tbl2[str1]
            return var2({
                items = var3.items,
                searchTerm = if var3.searchTerm == "" then nil else var3.searchTerm,
                limit = 25,
                cursor = var3.cursor
            }, network)
        end
    })

    local function recipientsKeyFor(tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
        local recipientsKey = buildRecipientsKey(tbl3)
        tbl2[recipientsKey] = tbl3
        return recipientsKey
    end

    return {
        getSenderEligibility = function()
            return (dataCache.getItem("sender"))
        end,
        getAndFetchItemGiftability = function(arg1)
            if not isValidItem(arg1) then
                return invalidItemResult()
            end

            return (dataResolver.getAndFetchItem(buildItemGiftabilityKey(arg1)))
        end,
        getAndFetchItemGiftabilities = function(tbl3)
            local tbl4 = {}
            local bool1 = false
            for _, value in tbl3 do
                if isValidItem(value) then
                    table.insert(tbl4, buildItemGiftabilityKey(value))
                else
                    bool1 = true
                end
            end

            local andFetchItems = dataResolver.getAndFetchItems(tbl4)
            if bool1 then
                andFetchItems.invalid = invalidItemResult()
            end
            return andFetchItems
        end,
        getAndFetchRecipients = function(tbl3)
            local getAndFetchItem = dataResolver2.getAndFetchItem
            local str1 = recipientsKeyFor(tbl3)
            return (getAndFetchItem(str1))
        end,
        clear = function()
            dataCache.clear()
            dataResolver.clear()
            tbl2 = {}
            dataResolver2.clear()
        end,
        dispose = function()
            dataCache.dispose()
            dataResolver.dispose()
            tbl2 = {}
            dataResolver2.dispose()
        end
    }
end

return createCanGiftStore
