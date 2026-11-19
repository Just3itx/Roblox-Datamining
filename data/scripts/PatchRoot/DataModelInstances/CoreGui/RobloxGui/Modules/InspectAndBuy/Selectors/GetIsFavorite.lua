-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local IsDetailsItemPartOfBundleAndOffsale = require(scriptParentParent.Selectors.IsDetailsItemPartOfBundleAndOffsale)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)

return function(arg1)
    local assetId = arg1.detailsInformation.assetId
    if not assetId then
        return false
    end
    local var1 = IsDetailsItemPartOfBundleAndOffsale(arg1)
    if var1 == nil then
        return false
    end
    local asset = arg1.assets[assetId]
    if not asset then
        return false
    end

    if not var1 then
        return arg1.favorites.assets[assetId]
    end

    local bundleId = UtilityFunctions.getBundleId(asset)
    return arg1.favorites.bundles[bundleId]
end
