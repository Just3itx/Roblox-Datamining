-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getActiveInterventionTimeoutEnd(tbl1, num1: number)
    local timeoutDurationSeconds = tbl1.timeoutDurationSeconds
    if timeoutDurationSeconds == nil or timeoutDurationSeconds < 0 then
        return false, nil
    elseif timeoutDurationSeconds == 0 then
        return true, nil
    else
        local timeoutStartTime = tbl1.timeoutStartTime
        local isoDate = if timeoutStartTime and timeoutStartTime ~= "" then DateTime.fromIsoDate(timeoutStartTime) else nil
        local var1 = (if isoDate then isoDate.UnixTimestamp else num1) + timeoutDurationSeconds
        if var1 <= num1 then
            return false, nil
        end

        return true, var1
    end
end
return getActiveInterventionTimeoutEnd
