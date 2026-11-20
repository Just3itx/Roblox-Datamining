-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local inspect = require(scriptParentParentParent.LuauPolyfill).util.inspect
local arrayContains = require(script.Parent.Parent.luaUtils.arrayContains)

local function toHaveSameMembers(arg1, arg2, arg3)
    if #arg1 ~= #arg2 then
        local tbl1 = { pass = false, message = 0 }

        local str1 = tostring(#arg1)
        local num1 = #arg2
        tbl1.message = ("Received array length %s / expected length %s"):format(str1, tostring(num1))
        return tbl1
    end

    for _, value in ipairs(arg2) do
        if not arrayContains(arg1, value, arg3) then
            return {
                pass = false,
                message = ("Expected item %s to be in Array %s"):format(inspect(value), inspect(arg1))
            }
        end
    end

    return { pass = true, message = "" }
end

return toHaveSameMembers
