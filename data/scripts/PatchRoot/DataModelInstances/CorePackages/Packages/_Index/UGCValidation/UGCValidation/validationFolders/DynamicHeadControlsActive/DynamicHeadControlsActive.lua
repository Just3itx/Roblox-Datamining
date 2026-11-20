-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local controlNames = {
    "LeftEyeClosed",
    "EyesLookDown",
    "RightEyeClosed",
    "JawDrop",
    "Pucker",
    "LeftLipCornerPuller",
    "RightLipCornerPuller",
    "ChinRaiser",
    "ChinRaiserUpperLip",
    "LeftCheekRaiser",
    "RightCheekRaiser",
    "LeftInnerBrowRaiser",
    "RightInnerBrowRaiser",
    "LeftLipCornerDown",
    "RightLipCornerDown",
    "LeftLowerLipDepressor",
    "RightLowerLipDepressor"
}

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    prereqTests = { ValidationEnums.ValidationModule.DynamicHeadFacsPresent },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local head = arg2.renderMeshesData.Head

    local success, result, result2 = pcall(function()
        return UGCValidationService:GetDynamicHeadEditableMeshInactiveControls(head.editable, controlNames)
    end)

    if not success then
        if string.find(result, "Download Error") == 1 then
            arg1:fetchError(
                string.format(
                    "Failed to load model for dynamic head '%s'. Make sure model exists and try again.",
                    arg2.rootInstance.Name
                )
            )
        end
        assert(false, result)
    end

    local meshId = arg2.rootInstance.MeshId

    if #result > 0 then
        arg1:fail(
            ErrorSourceStrings.Keys.DynHead_ControlsMissing,
            {
                headName = arg2.rootInstance.Name,
                meshId = meshId,
                controlList = table.concat(result, ", ")
            }
        )
    end
    if not (#result2 > 0) then
        return
    end

    arg1:fail(
        ErrorSourceStrings.Keys.DynHead_ControlsInactive,
        {
            headName = arg2.rootInstance.Name,
            meshId = meshId,
            controlList = table.concat(result2, ", ")
        }
    )
end

return module
