-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new(...)
    local var1 = (setmetatable({}, module))
    var1.data = {}

    local tbl1 = { ... }
    if #tbl1 == 1 and typeof(tbl1[1]) == "table" then
        if getmetatable(tbl1[1]) == module then
            tbl1 = tbl1[1].data
        else
            tbl1 = tbl1[1]
        end
    end

    for _, value in tbl1 do
        if typeof(value) ~= "number" then
            error("arg to FloatVector.new() not a number")
        else
            table.insert(var1.data, value)
        end
    end
    return var1
end

function module.getSize(arg1): number
    return #arg1.data
end

function module.checkCompatible(arg1, arg2)
    if typeof(arg1) ~= typeof(module) or typeof(arg2) ~= typeof(module) then
        error("vector operation on non-vector type")
        return false
    end

    if #arg1.data == #arg2.data then
        return true
    end

    error("operating on vectors of different dimension")
    return false
end

function module.__index(arg1, arg2)
    return if typeof(arg2) == "number" then arg1.data[arg2] else module[arg2]
end

function module.__newindex(arg1, arg2, arg3)
    if typeof(arg2) == "number" then
        arg1.data[arg2] = arg3
        return
    end

    rawset(arg1, arg2, arg3)
end

function module.__add(arg1, arg2)
    module.checkCompatible(arg1, arg2)
    local tbl1 = {}
    for i = 1, #arg1.data do
        table.insert(tbl1, arg1.data[i] + arg2.data[i])
    end
    return module.new(tbl1)
end

function module.__sub(arg1, arg2)
    module.checkCompatible(arg1, arg2)
    local tbl1 = {}
    for i = 1, #arg1.data do
        table.insert(tbl1, arg1.data[i] - arg2.data[i])
    end
    return module.new(tbl1)
end

function module.__mul(arg1, arg2)
    if typeof(arg1) == typeof(module) and typeof(arg2) == "number" then
        local tbl1 = {}
        for _, value in arg1.data do
            table.insert(tbl1, value * arg2)
        end
        return module.new(tbl1)
    end
    module.checkCompatible(arg1, arg2)
    local tbl1 = {}
    for i = 1, #arg1.data do
        table.insert(tbl1, arg1.data[i] * arg2.data[i])
    end
    return module.new(tbl1)
end

function module.__div(arg1, arg2)
    if typeof(arg1) == typeof(module) and typeof(arg2) == "number" then
        local tbl1 = {}
        for _, value in arg1.data do
            table.insert(tbl1, value / arg2)
        end
        return module.new(tbl1)
    end
    module.checkCompatible(arg1, arg2)
    local tbl1 = {}
    for i = 1, #arg1.data do
        table.insert(tbl1, arg1.data[i] / arg2.data[i])
    end
    return module.new(tbl1)
end

function module.dot(arg1, arg2)
    module.checkCompatible(arg1, arg2)
    local num1 = 0
    for i = 1, #arg1.data do
        num1 += arg1.data[i] * arg2.data[i]
    end
    return num1
end

function module.cross(arg1, arg2)
    module.checkCompatible(arg1, arg2)
    if #arg1.data == 3 and #arg2.data == 3 then
        return module.new(
            arg1.data[2] * arg2.data[3] - arg1.data[3] * arg2.data[2],
            arg1.data[3] * arg2.data[1] - arg1.data[1] * arg2.data[3],
            arg1.data[1] * arg2.data[2] - arg1.data[2] * arg2.data[1]
        )
    end

    error("cross product is only defined for two 3 dimensional vectors")
    return nil
end

function module.magnitude(arg1): number
    local num1 = 0
    for _, value in arg1.data do
        num1 += value ^ 2
    end
    return math.sqrt(num1)
end

function module.fuzzyEq(tbl1, arg1, num1: number)
    if not module.checkCompatible(tbl1, arg1) then
        return false
    end
    num1 = num1 or 0.00001
    for i = 1, #tbl1.data do
        local var1 = tbl1.data[i] - arg1.data[i]

        if num1 < math.abs(var1) then
            return false
        end
    end
    return true
end

return module
