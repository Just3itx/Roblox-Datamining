-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCValidationVertexDensityThreshold = require(scriptParentParentParent.flags.getFIntUGCValidationVertexDensityThreshold)
local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    for _, value in arg2.renderMeshesData do
        if UGCValidationService:GetEditableMeshMaxNearbyVerticesCollisions(value.editable, value.scale) > getFIntUGCValidationVertexDensityThreshold() then
            arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_VertexDensityExceeded, {})
        end
    end
end

return module
