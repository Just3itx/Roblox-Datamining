-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)
local Cryo = require(AvatarExperienceInspectAndBuyParent.Cryo)
local Constants = AXCommon.Constants
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local ASSET_TYPE_TO_ACCESSORY_TYPE = Constants.ASSET_TYPE_TO_ACCESSORY_TYPE
local ASSET_TYPE_NAME_TO_ID_STRING = Constants.ASSET_TYPE_NAME_TO_ID_STRING
local ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP = Constants.ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP
local LAYERED_CLOTHING_ORDER = Constants.LAYERED_CLOTHING_ORDER
local LAYERED_ASSET_TYPES = Constants.LAYERED_ASSET_TYPES
local BODY_BUNDLE_TYPE_ID = Constants.BODY_BUNDLE_TYPE_ID
local SHOES_BUNDLE_TYPE_ID = Constants.SHOES_BUNDLE_TYPE_ID
local DYNAMIC_HEAD_BUNDLE_TYPE_ID = Constants.DYNAMIC_HEAD_BUNDLE_TYPE_ID

local _Types = require(AvatarExperienceInspectAndBuy.Types)

local function func1(itemSubType: string, itemId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        AssetId = tonumber(itemId) or 0,
        Order = LAYERED_CLOTHING_ORDER[itemSubType],
        AccessoryType = ASSET_TYPE_TO_ACCESSORY_TYPE[itemSubType],
        IsLayered = LAYERED_ASSET_TYPES[itemSubType] ~= nil
    }
end

local function func2(accessories, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return Cryo.List.filter(accessories, function(arg1)
        for _, value in tbl1 do
            if arg1.AccessoryType == value then
                return false
            end
        end
        return true
    end)
end

local function func3(assetsInBundle, tbl1)
    local result = {}

    for _, value in assetsInBundle do
        local assetType = value.assetType
        local id = value.id

        if not (assetType and id) then
            continue
        end

        local var1 = ASSET_TYPE_TO_ACCESSORY_TYPE[assetType]
        local bool1

        if tbl1 then
            bool1 = false
            for _, value2 in tbl1 do
                if var1 == value2 then
                    bool1 = true
                    break
                end
            end
        else
            bool1 = true
        end

        if bool1 and var1 then
            table.insert(result, func1(assetType, id))
        end
    end

    return result
end

local function func4(arg1, tbl1)
    local accessories = arg1:GetAccessories(true)

    local tbl2 = {}
    for _, value in tbl1 do
        table.insert(tbl2, value.AccessoryType)
    end

    local var1 = func2(accessories, tbl2)

    arg1:SetAccessories(Cryo.List.join(var1, tbl1), true)
end

return function(arg1, arg2)
    if arg1.itemType == ItemTypeEnum.Asset
        and (ASSET_TYPE_TO_ACCESSORY_TYPE[arg1.itemSubType] or ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[arg1.itemSubType])
    then
        local itemSubType = arg1.itemSubType
        local itemId = arg1.itemId
        local var1 = ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[itemSubType]

        if itemId and itemSubType ~= ASSET_TYPE_NAME_TO_ID_STRING.Gear and ASSET_TYPE_TO_ACCESSORY_TYPE[itemSubType] then
            local tbl1 = { (func1(itemSubType, itemId)) }
            func4(arg2, tbl1)
        elseif var1 and itemId then
            arg2[var1] = itemId
        end
    end

    if arg1.itemType == ItemTypeEnum.Bundle and arg1.assetsInBundle and arg1.itemSubType == BODY_BUNDLE_TYPE_ID then
        local tbl1 = func3(arg1.assetsInBundle, { Enum.AccessoryType.Hair })
        if #tbl1 > 0 then
            func4(arg2, tbl1)
        end

        for _, value in arg1.assetsInBundle do
            local assetType = value.assetType
            if not assetType then
                continue
            end

            local var1 = ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[assetType]

            if ASSET_TYPE_TO_ACCESSORY_TYPE[assetType] ~= Enum.AccessoryType.Hair and var1 and value.id then
                arg2[var1] = value.id
            end
        end
    end

    if arg1.itemSubType == SHOES_BUNDLE_TYPE_ID and arg1.assetsInBundle then
        local tbl1 = func3(arg1.assetsInBundle, { Enum.AccessoryType.LeftShoe, Enum.AccessoryType.RightShoe })

        if #tbl1 > 0 then
            func4(arg2, tbl1)
        end
    end

    if arg1.itemSubType ~= DYNAMIC_HEAD_BUNDLE_TYPE_ID or not arg1.assetsInBundle then
        return
    end

    for _, value in arg1.assetsInBundle do
        local assetType = value.assetType
        local id = value.id
        if not assetType then
            continue
        end

        local var1 = ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[assetType]
        if var1 and id then
            arg2[var1] = id
        end
    end
end
