-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)

local fetchAvatarInventoryPage = require(script.Parent.fetchAvatarInventoryPage)
local _AvatarInventoryStoreTypes = require(script.Parent.AvatarInventoryStoreTypes)

local getLocalPlayerUserId = DataHydrationUtils.getLocalPlayerUserId

local function createAvatarInventoryStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local dataCache = createDataCache()
    local dataCache2 = createDataCache()

    local num1 = 0

    local function storePage(items)
        local var1 = table.create(#items)
        local tbl4 = ({})
        local tbl5 = ({})
        for _, item in items do
            if item.itemId == nil then
                continue
            end

            local itemId = tostring(item.itemId)
            local itemType = item.itemCategory and item.itemCategory.itemType
            if itemType == Enum.AvatarItemType.Asset.Value then
                tbl4[itemId] = item
                table.insert(var1, { itemType = "Asset", itemId = itemId })
            elseif itemType == Enum.AvatarItemType.Bundle.Value then
                tbl5[itemId] = item
                table.insert(var1, { itemType = "Outfit", itemId = itemId })
            end
        end

        dataCache.replaceItems(tbl4)
        dataCache2.replaceItems(tbl5)
        return var1
    end

    return {
        fetchPage = function(arg1, str1: string?)
            local localPlayerUserId = getLocalPlayerUserId()
            local num2 = num1
            return fetchAvatarInventoryPage(arg1, str1, tbl3):andThen(function(arg2)
                if num2 ~= num1 or localPlayerUserId ~= getLocalPlayerUserId() then
                    error("AvatarInventory: dropped a page fetched before the store was reset")
                end
                return {
                    items = storePage(arg2.items),
                    nextPageToken = arg2.nextPageToken
                }
            end)
        end,
        getAsset = function(str1: string)
            return (dataCache.getItem(str1))
        end,
        getOutfit = function(str1: string)
            return (dataCache2.getItem(str1))
        end,
        clear = function()
            num1 += 1
            dataCache.clear()
            dataCache2.clear()
        end,
        dispose = function()
            num1 += 1
            dataCache.dispose()
            dataCache2.dispose()
        end
    }
end

return createAvatarInventoryStore
