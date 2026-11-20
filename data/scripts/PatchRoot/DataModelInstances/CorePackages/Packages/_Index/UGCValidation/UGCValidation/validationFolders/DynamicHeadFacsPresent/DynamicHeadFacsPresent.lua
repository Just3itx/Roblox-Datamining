-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local head = arg2.renderMeshesData.Head

    local success, result = pcall(function(): boolean
        return UGCValidationService:ValidateDynamicHeadEditableMesh(head.editable)
    end)

    if not success then
        arg1:fetchError(
            string.format(
                "Failed to load model for dynamic head '%s'. Make sure model exists and try again.",
                arg2.rootInstance.Name
            )
        )
    end

    if not result then
        arg1:fail(ErrorSourceStrings.Keys.DynHead_FacsMissing, { headName = arg2.rootInstance.Name })
    end
end

return module
