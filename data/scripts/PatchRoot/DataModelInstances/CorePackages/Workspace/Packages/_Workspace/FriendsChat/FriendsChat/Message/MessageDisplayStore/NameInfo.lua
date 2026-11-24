-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    isNameLoading = function(tbl1): boolean
        local name = if tbl1 == nil then nil else tbl1.name
        return name == nil or name == ""
    end
}
