-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local mutedError = require(AvatarExperienceCommonParent.Loggers).mutedError
local ASSET_TYPE_NAME_TO_ID_STRING = require(AvatarExperienceCommon.Constants).ASSET_TYPE_NAME_TO_ID_STRING
local ASSET_TYPE_TO_ACCESSORY_TYPE = require(AvatarExperienceCommon.Constants).ASSET_TYPE_TO_ACCESSORY_TYPE

local ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP = require(AvatarExperienceCommon.Constants).ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP
local HUMANOID_DESCRIPTION_SCALE_TO_NAME = require(AvatarExperienceCommon.Constants).HUMANOID_DESCRIPTION_SCALE_TO_NAME
local setHumanoidDescriptionColorsFromBodyColor3s = require(script.Parent.setHumanoidDescriptionColorsFromBodyColor3s)
local createHumanoidDescriptionAccessoryInfo = require(script.Parent.createHumanoidDescriptionAccessoryInfo)
local setMakeupDescriptions = require(script.Parent.setMakeupDescriptions)
local isMakeupAssetType = require(AvatarExperienceCommon.Utils.isMakeupAssetType)
local isSpawnEffectAssetType = require(AvatarExperienceCommon.Utils.isSpawnEffectAssetType)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXOutfitPageRevamp = AvatarExperienceFlags.FFlagAXOutfitPageRevamp
local FFlagAXSpawnEffectSaveRoundTrip = AvatarExperienceFlags.FFlagAXSpawnEffectSaveRoundTrip

local getHumanoidDescriptionFromStateForOutfitType = require(AvatarExperienceCommon.Utils.Humanoid.getHumanoidDescriptionFromStateForOutfitType)

return function(arg1)
    local var1

    if FFlagAXOutfitPageRevamp then
        var1 = getHumanoidDescriptionFromStateForOutfitType(arg1, nil)
    else
        var1 = Instance.new("HumanoidDescription")
        local equippedAssets = arg1.AvatarEditor.Character.EquippedAssets
        local avatarScales = arg1.AvatarEditor.Character.AvatarScales

        if equippedAssets then
            local accessories = {}
            for k, equippedAsset in equippedAssets do
                local tbl1 = {}
                local var2 = ASSET_TYPE_TO_ACCESSORY_TYPE[k]
                for value, value2 in equippedAsset do
                    if var2 then
                        table.insert(accessories, createHumanoidDescriptionAccessoryInfo(k, value, value2))
                    else
                        table.insert(tbl1, value)
                    end
                end
                if var2 ~= nil or not (#tbl1 > 0) then
                    continue
                end

                local var3 = ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[k]
                local str1 = table.concat(tbl1, ",")
                if var3 then
                    var1[var3] = str1
                elseif k ~= ASSET_TYPE_NAME_TO_ID_STRING.Gear
                    and not (isMakeupAssetType(k) or FFlagAXSpawnEffectSaveRoundTrip and isSpawnEffectAssetType(k))
                then
                    mutedError(string.format("assetTypeId: %s not recognized as member of humanoidDescription", tostring(k)))
                end
            end

            var1:SetAccessories(accessories, true)
            setMakeupDescriptions(var1, equippedAssets)
        end

        if avatarScales then
            for value, value2 in avatarScales do
                var1[HUMANOID_DESCRIPTION_SCALE_TO_NAME[value]] = value2
            end
        end

        setHumanoidDescriptionColorsFromBodyColor3s(var1, arg1.AvatarEditor.Character.BodyColor3s)
    end

    local tbl1 = ({})
    local tbl2 = {}
    for _, value in arg1.AvatarEditor.EquippedEmotes.slotInfo do
        local str1 = tostring(value.assetId)
        tbl1[str1] = { tonumber(value.assetId) }
        table.insert(tbl2, { Slot = value.position, Name = tostring(value.assetId) })
    end
    var1:SetEmotes(tbl1)
    var1:SetEquippedEmotes(tbl2)

    return var1
end
