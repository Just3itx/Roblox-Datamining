-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:29Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local forEach = require(scriptParentParent.Array.forEach)
local map = require(scriptParentParent.Array.map)
local isArray = require(scriptParentParent.Array.isArray)
local InstanceOf = require(scriptParentParentParent.InstanceOf)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local module = ({})

function module.new(arg1)
    local var1 = nil
    local var2 = nil
    if arg1 == nil then
        var1 = {}
        var2 = {}
    elseif isArray(arg1) then
        if __DEV__ and #arg1 > 0 and typeof(arg1[1]) ~= "table" then
            error(
                "Value `" .. typeof(arg1[1]) .. "` is not an entry object.\n Cannot create Map from {K, V} form, it must be { {K, V}... }"
            )
        end

        var1 = table.create(#arg1)
        var2 = {}
        for _, value in arg1 do
            local var3 = value[1]
            if __DEV__ and var3 == nil then
                error("cannot create Map from a table that isn't an array.")
            end

            local var4 = value[2]

            if var2[var3] == nil then
                table.insert(var1, var3)
            end

            var2[var3] = var4
        end
    elseif InstanceOf(arg1, module) then
        var1 = table.clone(arg1._array)
        var2 = table.clone(arg1._map)
    else
        error(("`%s` `%s` is not iterable, cannot make Map using it"):format(typeof(arg1), tostring(arg1)))
    end

    return (setmetatable({ size = #var1, _map = var2, _array = var1 }, module))
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
    if __DEV__ and typeof(arg2) ~= "function" then
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
    if __DEV__ then
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

function module.__index(tbl1: {[string]: any}, arg1)
    local var1 = rawget(module, arg1)
    if var1 ~= nil then
        return var1
    end
    if __DEV__ then
        assert(
            rawget(tbl1, "_map"),
            "Map has been corrupted, and is missing private state! Did you accidentally call table.clear() instead of map:clear()?"
        )
    end

    return module.get(tbl1, arg1)
end

function module.__newindex(arg1, arg2, arg3)
    arg1:set(arg2, arg3)
end

return module
