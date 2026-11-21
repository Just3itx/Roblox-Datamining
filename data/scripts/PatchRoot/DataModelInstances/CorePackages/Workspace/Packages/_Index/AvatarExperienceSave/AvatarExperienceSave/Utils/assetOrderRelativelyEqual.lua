-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)

local function assetOrderRelativeEqual(arg1, arg2, tbl1)
    local tbl2 = {}

    local equippedAssets = arg1.equipped.EquippedAssets
    local equippedAssets2 = arg2.equipped.EquippedAssets

    if equippedAssets == nil and equippedAssets2 == nil then
        return true
    end

    if equippedAssets == nil or equippedAssets2 == nil then
        return false
    end

    for assetTypeId, equippedAsset in equippedAssets do
        if tbl1[assetTypeId] == nil then
            continue
        end

        for itemId, value2 in equippedAsset do
            if value2.order == nil then
                continue
            end

            table.insert(tbl2, { itemId = itemId, assetTypeId = assetTypeId, order = value2.order })
        end
    end

    for _, value in arg1.tryOn.OutfitTryOn.TryOnItems or {} do
        if tbl1[value.itemSubType] == nil or value.order == nil then
            continue
        end

        table.insert(tbl2, { itemId = value.itemId, assetTypeId = value.itemSubType, order = value.order })
    end

    table.sort(tbl2, function(arg3, arg4): boolean
        return arg3.order < arg4.order
    end)

    local order = nil
    for _, value in tbl2 do
        if order == nil then
            order = value.order
        end

        if equippedAssets2[value.assetTypeId] ~= nil and equippedAssets2[value.assetTypeId][value.itemId] ~= nil then
            if equippedAssets2[value.assetTypeId][value.itemId].order == nil
                or equippedAssets2[value.assetTypeId][value.itemId].order < order
            then
                return false
            end
            order = equippedAssets2[value.assetTypeId][value.itemId].order
        else
            local bool1 = false
            for _, value2 in arg2.tryOn.OutfitTryOn.TryOnItems or {} do
                if value.itemId ~= value2.itemId then
                    continue
                end

                if value2.order == nil or value2.order < order then
                    return false
                end

                order = value2.order
                bool1 = true
                break
            end

            if not bool1 then
                return false
            end
        end
    end

    return true
end

return assetOrderRelativeEqual
