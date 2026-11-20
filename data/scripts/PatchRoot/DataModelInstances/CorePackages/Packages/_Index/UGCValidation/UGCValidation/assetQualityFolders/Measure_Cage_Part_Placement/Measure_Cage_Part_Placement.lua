-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING },
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidateAQCagePartPlacement)
}

local function collectViolationDetails(tbl1)
    local num1 = 0
    local result = {}

    while true do
        local violationType = tbl1[`violation_{num1}_type`]
        if violationType == nil then
            break
        end

        if violationType == "part_vertex_count_mismatch" then
            table.insert(result, {
                violationType = violationType,
                partName = tbl1[`violation_{num1}_upper_part`] or "unknown",
                expectedCount = tbl1[`violation_{num1}_expected_vertex_count`] or "?",
                actualCount = tbl1[`violation_{num1}_actual_vertex_count`] or "?"
            })
        else
            table.insert(result, {
                violationType = violationType,
                upperPart = tbl1[`violation_{num1}_upper_part`] or "unknown",
                lowerPart = tbl1[`violation_{num1}_lower_part`] or "unknown"
            })
        end
        num1 += 1
    end
    return result
end

function module.run(arg1, arg2)
    local measureCagePartPlacement = arg2.aqsSummaryData.Measure_Cage_Part_Placement
    if measureCagePartPlacement == nil then
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Cage_Part_Placement" })

        return
    end
    for cageName, value2 in measureCagePartPlacement do
        if cageName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Cage_Part_Placement" })

            return
        end
        if tonumber(value2.score) == 100 then
            continue
        end

        for _, value3 in (collectViolationDetails(value2)) do
            if value3.violationType == "part_vertex_count_mismatch" then
                local aqsFailCagePartVertexCount = ErrorSourceStrings.Keys.AQSFail_CagePartVertexCount
                local tbl1 = {
                    cageName = cageName,
                    partName = value3.partName,
                    expectedCount = value3.expectedCount,
                    actualCount = value3.actualCount
                }
                arg1:fail(aqsFailCagePartVertexCount, tbl1)
            else
                local aqsFailCagePartPlacement = ErrorSourceStrings.Keys.AQSFail_CagePartPlacement
                local tbl1 = {
                    cageName = cageName,
                    upperPart = value3.upperPart,
                    lowerPart = value3.lowerPart
                }
                arg1:fail(aqsFailCagePartPlacement, tbl1)
            end
        end
    end
end

return module
