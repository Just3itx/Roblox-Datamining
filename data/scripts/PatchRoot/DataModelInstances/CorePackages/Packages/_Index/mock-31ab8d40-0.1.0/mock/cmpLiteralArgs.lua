-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local fmtArgs = require(script.Parent.fmtArgs)

return function(arg1, arg2)
    if arg1.n ~= arg2.n then
        return false, "number of literals in " .. fmtArgs(arg1) .. " does not match number of args in " .. fmtArgs(arg2)
    end

    for i = 1, arg1.n do
        if arg1[i] ~= arg2[i] then
            return false, "expected " .. fmtArgs(arg1) .. ", got " .. fmtArgs(arg2)
        end
    end
    return true
end
