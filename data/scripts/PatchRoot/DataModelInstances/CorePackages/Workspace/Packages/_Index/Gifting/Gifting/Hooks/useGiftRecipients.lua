-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local DataHydration = require(GiftingParent.DataHydration)
local React = require(GiftingParent.React)
local Signals = require(GiftingParent.Signals)
local SignalsReact = require(GiftingParent.SignalsReact)

local _createCanGiftStore = require(Gifting.Stores.createCanGiftStore)
local _FindRecipientsResponseModel = require(Gifting.Models.FindRecipientsResponseModel)
local getCanGiftStore = require(Gifting.Stores.getCanGiftStore)
local itemGiftabilityCacheKey = require(Gifting.Stores.itemGiftabilityCacheKey)
local _Types = require(Gifting.Types)

local DataStatus = DataHydration.DataStatus
local buildItemGiftabilityKey = itemGiftabilityCacheKey.buildItemGiftabilityKey

local tbl1 = {}

local tbl2 = {
    recipients = {},
    isLoading = false,
    isLoadingMore = false,
    hasFailed = false,
    nextCursor = nil
}

local function buildItemsSignature(current)
    if current == nil or #current == 0 then
        return nil
    end

    local tbl3 = {}
    for _, value in current do
        table.insert(tbl3, buildItemGiftabilityKey(value))
    end
    return table.concat(tbl3, ",")
end

local function requestPages(arg1, items, searchTerm: string, tbl3, tbl4)
    local result = {}
    local function requestPage(cursor: string?)
        local var1 = tbl4[#result + 1]
        if var1 ~= nil and var1.query.cursor == cursor then
            table.insert(result, var1)
            return
        end
        local query = { items = items, searchTerm = searchTerm, cursor = cursor }
        table.insert(result, { query = query, result = arg1.getAndFetchRecipients(query) })
    end

    requestPage(nil)
    for _, value in tbl3 do
        requestPage(value)
    end
    return result
end

local function createPagesSignal(tbl3)
    return Signals.createComputed(function(arg1)
        local recipients = {}
        local bool1 = false
        local bool2 = false
        local bool3 = false
        local nextCursor = nil

        for value, value2 in tbl3 do
            local var1 = value2.result.status(arg1)
            local var2 = value2.result.data(arg1)

            if var1 == DataStatus.NotReady then
                if value == 1 then
                    bool1 = true
                else
                    bool2 = true
                end
            elseif var1 == DataStatus.Failed then
                bool3 = true
            end

            if var2 ~= nil and var1 ~= DataStatus.Failed then
                for _, recipient in var2.recipients do
                    table.insert(recipients, recipient)
                end
            end

            if value ~= #tbl3 then
                continue
            end

            if var1 == DataStatus.Ready and var2 ~= nil then
                nextCursor = var2.nextCursor
            else
                nextCursor = nil
            end
        end

        return {
            recipients = recipients,
            isLoading = bool1,
            isLoadingMore = bool2,
            hasFailed = bool3,
            nextCursor = nextCursor
        }
    end)
end

local computed = Signals.createComputed(function()
    return tbl2
end)

local function useGiftRecipients(current, str1: string?)
    local canGiftStore = getCanGiftStore(false)

    local str2 = str1 or ""
    local var1, var2 = React.useState(nil)

    local itemsSignature = buildItemsSignature(current)
    local searchKey = `{itemsSignature or ""}\000{str2}`
    local var3 = if var1 ~= nil and var1.searchKey == searchKey then var1.cursors else tbl1
    local var4 = React.useRef(current)
    var4.current = current

    local var5 = React.useRef(nil)
    local var6 = React.useMemo(function()
        local current2 = var4.current
        if current2 == nil or itemsSignature == nil then
            return {}
        end
        local current3 = var5.current
        local var6 = (current3 == nil or current3.searchKey ~= searchKey) and {} or current3.pages
        local pages = requestPages(canGiftStore, current2, str2, var3, var6)
        var5.current = { searchKey = searchKey, pages = pages }
        return pages
    end, {
        canGiftStore,
        itemsSignature,
        str2,
        var3
    })
    local var7 = React.useMemo(function()
        if #var6 == 0 then
            return computed
        end
        return createPagesSignal(var6)
    end, { var6 })

    local var8 = SignalsReact.useSignalState(var7)

    local nextCursor = var8.nextCursor
    local loadMore = React.useCallback(function()
        if nextCursor == nil then
            return
        end
        local cursors = table.clone(var3)
        table.insert(cursors, nextCursor)
        var2({ searchKey = searchKey, cursors = cursors })
    end, { nextCursor, var3, searchKey })

    local retry = React.useCallback(function()
        for _, value in var6 do
            if value.result.status(false) == DataStatus.Failed then
                canGiftStore.getAndFetchRecipients(value.query)
            end
        end
    end, { canGiftStore, var6 })

    return {
        recipients = var8.recipients,
        isLoading = var8.isLoading,
        isLoadingMore = var8.isLoadingMore,
        hasFailed = var8.hasFailed,
        hasMore = nextCursor ~= nil,
        loadMore = loadMore,
        retry = retry
    }
end

return useGiftRecipients
