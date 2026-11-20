-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationRulesUtil = require(scriptParentParentParent.util.ValidationRulesUtil)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local Vector3Utils = require(scriptParentParentParent.util.Vector3Utils)
local valueToString = require(scriptParentParentParent.util.valueToString)
local module = {}

local getEngineFeatureLayeredClothingDecomposition = require(scriptParentParentParent.flags.getEngineFeatureLayeredClothingDecomposition)

local num1 = game:DefineFastInt("LCPostDeformSizeMultiplierEyebrowEyelashHundredths", 100) / 100

local tbl1 = {
    [Enum.AssetType.EyebrowAccessory] = num1,
    [Enum.AssetType.EyelashAccessory] = num1
}

local num2 = game:DefineFastInt("LCPostDeformSizeMultiplierGeneralHundredths", 100) / 100

module.fflag = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidationExactLCDeformationSize)
module.categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH }

module.requiredData = { ValidationEnums.SharedDataMember.renderMeshesData }

function module.run(arg1, arg2)
    local handle = arg2.rootInstance:FindFirstChild("Handle")
    local handle2 = arg2.renderMeshesData.Handle
    local assetType = arg2.uploadEnum.assetType

    if handle == nil or handle2 == nil then
        error("Schema should have ensured data exists for handle")
    end

    local var1, var2 = ValidationRulesUtil:getLCSizeLimit(assetType, handle)
    if not var1 or var2 == nil then
        error("Could not find matching attachment on Handle for " .. assetType.Name)
    end

    local var3 = var2 * (tbl1[assetType] or num2)
    local vec3 = if getEngineFeatureLayeredClothingDecomposition() then UGCValidationService:GetLayeredClothingPostDeformationSizeAsync(arg2.rootInstance, handle2.editable, handle2.scale) else UGCValidationService:GetLayeredClothingPostDeformationSize(arg2.rootInstance, handle2.editable, handle2.scale)

    if not Vector3Utils.isFirstLessOrEqual(vec3, var3) then
        arg1:fail(ErrorSourceStrings.Keys.LCDeformTooLarge, { maxSize = valueToString(var3) }, handle)
    end
end

return module
