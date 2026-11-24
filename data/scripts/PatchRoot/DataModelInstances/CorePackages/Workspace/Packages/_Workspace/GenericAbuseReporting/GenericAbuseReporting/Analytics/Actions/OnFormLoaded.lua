-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
return require(GenericAbuseReportingParent.Rodux).makeActionCreator(script.Name, function(tbl1)
    return {
        context = tbl1.context,
        place_id = tbl1.place_id,
        accumulated_time_ms = tbl1.accumulated_time_ms
    }
end)
