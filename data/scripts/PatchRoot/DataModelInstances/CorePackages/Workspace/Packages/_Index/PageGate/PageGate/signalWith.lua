-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function signalWith(tbl1, str1: string, str2: string)
    tbl1.defer(function()
        if not tbl1.isEnabled() then
            return
        end

        local success, result = pcall(tbl1.getService)
        if not success or result == nil then
            return
        end
        local var1 = tbl1.resolveEnumItem("PageType", str1)
        local var2 = tbl1.resolveEnumItem("PageMilestoneType", str2)
        if var1 == nil or var2 == nil then
            tbl1.warn(`PageGate.signal: no enum for page "{str1}" / milestone "{str2}"`)
            return
        end
        result:TriggerOnPageMilestone(var1, var2)
    end)
end

return signalWith
