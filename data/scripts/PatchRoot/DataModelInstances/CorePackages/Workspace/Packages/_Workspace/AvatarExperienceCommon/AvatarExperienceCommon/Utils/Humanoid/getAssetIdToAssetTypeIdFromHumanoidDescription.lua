-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local Constants = require(AvatarExperienceCommon.Constants)

local function getAssetIdToAssetTypeIdFromHumanoidDescription(arg1)
    local assetIdToAssetTypeIdFromHumanoidDescription = ({})

    for value, value2 in Constants.ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP do
        if Constants.ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(value)] ~= nil then
            continue
        end

        local var1 = arg1[value2]
        if typeof(var1) == "number" and var1 > 0 then
            assetIdToAssetTypeIdFromHumanoidDescription[tostring(var1)] = tostring(value)
        elseif typeof(var1) == "string" and var1 ~= "" then
            for value3 in var1:gmatch("([%d]+),?") do
                assetIdToAssetTypeIdFromHumanoidDescription[value3] = tostring(value)
            end
        end
    end

    for _, value in (arg1:GetAccessories(true)) do
        local accessoryType = value.AccessoryType
        local assetId = value.AssetId
        assetIdToAssetTypeIdFromHumanoidDescription[tostring(assetId)] = Constants.ACCESSORY_TYPE_TO_ASSET_TYPE[accessoryType]
    end

    return assetIdToAssetTypeIdFromHumanoidDescription
end

return getAssetIdToAssetTypeIdFromHumanoidDescription
