-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local CatalogItemCard = require(ProfilePlatformParent.AvatarExperienceCommon).Components.CatalogItemCard.CatalogItemCard
local ItemCardThumbnail = require(ProfilePlatformParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail

local UserLib = require(ProfilePlatformParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local Enums = require(ProfilePlatform.Common.Enums)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local FFlagProfilePlatformFixResaleLimitedPrice = require(ProfilePlatform.Flags.FFlagProfilePlatformFixResaleLimitedPrice)

local function MarketplaceAssetTile(tbl1)
    local var1 = useLocalization({ free = TextKeys.CatalogLabelFree, offSale = TextKeys.CatalogLabelOffSale })
    local var2 = if tbl1.itemType == Enums.ItemTypes.Bundle then Constants.RbxthumbTypes.BundleThumbnail else Constants.RbxthumbTypes.Asset
    local var3 = nil
    local var4

    if tbl1.isOffSale then
        var4 = FFlagProfilePlatformFixResaleLimitedPrice
            and tbl1.lowestResalePrice
            and tbl1.lowestResalePrice > 0
            and {
                type = Enums.PriceLineContentType.Price,
                price = tbl1.lowestResalePrice
            }
            or {
                type = Enums.PriceLineContentType.Text,
                text = var1.offSale
            }
    else
        var4 = tbl1.price == 0 and {
            type = Enums.PriceLineContentType.Text,
            text = var1.free
        }
            or tbl1.price and {
                type = Enums.PriceLineContentType.Price,
                price = tbl1.price
            }
            or var3
    end

    return React.createElement(CatalogItemCard, {
        title = tbl1.name,
        presentationSlot = React.createElement(ItemCardThumbnail, { url = getRbxthumbWithTypeSizeAndOptions(tbl1.assetId, var2, 150) }),
        onActivated = tbl1.onActivated,
        priceLineContent = var4,
        Size = UDim2.fromScale(1, 1),
        Selectable = true
    })
end

return MarketplaceAssetTile
