-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
return require(AvatarExperienceCatalogParent.Rodux).makeActionCreator(script.Name, function(tbl1)
    return {
        hydratedBundles = tbl1.hydratedBundles,
        assetsInBundle = tbl1.assetsInBundle,
        hydratedAssets = tbl1.hydratedAssets
    }
end)
