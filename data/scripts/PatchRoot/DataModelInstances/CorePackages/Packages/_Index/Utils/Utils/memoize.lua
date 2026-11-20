-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local WeakMap = LuauPolyfill.WeakMap

local module = {}

function module.memoize1(arg1)
    local weakMap = WeakMap.new()

    return function(arg2)
        local var1 = weakMap:get(arg2)
        if var1 ~= nil then
            return var1
        end

        local var2 = arg1(arg2)

        weakMap:set(arg2, var2)
        return var2
    end
end

function module.memoize2(arg1)
    local weakMap = WeakMap.new()

    return function(arg2, arg3)
        local var1 = weakMap:get(arg2)
        if not Boolean.toJSBoolean(var1) then
            local weakMap2 = WeakMap.new()
            weakMap:set(arg2, weakMap2)

            local var2 = arg1(arg2, arg3)

            weakMap2:set(arg3, var2)
            return var2
        end
        local var2 = var1:get(arg3)
        if var2 ~= nil then
            return var2
        end

        local var3 = arg1(arg2, arg3)

        var1:set(arg3, var3)
        return var3
    end
end

function module.memoize3(arg1)
    local weakMap = WeakMap.new()

    return function(arg2, arg3, arg4)
        local var1 = weakMap:get(arg2)
        if not Boolean.toJSBoolean(var1) then
            local weakMap2 = WeakMap.new()
            weakMap:set(arg2, weakMap2)
            local weakMap3 = WeakMap.new()
            weakMap2:set(arg3, weakMap3)

            local var2 = arg1(arg2, arg3, arg4)

            weakMap3:set(arg4, var2)
            return var2
        end
        local var2 = var1:get(arg3)
        if not Boolean.toJSBoolean(var2) then
            local weakMap2 = WeakMap.new()
            var1:set(arg3, weakMap2)

            local var3 = arg1(arg2, arg3, arg4)

            weakMap2:set(arg4, var3)
            return var3
        end
        local var3 = var2:get(arg4)
        if var3 ~= nil then
            return var3
        end

        local var4 = arg1(arg2, arg3, arg4)

        var2:set(arg4, var4)
        return var4
    end
end

function module.memoize4(arg1)
    local weakMap = WeakMap.new()

    return function(arg2, arg3, arg4, arg5)
        local var1 = weakMap:get(arg2)
        if not Boolean.toJSBoolean(var1) then
            local weakMap2 = WeakMap.new()
            weakMap:set(arg2, weakMap2)
            local weakMap3 = WeakMap.new()
            weakMap2:set(arg3, weakMap3)
            local weakMap4 = WeakMap.new()
            weakMap3:set(arg4, weakMap4)

            local var2 = arg1(arg2, arg3, arg4, arg5)

            weakMap4:set(arg5, var2)
            return var2
        end
        local var2 = var1:get(arg3)
        if not Boolean.toJSBoolean(var2) then
            local weakMap2 = WeakMap.new()
            var1:set(arg3, weakMap2)
            local weakMap3 = WeakMap.new()
            weakMap2:set(arg4, weakMap3)

            local var3 = arg1(arg2, arg3, arg4, arg5)

            weakMap3:set(arg5, var3)
            return var3
        end
        local var3 = var2:get(arg4)
        if not Boolean.toJSBoolean(var3) then
            local weakMap2 = WeakMap.new()

            var2:set(arg4, weakMap2)

            local var4 = arg1(arg2, arg3, arg4, arg5)

            weakMap2:set(arg5, var4)
            return var4
        end
        local var4 = var3:get(arg5)
        if var4 ~= nil then
            return var4
        end

        local var5 = arg1(arg2, arg3, arg4, arg5)

        var3:set(arg5, var5)
        return var5
    end
end

function module.memoize5(arg1)
    local weakMap = WeakMap.new()

    return function(arg2, arg3, arg4, arg5, arg6)
        local var1 = weakMap:get(arg2)
        if not Boolean.toJSBoolean(var1) then
            local weakMap2 = WeakMap.new()
            weakMap:set(arg2, weakMap2)
            local weakMap3 = WeakMap.new()
            weakMap2:set(arg3, weakMap3)
            local weakMap4 = WeakMap.new()
            weakMap3:set(arg4, weakMap4)
            local weakMap5 = WeakMap.new()
            weakMap4:set(arg5, weakMap5)

            local var2 = arg1(arg2, arg3, arg4, arg5, arg6)

            weakMap5:set(arg6, var2)
            return var2
        end
        local var2 = var1:get(arg3)
        if not Boolean.toJSBoolean(var2) then
            local weakMap2 = WeakMap.new()
            var1:set(arg3, weakMap2)
            local weakMap3 = WeakMap.new()
            weakMap2:set(arg4, weakMap3)
            local weakMap4 = WeakMap.new()
            weakMap3:set(arg5, weakMap4)

            local var3 = arg1(arg2, arg3, arg4, arg5, arg6)

            weakMap4:set(arg6, var3)
            return var3
        end
        local var3 = var2:get(arg4)
        if not Boolean.toJSBoolean(var3) then
            local weakMap2 = WeakMap.new()
            var2:set(arg4, weakMap2)
            local weakMap3 = WeakMap.new()
            weakMap2:set(arg5, weakMap3)

            local var4 = arg1(arg2, arg3, arg4, arg5, arg6)

            weakMap3:set(arg6, var4)
            return var4
        end
        local var4 = var3:get(arg5)
        if not Boolean.toJSBoolean(var4) then
            local weakMap2 = WeakMap.new()
            var3:set(arg5, weakMap2)

            local var5 = arg1(arg2, arg3, arg4, arg5, arg6)

            weakMap2:set(arg6, var5)
            return var5
        end
        local var5 = var4:get(arg6)
        if var5 ~= nil then
            return var5
        end

        local var6 = arg1(arg2, arg3, arg4, arg5, arg6)

        var4:set(arg6, var6)
        return var6
    end
end

local weakMap = WeakMap.new()
function module.memoize2of4(arg1)
    return function(arg2, arg3, arg4, arg5)
        local var1 = weakMap:get(arg2)
        if not Boolean.toJSBoolean(var1) then
            local weakMap2 = WeakMap.new()
            weakMap:set(arg2, weakMap2)

            local var2 = arg1(arg2, arg3, arg4, arg5)

            weakMap2:set(arg3, var2)
            return var2
        end
        local var2 = var1:get(arg3)
        if var2 ~= nil then
            return var2
        end

        local var3 = arg1(arg2, arg3, arg4, arg5)

        var1:set(arg3, var3)
        return var3
    end
end

return module
