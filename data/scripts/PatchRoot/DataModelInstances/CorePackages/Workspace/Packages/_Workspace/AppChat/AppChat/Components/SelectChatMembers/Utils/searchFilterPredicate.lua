-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, tbl1): boolean
    if not arg1 or arg1 == "" then
        return true
    end
    local displayName = tbl1.displayName
    if tbl1.alias ~= nil then
        displayName ..= tbl1.alias
    end
    return string.find(string.lower(displayName), string.lower(arg1), 1, true) ~= nil
end
