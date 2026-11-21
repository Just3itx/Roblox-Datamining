-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent

local Constants = require(AvatarExperienceRoduxParent.AvatarExperienceCommon).Constants

local FFlagAXCatalogMakeupSupport = require(AvatarExperienceRoduxParent.AvatarExperienceFlags).FFlagAXCatalogMakeupSupport

local AssetTypeToAssetCategory = require(script.Parent.Parent.Constants).AssetTypeToAssetCategory

local _BodyColors = require(script.Parent.Parent.Types.BodyColors)
local _OutfitTryOn = require(script.Parent.Parent.Types.OutfitTryOn)

local LOOK_TYPE = Constants.LOOK_TYPE

local module = {}

function module.filterTryOns(arg1, arg2)
    local tbl1 = ({})
    local var1 = nil
    for value, value2 in arg1 do
        local var2 = AssetTypeToAssetCategory[arg2.itemSubType]
        local bool1 = not var2 or AssetTypeToAssetCategory[value2.itemSubType] ~= var2
        if value2.itemSubType ~= arg2.itemSubType and bool1 then
            tbl1[value] = value2
        else
            var1 = value2
        end
    end

    return tbl1, var1
end

function module.convertDefaultBodyColorRanges(tbl1)
    local result = {}
    for _, range in tbl1 do
        table.insert(result, { rangeId = range[1]:ToHex(), range = range })
    end
    return result
end

function module.generateTryOnItemIdKey(str1: string, arg1, arg2)
    if arg2 == nil or arg2 ~= LOOK_TYPE.Avatar and (not FFlagAXCatalogMakeupSupport or arg2 ~= LOOK_TYPE.Makeup) then
        return str1
    end

    return tostring(str1) .. "-" .. arg1
end

function module.generateRecommendedItemsKey(str1: string?, str2: string?): string
    return (str2 or "") .. "-" .. (str1 or "")
end

return module
