-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local SquareCollectionGridView = require(ProfilePlatform.BaseComponents.CollectionGridViews.SquareCollectionGridView)
local AvatarExperienceCommon = require(ProfilePlatformParent.AvatarExperienceCommon)
local CatalogItemCard = AvatarExperienceCommon.Components.CatalogItemCard.CatalogItemCard
local ItemRestrictions = AvatarExperienceCommon.Enums.ItemRestrictions
local ItemCardThumbnail = require(ProfilePlatformParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local Enums = require(ProfilePlatform.Common.Enums)
local UserLib = require(ProfilePlatformParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FFlagProfileStoreEnableFreeItemPriceLabelFix = require(ProfilePlatform.Flags.FFlagProfileStoreEnableFreeItemPriceLabelFix)
local FFlagProfileStoreShowLimitedResalePrice = require(ProfilePlatform.Flags.FFlagProfileStoreShowLimitedResalePrice)

local Asset = Constants.RbxthumbTypes.Asset
local BundleThumbnail = Constants.RbxthumbTypes.BundleThumbnail
local function getItemHeight(num1: number): number
    return num1 + 49
end

local function isLimitedItem(arg1)
    local itemRestrictions = arg1.itemRestrictions
    if not itemRestrictions then
        return false
    end
    for _, itemRestriction in itemRestrictions do
        if itemRestriction == ItemRestrictions.Limited
            or itemRestriction == ItemRestrictions.LimitedUnique
            or itemRestriction == ItemRestrictions.Collectible
        then
            return true
        end
    end
    return false
end

local function isOnlyAvailableFromResale(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1.hasResellers and arg1.lowestResalePrice and arg1.lowestResalePrice > 0) then
        return false
    end
    local bool1 = not isLimitedItem(arg1)

    if not bool1 then
        if arg1.unitsAvailableForConsumption == nil then
            bool1 = false
        else
            bool1 = arg1.unitsAvailableForConsumption > 0
        end
    end

    return arg1.isOffSale == true or not bool1
end

local function StoreGrid(tbl1)
    local var1 = useLocalization({ store = TextKeys.Store, free = TextKeys.CatalogLabelFree })

    local renderItem = React.useCallback(function(arg1, layoutOrder: number)
        local var2 = if arg1.itemType == Enums.ItemTypes.Bundle then BundleThumbnail else Asset
        local var3 = arg1.price and {
            type = Enums.PriceLineContentType.Price,
            price = arg1.price
        }
        local var4 = FFlagProfileStoreEnableFreeItemPriceLabelFix
            and arg1.price
            and arg1.price == 0
            and {
                type = Enums.PriceLineContentType.Text,
                text = var1.free
            }
            or var3

        if FFlagProfileStoreShowLimitedResalePrice and arg1.lowestResalePrice then
            var4 = isOnlyAvailableFromResale(arg1) and {
                type = Enums.PriceLineContentType.Price,
                price = arg1.lowestResalePrice
            } or var4
        end

        local createElement = React.createElement
        local var5 = CatalogItemCard

        local tbl2 = {
            LayoutOrder = layoutOrder,
            title = arg1.name,
            presentationSlot = React.createElement(ItemCardThumbnail, { url = getRbxthumbWithTypeSizeAndOptions(arg1.id, var2, 150) }),
            onActivated = function()
                tbl1.openItemDetails(arg1.id, arg1.itemType, layoutOrder)
            end,
            priceLineContent = 0,
            AutomaticSize = 0
        }
        if not (FFlagProfileStoreEnableFreeItemPriceLabelFix or FFlagProfileStoreShowLimitedResalePrice) then
            var4 = arg1.price and {
                type = Enums.PriceLineContentType.Price,
                price = arg1.price
            }
        end

        tbl2.priceLineContent = var4

        tbl2.AutomaticSize = Enum.AutomaticSize.Y
        return createElement(var5, tbl2), "ItemCard"
    end, { tbl1.openItemDetails })

    return React.createElement(SquareCollectionGridView, {
        layoutOrder = tbl1.layoutOrder,
        items = tbl1.assets,
        renderItem = renderItem,
        getItemHeight = getItemHeight,
        title = var1.store,
        onActivateHeader = tbl1.navigateToCatalogSearch,
        overrides = {
            numColumns = tbl1.numColumns or 3
        }
    })
end

return StoreGrid
