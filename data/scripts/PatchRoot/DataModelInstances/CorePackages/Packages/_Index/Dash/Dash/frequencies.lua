-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)
local reduce = require(scriptParent.reduce)

local function frequencies(tbl1, func1: ((...any) -> (...any))?)
    return reduce(tbl1, function(arg1, arg2, arg3)
        if func1 then
            arg2 = func1(arg2, arg3)
        end

        if arg1[arg2] == nil then
            arg1[arg2] = 1
        else
            arg1[arg2] += 1
        end
        return arg1
    end, {})
end

return frequencies
