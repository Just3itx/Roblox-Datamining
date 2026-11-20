-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCLCCageVerticesSimilarityMaximum = require(scriptParentParentParent.flags.getFIntUGCLCCageVerticesSimilarityMaximum)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = { ValidationEnums.SharedDataMember.innerCagesData, ValidationEnums.SharedDataMember.outerCagesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local fIntUgclcCageVerticesSimilarityMaximum = getFIntUGCLCCageVerticesSimilarityMaximum()

    local tbl1 = {}
    for value, value2 in arg2.innerCagesData do
        table.insert(tbl1, { name = value .. " (inner cage)", data = value2 })
    end
    for value, value2 in arg2.outerCagesData do
        table.insert(tbl1, { name = value .. " (outer cage)", data = value2 })
    end

    for _, value in tbl1 do
        local num1 = math.floor(UGCValidationService:GetEditableMeshVerticesSimilarityRate(value.data.editable, Vector3.new(1, 1, 1)) * 100)
        if not (fIntUgclcCageVerticesSimilarityMaximum < num1) then
            continue
        end

        local verticesNotCoincidentTooManySimilar = ErrorSourceStrings.Keys.VerticesNotCoincident_TooManySimilar
        local tbl2 = {
            cageName = value.name,
            percentage = tostring(num1),
            threshold = tostring(fIntUgclcCageVerticesSimilarityMaximum)
        }
        arg1:fail(verticesNotCoincidentTooManySimilar, tbl2)
    end
end

return module
