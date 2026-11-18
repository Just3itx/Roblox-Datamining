-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T22:53:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

return function(str1: string, callback: (...any) -> (...any))
    if tbl1[str1] then
        return
    end
    tbl1[str1] = true
    callback()
end
