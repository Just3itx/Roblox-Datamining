-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local reduce = require(scriptParent.reduce)

local function func1(arg1, arg2): boolean
    return arg1 < arg2
end

local function min(tbl1, func2: ((...any) -> (...any))?, func3: ((...any) -> (...any))?)
    local var1 = func3 or func1

    if not func2 then
        return reduce(tbl1, function(arg1, arg2)
            return if arg1 then if var1(arg2, arg1) then arg2 else arg1 else arg2
        end, nil)
    end

    return reduce(tbl1, function(arg1, original, arg2)
        local value = func2(original, arg2)
        return if arg1 then if var1(value, arg1.value) then { value = value, original = original } else arg1 else {
            value = value,
            original = original
        }
    end, nil).original
end

return min
