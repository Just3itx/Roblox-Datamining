-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1, callback: (...any) -> (...any))
    for value, _ in tbl1 do
        callback(value)
    end
end
