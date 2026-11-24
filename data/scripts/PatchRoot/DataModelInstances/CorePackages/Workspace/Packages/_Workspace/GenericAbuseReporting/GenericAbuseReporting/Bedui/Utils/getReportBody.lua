-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local AbuseCategory = require(GenericAbuseReporting.Enums.AbuseCategory)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

return function(tbl1)
    local tbl2 = {}

    Dash.forEach(tbl1.additionalReportTags or {}, function(arg1)
        if not arg1.tagKey or arg1.tagKey == "" or not arg1.tagValue or arg1.tagValue == "" then
            return
        end

        if tbl2[arg1.tagKey] ~= nil then
            local var1 = tbl2[arg1.tagKey]
            tbl2[arg1.tagKey] = var1 .. "," .. arg1.tagValue
        else
            tbl2[arg1.tagKey] = arg1.tagValue
        end
    end)

    return {
        abuseVector = tbl1.abuseVector,
        category = tbl1.formData.abuse_category or AbuseCategory.ABUSE_CATEGORY_INVALID,
        comment = tbl1.formData.free_comment or "",
        submitterId = tbl1.localPlayerUserId,
        targetIdStr = tbl1.targetIdStr,
        targetType = tbl1.abuseVector,
        custom = if next(tbl2) == nil then nil else tbl2
    }
end
