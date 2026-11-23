-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarEditorCategories = require(script.Enums.AvatarEditorCategories)
local AvatarEditorSubcategories = require(script.Enums.AvatarEditorSubcategories)
local CatalogCategories = require(script.Enums.CatalogCategories)
local CatalogCategoryTaxonomyUUIDs = require(script.Enums.CatalogCategoryTaxonomyUUIDs)
local Constants = require(script.Constants)
local FocusType = require(script.Enums.FocusType)
local HeadShape = require(script.Enums.HeadShape)
local InventoryOutfitType = require(script.Enums.InventoryOutfitType)
local ItemTypeEnum = require(script.Enums.ItemTypeEnum)
local ItemLicenseType = require(script.Enums.ItemLicenseType)
local RecommendationsType = require(script.Enums.RecommendationsType)
local _CommonTypes = require(script.Types.CommonTypes)
local _DiscountType = require(script.Types.DiscountType)
local _TimedOptionType = require(script.Types.TimedOptionType)
local _IncludedItem = require(script.Types.IncludedItem)
local _ItemExperienceData = require(script.Types.ItemExperienceData)
local _AXItemInfo = require(script.Types.AXItemInfo)
local _AXCollectibleItemInfo = require(script.Types.AXCollectibleItemInfo)
local _AXCollectibleInstance = require(script.Types.AXCollectibleInstance)
local _WidgetContentTypes = require(script.Types.WidgetContentTypes)
local _createAvatarSettingsStore = require(script.Stores.AvatarSettingsStore.createAvatarSettingsStore)

return {
    ["jest.config"] = script["jest.config"],
    Constants = Constants,
    Enums = {
        AvatarEditorCategories = AvatarEditorCategories,
        AvatarEditorSubcategories = AvatarEditorSubcategories,
        CatalogCategories = CatalogCategories,
        CatalogCategoryTaxonomyUUIDs = CatalogCategoryTaxonomyUUIDs,
        FocusType = FocusType,
        HeadShape = HeadShape,
        InventoryOutfitType = InventoryOutfitType,
        ItemTypeEnum = ItemTypeEnum,
        ItemLicenseType = ItemLicenseType,
        RecommendationsType = RecommendationsType
    },
    Stores = {
        getAvatarSettingsStore = require(script.Stores.AvatarSettingsStore.getAvatarSettingsStore),
        getLayeredClothingEntryPageStore = require(script.Stores.LayeredClothingEntryPageStore.getLayeredClothingEntryPageStore),
        getLayeredClothingLastSavedSortStore = require(script.Stores.LayeredClothingLastSavedSortStore.getLayeredClothingLastSavedSortStore)
    }
}
