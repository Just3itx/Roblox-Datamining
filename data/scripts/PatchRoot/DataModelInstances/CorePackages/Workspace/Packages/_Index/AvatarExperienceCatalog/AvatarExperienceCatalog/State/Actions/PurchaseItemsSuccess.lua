-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Rodux = require(AvatarExperienceCatalogParent.Rodux)

local _createAXShoppingCartStore = require(AvatarExperienceCatalog.Stores.createAXShoppingCartStore)

local FFlagAXMISSaveWearFix = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXMISSaveWearFix

return Rodux.makeActionCreator(script.Name, function(tbl1)
    return {
        equippableAssets = tbl1.equippableAssets,
        items = tbl1.items,
        replaceAllEquippedAssets = tbl1.replaceAllEquippedAssets,
        shouldClearEquippedMakeup = tbl1.shouldClearEquippedMakeup,
        bodyColor3s = tbl1.bodyColor3s,
        bodyScales = tbl1.bodyScales,
        bodyPartColorRangeIds = tbl1.bodyPartColorRangeIds,
        makeupAssetsOnHumanoid = if FFlagAXMISSaveWearFix then tbl1.makeupAssetsOnHumanoid else nil
    }
end)
