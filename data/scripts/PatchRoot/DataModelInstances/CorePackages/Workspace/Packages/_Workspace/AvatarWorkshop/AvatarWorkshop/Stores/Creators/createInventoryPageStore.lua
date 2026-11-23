-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local createSignal = require(AvatarWorkshopParent.Signals).createSignal

local AvatarInventory = require(AvatarWorkshopParent.DataHydration.AvatarInventory)
local _InventoryPagesData = require(AvatarWorkshop.Constants.InventoryPagesData)

local function getQuery(arg1)
    if not arg1.assetTypes then
        return if arg1.outfitInventoryType then {
            outfitInventoryTypes = { arg1.outfitInventoryType }
        } else nil
    end

    local assetTypeIds = table.create(#arg1.assetTypes)
    for _, value in arg1.assetTypes do
        table.insert(assetTypeIds, value.Value)
    end
    return { assetTypeIds = assetTypeIds }
end

local function createInventoryPageStore(arg1, arg2)
    local var1 = arg2 or AvatarInventory.getAvatarInventoryStore(false)
    local query = getQuery(arg1)

    local getEntries, var3 = createSignal({})
    local getDidInitialFetch, var5 = createSignal(false)
    local getLastPageReached, var7 = createSignal(false)
    local getIsFetching, var9 = createSignal(false)
    local getHasFetchError, var11 = createSignal(false)

    local nextPageToken = nil

    local function applyPage(arg3)
        nextPageToken = arg3.nextPageToken
        var7(arg3.nextPageToken == nil)
        if #arg3.items > 0 then
            local var12 = table.clone(getEntries(false))
            table.move(arg3.items, 1, #arg3.items, #var12 + 1, var12)
            var3(var12)
        end
    end

    return {
        getEntries = getEntries,
        getDidInitialFetch = getDidInitialFetch,
        getLastPageReached = getLastPageReached,
        getIsFetching = getIsFetching,
        getHasFetchError = getHasFetchError,
        fetchNextPage = function()
            if getIsFetching(false) or getLastPageReached(false) then
                return
            end

            if not query then
                warn("createInventoryPageStore: pageData must specify assetTypes or outfitInventoryType")
                return
            end

            var9(true)
            var11(false)

            var1.fetchPage(query, nextPageToken):andThen(applyPage):catch(function(arg3)
                if typeof(arg3) == "table" then
                    arg3 = arg3.errorMessage
                end

                warn("createInventoryPageStore: avatar-inventory fetch failed:", arg3)
                var11(true)
            end):finally(function()
                var5(true)
                var9(false)
            end)
        end
    }
end

return createInventoryPageStore
