-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local getFIntUGCValidateRenderMeshInsideOuterCageMeshThreshold = require(scriptParentParent.flags.getFIntUGCValidateRenderMeshInsideOuterCageMeshThreshold)

local _Types = require(scriptParentParent.util.Types)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)

local function validateRenderMeshInsideOuterCageMesh(arg1, arg2, arg3, arg4)
    local now = tick()

    local var1, var2 = pcallDeferred(function(): number
        return UGCValidationService:CalculateEditableMeshInsideMeshPercentage(
            arg2.editableMesh,
            arg3.editableMesh,
            arg1.CageOrigin:Inverse(),
            Vector3.new(1, 1, 1)
        )
    end, arg4)

    if not var1 then
        local str1 = string.format(
            "Failed to execute render mesh inside outer mesh check for '%s' and '%s'. Make sure the meshes exists and try again.",
            arg2.fullName,
            arg3.fullName
        )
        if arg4.isServer then
            error(str1)
        end
        Analytics.reportFailure(Analytics.ErrorType.validateRenderMeshInsideOuterCageMesh_FailedToExecute, nil, arg4)

        return false, { str1 }
    end

    local var3 = var2 * 100
    if var3 < getFIntUGCValidateRenderMeshInsideOuterCageMeshThreshold() then
        Analytics.reportFailure(Analytics.ErrorType.validateRenderMeshInsideOuterCageMesh_MaxOutsideCageMeshExceeded, nil, arg4)

        return false, { string.format(
                "Validation detected %d%% of the accessory is outside its outer cage. Make adjustments to have more of the accessory placed between the cages",
                100 - math.floor(var3)
            )
                .. "[Read more](https://create.roblox.com/docs/art/validation-errors#cageInsideMesh)" }
    end

    Analytics.recordScriptTime(script.Name, now, arg4)
    return true
end

return validateRenderMeshInsideOuterCageMesh
