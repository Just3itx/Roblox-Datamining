-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    getThoughtHeading = function(arg1)
        if typeof(arg1) ~= "string" then
            return nil
        end
        local var1 = string.match(arg1, "^%s*%*%*([^\r\n]-)%*%*")
        if var1 == nil then
            return nil
        end
        local var2 = string.match(var1, "^%s*(.-)%s*$")
        if var2 == "" then
            return nil
        end

        return string.sub(var2, 1, (utf8.offset(var2, 81) or #var2 + 1) - 1)
    end
}
