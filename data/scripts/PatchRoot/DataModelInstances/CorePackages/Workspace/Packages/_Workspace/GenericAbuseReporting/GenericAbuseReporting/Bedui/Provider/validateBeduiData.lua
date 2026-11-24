-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local t = require(GenericAbuseReportingParent.t)

local BeduiDataTypeInterface = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes).BeduiDataTypeInterface

local function validateInterface(arg1, beduiDataTypeInterface) -- Luacid: Inlined by compiler; 1 call site recovered
    return t.interface(beduiDataTypeInterface)(arg1)
end

local function validateStepId(tbl1)
    local bool1 = false
    local tbl2 = {}
    for _, value in tbl1.nodes do
        if value.stepId == tbl1.rootStepId then
            if bool1 then
                return false, "Bedui data contains multiple steps with the same rootStepId"
            end

            bool1 = true
        end

        if table.find(tbl2, value.stepId) then
            return false, "Bedui data contains duplicate stepId: " .. tostring(value.stepId)
        end
        table.insert(tbl2, value.stepId)
    end

    if bool1 then
        return true, nil
    end
    return false, "Bedui data does not contain a step with the rootStepId"
end

local function validateBeduiData(tbl1)
    if tbl1 == nil then
        return false, "Bedui data is nil"
    elseif not validateInterface(tbl1, BeduiDataTypeInterface) then
        return false, "Bedui data does not conform to the expected structure"
    end
    return validateStepId(tbl1)
end

return validateBeduiData
