-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")
local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local tutils = require(AvatarExperienceSaveParent.tutils)
local AvatarExperienceCommon = require(AvatarExperienceSaveParent.AvatarExperienceCommon)
local AvatarExperienceModel = require(AvatarExperienceSaveParent.AvatarExperienceModel)

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local getSubstateToTrackForChanges = require(AvatarExperienceSave.Utils.getSubstateToTrackForChanges)
local assetOrderRelativelyEqual = require(AvatarExperienceSave.Utils.assetOrderRelativelyEqual)

local Constants = AvatarExperienceCommon.Constants

local _AvatarExperienceRodux = require(AvatarExperienceSaveParent.AvatarExperienceRodux)

local function shouldInsertNewHistoryEntry(arg1, arg2)
    local substateToTrackForChanges = getSubstateToTrackForChanges(arg1, true)
    local substateToTrackForChanges2 = getSubstateToTrackForChanges(arg2, true)

    if tutils.deepEqual(substateToTrackForChanges, substateToTrackForChanges2)
        and assetOrderRelativelyEqual(arg1, arg2, Constants.LAYERED_ASSET_TYPES)
        and assetOrderRelativelyEqual(arg1, arg2, Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE)
    then
        return false
    end

    local bool1 = true
    for _, value in substateToTrackForChanges2.OutfitTryOn.TryOnItems or {} do
        if value.itemType == ItemTypeEnum.Bundle and tutils.fieldCount(value.bundleInfo or {}) == 0 then
            return false
        end
    end
    return bool1
end

return shouldInsertNewHistoryEntry
