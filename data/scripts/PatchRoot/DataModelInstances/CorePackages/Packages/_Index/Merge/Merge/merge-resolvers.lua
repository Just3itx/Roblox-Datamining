-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local String = LuauPolyfill.String

local tbl1 = {}

local mergeDeep = require(scriptParentParent.Utils).mergeDeep

local function mergeResolvers(arg1, tbl2)
    if not Boolean.toJSBoolean(arg1) or Array.isArray(arg1) and #arg1 == 0 then
        return {}
    end
    if not Boolean.toJSBoolean(Array.isArray(arg1)) then
        return arg1
    end

    if #arg1 == 1 then
        return if Boolean.toJSBoolean(arg1[1]) then arg1[1] else {}
    end

    local tbl3 = {}

    for _, value in arg1 do
        if Boolean.toJSBoolean(Array.isArray(value)) then
            value = mergeResolvers(value)
        end

        local toJsBoolean = Boolean.toJSBoolean

        if toJsBoolean(typeof(value) == "table" and value) then
            table.insert(tbl3, value)
        end
    end

    local var1 = mergeDeep(tbl3, true)

    local toJsBoolean = Boolean.toJSBoolean

    if toJsBoolean(if typeof(tbl2) == "table" then tbl2.exclusions else nil) then
        for _, exclusion in tbl2.exclusions do
            local var2, var3 = table.unpack(String.split(exclusion, "."), 1, 2)

            if not Boolean.toJSBoolean(var3) or var3 == "*" then
                var1[var2] = nil
            elseif Boolean.toJSBoolean(var1[var2]) then
                var1[var2][var3] = nil
            end
        end
    end

    return var1
end
tbl1.mergeResolvers = mergeResolvers

return tbl1
