-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local mutedError = require(AvatarExperienceCommonParent.Loggers).mutedError
local HUMANOID_DESCRIPTION_SCALE_TO_NAME = require(AvatarExperienceCommon.Constants).HUMANOID_DESCRIPTION_SCALE_TO_NAME
local setHumanoidDescriptionColorsFromBodyColor3s = require(script.Parent.setHumanoidDescriptionColorsFromBodyColor3s)
local setMakeupDescriptions = require(script.Parent.setMakeupDescriptions)
local createHumanoidDescriptionAccessoryInfo = require(script.Parent.createHumanoidDescriptionAccessoryInfo)
local isMakeupAssetType = require(AvatarExperienceCommon.Utils.isMakeupAssetType)
local isSpawnEffectAssetType = require(AvatarExperienceCommon.Utils.isSpawnEffectAssetType)
local isValidAssetTypeForOutfitType = require(AvatarExperienceCommon.Utils.isValidAssetTypeForOutfitType)

local Constants = require(AvatarExperienceCommon.Constants)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagParseHeadShapeFromAPIResponse = AvatarExperienceFlags.FFlagParseHeadShapeFromAPIResponse
local FFlagHeadRefinementFacialAnimationToggle = AvatarExperienceFlags.FFlagHeadRefinementFacialAnimationToggle
local FFlagAXSpawnEffectSaveRoundTrip = AvatarExperienceFlags.FFlagAXSpawnEffectSaveRoundTrip

local _CategoryTypes = require(AvatarExperienceCommon.Types.CategoryTypes.CategoryTypes)

return function(arg1, arg2): HumanoidDescription
    local humanoidDescription = Instance.new("HumanoidDescription")
    local equippedAssets = arg1.AvatarEditor.Character.EquippedAssets
    local avatarScales = arg1.AvatarEditor.Character.AvatarScales

    local staticFacialAnimation = nil

    if equippedAssets then
        local accessories = {}
        for k, equippedAsset in equippedAssets do
            if not isValidAssetTypeForOutfitType(k, arg2) then
                continue
            end

            local tbl1 = {}
            local var1 = Constants.ASSET_TYPE_TO_ACCESSORY_TYPE[k]
            for value, value2 in equippedAsset do
                if var1 then
                    table.insert(accessories, createHumanoidDescriptionAccessoryInfo(k, value, value2))
                else
                    table.insert(tbl1, value)
                end
            end
            if var1 ~= nil or not (#tbl1 > 0) then
                continue
            end

            local var2 = Constants.ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[k]
            local str1 = table.concat(tbl1, ",")
            if var2 then
                if FFlagParseHeadShapeFromAPIResponse and Constants.BODY_PART_NAME_TO_ENUM[var2] then
                    local bodyPartDescription = Instance.new("BodyPartDescription")
                    bodyPartDescription.AssetId = tbl1[1]
                    bodyPartDescription.Parent = humanoidDescription
                    bodyPartDescription.BodyPart = Constants.BODY_PART_NAME_TO_ENUM[var2]

                    if k == Constants.ASSET_TYPE_NAME_TO_ID_STRING.DynamicHead then
                        local headShape = nil
                        for _, value in tbl1 do
                            local var3 = equippedAsset[value]

                            if FFlagHeadRefinementFacialAnimationToggle and var3 and var3.staticFacialAnimation ~= nil then
                                staticFacialAnimation = var3.staticFacialAnimation
                            end
                            if not (var3 and var3.headShape) then
                                continue
                            end

                            if var3.headShape == "Default" then
                                headShape = nil
                            else
                                headShape = var3.headShape
                            end

                            break
                        end

                        if headShape then
                            bodyPartDescription.HeadShape = headShape
                        end
                    end
                else
                    humanoidDescription[var2] = str1
                end
            elseif k ~= Constants.ASSET_TYPE_NAME_TO_ID_STRING.Gear
                and not (isMakeupAssetType(k) or FFlagAXSpawnEffectSaveRoundTrip and isSpawnEffectAssetType(k))
            then
                mutedError(string.format("assetTypeId: %s not recognized as member of humanoidDescription", tostring(k)))
            end
        end

        humanoidDescription:SetAccessories(accessories, true)
        setMakeupDescriptions(humanoidDescription, equippedAssets)
        if FFlagHeadRefinementFacialAnimationToggle and staticFacialAnimation ~= nil then
            humanoidDescription[Constants.STATIC_FACIAL_ANIMATION] = staticFacialAnimation
        end
    end

    if avatarScales then
        for value, value2 in avatarScales do
            humanoidDescription[HUMANOID_DESCRIPTION_SCALE_TO_NAME[value]] = value2
        end
    end

    setHumanoidDescriptionColorsFromBodyColor3s(humanoidDescription, arg1.AvatarEditor.Character.BodyColor3s)

    return humanoidDescription
end
