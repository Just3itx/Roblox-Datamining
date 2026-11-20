-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local WrapTargetCageUVReferenceValues = require(scriptParentParentParent.WrapTargetCageUVReferenceValues)

local getFIntUGCValidateCageDuplicateUVThreshold = require(scriptParentParentParent.flags.getFIntUGCValidateCageDuplicateUVThreshold)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = { ValidationEnums.SharedDataMember.innerCagesData, ValidationEnums.SharedDataMember.outerCagesData },
    conditionalData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local referenceValues = {}
    for _, value in pairs(WrapTargetCageUVReferenceValues) do
        for _, value2 in pairs(value) do
            table.insert(referenceValues, value2)
        end
    end

    local function checkCage(tbl1, bool1: boolean)
        for partName, value2 in tbl1 do
            local num1 = UGCValidationService:ValidateEditableMeshUVDuplicates(referenceValues, value2.editable)

            if not (getFIntUGCValidateCageDuplicateUVThreshold() < num1) then
                continue
            end

            arg1:fail(
                ErrorSourceStrings.Keys.CageUV_ExtraDuplicateUVs,
                {
                    count = tostring(num1),
                    cageType = if bool1 then "inner" else "outer",
                    partName = partName
                }
            )
        end
    end

    checkCage(arg2.innerCagesData, true)
    checkCage(arg2.outerCagesData, false)
end

return module
