-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local tbl1 = {}

local function replaceNil(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return if arg1 == nil then tbl1 else arg1
end

local function newWeakMap() -- Luacid: Inlined by compiler; 3 call sites recovered
    return (setmetatable({}, { __mode = "kv" }))
end

return {
    memoize3 = function(func1: (...any) -> (...any))
        local var1 = nil

        return function(arg1, arg2, arg3)
            local var2 = replaceNil(arg1)
            local var3 = replaceNil(arg2)
            local var4 = replaceNil(arg3)
            var1 = var1 or newWeakMap()

            local var5 = var1[var2]
            local var6 = nil

            if var5 then
                var6 = var5[var3]

                if var6 then
                    local var7 = var6[var4]

                    if var7 ~= nil then
                        return if var7 == tbl1 then nil else var7
                    end
                end
            else
                var5 = newWeakMap()

                var1[var2] = var5
            end
            if not var6 then
                var6 = newWeakMap()

                var5[var3] = var6
            end

            local var7 = func1(arg1, arg2, arg3)

            var6[var4] = replaceNil(var7)

            return var7
        end
    end
}
