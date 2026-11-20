-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if arg1 then
        local var1 = arg1.title or arg1.titleForViewer
        if var1 then
            local str1 = tostring(var1)
            return string.gsub(str1, "\n", "")
        end
    end

    return ""
end
