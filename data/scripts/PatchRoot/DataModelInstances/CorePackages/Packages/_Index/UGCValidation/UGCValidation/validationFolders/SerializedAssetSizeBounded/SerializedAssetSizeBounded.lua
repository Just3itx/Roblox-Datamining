-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SerializationService = game:GetService("SerializationService")
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateSerializedAssetSizeBounded = require(scriptParentParentParent.flags.getFFlagUGCValidateSerializedAssetSizeBounded)

local getEngineFeatureEngineUGCValidateSerializeExcludeCollisionPhysics = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateSerializeExcludeCollisionPhysics)

local getFIntUGCValidateMaxSerializedAssetSizeBytesDefault = require(scriptParentParentParent.flags.getFIntUGCValidateMaxSerializedAssetSizeBytesDefault)

local getFIntUGCValidateMaxSerializedAssetSizeBytesTorsoAndLimbs = require(scriptParentParentParent.flags.getFIntUGCValidateMaxSerializedAssetSizeBytesTorsoAndLimbs)

local getFIntUGCValidateMaxSerializedAssetSizeBytesDynamicHead = require(scriptParentParentParent.flags.getFIntUGCValidateMaxSerializedAssetSizeBytesDynamicHead)

local getFIntUGCValidateMaxSerializedAssetSizeBytesLayeredClothing = require(scriptParentParentParent.flags.getFIntUGCValidateMaxSerializedAssetSizeBytesLayeredClothing)

local getFIntUGCValidateMaxSerializedAssetSizeBytesRigidAccessory = require(scriptParentParentParent.flags.getFIntUGCValidateMaxSerializedAssetSizeBytesRigidAccessory)

local module = {}

local tbl1 = {
    [ValidationEnums.UploadCategory.TORSO_AND_LIMBS] = getFIntUGCValidateMaxSerializedAssetSizeBytesTorsoAndLimbs,
    [ValidationEnums.UploadCategory.DYNAMIC_HEAD] = getFIntUGCValidateMaxSerializedAssetSizeBytesDynamicHead,
    [ValidationEnums.UploadCategory.LAYERED_CLOTHING] = getFIntUGCValidateMaxSerializedAssetSizeBytesLayeredClothing,
    [ValidationEnums.UploadCategory.EYEBROW_EYELASH] = getFIntUGCValidateMaxSerializedAssetSizeBytesLayeredClothing,
    [ValidationEnums.UploadCategory.RIGID_ACCESSORY] = getFIntUGCValidateMaxSerializedAssetSizeBytesRigidAccessory
}

module.categories = Constants.AllAssetUploadCategories

module.requiredData = { ValidationEnums.SharedDataMember.entrypointInput, ValidationEnums.SharedDataMember.uploadCategory, ValidationEnums.SharedDataMember.consumerConfig }

module.fflag = getFFlagUGCValidateSerializedAssetSizeBounded

function module.run(arg1, arg2)
    if arg2.consumerConfig.consumerEnv ~= ValidationEnums.ConsumerEnv.Backend then
        return
    end

    local num1 = if getEngineFeatureEngineUGCValidateSerializeExcludeCollisionPhysics() then UGCValidationService:GetSerializedSizeExcludingCollisionAsync(arg2.entrypointInput) else buffer.len(SerializationService:SerializeInstancesAsync(arg2.entrypointInput))
    local var1 = (tbl1[arg2.uploadCategory] or getFIntUGCValidateMaxSerializedAssetSizeBytesDefault)()

    if var1 < num1 then
        arg1:fail(
            ErrorSourceStrings.Keys.SerializedAssetTooLarge,
            {
                sizeBytes = tostring(num1),
                maxSizeBytes = tostring(var1)
            }
        )
    end
end
return module
