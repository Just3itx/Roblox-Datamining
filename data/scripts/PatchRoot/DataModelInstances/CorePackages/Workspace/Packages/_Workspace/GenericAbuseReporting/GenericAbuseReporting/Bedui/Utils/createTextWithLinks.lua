-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)

return function(str1: string, tbl1)
    if tbl1 == nil then
        return str1
    end

    for value in string.gmatch(str1, "{%S+}") do
        local str2 = string.sub(value, 2, #value - 1)
        if tbl1[str2] then
            str1 = string.gsub(str1, value, tbl1[str2].label)
        end
    end
    return str1
end
