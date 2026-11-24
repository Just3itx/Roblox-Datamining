-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local mergeDeep = require(script.Parent.mergeDeep)

local function mergeResolvers(arg1, tbl1)
    if not arg1 or Array.isArray(arg1) and #arg1 == 0 then
        return {}
    end

    if not Array.isArray(arg1) then
        return arg1
    end

    if #arg1 == 1 then
        return arg1[1] or {}
    end
    local tbl2 = {}

    for _, value in arg1 do
        if Array.isArray(value) then
            value = mergeResolvers(value)
        end
        if type(value) == "table" and value then
            table.insert(tbl2, value)
        end
    end
    local var1 = mergeDeep(tbl2, true)
    if tbl1 and tbl1.exclusions then
        for _, exclusion in tbl1.exclusions do
            local var2, var3 = table.unpack(exclusion:split("."), 1, 2)
            if not var3 or var3 == "*" then
                var1[tostring(var2)] = nil
            elseif Boolean.toJSBoolean(var1[tostring(var2)]) then
                var1[tostring(var2)][tostring(var3)] = nil
            end
        end
    end
    return var1
end

return mergeResolvers
