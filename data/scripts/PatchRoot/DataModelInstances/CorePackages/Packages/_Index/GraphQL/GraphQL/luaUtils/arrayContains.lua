-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local deepEqual = require(script.Parent.deepEqual)
local deepContains = require(script.Parent.deepContains)

return function(arg1, arg2, arg3)
    for _, value in ipairs(arg1) do
        if arg3 then
            if deepContains(value, arg2) then
                return true
            end
        elseif deepEqual(value, arg2) then
            return true
        end
    end

    return false
end
