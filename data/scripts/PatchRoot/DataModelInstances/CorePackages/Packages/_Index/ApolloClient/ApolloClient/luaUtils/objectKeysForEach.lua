-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(tbl1, callback: (...any) -> (...any))
    for value, _ in tbl1 do
        callback(value)
    end
end
