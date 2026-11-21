-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")
local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local AvatarExperienceCommon = require(AvatarExperienceSaveParent.AvatarExperienceCommon)

local getSubstateToTrackForChanges = require(script.Parent.getSubstateToTrackForChanges)
local assetOrderRelativelyEqual = require(script.Parent.assetOrderRelativelyEqual)

local tutils = require(AvatarExperienceSaveParent.tutils)

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)

local Constants = AvatarExperienceCommon.Constants

local function shouldReplaceLastHistoryEntry(arg1, arg2)
    return not tutils.deepEqual(getSubstateToTrackForChanges(arg1, false), getSubstateToTrackForChanges(arg2, false))
        and tutils.deepEqual(getSubstateToTrackForChanges(arg1, true), getSubstateToTrackForChanges(arg2, true))
        and assetOrderRelativelyEqual(arg1, arg2, Constants.LAYERED_ASSET_TYPES)
        and assetOrderRelativelyEqual(arg1, arg2, Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE)
end

return shouldReplaceLastHistoryEntry
