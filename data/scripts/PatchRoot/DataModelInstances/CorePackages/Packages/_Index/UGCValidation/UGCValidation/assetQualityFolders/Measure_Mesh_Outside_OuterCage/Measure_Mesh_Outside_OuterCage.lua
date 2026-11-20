-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)

local num1 = game:DefineFastInt("UGCValidateRenderMeshOutsideOuterCageMeshThreshold", 65)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH }
}

function module.run(arg1, arg2)
    local handle = arg2.aqsSummaryData.Measure_Mesh_Outside_OuterCage.Handle
    local var1 = handle and tonumber(handle.mesh_outside_outer_cage_percent)

    if var1 == nil then
        error("Measure_Mesh_Outside_OuterCage: AQS summary missing required fields")
        return
    end
    if var1 * 100 > num1 then
        arg1:fail(
            ErrorSourceStrings.Keys.MeasureMeshOutsideOuterCage,
            {
                mesh_outside_outer_cage_percent = string.format("%.2f", var1 * 100)
            }
        )
    end

    if not getFFlagUGCValidateAQScoreWarnings() or handle.score == nil or tonumber(handle.score) == 100 then
        return
    end

    local aqsWarnMeshOutsideOuterCage = ErrorSourceStrings.Keys.AQSWarn_MeshOutsideOuterCage
    local tbl1 = {
        mesh_outside_outer_cage_percent = string.format("%.2f", (tonumber(handle.mesh_outside_outer_cage_percent) or 0) * 100)
    }
    arg1:warn(aqsWarnMeshOutsideOuterCage, tbl1)
end

return module
