-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

return function(str1: string, callback: (...any) -> (...any))
    if tbl1[str1] then
        return
    end
    tbl1[str1] = true
    callback()
end
