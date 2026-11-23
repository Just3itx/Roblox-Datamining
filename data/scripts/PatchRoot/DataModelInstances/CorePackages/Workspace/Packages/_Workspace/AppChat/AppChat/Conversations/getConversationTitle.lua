-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1)
    if tbl1 then
        local var1 = tbl1.title or tbl1.titleForViewer
        if var1 then
            return (string.gsub(tostring(var1), "\n", ""))
        end
    end

    return ""
end
