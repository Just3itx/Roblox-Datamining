-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local AssetCalculator = require(scriptParentParentParent.util.AssetCalculator)

local GetFStringUGCValidationMaxCageDistance = require(scriptParentParentParent.flags.GetFStringUGCValidationMaxCageDistance)

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData, ValidationEnums.SharedDataMember.outerCagesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local tbl1 = {}
    for _, child in arg2.rootInstance:GetChildren() do
        tbl1[child.Name] = child
    end

    if next(tbl1) == nil then
        return
    end

    local allTransformsForFullBody = AssetCalculator.calculateAllTransformsForFullBody(tbl1)

    local inputBodyParts = {}
    for name, value2 in tbl1 do
        local var1 = arg2.renderMeshesData[name]
        local var2 = arg2.outerCagesData[name]

        if var1 == nil or var2 == nil then
            continue
        end

        local scale = value2.Size / var1.originalSize

        table.insert(inputBodyParts, {
            renderMesh = var1.editable,
            outerCage = var2.editable,
            renderMeshTransform = allTransformsForFullBody[name],
            outerCageLocalTransform = var2.origin,
            scale = scale,
            name = name
        })
    end

    if #inputBodyParts == 0 then
        return
    end

    local var1, partName = UGCValidationService:CalculateBodyMaxCageDistance(inputBodyParts)

    if not (GetFStringUGCValidationMaxCageDistance.asNumber() < var1) then
        return
    end

    arg1:fail(ErrorSourceStrings.Keys.BodyPartCageDistanceValid_TooFar, {
        partName = partName,
        distance = string.format("%.2f", var1),
        maxDistance = GetFStringUGCValidationMaxCageDistance.asString()
    })
end

return module
