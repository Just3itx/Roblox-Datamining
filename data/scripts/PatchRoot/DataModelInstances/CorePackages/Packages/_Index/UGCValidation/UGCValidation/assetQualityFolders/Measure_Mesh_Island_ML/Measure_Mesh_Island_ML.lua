-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local num1 = game:DefineFastInt("UGCValidationMeshIslandMLMinScore", 9)

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY }
}

function module.run(arg1, arg2)
    local measureMeshIslandMl = arg2.aqsSummaryData.Measure_Mesh_Island_ML
    if measureMeshIslandMl == nil then
        arg1:err("Measure_Mesh_Island_ML: missing AQS summary data")
        return
    end

    for value, value2 in measureMeshIslandMl do
        if value == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:err("Measure_Mesh_Island_ML: missing score data for " .. tostring(value))
            return
        end

        local num2 = tonumber(value2.score) or 0
        if num2 < 0 then
            error("Measure_Mesh_Island_ML: received unexpected negative score, possible upstream bug")
        end
        if num2 < num1 then
            arg1:fail(ErrorSourceStrings.Keys.AQSFail_MeshIslandML)
        end
    end
end

return module
