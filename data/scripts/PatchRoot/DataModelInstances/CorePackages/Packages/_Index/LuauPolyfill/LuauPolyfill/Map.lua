-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local forEach = require(scriptParent.Array.forEach)
local map = require(scriptParent.Array.map)
local _types = require(scriptParent.types)

local module = ({})

function module.new(arg1)
    local _map = ({})
    local var1

    if arg1 == nil then
        var1 = {}
    else
        if _G.__DEV__ then
            local str1 = typeof(arg1)
            if str1 ~= "table" then
                error(("cannot create array from value of type `%s`"):format(str1))
            elseif #arg1 > 0 and typeof(arg1[1]) ~= "table" then
                error("cannot create Map from {K, V} form, it must be { {K, V}... }")
            end
        end

        local var2 = table.clone(arg1)
        var1 = table.create(#var2)
        for _, value in var2 do
            local var3 = value[1]
            if _G.__DEV__ and var3 == nil then
                error("cannot create Map from a table that isn't an array.")
            end

            local var4 = value[2]

            if _map[var3] == nil then
                table.insert(var1, var3)
            end

            _map[var3] = var4
        end
    end

    return (setmetatable({ size = #var1, _map = _map, _array = var1 }, module))
end

function module.set(arg1, arg2, arg3)
    if arg1._map[arg2] == nil then
        arg1.size += 1
        table.insert(arg1._array, arg2)
    end

    arg1._map[arg2] = arg3
    return arg1
end

function module.get(arg1, arg2)
    return arg1._map[arg2]
end

function module.clear(arg1)
    local table2 = table
    arg1.size = 0
    table2.clear(arg1._map)
    table2.clear(arg1._array)
end

function module.delete(arg1, arg2): boolean
    if arg1._map[arg2] == nil then
        return false
    end

    arg1.size -= 1
    arg1._map[arg2] = nil
    local var1 = table.find(arg1._array, arg2)
    if var1 then
        table.remove(arg1._array, var1)
    end
    return true
end

function module.forEach(arg1, arg2, arg3)
    if _G.__DEV__ and typeof(arg2) ~= "function" then
        error("callback is not a function")
    end

    forEach(arg1._array, function(arg4)
        local var1 = arg1._map[arg4]

        if arg3 ~= nil then
            arg2(arg3, var1, arg4, arg1)
            return
        end
        arg2(var1, arg4, arg1)
    end)
end

function module.has(arg1, arg2): boolean
    return arg1._map[arg2] ~= nil
end

function module.keys(arg1)
    return arg1._array
end

function module.values(arg1)
    return map(arg1._array, function(arg2)
        return arg1._map[arg2]
    end)
end

function module.entries(arg1)
    return map(arg1._array, function<T>(arg2: T): {T}
        return { arg2, arg1._map[arg2] }
    end)
end

function module.ipairs(arg1)
    if _G.__DEV__ then
        warn(
            debug.traceback(
                "`for _,_ in myMap:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in myMap do` instead\n",
                2
            )
        )
    end
    return ipairs(arg1:entries())
end

function module.__iter(arg1)
    return next, arg1:entries()
end

function module.__index(arg1, arg2)
    local var1 = rawget(module, arg2)
    if var1 ~= nil then
        return var1
    end

    return module.get(arg1, arg2)
end

function module.__newindex(arg1, arg2, arg3)
    arg1:set(arg2, arg3)
end

return module
