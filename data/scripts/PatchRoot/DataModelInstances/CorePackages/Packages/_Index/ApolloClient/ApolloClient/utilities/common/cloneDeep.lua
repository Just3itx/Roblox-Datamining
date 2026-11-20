-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local module = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Map = LuauPolyfill.Map
local Object = require(scriptParentParentParent.luaUtils.Object)
local instanceof = LuauPolyfill.instanceof

local NULL = require(script.Parent.Parent.globals.null).NULL

local cloneDeepHelper = nil

function module.cloneDeep(arg1)
    return cloneDeepHelper(arg1)
end
local tbl1 = {
    LuauPolyfill.Error,
    LuauPolyfill.Map,
    LuauPolyfill.WeakMap,
    LuauPolyfill.Set
}

cloneDeepHelper = function(arg1, arg2)
    if Array.isArray(arg1) then
        local var1 = arg2 or Map.new(nil)
        if var1:has(arg1) then
            return var1:get(arg1)
        end
        local var2 = Array.slice(arg1, 1)
        var1:set(arg1, var2)
        Array.forEach(var2, function(arg3, arg4)
            var2[arg4] = cloneDeepHelper(arg3, var1)
        end)
        return var2
    end
    if typeof(arg1) ~= "table" or arg1 == NULL or not Array.every(tbl1, function(arg3): boolean
        return not instanceof(arg1, arg3)
    end) then
        return arg1
    end

    local var1 = arg2 or Map.new(nil)
    if var1:has(arg1) then
        return var1:get(arg1)
    end

    local var2 = Object.create(Object.getPrototypeOf(arg1))
    var1:set(arg1, var2)
    Array.forEach(Object.keys(arg1), function(arg3)
        var2[arg3] = cloneDeepHelper(arg1[arg3], var1)
    end)
    return var2
end

return module
