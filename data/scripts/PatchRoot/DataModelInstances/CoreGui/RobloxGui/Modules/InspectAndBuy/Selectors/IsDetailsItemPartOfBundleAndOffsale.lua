-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    local assetId = arg1.detailsInformation.assetId
    if assetId == nil then
        return nil
    end
    local asset = arg1.assets[assetId]

    return asset and asset.parentBundleId ~= nil
end
