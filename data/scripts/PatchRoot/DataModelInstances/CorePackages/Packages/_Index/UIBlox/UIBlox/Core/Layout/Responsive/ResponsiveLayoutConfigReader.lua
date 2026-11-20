-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent
local t = require(scriptParentParentParentParentParent.t)
local Array = require(scriptParentParentParentParentParent.LuauPolyfill).Array

local function hasValue(tbl1, arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    for _, value in tbl1 do
        if value == arg1 then
            return true
        end
    end
    return false
end

local function matches(arg1, arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 and arg2 then
        if typeof(arg2) == "table" then
            return hasValue(arg2, arg1)
        end

        return arg2 == arg1
    end

    return true
end

local function readValue(arg1, arg2, arg3, arg4, num1: number)
    local var1 = arg1[arg4]
    local num2 = if var1 == nil then -1 else num1
    Array.forEach(arg1, function(arg5)
        if not matches(arg2, arg5.breakpoint) or not matches(arg3, arg5.kind) then
            return
        end

        local var2, var3 = readValue(arg5, arg2, arg3, arg4, num1 + 1)
        if num2 < var3 then
            var1 = var2
            num2 = var3
        end
    end)

    local var2, num3 = var1, num2
    return var2, num3
end

local tbl1 = {
    name = "_default",
    min = math.huge,
    max = 0
}

local tbl2 = {}
tbl2[t.strictInterface({ Scale = t.number, Offset = t.number })] = function(arg1): UDim
    return UDim.new(arg1.Scale, arg1.Offset)
end

return {
    getValue = function(arg1, arg2)
        local config = arg1.config
        local breakpoint = arg1.breakpoint
        local kind = arg1.kind
        local var1 = config[arg2]
        local num1 = if var1 == nil then -1 else 0
        local num2 = 0

        Array.forEach(config, function(arg3)
            if not matches(breakpoint, arg3.breakpoint) or not matches(kind, arg3.kind) then
                return
            end

            local var2, num3 = readValue(arg3, breakpoint, kind, arg2, num2 + 1)
            if num1 < num3 then
                var1 = var2
                num1 = num3
            end
        end)

        local var2 = var1

        for value, value2 in tbl2 do
            if value(var2) then
                return value2(var2)
            end
        end
        return var2
    end,
    findBreakpoint = function(tbl3, arg1)
        local var1 = Array.find(tbl3, function(arg2): boolean
            return type(arg2) == "table"
                and type(arg2.breakpoint) == "string"
                and arg1 <= (arg2.max or math.huge)
                and arg1 >= (arg2.min or 0)
        end)

        if not var1 then
            return tbl1
        end

        return {
            name = var1.breakpoint,
            min = var1.min or 0,
            max = var1.max or math.huge
        }
    end
}
