-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
return require(GenericAbuseReportingParent.Rodux).makeActionCreator(script.Name, function(tbl1)
    return {
        reason_selection = tbl1.reason_selection
    }
end)
