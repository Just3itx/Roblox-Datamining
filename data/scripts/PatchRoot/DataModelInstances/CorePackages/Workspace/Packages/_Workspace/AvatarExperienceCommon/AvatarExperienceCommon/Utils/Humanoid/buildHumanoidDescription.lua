-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local mutedError = require(AvatarExperienceCommonParent.Loggers).mutedError

local Constants = require(AvatarExperienceCommon.Constants)
local FFlagAXSpawnEffectSaveRoundTrip = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXSpawnEffectSaveRoundTrip

local createHumanoidDescriptionAccessoryInfo = require(AvatarExperienceCommon.Utils.Humanoid.createHumanoidDescriptionAccessoryInfo)
local setAvatarEffectDescriptions = require(AvatarExperienceCommon.Utils.Humanoid.setAvatarEffectDescriptions)
local setMakeupDescriptions = require(AvatarExperienceCommon.Utils.Humanoid.setMakeupDescriptions)
local isMakeupAssetType = require(AvatarExperienceCommon.Utils.isMakeupAssetType)
local isSpawnEffectAssetType = require(AvatarExperienceCommon.Utils.isSpawnEffectAssetType)

local function applyCurrentAssets(humanoidDescription: HumanoidDescription, currentAssets)
    if not currentAssets then
        return
    end

    local accessories = {}
    for k, currentAsset in currentAssets do
        local tbl1 = {}
        local var1 = Constants.ASSET_TYPE_TO_ACCESSORY_TYPE[k]
        for value, value2 in currentAsset do
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
            humanoidDescription[var2] = str1
        elseif k ~= Constants.ASSET_TYPE_NAME_TO_ID_STRING.Gear
            and not (isMakeupAssetType(k) or FFlagAXSpawnEffectSaveRoundTrip and isSpawnEffectAssetType(k))
        then
            mutedError(string.format("assetTypeId: %s not recognized as member of humanoidDescription", tostring(k)))
        end
    end

    humanoidDescription:SetAccessories(accessories, true)
    setMakeupDescriptions(humanoidDescription, currentAssets)
    if FFlagAXSpawnEffectSaveRoundTrip then
        setAvatarEffectDescriptions(humanoidDescription, currentAssets)
    end
end

local function applyAvatarScales(humanoidDescription: HumanoidDescription, avatarScales) -- Luacid: Inlined by compiler; 1 call site recovered
    if not avatarScales then
        return
    end

    for value, value2 in avatarScales do
        humanoidDescription[Constants.HUMANOID_DESCRIPTION_SCALE_TO_NAME[value]] = value2
    end
end

local function applyBodyColor3s(humanoidDescription: HumanoidDescription, bodyColor3s) -- Luacid: Inlined by compiler; 1 call site recovered
    if not bodyColor3s then
        return
    end

    for k, bodyColor3 in bodyColor3s do
        humanoidDescription[Constants.BODY_PART_FOR_SKIN_COLORING_ID_TO_HUMANOID_DESCRIPTION[k]] = bodyColor3
    end
end

local function applyEmotes(humanoidDescription: HumanoidDescription, emotesSlotInfo)
    if not emotesSlotInfo then
        return
    end

    local emotes = ({})
    local equippedEmotes = {}
    for _, value in emotesSlotInfo do
        local str1 = tostring(value.assetId)
        emotes[str1] = { tonumber(value.assetId) }
        table.insert(equippedEmotes, { Slot = value.position, Name = tostring(value.assetId) })
    end
    humanoidDescription:SetEmotes(emotes)
    humanoidDescription:SetEquippedEmotes(equippedEmotes)
end

local function buildHumanoidDescription(tbl1): HumanoidDescription
    local humanoidDescription = Instance.new("HumanoidDescription")

    applyCurrentAssets(humanoidDescription, tbl1.currentAssets)
    applyAvatarScales(humanoidDescription, tbl1.avatarScales)
    applyBodyColor3s(humanoidDescription, tbl1.bodyColor3s)
    applyEmotes(humanoidDescription, tbl1.emotesSlotInfo)

    return humanoidDescription
end

return buildHumanoidDescription
