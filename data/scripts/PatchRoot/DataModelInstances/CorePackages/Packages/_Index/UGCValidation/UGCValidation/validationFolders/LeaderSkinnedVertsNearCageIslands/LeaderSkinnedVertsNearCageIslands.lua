-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local EyelashCageUVReferenceValues = require(scriptParentParentParent.EyelashCageUVReferenceValues)

local getFIntUGCValidationLeaderVertsNearCageIslandsDistance = require(scriptParentParentParent.flags.getFIntUGCValidationLeaderVertsNearCageIslandsDistance)
local module = {
    fflag = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateLeaderVertsNearCageIslands),
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData, ValidationEnums.SharedDataMember.innerCagesData }
}

local var1 = getFIntUGCValidationLeaderVertsNearCageIslandsDistance() / 10000

function module.run(arg1, arg2)
    if arg2.uploadEnum.assetType ~= Enum.AssetType.EyelashAccessory then
        return
    end

    local handle = arg2.renderMeshesData.Handle
    local handle2 = arg2.innerCagesData.Handle

    if handle == nil or handle2 == nil then
        error("Schema should have ensured data exists for handle")
    end

    if not UGCValidationService:ValidateLeaderSkinnedVertsNearCageIslands(
        handle.editable,
        handle2.editable,
        EyelashCageUVReferenceValues,
        handle2.origin,
        var1
    ) then
        arg1:fail(ErrorSourceStrings.Keys.LeaderVertsNearCageIslands)
    end
end

return module
