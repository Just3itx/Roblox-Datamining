-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}
local function setAllCommands(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl1 = arg1
end

return function(arg1)
    if arg1 then
        setAllCommands(arg1)
    end

    return tbl1
end
