-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { "<system_reminder>.-</system_reminder>" }

return {
    shouldOptimisticallyDisplay = function(str1: string)
        for _, value in tbl1 do
            if string.find(str1, value) ~= nil then
                return false
            end
        end
        return true
    end
}
