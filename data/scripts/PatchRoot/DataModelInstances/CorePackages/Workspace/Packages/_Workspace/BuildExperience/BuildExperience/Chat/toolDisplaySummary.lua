-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { execute_luau = true, verify_luau = true }

local function cleanSummary(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) ~= "string" then
        return nil
    end
    local var1 = string.match(arg1, "^%s*(.-)%s*$")
    if var1 == "" then
        return nil
    end

    return string.sub(var1, 1, (utf8.offset(var1, 121) or #var1 + 1) - 1)
end

local function getLeadingComment(code)
    if typeof(code) ~= "string" then
        return nil
    end
    for value in string.gmatch(code, "[^\r\n]+") do
        local var1 = string.match(value, "^%s*(.-)%s*$")
        if var1 == "" or string.sub(var1, 1, 3) == "--!" then
            continue
        end

        if string.sub(var1, 1, 2) == "--" and string.match(var1, "^%-%-%[=*%[") == nil then
            return cleanSummary((string.match(var1, "^%-%-+%s*(.*)$")))
        end
        return nil
    end

    return nil
end

return {
    getToolDisplaySummary = function(str1: string?, arg1)
        if typeof(arg1) ~= "table" then
            return nil
        end

        local var1 = cleanSummary(arg1._display_summary)
        if var1 ~= nil then
            return var1
        elseif str1 ~= nil and tbl1[str1] then
            return (getLeadingComment(arg1.code))
        end
        return nil
    end
}
