-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionTypes = require(InterventionShared.InterventionAnalytics).Constants.InterventionTypes

return function(str1: string?)
    local str2 = if str1 then str1:lower() else ""

    if string.find(str2, "nudge") then
        return InterventionTypes.UFRNudge
    end

    if string.find(str2, "timeout") then
    end

    return InterventionTypes.UFRTimeout
end
