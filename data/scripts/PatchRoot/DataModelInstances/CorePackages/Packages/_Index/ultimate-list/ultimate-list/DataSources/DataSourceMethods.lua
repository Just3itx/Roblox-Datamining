-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _Parent = require(script.Parent)
local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)

local module = {}

function module.get(arg1, num1: number)
    assert(num1 >= 1, "index < 1")

    if arg1.type == "array" then
        local function get2(num2: number): {after: () -> any, before: () -> any, value: any}?
            return if num2 < 1 or #arg1.array < num2 then nil else {
                before = function()
                    return get2(num2 - 1)
                end,
                value = arg1.array[num2],
                after = function()
                    return get2(num2 + 1)
                end
            }
        end

        return (get2(num1))
    elseif arg1.type == "mutableSource" then
        return arg1.methods.get(num1)
    else
        return exhaustiveMatch(arg1.type)
    end
end

function module.getByRange(arg1, vec1: vector)
    if arg1.type == "array" then
        return table.move(arg1.array, vec1.X, vec1.Y, 1, {})
    end

    if arg1.type ~= "mutableSource" then
        return exhaustiveMatch(arg1.type)
    end

    if arg1.methods.getByRange ~= nil then
        return arg1.methods.getByRange(vec1.X, vec1.Y)
    end

    local byRange = {}

    local var1 = arg1.methods.get(vec1.X)
    for _ = 0, vec1.Y - vec1.X do
        if var1 == nil then
            break
        end

        table.insert(byRange, var1.value)
        var1 = var1.after()
    end

    return byRange
end

function module.back(arg1)
    if arg1.type == "array" then
        return arg1.array[#arg1.array]
    end

    if arg1.type ~= "mutableSource" then
        return exhaustiveMatch(arg1.type)
    end

    if arg1.methods.back ~= nil then
        return arg1.methods.back()
    end

    local var1 = arg1.methods.get(arg1.methods.length())
    return var1 and var1.value
end

function module.length(arg1)
    if arg1.type == "array" then
        return #arg1.array
    elseif arg1.type == "mutableSource" then
        return arg1.methods.length()
    end
    return exhaustiveMatch(arg1.type)
end

function module.equals(arg1, arg2)
    if arg1.type ~= arg2.type then
        return false
    end

    if arg1.type == "array" then
        assert(arg2.type == "array", "Luau")
        return arg1.array == arg2.array
    end

    if arg1.type ~= "mutableSource" then
        return exhaustiveMatch(arg1.type)
    end

    assert(arg2.type == "mutableSource", "Luau")
    return arg1.methods == arg2.methods
end

return module
