-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local PriceFooter = require(script.Parent.PriceFooter)

local UserLib = require(ProfilePlatformParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local UIBlox = require(ProfilePlatformParent.UIBlox)

local Enums = require(ProfilePlatform.Common.Enums)

local FFlagProfilePlatformEnableBundlesInAssetsCarousel = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableBundlesInAssetsCarousel

local FFlagProfilePlatformFixResaleLimitedPrice = require(ProfilePlatform.Flags.FFlagProfilePlatformFixResaleLimitedPrice)

local ItemTile = UIBlox.Tile.ItemTile

local function AssetTile(tbl1)
    local var1 = if FFlagProfilePlatformEnableBundlesInAssetsCarousel and tbl1.itemType and tbl1.itemType == Enums.ItemTypes.Bundle then Constants.RbxthumbTypes.BundleThumbnail else Constants.RbxthumbTypes.Asset
    local thumbnail = getRbxthumbWithTypeSizeAndOptions(tbl1.assetId, var1, 150)

    local createElement = React.createElement
    local var2 = ItemTile
    local tbl2 = {
        name = tbl1.name,
        thumbnail = thumbnail,
        onActivated = tbl1.onActivated,
        useMaxTitleHeight = false,
        titleTextLineCount = 1,
        footer = React.createElement(PriceFooter, {
            price = tbl1.price,
            isOffSale = tbl1.isOffSale,
            lowestResalePrice = if FFlagProfilePlatformFixResaleLimitedPrice then tbl1.lowestResalePrice else nil
        }),
        Selectable = true
    }
    return createElement(var2, tbl2)
end

return AssetTile
