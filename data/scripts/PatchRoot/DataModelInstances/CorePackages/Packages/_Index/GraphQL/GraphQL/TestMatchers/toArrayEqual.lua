-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local deepEqual = require(script.Parent.Parent.luaUtils.deepEqual)
local deepContains = require(script.Parent.Parent.luaUtils.deepContains)

local function toArrayEqual(arg1, arg2, arg3)
    if #arg1 ~= #arg2 then
        local tbl1 = { pass = false, message = 0 }

        local str1 = tostring(#arg1)
        local num1 = #arg2
        tbl1.message = ("Expected array length %s / got length %s"):format(str1, tostring(num1))
        return tbl1
    end

    for i = 1, #arg1 do
        local var1

        if arg3 then
            local var2
            var2, var1 = deepContains(arg1[i], arg2[i])
            if not var2 then
                return {
                    pass = false,
                    message = var1:gsub("{1}", ("{1}[%s]"):format(tostring(i))):gsub("{2}", ("{2}[%s]"):format(tostring(i)))
                }
            end
        else
            local var2
            var2, var1 = deepEqual(arg1[i], arg2[i])
            if not var2 then
                return {
                    pass = false,
                    message = var1:gsub("{1}", ("{1}[%s]"):format(tostring(i))):gsub("{2}", ("{2}[%s]"):format(tostring(i)))
                }
            end
        end
    end

    return { pass = true, message = "" }
end

return toArrayEqual
