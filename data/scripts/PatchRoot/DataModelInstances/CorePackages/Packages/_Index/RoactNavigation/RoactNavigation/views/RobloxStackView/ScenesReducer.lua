-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local TableUtilities = require(scriptParentParentParent.utils.TableUtilities)
local invariant = require(scriptParentParentParent.utils.invariant)

local function compareScenes(arg1, arg2): boolean
    if arg1.index ~= arg2.index then
        return arg1.index < arg2.index
    end

    local num1 = #arg1.key - #arg2.key

    if num1 == 0 then
        return arg1.key < arg2.key
    end

    return num1 < 0
end

local function routesAreShallowEqual(arg1, arg2) -- Luacid: unused: defined but never referenced
    if not (arg1 and arg2) then
        return arg1 == arg2
    elseif arg1.key ~= arg2.key then
        return false
    end

    return TableUtilities.ShallowEqual(arg1, arg2)
end

local function scenesAreShallowEqual(arg1, arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1

    if arg1.key == arg2.key and arg1.index == arg2.index and arg1.isStale == arg2.isStale and arg1.isActive == arg2.isActive then
        if not (arg1 and arg2) then
            return arg1 == arg2
        end

        if arg1.key ~= arg2.key then
            return false
        end

        var1 = TableUtilities.ShallowEqual(arg1, arg2)
    else
        var1 = false
    end

    return var1
end

return function(arg1, arg2, arg3, arg4)
    for _, value in arg1 do
        local route = value.route
        if arg4 and arg4[route.key] then
            value.descriptor = arg4[route.key]
        end
    end

    if arg3 == arg2 then
        return arg1
    end

    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})

    for _, value in arg1 do
        local key = value.key
        if value.isStale then
            tbl3[key] = value
        end

        tbl1[key] = value
    end

    local tbl4 = ({})
    local routes = arg2.routes
    if #routes > arg2.index then
        print("Warning: StackRouter provided invalid state. Index should always be the top route")
        routes = Array.slice(routes, 1, arg2.index)
    end

    for index, route in routes do
        local key = "scene_" .. route.key
        local descriptor = if arg4 then arg4[route.key] else nil
        local tbl5 = {
            index = index,
            isActive = false,
            isStale = false,
            key = key,
            route = route,
            descriptor = descriptor
        }

        invariant(not tbl4[key], "navigation.state.routes[%d].key '%s' conflicts with another route!", index, key)
        tbl4[key] = true

        if tbl3[key] then
            tbl3[key] = nil
        end

        tbl2[key] = tbl5
    end

    if arg3 then
        local routes2 = arg3.routes
        if #routes2 > arg3.index then
            print("StackRouter provided invalid state. Index should always be the top route.")
            routes2 = Array.slice(routes2, 1, arg3.index)
        end

        for index, route in routes2 do
            local key = "scene_" .. route.key

            if tbl2[key] then
                continue
            end

            local var2 = nil
            for _, value3 in arg1 do
                if value3.route.key == route.key then
                    var2 = value3
                    break
                end
            end

            local var3 = arg4[route.key]
            if var2 then
                var3 = var2.descriptor
            end

            if not var3 then
                continue
            end

            tbl3[key] = {
                index = index,
                isActive = false,
                isStale = true,
                key = key,
                route = route,
                descriptor = var3
            }
        end
    end

    local tbl5 = ({})

    local function mergeScene(arg5) -- Luacid: unused: defined but never referenced
        local key = arg5.key
        local var1 = tbl1[key] or nil

        if var1 and scenesAreShallowEqual(var1, arg5) then
            table.insert(tbl5, var1)
            return
        end
        table.insert(tbl5, arg5)
    end

    for _, value in tbl3 do
        local var1 = tbl1[value.key] or nil

        if var1 and scenesAreShallowEqual(var1, value) then
            table.insert(tbl5, var1)
        else
            table.insert(tbl5, value)
        end
    end

    for _, value in tbl2 do
        local var1 = tbl1[value.key] or nil

        if var1 and scenesAreShallowEqual(var1, value) then
            table.insert(tbl5, var1)
        else
            table.insert(tbl5, value)
        end
    end

    table.sort(tbl5, compareScenes)

    local num1 = 0
    for value, value2 in tbl5 do
        local isActive = not value2.isStale and value2.index == arg2.index
        if isActive ~= value2.isActive then
            tbl5[value] = Object.assign(table.clone(value2), { isActive = isActive })
        end

        if isActive then
            num1 += 1
        end
    end

    invariant(num1 == 1, "There should only be one active scene, not %d", num1)

    if #tbl5 ~= #arg1 then
        return tbl5
    end

    for value, value2 in tbl5 do
        if not scenesAreShallowEqual(arg1[value], value2) then
            return tbl5
        end
    end

    return arg1
end
