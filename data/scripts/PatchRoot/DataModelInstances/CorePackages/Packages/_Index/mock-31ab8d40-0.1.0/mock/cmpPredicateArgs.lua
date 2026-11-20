-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local fmtArgs = require(script.Parent.fmtArgs)

return function(arg1, arg2)
    if arg1.n ~= arg2.n then
        return false, "number of args in " .. fmtArgs(arg2) .. " does not match number of predicates"
    end

    for i = 1, arg2.n do
        if not arg1[i](arg2[i]) then
            return false, fmtArgs(arg2) .. " does not match predicates at position " .. i
        end
    end
    return true
end
