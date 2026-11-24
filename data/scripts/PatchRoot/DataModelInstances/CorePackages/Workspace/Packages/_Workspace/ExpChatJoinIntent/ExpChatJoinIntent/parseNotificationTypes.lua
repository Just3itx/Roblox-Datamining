-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function trim(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (string.match(str1, "^%s*(.-)%s*$"))
end

local function parseNotificationTypes(str1: string)
    local result = ({})
    for _, value in string.split(str1, ",") do
        local var1, var2 = string.match(value, "^([^=]*)=(.*)$")
        local var3 = trim(var1 or value)
        if var3 == "" then
            continue
        end

        local var4 = if var2 then trim(var2) else ""
        local tbl1 = { chatTarget = 0 }
        if var4 == "" then
            var4 = nil
        end

        tbl1.chatTarget = var4
        result[var3] = tbl1
    end

    return result
end

return parseNotificationTypes
