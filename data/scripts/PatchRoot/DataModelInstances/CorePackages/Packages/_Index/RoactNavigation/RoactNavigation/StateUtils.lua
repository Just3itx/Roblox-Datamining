-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local module = {}

function module.get(arg1, key)
    for _, value in arg1.routes do
        if value.key == key then
            return value
        end
    end

    return nil
end

function module.indexOf(arg1, key)
    for value, value2 in arg1.routes do
        if value2.key == key then
            return value
        end
    end

    return nil
end

function module.has(arg1, key)
    for _, value in arg1.routes do
        if value.key == key then
            return true
        end
    end

    return false
end

function module.push(arg1, arg2)
    local bool1 = module.indexOf(arg1, arg2.key) == nil
    local key = arg2.key
    assert(bool1, ("should not push route with duplicated key %s"):format(key))

    local routes = Array.concat(arg1.routes, { arg2 })
    return Object.assign(table.clone(arg1), { index = #routes, routes = routes })
end

function module.pop(arg1)
    if arg1.index <= 1 then
        return arg1
    end

    local routes = table.clone(arg1.routes)
    table.remove(routes, #routes)
    return Object.assign(table.clone(arg1), { index = #routes, routes = routes })
end

function module.jumpToIndex(arg1, index)
    if index == arg1.index then
        return arg1
    end

    assert(arg1.routes[index] ~= nil, ("invalid index %d to jump to"):format(index))

    return Object.assign(table.clone(arg1), { index = index })
end

function module.jumpTo(arg1, key)
    local var1 = module.indexOf(arg1, key)
    assert(var1 ~= nil, ("attempt to jump to unknown key \"%s\""):format(key))

    return module.jumpToIndex(arg1, var1)
end

function module.back(arg1)
    local var1 = arg1.index - 1
    if not arg1.routes[var1] then
        return arg1
    end

    return module.jumpToIndex(arg1, var1)
end

function module.forward(arg1)
    local var1 = arg1.index + 1
    if not arg1.routes[var1] then
        return arg1
    end

    return module.jumpToIndex(arg1, var1)
end

function module.replaceAndPrune(arg1, key, arg2)
    local var1 = module.indexOf(arg1, key)
    local var2 = module.replaceAtIndex(arg1, var1, arg2)

    local assign = Object.assign
    local var3 = table.clone(var2)
    local tbl1 = {
        routes = { unpack(var2.routes, 1, var1) }
    }
    return assign(var3, tbl1)
end

function module.replaceAt(arg1, key, arg2, arg3)
    local var1 = module.indexOf(arg1, key)
    local index = if arg3 then arg1.index else var1
    local var3 = module.replaceAtIndex(arg1, var1, arg2)
    var3.index = index
    return var3
end

function module.replaceAtIndex(arg1, index, arg2)
    local bool1 = arg1.routes[index] ~= nil
    local key = arg2.key
    assert(bool1, ("invalid index %d for replacing route %s"):format(index, key))

    if arg1.routes[index] == arg2 and index == arg1.index then
        return arg1
    end

    local routes = table.clone(arg1.routes)
    routes[index] = arg2

    return Object.assign(table.clone(arg1), { index = index, routes = routes })
end

function module.reset(arg1, routes, arg2)
    assert(type(routes) == "table" and #routes > 0, "invalid routes to replace")

    local index = arg2 or #routes

    if #arg1.routes == #routes and arg1.index == index then
        local bool1 = true
        for i = 1, #routes do
            if arg1.routes[i] ~= routes[i] then
                bool1 = false
                break
            end
        end

        if bool1 then
            return arg1
        end
    end

    assert(routes[index] ~= nil, ("invalid index %d to reset"):format(index))

    return Object.assign(table.clone(arg1), { index = index, routes = routes })
end

return module
